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

if IsServer then
	return;
end;

-- ----------------------------------------------------------------------------
--

function FieldFactory:CreateObjkNr(properties)
	local txt = self:CreateTextField(
		properties[
			self:CreateFieldInfo(
				"Nr",
				clr.System.String,
				properties.BindingPath .. ".Nr",
				{
					IsReadOnly = true,
					TextWidth = 10
				}
			)
		]
	);

	txt.IsTabStop = false;
	txt[self:GridLabel] = (properties.displayName or "Nr") .. ":";

	return txt;
end;

function FieldFactory:CreateAddress(properties)

	local landField = self:GetFieldInfo(properties, properties.FieldLand or "LandId", false);
	local regionField = self:GetFieldInfo(properties, properties.FieldRegion or "Region", false);

	local strasseField = self:GetFieldInfo(properties, properties.FieldStrasse or "Strasse", false);
	local zusatzField = self:GetFieldInfo(properties, properties.FieldStrasse or "Zusatz", false);
	local postfachField = self:GetFieldInfo(properties, properties.FieldPostfach or "Postfach", false);
	local plzField = self:GetFieldInfo(properties, properties.FieldPlz or "Plz", false);
	local ortField = self:GetFieldInfo(properties, properties.FieldOrt or "Ort", false);

	--local addressField = properties:GetService("FieldInfo");
	local fields = {};

	-- Land line
	if landField and regionField then
		local landPoperties = properties[landField];
		local regionProperties = properties[regionField];

		table.insert(fields, UI.Grid {
			ColumnDefinitions = { "*", "*" },

			[self:GridLabel] = "{0}/{1}:":Format(landPoperties.displayName, regionProperties.displayName),

			self:CreateMasterDataField(landPoperties, landPoperties.refTable) {
				Height = self:GetHeight(1),
				["Grid.Column"] = 0
			},
			self:CreateTextField(regionProperties) {
				Margin = "6,0,0,0",
				Height = self:GetHeight(1),
				["Grid.Column"] = 1
			}
		});

	elseif regionField then -- only region
		local regionProperties = properties[regionField];
		
		table.insert(fields, 
			self:CreateTextField(regionProperties) { 
				[self:GridLabel] = regionProperties.displayName .. ":"
			}
		);
	end;

	-- Strasse
	if strasseField then
		local strasseProperties = properties[strasseField];
		table.insert(fields, 
			self:CreateTextField(strasseProperties) { 
				[self:GridLabel] = strasseProperties.displayName .. ":"
			}
		);
	end;

	-- Zusatz
	if zusatzField then
		local zusatzProperties = properties[zusatzField];
		table.insert(fields, 
			self:CreateTextField(zusatzProperties) { 
				[self:GridLabel] = zusatzProperties.displayName .. ":"
			}
		);
	end;

	-- Postfach
	if postfachField then
		local postfachProperties = properties[postfachField];
		table.insert(fields, 
			self:CreateTextField(postfachProperties) { 
				[self:GridLabel] = postfachProperties.displayName .. ":"
			}
		);
	end;

	-- Plz,Ort
	if plzField and ortField then
		local plzProperties = properties[plzField];
		local ortProperties = properties[ortField];

		table.insert(fields,
			UI.Grid {
				ColumnDefinitions = { "Auto", "*" },

				[self:GridLabel] = "{0}/{1}:":Format(plzProperties.displayName, ortProperties.displayName),

				self:CreateTextField(plzProperties) {
					Height = self:GetHeight(1),
					Width = self:GetWidth(10),
					["Grid.Column"] = 0
				},
				self:CreateTextField(ortProperties) {
					Margin = "6,0,0,0",
					Height = self:GetHeight(1),
					["Grid.Column"] = 1
				},
			}
		);
	end;

	-- Addresse
	table.insert(fields,
		self:CreateTextField(properties, true) {
			[self:GridLabel] = properties.displayName .. ":",
			[self:GridLines] = 3
		}
	);

	return table.unpack(fields)
end;

function FieldFactory:SimpleTableSelector(properties)
	local combo = self:CreateComboField(properties);

	combo.ItemsSource = UI.Binding {
		Path = properties.ItemsSource,
		Mode = "OneWay",
		Source = self:GetCode(context)
	};
	combo.SelectedValuePath = properties.SelectedValuePath or "Id"
	combo.DisplayMemberPath = properties.DisplayMemberPath or "Name";

	return combo;
end;