
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

function HelloClick(sender, e) : void
	bindTitle = "Hello World clicked {0} times.":Format(clickCount);
	clickCount = clickCount + 1;
end;
