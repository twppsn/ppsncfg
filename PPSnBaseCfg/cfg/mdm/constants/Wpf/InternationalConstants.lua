self:require 'ConstantsWpf.lua';

local landSource = createSource {
	Source = Data:Land,
	SortDescriptions = { "+ISO3" }
};

local waehSource = createSource {
	Source = Data:WAEH,
	SortDescriptions = { "+Name" }
};

local interConstants = {
	{
		Name = "Länder",
		View = landSource:View
	},
	{
		Name = "Währungen",
		View = waehSource:View
	}
};

InterConstants = rawarray(interConstants);

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