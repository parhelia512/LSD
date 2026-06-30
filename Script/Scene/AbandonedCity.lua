-- [yue]: Script/Scene/AbandonedCity.yue
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
local Offset <const> = 230 -- 8
local PathOffset <const> = Vec2(50, -25) -- 9
local MaxPath <const> = 2 -- 10
local DefaultZoom <const> = 1.0 -- 11
local layerDefs = { -- 20
	{ -- 20
		look = "front", -- 20
		order = 100, -- 20
		ratio = Vec2(-0.2, 0) -- 20
	}, -- 20
	{ -- 21
		look = "road", -- 21
		order = -100 -- 21
	}, -- 21
	{ -- 22
		look = "back1", -- 22
		order = -101, -- 22
		ratio = Vec2(0.7, 0) -- 22
	}, -- 22
	{ -- 23
		look = "back2", -- 23
		order = -102, -- 23
		ratio = Vec2(0.76, 0), -- 23
		handle = function(self) -- 23
			self:play("idle", true) -- 24
			return self -- 23
		end -- 23
	}, -- 23
	{ -- 25
		look = "back3", -- 25
		order = -103, -- 25
		ratio = Vec2(0.73, 0) -- 25
	}, -- 25
	{ -- 26
		look = "back4", -- 26
		order = -104, -- 26
		ratio = Vec2(0.76, 0) -- 26
	}, -- 26
	{ -- 27
		look = "back5", -- 27
		order = -105, -- 27
		ratio = Vec2(0.80, 0) -- 27
	}, -- 27
	{ -- 28
		look = "back6c1", -- 28
		order = -106, -- 28
		ratio = Vec2(0.8, 0), -- 28
		handle = function(self) -- 28
			self:play("cloud1", true) -- 29
			return self -- 28
		end -- 28
	}, -- 28
	{ -- 30
		look = "back6c2", -- 30
		order = -107, -- 30
		ratio = Vec2(0.82, 0), -- 30
		handle = function(self) -- 30
			self:play("cloud2", true) -- 31
			return self -- 30
		end -- 30
	}, -- 30
	{ -- 32
		look = "back7", -- 32
		order = -108, -- 32
		ratio = Vec2(0.84, 0) -- 32
	}, -- 32
	{ -- 33
		look = "back8c", -- 33
		order = -109, -- 33
		ratio = Vec2(0.86, 0), -- 33
		handle = function(self) -- 33
			self:play("cloud3", true) -- 34
			return self -- 33
		end -- 33
	}, -- 33
	{ -- 35
		look = "bk", -- 35
		order = -110, -- 35
		ratio = Vec2(1, 0) -- 35
	} -- 35
} -- 19
local addLayer -- 37
addLayer = function(world, def) -- 37
	local layer -- 38
	do -- 38
		local _with_0 = Spine("abandonedCity") -- 38
		_with_0.look = def.look -- 39
		_with_0.order = def.order -- 40
		layer = _with_0 -- 38
	end -- 38
	if def.ratio then -- 41
		world:setLayerRatio(def.order, def.ratio) -- 42
	end -- 41
	world:addChild(layer) -- 43
	if def.handle then -- 44
		def.handle(layer) -- 44
	end -- 44
	return layer -- 45
end -- 37
_module_0 = Class({ -- 48
	sceneWidth = property(function() -- 48
		return W -- 48
	end), -- 48
	offset = property(function() -- 49
		return Offset -- 49
	end), -- 49
	addShadowTo = function(self, unit) -- 51
		local _with_0 = Sprite("Image/shadow.png") -- 52
		_with_0.order = -1 -- 53
		_with_0:schedule(function() -- 54
			_with_0.y = self.offset - unit.y -- 54
		end) -- 54
		_with_0:addTo(unit) -- 55
		return _with_0 -- 52
	end, -- 51
	zoom = property(function(self) -- 57
		return self._zoom -- 57
	end, function(self, value) -- 58
		self._zoom = value -- 59
		return self:updateZoom() -- 60
	end), -- 57
	updateZoom = function(self) -- 62
		local scale = View.scale -- 63
		local width, height -- 64
		do -- 64
			local _obj_0 = View.size * Vec2(scale, scale) -- 64
			width, height = _obj_0.width, _obj_0.height -- 64
		end -- 64
		local zoom = self._zoom / DefaultZoom -- 65
		zoom = math.max(width / W / zoom, height / H / zoom) -- 66
		local realWidth = math.min(W / zoom, W) -- 67
		local realHeight = math.min(H / zoom, H) -- 68
		zoom = math.max(W / realWidth, H / realHeight) -- 69
		self.camera.zoom = zoom / scale -- 70
	end, -- 62
	__partial = function(_) -- 72
		local _with_0 = PlatformWorld() -- 73
		do -- 74
			local _with_1 = _with_0.camera -- 74
			_with_1.boundary = Rect(0, 0, W, H) -- 75
			_with_1.followRatio = Vec2(0.03, 0.03) -- 76
		end -- 74
		_with_0.tag = "AbandonedCity" -- 77
		return _with_0 -- 73
	end, -- 72
	__init = function(self) -- 79
		for i = -MaxPath, MaxPath do -- 80
			self:setLayerOffset(i, PathOffset * i) -- 81
		end -- 80
		for _index_0 = 1, #layerDefs do -- 83
			local def = layerDefs[_index_0] -- 83
			addLayer(self, def) -- 84
		end -- 83
		local terrainDef -- 86
		do -- 86
			local _with_0 = BodyDef() -- 86
			_with_0.type = "Static" -- 87
			_with_0:attachPolygon(Vec2(HW, 0), W, 10, 0, 1, 1, 0) -- 88
			_with_0:attachPolygon(Vec2(HW, H), W, 10, 0, 1, 1, 0) -- 89
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 90
			_with_0:attachPolygon(Vec2(W, HH), 10, H, 0, 1, 1, 0) -- 91
			_with_0.position = Vec2(0, Offset) -- 92
			terrainDef = _with_0 -- 86
		end -- 86
		do -- 94
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 94
			_with_0.group = Data.groupTerrain -- 95
			_with_0:addTo(self) -- 96
		end -- 94
		self._zoom = 1.0 -- 98
		self:gslot("AppChange", function(settingName) -- 99
			if settingName == "Size" then -- 99
				return self:updateZoom() -- 99
			end -- 99
		end) -- 99
		return self:updateZoom() -- 100
	end, -- 79
	loadAsync = function(_) -- 102
		return Cache:loadAsync("spine:abandonedCity") -- 102
	end -- 102
}) -- 47
return _module_0 -- 1
