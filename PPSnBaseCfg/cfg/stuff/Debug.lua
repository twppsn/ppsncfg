const Procs typeof TecWare.DE.Stuff.Procs;
const Path typeof System.IO.Path;
const DirectoryInfo typeof System.IO.DirectoryInfo;
const FileInfo typeof System.IO.FileInfo;
const DEServerBaseLog typeof TecWare.DE.Server.DEServerBaseLog;

local function findProjectFile() : FileInfo

	local basePath = Path:GetFullPath(Path:Combine(Path:GetDirectoryName(DEServerBaseLog:GetType().Assembly.Location), [[..\..]]));
	local di = DirectoryInfo(basePath);

	if di.Exists then
		local fi = di:GetFiles("*.csproj");
		if #fi == 1 then
			return fi[0];
		end;
	end;
end; -- findProjectFile

local function testFile(fileName : string) : FileInfo

	local fi = FileInfo(fileName);
	if fi.Exists then
		return fi;
	end;
end; -- testFile

local function findMsBuild() : FileInfo
	return testFile [[C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\msbuild.exe]]
		or testFile [[C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\msbuild.exe]]
		or testFile [[C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\msbuild.exe]];
end;

local function copyConfig()
	-- find csproj
	local projectFile = findProjectFile();
	if projectFile ~= nil and projectFile.Exists then
		-- run msbuild
		print("CopyConfig: " .. projectFile.Name);
		
		local msbuild = findMsBuild();
		if msbuild then
			--print("MSBuild: " .. msbuild.FullName);
			local cmd = "\"" .. msbuild.FullName .. "\" /target:CopyConfig \"" .. projectFile.FullName .. "\"";
			--print(cmd);
			do (f = IO.popen(cmd, "r+"))
				while true do
					local l = f:read();
					if l ~= nil then
						print(l);
					else
						break;
					end;
				end;
				
				local exitCode = f:close();
				if exitCode ~= 0 then
					error("MSBuild failed: " .. exitCode);
				end;
			end;
		else
			error("MSBuild nicht gefunden.");
		end;
	end;
end; -- CopyConfig

function DebugEnv.InitSession(session)

end; -- DebugEnv.InitSession

function DebugEnv.loadTable(fileName : string)
	local x = clr.System.Xml.Linq.XDocument:Load(fileName);
	return Procs:CreateLuaTable(x = x:Root);
end;

function DebugEnv.OnBeforeCompile(x)
	copyConfig();
end; -- DebugEnv.OnBeforeCompile

DebugEnv.CopyConfig = copyConfig;
