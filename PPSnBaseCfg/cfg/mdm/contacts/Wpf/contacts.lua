
-- Global Properties --
VikaView = getView(Data:Head:First:VikaHead);
	
PushCommand = command(
	function (args) : void
		UpdateSources();
		if Data:Head:First:Name == nil or (Data:Head:First:Name:gsub("^%s*", "")) == ''  then
			msgbox("Das Feld Name darf nicht leer sein."  );
			return;
		end
		if Data:IsDirty or Data:Object:IsDocumentChanged then
			await(PushDataAsync());
		else
			msgbox("Es gibt keine Änderungen.", "Information");
		end
    end
);

local function SelectVika(row) : void
	VikaView:MoveCurrentTo(row);
end;
SelectVika(nil);

function SelectVikaItem(sender, e) : void
	SelectVika(e.Parameter);
end;

VikaNewCommand = command(
	function (args) : void
		local row;
		do (trans = UndoManager:BeginTransaction("Neue Visitenkarte"))
			row = VikaView:Add { Name = "Neuer Name" };
 			trans:Commit();
		end;
		SelectVika(row);
	end
);

VikaRemoveCommand = command(
	function (args) : void
		do (trans = UndoManager:BeginTransaction("Visitenkarte löschen"))
			VikaView:CurrentItem:Remove();
			trans:Commit();
		end;
	end
);
