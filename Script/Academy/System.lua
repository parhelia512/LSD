-- [yue]: Script/Academy/System.yue
local _module_0 = nil -- 1
local _ENV = Dora(Dora.Platformer) -- 1
local require <const> = require -- 2
local Data <const> = Data -- 2
local Observer <const> = Observer -- 2
local tostring <const> = tostring -- 2
local once <const> = once -- 2
local App <const> = App -- 2
local sleep <const> = sleep -- 2
local Director <const> = Director -- 2
local Entity <const> = Entity -- 2
local assert <const> = assert -- 2
local Dictionary <const> = Dictionary -- 2
local Vec2 <const> = Vec2 -- 2
local Size <const> = Size -- 2
local Array <const> = Array -- 2
local Unit <const> = Unit -- 2
local math <const> = math -- 2
local Node <const> = Node -- 2
local Color <const> = Color -- 2
local cycle <const> = cycle -- 2
local SpriteEffect <const> = SpriteEffect -- 2
local _anon_func_0 = function(_with_1, moveEnter, unit) -- 77
	if "center" == moveEnter then -- 78
		return unit.faceRight -- 78
	elseif "left" == moveEnter then -- 79
		return true -- 79
	elseif "right" == moveEnter then -- 80
		return false -- 80
	end -- 77
end -- 77
local _anon_func_1 = function(MaxPath, self, u) -- 147
	local _exp_0 = self.order -- 147
	if _exp_0 ~= nil then -- 147
		return _exp_0 -- 147
	else -- 147
		return math.random(-MaxPath, MaxPath) -- 147
	end -- 147
end -- 147
local _anon_func_2 = function(GrabSize, _with_1, parent) -- 150
	local _with_0 = Node() -- 150
	_with_0.size = Size(GrabSize, GrabSize) -- 151
	_with_0:addTo(parent) -- 152
	return _with_0 -- 150
end -- 150
local _anon_func_3 = function(u) -- 155
	local _val_0 = u.decisionTree -- 155
	return not ("AI:PlayerControl" == _val_0 or "AI:NPC" == _val_0) -- 155
