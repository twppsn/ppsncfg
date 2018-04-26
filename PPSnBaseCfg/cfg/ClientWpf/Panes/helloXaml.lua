
SubChild = self:requireXaml 'helloSub.xaml';

clickCount = 1;

--[[
__metatable = { 
	__changed = function (table, name)
		msgbox("Changed: " .. name);
	end
};
]]

bindTitle = "Hello {0}":Format(Arguments.index);

local t = {
	{ Id = 2, Text = "Hallo 2" },
	{ Id = 3, Text = "Hallo 3" },
	{ Id = 4, Text = "Hallo 4" },
	{ Id = 5, Text = "Hallo 5" }
};

Liste = rawarray(t);

function HelloClick(sender, e) : void
	bindTitle = "Hello World clicked {0} times.":Format(clickCount);
	clickCount = clickCount + 1;
end;

function ListBoxClicked(sender, e) : void
	msgbox(ListControl or "null");
	msgbox(ListControl.SelectedIndex);
end;