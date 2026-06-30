-- [yue]: Script/Academy/Action.yue
local _module_0 = nil -- 1
local _ENV = Dora(Dora.Platformer) -- 1
local Data <const> = Data -- 2
local UnitAction <const> = UnitAction -- 2
local once <const> = once -- 2
local sleep <const> = sleep -- 2
local cycle <const> = cycle -- 2
local math <const> = math -- 2
local coroutine <const> = coroutine -- 2
local Vec2 <const> = Vec2 -- 2
local _anon_func_0 = function(_with_0) -- 118
	local _val_0 = _with_0.lastCompleted -- 118
	return "melee" == _val_0 or "pistol" == _val_0 or "bow" == _val_0 or "gun1" == _val_0 or "gun2" == _val_0 or "gun3" == _val_0 or "throw" == _val_0 or "parry" == _val_0 or "defense" == _val_0 or "comp" == _val_0 or "comm" == _val_0 or "hit" == _val_0 -- 118
end -- 118
_module_0 = function() -- 4
	local Store = Data.store -- 5
	UnitAction:add("fall", { -- 8
		priority = 10, -- 8
		reaction = 3, -- 9
		recovery = 0.1, -- 10
		queued = true, -- 11
		available = function() -- 12
			return true -- 12
		end, -- 12
		create = function(self) -- 13
			return once(function() -- 13
				local _with_0 = self.playable -- 13
				_with_0.speed = 1 -- 14
				sleep(_with_0:play("fall")) -- 15
				sleep(0.1) -- 16
				_with_0.recovery = 0 -- 17
				sleep(_with_0:play("standUp")) -- 18
				return _with_0 -- 13
			end) -- 13
		end -- 13
	}) -- 7
	UnitAction:add("evade", { -- 21
		priority = 10, -- 21
		reaction = 10, -- 22
		recovery = 0, -- 23
		queued = true, -- 24
		available = function() -- 25
			return true -- 25
		end, -- 25
		create = function(self) -- 26
			local time = 0 -- 27
			do -- 28
				local _with_0 = self.playable -- 28
				_with_0.speed = 1.0 -- 29
				time = _with_0:play("bstep") -- 30
			end -- 28
			return once(function(self) -- 31
				local dir = self.faceRight and -1 or 1 -- 32
				cycle(math.max(time, 0.4), function() -- 33
					self.velocityX = 800 * dir -- 33
				end) -- 33
				do -- 34
					local _with_0 = self.playable -- 34
					_with_0.recovery = 0.3 -- 35
					_with_0.speed = 1.0 -- 36
					_with_0:play("idle") -- 37
				end -- 34
				sleep(0.3) -- 38
				return true -- 39
			end) -- 31
		end -- 26
	}) -- 20
	UnitAction:add("rush", { -- 42
		priority = 10, -- 42
		reaction = 10, -- 43
		recovery = 0, -- 44
		queued = true, -- 45
		available = function() -- 46
			return true -- 46
		end, -- 46
		create = function(self) -- 47
			local time = 0 -- 48
			do -- 49
				local _with_0 = self.playable -- 49
				_with_0.speed = 1.0 -- 50
				time = _with_0:play("fstep") -- 51
			end -- 49
			return once(function(self) -- 52
				local dir = self.faceRight and 1 or -1 -- 53
				cycle(math.max(time, 0.4), function() -- 54
					self.velocityX = 800 * dir -- 54
				end) -- 54
				do -- 55
					local _with_0 = self.playable -- 55
					_with_0.recovery = 0.3 -- 56
					_with_0.speed = 1.0 -- 57
					_with_0:play("idle") -- 58
				end -- 55
				sleep(0.3) -- 59
				return true -- 60
			end) -- 52
		end -- 47
	}) -- 41
	UnitAction:add("hit", { -- 63
		priority = 99, -- 63
		reaction = 3, -- 64
		recovery = 0.2, -- 65
		queued = false, -- 66
		available = function() -- 67
			return true -- 67
		end, -- 67
		create = function(self) -- 68
			return once(function() -- 68
				local _with_0 = self.playable -- 69
				_with_0.speed = 1 -- 70
				sleep(_with_0:play("hit")) -- 71
				return _with_0 -- 69
			end) -- 68
		end -- 68
	}) -- 62
	UnitAction:add("pistol", { -- 74
		priority = 3, -- 74
		reaction = 3, -- 75
		recovery = 0.2, -- 76
		queued = true, -- 77
		available = function() -- 78
			return true -- 78
		end, -- 78
		create = function(self) -- 79
			return once(function() -- 79
				local _with_0 = self.playable -- 80
				_with_0.speed = 1 -- 81
				sleep(_with_0:play("pistol")) -- 82
				return _with_0 -- 80
			end) -- 79
		end -- 79
	}) -- 73
	UnitAction:add("test", { -- 85
		priority = 3, -- 85
		reaction = 3, -- 86
		recovery = 0.1, -- 87
		queued = true, -- 88
		available = function() -- 89
			return true -- 89
		end, -- 89
		create = function(self) -- 90
			return once(function() -- 90
				local _with_0 = self.playable -- 90
				_with_0.speed = 1 -- 91
				sleep(_with_0:play(Store.testAction)) -- 92
				return _with_0 -- 90
			end) -- 90
		end -- 90
	}) -- 84
	UnitAction:add("idle", { -- 95
		priority = 1, -- 95
		reaction = 2.0, -- 96
		recovery = 0.2, -- 97
		available = function(self) -- 98
			return self.onSurface -- 98
		end, -- 98
		create = function(self) -- 99
			local _with_0 = self.playable -- 99
			_with_0.speed = 1.0 -- 100
			_with_0:play("idle", true) -- 101
			local playIdleSpecial = coroutine.create(function() -- 102
				while true do -- 102
					sleep(3) -- 103
					sleep(_with_0:play("idle1")) -- 104
					_with_0:play("idle", true) -- 105
				end -- 102
			end) -- 102
			self.data.playIdleSpecial = playIdleSpecial -- 106
			return function(self) -- 107
				coroutine.resume(playIdleSpecial) -- 108
				return not self.onSurface -- 109
			end -- 107
		end -- 99
	}) -- 94
	UnitAction:add("prepare", { -- 112
		priority = 1, -- 112
		reaction = 2.0, -- 113
		recovery = 0.2, -- 114
		available = function(self) -- 115
			return self.onSurface -- 115
		end, -- 115
		create = function(self) -- 116
			local _with_0 = self.playable -- 116
			_with_0.speed = 1.0 -- 117
			if _anon_func_0(_with_0) then -- 118
				_with_0.recovery = 0.0 -- 132
			end -- 118
			_with_0:play("prepare", true) -- 133
			return function(self) -- 134
				return not self.onSurface -- 134
			end -- 134
		end -- 116
	}) -- 111
	UnitAction:add("fmove", { -- 137
		priority = 1, -- 137
		reaction = 2.0, -- 138
		recovery = 0.2, -- 139
		available = function(self) -- 140
			return self.onSurface -- 140
		end, -- 140
		create = function(self) -- 141
			do -- 142
				local _with_0 = self.playable -- 142
				_with_0.speed = 1 -- 143
				_with_0:play("fmove", true) -- 144
			end -- 142
			return function(self, action) -- 145
				local elapsedTime, recovery = action.elapsedTime, action.recovery -- 146
				local move = self.unitDef.move -- 147
				local moveSpeed -- 148
				if elapsedTime < recovery then -- 148
					moveSpeed = math.min(elapsedTime / recovery, 1.0) -- 149
				else -- 151
					moveSpeed = 1.0 -- 151
				end -- 148
				self.velocityX = moveSpeed * (self.faceRight and move or -move) -- 152
				return not self.onSurface -- 153
			end -- 145
		end -- 141
	}) -- 136
	UnitAction:add("keepIdle", { -- 156
		priority = 100, -- 156
		reaction = 2.0, -- 157
		recovery = 0.2, -- 158
		available = function() -- 159
			return true -- 159
		end, -- 159
		create = function(self) -- 160
			do -- 161
				local _with_0 = self.playable -- 161
				_with_0.speed = 1 -- 162
				_with_0:play("idle", true) -- 163
			end -- 161
			return function() -- 164
				return false -- 164
			end -- 164
		end -- 160
	}) -- 155
	UnitAction:add("idle1", { -- 167
		priority = 1, -- 167
		reaction = 2.0, -- 168
		recovery = 0.2, -- 169
		available = function() -- 170
			return true -- 170
		end, -- 170
		queued = true, -- 171
		create = function(self) -- 172
			return once(function() -- 172
				local _with_0 = self.playable -- 173
				_with_0.speed = 1 -- 174
				sleep(_with_0:play("idle1", false)) -- 175
				return _with_0 -- 173
			end) -- 172
		end -- 172
	}) -- 166
	UnitAction:add("keepMove", { -- 178
		priority = 100, -- 178
		reaction = 2.0, -- 179
		recovery = 0.2, -- 180
		available = function() -- 181
			return true -- 181
		end, -- 181
		create = function(self) -- 182
			do -- 183
				local _with_0 = self.playable -- 183
				_with_0.speed = 1 -- 184
				_with_0:play("fmove", true) -- 185
			end -- 183
			return function() -- 186
				return false -- 186
			end -- 186
		end -- 182
	}) -- 177
	UnitAction:add("bmove", { -- 189
		priority = 1, -- 189
		reaction = 2.0, -- 190
		recovery = 0.2, -- 191
		available = function(self) -- 192
			return self.onSurface -- 192
		end, -- 192
		create = function(self) -- 193
			do -- 194
				local _with_0 = self.playable -- 194
				_with_0.speed = 1 -- 195
				_with_0:play("bmove", true) -- 196
			end -- 194
			return function(self, action) -- 197
				local elapsedTime, recovery = action.elapsedTime, action.recovery -- 198
				local move = self.unitDef.move -- 199
				local moveSpeed -- 200
				if elapsedTime < recovery then -- 200
					moveSpeed = math.min(elapsedTime / recovery, 1.0) -- 201
				else -- 203
					moveSpeed = 1.0 -- 203
				end -- 200
				self.velocityX = moveSpeed * (self.faceRight and -move or move) * 0.5 -- 204
				return not self.onSurface -- 205
			end -- 197
		end -- 193
	}) -- 188
	UnitAction:add("jump", { -- 208
		priority = 3, -- 208
		reaction = 2.0, -- 209
		recovery = 0.1, -- 210
		queued = true, -- 211
		available = function(self) -- 212
			return self.onSurface -- 212
		end, -- 212
		create = function(self) -- 213
			local velocityX = self.velocityX -- 214
			local jump = self.unitDef.jump -- 215
			self.velocity = Vec2(velocityX, jump) -- 216
			return once(function(self) -- 217
				local _with_0 = self.playable -- 218
				_with_0.speed = 1 -- 219
				sleep(_with_0:play("jump", false)) -- 220
				return _with_0 -- 218
			end) -- 217
		end -- 213
	}) -- 207
	return UnitAction:add("fallOff", { -- 223
		priority = 2, -- 223
		reaction = -1, -- 224
		recovery = 0.3, -- 225
		available = function(self) -- 226
			return not self.onSurface -- 226
		end, -- 226
		create = function(self) -- 227
			if self.playable.current ~= "jumping" then -- 228
				local _with_0 = self.playable -- 229
				_with_0.speed = 1 -- 230
				_with_0:play("jumping", true) -- 231
			end -- 228
			return once(function(self) -- 232
				while true do -- 233
					if self.onSurface then -- 234
						do -- 235
							local _with_0 = self.playable -- 235
							_with_0.speed = 1 -- 236
							sleep(_with_0:play("landing", false)) -- 237
						end -- 235
						coroutine.yield(true) -- 238
					else -- 240
						coroutine.yield(false) -- 240
					end -- 234
				end -- 233
			end) -- 232
		end -- 227
	}) -- 222
end -- 4
return _module_0 -- 1
