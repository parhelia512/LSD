-- [yue]: UI/HUDMove.yue
local _module_0 = nil -- 1
local _ENV = Dora -- 1
local require <const> = require -- 2
local Class <const> = Class -- 2
local Group <const> = Group -- 2
local Scale <const> = Scale -- 2
local Ease <const> = Ease -- 2
local Keyboard <const> = Keyboard -- 2
local Controller <const> = Controller -- 2
local HUDMove = require("UI.View.HUDMove") -- 3
_module_0 = Class(HUDMove, { -- 6
	__init = function(self) -- 6
		local playerGroup = Group({ -- 7
			"player" -- 7
		}) -- 7
		local keyboardEnabled = false -- 8
		local updatePlayerControl -- 9
		updatePlayerControl = function(key, down, vpad) -- 9
			if keyboardEnabled and vpad then -- 10
				keyboardEnabled = false -- 11
			end -- 10
			local player = playerGroup:find(function(e) -- 12
				return e.player -- 12
			end) -- 12
			if player then -- 12
				player[key] = down -- 13
			end -- 12
		end -- 9
		self:gslot("HUD.DisplayMove", function(visible) -- 14
			self.visible = visible -- 15
			return self:perform(Scale(0.3, 0, 1, Ease.OutBack)) -- 16
		end) -- 14
		self:schedule(function() -- 17
			if not self.visible then -- 18
				return -- 18
			end -- 18
			local keyA = Keyboard:isKeyPressed("A") or Controller:isButtonPressed(0, "dpleft") -- 19
			local keyD = Keyboard:isKeyPressed("D") or Controller:isButtonPressed(0, "dpright") -- 20
			if keyA or keyD then -- 21
				keyboardEnabled = true -- 21
			end -- 21
			if not keyboardEnabled then -- 22
				return false -- 22
			end -- 22
			updatePlayerControl("keyLeft", keyA, false) -- 23
			updatePlayerControl("keyRight", keyD, false) -- 24
			return false -- 25
		end) -- 17
		self:slot("Left", function(down) -- 26
			return updatePlayerControl("keyLeft", down, true) -- 27
		end) -- 26
		return self:slot("Right", function(down) -- 28
			return updatePlayerControl("keyRight", down, true) -- 29
		end) -- 28
	end -- 6
}) -- 5
return _module_0 -- 1
