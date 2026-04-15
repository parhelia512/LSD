-- [yue]: Test/SpineTest.yue
local _ENV = Dora(Dora.Platformer, Dora.Platformer.Decision, Dora.ImGui) -- 1
local Path <const> = Path -- 6
local Content <const> = Content -- 6
local require <const> = require -- 6
local Director <const> = Director -- 6
local Data <const> = Data -- 6
local UnitAction <const> = UnitAction -- 6
local once <const> = once -- 6
local sleep <const> = sleep -- 6
local cycle <const> = cycle -- 6
local math <const> = math -- 6
local coroutine <const> = coroutine -- 6
local Vec2 <const> = Vec2 -- 6
local Sel <const> = Sel -- 6
local Seq <const> = Seq -- 6
local Con <const> = Con -- 6
local AI <const> = AI -- 6
local Act <const> = Act -- 6
local Reject <const> = Reject -- 6
local tostring <const> = tostring -- 6
local Group <const> = Group -- 6
local Entity <const> = Entity -- 6
local Spine <const> = Spine -- 6
local pairs <const> = pairs -- 6
local Dictionary <const> = Dictionary -- 6
local Size <const> = Size -- 6
local Array <const> = Array -- 6
local table <const> = table -- 6
local Unit <const> = Unit -- 6
local Node <const> = Node -- 6
local Sprite <const> = Sprite -- 6
local App <const> = App -- 6
local SetNextWindowPos <const> = SetNextWindowPos -- 6
local SetNextWindowSize <const> = SetNextWindowSize -- 6
local Begin <const> = Begin -- 6
local Combo <const> = Combo -- 6
local Checkbox <const> = Checkbox -- 6
local ipairs <const> = ipairs -- 6
local Button <const> = Button -- 6
local SameLine <const> = SameLine -- 6
local Text <const> = Text -- 6
do -- 8
	local scriptPath = Path:getScriptPath(...) -- 8
	if scriptPath then -- 8
		scriptPath = Path:getPath(scriptPath) -- 9
		local _list_0 = { -- 11
			scriptPath, -- 11
			Path(scriptPath, "Script"), -- 12
			Path(scriptPath, "Spine"), -- 13
			Path(scriptPath, "Image"), -- 14
			Path(scriptPath, "Font") -- 15
		} -- 10
		for _index_0 = 1, #_list_0 do -- 10
			local path = _list_0[_index_0] -- 10
			Content:insertSearchPath(1, path) -- 17
		end -- 10
	else -- 18
		return -- 18
	end -- 8
