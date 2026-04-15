-- [yue]: Script/Tutorial/AI.yue
local _module_0 = nil -- 1
local _ENV = Dora(Dora.Platformer, Dora.Platformer.Decision) -- 1
local Data <const> = Data -- 5
local Dora <const> = Dora -- 5
local Behave <const> = Behave -- 5
local Spine <const> = Spine -- 5
local Sel <const> = Sel -- 5
local Seq <const> = Seq -- 5
local Con <const> = Con -- 5
local AI <const> = AI -- 5
local math <const> = math -- 5
local Act <const> = Act -- 5
local Group <const> = Group -- 5
local Reject <const> = Reject -- 5
local Accept <const> = Accept -- 5
local _anon_func_0 = function(_with_0) -- 14
	local _with_1 = Spine("empgun") -- 14
	_with_1.look = "PT" -- 15
	_with_1.scaleX = 0.2 -- 16
	_with_1.scaleY = 0.2 -- 17
	return _with_1 -- 14
end -- 14
_module_0 = function() -- 7
	local Store = Data.store -- 8
	local BT = Dora.Platformer.Behavior -- 9
	Store["AI:NiniliteIntro"] = Behave("intro", BT.Seq({ -- 12
		BT.Con("raise gun", function(self) -- 12
			do -- 13
				local _with_0 = self.owner.playable -- 13
				_with_0:setSlot("pistol", _anon_func_0(_with_0)) -- 14
				_with_0.speed = 0.8 -- 18
				_with_0:play("pistol") -- 19
			end -- 13
			return true -- 20
		end), -- 12
		BT.Wait(0.5), -- 21
		BT.Con("hold gun", function(self) -- 22
			self.owner.playable.speed = 0 -- 23
			return true -- 24
		end), -- 22
		BT.Repeat(BT.Con("wait", function() -- 25
			return true -- 25
		end)) -- 25
	})) -- 11
	local normalNPC = Sel({ -- 29
		Seq({ -- 30
			Con("not facing nearest player", function(self) -- 30
				local _list_0 = AI:getDetectedUnits() -- 31
				for _index_0 = 1, #_list_0 do -- 31
					local unit = _list_0[_index_0] -- 31
					if unit.entity.player then -- 32
						return math.abs(self.x - unit.x) <= 200 and (self.x > unit.x) == self.faceRight -- 33
					end -- 32
				end -- 31
				local unit = AI:getNearestUnit("Any") -- 34
				if unit then -- 34
					return math.abs(self.x - unit.x) <= 200 and (self.x > unit.x) == self.faceRight -- 35
				else -- 37
					return false -- 37
				end -- 34
			end), -- 30
			Act("turn") -- 38
		}), -- 29
		Act("idle") -- 40
	}) -- 28
	local gotoExit = Seq({ -- 44
		Con("leading", function(self) -- 44
			return self.entity.leading -- 44
		end), -- 44
		Sel({ -- 46
			Seq({ -- 47
				Con("reached exit", function(unit) -- 47
					if unit.x >= 6200 then -- 48
						unit.entity.leading = false -- 49
						unit:emit("ReachedExit") -- 50
						return true -- 51
					else -- 53
						return false -- 53
					end -- 48
				end), -- 47
				normalNPC -- 54
			}), -- 46
			Seq({ -- 57
				Con("player is far", function(unit) -- 57
					return Group({ -- 58
						"player", -- 58
						"unit" -- 58
					}):each(function(self) -- 58
						return self.player and unit.x - self.unit.x > 400 -- 58
					end) -- 58
				end), -- 57
				Act("idle") -- 59
			}), -- 56
			Seq({ -- 62
				Con("not facing exit", function(self) -- 62
					return not self.faceRight -- 62
				end), -- 62
				Act("turn"), -- 63
				Reject() -- 64
			}), -- 61
			Act("fmove") -- 66
		}) -- 45
	}) -- 43
	Store["AI:NPC"] = Sel({ -- 71
		Seq({ -- 72
			Con("enemy nearby", function() -- 72
				return (AI:getNearestUnit("Enemy") ~= nil) -- 72
			end), -- 72
			Sel({ -- 74
				Seq({ -- 75
					Con("not facing nearest enemy", function(self) -- 75
						local unit = AI:getNearestUnit("Enemy") -- 76
						if unit then -- 76
							return (self.x > unit.x) == self.faceRight -- 77
						else -- 79
							return false -- 79
						end -- 76
					end), -- 75
					Act("turn"), -- 80
					Reject() -- 81
				}), -- 74
				Seq({ -- 84
					Con("is falling", function(self) -- 84
						return not self.onSurface -- 84
					end), -- 84
					Act("fallOff") -- 85
				}), -- 83
				Seq({ -- 88
					Con("attackable", function(self) -- 88
						local units = AI:getUnitsInAttackRange() -- 89
						return units.count > 0 and units:each(function(unit) -- 90
							return (self.x <= unit.x) == self.faceRight -- 90
						end) -- 90
					end), -- 88
					Behave("attack", BT.Seq({ -- 92
						BT.Command("prepare"), -- 92
						BT.Wait(1), -- 93
						BT.Act("laser") -- 94
					})) -- 91
				}), -- 87
				Act("prepare") -- 97
			}) -- 73
		}), -- 71
		gotoExit, -- 100
		normalNPC -- 101
	}) -- 70
	Store["AI:Monster"] = Sel({ -- 105
		Seq({ -- 106
			Con("enemy dead", function(self) -- 106
				return self.entity.hp <= 0 -- 106
			end), -- 106
			Accept() -- 107
		}), -- 105
		Seq({ -- 110
			Con("enemy nearby", function() -- 110
				return (AI:getNearestUnit("Enemy") ~= nil) -- 110
			end), -- 110
			Sel({ -- 112
				Seq({ -- 113
					Con("not facing nearest enemy", function(self) -- 113
						local unit = AI:getNearestUnit("Enemy") -- 114
						if unit then -- 114
							return (self.x > unit.x) == self.faceRight -- 115
						else -- 117
							return false -- 117
						end -- 114
					end), -- 113
					Act("turn"), -- 118
					Reject() -- 119
				}), -- 112
				Seq({ -- 122
					Con("attackable", function(self) -- 122
						local units = AI:getUnitsInAttackRange() -- 123
						return units.count > 0 and units:each(function(unit) -- 124
							return (self.x <= unit.x) == self.faceRight -- 124
						end) -- 124
					end), -- 122
					Act("blow") -- 125
				}), -- 121
				Act("fmove") -- 127
			}) -- 111
		}), -- 109
		Act("idle") -- 130
	}) -- 104
	Store["AI:NiniliteFight"] = Store["AI:NPC"] -- 133
	local normalControl = Sel({ -- 136
		Seq({ -- 137
			Sel({ -- 138
				Seq({ -- 139
					Con("fmove key down", function(self) -- 139
						return not (self.entity.keyLeft and self.entity.keyRight) and ((self.entity.keyLeft and self.faceRight) or (self.entity.keyRight and not self.faceRight)) -- 140
					end), -- 139
					Act("turn") -- 145
				}), -- 138
				Seq({ -- 148
					Con("bmove key down", function(self) -- 148
						return not (self.entity.keyLeft or self.entity.keyRight) and not (self.entity.keyBLeft and self.entity.keyBRight) and ((self.entity.keyBLeft and not self.faceRight) or (self.entity.keyBRight and self.faceRight)) -- 149
					end), -- 148
					Act("turn") -- 155
				}) -- 147
			}), -- 137
			Reject() -- 158
		}), -- 136
		Seq({ -- 161
			Con("kinetic", function(self) -- 161
				return self.entity.keyShoot -- 161
			end), -- 161
			Act("kinetic") -- 162
		}), -- 160
		Seq({ -- 165
			Con("is falling", function(self) -- 165
				return not self.onSurface -- 165
			end), -- 165
			Act("fallOff") -- 166
		}), -- 164
		Seq({ -- 169
			Con("fmove key down", function(self) -- 169
				return self.entity.keyLeft or self.entity.keyRight -- 169
			end), -- 169
			Act("fmove") -- 170
		}), -- 168
		Seq({ -- 173
			Con("bmove key down", function(self) -- 173
				return self.entity.keyBLeft or self.entity.keyBRight -- 173
			end), -- 173
			Act("bmove") -- 174
		}), -- 172
		Act("idle") -- 176
	}) -- 135
	local battleControl = Sel({ -- 180
		Seq({ -- 181
			Con("kinetic", function(self) -- 181
				return self.entity.keyShoot -- 181
			end), -- 181
			Act("kinetic") -- 182
		}), -- 180
		Seq({ -- 185
			Con("is falling", function(self) -- 185
				return not self.onSurface -- 185
			end), -- 185
			Act("fallOff") -- 186
		}), -- 184
		Seq({ -- 189
			Con("not facing nearest enemy", function(self) -- 189
				local unit = AI:getNearestUnit("Enemy") -- 190
				if unit then -- 190
					return (self.x > unit.x) == self.faceRight -- 191
				else -- 193
					return false -- 193
				end -- 190
			end), -- 189
			Act("turn"), -- 194
			Reject() -- 195
		}), -- 188
		Seq({ -- 198
			Con("left key down", function(self) -- 198
				return self.entity.keyLeft -- 198
			end), -- 198
			Act(function(self) -- 199
				local unit = AI:getNearestUnit("Enemy") -- 200
				if unit then -- 200
					return self.x > unit.x and "fmove" or "bmove" -- 201
				else -- 203
					return "" -- 203
				end -- 200
			end) -- 199
		}), -- 197
		Seq({ -- 206
			Con("right key down", function(self) -- 206
				return self.entity.keyRight -- 206
			end), -- 206
			Act(function(self) -- 207
				local unit = AI:getNearestUnit("Enemy") -- 208
				if unit then -- 208
					return self.x <= unit.x and "fmove" or "bmove" -- 209
				else -- 211
					return "" -- 211
				end -- 208
			end) -- 207
		}), -- 205
		Act("prepare") -- 213
	}) -- 179
	Store["AI:PlayerControl"] = Sel({ -- 217
		Seq({ -- 218
			Con("enemy nearby", function() -- 218
				return (AI:getNearestUnit("Enemy") ~= nil) -- 218
			end), -- 218
			battleControl -- 219
		}), -- 217
		normalControl -- 221
	}) -- 216
end -- 7
return _module_0 -- 1
