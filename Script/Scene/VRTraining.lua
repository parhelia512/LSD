-- [yue]: Script/Scene/VRTraining.yue
local _module_0 = nil -- 1
local _ENV = Dora(Dora.Platformer) -- 1
local require <const> = require -- 2
local Vec2 <const> = Vec2 -- 2
local math <const> = math -- 2
local Content <const> = Content -- 2
local table <const> = table -- 2
local Spine <const> = Spine -- 2
local Class <const> = Class -- 2
local property <const> = property -- 2
local View <const> = View -- 2
local PlatformWorld <const> = PlatformWorld -- 2
local Rect <const> = Rect -- 2
local Sequence <const> = Sequence -- 2
local Opacity <const> = Opacity -- 2
local utf8 <const> = utf8 -- 2
local Label <const> = Label -- 2
local Color3 <const> = Color3 -- 2
local loop <const> = loop -- 2
local Node <const> = Node -- 2
local once <const> = once -- 2
local sleep <const> = sleep -- 2
local Show <const> = Show -- 2
local Ease <const> = Ease -- 2
local Hide <const> = Hide -- 2
local BodyDef <const> = BodyDef -- 2
local Body <const> = Body -- 2
local Data <const> = Data -- 2
local Cache <const> = Cache -- 2
local Struct = require("Utils").Struct -- 3
local u8 = require("utf-8") -- 4
local W <const> = 3840 -- 6
local HW <const> = W / 2 -- 7
local H <const> = 1080 -- 8
local HH <const> = H / 2 -- 9
local Offset <const> = 140 -- 10
local PathOffset <const> = Vec2(50, 30) -- 11
local MaxPath <const> = 2 -- 12
local DefaultZoom <const> = 1.0 -- 13
local FrameScale <const> = 1 -- 15
local FrameLook <const> = "frame1" -- 16
local FrameHeight <const> = 630 -- 17
local FrameWidth <const> = 1308 -- 18
local FrameCol <const> = 21 -- 19
local FrameSize <const> = FrameWidth / FrameCol -- 20
local FrameRow <const> = math.floor(FrameHeight / FrameSize) -- 21
local FrameLen <const> = FrameCol * FrameRow -- 22
local CodeFile <const> = "Data/wenyan-lang.xlsx" -- 24
local codes = Content:loadExcel(CodeFile, { -- 26
	"codes" -- 26
}).codes -- 26
do -- 27
	Struct.Wenyan(codes[1]) -- 28
	table.remove(codes, 1) -- 29
	for _index_0 = 1, #codes do -- 30
		local code = codes[_index_0] -- 30
		Struct:load("Wenyan", code) -- 31
	end -- 30
end -- 27
local layerDefs = { -- 40
	{ -- 40
		look = "floor", -- 40
		order = -100 -- 40
	}, -- 40
	{ -- 41
		look = "stats", -- 41
		order = -101, -- 41
		handle = function(self) -- 41
			self.z = 600 -- 42
			self:play("stat", true) -- 43
			return self -- 41
		end -- 41
	}, -- 41
	{ -- 44
		look = "back", -- 44
		order = -102 -- 44
	} -- 44
} -- 39
local addLayer -- 46
addLayer = function(world, def) -- 46
	local layer -- 47
	do -- 47
		local _with_0 = Spine("VRTraining") -- 47
		_with_0.look = def.look -- 48
		_with_0.order = def.order -- 49
		layer = _with_0 -- 47
	end -- 47
	if def.ratio then -- 50
		world:setLayerRatio(def.order, def.ratio) -- 51
	end -- 50
	if def.offset then -- 52
		world:setLayerOffset(def.order, def.offset) -- 53
	end -- 52
	world:addChild(layer) -- 54
	if def.handle then -- 55
		def.handle(layer) -- 55
	end -- 55
	return layer -- 56
