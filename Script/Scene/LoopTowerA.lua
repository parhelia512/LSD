-- [yue]: Script/Scene/LoopTowerA.yue
local _module_0 = nil -- 1
local _ENV = Dora(Dora.Platformer) -- 1
local Vec2 <const> = Vec2 -- 2
local Spine <const> = Spine -- 2
local Class <const> = Class -- 2
local property <const> = property -- 2
local Sprite <const> = Sprite -- 2
local Data <const> = Data -- 2
local View <const> = View -- 2
local math <const> = math -- 2
local PlatformWorld <const> = PlatformWorld -- 2
local Rect <const> = Rect -- 2
local ClipNode <const> = ClipNode -- 2
local BodyDef <const> = BodyDef -- 2
local Body <const> = Body -- 2
local Node <const> = Node -- 2
local Director <const> = Director -- 2
local Cache <const> = Cache -- 2
local SceneScale <const> = 1.7 -- 4
local W <const> = (11700 + 4000) / SceneScale -- 5
local H <const> = (2616 + 2000) / SceneScale -- 6
local HH <const> = H / 2 -- 7
local Offset <const> = 150 -- 8
local PathOffset <const> = Vec2(10, 10) -- 9
local MaxPath <const> = 2 -- 10
local DefaultZoom <const> = 0.45 -- 11
local layerDefs = { -- 20
	{ -- 20
		look = "front", -- 20
		order = 100 -- 20
	}, -- 20
	{ -- 21
		look = "backitem", -- 21
		order = -100 -- 21
	}, -- 21
	{ -- 22
		look = "floor", -- 22
		order = -101 -- 22
	}, -- 22
	{ -- 23
		look = "window", -- 23
		order = -102 -- 23
	}, -- 23
	{ -- 24
		look = "windowmask", -- 24
		order = -103 -- 24
	}, -- 24
	{ -- 25
		look = "windowoutside", -- 25
		order = -104, -- 25
		ratio = Vec2(-0.1, 0) -- 25
	}, -- 25
	{ -- 26
		look = "back", -- 26
		order = -105 -- 26
	}, -- 26
	{ -- 27
		look = "door", -- 27
		order = -106 -- 27
	}, -- 27
	{ -- 28
		look = "doorinside", -- 28
		order = -107 -- 28
	} -- 28
} -- 19
local lightDefs -- 30
do -- 30
	local _accum_0 = { } -- 30
	local _len_0 = 1 -- 30
	for _index_0 = 1, #layerDefs do -- 30
		local def = layerDefs[_index_0] -- 30
		if def.light then -- 30
			_accum_0[_len_0] = def -- 30
			_len_0 = _len_0 + 1 -- 30
		end -- 30
	end -- 30
	lightDefs = _accum_0 -- 30
end -- 30
local darkDefs -- 31
do -- 31
	local _accum_0 = { } -- 31
	local _len_0 = 1 -- 31
	for _index_0 = 1, #layerDefs do -- 31
		local def = layerDefs[_index_0] -- 31
		if def.light ~= nil and def.light == false then -- 31
			_accum_0[_len_0] = def -- 31
			_len_0 = _len_0 + 1 -- 31
		end -- 31
	end -- 31
	darkDefs = _accum_0 -- 31
end -- 31
local addLayer -- 33
addLayer = function(world, def) -- 33
	local layer -- 34
	do -- 34
		local _with_0 = Spine("loopTowerA") -- 34
		_with_0.scaleX = 1 / SceneScale -- 35
		_with_0.scaleY = 1 / SceneScale -- 36
		_with_0.look = def.look -- 37
		_with_0.order = def.order -- 38
		layer = _with_0 -- 34
	end -- 34
	if def.ratio then -- 39
		world:setLayerRatio(def.order, def.ratio) -- 40
	end -- 39
	world:addChild(layer) -- 41
	if def.handle then -- 42
		def.handle(layer, world) -- 42
	end -- 42
	return layer -- 43
