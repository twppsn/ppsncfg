
-- Global Properties --

--[===[


--ViewAdre = getView(Data:Head:First:AdreHead);

--[[
pushContact = command(
    function (args) : void
    	do (trans = UndoManager:BeginTransaction('Neue Adresse'))
    		
    		local ansp = getView(tvw:SelectedItem.AnspAdre);
    		local newRow = ansp:Add { Name = "Test4" };
			
			local tviParent = tvw:ItemContainerGenerator:ContainerFromItem(tvw:SelectedItem);
			tviParent.IsExpanded = true;
			
			local tviNew = tviParent:ItemContainerGenerator:ContainerFromItem(newRow);
			if tviNew ~= nil then
				tviNew.IsExpanded = true;
				tviNew.IsSelected = true;
			else
				msgbox("tvi is null");
			end;			

            trans:Commit();
        end;
        
        -- PushDataAsync();
    end
);
		
pushContact = command(
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

newAddress = command(
    function (args) : void
	    do (trans = UndoManager:BeginTransaction("Neue Adresse"))
			local viewAdre = getView(Data:Head:First:AdreHead);
			viewAdre:Add({ Name = "Neue Adresse"});
			
 			trans:Commit();
		end;
    end
);

newPartner = command(
    function (args) : void
        local cur = AdreTreeView.SelectedValue;
        if cur ~= nil then
            do (trans = UndoManager:BeginTransaction("Neuer Partner"))
                if cur:Table:TableName == "Adre" then
                    local viewAdre = getView(cur:AnspAdre);
                    viewAdre:Add({ Name = "Neuer Partner"});
                else
                    cur:Table:Add({AdreId = cur:AdreId, Name = "Neuer Partner"});
                end;
                trans:Commit();
            end;
		end;
	end
);
				
delItem = command(
    function (args) : void
  		local cur = AdreTreeView:SelectedValue;
        if cur ~= nil then
			do (trans = UndoManager:BeginTransaction("Löschen"))
 			    cur:Remove({"Löschen " .. (cur.Name)});
				trans:Commit();
			end;
		end;
    end
);

templateSelectorAdr = templateSelector(
    function (item, container) : object
    	if item == nil then
    		return nil;
		end;

		local resName = item:Table:TableName;
    	return GetResource(resName);
    end
);

testCommand = command(
    function (args) : void
  		msgbox("Test");
    end
);]]

-- todo: Deaktivieren auf Toolbar

-- UI Creation --
do
	local scope =  UI.Scope(Data);

	local ctrl = UI.SideBar() {
		UI.SideBarPanelFilter {
			Header = "Kopfdaten"
		},

		Content = UI.StackSection {
			UI.StackSectionItem {
				Header = "Kopfdaten",

				Content = UI.DataFields(Data.Head) {
					ColumnCount = 2,
					LabelWidth = 200.0,
	
					UI.DataField("Name") {},
					UI.DataField("KurzName") {},
					UI.DataField("WaehId") {}

					-- Auswahl: Lieferant, Kunde, Spedition, Personal

					--UI.DataFieldAddress() {}
					--UI.DataFieldCoord("KoordL", "KoordB") {}
				}
			},
			UI.StackSectionItem {
				Header = "Indentifizierung",

				Content = UI.DataFields(Data.Head) {
					ColumnCount = 2,
					LabelWidth = 200.0,
				
					UI.DataField("StIdentNr") {},
					UI.DataField("SteuerNr") {},
					UI.DataField("UstIdNr") {},

					UI.DataField("Iban") {},
					UI.DataField("Bic") {}
				}
			},
			UI.StackSectionItem {
				Header = "Lieferung",

				Content = UI.DataFields(Data.Lief) {
					ColumnCount = 2,
					LabelWidth = 200.0,
				
					UI.DataField("KundNr") {},
					UI.DataField("Abc") {}
					--UI.DataField("RAdresse") {}

					-- todo: ZaziId, VartId, PstgId
				}
			},
			UI.StackSectionItem {
				Header = "Versand",

				Content = UI.DataFields(Data.Kund) {
					ColumnCount = 2,
					LabelWidth = 200.0,
				
					UI.DataField("LiefNr") {},
					UI.DataField("Abc") {}
					--UI.DataField("VAdresse") {}

					-- todo: ZaziId, VartId, PstgId
				}
			},
			UI.StackSectionItem {
				Header = "Personal",

				Content = UI.DataFields(Data.Pers) {
					ColumnCount = 2,
					LabelWidth = 200.0,
				
					UI.DataField("Geburt") {},
					UI.DataField("Seit") {},
					UI.DataField("Bis") {},
					UI.DataField("Rfid") {},
					UI.DataField("VersNr") {},
					UI.DataField("FamStand") {},
					UI.DataField("Stkl") {},
					UI.DataField("Kasse") {},
					UI.DataField("KindFrei") {},
					UI.DataField("Staat") {}
				}
			}
		},

		UI.SideBarGroup {
			Header = "Visitenkarten",
			
			ItemsSource = UI.Binding("Vika"),
			ItemTemplate = UI:CreateDataTemplate(UI.SideBarPanel {
				Header = UI.Binding("Name"),
				Content = UI.DataFields(Data.Vika) {

					UI.DataField("Name") {},
					UI.DataField("Vorname") {},
					UI.DataField("Titel") {},
					UI.DataField("Tel") {},
					UI.DataField("Fax") {},
					UI.DataField("Mail") {},
					UI.DataField("Mobil") {},
					UI.DataField("Std") {},
					UI.DataField("Geschl") {},
					UI.DataField("Funktion") {},
					UI.DataField("Brief") {},
					UI.DataField("Postfach") {},
					UI.DataField("Zusatz") {},
					UI.DataField("Strasse") {},
					UI.DataField("Ort") {},
					UI.DataField("Region") {},
					UI.DataField("Plz") {},
					UI.DataField("Adresse") {},
					UI.DataField("PictureId") {}
				}
			}),
			Content = UI.ListBox {  -- todo: suche
				ItemsSource = UI.Binding("Vika"),
				Width = 200,
				Height = 200
			}
		}
	};
	
	scope(); -- finish scope

	setControl {
		Title = UI.Binding("Title"),
		SubTitle = "Kontakt",
		ctrl
	}
end;

--[[
<pps:column name="WaehId" fieldName="dbo.Ktkt.WaehId" />

<pps:column name="LandId" fieldName="dbo.Ktkt.LandId" />
<pps:column name="Postfach" fieldName="dbo.Ktkt.Postfach" />
<pps:column name="Zusatz" fieldName="dbo.Ktkt.Zusatz" />
<pps:column name="Strasse" fieldName="dbo.Ktkt.Strasse" />
<pps:column name="Ort" fieldName="dbo.Ktkt.Ort" />
<pps:column name="Region" fieldName="dbo.Ktkt.Region" />
<pps:column name="Plz" fieldName="dbo.Ktkt.Plz" />
<pps:column name="Adresse" fieldName="dbo.Ktkt.Adresse" />
				
<pps:column name="KoordL" fieldName="dbo.Ktkt.KoordL" />
<pps:column name="KoordB" fieldName="dbo.Ktkt.KoordB" />

]===]