end -- 155
_module_0 = function() -- 4
	local Interaction = require("UI.Interaction") -- 5
	local Set = require("Utils").Set -- 6
	local Map = require("Academy.Map") -- 7
	local Store -- 9
	Store = Data.store -- 9
	local Width <const>, Height <const>, GrabSize <const>, Outline <const>, MaxPath <const> = 100, 300, 400, 6, 2 -- 10
	local names <const> = { -- 13
		moling = '默翎', -- 13
		moyu = '默羽', -- 14
		liyena = '李叶那', -- 15
		ayan = '阿岩', -- 16
		villywan = '万薇莉', -- 17
		yuzijiang = '余梓绛', -- 18
		ninilite = '妮妮莉特', -- 19
		wuyun = '乌云', -- 20
		sunborn = '向阳珄' -- 21
	} -- 12
	local moveComs <const> = { -- 25
		"unit", -- 25
		"moveFromRight", -- 26
		"moveRouteName", -- 27
		"moveEnter", -- 28
		"moveTargets" -- 29
	} -- 24
	local defaultFaceLeft = Set({ -- 32
		"liyena", -- 32
		"dataotie" -- 33
	}) -- 31
	do -- 35
		local _with_0 = Observer("Add", moveComs) -- 35
		_with_0:watch(function(self, unit, moveFromRight, moveRouteName, moveEnter, moveTargets) -- 36
			local buttons -- 43
			do -- 43
				local _accum_0 = { } -- 43
				local _len_0 = 1 -- 43
				for _index_0 = 1, #moveTargets do -- 43
					local target = moveTargets[_index_0] -- 43
					_accum_0[_len_0] = { -- 43
						Map.getName(target), -- 43
						target:upper() -- 43
					} -- 43
					_len_0 = _len_0 + 1 -- 43
				end -- 43
				buttons = _accum_0 -- 43
			end -- 43
			local fliped = not moveFromRight -- 44
			local forbidden = moveTargets.empty -- 45
			if forbidden then -- 46
				buttons[#buttons + 1] = { -- 46
					"禁行区域", -- 46
					"FORBIDDEN" -- 46
				} -- 46
			end -- 46
			local _with_1 = Interaction({ -- 47
				text = moveRouteName, -- 47
				buttons = buttons, -- 47
				fliped = fliped -- 47
			}) -- 47
			_with_1.order = unit.world.children.last.order -- 48
			_with_1.transformTarget = unit -- 49
			_with_1:show() -- 50
			if forbidden then -- 51
				_with_1.menu.enabled = false -- 52
			else -- 54
				local name = self.name -- 54
				_with_1:slot("Tapped", function(index) -- 55
					local sceneName = moveTargets[index] -- 56
					local worldClass = require("Scene." .. tostring(sceneName)) -- 57
					return _with_1:schedule(once(function() -- 58
						local startTime = App.runningTime -- 59
						worldClass:loadAsync() -- 60
						local deltaTime = App.runningTime - startTime -- 61
						if deltaTime < 0.5 then -- 62
							sleep(0.5 - deltaTime) -- 63
						end -- 62
						local oldWorld = Store.world -- 64
						local world -- 65
						do -- 65
							local _with_2 = worldClass() -- 65
							_with_2.visible = false -- 66
							_with_2.camera.position = _with_2[moveEnter] -- 67
							if "left" == moveEnter then -- 69
								_with_2:openLeftDoor() -- 69
							elseif "right" == moveEnter then -- 70
								_with_2:openRightDoor() -- 70
							elseif "center" == moveEnter then -- 71
								_with_2:openCenterDoor() -- 71
							end -- 68
							_with_2:addTo(Director.entry) -- 72
							world = _with_2 -- 65
						end -- 65
						Store.world = world -- 73
						Entity({ -- 75
							player = true, -- 75
							name = name, -- 76
							faceRight = _anon_func_0(_with_1, moveEnter, unit), -- 77
							position = assert(world[moveEnter]), -- 81
							base = true -- 82
						}) -- 74
						sleep() -- 98
						world.visible = true -- 99
						return oldWorld:removeFromParent() -- 100
					end)) -- 58
				end) -- 55
			end -- 51
			_with_1:addTo(unit.world) -- 101
			self.interaction = _with_1 -- 47
		end) -- 36
	end -- 35
	do -- 103
		local _with_0 = Observer("Remove", moveComs) -- 103
		_with_0:watch(function(self) -- 104
			local _with_1 = self.interaction -- 105
			if _with_1 ~= nil then -- 105
				_with_1:hide() -- 106
				self.interaction = nil -- 107
			end -- 105
			return _with_1 -- 105
		end) -- 104
	end -- 103
	local _with_0 = Observer("Add", { -- 109
		"player", -- 109
		"name", -- 109
		"position", -- 109
		"faceRight", -- 109
		"base" -- 109
	}) -- 109
	_with_0:watch(function(self, player, name, position, faceRight) -- 110
		local unitDef -- 111
		do -- 111
			local _with_1 = Dictionary() -- 111
			_with_1.linearAcceleration = Vec2(0, -15) -- 112
			_with_1.bodyType = "Dynamic" -- 113
			_with_1.scale = 1.0 -- 114
			_with_1.density = 1.0 -- 115
			_with_1.friction = 1.0 -- 116
			_with_1.restitution = 0.0 -- 117
			_with_1.playable = "spine:" .. tostring(name) -- 118
			_with_1.defaultFaceRight = not defaultFaceLeft[name] -- 119
			_with_1.size = Size(Width, Height) -- 120
			_with_1.sensity = player and 0.0 or 0.5 -- 121
			_with_1.move = 300 -- 122
			_with_1.jump = 800 -- 123
			_with_1.detectDistance = 200 -- 124
			_with_1.attackRange = Size(800, 200) -- 125
			_with_1.hp = 1.0 -- 126
			do -- 127
				local _exp_0 = self.decisionTree -- 127
				if _exp_0 ~= nil then -- 127
					_with_1.decisionTree = _exp_0 -- 127
				else -- 127
					_with_1.decisionTree = player and "AI:PlayerControl" or "AI:NPC" -- 127
				end -- 127
			end -- 127
			_with_1.usePreciseHit = false -- 128
			_with_1.actions = Array({ -- 130
				"hit", -- 130
				"pistol", -- 131
				"idle", -- 132
				"prepare", -- 133
				"turn", -- 134
				"fmove", -- 135
				"bmove", -- 136
				"jump", -- 137
				"fallOff", -- 138
				"cancel", -- 139
				"keepIdle", -- 140
				"keepMove", -- 141
				"idle1" -- 142
			}) -- 129
			unitDef = _with_1 -- 111
		end -- 111
		local world = Store.world -- 143
		local unit -- 144
		do -- 144
			local u = Unit(unitDef, world, self, position + Vec2(0, Height / 2)) -- 144
			u.group = 1 -- 145
			u.faceRight = faceRight -- 146
			u.order = player and 0 or (_anon_func_1(MaxPath, self, u)) -- 147
			do -- 148
				local _with_1 = u.playable -- 148
				local parent = _with_1.parent -- 149
				_with_1:moveToParent(_anon_func_2(GrabSize, _with_1, parent)) -- 150
				_with_1.position = Vec2(GrabSize / 2, GrabSize / 2 - Height / 2) -- 153
			end -- 148
			local isCommonAI = true -- 154
			if _anon_func_3(u) then -- 155
				isCommonAI = false -- 156
				if player then -- 157
					world.camera.followTarget = unit -- 158
				end -- 157
			end -- 155
			world:addShadowTo(u) -- 159
			u:addTo(world) -- 160
			if not isCommonAI then -- 161
				return -- 161
			end -- 161
			unit = u -- 144
		end -- 144
		if player then -- 162
			unit:gslot("Skill.Began", function() -- 163
				self.keySkill = true -- 163
			end) -- 163
			unit:gslot("Skill.Ended", function() -- 164
				self.keySkill = false -- 164
			end) -- 164
			do -- 165
				local _with_1 = world.camera -- 165
				_with_1.followTarget = unit -- 166
			end -- 165
			local _with_1 = unit.playable.parent -- 167
			local sensor = unit:getSensorByTag(Unit.DetectSensorTag) -- 168
			_with_1:schedule(function() -- 169
				local target = nil -- 170
				local minDictance = nil -- 171
				if unit.entity.busy then -- 172
					return -- 172
				end -- 172
				local _list_0 = sensor.sensedBodies -- 173
				for _index_0 = 1, #_list_0 do -- 173
					local body = _list_0[_index_0] -- 173
					local entity = body.entity -- 174
					if not entity then -- 175
						goto _continue_0 -- 175
					end -- 175
					if body.decisionTree ~= "AI:NPC" then -- 176
						goto _continue_0 -- 176
					end -- 176
					if not (entity.player ~= nil) then -- 177
						goto _continue_0 -- 177
					end -- 177
					if body == unit then -- 178
						goto _continue_0 -- 178
					end -- 178
					if entity.busy then -- 179
						goto _continue_0 -- 179
					end -- 179
					local posA, zA = body:convertToWorldSpace(Vec2.zero, 0) -- 180
					local posB, zB = unit:convertToWorldSpace(Vec2.zero, 0) -- 181
					local dx, dy, dz = posA.x - posB.x, posA.y - posB.y, zA - zB -- 182
					local distance = dx * dx + dy * dy + dz * dz -- 183
					if not minDictance or minDictance > distance then -- 184
						minDictance = distance -- 185
						target = body -- 186
					end -- 184
					::_continue_0:: -- 174
				end -- 173
				local oldTarget = self.target -- 187
				if oldTarget ~= target then -- 188
					if oldTarget then -- 189
						do -- 190
							local _with_2 = oldTarget.entity.interaction -- 190
							if _with_2 ~= nil then -- 190
								_with_2:hide() -- 191
								oldTarget.entity.interaction = nil -- 192
							end -- 190
						end -- 190
						local playable = oldTarget.playable -- 193
						playable:schedule(once(function() -- 194
							do -- 195
								local _with_2 = playable.parent:grab() -- 195
								local color = Color(0x007ec0f8) -- 196
								_with_2.effect:get(1):set("u_linecolor", color) -- 197
								cycle(0.3, function(dt) -- 198
									color.opacity = 1.0 - dt -- 199
									return _with_2.effect:get(1):set("u_linecolor", color) -- 200
								end) -- 198
							end -- 195
							return playable.parent:grab(false) -- 201
						end)) -- 194
					end -- 189
					self.target = target -- 202
					if target then -- 203
						do -- 204
							local _with_2 = target.playable.parent:grab() -- 204
							local _with_3 = SpriteEffect("builtin:vs_sprite", "builtin:fs_spriteoutlinecolor") -- 205
							local color = Color(0x007ec0f8) -- 206
							_with_3:get(1):set("u_linecolor", color) -- 207
							target.playable:schedule(once(function() -- 208
								return cycle(0.3, function(dt) -- 209
									color.opacity = dt -- 210
									return _with_3:get(1):set("u_linecolor", color) -- 211
								end) -- 209
							end)) -- 208
							_with_3:get(1):set("u_lineoffset", Outline, Outline, 0.1) -- 212
							_with_2.effect = _with_3 -- 205
						end -- 204
						local nameText -- 213
						do -- 213
							local _exp_0 = names[target.entity.name] -- 213
							if _exp_0 ~= nil then -- 213
								nameText = _exp_0 -- 213
							else -- 213
								nameText = "人物" -- 213
							end -- 213
						end -- 213
						local ui = Interaction({ -- 214
							text = nameText, -- 214
							buttons = { -- 215
								{ -- 215
									"对话", -- 215
									"TALK" -- 215
								}, -- 215
								{ -- 216
									"进行训练", -- 216
									"TRAINING" -- 216
								}, -- 216
								{ -- 217
									"个人信息", -- 217
									"INFORMATION" -- 217
								} -- 217
							}, -- 214
							fliped = target.x < unit.x -- 218
						}) -- 214
						ui.order = world.children.last.order -- 219
						ui.transformTarget = target -- 220
						ui:slot("Tapped", function(index) -- 221
							if 1 == index then -- 223
								return ui:schedule(once(function() -- 223
									local startTime = App.runningTime -- 224
									local deltaTime = App.runningTime - startTime -- 225
									if deltaTime < 0.5 then -- 226
										sleep(0.5 - deltaTime) -- 227
									end -- 226
									ui:hide(false) -- 228
									local Story = require("UI.Story") -- 229
									return Director.ui:addChild((function() -- 230
										local _with_2 = Story() -- 230
										_with_2:slot("Hide", function() -- 231
											return ui:show() -- 231
										end) -- 231
										return _with_2 -- 230
									end)()) -- 230
								end)) -- 223
							end -- 222
						end) -- 221
						ui:addTo(world) -- 232
						ui:show() -- 233
						target.entity.interaction = ui -- 214
					end -- 203
				end -- 188
			end) -- 169
			return _with_1 -- 167
		end -- 162
	end) -- 110
	return _with_0 -- 109
end -- 4
return _module_0 -- 1
