-- [yue]: Script/Scene/TrainA.yue
local _module_0 = nil -- 1
local _ENV = Dora -- 1
local require <const> = require -- 2
local Class <const> = Class -- 2
local Train = require("Scene.Train") -- 3
_module_0 = Class(Train, { -- 5
	__init = function(self) -- 5
		self.__base.__init(self, true) -- 6
		self.tag = "TrainA" -- 7
	end -- 5
}) -- 4
return _module_0 -- 1
