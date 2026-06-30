-- [yue]: Script/Scene/OperationRoom.yue
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
local W <const> = 3554 -- 5
local HW <const> = W / 2 -- 6
local H <const> = 1080 -- 7
local HH <const> = H / 2 -- 8
local Offset <const> = 0 -- 9
local BackZ <const> = 470 -- 10
local ZOffset <const> = BackZ / 2 - 50 -- 11
local PathOffset <const> = 50 -- 12
local MaxPath <const> = 2 -- 13
local DefaultZoom <const> = 0.5 -- 14
local SceneName <const> = "OperationRoom" -- 15
local layerDefs = { -- 24
	{ -- 24
		look = "lantern", -- 24
		order = 100, -- 24
		x = W * (1.0 - DefaultZoom) / 2, -- 24
		scale = DefaultZoom -- 24
	}, -- 24
	{ -- 25
		look = "chairLR", -- 25
		order = -100, -- 25
		z = ZOffset + 100 -- 25
	}, -- 25
	{ -- 26
		look = "chaircenter", -- 26
		order = -101, -- 26
		z = ZOffset + 100 -- 26
	}, -- 26
	{ -- 27
		look = "curtainL", -- 27
		order = -102, -- 27
		z = BackZ - 100 -- 27
	}, -- 27
	{ -- 28
		look = "curtainR", -- 28
		order = -103, -- 28
		z = BackZ - 100 -- 28
	}, -- 28
	{ -- 29
		look = "control", -- 29
		order = -104, -- 29
		z = BackZ - 50 -- 29
	}, -- 29
	{ -- 30
		look = "leftwall", -- 30
		order = -105, -- 30
		angleY = -90 -- 30
	}, -- 30
	{ -- 31
		look = "rightwall", -- 31
		order = -106, -- 31
		x = W, -- 31
		angleY = 90 -- 31
	}, -- 31
	{ -- 32
		look = "closetL", -- 32
		order = -107, -- 32
		z = BackZ -- 32
	}, -- 32
	{ -- 33
		look = "closetR", -- 33
		order = -108, -- 33
		z = BackZ -- 33
	}, -- 33
	{ -- 34
		look = "device", -- 34
		order = -109, -- 34
		z = BackZ -- 34
	}, -- 34
	{ -- 35
		look = "backcurtain", -- 35
		order = -110, -- 35
		z = BackZ + 80 -- 35
	}, -- 35
	{ -- 36
		look = "floor", -- 36
		order = -111, -- 36
		angleX = 90 -- 36
	}, -- 36
	{ -- 37
		look = "back", -- 37
		order = -112, -- 37
		z = BackZ + 150 -- 37
	} -- 37
} -- 23
local addLayer -- 39
addLayer = function(world, def) -- 39
	local layer -- 40
	do -- 40
		local _with_0 = Spine("operationRoom") -- 40
		_with_0.look = def.look -- 41
		_with_0.order = def.order -- 42
		_with_0.scaleX = def.scale or 1.0 -- 43
		_with_0.scaleY = def.scale or 1.0 -- 44
		_with_0.x = def.x or 0 -- 45
		_with_0.y = def.y or 0 -- 46
		_with_0.z = def.z or 0 -- 47
		_with_0.angleX = def.angleX or 0 -- 48
		_with_0.angleY = def.angleY or 0 -- 49
		_with_0.x = def.x or 0 -- 50
		layer = _with_0 -- 40
	end -- 40
	if def.ratio then -- 51
		world:setLayerRatio(def.order, def.ratio) -- 52
	end -- 51
	if def.offset then -- 53
		world:setLayerOffset(def.order, def.offset) -- 54
	end -- 53
	world:addChild(layer) -- 55
	if def.handle then -- 56
		def.handle(layer) -- 56
	end -- 56
	return layer -- 57
