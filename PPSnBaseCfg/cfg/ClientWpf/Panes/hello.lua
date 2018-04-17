		
data = { Name = "Test" };
        
clickCount = 1;
		
bindTitle = "Hello {0}":Format(Arguments.index);

local function waitTaskAsync(progressCreate)
	
	do (p = progressCreate())
		
		for i = 1, 10, 1 do
			p.Text = "Warte {0:N0}ms":Format(i * 300);
			p.Value = i * 1000;
			clr.System.Threading.Thread:Sleep(300);
		end;
	end;
	
end;


blockPane = command(
	function (arg) : void
		runTask(waitTaskAsync, disableUI);
	end
);

blockBk = command(
	function (arg) : void
		runTask(waitTaskAsync, TestBackgroundProgressState);
	end
);

blockGlobal = command(
	function (arg) : void
		runTask(waitTaskAsync, TestForegroundProgressState);
	end
);

local ctrl = UI.Grid {
	RowDefinitions = { 60, 60, 60, 60 },
	ColumnDefinitions = { 200, "*" },

	UI.Button {
		Margin = "12",
		Click = function (sender, e) : void
			data.Name = "Test {0}":Format(clickCount);
			bindTitle = "Hello World clicked {0} times.":Format(clickCount);
			clickCount = clickCount + 1;
		end,
		"Hello"
	},

	UI.TextBlock {
		["Grid.Column"] = 1,
		"Hello pane with number ",
		UI.Run {
			Text = UI.Binding("Arguments.index")
		},
		UI.LineBreak {},
		UI.Run {
			Text = UI.Binding("bindTitle")
		}
	},
	UI.ContentPresenter {
		["Grid.Row"] = 2,
		Content = UI.Binding("SubChild.Control")
	}
};

setControl {
	Title = UI.Binding("bindTitle"),
	SubTitle = "Test",
	ctrl
};

SubChild = self:requirePane 'helloSub.lua';
