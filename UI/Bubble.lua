-- [yue]: UI/Bubble.yue
local _module_0 = nil -- 1
local _ENV = Dora -- 1
local require <const> = require -- 2
local Class <const> = Class -- 2
local once <const> = once -- 2
local math <const> = math -- 2
local utf8 <const> = utf8 -- 2
local sleep <const> = sleep -- 2
local Opacity <const> = Opacity -- 2
local Bubble = require("UI.View.Bubble") -- 4
_module_0 = Class(Bubble, { -- 7
	__init = function(self, args) -- 7
		local text = args.text -- 8
		self.tag = "bubble" -- 9
		return self:schedule(once(function() -- 10
			local time = 3 + math.max(0.15 * utf8.len(text, 1)) -- 11
			sleep(time) -- 12
			self:perform(Opacity(0.5, 1, 0)) -- 13
			return self:removeFromParent() -- 14
		end)) -- 10
	end -- 7
}) -- 6
return _module_0 -- 1
