-- [yue]: Script/Scene/FrozenCity.yue
local _module_0 = nil -- 1
local _ENV = Dora(Dora.Platformer) -- 1
local Vec2 <const> = Vec2 -- 2
local Spine <const> = Spine -- 2
local Class <const> = Class -- 2
local property <const> = property -- 2
local Sprite <const> = Sprite -- 2
local View <const> = View -- 2
local math <const> = math -- 2
local PlatformWorld <const> = PlatformWorld -- 2
local Rect <const> = Rect -- 2
local BodyDef <const> = BodyDef -- 2
local Body <const> = Body -- 2
local Data <const> = Data -- 2
local Cache <const> = Cache -- 2
local W <const> = 11520 -- 4
local HW <const> = W / 2 -- 5
local H <const> = 1080 -- 6
local HH <const> = H / 2 -- 7
local Offset <const> = 100 -- 8
local PathOffset <const> = Vec2(50, 30) -- 9
local MaxPath <const> = 2 -- 10
local DefaultZoom <const> = 1.0 -- 11
local layerDefs = { -- 20
	{ -- 20
		look = "snow", -- 20
		order = 100, -- 20
		ratio = Vec2(1, 0), -- 20
		handle = function(self) -- 20
			self:play("idle", true) -- 21
			return self -- 20
		end -- 20
	}, -- 20
	{ -- 22
		look = "front", -- 22
		order = 99, -- 22
		ratio = Vec2(-0.2, 0) -- 22
	}, -- 22
	{ -- 23
		look = "road", -- 23
		order = -100 -- 23
	}, -- 23
	{ -- 24
		look = "fog", -- 24
		order = -101, -- 24
		ratio = Vec2(0.8, 0), -- 24
		handle = function(self) -- 24
			self:play("idle", true) -- 25
			return self -- 24
		end -- 24
	}, -- 24
	{ -- 26
		look = "back0", -- 26
		order = -102, -- 26
		ratio = Vec2(0.72, 0), -- 26
		handle = function(self) -- 26
			self:play("idle", true) -- 27
			return self -- 26
		end -- 26
	}, -- 26
	{ -- 28
		look = "back1", -- 28
		order = -103, -- 28
		ratio = Vec2(0.74, 0) -- 28
	}, -- 28
	{ -- 29
		look = "back2", -- 29
		order = -104, -- 29
		ratio = Vec2(0.76, 0) -- 29
	}, -- 29
	{ -- 30
		look = "back3", -- 30
		order = -105, -- 30
		ratio = Vec2(0.78, 0) -- 30
	}, -- 30
	{ -- 31
		look = "back4", -- 31
		order = -106, -- 31
		ratio = Vec2(0.8, 0) -- 31
	}, -- 31
	{ -- 32
		look = "back5", -- 32
		order = -107, -- 32
		ratio = Vec2(0.82, 0) -- 32
	}, -- 32
	{ -- 33
		look = "back6", -- 33
		order = -108, -- 33
		ratio = Vec2(0.84, 0) -- 33
	}, -- 33
	{ -- 34
		look = "back7", -- 34
		order = -109, -- 34
		ratio = Vec2(0.86, 0) -- 34
	}, -- 34
	{ -- 35
		look = "back8", -- 35
		order = -110, -- 35
		ratio = Vec2(0.9, 0) -- 35
	}, -- 35
	{ -- 36
		look = "back9", -- 36
		order = -111, -- 36
		ratio = Vec2(0.92, 0) -- 36
	}, -- 36
	{ -- 37
		look = "cloud", -- 37
		order = -112, -- 37
		ratio = Vec2(0.9, 0), -- 37
		handle = function(self) -- 37
			self:play("idle", true) -- 38
			return self -- 37
		end -- 37
	}, -- 37
	{ -- 39
		look = "sky", -- 39
		order = -113, -- 39
		ratio = Vec2(1, 0) -- 39
	} -- 39
} -- 19
local addLayer -- 41
addLayer = function(world, def) -- 41
	local layer -- 42
	do -- 42
		local _with_0 = Spine("frozenCity") -- 42
		_with_0.look = def.look -- 43
		_with_0.order = def.order -- 44
		layer = _with_0 -- 42
	end -- 42
	if def.ratio then -- 45
		world:setLayerRatio(def.order, def.ratio) -- 46
	end -- 45
	if def.offset then -- 47
		world:setLayerOffset(def.order, def.offset) -- 48
	end -- 47
	world:addChild(layer) -- 49
	if def.handle then -- 50
		def.handle(layer) -- 50
	end -- 50
	return layer -- 51
