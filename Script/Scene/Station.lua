-- [yue]: Script/Scene/Station.yue
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
local PathOffset <const> = Vec2(50, -25) -- 9
local MaxPath <const> = 2 -- 10
local DefaultZoom <const> = 1.0 -- 11
local layerDefs = { -- 20
	{ -- 20
		look = "frontUp", -- 20
		order = 100, -- 20
		ratio = Vec2(-0.2, 0) -- 20
	}, -- 20
	{ -- 21
		look = "frontDown", -- 21
		order = 99, -- 21
		ratio = Vec2(-0.2, 0) -- 21
	}, -- 21
	{ -- 22
		look = "floor", -- 22
		order = -100 -- 22
	}, -- 22
	{ -- 23
		look = "car", -- 23
		order = -101, -- 23
		ratio = Vec2(0.2, 0) -- 23
	}, -- 23
	{ -- 24
		look = "light", -- 24
		order = -102, -- 24
		ratio = Vec2(0.4, 0) -- 24
	}, -- 24
	{ -- 25
		look = "back1", -- 25
		order = -103, -- 25
		ratio = Vec2(0.4, 0) -- 25
	}, -- 25
	{ -- 26
		look = "back2", -- 26
		order = -104, -- 26
		ratio = Vec2(0.6, 0) -- 26
	} -- 26
} -- 19
local addLayer -- 28
addLayer = function(world, def) -- 28
	local layer -- 29
	do -- 29
		local _with_0 = Spine("station") -- 29
		_with_0.look = def.look -- 30
		_with_0.order = def.order -- 31
		layer = _with_0 -- 29
	end -- 29
	if def.ratio then -- 32
		world:setLayerRatio(def.order, def.ratio) -- 33
	end -- 32
	if def.offset then -- 34
		world:setLayerOffset(def.order, def.offset) -- 35
	end -- 34
	world:addChild(layer) -- 36
	if def.handle then -- 37
		def.handle(layer) -- 37
	end -- 37
	return layer -- 38
end -- 28
_module_0 = Class({ -- 41
	sceneWidth = property(function() -- 41
		return W -- 41
	end), -- 41
	offset = property(function() -- 42
		return Offset -- 42
	end), -- 42
	addShadowTo = function(self, unit) -- 44
		local _with_0 = Sprite("Image/shadow.png") -- 45
		_with_0.order = -1 -- 46
		_with_0:schedule(function() -- 47
			_with_0.y = self.offset - unit.y -- 47
		end) -- 47
		_with_0:addTo(unit) -- 48
		return _with_0 -- 45
	end, -- 44
	zoom = property(function(self) -- 50
		return self._zoom -- 50
	end, function(self, value) -- 51
		self._zoom = value -- 52
		return self:updateZoom() -- 53
	end), -- 50
	updateZoom = function(self) -- 55
		local scale = View.scale -- 56
		local width, height -- 57
		do -- 57
			local _obj_0 = View.size * Vec2(scale, scale) -- 57
			width, height = _obj_0.width, _obj_0.height -- 57
		end -- 57
		local zoom = self._zoom / DefaultZoom -- 58
		zoom = math.max(width / W / zoom, height / H / zoom) -- 59
		local realWidth = math.min(W / zoom, W) -- 60
		local realHeight = math.min(H / zoom, H) -- 61
		zoom = math.max(W / realWidth, H / realHeight) -- 62
		self.camera.zoom = zoom / scale -- 63
	end, -- 55
	__partial = function(_self) -- 65
		local _with_0 = PlatformWorld() -- 66
		do -- 67
			local _with_1 = _with_0.camera -- 67
			_with_1.boundary = Rect(0, 0, W, H) -- 68
			_with_1.followRatio = Vec2(0.03, 0.03) -- 69
		end -- 67
		_with_0.tag = "Station" -- 70
		return _with_0 -- 66
	end, -- 65
	__init = function(self) -- 72
		for i = -MaxPath, MaxPath do -- 73
			self:setLayerOffset(i, PathOffset * i) -- 74
		end -- 73
		for _index_0 = 1, #layerDefs do -- 76
			local def = layerDefs[_index_0] -- 76
			addLayer(self, def) -- 77
		end -- 76
		local terrainDef -- 79
		do -- 79
			local _with_0 = BodyDef() -- 79
			_with_0.type = "Static" -- 80
			_with_0:attachPolygon(Vec2(HW, 0), W, 10, 0, 1, 1, 0) -- 81
			_with_0:attachPolygon(Vec2(HW, H), W, 10, 0, 1, 1, 0) -- 82
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 83
			_with_0:attachPolygon(Vec2(W, HH), 10, H, 0, 1, 1, 0) -- 84
			_with_0.position = Vec2(0, Offset) -- 85
			terrainDef = _with_0 -- 79
		end -- 79
		do -- 87
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 87
			_with_0.group = Data.groupTerrain -- 88
			_with_0:addTo(self) -- 89
		end -- 87
		self._zoom = 1.0 -- 91
		self:gslot("AppChange", function(settingName) -- 92
			if settingName == "Size" then -- 92
				return self:updateZoom() -- 92
			end -- 92
		end) -- 92
		return self:updateZoom() -- 93
	end, -- 72
	loadAsync = function(_self) -- 95
		return Cache:loadAsync("spine:station") -- 95
	end -- 95
}) -- 40
return _module_0 -- 1
