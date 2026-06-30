-- [yue]: Script/System/Command.yue
local _module_0 = nil -- 1
local _ENV = Dora -- 1
local require <const> = require -- 2
local coroutine <const> = coroutine -- 2
local once <const> = once -- 2
local sleep <const> = sleep -- 2
local Director <const> = Director -- 2
local emit <const> = emit -- 2
local setmetatable <const> = setmetatable -- 2
local print <const> = print -- 2
local tostring <const> = tostring -- 2
local table <const> = table -- 2
local select <const> = select -- 2
local Config = require("Data.Config") -- 3
local u8 = require("utf-8") -- 4
local _anon_func_0 = function(...) -- 25
	local _accum_0 = { } -- 25
	local _len_0 = 1 -- 25
	for i = 1, select('#', ...) do -- 25
		_accum_0[_len_0] = tostring(select(i, ...)) -- 25
		_len_0 = _len_0 + 1 -- 25
	end -- 25
	return _accum_0 -- 25
end -- 25
local commands = setmetatable({ -- 7
	preload = function(...) -- 7
		return coroutine.yield("Command", { -- 8
			preload = { -- 8
				... -- 8
			} -- 8
		}) -- 8
	end, -- 7
	inputName = function() -- 9
		local InputBox = require("UI.InputBox") -- 10
		local _with_0 = InputBox({ -- 11
			hint = "请输入你的姓名" -- 11
		}) -- 11
		_with_0.visible = false -- 12
		_with_0:schedule(once(function() -- 13
			sleep() -- 14
			_with_0.visible = true -- 15
		end)) -- 13
		_with_0:addTo(Director.ui3D) -- 16
		_with_0:slot("Inputed", function(name) -- 17
			if name == "" then -- 18
				name = "匿名玩家" -- 18
			end -- 18
			Config.charName = u8.sub(name, 1, 10) -- 19
			_with_0:removeFromParent() -- 20
			return emit("Story.Advance") -- 21
		end) -- 17
		coroutine.yield("Command") -- 22
		return _with_0 -- 11
	end, -- 9
	setCharId = function(charId) -- 23
		Config.char = charId -- 23
	end -- 23
}, { -- 24
	__index = function(_self, name) -- 24
		return function(...) -- 24
			return print("[command]: " .. tostring(name) .. "(" .. tostring(table.concat(_anon_func_0(...), ', ')) .. ")") -- 25
		end -- 24
	end -- 24
}) -- 6
_module_0 = commands -- 28
return _module_0 -- 1
