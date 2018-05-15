self:require 'ConstantsWpf.lua';

local landSource = createSource {
	Source = Data:Land,
	SortDescriptions = { "+ISO3" }
};

local waehSource = createSource {
	Source = Data:Waeh,
	SortDescriptions = { "+Name" }
};

local interConstants = {
	{
		Name = "Länder",
		Template = "LandTemplate",
		Source = landSource,
		View = landSource:View
	},
	{
		Name = "Währungen",
		Template = "WaehTemplate",
		Source = waehSource,
		View = waehSource:View
	}
};

InterConstants = rawarray(interConstants);
