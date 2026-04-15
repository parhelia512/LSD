-- [yue]: Script/Scene/Train.yue
local _module_0 = nil -- 1
local _ENV = Dora(Dora.Platformer) -- 1
local Vec2 <const> = Vec2 -- 2
local once <const> = once -- 2
local cycle <const> = cycle -- 2
local Spine <const> = Spine -- 2
local Class <const> = Class -- 2
local property <const> = property -- 2
local Sprite <const> = Sprite -- 2
local View <const> = View -- 2
local math <const> = math -- 2
local Opacity <const> = Opacity -- 2
local sleep <const> = sleep -- 2
local PlatformWorld <const> = PlatformWorld -- 2
local Rect <const> = Rect -- 2
local BodyDef <const> = BodyDef -- 2
local Body <const> = Body -- 2
local Data <const> = Data -- 2
local loop <const> = loop -- 2
local Cache <const> = Cache -- 2
local SceneScale <const> = 1.7 -- 4
local W <const> = 3840 / SceneScale -- 5
local HW <const> = W / 2 -- 6
local H <const> = 1080 / SceneScale -- 7
local HH <const> = H / 2 -- 8
local Offset <const> = 100 -- 9
local PathOffset <const> = Vec2(10, 10) -- 10
local MaxPath <const> = 2 -- 11
local layerDefs = { -- 20
	{ -- 20
		look = "front", -- 20
		order = 100, -- 20
		ratio = Vec2(-0.2, 0) -- 20
	}, -- 20
	{ -- 21
		look = "lightambient", -- 21
		order = 99, -- 21
		light = true -- 21
	}, -- 21
	{ -- 22
		look = "handrails", -- 22
		order = 98, -- 22
		ratio = Vec2(-0.05, 0), -- 22
		highSpeed = false -- 22
	}, -- 22
	{ -- 23
		look = "handrailshadow", -- 23
		order = 97, -- 23
		light = true, -- 23
		ratio = Vec2(-0.05, 0), -- 23
		highSpeed = false -- 23
	}, -- 23
	{ -- 24
		look = "seat1", -- 24
		order = -100, -- 24
		highSpeed = true -- 24
	}, -- 24
	{ -- 25
		look = "seat2", -- 25
		order = -100, -- 25
		highSpeed = false -- 25
	}, -- 25
	{ -- 26
		look = "lightwindow1", -- 26
		order = -101, -- 26
		light = true, -- 26
		highSpeed = false -- 26
	}, -- 26
	{ -- 27
		look = "lightwindow", -- 27
		order = -102, -- 27
		light = true, -- 27
		highSpeed = true -- 27
	}, -- 27
	{ -- 28
		look = "lightfloor", -- 28
		order = -103, -- 28
		light = true -- 28
	}, -- 28
	{ -- 29
		look = "floor", -- 29
		order = -104 -- 29
	}, -- 29
	{ -- 30
		look = "carriage", -- 30
		order = -105 -- 30
	}, -- 30
	{ -- 31
		look = "scenerylight", -- 31
		order = -106, -- 31
		light = true, -- 31
		handle = function(self, world) -- 31
			self:play("idle", true) -- 32
			world:slot("SpeedUp", function() -- 33
				return self:schedule(once(function() -- 34
					return cycle(10, function(dt) -- 34
						self.speed = dt * world.speed -- 34
					end) -- 34
				end)) -- 34
			end) -- 33
			world:slot("SpeedDown", function() -- 35
				return self:schedule(once(function() -- 36
					return cycle(10, function(dt) -- 36
						self.speed = (1.0 - dt) * world.speed -- 36
					end) -- 36
				end)) -- 36
			end) -- 35
			return self -- 31
		end -- 31
	}, -- 31
	{ -- 37
		look = "scenerydark", -- 37
		order = -107, -- 37
		handle = function(self, world) -- 37
			self:play("idle", true) -- 38
			world:slot("SpeedUp", function() -- 39
				return self:schedule(once(function() -- 40
					return cycle(10, function(dt) -- 40
						self.speed = dt * world.speed -- 40
					end) -- 40
				end)) -- 40
			end) -- 39
			world:slot("SpeedDown", function() -- 41
				return self:schedule(once(function() -- 42
					return cycle(10, function(dt) -- 42
						self.speed = (1.0 - dt) * world.speed -- 42
					end) -- 42
				end)) -- 42
			end) -- 41
			return self -- 37
		end -- 37
	} -- 37
} -- 19
local lightDefs -- 44
do -- 44
	local _accum_0 = { } -- 44
	local _len_0 = 1 -- 44
	for _index_0 = 1, #layerDefs do -- 44
		local def = layerDefs[_index_0] -- 44
		if def.light then -- 44
			_accum_0[_len_0] = def -- 44
			_len_0 = _len_0 + 1 -- 44
		end -- 44
	end -- 44
	lightDefs = _accum_0 -- 44
end -- 44
local darkDefs -- 45
do -- 45
	local _accum_0 = { } -- 45
	local _len_0 = 1 -- 45
	for _index_0 = 1, #layerDefs do -- 45
		local def = layerDefs[_index_0] -- 45
		if def.light ~= nil and def.light == false then -- 45
			_accum_0[_len_0] = def -- 45
			_len_0 = _len_0 + 1 -- 45
		end -- 45
	end -- 45
	darkDefs = _accum_0 -- 45
