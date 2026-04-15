-- [yue]: Script/System/PlayBubbleChat.yue
local _module_0 = nil -- 1
local _ENV = Dora -- 1
local require <const> = require -- 2
local type <const> = type -- 2
local Group <const> = Group -- 2
local thread <const> = thread -- 2
local emit <const> = emit -- 2
local tostring <const> = tostring -- 2
local sleep <const> = sleep -- 2
local math <const> = math -- 2
local Bubble = require("UI.Bubble") -- 4
local YarnRunner = require("YarnRunner") -- 5
local Config = require("Data.Config") -- 6
local Command = require("System.Command") -- 7
local u8 = require("utf-8") -- 8
local getCharName -- 10
getCharName = function(current) -- 10
	if current.marks then -- 11
		local _list_0 = current.marks -- 12
		for _index_0 = 1, #_list_0 do -- 12
			local mark = _list_0[_index_0] -- 12
			local _type_0 = type(mark) -- 13
			local _tab_0 = "table" == _type_0 or "userdata" == _type_0 -- 13
			if _tab_0 then -- 13
				local attr = mark.name -- 13
				local name -- 13
				do -- 13
					local _obj_0 = mark.attrs -- 13
					local _type_1 = type(_obj_0) -- 13
					if "table" == _type_1 or "userdata" == _type_1 then -- 13
						name = _obj_0.name -- 13
					end -- 13
				end -- 13
				local id -- 13
				do -- 13
					local _obj_0 = mark.attrs -- 13
					local _type_1 = type(_obj_0) -- 13
					if "table" == _type_1 or "userdata" == _type_1 then -- 13
						id = _obj_0.id -- 13
					end -- 13
				end -- 13
				if name == nil then -- 13
					name = '' -- 13
				end -- 13
				if id == nil then -- 13
					id = '' -- 13
				end -- 13
				if attr ~= nil then -- 13
					if ("char" == attr or "Character" == attr) then -- 14
						if id == "char" then -- 15
							id = Config.char -- 15
						end -- 15
						return name, id -- 16
					end -- 14
				end -- 13
			end -- 13
		end -- 12
	end -- 11
	return '', '' -- 17
end -- 10
_module_0 = function(file) -- 19
	local runner = YarnRunner(file, "Start", Config, Command) -- 20
	local unitGroup = Group({ -- 21
		"unit", -- 21
		"name" -- 21
	}) -- 21
	return thread(function() -- 22
		repeat -- 22
			local itemType, result = runner:advance() -- 23
			if "Text" == itemType then -- 24
				local name, characterId = getCharName(result) -- 25
				local text = result.text -- 26
				local entity = unitGroup:find(function(self) -- 27
					return self.name == characterId -- 27
				end) -- 27
				if entity then -- 27
					local unit = entity.unit -- 28
					do -- 29
						local bubble = unit:getChildByTag("bubble") -- 29
						if bubble then -- 29
							bubble:removeFromParent() -- 30
						end -- 29
					end -- 29
					unit:addChild(Bubble({ -- 31
						text = text -- 31
					})) -- 31
					emit("MessageBox.Add", { -- 32
						title = "对话", -- 32
						special = false, -- 32
						text = tostring(name) .. "：" .. tostring(text) -- 32
					}) -- 32
					sleep(math.max(1, 0.15 * u8.len(text))) -- 33
				end -- 27
			else -- 35
				return -- 35
			end -- 24
		until false -- 22
	end) -- 22
end -- 19
return _module_0 -- 1
