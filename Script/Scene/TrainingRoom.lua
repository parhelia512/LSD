-- [yue]: Script/Scene/TrainingRoom.yue
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
local W <const> = 3840 -- 5
local HW <const> = W / 2 -- 6
local H <const> = 1080 -- 7
local HH <const> = H / 2 -- 8
local Offset <const> = 0 -- 9
local BackZ <const> = 475 -- 10
local ZOffset <const> = BackZ / 2 -- 11
local PathOffset <const> = 50 -- 12
local MaxPath <const> = 2 -- 13
local DefaultZoom <const> = 0.65 -- 14
local SceneName <const> = "TrainingRoom" -- 15
local layerDefs = { -- 24
	{ -- 24
		look = "lantern", -- 24
		order = 100, -- 24
		x = W * (1.0 - DefaultZoom) / 2, -- 24
		scale = DefaultZoom -- 24
	}, -- 24
	{ -- 25
		look = "dummyanchor2", -- 25
		order = 99, -- 25
		x = 1761, -- 25
		z = ZOffset - 80 - 60 -- 25
	}, -- 25
	{ -- 26
		look = "dummyanchor1", -- 26
		order = 98, -- 26
		x = 1761, -- 26
		z = ZOffset - 80 - 30 -- 26
	}, -- 26
	{ -- 27
		look = "dummy", -- 27
		order = 97, -- 27
		x = 1761, -- 27
		z = ZOffset - 80, -- 27
		handle = function(self) -- 27
			return self:play("dummyglow", true) -- 27
		end -- 27
	}, -- 27
	{ -- 28
		look = "backanchor2", -- 28
		order = 96, -- 28
		z = BackZ - 300 -- 28
	}, -- 28
	{ -- 29
		look = "seat", -- 29
		order = 95, -- 29
		x = 935, -- 29
		z = ZOffset - 100, -- 29
		scale = 0.7 -- 29
	}, -- 29
	{ -- 30
		look = "horseanchor2", -- 30
		order = -100, -- 30
		x = 2382, -- 30
		z = ZOffset + 100 - 60 -- 30
	}, -- 30
	{ -- 31
		look = "horseanchor1", -- 31
		order = -101, -- 31
		x = 2382, -- 31
		z = ZOffset + 100 - 30 -- 31
	}, -- 31
	{ -- 32
		look = "horse", -- 32
		order = -102, -- 32
		x = 2382, -- 32
		z = ZOffset + 100, -- 32
		handle = function(self) -- 32
			return self:play("horseglow", true) -- 32
		end -- 32
	}, -- 32
	{ -- 33
		look = "dummyanchor2", -- 33
		order = -103, -- 33
		x = 2940, -- 33
		z = ZOffset + 150 - 60 -- 33
	}, -- 33
	{ -- 34
		look = "dummyanchor1", -- 34
		order = -104, -- 34
		x = 2940, -- 34
		z = ZOffset + 150 - 30 -- 34
	}, -- 34
	{ -- 35
		look = "dummy", -- 35
		order = -105, -- 35
		x = 2940, -- 35
		z = ZOffset + 150, -- 35
		handle = function(self) -- 35
			return self:play("dummyglow", true) -- 35
		end -- 35
	}, -- 35
	{ -- 36
		look = "text", -- 36
		order = -106, -- 36
		x = 935, -- 36
		z = ZOffset + 50, -- 36
		handle = function(self) -- 36
			return self:play("textroll", true) -- 36
		end -- 36
	}, -- 36
	{ -- 37
		look = "table", -- 37
		order = -107, -- 37
		x = 935, -- 37
		z = ZOffset + 50, -- 37
		handle = function(self) -- 37
			return self:play("maskglow", true) -- 37
		end -- 37
	}, -- 37
	{ -- 38
		look = "leftwall", -- 38
		order = -108, -- 38
		angleY = -90 -- 38
	}, -- 38
	{ -- 39
		look = "rightwall", -- 39
		order = -109, -- 39
		x = W, -- 39
		angleY = 90 -- 39
	}, -- 39
	{ -- 40
		look = "backanchor1", -- 40
		order = -110, -- 40
		z = BackZ - 100 -- 40
	}, -- 40
	{ -- 41
		look = "back", -- 41
		order = -111, -- 41
		z = BackZ -- 41
	}, -- 41
	{ -- 42
		look = "floor", -- 42
		order = -112, -- 42
		angleX = 90 -- 42
	} -- 42
} -- 23
local addLayer -- 44
addLayer = function(world, def) -- 44
	local layer -- 45
	do -- 45
		local _with_0 = Spine("trainingRoom") -- 45
		_with_0.look = def.look -- 46
		_with_0.order = def.order -- 47
		_with_0.scaleX = def.scale or 1.0 -- 48
		_with_0.scaleY = def.scale or 1.0 -- 49
		_with_0.x = def.x or 0 -- 50
		_with_0.y = def.y or 0 -- 51
		_with_0.z = def.z or 0 -- 52
		_with_0.angleX = def.angleX or 0 -- 53
		_with_0.angleY = def.angleY or 0 -- 54
		_with_0.x = def.x or 0 -- 55
		layer = _with_0 -- 45
	end -- 45
	if def.ratio then -- 56
		world:setLayerRatio(def.order, def.ratio) -- 57
	end -- 56
	if def.offset then -- 58
		world:setLayerOffset(def.order, def.offset) -- 59
	end -- 58
	world:addChild(layer) -- 60
	if def.handle then -- 61
		def.handle(layer) -- 61
	end -- 61
	return layer -- 62
