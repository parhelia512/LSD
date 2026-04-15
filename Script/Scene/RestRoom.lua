-- [yue]: Script/Scene/RestRoom.yue
local _module_0 = nil -- 1
local _ENV = Dora(Dora.Platformer) -- 1
local require <const> = require -- 2
local Spine <const> = Spine -- 2
local Class <const> = Class -- 2
local property <const> = property -- 2
local Vec2 <const> = Vec2 -- 2
local Sprite <const> = Sprite -- 2
local View <const> = View -- 2
local PlatformWorld <const> = PlatformWorld -- 2
local Rect <const> = Rect -- 2
local BodyDef <const> = BodyDef -- 2
local Body <const> = Body -- 2
local Data <const> = Data -- 2
local Array <const> = Array -- 2
local math <const> = math -- 2
local Cache <const> = Cache -- 2
local Map = require("Academy.Map") -- 3
local W <const> = 3640 -- 5
local HW <const> = W / 2 -- 6
local H <const> = 1080 -- 7
local HH <const> = H / 2 -- 8
local Offset <const> = 0 -- 9
local BackZ <const> = 470 -- 10
local ZOffset <const> = BackZ / 2 -- 11
local PathOffset <const> = 50 -- 12
local MaxPath <const> = 2 -- 13
local DefaultZoom <const> = 0.68 -- 14
local SceneName <const> = "RestRoom" -- 15
local layerDefs = { -- 24
	{ -- 24
		look = "lantern", -- 24
		order = 100, -- 24
		x = W * (1.0 - DefaultZoom) / 2, -- 24
		scale = DefaultZoom -- 24
	}, -- 24
	{ -- 25
		look = "disco", -- 25
		order = 99, -- 25
		z = 100, -- 25
		x = W * (1.0 - DefaultZoom) / 2, -- 25
		scale = DefaultZoom, -- 25
		y = 50 -- 25
	}, -- 25
	{ -- 26
		look = "front", -- 26
		order = 98 -- 26
	}, -- 26
	{ -- 27
		look = "vending", -- 27
		order = -100, -- 27
		z = BackZ - 150 -- 27
	}, -- 27
	{ -- 28
		look = "board", -- 28
		order = -101, -- 28
		z = BackZ - 50 -- 28
	}, -- 28
	{ -- 29
		look = "closet", -- 29
		order = -102, -- 29
		z = BackZ -- 29
	}, -- 29
	{ -- 30
		look = "leftwall", -- 30
		order = -103, -- 30
		angleY = -90 -- 30
	}, -- 30
	{ -- 31
		look = "rightwall", -- 31
		order = -104, -- 31
		x = W, -- 31
		angleY = 90 -- 31
	}, -- 31
	{ -- 32
		look = "floor", -- 32
		order = -105, -- 32
		angleX = 90 -- 32
	}, -- 32
	{ -- 33
		look = "back", -- 33
		order = -106, -- 33
		z = BackZ -- 33
	} -- 33
} -- 23
local addLayer -- 35
addLayer = function(world, def) -- 35
	local layer -- 36
	do -- 36
		local _with_0 = Spine("restRoom") -- 36
		_with_0.look = def.look -- 37
		_with_0.order = def.order -- 38
		_with_0.scaleX = def.scale or 1.0 -- 39
		_with_0.scaleY = def.scale or 1.0 -- 40
		_with_0.x = def.x or 0 -- 41
		_with_0.y = def.y or 0 -- 42
		_with_0.z = def.z or 0 -- 43
		_with_0.angleX = def.angleX or 0 -- 44
		_with_0.angleY = def.angleY or 0 -- 45
		_with_0.x = def.x or 0 -- 46
		layer = _with_0 -- 36
	end -- 36
	if def.ratio then -- 47
		world:setLayerRatio(def.order, def.ratio) -- 48
	end -- 47
	if def.offset then -- 49
		world:setLayerOffset(def.order, def.offset) -- 50
	end -- 49
	world:addChild(layer) -- 51
	if def.handle then -- 52
		def.handle(layer) -- 52
	end -- 52
	return layer -- 53
