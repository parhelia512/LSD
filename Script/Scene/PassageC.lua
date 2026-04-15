-- [yue]: Script/Scene/PassageC.yue
local _module_0 = nil -- 1
local _ENV = Dora -- 1
local require <const> = require -- 2
local Class <const> = Class -- 2
local Passage = require("Scene.Passage") -- 3
_module_0 = Class(Passage, { -- 5
	__init = function(self) -- 5
		self.__base.__init(self, "PassageC", 2, true) -- 6
		self.tag = "PassageC" -- 7
	end -- 5
}) -- 4
return _module_0 -- 1
