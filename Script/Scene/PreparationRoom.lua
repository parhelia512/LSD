-- [yue]: Script/Scene/PreparationRoom.yue
local _module_0 = nil -- 1
local _ENV = Dora(Dora.Platformer) -- 1
local require <const> = require -- 2
local Spine <const> = Spine -- 2
local Class <const> = Class -- 2
local property <const> = property -- 2
local Vec2 <const> = Vec2 -- 2
local Sprite <const> = Sprite -- 2
local View <const> = View -- 2
local Rect <const> = Rect -- 2
local once <const> = once -- 2
local cycle <const> = cycle -- 2
local Ease <const> = Ease -- 2
local sleep <const> = sleep -- 2
local PlatformWorld <const> = PlatformWorld -- 2
local BodyDef <const> = BodyDef -- 2
local Body <const> = Body -- 2
local Data <const> = Data -- 2
local Array <const> = Array -- 2
local Cache <const> = Cache -- 2
local Map = require("Academy.Map") -- 3
local W <const> = 3840 -- 5
local HW <const> = W / 2 -- 6
local H <const> = 1080 -- 7
local HH <const> = H / 2 -- 8
local Offset <const> = 0 -- 9
local BackZ <const> = 470 -- 10
local ZOffset <const> = BackZ / 2 -- 11
local PathOffset <const> = 50 -- 12
local MaxPath <const> = 2 -- 13
local DefaultZoom <const> = 0.7 -- 14
local GateZ <const> = 400 -- 15
local SceneName <const> = "PreparationRoom" -- 16
local layerDefs = { -- 25
	{ -- 25
		look = "lantern", -- 25
		order = 100, -- 25
		x = W * (1.0 - DefaultZoom) / 2, -- 25
		scale = DefaultZoom -- 25
	}, -- 25
	{ -- 26
		look = "front", -- 26
		order = 99 -- 26
	}, -- 26
	{ -- 27
		look = "furniture", -- 27
		order = -100, -- 27
		z = 300 -- 27
	}, -- 27
	{ -- 28
		look = "shield", -- 28
		order = -101, -- 28
		z = GateZ -- 28
	}, -- 28
	{ -- 29
		look = "gate", -- 29
		order = -102, -- 29
		z = GateZ -- 29
	}, -- 29
	{ -- 30
		look = "elevatorfloor", -- 30
		order = -110, -- 30
		z = GateZ, -- 30
		angleX = 90 -- 30
	}, -- 30
	{ -- 31
		look = "elevator", -- 31
		order = -111, -- 31
		z = GateZ + 268 -- 31
	}, -- 31
	{ -- 32
		look = "leftwall", -- 32
		order = -112, -- 32
		angleY = -90 -- 32
	}, -- 32
	{ -- 33
		look = "rightwall", -- 33
		order = -113, -- 33
		x = W, -- 33
		angleY = 90 -- 33
	}, -- 33
	{ -- 34
		look = "floor", -- 34
		order = -114, -- 34
		angleX = 90 -- 34
	}, -- 34
	{ -- 35
		look = "back", -- 35
		order = -115, -- 35
		z = BackZ -- 35
	} -- 35
} -- 24
local addLayer -- 37
addLayer = function(world, def) -- 37
	local layer -- 38
	do -- 38
		local _with_0 = Spine("preparationRoom") -- 38
		_with_0.look = def.look -- 39
		_with_0.order = def.order -- 40
		_with_0.scaleX = def.scale or 1.0 -- 41
		_with_0.scaleY = def.scale or 1.0 -- 42
		_with_0.x = def.x or 0 -- 43
		_with_0.y = def.y or 0 -- 44
		_with_0.z = def.z or 0 -- 45
		_with_0.angleX = def.angleX or 0 -- 46
		_with_0.angleY = def.angleY or 0 -- 47
		_with_0.x = def.x or 0 -- 48
		layer = _with_0 -- 38
	end -- 38
	if def.ratio then -- 49
		world:setLayerRatio(def.order, def.ratio) -- 50
	end -- 49
	if def.offset then -- 51
		world:setLayerOffset(def.order, def.offset) -- 52
	end -- 51
	world:addChild(layer) -- 53
	if def.handle then -- 54
		def.handle(layer) -- 54
	end -- 54
	return layer -- 55