end -- 35
_module_0 = Class({ -- 56
	sceneWidth = property(function() -- 56
		return W -- 56
	end), -- 56
	offset = property(function() -- 57
		return Offset -- 57
	end), -- 57
	left = property(function(self) -- 58
		return Vec2(100, self.offset) -- 58
	end), -- 58
	right = property(function(self) -- 59
		return Vec2(self.sceneWidth - 100, self.offset) -- 59
	end), -- 59
	addShadowTo = function(self, unit) -- 61
		local _with_0 = Sprite("Image/shadow1.png") -- 62
		_with_0.angleX = 90 -- 63
		_with_0.order = -1 -- 64
		_with_0:schedule(function() -- 65
			_with_0.y = self.offset - unit.y -- 65
		end) -- 65
		_with_0:addTo(unit) -- 66
		return _with_0 -- 62
	end, -- 61
	openLeftDoor = function(self) -- 68
		local _with_0 = self._layers.leftwall -- 68
		_with_0.opened = true -- 69
		_with_0.recovery = 0 -- 70
		_with_0:play("openLI") -- 71
		return _with_0 -- 68
	end, -- 68
	openRightDoor = function(self) -- 73
		local _with_0 = self._layers.rightwall -- 73
		_with_0.opened = true -- 74
		_with_0.recovery = 0 -- 75
		_with_0:play("openRI") -- 76
		return _with_0 -- 73
	end, -- 73
	zoom = property(function(self) -- 78
		return self._zoom -- 78
	end, function(self, value) -- 79
		self._zoom = value -- 80
		return self:updateZoom() -- 81
	end), -- 78
	updateZoom = function(self) -- 83
		local actualZoom = self._zoom * DefaultZoom -- 84
		local width, height -- 85
		do -- 85
			local _obj_0 = View.size -- 85
			width, height = _obj_0.width, _obj_0.height -- 85
		end -- 85
		local zoom = height / H / actualZoom -- 86
		if width > W * zoom then -- 87
			zoom = width / W -- 88
		end -- 87
		self.camera.zoom = zoom -- 89
	end, -- 83
	__partial = function(_self) -- 91
		local _with_0 = PlatformWorld() -- 92
		do -- 93
			local _with_1 = _with_0.camera -- 93
			_with_1.boundary = Rect(0, 0, W, H * DefaultZoom) -- 94
			_with_1.followRatio = Vec2(0.03, 0.03) -- 95
		end -- 93
		_with_0.tag = "RestRoom" -- 96
		return _with_0 -- 92
	end, -- 91
	__init = function(self) -- 98
		for i = -MaxPath, MaxPath do -- 99
			local _with_0 = self:getLayer(i) -- 100
			_with_0.z = ZOffset - PathOffset * i -- 101
		end -- 99
		do -- 103
			local _tbl_0 = { } -- 103
			for _index_0 = 1, #layerDefs do -- 103
				local def = layerDefs[_index_0] -- 103
				_tbl_0[def.look] = addLayer(self, def) -- 103
			end -- 103
			self._layers = _tbl_0 -- 103
		end -- 103
		local LeftDoorSensor <const> = 0 -- 105
		local RightDoorSensor <const> = 1 -- 106
		local terrainDef -- 107
		do -- 107
			local _with_0 = BodyDef() -- 107
			_with_0.type = "Static" -- 108
			_with_0:attachPolygon(Vec2(HW, 0), W, 10, 0, 1, 1, 0) -- 109
			_with_0:attachPolygon(Vec2(HW, H), W, 10, 0, 1, 1, 0) -- 110
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 111
			_with_0:attachPolygon(Vec2(W, HH), 10, H, 0, 1, 1, 0) -- 112
			_with_0:attachPolygonSensor(LeftDoorSensor, Vec2(75, 175), 150, 350) -- 113
			_with_0:attachPolygonSensor(RightDoorSensor, Vec2(W - 75, 175), 150, 350) -- 114
			_with_0.position = Vec2(0, Offset) -- 115
			terrainDef = _with_0 -- 107
		end -- 107
		self._layers.leftwall.opened = false -- 117
		self._layers.rightwall.opened = false -- 118
		local DoorSpeed <const> = 1.5 -- 119
		do -- 120
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 120
			_with_0.group = Data.groupTerrain -- 121
			_with_0:slot("BodyEnter", function(body, sensorTag) -- 122
				if not body.entity then -- 123
					return -- 123
				end -- 123
				if not body.entity.player then -- 124
					return -- 124
				end -- 124
				local door, animation, route -- 125
				if LeftDoorSensor == sensorTag then -- 126
					door, animation, route = self._layers.leftwall, "openL", "left" -- 127
				elseif RightDoorSensor == sensorTag then -- 128
					door, animation, route = self._layers.rightwall, "openR", "right" -- 129
				end -- 125
				local name, enter, targets = Map.getRoute(SceneName, route) -- 130
				if name then -- 130
					do -- 131
						local _with_1 = body.entity -- 131
						if body.velocityX == 0 then -- 132
							_with_1.moveFromRight = route ~= "right" -- 132
						else -- 132
							_with_1.moveFromRight = body.velocityX < 0 -- 132
						end -- 132
						_with_1.moveRouteName = name -- 133
						_with_1.moveEnter = enter -- 134
						_with_1.moveTargets = Array(targets) -- 135
					end -- 131
					if #targets > 0 and not door.opened then -- 136
						door.opened = true -- 138
						door.recovery = 1 -- 139
						door.speed = DoorSpeed -- 140
						door:play(animation) -- 141
						return door -- 137
					end -- 136
				end -- 130
			end) -- 122
			_with_0:slot("BodyLeave", function(body, sensorTag) -- 142
				if not body.entity then -- 143
					return -- 143
				end -- 143
				if not body.entity.player then -- 144
					return -- 144
				end -- 144
				if not body.entity.moveTargets then -- 145
					return -- 145
				end -- 145
				local available = not body.entity.moveTargets.empty -- 146
				do -- 147
					local _with_1 = body.entity -- 147
					_with_1.moveFromRight = nil -- 148
					_with_1.moveRouteName = nil -- 149
					_with_1.moveEnter = nil -- 150
					_with_1.moveTargets = nil -- 151
				end -- 147
				if not available then -- 152
					return -- 152
				end -- 152
				local door, animation -- 153
				if LeftDoorSensor == sensorTag then -- 154
					door, animation = self._layers.leftwall, "closeL" -- 155
				elseif RightDoorSensor == sensorTag then -- 156
					door, animation = self._layers.rightwall, "closeR" -- 157
				end -- 153
				door.opened = false -- 159
				door.recovery = 1 -- 160
				door.speed = DoorSpeed -- 161
				door:play(animation) -- 162
				return door -- 158
			end) -- 142
			_with_0:addTo(self) -- 163
		end -- 120
		self._zoom = 1.0 -- 165
		self:gslot("AppChange", function(settingName) -- 166
			if settingName == "Size" then -- 166
				return self:updateZoom() -- 166
			end -- 166
		end) -- 166
		self:updateZoom() -- 167
		return self:schedule(function() -- 168
			local x = self.camera.position.x -- 169
			local distance -- 170
			if x < 800 then -- 170
				distance = 800 - x -- 171
			elseif x > 2300 then -- 172
				distance = x - 2300 -- 173
			else -- 175
				distance = 0 -- 175
			end -- 170
			self.zoom = 0.61 + 0.39 * math.min(1.0, distance / 800) -- 176
		end) -- 168
	end, -- 98
	loadAsync = function(_self) -- 178
		return Cache:loadAsync("spine:restRoom") -- 178
	end -- 178
}) -- 55
return _module_0 -- 1
