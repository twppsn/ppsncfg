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
		View = landSource:View
	},
	{
		Name = "Währungen",
		Template = "WaehTemplate",
		View = waehSource:View
	}
};

InterConstants = rawarray(interConstants);
