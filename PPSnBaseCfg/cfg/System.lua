const DateTime typeof System.DateTime;
const DayOfWeek typeof System.DayOfWeek;

const Path typeof System.IO.Path;
const Path typeof System.IO.Path;

const backupTimeout : int = 86400; -- 24h

System = System or {};

local indexExecuteMeta = {
	__index = function (t, k) : object
		if k == "execute" then
			return function (log)
				local cmd : string;
				local msg : string;

				if t.type == "reorg" then
					log:WriteLine("Reorg Index: {0} / {1} ({2:N3})":Format(t.object, t.index, t.frag));

					t.db:ExecuteNoneResult { sql = "ALTER INDEX {1} ON {0} REORGANIZE":Format(t.object, t.index) };
				elseif t.type == "rebuild" then
					log:WriteLine("Rebuild Index: {0} / {1} ({2:N3})":Format(t.object, t.index, t.frag));

					t.db:ExecuteNoneResult { sql = "ALTER INDEX {1} ON {0} REBUILD":Format(t.object, t.index) };
				end;
			end;
		end;
		return nil;
	end
};

local function getIndexBatch(db, databaseName, log) : table
	local r = {};

	-- check if view is created
	local viewDef = GetViewDefinition(db.DataSource.Name .. ".dbo.IndexHealth", false);
	if viewDef ~= nil then
		foreach row in (viewDef.SelectorToken:CreateSelector(db.Connection)) do
			if row.AvgFrag >= 5.0 and row.AvgFrag < 30.0 then
				table.insert(r, { db = db, object = row.Schema .. ".[" .. row.ObjName .. "]", index = "[" .. row.IdxName .. "]", frag = row.AvgFrag, type = "reorg", __metatable = indexExecuteMeta });
			elseif row.AvgFrag >= 30.0 then
				table.insert(r, { db = db, object = row.Schema .. ".[" .. row.ObjName .. "]", index = "[" .. row.IdxName .. "]", frag = row.AvgFrag, type = "rebuild", __metatable = indexExecuteMeta });
			end;
		end;
	elseif databaseName ~= "master" and databaseName ~= "msdb" then
		log:WriteLine("dbo.IndexHealth not registered!");
		log:SetType(1);
	end;

	return r;
end; -- getIndexBatch

