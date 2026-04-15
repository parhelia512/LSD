-- [yue]: UI/StatusBar.yue
local _module_0 = nil -- 1
local _ENV = Dora -- 1
local require <const> = require -- 2
local Class <const> = Class -- 2
local property <const> = property -- 2
local Color3 <const> = Color3 -- 2
local ScaleX <const> = ScaleX -- 2
local Ease <const> = Ease -- 2
local StatusBarView = require("UI.View.StatusBar").default -- 3
local getHPColor -- 5
getHPColor = function(isHostile) -- 5
	return isHostile and 0xffffff or 0x79f652 -- 5
end -- 5
local StatusBar = Class({ -- 8
	__partial = function(self, hp, ap, isHostile) -- 8
		local node -- 9
		node, self._hpBar, self._apBar = StatusBarView(hp, ap, getHPColor(isHostile)) -- 9
		return node -- 10
	end, -- 8
	hp = property(function(self) -- 12
		return self._hp -- 12
	end, function(self, value) -- 13
		if self._hp == value then -- 14
			return -- 14
		end -- 14
		self._hp = value -- 15
		if (value <= 0.25) ~= self._lowHp then -- 16
			local _des_0 = not self._lowHp -- 17
			if _des_0 then -- 17
				self._lowHp = _des_0 -- 17
				self._hpBar.color3 = Color3(0xff0000) -- 18
			else -- 20
				self._hpBar.color3 = Color3(getHPColor(self._isHostile)) -- 20
			end -- 17
		end -- 16
		return self._hpBar:perform(ScaleX(1, self._hpBar.scaleX, value, Ease.OutExpo)) -- 21
	end), -- 12
	ap = property(function(self) -- 23
		return self._ap -- 23
	end, function(self, value) -- 24
		if self._ap == value then -- 25
			return -- 25
		end -- 25
		self._ap = value -- 26
		return self._apBar:perform(ScaleX(1, self._apBar.scaleX, value, Ease.OutExpo)) -- 27
	end), -- 23
	__init = function(self, hp, ap, isHostile) -- 29
		self._hp = hp -- 30
		self._ap = ap -- 31
		self._isHostile = isHostile -- 32
		self._lowHp = hp <= 0.25 -- 33
		if self._lowHp then -- 34
			self._hpBar.color3 = Color3(0xff0000) -- 35
		else -- 37
			self._hpBar.color3 = Color3(getHPColor(self._isHostile)) -- 37
		end -- 34
	end -- 29
}) -- 7
_module_0 = StatusBar -- 39
return _module_0 -- 1
