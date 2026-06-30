-- [yue]: UI/Interaction.yue
local _module_0 = nil -- 1
local _ENV = Dora -- 1
local require <const> = require -- 2
local Class <const> = Class -- 2
local Spawn <const> = Spawn -- 2
local Opacity <const> = Opacity -- 2
local Y <const> = Y -- 2
local Ease <const> = Ease -- 2
local Sequence <const> = Sequence -- 2
local Event <const> = Event -- 2
local InputButton = require("UI.InputButton") -- 3
local Interaction = require("UI.View.Interaction") -- 4
local _anon_func_0 = function(fadeOut, remove) -- 38
	if remove then -- 38
		return Sequence(fadeOut, Event("Remove")) -- 39
	else -- 44
		return fadeOut -- 44
	end -- 38
end -- 38
_module_0 = Class(Interaction, { -- 11
	__init = function(self, args) -- 11
		local buttons = args.buttons -- 12
		if buttons == nil then -- 12
			buttons = { } -- 12
		end -- 12
		local index = 1 -- 13
		for _index_0 = 1, #buttons do -- 14
			local _des_0 = buttons[_index_0] -- 14
			local text, textBG = _des_0[1], _des_0[2] -- 14
			local buttonIndex = index -- 15
			self.menu:addChild((function() -- 16
				local _with_0 = InputButton({ -- 16
					text = text, -- 16
					textBG = textBG -- 16
				}) -- 16
				self.menu.enabled = false -- 17
				_with_0:slot("Tapped", function() -- 18
					return self:emit("Tapped", buttonIndex) -- 18
				end) -- 18
				return _with_0 -- 16
			end)()) -- 16
			index = index + 1 -- 19
		end -- 14
		local size = self.menu:alignItems(5) -- 20
		self.menu.size = size -- 21
		self.menu:alignItems(5) -- 22
		return self:slot("Remove", function() -- 23
			return self:removeFromParent() -- 23
		end) -- 23
	end, -- 11
	show = function(self) -- 25
		self.menu.enabled = true -- 26
		return self:perform(Spawn(Opacity(0.2, 0, 1), Y(0.2, 220, 200, Ease.OutQuad))) -- 27
	end, -- 25
	hide = function(self, remove) -- 32
		if remove == nil then -- 32
			remove = true -- 32
		end -- 32
		self.menu.enabled = false -- 33
		local fadeOut = Spawn(Opacity(0.2, 1, 0), Y(0.2, 200, 220, Ease.InQuad)) -- 34
		return self:perform(_anon_func_0(fadeOut, remove)) -- 38
	end -- 32
}) -- 10
return _module_0 -- 1
