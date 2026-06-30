-- [yue]: Script/Academy/AI.yue
local _module_0 = nil -- 1
local _ENV = Dora(Dora.Platformer, Dora.Platformer.Decision) -- 1
local Data <const> = Data -- 5
local Sel <const> = Sel -- 5
local Seq <const> = Seq -- 5
local Con <const> = Con -- 5
local AI <const> = AI -- 5
local math <const> = math -- 5
local Act <const> = Act -- 5
local Reject <const> = Reject -- 5
_module_0 = function() -- 7
	local Store = Data.store -- 8
	Store["AI:NPC"] = Sel({ -- 11
		Seq({ -- 12
			Con("not facing nearest player", function(self) -- 12
				local _list_0 = AI:getDetectedUnits() -- 13
				for _index_0 = 1, #_list_0 do -- 13
					local unit = _list_0[_index_0] -- 13
					if unit.entity.player then -- 14
						return math.abs(self.x - unit.x) <= 200 and (self.x > unit.x) == self.faceRight -- 15
					end -- 14
				end -- 13
				local unit = AI:getNearestUnit("Any") -- 16
				if unit then -- 16
					return math.abs(self.x - unit.x) <= 200 and (self.x > unit.x) == self.faceRight -- 17
				else -- 19
					return false -- 19
				end -- 16
			end), -- 12
			Act("turn") -- 20
		}), -- 11
		Act("idle") -- 22
	}) -- 10
	Store["AI:PlayerControl"] = Sel({ -- 26
		Seq({ -- 27
			Sel({ -- 28
				Seq({ -- 29
					Con("fmove key down", function(self) -- 29
						return not (self.entity.keyLeft and self.entity.keyRight) and ((self.entity.keyLeft and self.faceRight) or (self.entity.keyRight and not self.faceRight)) -- 30
					end), -- 29
					Act("turn") -- 35
				}), -- 28
				Seq({ -- 38
					Con("bmove key down", function(self) -- 38
						return not (self.entity.keyLeft or self.entity.keyRight) and not (self.entity.keyBLeft and self.entity.keyBRight) and ((self.entity.keyBLeft and not self.faceRight) or (self.entity.keyBRight and self.faceRight)) -- 39
					end), -- 38
					Act("turn") -- 45
				}) -- 37
			}), -- 27
			Reject() -- 48
		}), -- 26
		Seq({ -- 51
			Con("is falling", function(self) -- 51
				return not self.onSurface -- 51
			end), -- 51
			Act("fallOff") -- 52
		}), -- 50
		Seq({ -- 55
			Con("fmove key down", function(self) -- 55
				return self.entity.keyLeft or self.entity.keyRight -- 55
			end), -- 55
			Act("fmove") -- 56
		}), -- 54
		Act("idle") -- 58
	}) -- 25
end -- 7
return _module_0 -- 1
