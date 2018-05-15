
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
				local row = def.View:Add { Name = "Neuer Eintrag", IsActive = true };
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
			do (trans = UndoManager:BeginTransaction("Lösche " .. def.Name))
				def.View:CurrentItem:Remove();
				trans:Commit();
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
			await(PushDataAsync());
		else
			msgbox("Es gibt keine Änderungen.", "Information");
		end
    end
);