end -- 44
_module_0 = Class({ -- 65
	sceneWidth = property(function() -- 65
		return W -- 65
	end), -- 65
	offset = property(function() -- 66
		return Offset -- 66
	end), -- 66
	left = property(function(self) -- 67
		return Vec2(100, self.offset) -- 67
	end), -- 67
	right = property(function(self) -- 68
		return Vec2(self.sceneWidth - 100, self.offset) -- 68
	end), -- 68
	addShadowTo = function(self, unit) -- 70
		local _with_0 = Sprite("Image/shadow1.png") -- 71
		_with_0.angleX = 90 -- 72
		_with_0.order = -1 -- 73
		_with_0:schedule(function() -- 74
			_with_0.y = self.offset - unit.y -- 74
		end) -- 74
		_with_0:addTo(unit) -- 75
		return _with_0 -- 71
	end, -- 70
	openLeftDoor = function(self) -- 77
		local _with_0 = self._layers.leftwall -- 77
		_with_0.opened = true -- 78
		_with_0.recovery = 0 -- 79
		_with_0:play("openLI") -- 80
		return _with_0 -- 77
	end, -- 77
	openRightDoor = function(self) -- 82
		local _with_0 = self._layers.rightwall -- 82
		_with_0.opened = true -- 83
		_with_0.recovery = 0 -- 84
		_with_0:play("openRI") -- 85
		return _with_0 -- 82
	end, -- 82
	zoom = property(function(self) -- 87
		return self._zoom -- 87
	end, function(self, value) -- 88
		self._zoom = value -- 89
		return self:updateZoom() -- 90
	end), -- 87
	updateZoom = function(self) -- 92
		local actualZoom = self._zoom * DefaultZoom -- 93
		do -- 94
			local _with_0 = self._layers.lantern -- 94
			_with_0.x = W * (1.0 - actualZoom) / 2 -- 95
			_with_0.scaleX = actualZoom -- 96
			_with_0.scaleY = actualZoom -- 97
		end -- 94
		local width, height -- 98
		do -- 98
			local _obj_0 = View.size -- 98
			width, height = _obj_0.width, _obj_0.height -- 98
		end -- 98
		local zoom = height / H / actualZoom -- 99
		if width > W * zoom then -- 100
			zoom = width / W -- 101
		end -- 100
		local _with_0 = self.camera -- 102
		_with_0.zoom = zoom -- 103
		_with_0.boundary = Rect(0, 0, W, H * actualZoom) -- 104
		return _with_0 -- 102
	end, -- 92
	__partial = function(_self) -- 106
		local _with_0 = PlatformWorld() -- 107
		_with_0.camera.followRatio = Vec2(0.03, 0.03) -- 108
		_with_0.tag = "TrainingRoom" -- 109
		return _with_0 -- 107
	end, -- 106
	__init = function(self) -- 111
		for i = -MaxPath, MaxPath do -- 112
			local _with_0 = self:getLayer(i) -- 113
			_with_0.z = ZOffset - PathOffset * i -- 114
		end -- 112
		do -- 116
			local _tbl_0 = { } -- 116
			for _index_0 = 1, #layerDefs do -- 116
				local def = layerDefs[_index_0] -- 116
				_tbl_0[def.look] = addLayer(self, def) -- 116
			end -- 116
			self._layers = _tbl_0 -- 116
		end -- 116
		local LeftDoorSensor <const> = 0 -- 118
		local RightDoorSensor <const> = 1 -- 119
		local terrainDef -- 120
		do -- 120
			local _with_0 = BodyDef() -- 120
			_with_0.type = "Static" -- 121
			_with_0:attachPolygon(Vec2(HW, 0), W, 10, 0, 1, 1, 0) -- 122
			_with_0:attachPolygon(Vec2(HW, H), W, 10, 0, 1, 1, 0) -- 123
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 124
			_with_0:attachPolygon(Vec2(W, HH), 10, H, 0, 1, 1, 0) -- 125
			_with_0:attachPolygonSensor(LeftDoorSensor, Vec2(75, 175), 150, 350) -- 126
			_with_0:attachPolygonSensor(RightDoorSensor, Vec2(W - 75, 175), 150, 350) -- 127
			_with_0.position = Vec2(0, Offset) -- 128
			terrainDef = _with_0 -- 120
		end -- 120
		self._layers.leftwall.opened = false -- 130
		self._layers.rightwall.opened = false -- 131
		local DoorSpeed <const> = 1.5 -- 132
		do -- 133
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 133
			_with_0.group = Data.groupTerrain -- 134
			_with_0:slot("BodyEnter", function(body, sensorTag) -- 135
				if not body.entity then -- 136
					return -- 136
				end -- 136
				if not body.entity.player then -- 137
					return -- 137
				end -- 137
				local door, animation, route -- 138
				if LeftDoorSensor == sensorTag then -- 139
					door, animation, route = self._layers.leftwall, "openL", "left" -- 140
				elseif RightDoorSensor == sensorTag then -- 141
					door, animation, route = self._layers.rightwall, "openR", "right" -- 142
				end -- 138
				local name, enter, targets = Map.getRoute(SceneName, route) -- 143
				if name then -- 143
					do -- 144
						local _with_1 = body.entity -- 144
						if body.velocityX == 0 then -- 145
							_with_1.moveFromRight = route ~= "right" -- 145
						else -- 145
							_with_1.moveFromRight = body.velocityX < 0 -- 145
						end -- 145
						_with_1.moveRouteName = name -- 146
						_with_1.moveEnter = enter -- 147
						_with_1.moveTargets = Array(targets) -- 148
					end -- 144
					if #targets > 0 and not door.opened then -- 149
						door.opened = true -- 151
						door.recovery = 1 -- 152
						door.speed = DoorSpeed -- 153
						door:play(animation) -- 154
						return door -- 150
					end -- 149
				end -- 143
			end) -- 135
			_with_0:slot("BodyLeave", function(body, sensorTag) -- 155
				if not body.entity then -- 156
					return -- 156
				end -- 156
				if not body.entity.player then -- 157
					return -- 157
				end -- 157
				if not body.entity.moveTargets then -- 158
					return -- 158
				end -- 158
				local available = not body.entity.moveTargets.empty -- 159
				do -- 160
					local _with_1 = body.entity -- 160
					_with_1.moveFromRight = nil -- 161
					_with_1.moveRouteName = nil -- 162
					_with_1.moveEnter = nil -- 163
					_with_1.moveTargets = nil -- 164
				end -- 160
				if not available then -- 165
					return -- 165
				end -- 165
				local door, animation -- 166
				if LeftDoorSensor == sensorTag then -- 167
					door, animation = self._layers.leftwall, "closeL" -- 168
				elseif RightDoorSensor == sensorTag then -- 169
					door, animation = self._layers.rightwall, "closeR" -- 170
				end -- 166
				door.opened = false -- 172
				door.recovery = 1 -- 173
				door.speed = DoorSpeed -- 174
				door:play(animation) -- 175
				return door -- 171
			end) -- 155
			_with_0:addTo(self) -- 176
		end -- 133
		self._zoom = 1.0 -- 178
		self:gslot("AppChange", function(settingName) -- 179
			if settingName == "Size" then -- 179
				return self:updateZoom() -- 179
			end -- 179
		end) -- 179
		return self:updateZoom() -- 180
	end, -- 111
	loadAsync = function(_self) -- 182
		return Cache:loadAsync("spine:trainingRoom") -- 182
	end -- 182
}) -- 64
return _module_0 -- 1
