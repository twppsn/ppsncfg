
-- Global Properties --
Title = "Einstellung";

-- UI Creation --
local ctrl = UI.Grid {
	RowDefinitions = { "*" },
	ColumnDefinitions = { "*" },
		
	UI.Label {
		Content = "Todo Währungseinstellungen"
	}
};


setControl {
	Title = UI.Binding("Title"),
	SubTitle = "Währungseinstellungen",
	ctrl
}