end -- 46
_module_0 = Class({ -- 59
	sceneWidth = property(function() -- 59
		return W -- 59
	end), -- 59
	offset = property(function() -- 60
		return Offset -- 60
	end), -- 60
	addShadowTo = function(_self) end, -- 62
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
		local zoom = self._zoom / DefaultZoom -- 71
		zoom = math.max(width / W / zoom, height / H / zoom) -- 72
		local realWidth = math.min(W / zoom, W) -- 73
		local realHeight = math.min(H / zoom, H) -- 74
		zoom = math.max(W / realWidth, H / realHeight) -- 75
		self.camera.zoom = zoom -- 76
	end, -- 69
	__partial = function(_self) -- 78
		local _with_0 = PlatformWorld() -- 79
		do -- 80
			local _with_1 = _with_0.camera -- 80
			_with_1.boundary = Rect(0, 0, W, H) -- 81
			_with_1.followRatio = Vec2(0.03, 0.03) -- 82
		end -- 80
		_with_0.tag = "VRTraining" -- 83
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
		local code = codes[math.random(1, #codes)] -- 92
		local codeStr = code.code -- 93
		local len = u8.len(codeStr) -- 94
		local start = 1 -- 95
		local i = 0 -- 96
		local lefts = { } -- 97
		local rights = { } -- 98
		local blink = Sequence(Opacity(0.1, 0.2, 1), Opacity(1, 1, 0.2)) -- 99
		while true do -- 103
			i = i + 1 -- 104
			local fontSize = math.floor(FrameSize * FrameScale) - 6 -- 105
			if start >= len then -- 106
				break -- 106
			end -- 106
			local codePanel -- 107
			do -- 107
				local _with_0 = Spine("VRTraining") -- 107
				_with_0.scaleX = FrameScale -- 108
				_with_0.scaleY = FrameScale -- 109
				_with_0.look = FrameLook -- 110
				if i % 2 ~= 0 then -- 111
					_with_0.x = math.random(0, (W / 2) - math.floor(FrameWidth * FrameScale) - 600) -- 112
				else -- 114
					_with_0.x = math.random((W / 2) + 600, W - math.floor(FrameWidth * FrameScale)) -- 114
				end -- 111
				_with_0.y = math.random(350, H - math.floor(FrameHeight * FrameScale) - 100) -- 115
				_with_0.z = math.random(100, 500) -- 116
				_with_0.order = -3 -- 117
				_with_0.visible = false -- 118
				_with_0.opacity = 0 -- 119
				codePanel = _with_0 -- 107
			end -- 107
			if i % 2 ~= 0 then -- 120
				table.insert(lefts, codePanel) -- 121
			else -- 123
				table.insert(rights, codePanel) -- 123
			end -- 120
			self:addChild(codePanel) -- 124
			local str = u8.sub(codeStr, start, start + FrameLen - 1) -- 125
			local row = 1 -- 126
			local col = 1 -- 127
			local chars -- 128
			do -- 128
				local _accum_0 = { } -- 128
				local _len_0 = 1 -- 128
				for _, c in utf8.codes(str) do -- 128
					local ch = utf8.char(c) -- 129
					local label -- 130
					do -- 130
						local _with_0 = Label("DroidSansFallback", fontSize) -- 130
						_with_0.color3 = Color3(0x4aa0e8) -- 131
						_with_0.text = ch -- 132
						_with_0.x = (FrameWidth - (FrameSize / 2) - FrameSize * (col - 1)) * FrameScale -- 133
						_with_0.y = (FrameHeight - (FrameSize / 2) - FrameSize * (row - 1)) * FrameScale -- 134
						_with_0.opacity = 0.2 -- 135
						label = _with_0 -- 130
					end -- 130
					codePanel:addChild(label) -- 136
					row = row + 1 -- 137
					if row > FrameRow then -- 138
						row = 1 -- 139
						col = col + 1 -- 140
					end -- 138
					_accum_0[_len_0] = label -- 141
					_len_0 = _len_0 + 1 -- 129
				end -- 128
				chars = _accum_0 -- 128
			end -- 128
			codePanel:schedule(loop(function() -- 142
				codePanel:addChild((function() -- 143
					local _with_0 = Node() -- 143
					_with_0:schedule(once(function() -- 144
						for _index_0 = 1, #chars do -- 145
							local char = chars[_index_0] -- 145
							char:perform(blink) -- 146
							sleep(0.01) -- 147
						end -- 145
						return _with_0:removeFromParent() -- 148
					end)) -- 144
					return _with_0 -- 143
				end)()) -- 143
				return sleep(2) -- 149
			end)) -- 142
			start = start + FrameLen -- 150
		end -- 103
		local index = 1 -- 151
		local count = math.max(#lefts, #rights) -- 152
		self:schedule(loop(function() -- 153
			local left = lefts[index] -- 154
			local right = rights[index] -- 155
			if left then -- 159
				left:perform(Sequence(Show(), Opacity(5, 0, 1, Ease.InQuad))) -- 156
			end -- 159
			if right then -- 163
				right:perform(Sequence(Show(), Opacity(5, 0, 1, Ease.InQuad))) -- 160
			end -- 163
			if count == 1 then -- 164
				return true -- 164
			end -- 164
			sleep(10) -- 165
			if left then -- 169
				left:perform(Sequence(Opacity(5, 1, 0, Ease.OutQuad), Hide())) -- 166
			end -- 169
			if right then -- 173
				right:perform(Sequence(Opacity(5, 1, 0, Ease.OutQuad), Hide())) -- 170
			end -- 173
			index = index + 1 -- 174
			if index > count then -- 175
				index = 1 -- 175
			end -- 175
		end)) -- 153
		local terrainDef -- 176
		do -- 176
			local _with_0 = BodyDef() -- 176
			_with_0.type = "Static" -- 177
			_with_0:attachPolygon(Vec2(HW, 0), W, 10, 0, 1, 1, 0) -- 178
			_with_0:attachPolygon(Vec2(HW, H), W, 10, 0, 1, 1, 0) -- 179
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 180
			_with_0:attachPolygon(Vec2(W, HH), 10, H, 0, 1, 1, 0) -- 181
			_with_0.position = Vec2(0, Offset) -- 182
			terrainDef = _with_0 -- 176
		end -- 176
		do -- 184
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 184
			_with_0.group = Data.groupTerrain -- 185
			_with_0:addTo(self) -- 186
		end -- 184
		self._zoom = 1.0 -- 188
		self:gslot("AppChange", function(settingName) -- 189
			if settingName == "Size" then -- 189
				return self:updateZoom() -- 189
			end -- 189
		end) -- 189
		return self:updateZoom() -- 190
	end, -- 85
	loadAsync = function(_self) -- 192
		return Cache:loadAsync("spine:VRTraining") -- 192
	end -- 192
}) -- 58
return _module_0 -- 1
