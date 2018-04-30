dbo = dbo or {};

dbo.Geschlecht = {
	
	{
	  Id = nil,
		Name = "unbekannt"	
	},
	{
		Id = cast(char, "m"),
		Name = "männlich"
	},
	{
		Id = cast(char, "w"),
		Name = "weiblich"
	}
	
};

-- ----------------------------------------------------------------------------
--

function FieldFactory:CreateObjkNr(context, properties)
	local txt = self:CreateTextField(
		self:CreateFieldInfo(
			context,
			"ObjkId.Nr",
			clr.System.String,
			properties.BindingPath or "ObjkId.Nr",
			{
				IsReadOnly = true,
				Width = 10
			}
		)
	);

	txt.IsTabStop = false;
	txt["PpsDataFieldPanel.Label"] = (properties.Label or "Nr") .. ":";

	return txt;
end;

function FieldFactory:SimpleTableSelector(context, properties, fieldInfo)
	local combo = self:CreateComboField(fieldInfo);

	combo.ItemsSource = UI.Binding {
		Path = properties.ItemsSource,
		Mode = "OneWay",
		Source = self:GetCode(context)
	};
	combo.SelectedValuePath = properties.SelectedValuePath or "Id"
	combo.DisplayMemberPath = properties.DisplayMemberPath or "Name";

	return combo;
end;