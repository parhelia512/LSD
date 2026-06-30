-- [yue]: UI/HUDControl.yue
local _module_0 = nil -- 1
local _ENV = Dora -- 1
local require <const> = require -- 2
local Class <const> = Class -- 2
local Scale <const> = Scale -- 2
local Ease <const> = Ease -- 2
local Keyboard <const> = Keyboard -- 2
local Controller <const> = Controller -- 2
local emit <const> = emit -- 2
local HUDControl = require("UI.View.HUDControl") -- 3
_module_0 = Class(HUDControl, { -- 6
	__init = function(self) -- 6
		self:gslot("Story.Display", function(visible) -- 7
			self.visible = not visible -- 7
		end) -- 7
		self:gslot("Tutorial.Weapon", function() -- 8
			self.weapon:perform(Scale(0.3, 0, 1, Ease.OutBack)) -- 9
			self.weapon.visible = true -- 10
		end) -- 8
		return self.weapon:schedule(function() -- 11
			if Keyboard:isKeyDown("J") or Controller:isButtonDown(0, "a") then -- 12
				emit("Skill.Began") -- 13
			end -- 12
			if Keyboard:isKeyUp("J") or Controller:isButtonUp(0, "a") then -- 14
				return emit("Skill.Ended") -- 15
			end -- 14
		end) -- 11
	end -- 6
}) -- 5
return _module_0 -- 1
