-- [yue]: Script/Scene/Factory.yue
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
local Offset <const> = 130 -- 8
local PathOffset <const> = Vec2(50, -25) -- 9
local MaxPath <const> = 2 -- 10
local DefaultZoom <const> = 1.0 -- 11
local layerDefs = { -- 20
	{ -- 20
		look = "shadow", -- 20
		order = 100, -- 20
		ratio = Vec2(-0.2, 0) -- 20
	}, -- 20
	{ -- 21
		look = "front", -- 21
		order = 99, -- 21
		ratio = Vec2(-0.2, 0) -- 21
	}, -- 21
	{ -- 22
		look = "road", -- 22
		order = -100 -- 22
	}, -- 22
	{ -- 23
		look = "back1", -- 23
		order = -101, -- 23
		ratio = Vec2(0.8, 0) -- 23
	}, -- 23
	{ -- 24
		look = "back1.5", -- 24
		order = -102, -- 24
		ratio = Vec2(0.77, 0) -- 24
	}, -- 24
	{ -- 25
		look = "back2", -- 25
		order = -103, -- 25
		ratio = Vec2(0.72, 0), -- 25
		offset = Vec2(50, 0) -- 25
	}, -- 25
	{ -- 26
		look = "back4", -- 26
		order = -104, -- 26
		ratio = Vec2(0.78, 0) -- 26
	}, -- 26
	{ -- 27
		look = "back4.5", -- 27
		order = -105, -- 27
		ratio = Vec2(0.8, 0) -- 27
	}, -- 27
	{ -- 28
		look = "back3", -- 28
		order = -106, -- 28
		ratio = Vec2(0.76, 0) -- 28
	}, -- 28
	{ -- 29
		look = "back5", -- 29
		order = -107, -- 29
		ratio = Vec2(0.79, 0) -- 29
	}, -- 29
	{ -- 30
		look = "back5.5", -- 30
		order = -108, -- 30
		ratio = Vec2(0.8, 0) -- 30
	}, -- 30
	{ -- 31
		look = "back6", -- 31
		order = -109, -- 31
		ratio = Vec2(0.82, 0), -- 31
		offset = Vec2(-150, 0) -- 31
	}, -- 31
	{ -- 32
		look = "back7", -- 32
		order = -110, -- 32
		ratio = Vec2(0.84, 0) -- 32
	}, -- 32
	{ -- 33
		look = "back8", -- 33
		order = -111, -- 33
		ratio = Vec2(0.86, 0) -- 33
	}, -- 33
	{ -- 34
		look = "fog", -- 34
		order = -112, -- 34
		ratio = Vec2(0.88, 0) -- 34
	}, -- 34
	{ -- 35
		look = "back9", -- 35
		order = -113, -- 35
		ratio = Vec2(0.9, 0) -- 35
	} -- 35
} -- 19
local addLayer -- 37
addLayer = function(world, def) -- 37
	local layer -- 38
	do -- 38
		local _with_0 = Spine("factory") -- 38
		_with_0.look = def.look -- 39
		_with_0.order = def.order -- 40
		layer = _with_0 -- 38
	end -- 38
	if def.ratio then -- 41
		world:setLayerRatio(def.order, def.ratio) -- 42
	end -- 41
	if def.offset then -- 43
		world:setLayerOffset(def.order, def.offset) -- 44
	end -- 43
	world:addChild(layer) -- 45
	if def.handle then -- 46
		def.handle(layer) -- 46
	end -- 46
	return layer -- 47
end -- 37
_module_0 = Class({ -- 50
	sceneWidth = property(function() -- 50
		return W -- 50
	end), -- 50
	offset = property(function() -- 51
		return Offset -- 51
	end), -- 51
	addShadowTo = function(self, unit) -- 53
		local _with_0 = Sprite("Image/shadow.png") -- 54
		_with_0.order = -1 -- 55
		_with_0:schedule(function() -- 56
			_with_0.y = self.offset - unit.y -- 56
		end) -- 56
		_with_0:addTo(unit) -- 57
		return _with_0 -- 54
	end, -- 53
	zoom = property(function(self) -- 59
		return self._zoom -- 59
	end, function(self, value) -- 60
		self._zoom = value -- 61
		return self:updateZoom() -- 62
	end), -- 59
	updateZoom = function(self) -- 64
		local scale = View.scale -- 65
		local width, height -- 66
		do -- 66
			local _obj_0 = View.size * Vec2(scale, scale) -- 66
			width, height = _obj_0.width, _obj_0.height -- 66
		end -- 66
		local zoom = self._zoom / DefaultZoom -- 67
		zoom = math.max(width / W / zoom, height / H / zoom) -- 68
		local realWidth = math.min(W / zoom, W) -- 69
		local realHeight = math.min(H / zoom, H) -- 70
		zoom = math.max(W / realWidth, H / realHeight) -- 71
		self.camera.zoom = zoom / scale -- 72
	end, -- 64
	__partial = function(_) -- 74
		local _with_0 = PlatformWorld() -- 75
		do -- 76
			local _with_1 = _with_0.camera -- 76
			_with_1.boundary = Rect(0, 0, W, H) -- 77
			_with_1.followRatio = Vec2(0.03, 0.03) -- 78
		end -- 76
		_with_0.tag = "Factory" -- 79
		return _with_0 -- 75
	end, -- 74
	__init = function(self) -- 81
		for i = -MaxPath, MaxPath do -- 82
			self:setLayerOffset(i, PathOffset * i) -- 83
		end -- 82
		for _index_0 = 1, #layerDefs do -- 85
			local def = layerDefs[_index_0] -- 85
			addLayer(self, def) -- 86
		end -- 85
		local terrainDef -- 88
		do -- 88
			local _with_0 = BodyDef() -- 88
			_with_0.type = "Static" -- 89
			_with_0:attachPolygon(Vec2(HW, 0), W, 10, 0, 1, 1, 0) -- 90
			_with_0:attachPolygon(Vec2(HW, H), W, 10, 0, 1, 1, 0) -- 91
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 92
			_with_0:attachPolygon(Vec2(W, HH), 10, H, 0, 1, 1, 0) -- 93
			_with_0.position = Vec2(0, Offset) -- 94
			terrainDef = _with_0 -- 88
		end -- 88
		do -- 96
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 96
			_with_0.group = Data.groupTerrain -- 97
			_with_0:addTo(self) -- 98
		end -- 96
		self._zoom = 1.0 -- 100
		self:gslot("AppChange", function(settingName) -- 101
			if settingName == "Size" then -- 101
				return self:updateZoom() -- 101
			end -- 101
		end) -- 101
		return self:updateZoom() -- 102
	end, -- 81
	loadAsync = function(_) -- 104
		return Cache:loadAsync("spine:factory") -- 104
	end -- 104
}) -- 49
return _module_0 -- 1
