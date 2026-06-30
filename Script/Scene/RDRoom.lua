-- [yue]: Script/Scene/RDRoom.yue
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
local PlatformWorld <const> = PlatformWorld -- 2
local BodyDef <const> = BodyDef -- 2
local Body <const> = Body -- 2
local Data <const> = Data -- 2
local Array <const> = Array -- 2
local Cache <const> = Cache -- 2
local Map = require("Academy.Map") -- 3
local W <const> = 5690 -- 5
local HW <const> = W / 2 -- 6
local H <const> = 1080 -- 7
local HH <const> = H / 2 -- 8
local Offset <const> = 0 -- 9
local BackZ <const> = 470 -- 10
local ZOffset <const> = BackZ / 2 -- 11
local PathOffset <const> = 50 -- 12
local MaxPath <const> = 2 -- 13
local DefaultZoom <const> = 0.7 -- 14
local SceneName <const> = "RDRoom" -- 15
local layerDefs = { -- 24
	{ -- 24
		look = "lantern", -- 24
		order = 100, -- 24
		x = W * (1.0 - DefaultZoom) / 2, -- 24
		scale = DefaultZoom -- 24
	}, -- 24
	{ -- 25
		look = "front", -- 25
		order = 99 -- 25
	}, -- 25
	{ -- 26
		look = "dragonhead", -- 26
		order = 98, -- 26
		z = 100, -- 26
		x = W * (1.0 - DefaultZoom) / 2, -- 26
		scale = DefaultZoom, -- 26
		y = 50 -- 26
	}, -- 26
	{ -- 27
		look = "backlight", -- 27
		order = 97, -- 27
		z = 150, -- 27
		x = W * (1.0 - DefaultZoom) / 2, -- 27
		scale = DefaultZoom, -- 27
		y = 78 -- 27
	}, -- 27
	{ -- 28
		look = "device1", -- 28
		order = -100, -- 28
		z = ZOffset + 40 -- 28
	}, -- 28
	{ -- 29
		look = "device2", -- 29
		order = -101, -- 29
		z = ZOffset + 40 * 2 -- 29
	}, -- 29
	{ -- 30
		look = "console1", -- 30
		order = -102, -- 30
		z = ZOffset + 40 * 3 -- 30
	}, -- 30
	{ -- 31
		look = "console2", -- 31
		order = -103, -- 31
		z = ZOffset + 40 * 4 -- 31
	}, -- 31
	{ -- 32
		look = "console3", -- 32
		order = -104, -- 32
		z = ZOffset + 40 * 5 -- 32
	}, -- 32
	{ -- 33
		look = "printer", -- 33
		order = -105, -- 33
		z = ZOffset + 50 -- 33
	}, -- 33
	{ -- 34
		look = "sigil", -- 34
		order = -106, -- 34
		z = ZOffset + 120 -- 34
	}, -- 34
	{ -- 35
		look = "dragonbody", -- 35
		order = -107, -- 35
		z = ZOffset + 150, -- 35
		x = 600 -- 35
	}, -- 35
	{ -- 36
		look = "leftwall", -- 36
		order = -108, -- 36
		angleY = -90 -- 36
	}, -- 36
	{ -- 37
		look = "rightwall", -- 37
		order = -109, -- 37
		x = W, -- 37
		z = -100, -- 37
		angleY = 90 -- 37
	}, -- 37
	{ -- 38
		look = "floor", -- 38
		order = -110, -- 38
		angleX = 90 -- 38
	}, -- 38
	{ -- 39
		look = "back", -- 39
		order = -111, -- 39
		z = BackZ -- 39
	} -- 39
} -- 23
local addLayer -- 41
addLayer = function(world, def) -- 41
	local layer -- 42
	do -- 42
		local _with_0 = Spine("RDRoom") -- 42
		_with_0.look = def.look -- 43
		_with_0.order = def.order -- 44
		_with_0.scaleX = def.scale or 1.0 -- 45
		_with_0.scaleY = def.scale or 1.0 -- 46
		_with_0.x = def.x or 0 -- 47
		_with_0.y = def.y or 0 -- 48
		_with_0.z = def.z or 0 -- 49
		_with_0.angleX = def.angleX or 0 -- 50
		_with_0.angleY = def.angleY or 0 -- 51
		_with_0.x = def.x or 0 -- 52
		layer = _with_0 -- 42
	end -- 42
	if def.ratio then -- 53
		world:setLayerRatio(def.order, def.ratio) -- 54
	end -- 53
	if def.offset then -- 55
		world:setLayerOffset(def.order, def.offset) -- 56
	end -- 55
	world:addChild(layer) -- 57
	if def.handle then -- 58
		def.handle(layer) -- 58
	end -- 58
	return layer -- 59