end -- 33
_module_0 = Class({ -- 46
	sceneWidth = property(function() -- 46
		return W -- 46
	end), -- 46
	offset = property(function() -- 47
		return Offset -- 47
	end), -- 47
	addShadowTo = function(self, unit) -- 49
		local _with_0 = Sprite("Image/shadow.png") -- 50
		_with_0.order = -1 -- 51
		_with_0:schedule(function() -- 52
			local position = unit.position -- 53
			local target = position -- 54
			if self:raycast(position, Vec2(position.x, position.y - 1000), false, function(body, point) -- 55
				if body.group == Data.groupTerrain then -- 56
					target = point -- 57
					return true -- 58
				else -- 60
					return false -- 60
				end -- 56
			end) then -- 55
				_with_0.y = target.y - unit.y -- 61
			end -- 55
		end) -- 52
		_with_0:addTo(unit) -- 62
		return _with_0 -- 50
	end, -- 49
	zoom = property(function(self) -- 64
		return self._zoom -- 64
	end, function(self, value) -- 65
		self._zoom = value -- 66
		return self:updateZoom() -- 67
	end), -- 64
	updateZoom = function(self) -- 69
		local width, height -- 70
		do -- 70
			local _obj_0 = View.size -- 70
			width, height = _obj_0.width, _obj_0.height -- 70
		end -- 70
		local zoom = self._zoom * DefaultZoom -- 71
		self.camera.zoom = math.max(height / H / zoom, width / W / zoom) -- 72
	end, -- 69
	__partial = function(_) -- 74
		local _with_0 = PlatformWorld() -- 75
		do -- 76
			local _with_1 = _with_0.camera -- 76
			_with_1.boundary = Rect(0, 0, W, H) -- 77
			_with_1.followRatio = Vec2(0.03, 0.03) -- 78
			_with_1.followOffset = Vec2(0, 200) -- 79
		end -- 76
		_with_0.tag = "LoopTowerA" -- 80
		return _with_0 -- 75
	end, -- 74
	openRightDoor = function(self) -- 82
		return self._layers.door:play("openR") -- 82
	end, -- 82
	__init = function(self) -- 84
		for i = -MaxPath, MaxPath do -- 85
			self:setLayerOffset(i, PathOffset * -i) -- 86
		end -- 85
		do -- 88
			local _tbl_0 = { } -- 88
			for _index_0 = 1, #layerDefs do -- 88
				local def = layerDefs[_index_0] -- 88
				_tbl_0[def.look] = addLayer(self, def) -- 88
			end -- 88
			self._layers = _tbl_0 -- 88
		end -- 88
		do -- 90
			local mask = self._layers.windowmask -- 90
			mask:removeFromParent(false) -- 91
			local clip = ClipNode(mask) -- 92
			clip.order = mask.order -- 93
			clip:addTo(self) -- 94
			local _with_0 = self._layers.windowoutside -- 95
			_with_0.transformTarget = _with_0.parent -- 96
			_with_0:moveToParent(clip) -- 97
		end -- 90
		local RightDoorSensor <const> = 0 -- 99
		local terrainDef -- 100
		do -- 100
			local _with_0 = BodyDef() -- 100
			_with_0.type = "Static" -- 101
			_with_0:attachPolygon(Vec2(959 / SceneScale, 0), 1918 / SceneScale, 10, 0, 1, 1, 0) -- 102
			_with_0:attachPolygon(Vec2(5838 / SceneScale, 398 / SceneScale), 7880 / SceneScale, 10, -5.8, 1, 1, 0) -- 103
			_with_0:attachPolygon(Vec2(10618.5 / SceneScale, 796 / SceneScale), 1721 / SceneScale, 10, 0, 1, 1, 0) -- 104
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 105
			_with_0:attachPolygon(Vec2(11479 / SceneScale, HH), 10, H, 0, 1, 1, 0) -- 106
			_with_0:attachPolygonSensor(RightDoorSensor, Vec2(6230, 675), 300, 400) -- 107
			_with_0.position = Vec2(0, Offset) -- 108
			terrainDef = _with_0 -- 100
		end -- 100
		do -- 110
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 110
			_with_0.group = Data.groupTerrain -- 111
			_with_0:addTo(self) -- 112
			_with_0:slot("BodyEnter", function(body, sensorTag) -- 113
				if sensorTag == RightDoorSensor then -- 114
					if not body.entity then -- 115
						return -- 115
					end -- 115
					if not body.entity.player then -- 116
						return -- 116
					end -- 116
					body.entity.enterExit = true -- 117
				end -- 114
			end) -- 113
			_with_0:slot("BodyLeave", function(body, sensorTag) -- 118
				if sensorTag == RightDoorSensor then -- 119
					if not body.entity then -- 120
						return -- 120
					end -- 120
					if not body.entity.player then -- 121
						return -- 121
					end -- 121
					body.entity.enterExit = false -- 122
				end -- 119
			end) -- 118
		end -- 110
		self._zoom = 1.0 -- 124
		self:gslot("AppChange", function(settingName) -- 125
			if settingName == "Size" then -- 125
				return self:updateZoom() -- 125
			end -- 125
		end) -- 125
		self:updateZoom() -- 126
		local world = self -- 128
		world.scaleX = 1.33 -- 129
		world.scaleY = 1.33 -- 130
		return world:slot("Enter", function() -- 131
			local node = Node() -- 132
			node:addTo(world.parent) -- 133
			node:schedule(function() -- 134
				local position, zoom -- 135
				do -- 135
					local _obj_0 = Director.currentCamera -- 135
					position, zoom = _obj_0.position, _obj_0.zoom -- 135
				end -- 135
				local size = View.size * Vec2(1.0 / zoom, 1.0 / zoom) -- 136
				node.scaleX = 1.33 -- 137
				node.scaleY = 1.33 -- 138
				local h = size.height -- 139
				node.position = position -- 140
				world.position = Vec2(0.5, 0.5) * size - position -- 141
				world.y = world.y + (h * 0.1) -- 142
				node.size = size -- 143
			end) -- 134
			local zoom = Director.currentCamera.zoom -- 144
			node.size = View.size * Vec2(1.0 / zoom, 1.0 / zoom) -- 145
			local h = node.size.height -- 146
			do -- 147
				local _with_0 = node:grab(20, 1) -- 147
				for x = 1, 21 do -- 148
					for y = 1, 2 do -- 149
						local pos = _with_0:getPos(x, y) -- 150
						_with_0:setPos(x, y, pos, math.sin(math.abs(x - 11) * math.pi / 200) * math.abs(x - 11) * h * 0.25) -- 151
					end -- 149
				end -- 148
			end -- 147
			node:gslot("AppChange", function(settingName) -- 152
				if settingName == "Size" then -- 152
					zoom = Director.currentCamera.zoom -- 153
					node.size = View.size * Vec2(1.0 / zoom, 1.0 / zoom) -- 154
					h = node.size.height -- 155
					node:grab(false) -- 156
					local _with_0 = node:grab(20, 1) -- 157
					for x = 1, 21 do -- 158
						for y = 1, 2 do -- 159
							local pos = _with_0:getPos(x, y) -- 160
							_with_0:setPos(x, y, pos, math.sin(math.abs(x - 11) * math.pi / 200) * math.abs(x - 11) * h * 0.25) -- 161
						end -- 159
					end -- 158
					return _with_0 -- 157
				end -- 152
			end) -- 152
			world:moveToParent(node) -- 162
			return node -- 132
		end) -- 131
	end, -- 84
	loadAsync = function(_) -- 165
		return Cache:loadAsync("spine:loopTowerA") -- 165
	end -- 165
}) -- 45
return _module_0 -- 1
