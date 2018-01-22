const ContactType = 'crmContacts';

function GetContactData(obj, ds)

	local trans = Db.Main;
	do (t = ds:BeginData())

	-- Kopfdaten --
		ds:Head:AddRange(
			trans:ExecuteSingleResult{
				select = [[
					dbo.ObjK
						=dbo.Ktkt[Objk.Id = Ktkt.ObjkId]
				]],
				columnList = ds:Head,
				[1] = { Id = obj.Id, Typ = ContactType }
			}
		);

		if #ds:Head == 0 then
			error("Kontakt nicht gefunden '{1},{0}:{2}":Format(obj.Id, obj.Nr, obj.Guid));
		end;

		-- Kundendaten --
		ds:Kund:AddRange(
			trans:ExecuteSingleResult{
				select = [[
					dbo.Ktkt
						=dbo.Kund[Ktkt.Id = Kund.KtktId]
				]],
				columnList = ds:Kund,
				[1] = { ObjKId = obj.Id }
			}
		);

		-- Lieferantendaten --
		ds:Lief:AddRange(
			trans:ExecuteSingleResult{
				select = [[
					dbo.Ktkt
						=dbo.Lief[Ktkt.Id = Lief.KtktId]
				]],
				columnList = ds:Lief,
				[1] = { ObjKId = obj.Id }
			}
		);

		-- Personaldaten --
		ds:Pers:AddRange(
			trans:ExecuteSingleResult{
				select = [[
					dbo.Ktkt
						=dbo.Pers[Ktkt.Id = Pers.KtktId]
				]],
				columnList = ds:Pers,
				[1] = { ObjKId = obj.Id }
			}
		);

		-- Visitenkarte --
		ds:Vika:AddRange(
			trans:ExecuteSingleResult{
				select = [[
					dbo.Ktkt
						=dbo.Vika[Ktkt.Id = Vika.KtktId]
				]],
				columnList = ds:Vika,
				defaults = {},
				[1] = { ObjKId = obj.Id }
			}
		);

		ds:Commit();
	end;
end;

function mergeContactToSql(obj, data)

	trans = Db.Main;

	-- write ktkt table
	trans:ExecuteNoneResult {
		upsert ="dbo.Ktkt",
		rows = data:Head
	};

	-- write kund
	trans:ExecuteNoneResult {
		upsert ="dbo.Kund",
		rows = data:Kund
	};
	
	-- write lief
	trans:ExecuteNoneResult {
		upsert ="dbo.Lief",
		rows = data:Lief
	};

	-- write pers
	trans:ExecuteNoneResult {
		upsert ="dbo.Pers",
		rows = data:Pers
	};

	-- Default-Values can not be passed as argument.
	--   Q&D: set Vika.Std

	foreach row in data:Vika do
		if row.Std == nil then
			row.Std = false;
		end;
	end;

	-- write vika
	trans:ExecuteNoneResult {
		upsert ="dbo.Vika",
		rows = data:Vika
	};
end;

-- overwrite NextNumber
NextNumber = "K{6}";

-- auto merge data
OnAfterPush["sds.contacts"] = mergeContactToSql;

-- get Contact data
OnCreateRevision["sds.contacts"] = GetContactData;