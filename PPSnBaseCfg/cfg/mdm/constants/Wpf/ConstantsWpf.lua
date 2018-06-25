
local function GetCurrentDefinition(target) : object
	local grid = GetVisualParent(target, "TemplateGrid", true);
	if grid.DataContext then
		return grid.DataContext;
	else
		return nil;
	end;
end;

AddCommand = command(
	function (args) : void
		local def = GetCurrentDefinition(args:Target);
		if def then
			do (trans = UndoManager:BeginTransaction("Neu " .. def.Name))
				local row = def.View:Add { IsActive = true };
				def.View:CommitNew();
				trans:Commit();
				def.View:MoveCurrentTo(row);
			end;
		end;
	end,
	function (args) : bool
		return GetCurrentDefinition(args:Target);
	end
);

DeleteCommand = command(
	function (args) : void
		local def = GetCurrentDefinition(args:Target);
		if def and def.View:CurrentItem then
			local item = def.View:CurrentItem;
			if item.Id > 0 then
				msgbox("Der Datensatz wurde schon übertragen und kann nicht mehr gelöscht werden.");
			else
				do (trans = UndoManager:BeginTransaction("Lösche " .. item.Name))
					item:Remove();
					trans:Commit();
				end;
			end;
		end;
	end,
	function (args) : bool
		return GetCurrentDefinition(args:Target);;
	end
);

PushCommand = command(
    function (args) : void
		UpdateSources();
		if Data:IsDirty or Data:Object:IsDocumentChanged then
			do (ui = disableUI("Veröffentlichung läuft..."))
				await(PushDataAsync());
			end;
		else
			msgbox("Es gibt keine Änderungen.", "Information");
		end
    end
);