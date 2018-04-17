 print("Test Code loaded.")

function throwme()
	error(clr.System.Exception("Test"));
end;

function throwmemax()
	local ex = nil;

	for j = 1, 6, 1 do

		ex = clr.System.Exception(message = "Test{0}":Format(j), innerException = ex);

		for i = 1, 20, 1 do
			ex:Data["Data{0}":Format(i)] = "Value{0}":Format(i);
		end;
	end;

	error(ex);
end;

function IncrementHelloIndex() : int 
	if helloIndex == nil then
		helloIndex = 1;
	else
		helloIndex = helloIndex  + 1;
	end;

	return helloIndex;
end;