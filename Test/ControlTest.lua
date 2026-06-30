-- [yue]: Test/ControlTest.yue
local _ENV = Dora -- 1
local Path <const> = Path -- 2
local Content <const> = Content -- 2
local require <const> = require -- 2
local Director <const> = Director -- 2
local thread <const> = thread -- 2
local sleep <const> = sleep -- 2
local emit <const> = emit -- 2
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
local HUDControl = require("UI.HUDControl") -- 17
Director.ui3D:addChild((function() -- 19
	local _with_0 = LsdOSBack() -- 19
	_with_0:alignLayout() -- 20
	return _with_0 -- 19
end)()) -- 19
Director.ui3D:addChild(HUDControl()) -- 22
return thread(function() -- 24
	sleep(1) -- 25
	emit("MessageBox.Add", { -- 26
		title = "社交", -- 26
		special = false, -- 26
		text = "你借调的学员默翎获得了3个赞" -- 26
	}) -- 26
	sleep(1) -- 27
	return emit("MessageBox.Add", { -- 28
		title = "系统", -- 28
		special = true, -- 28
		text = "你借调的学员默翎获得了3个赞" -- 28
	}) -- 28
end) -- 24
