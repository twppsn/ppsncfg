
pushContract = command(
    function (args) : void
        UpdateSources();
		if Data:IsDirty or Data:Object:IsDocumentChanged then
			await(PushDataAsync());
		else
			msgbox(text = "Es gibt keine Änderungen.", caption = "Information", image = clr.System.Windows.MessageBoxImage.Information);
		end
    end
);

newPosition = command(
    function (args) : void
	    do (trans = UndoManager:BeginTransaction("Neue Position"))
			local viewAnpo = getView(Data:Head:First:AnpoHead);
			viewAnpo:Add({ Text = "Neue Position"});
 			trans:Commit();
		end;
    end
);