end -- 37
_module_0 = Class({ -- 58
	sceneWidth = property(function() -- 58
		return W -- 58
	end), -- 58
	offset = property(function() -- 59
		return Offset -- 59
	end), -- 59
	left = property(function(self) -- 60
		return Vec2(100, self.offset) -- 60
	end), -- 60
	right = property(function(self) -- 61
		return Vec2(self.sceneWidth - 100, self.offset) -- 61
	end), -- 61
	center = property(function(self) -- 62
		return Vec2(self.sceneWidth / 2, self.offset) -- 62
	end), -- 62
	addShadowTo = function(self, unit) -- 64
		local _with_0 = Sprite("Image/shadow1.png") -- 65
		_with_0.angleX = 90 -- 66
		_with_0.order = -1 -- 67
		_with_0:schedule(function() -- 68
			_with_0.y = self.offset - unit.y -- 68
		end) -- 68
		_with_0:addTo(unit) -- 69
		return _with_0 -- 65
	end, -- 64
	openLeftDoor = function(self) -- 71
		local _with_0 = self._layers.leftwall -- 71
		_with_0.opened = true -- 72
		_with_0.recovery = 0 -- 73
		_with_0:play("openLI") -- 74
		return _with_0 -- 71
	end, -- 71
	openRightDoor = function(self) -- 76
		local _with_0 = self._layers.rightwall -- 76
		_with_0.opened = true -- 77
		_with_0.recovery = 0 -- 78
		_with_0:play("openRI") -- 79
		return _with_0 -- 76
	end, -- 76
	zoom = property(function(self) -- 81
		return self._zoom -- 81
	end, function(self, value) -- 82
		self._zoom = value -- 83
		return self:updateZoom() -- 84
	end), -- 81
	updateZoom = function(self) -- 86
		local actualZoom = self._zoom * DefaultZoom -- 87
		do -- 88
			local _with_0 = self._layers.lantern -- 88
			_with_0.x = W * (1.0 - actualZoom) / 2 -- 89
			_with_0.scaleX = actualZoom -- 90
			_with_0.scaleY = actualZoom -- 91
		end -- 88
		local width, height -- 92
		do -- 92
			local _obj_0 = View.size -- 92
			width, height = _obj_0.width, _obj_0.height -- 92
		end -- 92
		local zoom = height / H / actualZoom -- 93
		if width > W * zoom then -- 94
			zoom = width / W -- 95
		end -- 94
		local _with_0 = self.camera -- 96
		_with_0.zoom = zoom -- 97
		_with_0.boundary = Rect(0, 0, W, H * actualZoom) -- 98
		return _with_0 -- 96
	end, -- 86
	openGate = function(self) -- 100
		self._layers.gate.speed = self._speed -- 101
		self._layers.gate:play("gateOpen") -- 102
		self._layers.shield.speed = self._speed -- 103
		return self._layers.shield:play("gateOpen") -- 104
	end, -- 100
	closeGate = function(self) -- 106
		self._layers.gate.speed = self._speed -- 107
		self._layers.gate:play("gateClose") -- 108
		self._layers.shield.speed = self._speed -- 109
		return self._layers.shield:play("gateClose") -- 110
	end, -- 106
	turnOnLights = function(self) -- 112
		self.zoom = 1.0 -- 113
		self:schedule(once(function() -- 114
			cycle(3.5 / self._speed, function(dt) -- 115
				self.zoom = 1.4 - (0.8 * Ease:func(Ease.OutQuad, dt)) -- 116
			end) -- 115
			return self:schedule(once(function() -- 117
				return cycle(4.5 / self._speed, function(dt) -- 118
					self.zoom = 0.6 + (0.4 * Ease:func(Ease.InOutBack, dt)) -- 119
				end) -- 118
			end)) -- 117
		end)) -- 114
		return self._layers.back:schedule(once(function() -- 120
			self._layers.back:play("backOn") -- 121
			self._layers.lantern.speed = self._speed -- 122
			self._layers.lantern:play("lanternOn") -- 123
			self._layers.shield.speed = self._speed -- 124
			self._layers.shield:play("gateOn") -- 125
			self._layers.furniture.speed = self._speed -- 126
			self._layers.furniture:play("gateOn") -- 127
			do -- 128
				local _with_0 = self._layers.gate -- 128
				_with_0.speed = self._speed -- 129
				sleep(_with_0:play("gateOn")) -- 130
			end -- 128
			return self:openGate() -- 131
		end)) -- 120
	end, -- 112
	makeUnitEnter = function(self, unit, delay, order) -- 133
		if delay == nil then -- 133
			delay = 0 -- 133
		end -- 133
		if order == nil then -- 133
			order = 0 -- 133
		end -- 133
		unit:start("cancel") -- 134
		unit:start("keepIdle") -- 135
		unit.order = -110 -- 136
		local startZ = GateZ + 100 -- 137
		unit.z = startZ -- 138
		return unit:schedule(once(function() -- 139
			sleep(3.5 + delay) -- 140
			unit:start("keepMove") -- 141
			cycle(1 / 2, function(dt) -- 142
				unit.z = startZ - dt * 100 -- 143
			end) -- 142
			unit.order = order -- 144
			local layer = self:getLayer(order) -- 145
			startZ = GateZ - layer.z -- 146
			unit.z = startZ -- 147
			cycle(1.65 / 2, function(dt) -- 148
				unit.z = startZ - dt * startZ -- 149
			end) -- 148
			unit:start("cancel") -- 150
			unit:start("idle1") -- 151
			return sleep(3) -- 152
		end)) -- 139
	end, -- 133
	__partial = function(_) -- 154
		local _with_0 = PlatformWorld() -- 155
		_with_0.camera.followRatio = Vec2(0.03, 0.03) -- 156
		_with_0.tag = "PreparationRoom" -- 157
		return _with_0 -- 155
	end, -- 154
	__init = function(self) -- 159
		for i = -MaxPath, MaxPath do -- 160
			local _with_0 = self:getLayer(i) -- 161
			_with_0.z = ZOffset - PathOffset * i -- 162
		end -- 160
		do -- 164
			local _tbl_0 = { } -- 164
			for _index_0 = 1, #layerDefs do -- 164
				local def = layerDefs[_index_0] -- 164
				_tbl_0[def.look] = addLayer(self, def) -- 164
			end -- 164
			self._layers = _tbl_0 -- 164
		end -- 164
		local LeftDoorSensor <const> = 0 -- 166
		local RightDoorSensor <const> = 1 -- 167
		local terrainDef -- 168
		do -- 168
			local _with_0 = BodyDef() -- 168
			_with_0.type = "Static" -- 169
			_with_0:attachPolygon(Vec2(HW, 0), W, 10, 0, 1, 1, 0) -- 170
			_with_0:attachPolygon(Vec2(HW, H), W, 10, 0, 1, 1, 0) -- 171
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 172
			_with_0:attachPolygon(Vec2(W, HH), 10, H, 0, 1, 1, 0) -- 173
			_with_0:attachPolygonSensor(LeftDoorSensor, Vec2(75, 175), 150, 350) -- 174
			_with_0:attachPolygonSensor(RightDoorSensor, Vec2(W - 75, 175), 150, 350) -- 175
			_with_0.position = Vec2(0, Offset) -- 176
			terrainDef = _with_0 -- 168
		end -- 168
		self._layers.leftwall.opened = false -- 178
		self._layers.rightwall.opened = false -- 179
		local DoorSpeed <const> = 1.5 -- 180
		do -- 181
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 181
			_with_0.group = Data.groupTerrain -- 182
			_with_0:slot("BodyEnter", function(body, sensorTag) -- 183
				if not body.entity then -- 184
					return -- 184
				end -- 184
				if not body.entity.player then -- 185
					return -- 185
				end -- 185
				local door, animation, route -- 186
				if LeftDoorSensor == sensorTag then -- 187
					door, animation, route = self._layers.leftwall, "openL", "left" -- 188
				elseif RightDoorSensor == sensorTag then -- 189
					door, animation, route = self._layers.rightwall, "openR", "right" -- 190
				end -- 186
				local name, enter, targets = Map.getRoute(SceneName, route) -- 191
				if name then -- 191
					do -- 192
						local _with_1 = body.entity -- 192
						if body.velocityX == 0 then -- 193
							_with_1.moveFromRight = route ~= "right" -- 193
						else -- 193
							_with_1.moveFromRight = body.velocityX < 0 -- 193
						end -- 193
						_with_1.moveRouteName = name -- 194
						_with_1.moveEnter = enter -- 195
						_with_1.moveTargets = Array(targets) -- 196
					end -- 192
					if #targets > 0 and not door.opened then -- 197
						door.opened = true -- 199
						door.recovery = 1 -- 200
						door.speed = DoorSpeed -- 201
						door:play(animation) -- 202
						return door -- 198
					end -- 197
				end -- 191
			end) -- 183
			_with_0:slot("BodyLeave", function(body, sensorTag) -- 203
				if not body.entity then -- 204
					return -- 204
				end -- 204
				if not body.entity.player then -- 205
					return -- 205
				end -- 205
				if not body.entity.moveTargets then -- 206
					return -- 206
				end -- 206
				local available = not body.entity.moveTargets.empty -- 207
				do -- 208
					local _with_1 = body.entity -- 208
					_with_1.moveFromRight = nil -- 209
					_with_1.moveRouteName = nil -- 210
					_with_1.moveEnter = nil -- 211
					_with_1.moveTargets = nil -- 212
				end -- 208
				if not available then -- 213
					return -- 213
				end -- 213
				local door, animation -- 214
				if LeftDoorSensor == sensorTag then -- 215
					door, animation = self._layers.leftwall, "closeL" -- 216
				elseif RightDoorSensor == sensorTag then -- 217
					door, animation = self._layers.rightwall, "closeR" -- 218
				end -- 214
				door.opened = false -- 220
				door.recovery = 1 -- 221
				door.speed = DoorSpeed -- 222
				door:play(animation) -- 223
				return door -- 219
			end) -- 203
			_with_0:addTo(self) -- 224
		end -- 181
		self._speed = 1.0 -- 226
		self._zoom = 1.0 -- 227
		self:gslot("AppChange", function(settingName) -- 228
			if settingName == "Size" then -- 228
				return self:updateZoom() -- 228
			end -- 228
		end) -- 228
		return self:updateZoom() -- 229
	end, -- 159
	loadAsync = function(_) -- 231
		return Cache:loadAsync("spine:preparationRoom") -- 231
	end -- 231
}) -- 57
return _module_0 -- 1
