-- [tsx]: Action.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 1
local cycle = ____Dora.cycle -- 1
local Ease = ____Dora.Ease -- 1
local Node = ____Dora.Node -- 1
local once = ____Dora.once -- 1
local Opacity = ____Dora.Opacity -- 1
local sleep = ____Dora.sleep -- 1
local Spine = ____Dora.Spine -- 1
local tolua = ____Dora.tolua -- 1
local Vec2 = ____Dora.Vec2 -- 1
local ____Platformer = require("Platformer") -- 2
local Unit = ____Platformer.Unit -- 2
local UnitAction = ____Platformer.UnitAction -- 2
local Data = ____Platformer.Data -- 2
local BulletDef = ____Platformer.BulletDef -- 2
local Face = ____Platformer.Face -- 2
local Bullet = ____Platformer.Bullet -- 2
local TargetAllow = ____Platformer.TargetAllow -- 2
local ____DoraX = require("DoraX") -- 3
local React = ____DoraX.React -- 3
local toNode = ____DoraX.toNode -- 3
local Rectangle = require("UI.View.Shape.Rectangle") -- 4
local ____LightStrip = require("Tutorial.LightStrip") -- 5
local LightStrip = ____LightStrip.LightStrip -- 5
function ____exports.default() -- 7
	UnitAction:add( -- 8
		"bmove", -- 8
		{ -- 8
			priority = 1, -- 9
			reaction = 2, -- 10
			recovery = 0.2, -- 11
			available = function(owner) return owner.onSurface end, -- 12
			create = function(owner) -- 13
				local playable = owner.playable -- 14
				playable:play("bmove", true) -- 15
				return function(owner, action) -- 16
					local ____action_0 = action -- 17
					local elapsedTime = ____action_0.elapsedTime -- 17
					local recovery = ____action_0.recovery -- 17
					local move = owner.unitDef.move -- 18
					local moveSpeed = 1 -- 19
					if elapsedTime < recovery then -- 19
						moveSpeed = math.min(elapsedTime / recovery, 1) -- 21
					end -- 21
					owner.velocityX = moveSpeed * (owner.faceRight and -move or move) * 0.5 -- 23
					return not owner.onSurface -- 24
				end -- 16
			end -- 13
		} -- 13
	) -- 13
	UnitAction:add( -- 29
		"fmove", -- 29
		{ -- 29
			priority = 1, -- 30
			reaction = 2, -- 31
			recovery = 0.2, -- 32
			available = function(owner) return owner.onSurface end, -- 33
			create = function(owner) -- 34
				local playable = owner.playable -- 35
				playable:play("fmove", true) -- 36
				return function(owner, action) -- 37
					local ____action_1 = action -- 38
					local elapsedTime = ____action_1.elapsedTime -- 38
					local recovery = ____action_1.recovery -- 38
					local move = owner.unitDef.move -- 39
					local moveSpeed = 1 -- 40
					if elapsedTime < recovery then -- 40
						moveSpeed = math.min(elapsedTime / recovery, 1) -- 42
					end -- 42
					owner.velocityX = moveSpeed * (owner.faceRight and move or -move) -- 44
					return not owner.onSurface -- 45
				end -- 37
			end -- 34
		} -- 34
	) -- 34
	UnitAction:add( -- 50
		"prepare", -- 50
		{ -- 50
			priority = 1, -- 51
			reaction = 2, -- 52
			recovery = 0.2, -- 53
			available = function(owner) return owner.onSurface end, -- 54
			create = function(owner) -- 55
				local playable = owner.playable -- 56
				repeat -- 56
					local ____switch13 = playable.lastCompleted -- 56
					local ____cond13 = ____switch13 == "pistol" or ____switch13 == "laser" or ____switch13 == "hit" -- 56
					if ____cond13 then -- 56
						playable.recovery = 0 -- 61
						break -- 62
					end -- 62
				until true -- 62
				playable:play("prepare", true) -- 64
				return function() return not owner.onSurface end -- 65
			end -- 55
		} -- 55
	) -- 55
	UnitAction:add( -- 69
		"idle", -- 69
		{ -- 69
			priority = 1, -- 70
			reaction = 2, -- 71
			recovery = 0.2, -- 72
			create = function(owner) -- 73
				local playable = owner.playable -- 74
				playable:play("idle", true) -- 75
				local playIdleSpecial = coroutine.create(function() -- 76
					while true do -- 76
						sleep(3) -- 78
						sleep(playable:play("idle1")) -- 79
						playable:play("idle", true) -- 80
					end -- 80
				end) -- 76
				owner.data.playIdleSpecial = playIdleSpecial -- 83
				return function() -- 84
					coroutine.resume(playIdleSpecial) -- 85
					return not owner.onSurface -- 86
				end -- 84
			end -- 73
		} -- 73
	) -- 73
	UnitAction:add( -- 91
		"laser", -- 91
		{ -- 91
			priority = 3, -- 92
			reaction = 3, -- 93
			recovery = 0.2, -- 94
			queued = true, -- 95
			create = function(owner) return once(function() -- 96
				owner.playable:slot("attack"):set(function() -- 97
					local bulletDef = BulletDef() -- 98
					bulletDef.lifeTime = 10 -- 99
					bulletDef.damageRadius = 0 -- 100
					bulletDef.highSpeedFix = true -- 101
					bulletDef.gravity = Vec2.zero -- 102
					bulletDef.face = Face(function() -- 103
						return Rectangle({width = 10, height = 10, borderColor = 4294901896, fillColor = 1727987848}) -- 104
					end) -- 103
					bulletDef:setAsCircle(10) -- 111
					bulletDef:setVelocity(0, 5000) -- 112
					local bullet = Bullet(bulletDef, owner) -- 113
					local targetAllow = TargetAllow() -- 114
					targetAllow:allow("Enemy", true) -- 115
					targetAllow.terrainAllowed = true -- 116
					bullet.angle = 0 -- 117
					bullet.targetAllow = targetAllow:toValue() -- 118
					bullet:slot( -- 119
						"HitTarget", -- 119
						function(bullet, target, pos) -- 119
							local entity = target.entity -- 120
							target.data.hitFromRight = bullet.velocityX < 0 -- 121
							entity.ap = entity.ap - 100 -- 122
							bullet.hitStop = true -- 123
						end -- 119
					) -- 119
					bullet:addTo(owner.world, owner.order) -- 125
					local pistol = owner.playable:getSlot("pistol") -- 126
					if pistol then -- 126
						local worldPos = pistol:convertToWorldSpace(Vec2(300, 0)) -- 128
						local ____opt_2 = owner.parent -- 128
						local pos = ____opt_2 and ____opt_2:convertToNodeSpace(worldPos) -- 129
						if pos then -- 129
							bullet.position = pos -- 130
						end -- 130
					end -- 130
					LightStrip(bullet.position, bullet, 3431841523) -- 132
				end) -- 97
				owner.playable.recovery = 0.2 -- 134
				sleep(owner.playable:play("pistol")) -- 135
				return true -- 136
			end) end -- 96
		} -- 96
	) -- 96
	UnitAction:add( -- 140
		"kinetic", -- 140
		{ -- 140
			priority = 3, -- 141
			reaction = 3, -- 142
			recovery = 0.2, -- 143
			queued = true, -- 144
			create = function(owner) return once(function() -- 145
				owner.playable:slot("attack"):set(function() -- 146
					local ____owner_data_aimAngle_4 = owner.data.aimAngle -- 147
					if ____owner_data_aimAngle_4 == nil then -- 147
						____owner_data_aimAngle_4 = 0 -- 147
					end -- 147
					local aimAngle = ____owner_data_aimAngle_4 -- 147
					local bulletDef = BulletDef() -- 148
					bulletDef.lifeTime = 10 -- 149
					bulletDef.damageRadius = 0 -- 150
					bulletDef.highSpeedFix = true -- 151
					bulletDef.gravity = Vec2.zero -- 152
					bulletDef.face = Face(function() -- 153
						local spine = Spine("Spine/kineticgun") -- 154
						if spine then -- 154
							local node = Node() -- 156
							node:addChild(spine) -- 157
							spine.angle = owner.faceRight and aimAngle or 180 - aimAngle -- 158
							spine.scaleX = 0.5 -- 159
							spine.scaleY = 0.5 -- 160
							spine.look = "PTbullet" -- 161
							return node -- 162
						end -- 162
						return Node() -- 164
					end) -- 153
					bulletDef:setAsCircle(10) -- 166
					bulletDef:setVelocity(-aimAngle, 5000) -- 167
					local bullet = Bullet(bulletDef, owner) -- 168
					local targetAllow = TargetAllow() -- 169
					targetAllow:allow("Enemy", true) -- 170
					targetAllow.terrainAllowed = true -- 171
					bullet.targetAllow = targetAllow:toValue() -- 172
					bullet:slot( -- 173
						"HitTarget", -- 173
						function(bullet, target, pos, normal) -- 173
							local entity = target.entity -- 174
							target.data.hitFromRight = bullet.velocityX < 0 -- 175
							entity.hp = entity.hp - 1 -- 176
							if target:isDoing("dizzy") then -- 176
								bullet.hitStop = true -- 178
							else -- 178
								bullet.hitStop = false -- 180
								local ____bullet_5 = bullet -- 181
								local velocity = ____bullet_5.velocity -- 181
								local proj = velocity:dot(normal) -- 182
								local reflection = velocity:sub(normal:mul(2 * proj)) -- 183
								bullet:emit("StopStrip") -- 184
								bullet.velocity = reflection -- 185
								LightStrip( -- 186
									bullet.position:sub(Vec2(5, 5)), -- 186
									bullet, -- 186
									1728053247 -- 186
								) -- 186
							end -- 186
						end -- 173
					) -- 173
					bullet:addTo(owner.world, owner.order) -- 189
					local pistol = owner.playable:getSlot("pistol") -- 190
					if pistol then -- 190
						local worldPos = pistol:convertToWorldSpace(Vec2(300, 0)) -- 192
						local ____opt_6 = owner.parent -- 192
						local pos = ____opt_6 and ____opt_6:convertToNodeSpace(worldPos) -- 193
						if pos then -- 193
							bullet.position = pos -- 194
						end -- 194
						worldPos = pistol:convertToWorldSpace(Vec2.zero) -- 195
						local ____opt_8 = owner.parent -- 195
						pos = ____opt_8 and ____opt_8:convertToNodeSpace(worldPos) or Vec2.zero -- 196
						local casing = toNode(React.createElement( -- 197
							"body", -- 197
							{ -- 197
								type = "Dynamic", -- 197
								x = pos.x, -- 197
								y = pos.y, -- 197
								world = owner.world, -- 197
								group = Data.groupHide, -- 197
								linearAcceleration = Vec2(0, -9.8), -- 197
								velocityX = (math.random() + 1) * (owner.faceRight and -200 or 200), -- 197
								velocityY = (math.random() + 1) * 300, -- 197
								angle = math.random() * aimAngle -- 197
							}, -- 197
							React.createElement("rect-fixture", { -- 197
								width = 20, -- 197
								height = 10, -- 197
								density = 26, -- 197
								friction = 0.4, -- 197
								restitution = 0.4 -- 197
							}), -- 197
							React.createElement("spine", {file = "Spine/kineticgun", look = "PTcasing", scaleX = 0.5, scaleY = 0.5}) -- 197
						)) -- 197
						if casing then -- 197
							casing:schedule(once(function() -- 211
								sleep(10) -- 212
								sleep(casing:perform(Opacity(0.5, 1, 0))) -- 213
								casing:removeFromParent() -- 214
							end)) -- 211
							casing:addTo(owner.world, owner.order) -- 216
						end -- 216
					end -- 216
					LightStrip(bullet.position, bullet, 3439329279) -- 219
					local playable = tolua.cast(owner.playable, "Spine") -- 220
					if playable then -- 220
						playable:schedule(once(function() -- 222
							sleep(0.2) -- 223
							cycle( -- 224
								0.2, -- 224
								function(time) -- 224
									local angle = -(1 - Ease:func(Ease.OutSine, time)) * aimAngle -- 225
									owner.data.aimAngle = angle -- 226
									playable:setBoneRotation("aim", angle) -- 227
								end -- 224
							) -- 224
						end)) -- 222
					end -- 222
				end) -- 146
				local aim = owner:getChildByTag("aim") -- 232
				local playable = tolua.cast(owner.playable, "Spine") -- 233
				if aim and playable then -- 233
					local angle = aim.angle -- 235
					playable:schedule(once(function() -- 236
						local fix = owner.faceRight and 1 or -1 -- 237
						cycle( -- 238
							0.2, -- 238
							function(time) -- 238
								local aimAngle = -Ease:func(Ease.OutSine, time) * fix * angle -- 239
								owner.data.aimAngle = -aimAngle -- 240
								playable:setBoneRotation("aim", aimAngle) -- 241
							end -- 238
						) -- 238
					end)) -- 236
				end -- 236
				sleep(owner.playable:play("pistol")) -- 245
				return true -- 246
			end) end, -- 145
			stop = function(owner) -- 248
				local aimAngle = owner.data.aimAngle -- 249
				if aimAngle then -- 249
					local playable = tolua.cast(owner.playable, "Spine") -- 251
					if playable then -- 251
						playable:schedule(once(function() -- 253
							cycle( -- 254
								0.2, -- 254
								function(time) -- 254
									playable:setBoneRotation( -- 255
										"aim", -- 255
										-(1 - Ease:func(Ease.OutSine, time)) * aimAngle -- 255
									) -- 255
								end -- 254
							) -- 254
						end)) -- 253
					end -- 253
				end -- 253
			end -- 248
		} -- 248
	) -- 248
	UnitAction:add( -- 263
		"hit", -- 263
		{ -- 263
			priority = 99, -- 264
			reaction = 3, -- 265
			recovery = 0.2, -- 266
			create = function(owner) return once(function() -- 267
				sleep(owner.playable:play("hit")) -- 268
				return true -- 269
			end) end -- 267
		} -- 267
	) -- 267
	UnitAction:add( -- 273
		"dizzy", -- 273
		{ -- 273
			priority = 99, -- 274
			reaction = 3, -- 275
			recovery = 0.2, -- 276
			create = function(owner) -- 277
				owner.playable:play("dizzy", true) -- 278
				return function() return false end -- 279
			end -- 277
		} -- 277
	) -- 277
	UnitAction:add( -- 283
		"lose", -- 283
		{ -- 283
			priority = 99, -- 284
			reaction = 3, -- 285
			recovery = 0.2, -- 286
			create = function(owner) return once(function() -- 287
				local time = owner.playable:play("lose") -- 288
				sleep(time - 0.05) -- 289
				owner.playable.speed = 0 -- 290
				return true -- 291
			end) end -- 287
		} -- 287
	) -- 287
	UnitAction:add( -- 295
		"blow", -- 295
		{ -- 295
			reaction = 3, -- 296
			recovery = 0.2, -- 297
			priority = 3, -- 298
			queued = true, -- 299
			create = function(owner) -- 300
				owner.playable:slot("attack"):set(function() -- 301
					local senser = owner:getSensorByTag(Unit.AttackSensorTag) -- 302
					senser.sensedBodies:each(function(item) -- 303
						local unit = tolua.cast(item, "Platformer::Unit") -- 304
						if unit and Data:isEnemy(unit.group, owner.group) and unit.x >= owner.x == owner.faceRight then -- 304
							unit:applyLinearImpulse( -- 306
								Vec2(unit.x < owner.x and -500 or 500, 0), -- 306
								Vec2.zero -- 306
							) -- 306
							unit:start("cancal") -- 307
							if unit.x < owner.x and not unit.faceRight then -- 307
								unit:start("turn") -- 309
							end -- 309
							unit:start("hit") -- 311
						end -- 311
						return false -- 313
					end) -- 303
				end) -- 301
				return once(function() -- 316
					sleep(owner.playable:play("blow")) -- 317
					return true -- 318
				end) -- 316
			end -- 300
		} -- 300
	) -- 300
	UnitAction:add( -- 323
		"fallOff", -- 323
		{ -- 323
			priority = 2, -- 324
			reaction = -1, -- 325
			recovery = 0.3, -- 326
			queued = true, -- 327
			available = function(owner) return not owner.onSurface end, -- 328
			create = function(owner) -- 329
				local playable = owner.playable -- 330
				if playable.current ~= "jumping" then -- 330
					playable:play("jumping", true) -- 332
				end -- 332
				return once(function() -- 334
					while true do -- 334
						if owner.onSurface then -- 334
							sleep(playable:play("landing", false)) -- 337
							coroutine.yield(true) -- 338
						else -- 338
							coroutine.yield(false) -- 340
						end -- 340
					end -- 340
				end) -- 334
			end -- 329
		} -- 329
	) -- 329
end -- 329
return ____exports -- 329