-- [yue]: Test/MissionFailTest.yue
local _ENV = Dora -- 1
local Path <const> = Path -- 2
local Content <const> = Content -- 2
local require <const> = require -- 2
local Director <const> = Director -- 2
do -- 4
	local scriptPath = Path:getScriptPath(...) -- 4
	if scriptPath then -- 4
		scriptPath = Path:getPath(scriptPath) -- 5
		local _list_0 = { -- 7
			scriptPath, -- 7
			Path(scriptPath, "Script"), -- 8
			Path(scriptPath, "Spine"), -- 9
			Path(scriptPath, "Image"), -- 10
			Path(scriptPath, "Font") -- 11
		} -- 6
		for _index_0 = 1, #_list_0 do -- 6
			local path = _list_0[_index_0] -- 6
			Content:insertSearchPath(1, path) -- 13
		end -- 6
	else -- 14
		return -- 14
	end -- 4
end -- 4
local LsdOSBack = require("UI.LsdOSBack") -- 16
local MissionFail = require("UI.MissionFail") -- 17
Director.ui3D:addChild((function() -- 19
	local _with_0 = LsdOSBack() -- 19
	_with_0:alignLayout() -- 20
	return _with_0 -- 19
end)()) -- 19
return Director.ui3D:addChild((function() -- 21
	local _with_0 = MissionFail() -- 21
	_with_0:alignLayout() -- 22
	return _with_0 -- 21
end)()) -- 21