end -- 39
_module_0 = Class({ -- 60
	sceneWidth = property(function() -- 60
		return W -- 60
	end), -- 60
	offset = property(function() -- 61
		return Offset -- 61
	end), -- 61
	left = property(function(self) -- 62
		return Vec2(100, self.offset) -- 62
	end), -- 62
	right = property(function(self) -- 63
		return Vec2(self.sceneWidth - 100, self.offset) -- 63
	end), -- 63
	addShadowTo = function(self, unit) -- 65
		local _with_0 = Sprite("Image/shadow1.png") -- 66
		_with_0.angleX = 90 -- 67
		_with_0.order = -1 -- 68
		_with_0:schedule(function() -- 69
			_with_0.y = self.offset - unit.y -- 69
		end) -- 69
		_with_0:addTo(unit) -- 70
		return _with_0 -- 66
	end, -- 65
	openLeftDoor = function(self) -- 72
		local _with_0 = self._layers.leftwall -- 72
		_with_0.opened = true -- 73
		_with_0.recovery = 0 -- 74
		_with_0:play("openLI") -- 75
		return _with_0 -- 72
	end, -- 72
	openRightDoor = function(self) -- 77
		local _with_0 = self._layers.rightwall -- 77
		_with_0.opened = true -- 78
		_with_0.recovery = 0 -- 79
		_with_0:play("openRI") -- 80
		return _with_0 -- 77
	end, -- 77
	zoom = property(function(self) -- 82
		return self._zoom -- 82
	end, function(self, value) -- 83
		self._zoom = value -- 84
		return self:updateZoom() -- 85
	end), -- 82
	updateZoom = function(self) -- 87
		local actualZoom = self._zoom * DefaultZoom -- 88
		do -- 89
			local _with_0 = self._layers.lantern -- 89
			_with_0.x = W * (1.0 - actualZoom) / 2 -- 90
			_with_0.scaleX = actualZoom -- 91
			_with_0.scaleY = actualZoom -- 92
		end -- 89
		local width, height -- 93
		do -- 93
			local _obj_0 = View.size -- 93
			width, height = _obj_0.width, _obj_0.height -- 93
		end -- 93
		local zoom = height / H / actualZoom -- 94
		if width > W * zoom then -- 95
			zoom = width / W -- 96
		end -- 95
		local _with_0 = self.camera -- 97
		_with_0.zoom = zoom -- 98
		_with_0.boundary = Rect(0, 0, W, H * actualZoom) -- 99
		return _with_0 -- 97
	end, -- 87
	__partial = function(_) -- 101
		local _with_0 = PlatformWorld() -- 102
		_with_0.camera.followRatio = Vec2(0.03, 0.03) -- 103
		_with_0.tag = "OperationRoom" -- 104
		return _with_0 -- 102
	end, -- 101
	__init = function(self) -- 106
		for i = -MaxPath, MaxPath do -- 107
			local _with_0 = self:getLayer(i) -- 108
			_with_0.z = ZOffset - PathOffset * i -- 109
		end -- 107
		do -- 111
			local _tbl_0 = { } -- 111
			for _index_0 = 1, #layerDefs do -- 111
				local def = layerDefs[_index_0] -- 111
				_tbl_0[def.look] = addLayer(self, def) -- 111
			end -- 111
			self._layers = _tbl_0 -- 111
		end -- 111
		local LeftDoorSensor <const> = 0 -- 113
		local RightDoorSensor <const> = 1 -- 114
		local terrainDef -- 115
		do -- 115
			local _with_0 = BodyDef() -- 115
			_with_0.type = "Static" -- 116
			_with_0:attachPolygon(Vec2(HW, 0), W, 10, 0, 1, 1, 0) -- 117
			_with_0:attachPolygon(Vec2(HW, H), W, 10, 0, 1, 1, 0) -- 118
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 119
			_with_0:attachPolygon(Vec2(W, HH), 10, H, 0, 1, 1, 0) -- 120
			_with_0:attachPolygonSensor(LeftDoorSensor, Vec2(75, 175), 150, 350) -- 121
			_with_0:attachPolygonSensor(RightDoorSensor, Vec2(W - 75, 175), 150, 350) -- 122
			_with_0.position = Vec2(0, Offset) -- 123
			terrainDef = _with_0 -- 115
		end -- 115
		self._layers.leftwall.opened = false -- 125
		self._layers.rightwall.opened = false -- 126
		local DoorSpeed <const> = 1.5 -- 127
		do -- 128
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 128
			_with_0.group = Data.groupTerrain -- 129
			_with_0:slot("BodyEnter", function(body, sensorTag) -- 130
				if not body.entity then -- 131
					return -- 131
				end -- 131
				if not body.entity.player then -- 132
					return -- 132
				end -- 132
				local door, animation, route -- 133
				if LeftDoorSensor == sensorTag then -- 134
					door, animation, route = self._layers.leftwall, "openL", "left" -- 135
				elseif RightDoorSensor == sensorTag then -- 136
					door, animation, route = self._layers.rightwall, "openR", "right" -- 137
				end -- 133
				local name, enter, targets = Map.getRoute(SceneName, route) -- 138
				if name then -- 138
					do -- 139
						local _with_1 = body.entity -- 139
						if body.velocityX == 0 then -- 140
							_with_1.moveFromRight = route ~= "right" -- 140
						else -- 140
							_with_1.moveFromRight = body.velocityX < 0 -- 140
						end -- 140
						_with_1.moveRouteName = name -- 141
						_with_1.moveEnter = enter -- 142
						_with_1.moveTargets = Array(targets) -- 143
					end -- 139
					if #targets > 0 and not door.opened then -- 144
						door.opened = true -- 146
						door.recovery = 1 -- 147
						door.speed = DoorSpeed -- 148
						door:play(animation) -- 149
						return door -- 145
					end -- 144
				end -- 138
			end) -- 130
			_with_0:slot("BodyLeave", function(body, sensorTag) -- 150
				if not body.entity then -- 151
					return -- 151
				end -- 151
				if not body.entity.player then -- 152
					return -- 152
				end -- 152
				if not body.entity.moveTargets then -- 153
					return -- 153
				end -- 153
				local available = not body.entity.moveTargets.empty -- 154
				do -- 155
					local _with_1 = body.entity -- 155
					_with_1.moveFromRight = nil -- 156
					_with_1.moveRouteName = nil -- 157
					_with_1.moveEnter = nil -- 158
					_with_1.moveTargets = nil -- 159
				end -- 155
				if not available then -- 160
					return -- 160
				end -- 160
				local door, animation -- 161
				if LeftDoorSensor == sensorTag then -- 162
					door, animation = self._layers.leftwall, "closeL" -- 163
				elseif RightDoorSensor == sensorTag then -- 164
					door, animation = self._layers.rightwall, "closeR" -- 165
				end -- 161
				door.opened = false -- 167
				door.recovery = 1 -- 168
				door.speed = DoorSpeed -- 169
				door:play(animation) -- 170
				return door -- 166
			end) -- 150
			_with_0:addTo(self) -- 171
		end -- 128
		self._zoom = 1.0 -- 173
		self:gslot("AppChange", function(settingName) -- 174
			if settingName == "Size" then -- 174
				return self:updateZoom() -- 174
			end -- 174
		end) -- 174
		return self:updateZoom() -- 175
	end, -- 106
	loadAsync = function(_) -- 177
		return Cache:loadAsync("spine:operationRoom") -- 177
	end -- 177
}) -- 59
return _module_0 -- 1
