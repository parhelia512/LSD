-- [yue]: Test/ChatTest.yue
local _ENV = Dora -- 1
local Path <const> = Path -- 2
local Content <const> = Content -- 2
local require <const> = require -- 2
local Director <const> = Director -- 2
local print <const> = print -- 2
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
local Interaction = require("UI.Interaction") -- 17
local MessageBox = require("UI.MessageBox") -- 18
local Bubble = require("UI.Bubble") -- 19
return Director.ui3D:addChild((function() -- 21
	local _with_0 = LsdOSBack() -- 21
	_with_0.bg:addChild((function() -- 22
		local _with_1 = Interaction({ -- 22
			text = "妮妮莉特", -- 22
			buttons = { -- 23
				{ -- 23
					"对话", -- 23
					"TALK" -- 23
				}, -- 23
				{ -- 24
					"进行训练", -- 24
					"TRAINING" -- 24
				}, -- 24
				{ -- 25
					"个人信息", -- 25
					"INFORMATION" -- 25
				} -- 25
			} -- 22
		}) -- 22
		_with_1:show() -- 27
		_with_1:slot("Tapped", function(index) -- 28
			return print(index) -- 28
		end) -- 28
		return _with_1 -- 22
	end)()) -- 22
	_with_0.bg:addChild((function() -- 29
		local _with_1 = MessageBox() -- 29
		_with_1.x = -600 -- 30
		return _with_1 -- 29
	end)()) -- 29
	_with_0.bg:addChild((function() -- 31
		local _with_1 = Bubble({ -- 31
			text = "聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字，聊天文字" -- 31
		}) -- 31
		_with_1.x = 600 -- 32
		return _with_1 -- 31
	end)()) -- 31
	_with_0:alignLayout() -- 33
	return _with_0 -- 21
end)()) -- 21
