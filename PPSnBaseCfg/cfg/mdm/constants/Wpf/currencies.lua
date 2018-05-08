local waehSource = createSource {
	Source = Data:WAEH,
	SortDescriptions = { "+Name" }
};


PushCurrenciesCommand = command(
    function (args) : void
		UpdateSources();
		if Data:IsDirty or Data:Object:IsDocumentChanged then
			await(PushDataAsync());
		else
			msgbox("Es gibt keine Änderungen.", "Information");
		end
    end
);