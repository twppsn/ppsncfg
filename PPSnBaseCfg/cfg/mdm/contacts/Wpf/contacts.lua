
-- Global Properties --
PushCommand = command(
	function (args) : void
		UpdateSources();
		-- Pflichtfelder Ktkt
		if HeadRow:Name == nil or (HeadRow:Name:gsub("^%s*", "")) == ''  then
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

function SelectVikaItem(sender, e) : void
	SelectVika(e.Parameter);
end;

local function createViews()
	HeadRow = Data:Head:First;

	VikaSource = createSource {
		Source = HeadRow:VikaHead,
		SortDescriptions = { "+Name" }
	};
	VikaView = VikaSource:View;

	VikaListSource = createSource {
		Source = HeadRow:VikaHead,
		SortDescriptions = { "+Name" }
	};
	VikaListView = VikaListSource:View;

	SelectVika(nil);
end;

function OnDataChanged() : void
	createViews();
end;

VikaNewCommand = command(
	function (args) : void
		local row;
		do (trans = UndoManager:BeginTransaction("Neue Visitenkarte"))
			row = HeadRow:VikaHead:Add{};
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
