const Path typeof System.IO.Path;
const Path typeof System.IO.Path;

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

local function getIndexBatch(db) : table
	local r = {};

	foreach row in (db:CreateSelector("dbo.IndexHealth")) do
		if row.AvgFrag >= 5.0 and row.AvgFrag < 30.0 then
			table.insert(r, { db = db, object = row.Schema .. "." .. row.ObjName, index = row.IdxName, frag = row.AvgFrag, type = "reorg", __metatable = indexExecuteMeta });
		elseif row.AvgFrag >= 30.0 then
			table.insert(r, { db = db, object = row.Schema .. "." .. row.ObjName, index = row.IdxName, frag = row.AvgFrag, type = "rebuild", __metatable = indexExecuteMeta });
		end;
	end;

	return r;
end; -- getIndexBatch

local function executeBackup(db)

	do (log = Log:CreateScope(stopTime = true))
	do
		local r = GetFirstRow(db:ExecuteSingleResult {
			--__notrans = true,
			sql = "select DB_NAME() as name"
		});
		
		local databaseName = r.name;
		local backupFile = BackupPath;

		log:WriteLine("Backup von {0} nach {1}":Format(databaseName, backupFile));

		assert(backupFile ~= nil, "Backup file missing.");
		backupFile = Path:Combine(backupFile, databaseName .. ".bak");

		-- Index rebuild/reorg
		log:WriteLine("Validate Indices...");
		for i,v in ipairs(getIndexBatch(db)) do
			v.execute(log);
		end;

		-- Execute Backup
		log:WriteLine("Starte Backup...");
		db:Commit();

		local cmd = db:Prepare {
			__notrans = true,
			sql = [==[
				BACKUP DATABASE []==] .. databaseName ..  [==[] 
					TO DISK = N']==] .. backupFile .. [==[' WITH NOFORMAT, INIT,  
					NAME = N'Vollständige Datenbank Sicherung', SKIP, NOREWIND, NOUNLOAD, STATS = 10, CHECKSUM
			]==]
		};
		cmd.Command.ExecuteNonQuery(); -- fixme: transaktion wird wieder gesetzt, dadurch kann kein Backup ausgeführt werden.

		r = GetFirstRow(db:ExecuteSingleResult {
			--__notrans = true,
			sql = [[select position from msdb..backupset where database_name=N']] .. databaseName .. [[' and backup_set_id = (select max(backup_set_id) from msdb..backupset where database_name = N']] .. databaseName .. [[')]]
		});

		if r == nil or r.position == nil then
			log:WriteLine("Sicherungsinformationen für die Datenbank wurden nicht gefunden.");
			log:SetType(2);
			return;
		end;

		db:Commit(); -- fixme

		log:WriteLine("Verify Backup...");
		cmd = db:Prepare {
			__notrans = true,
			sql = [==[
				RESTORE VERIFYONLY FROM  DISK = N']==] .. backupFile .. [==[' WITH  FILE = ]==] .. r.position .. [==[,  NOUNLOAD,  NOREWIND
			]==]
		};
		cmd.Command.ExecuteNonQuery(); -- fixme
	end(
		function (e)
			log:WriteException(e);
			rethrow;
		end
	)
	end;
end; -- executeBackup

System.BackupDatabases = System.BackupDatabases or {};
System.BackupDatabases["Main"] = true;

System.IndexBatch = getIndexBatch;
System.ExecuteBackup = function ()
	for k,v in mpairs(System.BackupDatabases) do
		if v then
			executeBackup(Db.GetDatabase(k));
		end;
	end;
end;