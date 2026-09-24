const Procs typeof TecWare.DE.Stuff.Procs;
const Path typeof System.IO.Path;
const DirectoryInfo typeof System.IO.DirectoryInfo;
const FileInfo typeof System.IO.FileInfo;
const DEServerBaseLog typeof TecWare.DE.Server.DEServerBaseLog;
const MSBuildLocator typeof Microsoft.Build.Locator.MSBuildLocator;
const VisualStudioInstance typeof Microsoft.Build.Locator.VisualStudioInstance;

const Debug typeof System.Diagnostics.Debug;

-- install-package Microsoft.Build.Locator

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

local function findMsBuild() : FileInfo

	local instances = MSBuildLocator:QueryVisualStudioInstances();
    local latestInstance = nil;
    -- Loop through all found instances to find the highest version
    foreach instance in instances do
        --print( "Checking - Name: {0}, Version: {1}":Format(instance.Name, instance.Version) );
        
        -- If it's the first one, or its version is newer than our recorded latest version
        if latestInstance == nil or instance.Version > latestInstance.Version then
            latestInstance = instance;
        end;
    end;

    -- If we found at least one instance, construct the path or object to return
    if latestInstance ~= nil then
        --print( "Selected Latest - Name: {0}, Version: {1}":Format(latestInstance.Name, latestInstance.Version) );
		--print(Path:Combine(latestInstance.MSBuildPath, "MSBuild.exe"));
        return FileInfo(Path:Combine(latestInstance.MSBuildPath, "MSBuild.exe")); 
    end;
	return nil;
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
			local cmd = "\"" .. msbuild.FullName .. "\" /v:n /clp:Summary;ShowTimestamp;ShowEventId /target:CopyConfig \"" .. projectFile.FullName .. "\"";
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