end -- 41
_module_0 = Class({ -- 54
	sceneWidth = property(function() -- 54
		return W -- 54
	end), -- 54
	offset = property(function() -- 55
		return Offset -- 55
	end), -- 55
	addShadowTo = function(self, unit) -- 57
		local _with_0 = Sprite("Image/shadow.png") -- 58
		_with_0.order = -1 -- 59
		_with_0:schedule(function() -- 60
			_with_0.y = self.offset - unit.y -- 60
		end) -- 60
		_with_0:addTo(unit) -- 61
		return _with_0 -- 58
	end, -- 57
	zoom = property(function(self) -- 63
		return self._zoom -- 63
	end, function(self, value) -- 64
		self._zoom = value -- 65
		return self:updateZoom() -- 66
	end), -- 63
	updateZoom = function(self) -- 68
		local scale = View.scale -- 69
		local width, height -- 70
		do -- 70
			local _obj_0 = View.size * Vec2(scale, scale) -- 70
			width, height = _obj_0.width, _obj_0.height -- 70
		end -- 70
		local zoom = self._zoom / DefaultZoom -- 71
		zoom = math.max(width / W / zoom, height / H / zoom) -- 72
		local realWidth = math.min(W / zoom, W) -- 73
		local realHeight = math.min(H / zoom, H) -- 74
		zoom = math.max(W / realWidth, H / realHeight) -- 75
		self.camera.zoom = zoom / scale -- 76
	end, -- 68
	__partial = function(_) -- 78
		local _with_0 = PlatformWorld() -- 79
		do -- 80
			local _with_1 = _with_0.camera -- 80
			_with_1.boundary = Rect(0, 0, W, H) -- 81
			_with_1.followRatio = Vec2(0.03, 0.03) -- 82
		end -- 80
		_with_0.tag = "FrozenCity" -- 83
		return _with_0 -- 79
	end, -- 78
	__init = function(self) -- 85
		for i = -MaxPath, MaxPath do -- 86
			self:setLayerOffset(i, PathOffset * -i) -- 87
		end -- 86
		for _index_0 = 1, #layerDefs do -- 89
			local def = layerDefs[_index_0] -- 89
			addLayer(self, def) -- 90
		end -- 89
		local terrainDef -- 92
		do -- 92
			local _with_0 = BodyDef() -- 92
			_with_0.type = "Static" -- 93
			_with_0:attachPolygon(Vec2(HW, 0), W, 10, 0, 1, 1, 0) -- 94
			_with_0:attachPolygon(Vec2(HW, H), W, 10, 0, 1, 1, 0) -- 95
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 96
			_with_0:attachPolygon(Vec2(W, HH), 10, H, 0, 1, 1, 0) -- 97
			_with_0.position = Vec2(0, Offset) -- 98
			terrainDef = _with_0 -- 92
		end -- 92
		do -- 100
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 100
			_with_0.group = Data.groupTerrain -- 101
			_with_0:addTo(self) -- 102
		end -- 100
		self._zoom = 1.0 -- 104
		self:gslot("AppChange", function(settingName) -- 105
			if settingName == "Size" then -- 105
				return self:updateZoom() -- 105
			end -- 105
		end) -- 105
		return self:updateZoom() -- 106
	end, -- 85
	loadAsync = function(_) -- 108
		return Cache:loadAsync("spine:frozenCity") -- 108
	end -- 108
}) -- 53
return _module_0 -- 1