end -- 41
_module_0 = Class({ -- 62
	sceneWidth = property(function() -- 62
		return W -- 62
	end), -- 62
	offset = property(function() -- 63
		return Offset -- 63
	end), -- 63
	left = property(function(self) -- 64
		return Vec2(100, self.offset) -- 64
	end), -- 64
	right = property(function(self) -- 65
		return Vec2(self.sceneWidth - 100, self.offset) -- 65
	end), -- 65
	addShadowTo = function(self, unit) -- 67
		local _with_0 = Sprite("Image/shadow1.png") -- 68
		_with_0.angleX = 90 -- 69
		_with_0.order = -1 -- 70
		_with_0:schedule(function() -- 71
			_with_0.y = self.offset - unit.y -- 71
		end) -- 71
		_with_0:addTo(unit) -- 72
		return _with_0 -- 68
	end, -- 67
	openLeftDoor = function(self) -- 74
		local _with_0 = self._layers.leftwall -- 74
		_with_0.opened = true -- 75
		_with_0.recovery = 0 -- 76
		_with_0:play("openLI") -- 77
		return _with_0 -- 74
	end, -- 74
	openRightDoor = function(self) -- 79
		local _with_0 = self._layers.rightwall -- 79
		_with_0.opened = true -- 80
		_with_0.recovery = 0 -- 81
		_with_0:play("openRI") -- 82
		return _with_0 -- 79
	end, -- 79
	zoom = property(function(self) -- 84
		return self._zoom -- 84
	end, function(self, value) -- 85
		self._zoom = value -- 86
		return self:updateZoom() -- 87
	end), -- 84
	updateZoom = function(self) -- 89
		local actualZoom = self._zoom * DefaultZoom -- 90
		do -- 91
			local _with_0 = self._layers.lantern -- 91
			_with_0.x = W * (1.0 - actualZoom) / 2 -- 92
			_with_0.scaleX = actualZoom -- 93
			_with_0.scaleY = actualZoom -- 94
		end -- 91
		local width, height -- 95
		do -- 95
			local _obj_0 = View.size -- 95
			width, height = _obj_0.width, _obj_0.height -- 95
		end -- 95
		local zoom = height / H / actualZoom -- 96
		if width > W * zoom then -- 97
			zoom = width / W -- 98
		end -- 97
		local _with_0 = self.camera -- 99
		_with_0.zoom = zoom -- 100
		_with_0.boundary = Rect(0, 0, W, H * actualZoom) -- 101
		return _with_0 -- 99
	end, -- 89
	__partial = function(_) -- 103
		local _with_0 = PlatformWorld() -- 104
		_with_0.camera.followRatio = Vec2(0.03, 0.03) -- 105
		_with_0.tag = "RDRoom" -- 106
		return _with_0 -- 104
	end, -- 103
	__init = function(self) -- 108
		for i = -MaxPath, MaxPath do -- 109
			local _with_0 = self:getLayer(i) -- 110
			_with_0.z = ZOffset - PathOffset * i -- 111
		end -- 109
		do -- 113
			local _tbl_0 = { } -- 113
			for _index_0 = 1, #layerDefs do -- 113
				local def = layerDefs[_index_0] -- 113
				_tbl_0[def.look] = addLayer(self, def) -- 113
			end -- 113
			self._layers = _tbl_0 -- 113
		end -- 113
		local LeftDoorSensor <const> = 0 -- 115
		local RightDoorSensor <const> = 1 -- 116
		local terrainDef -- 117
		do -- 117
			local _with_0 = BodyDef() -- 117
			_with_0.type = "Static" -- 118
			_with_0:attachPolygon(Vec2(HW, 0), W, 10, 0, 1, 1, 0) -- 119
			_with_0:attachPolygon(Vec2(HW, H), W, 10, 0, 1, 1, 0) -- 120
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 121
			_with_0:attachPolygon(Vec2(W, HH), 10, H, 0, 1, 1, 0) -- 122
			_with_0:attachPolygonSensor(LeftDoorSensor, Vec2(75, 175), 150, 350) -- 123
			_with_0:attachPolygonSensor(RightDoorSensor, Vec2(W - 75, 175), 150, 350) -- 124
			_with_0.position = Vec2(0, Offset) -- 125
			terrainDef = _with_0 -- 117
		end -- 117
		self._layers.leftwall.opened = false -- 127
		self._layers.rightwall.opened = false -- 128
		local DoorSpeed <const> = 1.5 -- 129
		do -- 130
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 130
			_with_0.group = Data.groupTerrain -- 131
			_with_0:slot("BodyEnter", function(body, sensorTag) -- 132
				if not body.entity then -- 133
					return -- 133
				end -- 133
				if not body.entity.player then -- 134
					return -- 134
				end -- 134
				local door, animation, route -- 135
				if LeftDoorSensor == sensorTag then -- 136
					door, animation, route = self._layers.leftwall, "openL", "left" -- 137
				elseif RightDoorSensor == sensorTag then -- 138
					door, animation, route = self._layers.rightwall, "openR", "right" -- 139
				end -- 135
				local name, enter, targets = Map.getRoute(SceneName, route) -- 140
				if name then -- 140
					do -- 141
						local _with_1 = body.entity -- 141
						if body.velocityX == 0 then -- 142
							_with_1.moveFromRight = route ~= "right" -- 142
						else -- 142
							_with_1.moveFromRight = body.velocityX < 0 -- 142
						end -- 142
						_with_1.moveRouteName = name -- 143
						_with_1.moveEnter = enter -- 144
						_with_1.moveTargets = Array(targets) -- 145
					end -- 141
					if #targets > 0 and not door.opened then -- 146
						door.opened = true -- 148
						door.recovery = 1 -- 149
						door.speed = DoorSpeed -- 150
						door:play(animation) -- 151
						return door -- 147
					end -- 146
				end -- 140
			end) -- 132
			_with_0:slot("BodyLeave", function(body, sensorTag) -- 152
				if not body.entity then -- 153
					return -- 153
				end -- 153
				if not body.entity.player then -- 154
					return -- 154
				end -- 154
				if not body.entity.moveTargets then -- 155
					return -- 155
				end -- 155
				local available = not body.entity.moveTargets.empty -- 156
				do -- 157
					local _with_1 = body.entity -- 157
					_with_1.moveFromRight = nil -- 158
					_with_1.moveRouteName = nil -- 159
					_with_1.moveEnter = nil -- 160
					_with_1.moveTargets = nil -- 161
				end -- 157
				if not available then -- 162
					return -- 162
				end -- 162
				local door, animation -- 163
				if LeftDoorSensor == sensorTag then -- 164
					door, animation = self._layers.leftwall, "closeL" -- 165
				elseif RightDoorSensor == sensorTag then -- 166
					door, animation = self._layers.rightwall, "closeR" -- 167
				end -- 163
				door.opened = false -- 169
				door.recovery = 1 -- 170
				door.speed = DoorSpeed -- 171
				door:play(animation) -- 172
				return door -- 168
			end) -- 152
			_with_0:addTo(self) -- 173
		end -- 130
		self._zoom = 1.0 -- 175
		self:gslot("AppChange", function(settingName) -- 176
			if settingName == "Size" then -- 176
				return self:updateZoom() -- 176
			end -- 176
		end) -- 176
		return self:updateZoom() -- 177
	end, -- 108
	loadAsync = function(_) -- 179
		return Cache:loadAsync("spine:RDRoom") -- 179
	end -- 179
}) -- 61
return _module_0 -- 1