end -- 45
local addLayer -- 47
addLayer = function(world, def) -- 47
	local layer -- 48
	do -- 48
		local _with_0 = Spine("train") -- 48
		_with_0.scaleX = 1 / SceneScale -- 49
		_with_0.scaleY = 1 / SceneScale -- 50
		_with_0.look = def.look -- 51
		_with_0.order = def.order -- 52
		layer = _with_0 -- 48
	end -- 48
	if def.ratio then -- 53
		world:setLayerRatio(def.order, def.ratio) -- 54
	end -- 53
	world:addChild(layer) -- 55
	if def.handle then -- 56
		def.handle(layer, world) -- 56
	end -- 56
	return layer -- 57
end -- 47
_module_0 = Class({ -- 60
	sceneWidth = property(function() -- 60
		return W -- 60
	end), -- 60
	offset = property(function() -- 61
		return Offset -- 61
	end), -- 61
	addShadowTo = function(self, unit) -- 63
		local _with_0 = Sprite("Image/shadow.png") -- 64
		_with_0.order = -1 -- 65
		_with_0:schedule(function() -- 66
			_with_0.y = self.offset - unit.y -- 66
		end) -- 66
		_with_0:addTo(unit) -- 67
		return _with_0 -- 64
	end, -- 63
	zoom = property(function(self) -- 69
		return self._zoom -- 69
	end, function(self, value) -- 70
		self._zoom = value -- 71
		return self:updateZoom() -- 72
	end), -- 69
	updateZoom = function(self) -- 74
		local width, height -- 75
		do -- 75
			local _obj_0 = View.size -- 75
			width, height = _obj_0.width, _obj_0.height -- 75
		end -- 75
		local zoom = self._zoom -- 76
		self.camera.zoom = math.max(height / H / zoom, width / W / zoom) -- 77
	end, -- 74
	isUnderground = property(function(self) -- 79
		return self._isUnderground -- 79
	end, function(self, value) -- 80
		self._isUnderground = value -- 81
		local showLayers = value and darkDefs or lightDefs -- 82
		local hideLayers = value and lightDefs or darkDefs -- 83
		for _index_0 = 1, #hideLayers do -- 84
			local def = hideLayers[_index_0] -- 84
			local layer = self:getLayer(def.order) -- 85
			layer:runAction(Opacity(0.5, 1, 0)) -- 86
			layer:schedule(once(function() -- 87
				sleep(0.5) -- 88
				layer.visible = false -- 89
			end)) -- 87
		end -- 84
		for _index_0 = 1, #showLayers do -- 90
			local def = showLayers[_index_0] -- 90
			local layer = self:getLayer(def.order) -- 91
			layer:runAction(Opacity(0.5, 0, 1)) -- 92
			layer.visible = true -- 93
		end -- 90
	end), -- 79
	__partial = function(_self) -- 95
		local _with_0 = PlatformWorld() -- 96
		local _with_1 = _with_0.camera -- 97
		_with_1.boundary = Rect(0, 0, W, H) -- 98
		_with_1.followRatio = Vec2(0.03, 0.03) -- 99
		return _with_0 -- 96
	end, -- 95
	__init = function(self, highSpeed) -- 101
		if highSpeed == nil then -- 101
			highSpeed = true -- 101
		end -- 101
		for i = -MaxPath, MaxPath do -- 102
			self:setLayerOffset(i, PathOffset * -i) -- 103
		end -- 102
		for _index_0 = 1, #layerDefs do -- 105
			local def = layerDefs[_index_0] -- 105
			if not (def.highSpeed ~= nil) or def.highSpeed == highSpeed then -- 106
				addLayer(self, def) -- 107
			end -- 106
		end -- 105
		local terrainDef -- 109
		do -- 109
			local _with_0 = BodyDef() -- 109
			_with_0.type = "Static" -- 110
			_with_0:attachPolygon(Vec2(HW, 0), W, 10, 0, 1, 1, 0) -- 111
			_with_0:attachPolygon(Vec2(HW, H), W, 10, 0, 1, 1, 0) -- 112
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 113
			_with_0:attachPolygon(Vec2(W, HH), 10, H, 0, 1, 1, 0) -- 114
			_with_0.position = Vec2(0, Offset) -- 115
			terrainDef = _with_0 -- 109
		end -- 109
		do -- 117
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 117
			_with_0.group = Data.groupTerrain -- 118
			_with_0:addTo(self) -- 119
		end -- 117
		self._zoom = 1.0 -- 121
		self:gslot("AppChange", function(settingName) -- 122
			if settingName == "Size" then -- 122
				return self:updateZoom() -- 122
			end -- 122
		end) -- 122
		self:updateZoom() -- 123
		self.speed = highSpeed and 2.0 or 1.0 -- 125
		self:emit("SpeedUp") -- 126
		return self:schedule(loop(function() -- 127
			sleep(math.random(5, 30)) -- 128
			self.isUnderground = not self.isUnderground -- 129
		end)) -- 127
	end, -- 101
	loadAsync = function(_self) -- 131
		return Cache:loadAsync("spine:train") -- 131
	end -- 131
}) -- 59
return _module_0 -- 1