end -- 8
require("Control") -- 20
local Set = require("Utils").Set -- 21
local HUDControl = require("UI.HUDControl") -- 22
Director.ui3D:addChild(HUDControl()) -- 24
local Store = Data.store -- 26
UnitAction:add("fall", { -- 29
	priority = 10, -- 29
	reaction = 3, -- 30
	recovery = 0.1, -- 31
	queued = true, -- 32
	available = function() -- 33
		return true -- 33
	end, -- 33
	create = function(self) -- 34
		return once(function() -- 34
			local _with_0 = self.playable -- 34
			_with_0.speed = 1 -- 35
			sleep(_with_0:play("fall")) -- 36
			sleep(0.1) -- 37
			_with_0.recovery = 0 -- 38
			sleep(_with_0:play("standUp")) -- 39
			return _with_0 -- 34
		end) -- 34
	end -- 34
}) -- 28
UnitAction:add("evade", { -- 42
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
			time = _with_0:play("bstep") -- 51
		end -- 49
		return once(function(self) -- 52
			local dir = self.faceRight and -1 or 1 -- 53
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
UnitAction:add("rush", { -- 63
	priority = 10, -- 63
	reaction = 10, -- 64
	recovery = 0, -- 65
	queued = true, -- 66
	available = function() -- 67
		return true -- 67
	end, -- 67
	create = function(self) -- 68
		local time = 0 -- 69
		do -- 70
			local _with_0 = self.playable -- 70
			_with_0.speed = 1.0 -- 71
			time = _with_0:play("fstep") -- 72
		end -- 70
		return once(function(self) -- 73
			local dir = self.faceRight and 1 or -1 -- 74
			cycle(math.max(time, 0.4), function() -- 75
				self.velocityX = 800 * dir -- 75
			end) -- 75
			do -- 76
				local _with_0 = self.playable -- 76
				_with_0.recovery = 0.3 -- 77
				_with_0.speed = 1.0 -- 78
				_with_0:play("idle") -- 79
			end -- 76
			sleep(0.3) -- 80
			return true -- 81
		end) -- 73
	end -- 68
}) -- 62
local pistolEnd -- 83
pistolEnd = function(name, playable) -- 83
	if name == "pistol" then -- 83
		return playable.parent.parent:stop() -- 84
	end -- 83
end -- 83
UnitAction:add("pistol", { -- 87
	priority = 3, -- 87
	reaction = 3, -- 88
	recovery = 0.2, -- 89
	queued = true, -- 90
	available = function() -- 91
		return true -- 91
	end, -- 91
	create = function(self) -- 92
		do -- 93
			local _with_0 = self.playable -- 93
			_with_0.speed = 1 -- 94
			_with_0:play("pistol") -- 95
			_with_0:slot("AnimationEnd", pistolEnd) -- 96
		end -- 93
		return function() -- 97
			return false -- 97
		end -- 97
	end, -- 92
	stop = function(self) -- 98
		return self.playable:slot("AnimationEnd"):remove(pistolEnd) -- 99
	end -- 98
}) -- 86
local testEnd -- 101
testEnd = function(name, playable) -- 101
	if name == Store.testAction then -- 101
		return playable.parent.parent:stop() -- 102
	end -- 101
end -- 101
UnitAction:add("test", { -- 105
	priority = 3, -- 105
	reaction = 3, -- 106
	recovery = 0.1, -- 107
	queued = true, -- 108
	available = function() -- 109
		return true -- 109
	end, -- 109
	create = function(self) -- 110
		do -- 111
			local _with_0 = self.playable -- 111
			_with_0.speed = 1 -- 112
			_with_0:play(Store.testAction) -- 113
			_with_0:slot("AnimationEnd", testEnd) -- 114
		end -- 111
		return function() -- 115
			return false -- 115
		end -- 115
	end, -- 110
	stop = function(self) -- 116
		return self.playable:slot("AnimationEnd"):remove(testEnd) -- 117
	end -- 116
}) -- 104
UnitAction:add("idle", { -- 120
	priority = 1, -- 120
	reaction = 2.0, -- 121
	recovery = 0.2, -- 122
	available = function(self) -- 123
		return self.onSurface -- 123
	end, -- 123
	create = function(self) -- 124
		local _with_0 = self.playable -- 124
		_with_0.speed = 1.0 -- 125
		if Store.battle then -- 126
			do -- 127
				local _exp_0 = _with_0.lastCompleted -- 127
				if "melee" == _exp_0 or "pistol" == _exp_0 or "bow" == _exp_0 or "gun1" == _exp_0 or "gun2" == _exp_0 or "gun3" == _exp_0 or "throw" == _exp_0 or "parry" == _exp_0 or "defense" == _exp_0 or "comp" == _exp_0 or "comm" == _exp_0 then -- 128
					_with_0.recovery = 0.0 -- 129
				end -- 127
			end -- 127
			_with_0:play("prepare", true) -- 130
			return function(self) -- 131
				return not self.onSurface -- 131
			end -- 131
		else -- 133
			_with_0:play("idle", true) -- 133
			local playIdleSpecial = coroutine.create(function() -- 134
				while true do -- 134
					sleep(3) -- 135
					sleep(_with_0:play("idle1")) -- 136
					_with_0:play("idle", true) -- 137
				end -- 134
			end) -- 134
			self.data.playIdleSpecial = playIdleSpecial -- 138
			return function(self) -- 139
				coroutine.resume(playIdleSpecial) -- 140
				return not self.onSurface -- 141
			end -- 139
		end -- 126
		return _with_0 -- 124
	end -- 124
}) -- 119
UnitAction:add("fmove", { -- 144
	priority = 1, -- 144
	reaction = 2.0, -- 145
	recovery = 0.2, -- 146
	available = function(self) -- 147
		return self.onSurface -- 147
	end, -- 147
	create = function(self) -- 148
		do -- 149
			local _with_0 = self.playable -- 149
			_with_0.speed = 1 -- 150
			local duration = _with_0:play("fmove", true) -- 151
			if duration == 0 then -- 152
				_with_0:play("move", true) -- 153
			end -- 152
		end -- 149
		return function(self, action) -- 154
			local elapsedTime, recovery = action.elapsedTime, action.recovery -- 155
			local move = self.unitDef.move -- 156
			local moveSpeed -- 157
			if elapsedTime < recovery then -- 157
				moveSpeed = math.min(elapsedTime / recovery, 1.0) -- 158
			else -- 160
				moveSpeed = 1.0 -- 160
			end -- 157
			self.velocityX = moveSpeed * (self.faceRight and move or -move) -- 161
			return not self.onSurface -- 162
		end -- 154
	end -- 148
}) -- 143
UnitAction:add("keepIdle", { -- 165
	priority = 100, -- 165
	reaction = 2.0, -- 166
	recovery = 0.2, -- 167
	available = function() -- 168
		return true -- 168
	end, -- 168
	create = function(self) -- 169
		do -- 170
			local _with_0 = self.playable -- 170
			_with_0.speed = 1 -- 171
			_with_0:play("idle", true) -- 172
		end -- 170
		return function() -- 173
			return false -- 173
		end -- 173
	end -- 169
}) -- 164
UnitAction:add("idle1", { -- 176
	priority = 1, -- 176
	reaction = 2.0, -- 177
	recovery = 0.2, -- 178
	available = function() -- 179
		return true -- 179
	end, -- 179
	queued = true, -- 180
	create = function(self) -- 181
		return once(function() -- 181
			local _with_0 = self.playable -- 182
			_with_0.speed = 1 -- 183
			sleep(_with_0:play("idle1", false)) -- 184
			return _with_0 -- 182
		end) -- 181
	end -- 181
}) -- 175
UnitAction:add("keepMove", { -- 187
	priority = 100, -- 187
	reaction = 2.0, -- 188
	recovery = 0.2, -- 189
	available = function() -- 190
		return true -- 190
	end, -- 190
	create = function(self) -- 191
		do -- 192
			local _with_0 = self.playable -- 192
			_with_0.speed = 1 -- 193
			_with_0:play("fmove", true) -- 194
		end -- 192
		return function() -- 195
			return false -- 195
		end -- 195
	end -- 191
}) -- 186
UnitAction:add("bmove", { -- 198
	priority = 1, -- 198
	reaction = 2.0, -- 199
	recovery = 0.2, -- 200
	available = function(self) -- 201
		return self.onSurface -- 201
	end, -- 201
	create = function(self) -- 202
		do -- 203
			local _with_0 = self.playable -- 203
			_with_0.speed = 1 -- 204
			_with_0:play("bmove", true) -- 205
		end -- 203
		return function(self, action) -- 206
			local elapsedTime, recovery = action.elapsedTime, action.recovery -- 207
			local move = self.unitDef.move -- 208
			local moveSpeed -- 209
			if elapsedTime < recovery then -- 209
				moveSpeed = math.min(elapsedTime / recovery, 1.0) -- 210
			else -- 212
				moveSpeed = 1.0 -- 212
			end -- 209
			self.velocityX = moveSpeed * (self.faceRight and -move or move) * 0.5 -- 213
			return not self.onSurface -- 214
		end -- 206
	end -- 202
}) -- 197
UnitAction:add("jump", { -- 217
	priority = 3, -- 217
	reaction = 2.0, -- 218
	recovery = 0.1, -- 219
	queued = true, -- 220
	available = function(self) -- 221
		return self.onSurface -- 221
	end, -- 221
	create = function(self) -- 222
		local velocityX = self.velocityX -- 223
		local jump = self.unitDef.jump -- 224
		self.velocity = Vec2(velocityX, jump) -- 225
		return once(function(self, _action) -- 226
			local _with_0 = self.playable -- 227
			_with_0.speed = 1 -- 228
			sleep(_with_0:play("jump", false)) -- 229
			return _with_0 -- 227
		end) -- 226
	end -- 222
}) -- 216
UnitAction:add("fallOff", { -- 232
	priority = 2, -- 232
	reaction = -1, -- 233
	recovery = 0.3, -- 234
	available = function(self) -- 235
		return not self.onSurface -- 235
	end, -- 235
	create = function(self) -- 236
		if self.playable.current ~= "jumping" then -- 237
			local _with_0 = self.playable -- 238
			_with_0.speed = 1 -- 239
			_with_0:play("jumping", true) -- 240
		end -- 237
		return once(function(self, _action) -- 241
			while true do -- 242
				if self.onSurface then -- 243
					do -- 244
						local _with_0 = self.playable -- 244
						_with_0.speed = 1 -- 245
						sleep(_with_0:play("landing", false)) -- 246
					end -- 244
					coroutine.yield(true) -- 247
				else -- 249
					coroutine.yield(false) -- 249
				end -- 243
			end -- 242
		end) -- 241
	end -- 236
}) -- 231
Store["AI:NPC"] = Sel({ -- 252
	Seq({ -- 253
		Con("not facing nearest unit", function(self) -- 253
			local _list_0 = AI:getDetectedUnits() -- 254
			for _index_0 = 1, #_list_0 do -- 254
				local unit = _list_0[_index_0] -- 254
				if unit.entity.player then -- 255
					return (self.x > unit.x) == self.faceRight -- 256
				end -- 255
			end -- 254
			local unit = AI:getNearestUnit("Any") -- 257
			if unit then -- 257
				return (self.x > unit.x) == self.faceRight -- 258
			else -- 260
				return false -- 260
			end -- 257
		end), -- 253
		Act("turn") -- 261
	}), -- 252
	Act("idle") -- 263
}) -- 251
Store["AI:PlayerControl"] = Sel({ -- 267
	Seq({ -- 268
		Sel({ -- 269
			Seq({ -- 270
				Con("fmove key down", function(self) -- 270
					return not (self.entity.keyLeft and self.entity.keyRight) and ((self.entity.keyLeft and self.faceRight) or (self.entity.keyRight and not self.faceRight)) -- 271
				end), -- 270
				Act("turn") -- 276
			}), -- 269
			Seq({ -- 279
				Con("bmove key down", function(self) -- 279
					return not (self.entity.keyLeft or self.entity.keyRight) and not (self.entity.keyBLeft and self.entity.keyBRight) and ((self.entity.keyBLeft and not self.faceRight) or (self.entity.keyBRight and self.faceRight)) -- 280
				end), -- 279
				Act("turn") -- 286
			}) -- 278
		}), -- 268
		Reject() -- 289
	}), -- 267
	Seq({ -- 292
		Con("pistol", function(self) -- 292
			return self.entity.keyShoot -- 292
		end), -- 292
		Act("pistol") -- 293
	}), -- 291
	Seq({ -- 296
		Con("evade", function(self) -- 296
			return self.entity.keyEvade -- 296
		end), -- 296
		Act("evade") -- 297
	}), -- 295
	Seq({ -- 300
		Con("rush", function(self) -- 300
			return self.entity.keyRush -- 300
		end), -- 300
		Act("rush") -- 301
	}), -- 299
	Seq({ -- 304
		Con("fall", function(self) -- 304
			return self.entity.keyFall -- 304
		end), -- 304
		Act("fall") -- 305
	}), -- 303
	Sel({ -- 308
		Seq({ -- 309
			Con("is falling", function(self) -- 309
				return not self.onSurface -- 309
			end), -- 309
			Act("fallOff") -- 310
		}), -- 308
		Seq({ -- 313
			Con("jump key down", function(self) -- 313
				return self.entity.keyUp -- 313
			end), -- 313
			Act("jump") -- 314
		}) -- 312
	}), -- 307
	Seq({ -- 318
		Con("fmove key down", function(self) -- 318
			return self.entity.keyLeft or self.entity.keyRight -- 318
		end), -- 318
		Act("fmove") -- 319
	}), -- 317
	Seq({ -- 322
		Con("bmove key down", function(self) -- 322
			return self.entity.keyBLeft or self.entity.keyBRight -- 322
		end), -- 322
		Act("bmove") -- 323
	}), -- 321
	Act("idle") -- 325
}) -- 266
Store.battle = false -- 328
local unit = nil -- 330
local playable = nil -- 331
local targetAnims = Set({ -- 334
	"bmove", -- 334
	"bow", -- 335
	"bstep", -- 336
	"comm", -- 337
	"comp", -- 338
	"defence", -- 339
	"fall", -- 340
	"fmove", -- 341
	"fstep", -- 342
	"gun1", -- 343
	"gun2", -- 344
	"gun3", -- 345
	"hit", -- 346
	"idle", -- 347
	"idle1", -- 348
	"jump", -- 349
	"jumping", -- 350
	"landing", -- 351
	"lose", -- 352
	"melee", -- 353
	"parry", -- 354
	"pistol", -- 355
	"prepare", -- 356
	"standUp", -- 357
	"throw" -- 358
}) -- 333
local testAnims = { -- 362
	"bow", -- 362
	"gun1", -- 363
	"gun2", -- 364
	"gun3", -- 365
	"hit", -- 366
	"lose", -- 367
	"melee", -- 368
	"parry", -- 369
	"throw", -- 370
	"comm", -- 371
	"comp", -- 372
	"defence" -- 373
} -- 361
local missingAnims = { } -- 376
local extraAnims = { } -- 377
local availableAnims = { } -- 379
local defaultFaceRight = true -- 380
local getAllFiles -- 382
getAllFiles = function(path, exts) -- 382
	local filters = Set(exts) -- 383
	local _accum_0 = { } -- 384
	local _len_0 = 1 -- 384
	local _list_0 = Content:getAllFiles(path) -- 384
	for _index_0 = 1, #_list_0 do -- 384
		local file = _list_0[_index_0] -- 384
		if not filters[Path:getExt(file)] then -- 385
			goto _continue_0 -- 385
		end -- 385
		_accum_0[_len_0] = file -- 386
		_len_0 = _len_0 + 1 -- 385
		::_continue_0:: -- 385
	end -- 384
	return _accum_0 -- 384
end -- 382
local fileSet = Set((function() -- 388
	local _accum_0 = { } -- 388
	local _len_0 = 1 -- 388
	local _list_0 = getAllFiles("Spine", { -- 388
		"skel", -- 388
		"json" -- 388
	}) -- 388
	for _index_0 = 1, #_list_0 do -- 388
		local file = _list_0[_index_0] -- 388
		_accum_0[_len_0] = Path:getName(file) -- 389
		_len_0 = _len_0 + 1 -- 389
	end -- 388
	return _accum_0 -- 388
end)()) -- 388
local includes = { -- 391
	"char", -- 391
	"charF", -- 392
	"charM", -- 393
	"ayan", -- 394
	"liyena", -- 395
	"moling", -- 396
	"moyu", -- 397
	"villywan", -- 398
	"sunborn", -- 399
	"yuzijiang", -- 400
	"ninilite", -- 401
	"wuyun", -- 402
	"dataotie", -- 403
	"xiaotaotie", -- 404
	"dahuayao", -- 405
	"xiaohuayao", -- 406
	"dashanxiao", -- 407
	"xiaoshanxiao", -- 408
	"dayingzhao", -- 409
	"zhongyingzhao", -- 410
	"xiaoyingzhao", -- 411
	"dahuli", -- 412
	"xiaohuli" -- 413
} -- 390
local files -- 415
do -- 415
	local _accum_0 = { } -- 415
	local _len_0 = 1 -- 415
	for _index_0 = 1, #includes do -- 415
		local k = includes[_index_0] -- 415
		if fileSet[k] then -- 415
			_accum_0[_len_0] = k -- 415
			_len_0 = _len_0 + 1 -- 415
		end -- 415
	end -- 415
	files = _accum_0 -- 415
end -- 415
local defaultFaceLeft = Set({ -- 418
	"liyena", -- 418
	"dataotie", -- 419
	"dahuayao", -- 420
	"xiaohuayao", -- 421
	"dashanxiao", -- 422
	"xiaoshanxiao", -- 423
	"dayingzhao", -- 424
	"zhongyingzhao", -- 425
	"xiaoyingzhao", -- 426
	"dahuli", -- 427
	"xiaohuli" -- 428
}) -- 417
local looks = { -- 431
	xiaohuayao = "white", -- 431
	dashanxiao = "glasses" -- 432
} -- 430
local scenes = { -- 435
	"LoopTowerA", -- 435
	"Station", -- 436
	"Factory", -- 437
	"FrozenCity", -- 438
	"AbandonedCity", -- 439
	"OuterHeaven", -- 440
	"TrainA", -- 441
	"TrainB", -- 442
	"VRTraining", -- 443
	"PreparationRoom", -- 444
	"PassageA", -- 445
	"PassageB", -- 446
	"PassageC", -- 447
	"PassageD", -- 448
	"TrainingRoom", -- 449
	"OperationRoom", -- 450
	"RestRoom", -- 451
	"RDRoom" -- 452
} -- 434
local currentScene = 3 -- 454
local createScene -- 456
createScene = function() -- 456
	local world = Store.world -- 457
	if world then -- 458
		world:removeFromParent() -- 458
	end -- 458
	world = (require("Scene." .. tostring(scenes[currentScene])))() -- 459
	Store.world = world -- 460
	return Director.entry:addChild(world) -- 461
end -- 456
local _anon_func_0 = function(_with_1, grabSize, parent) -- 549
	local _with_0 = Node() -- 549
	_with_0.size = Size(grabSize, grabSize) -- 550
	_with_0:addTo(parent) -- 557
	return _with_0 -- 549
end -- 549
local _anon_func_1 = function(_with_0, scaleY) -- 566
	local _with_1 = Spine("coldweapon") -- 566
	_with_1.look = "grenade" -- 567
	_with_1.scaleX = 0.04 -- 568
	_with_1.scaleY = 0.04 * scaleY -- 569
	return _with_1 -- 566
end -- 566
local _anon_func_2 = function(_with_0, scaleY) -- 570
	local _with_1 = Spine("coldweapon") -- 570
	_with_1.look = "comm" -- 571
	_with_1.scaleX = 0.06 -- 572
	_with_1.scaleY = 0.06 * scaleY -- 573
	return _with_1 -- 570
end -- 570
local _anon_func_3 = function(_with_0, scaleY) -- 574
	local _with_1 = Spine("coldweapon") -- 574
	_with_1.look = "comp" -- 575
	_with_1.scaleX = 0.1 -- 576
	_with_1.scaleY = 0.1 * scaleY -- 577
	return _with_1 -- 574
end -- 574
local _anon_func_4 = function(_with_0, scaleY) -- 578
	local _with_1 = Spine("coldweapon") -- 578
	_with_1.look = "shield" -- 579
	_with_1.scaleX = 0.2 -- 580
	_with_1.scaleY = 0.2 * scaleY -- 581
	return _with_1 -- 578
end -- 578
local _anon_func_5 = function(_with_0, scaleY) -- 582
	local _with_1 = Spine("coldweapon") -- 582
	_with_1.look = "sword" -- 583
	_with_1.scaleX = 0.2 -- 584
	_with_1.scaleY = 0.2 * scaleY -- 585
	return _with_1 -- 582
end -- 582
local _anon_func_6 = function(_with_0, scaleY) -- 586
	local _with_1 = Spine("coldweapon") -- 586
	_with_1.look = "bow" -- 587
	_with_1.scaleX = 0.2 -- 588
	_with_1.scaleY = 0.2 * scaleY -- 589
	return _with_1 -- 586
end -- 586
local _anon_func_7 = function(_with_0, scaleY) -- 590
	local _with_1 = Spine("kineticgun") -- 590
	_with_1.look = "PT" -- 591
	_with_1.scaleX = 0.2 -- 592
	_with_1.scaleY = 0.2 * scaleY -- 593
	return _with_1 -- 590
end -- 590
local _anon_func_8 = function(_with_0, scaleY) -- 594
	local _with_1 = Spine("kineticgun") -- 594
	_with_1.look = "AR" -- 595
	_with_1.scaleX = 0.2 -- 596
	_with_1.scaleY = 0.2 * scaleY -- 597
	return _with_1 -- 594
end -- 594
local createUnit -- 474
createUnit = function() -- 474
	if unit then -- 475
		unit:removeFromParent() -- 475
	end -- 475
	Group({ -- 476
		"player" -- 476
	}):each(function(self) -- 476
		local _obj_0 = self.unit -- 476
		if _obj_0 ~= nil then -- 476
			return _obj_0:removeFromParent() -- 476
		end -- 476
		return nil -- 476
	end) -- 476
	Entity({ -- 479
		player = true, -- 479
		name = playable -- 480
	}) -- 478
	local entity = Group({ -- 482
		"player" -- 482
	}):find(function() -- 482
		return true -- 482
	end) -- 482
	local anims = Set(Spine:getAnimations(playable)) -- 484
	do -- 486
		local _accum_0 = { } -- 486
		local _len_0 = 1 -- 486
		for anim in pairs(targetAnims) do -- 486
			if not anims[anim] then -- 487
				_accum_0[_len_0] = anim -- 488
				_len_0 = _len_0 + 1 -- 487
			else -- 489
				goto _continue_0 -- 489
			end -- 487
			::_continue_0:: -- 487
		end -- 486
		missingAnims = _accum_0 -- 486
	end -- 486
	do -- 491
		local _accum_0 = { } -- 491
		local _len_0 = 1 -- 491
		for anim in pairs(anims) do -- 491
			if not targetAnims[anim] then -- 492
				_accum_0[_len_0] = anim -- 493
				_len_0 = _len_0 + 1 -- 492
			else -- 494
				goto _continue_1 -- 494
			end -- 492
			::_continue_1:: -- 492
		end -- 491
		extraAnims = _accum_0 -- 491
	end -- 491
	defaultFaceRight = not defaultFaceLeft[playable] -- 496
	local getUnitDef -- 498
	getUnitDef = function() -- 498
		local _with_0 = Dictionary() -- 498
		_with_0.linearAcceleration = Vec2(0, -15) -- 499
		_with_0.bodyType = "Dynamic" -- 500
		_with_0.scale = 1.0 -- 501
		_with_0.density = 1.0 -- 502
		_with_0.friction = 1.0 -- 503
		_with_0.restitution = 0.0 -- 504
		_with_0.playable = "spine:" .. tostring(playable) -- 505
		_with_0.defaultFaceRight = defaultFaceRight -- 506
		_with_0.size = Size(100, 300) -- 507
		_with_0.sensity = 0 -- 508
		_with_0.move = 300 -- 509
		_with_0.jump = 1200 -- 510
		_with_0.detectDistance = 300 -- 511
		_with_0.hp = 5.0 -- 512
		_with_0.tag = "player" -- 513
		_with_0.decisionTree = "AI:PlayerControl" -- 514
		_with_0.usePreciseHit = false -- 515
		local _with_1 = Array({ -- 517
			"idle", -- 517
			"turn", -- 518
			"fallOff", -- 519
			"test", -- 520
			"cancel", -- 521
			"keepIdle", -- 522
			"keepMove", -- 523
			"idle1" -- 524
		}) -- 516
		if anims["fstep"] then -- 526
			_with_1:add("rush") -- 526
		end -- 526
		if anims["bstep"] then -- 527
			_with_1:add("evade") -- 527
		end -- 527
		if anims["jump"] then -- 528
			_with_1:add("jump") -- 528
		end -- 528
		if anims["pistol"] then -- 529
			_with_1:add("pistol") -- 529
		end -- 529
		if anims["fall"] and anims["standUp"] then -- 530
			_with_1:add("fall") -- 530
		end -- 530
		if anims["fmove"] or anims["move"] then -- 531
			_with_1:add("fmove") -- 531
		end -- 531
		if anims["bmove"] then -- 532
			_with_1:add("bmove") -- 532
		end -- 532
		_with_0.actions = _with_1 -- 516
		return _with_0 -- 498
	end -- 498
	do -- 534
		local _accum_0 = { } -- 534
		local _len_0 = 1 -- 534
		for _index_0 = 1, #testAnims do -- 534
			local anim = testAnims[_index_0] -- 534
			if anims[anim] then -- 535
				_accum_0[_len_0] = anim -- 536
				_len_0 = _len_0 + 1 -- 535
			else -- 537
				goto _continue_2 -- 537
			end -- 535
			::_continue_2:: -- 535
		end -- 534
		availableAnims = _accum_0 -- 534
	end -- 534
	for _index_0 = 1, #extraAnims do -- 539
		local a = extraAnims[_index_0] -- 539
		table.insert(availableAnims, a) -- 540
	end -- 539
	local world = Store.world -- 542
	local grabSize <const> = 800 -- 543
	do -- 544
		local _with_0 = Unit(getUnitDef(), world, entity, Vec2(100, world.offset + 150)) -- 544
		_with_0.group = 1 -- 545
		local _with_1 = _with_0.playable -- 546
		_with_1.look = looks[playable] or "" -- 547
		local parent = _with_1.parent -- 548
		_with_1:moveToParent(_anon_func_0(_with_1, grabSize, parent)) -- 549
		_with_1.position = Vec2(grabSize / 2, grabSize / 2 - 150) -- 558
		unit = _with_0 -- 544
	end -- 544
	if unit.playable.hitTestEnabled then -- 560
		entity.hitTest = true -- 561
	end -- 560
	local scaleY = defaultFaceRight and 1.0 or -1.0 -- 563
	do -- 565
		local _with_0 = unit.playable -- 565
		_with_0:setSlot("item", _anon_func_1(_with_0, scaleY)) -- 566
		_with_0:setSlot("comm", _anon_func_2(_with_0, scaleY)) -- 570
		_with_0:setSlot("comp", _anon_func_3(_with_0, scaleY)) -- 574
		_with_0:setSlot("shield", _anon_func_4(_with_0, scaleY)) -- 578
		_with_0:setSlot("melee", _anon_func_5(_with_0, scaleY)) -- 582
		_with_0:setSlot("bow", _anon_func_6(_with_0, scaleY)) -- 586
		_with_0:setSlot("pistol", _anon_func_7(_with_0, scaleY)) -- 590
		_with_0:setSlot("gun", _anon_func_8(_with_0, scaleY)) -- 594
	end -- 565
	local shadow -- 599
	do -- 599
		local _with_0 = Sprite("Image/shadow.png") -- 599
		_with_0.order = -1 -- 600
		_with_0:schedule(function() -- 601
			local start = unit.position -- 602
			local stop = start + Vec2(0, -1000) -- 603
			if world:raycast(start, stop, false, function(body, point) -- 604
				if body.group == Data.groupTerrain then -- 605
					stop = point -- 606
					return true -- 607
				end -- 605
				return false -- 608
			end) then -- 604
				_with_0.y = stop.y - unit.y -- 609
			end -- 604
		end) -- 601
		_with_0:addTo(unit) -- 610
		shadow = _with_0 -- 599
	end -- 599
	world:addChild(unit) -- 611
	local _with_0 = world.camera -- 612
	_with_0.position = unit.position -- 613
	_with_0.followTarget = unit -- 614
	return _with_0 -- 612
end -- 474
local currentFile = 1 -- 616
createScene() -- 618
if #files > 0 then -- 619
	for i = 1, #files do -- 620
		if files[i] == "charF" then -- 621
			playable = files[i] -- 622
			currentFile = math.floor(i) -- 623
			break -- 624
		end -- 621
	end -- 620
	if not playable then -- 625
		currentFile = 1 -- 626
		playable = files[1] -- 627
	end -- 625
	createUnit() -- 628
end -- 619
local battle = false -- 630
return Director.entry:addChild((function() -- 631
	local _with_0 = Node() -- 631
	_with_0:schedule(function() -- 632
		local width, height -- 633
		do -- 633
			local _obj_0 = App.visualSize -- 633
			width, height = _obj_0.width, _obj_0.height -- 633
		end -- 633
		SetNextWindowPos(Vec2(width - 300, 10), "FirstUseEver") -- 634
		SetNextWindowSize(Vec2(290, 325), "FirstUseEver") -- 635
		return Begin("Spine", { -- 636
			"NoResize", -- 636
			"NoSavedSettings" -- 636
		}, function() -- 636
			local changed -- 637
			changed, currentScene = Combo("Scene", currentScene, scenes) -- 637
			if changed then -- 638
				createScene() -- 639
				createUnit() -- 640
			end -- 638
			changed, currentFile = Combo("Spine", currentFile, files) -- 641
			if changed then -- 642
				playable = files[currentFile] -- 643
				createUnit() -- 644
			end -- 642
			changed, defaultFaceRight = Checkbox("默认朝向右", defaultFaceRight) -- 645
			if changed then -- 646
				createUnit() -- 646
			end -- 646
			changed, battle = Checkbox("战斗状态", battle) -- 647
			if changed then -- 648
				Store.battle = battle -- 649
				if unit.onSurface then -- 650
					unit:start("cancel") -- 651
					unit:start("idle") -- 652
				end -- 650
			end -- 648
			for i, anim in ipairs(availableAnims) do -- 653
				if Button(anim) then -- 654
					if not unit.currentAction or unit.currentAction.name ~= "test_" then -- 655
						if not unit:isDoing("test") then -- 656
							Store.testAction = anim -- 657
							unit:start("test") -- 658
						end -- 656
					end -- 655
				end -- 654
				if i % 3 ~= 0 and i ~= #availableAnims then -- 659
					SameLine() -- 659
				end -- 659
			end -- 653
			if #missingAnims > 0 then -- 660
				Text("缺失动作或名称错误：") -- 661
				Text(table.concat(missingAnims, "\n")) -- 662
			end -- 660
			if #extraAnims > 0 then -- 663
				Text("多余动作：") -- 664
				return Text(table.concat(extraAnims, "\n")) -- 665
			end -- 663
		end) -- 636
	end) -- 632
	return _with_0 -- 631
end)()) -- 631
