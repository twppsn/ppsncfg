
-- Global Properties --
VikaView = getView(Data:Head:First:VikaHead);

local vikaSource = createSource {
	Source = Data:Head:First:VikaHead,
	SortDescriptions = { "+Name" }
};

VikaListView  = vikaSource:View;
	
PushCommand = command(
	function (args) : void
		UpdateSources();
		-- Pflichtfelder Ktkt
		if Data:Head:First:Name == nil or (Data:Head:First:Name:gsub("^%s*", "")) == ''  then
			msgbox("Das Feld 'Name' darf nicht leer sein.");
			return;
		end
		-- Pflichtfelder Vika
		foreach row in Data:Vika do
			if row.Name == nil then
				msgbox("Das Feld 'Name' in der Visitenkarte darf nicht leer sein.");
				return;
			end;
		end;
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
			row = VikaView:Add {};
 			trans:Commit();
		end;
		SelectVika(row);
	end
);

VikaRemoveCommand = command(
	function (args) : void
		do (trans = UndoManager:BeginTransaction("Visitenkarte löschen"))
			if VikaView:CurrentItem then
				VikaView:CurrentItem:Remove();
			elseif VikaListView:CurrentItem then
				VikaListView:CurrentItem:Remove();
			end;
			trans:Commit();
		end;
	end,
	function (args) : bool
		return VikaView:CurrentItem or VikaListView:CurrentItem;
	end
);