local function executeBackup(db, checkDb, beforeActions, afterActions) : bool

	do (log = Log:GetScope(stopTime = true))
	do
		local r = GetFirstRow(db:ExecuteSingleResult {
			--__notrans = true,
			sql = "select DB_NAME() as name"
		});
		
		local databaseName = r.name;
		local backupPath = BackupPath;
		local backupFile = backupPath;

		log:WriteLine("Backup von {0} nach {1}":Format(databaseName, backupFile));

		assert(backupFile ~= nil, "Backup file missing.");
		backupFile = Path:Combine(backupFile, databaseName .. ".bak");

		-- Before trigger
		if beforeActions ~= nil and type(beforeActions) == "table" then
			for k,v in mpairs(beforeActions) do
				v(log, db, backupPath);
			end;
		end;

		-- Index rebuild/reorg
		log:WriteLine("Validate Indices...");
		for i,v in ipairs(getIndexBatch(db, databaseName, log)) do
			v.execute(log);
		end;

		-- get backup parameter
		local backupParameter = GetFirstRow(db.ExecuteSingleResult {
			--__notrans = true,
			sql = [==[
				SELECT TOP 1
						d.recovery_model_desc AS [DatabaseRecovery]
						, datediff(day, s.backup_finish_date, getdate()) AS [BackupAge]
						, s.recovery_model AS [BackupRecovery]
					FROM sys.databases d
						LEFT OUTER JOIN (
							msdb.dbo.backupset s
								INNER JOIN msdb.dbo.backupmediafamily m on (s.media_set_id = m.media_set_id AND m.device_type in (2, 5))
						)  ON (d.[name] = s.[database_name] AND s.[type] = 'D')
					WHERE d.[name] = @NAME
					ORDER BY backup_set_id DESC]==],
			{ NAME = databaseName }
		});

		db:Commit();
		
		do (_logScope = db.LogMessages(log))

			local nativeConnection = db.DbConnection;

			-- check for saturday night
			local now : DateTime = DateTime.Now;
			local doFull : bool = now.DayOfWeek == DayOfWeek.Saturday;
			
			-- backup is new, no full backup needed
			if doFull and backupParameter.BackupAge ~= nil and backupParameter.BackupAge == 0 then
				doFull = false;
			end;
			
			-- check for recovery model changes
			if databaseName == "master" then
				log:WriteLine("Start " .. backupParameter.DatabaseRecovery .. " backup (because it is master)...");
				doFull = true;
			elseif backupParameter.BackupRecovery == nil then
				log:WriteLine("Start " .. backupParameter.DatabaseRecovery .. " backup (because none exist)...");
				doFull = true;
			elseif backupParameter.DatabaseRecovery ~= backupParameter.BackupRecovery then
				log:WriteLine("Start " .. backupParameter.DatabaseRecovery .. " backup (recovery model was changed from " .. backupParameter.BackupRecovery .. ")...");
				doFull = true;
			elseif backupParameter.BackupAge > 7 then
				log:WriteLine("Start " .. backupParameter.DatabaseRecovery .. " backup (because full backup is " .. backupParameter.BackupAge .. " days old)...");
				doFull = true;
			elseif doFull then
				log:WriteLine("Start " .. backupParameter.DatabaseRecovery .. " backup (because it is saturday)...");
			else
				log:WriteLine("Start differential backup (" .. backupParameter.DatabaseRecovery .. ", " .. backupParameter.BackupAge .. " days)...");
			end;

			local isSimple = backupParameter.DatabaseRecovery == "SIMPLE";
			
			-- Check database
			if doFull and checkDb then
				log:WriteLine("Check database...");

				local flags : string = "no_infomsgs";

				if type(checkDb) == "string" and checkDb == "logical" then
					flags = "extended_logical_checks, " .. flags;
				end;
			
				do (checkCommand = nativeConnection:CreateCommand())
					checkCommand.CommandTimeout = backupTimeout;
					checkCommand.CommandText = [[DBCC CHECKDB (']] .. databaseName .. [[') with ]] .. flags;
					checkCommand:ExecuteNonQuery();
				end;
			end;

			if doFull then -- Do a complete backup

				do (backupCommand = nativeConnection:CreateCommand())

					nativeConnection:ChangeDatabase("msdb");
					backupCommand.CommandText = [[exec sp_delete_database_backuphistory ']] .. databaseName .. [[';]];
					backupCommand:ExecuteNonQuery();
					nativeConnection:ChangeDatabase(databaseName);

					backupCommand.CommandTimeout = backupTimeout;
					backupCommand.CommandText = [==[
						BACKUP DATABASE []==] .. databaseName ..  [==[] 
							TO DISK = N']==] .. backupFile .. [==['
							WITH NOFORMAT, INIT, NAME = N']==] .. "Vollständige Sicherung vom " .. now:ToString("G") .. [==[', SKIP, NOREWIND, NOUNLOAD, STATS = 10, CHECKSUM
					]==];
					backupCommand:ExecuteNonQuery();

					if not isSimple then
						backupCommand.CommandText = [==[
							BACKUP LOG []==] .. databaseName ..  [==[]
								TO DISK = N']==] .. backupFile .. [==['
								WITH NOINIT, NAME = N'Datenbank Log Sicherung'
						]==];
						backupCommand:ExecuteNonQuery();
					end;
				end;

			else -- Differential Sicherung

				do (backupCommand = nativeConnection:CreateCommand())
					backupCommand.CommandTimeout = backupTimeout;
					backupCommand.CommandText = [==[
						BACKUP DATABASE []==] .. databaseName ..  [==[] 
							TO DISK = N']==] .. backupFile .. [==['
							WITH DIFFERENTIAL, NOINIT, NAME = N']==] .. "Differential Sicherung vom " .. now:ToString("G") .. [==[', SKIP, NOREWIND, NOUNLOAD, STATS = 10, CHECKSUM
					]==];
					backupCommand:ExecuteNonQuery();

					if not isSimple then
						backupCommand.CommandText = [==[
							BACKUP LOG []==] .. databaseName ..  [==[]
								TO DISK = N']==] .. backupFile .. [==['
								WITH NOINIT, NAME = N'Datenbank Log Sicherung'
						]==];
						backupCommand:ExecuteNonQuery();
					end;
				end;

			end;

			r = GetFirstRow(db:ExecuteSingleResult {
				--__notrans = true,
				sql = [[
					SELECT TOP 1 s.position AS [position], f.file_size / 1024 AS [size]
						FROM msdb.dbo.backupset s
							INNER JOIN msdb.dbo.backupfile f ON (s.backup_set_id = f.backup_set_id)
						WHERE database_name = @NAME
						ORDER BY s.backup_set_id DESC]],
				{ NAME = databaseName }
			});

			if r == nil or r.position == nil then
				log:WriteLine("Backup information for the database missing.");
				log:SetType(2);
				return;
			end;

			db:Commit();

			log:WriteLine("Verify backup ({0:N0} KiB)...", r.size);
			
			do (restoreCommand = nativeConnection:CreateCommand())
				restoreCommand.CommandTimeout = backupTimeout;
				restoreCommand.CommandText = [==[
					RESTORE VERIFYONLY FROM  DISK = N']==] .. backupFile .. [==['
						WITH  FILE = ]==] .. r.position .. [==[, NOUNLOAD,  NOREWIND
				]==];
				restoreCommand:ExecuteNonQuery();
			end;
		end;

		-- after trigger
		if afterActions ~= nil and type(afterActions) == "table" then
			for k,v in mpairs(afterActions) do
				v(log, db, backupPath);
			end;
		end;

		return true;
	end(
		function (e)
			log:WriteException(e);
			return false;
		end
	)
	end;
end; -- executeBackup

System.BackupDatabases = System.BackupDatabases or {};
System.BackupDatabases.Main =  System.BackupDatabases.Main or {};
System.BackupDatabases.Main.CheckDb = "logical";

System.IndexBatch = getIndexBatch;
System.ExecuteBackup = function (name : string) : bool
	if name ~= nil then
		return executeBackup(Db.GetDatabase(name));
	else
		local failed : int = 0;
		for k,v in mpairs(System.BackupDatabases) do
			local args : table = nil;
			local tn : string = type(v);

			if tn == "boolean" then
				if v then
					args = { CheckDb = true };
				end;
			elseif tn == "table" then
				args = v;
			end;

			if args ~= nil then
				if not executeBackup(Db.GetDatabase(k), v.CheckDb or true, v.BeforeActions, v.AfterActions) then
					failed = failed + 1;
				end;
			end;
		end;
		return failed == 0;
	end;
end; -- ExecuteBackup
