-- [yue]: Script/Scene/Passage.yue
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
local ClipNode <const> = ClipNode -- 2
local BodyDef <const> = BodyDef -- 2
local Body <const> = Body -- 2
local Data <const> = Data -- 2
local Array <const> = Array -- 2
local Cache <const> = Cache -- 2
local Rectangle = require("UI.View.Shape.Rectangle") -- 3
local Map = require("Academy.Map") -- 4
local H <const> = 940 -- 6
local HH <const> = H / 2 -- 7
local Offset <const> = 0 -- 8
local BackZ <const> = 470 -- 9
local ZOffset <const> = BackZ / 2 -- 10
local PathOffset <const> = 80 -- 11
local MaxPath <const> = 2 -- 12
local DefaultZoom <const> = 0.7 -- 13
local passageDefs = { -- 22
	{ -- 22
		w = 790, -- 22
		items = { -- 24
			{ -- 24
				look = "spotlight1", -- 24
				order = 100, -- 24
				z = ZOffset -- 24
			}, -- 24
			{ -- 25
				look = "leftwall", -- 25
				order = -110, -- 25
				angleY = -90 -- 25
			}, -- 25
			{ -- 26
				look = "rightwall", -- 26
				order = -111, -- 26
				x = 790, -- 26
				angleY = 90 -- 26
			}, -- 26
			{ -- 27
				look = "floor1", -- 27
				order = -112, -- 27
				angleX = 90 -- 27
			}, -- 27
			{ -- 28
				look = "back1", -- 28
				order = -113, -- 28
				z = BackZ -- 28
			} -- 28
		}, -- 23
		elevator = { -- 30
			frame = { -- 30
				look = "elevator", -- 30
				order = -100, -- 30
				x = 790 / 2, -- 30
				z = BackZ -- 30
			}, -- 30
			door = { -- 31
				look = "elevatordoor", -- 31
				order = -101, -- 31
				x = 790 / 2, -- 31
				z = BackZ -- 31
			}, -- 31
			floor = { -- 32
				look = "elevatorfloor", -- 32
				order = -102, -- 32
				x = 790 / 2, -- 32
				z = BackZ, -- 32
				angleX = 90 -- 32
			}, -- 32
			back = { -- 33
				look = "elevatorback", -- 33
				order = -103, -- 33
				x = 790 / 2, -- 33
				z = BackZ + 134 -- 33
			} -- 33
		} -- 29
	}, -- 22
	{ -- 34
		w = 1570, -- 34
		items = { -- 36
			{ -- 36
				look = "spotlight2", -- 36
				order = 100, -- 36
				z = ZOffset -- 36
			}, -- 36
			{ -- 37
				look = "leftwall", -- 37
				order = -110, -- 37
				angleY = -90 -- 37
			}, -- 37
			{ -- 38
				look = "rightwall", -- 38
				order = -111, -- 38
				x = 1570, -- 38
				angleY = 90 -- 38
			}, -- 38
			{ -- 39
				look = "floor2", -- 39
				order = -112, -- 39
				angleX = 90 -- 39
			}, -- 39
			{ -- 40
				look = "back2", -- 40
				order = -113, -- 40
				z = BackZ -- 40
			} -- 40
		}, -- 35
		elevator = { -- 42
			frame = { -- 42
				look = "elevator", -- 42
				order = -100, -- 42
				x = 1570 / 2, -- 42
				z = BackZ -- 42
			}, -- 42
			door = { -- 43
				look = "elevatordoor", -- 43
				order = -101, -- 43
				x = 1570 / 2, -- 43
				z = BackZ -- 43
			}, -- 43
			floor = { -- 44
				look = "elevatorfloor", -- 44
				order = -102, -- 44
				x = 1570 / 2, -- 44
				z = BackZ, -- 44
				angleX = 90 -- 44
			}, -- 44
			back = { -- 45
				look = "elevatorback", -- 45
				order = -103, -- 45
				x = 1570 / 2, -- 45
				z = BackZ + 134 -- 45
			} -- 45
		} -- 41
	}, -- 34
	{ -- 46
		w = 2344, -- 46
		items = { -- 48
			{ -- 48
				look = "spotlight3", -- 48
				order = 100, -- 48
				z = ZOffset -- 48
			}, -- 48
			{ -- 49
				look = "leftwall", -- 49
				order = -110, -- 49
				angleY = -90 -- 49
			}, -- 49
			{ -- 50
				look = "rightwall", -- 50
				order = -111, -- 50
				x = 2344, -- 50
				angleY = 90 -- 50
			}, -- 50
			{ -- 51
				look = "floor3", -- 51
				order = -112, -- 51
				angleX = 90 -- 51
			}, -- 51
			{ -- 52
				look = "back3", -- 52
				order = -113, -- 52
				z = BackZ -- 52
			} -- 52
		}, -- 47
		elevator = { -- 54
			frame = { -- 54
				look = "elevator", -- 54
				order = -100, -- 54
				x = 1558, -- 54
				z = BackZ -- 54
			}, -- 54
			door = { -- 55
				look = "elevatordoor", -- 55
				order = -101, -- 55
				x = 1558, -- 55
				z = BackZ -- 55
			}, -- 55
			floor = { -- 56
				look = "elevatorfloor", -- 56
				order = -102, -- 56
				x = 1558, -- 56
				z = BackZ, -- 56
				angleX = 90 -- 56
			}, -- 56
			back = { -- 57
				look = "elevatorback", -- 57
				order = -103, -- 57
				x = 1558, -- 57
				z = BackZ + 134 -- 57
			} -- 57
		} -- 53
	} -- 46
} -- 21
local createLayer -- 59
createLayer = function(def) -- 59
	local _with_0 = Spine("passage") -- 60
	_with_0.look = def.look -- 61
	_with_0.order = def.order -- 62
	_with_0.scaleX = def.scale or 1.0 -- 63
	_with_0.scaleY = def.scale or 1.0 -- 64
	_with_0.x = def.x or 0 -- 65
	_with_0.y = def.y or 0 -- 66
	_with_0.z = def.z or 0 -- 67
	_with_0.angleX = def.angleX or 0 -- 68
	_with_0.angleY = def.angleY or 0 -- 69
	_with_0.x = def.x or 0 -- 70
	return _with_0 -- 60
end -- 59
local addLayer -- 72
addLayer = function(world, def) -- 72
	local layer = createLayer(def) -- 73
	if def.ratio then -- 74
		world:setLayerRatio(def.order, def.ratio) -- 75
	end -- 74
	if def.offset then -- 76
		world:setLayerOffset(def.order, def.offset) -- 77
	end -- 76
	world:addChild(layer) -- 78
	if def.handle then -- 79
		def.handle(layer) -- 79
	end -- 79
	return layer -- 80
end -- 72
local _anon_func_0 = function(back, createLayer, floor, mask) -- 161
	local _with_0 = ClipNode(mask) -- 161
	_with_0:addChild(createLayer(back)) -- 162
	_with_0:addChild(createLayer(floor)) -- 163
	_with_0.order = back.order -- 164
	return _with_0 -- 161
end -- 161
_module_0 = Class({ -- 83
	sceneWidth = property(function(self) -- 83
		return self._width -- 83
	end), -- 83
	offset = property(function() -- 84
		return Offset -- 84
	end), -- 84
	left = property(function(self) -- 85
		return Vec2(100, self.offset) -- 85
	end), -- 85
	right = property(function(self) -- 86
		return Vec2(self.sceneWidth - 100, self.offset) -- 86
	end), -- 86
	center = property(function(self) -- 87
		local elevator = self._layers.elevatorDoor -- 88
		if elevator then -- 88
			return Vec2(elevator.x, self.offset) -- 89
		else -- 91
			return nil -- 91
		end -- 88
	end), -- 87
	addShadowTo = function(self, unit) -- 93
		local _with_0 = Sprite("Image/shadow1.png") -- 94
		_with_0.angleX = 90 -- 95
		_with_0.order = -1 -- 96
		_with_0:schedule(function() -- 97
			_with_0.y = self.offset - unit.y -- 97
		end) -- 97
		_with_0:addTo(unit) -- 98
		return _with_0 -- 94
	end, -- 93
	openLeftDoor = function(self) -- 100
		local _with_0 = self._layers.leftwall -- 100
		_with_0.opened = true -- 101
		_with_0.recovery = 0 -- 102
		_with_0:play("openLI") -- 103
		return _with_0 -- 100
	end, -- 100
	openRightDoor = function(self) -- 105
		local _with_0 = self._layers.rightwall -- 105
		_with_0.opened = true -- 106
		_with_0.recovery = 0 -- 107
		_with_0:play("openRI") -- 108
		return _with_0 -- 105
	end, -- 105
	openCenterDoor = function(self) -- 110
		local _with_0 = self._layers.elevatorDoor -- 110
		_with_0.opened = true -- 111
		_with_0.recovery = 0 -- 112
		_with_0:play("openElevatorI") -- 113
		return _with_0 -- 110
	end, -- 110
	zoom = property(function(self) -- 115
		return self._zoom -- 115
	end, function(self, value) -- 116
		self._zoom = value -- 117
		return self:updateZoom() -- 118
	end), -- 115
	updateZoom = function(self) -- 120
		local actualZoom = self._zoom * DefaultZoom -- 121
		local width, height -- 122
		do -- 122
			local _obj_0 = View.size -- 122
			width, height = _obj_0.width, _obj_0.height -- 122
		end -- 122
		local zoom = height / H / actualZoom -- 123
		if width > self._width * zoom then -- 124
			zoom = width / self._width -- 125
		end -- 124
		local _with_0 = self.camera -- 126
		_with_0.zoom = zoom -- 127
		_with_0.boundary = Rect(0, 0, self._width, H * actualZoom) -- 128
		return _with_0 -- 126
	end, -- 120
	__partial = function() -- 130
		local _with_0 = PlatformWorld() -- 131
		_with_0.camera.followRatio = Vec2(0.03, 0.03) -- 132
		return _with_0 -- 131
	end, -- 130
	__init = function(self, name, index, withElevator) -- 134
		if index == nil then -- 134
			index = 3 -- 134
		end -- 134
		if withElevator == nil then -- 134
			withElevator = true -- 134
		end -- 134
		self._name = name -- 135
		local passageDef = passageDefs[index] -- 137
		local W <const> = passageDef.w -- 138
		local HW <const> = W / 2 -- 139
		self._width = W -- 140
		for i = -MaxPath, MaxPath do -- 142
			local _with_0 = self:getLayer(i) -- 143
			_with_0.z = ZOffset - PathOffset * i -- 144
		end -- 142
		do -- 146
			local _tbl_0 = { } -- 146
			local _list_0 = passageDef.items -- 146
			for _index_0 = 1, #_list_0 do -- 146
				local def = _list_0[_index_0] -- 146
				_tbl_0[def.look] = addLayer(self, def) -- 146
			end -- 146
			self._layers = _tbl_0 -- 146
		end -- 146
		if withElevator then -- 148
			local frame, door, floor, back -- 149
			do -- 149
				local _obj_0 = passageDef.elevator -- 149
				frame, door, floor, back = _obj_0.frame, _obj_0.door, _obj_0.floor, _obj_0.back -- 149
			end -- 149
			addLayer(self, frame) -- 150
			do -- 151
				local _with_0 = addLayer(self, door) -- 151
				_with_0.opened = false -- 152
				self._layers.elevatorDoor = _with_0 -- 151
			end -- 151
			local mask -- 153
			do -- 153
				local _with_0 = Rectangle({ -- 154
					x = frame.x, -- 154
					y = 375 / 2, -- 155
					width = 270, -- 156
					height = 375, -- 157
					fillColor = 0xffffffff -- 158
				}) -- 153
				_with_0.z = frame.z -- 160
				mask = _with_0 -- 153
			end -- 153
			self:addChild(_anon_func_0(back, createLayer, floor, mask)) -- 161
		end -- 148
		local LeftDoorSensor <const> = 0 -- 166
		local RightDoorSensor <const> = 1 -- 167
		local ElevatorSensor <const> = 2 -- 168
		local terrainDef -- 169
		do -- 169
			local _with_0 = BodyDef() -- 169
			_with_0.type = "Static" -- 170
			_with_0:attachPolygon(Vec2(HW, 0), W, 10, 0, 1, 1, 0) -- 171
			_with_0:attachPolygon(Vec2(HW, H), W, 10, 0, 1, 1, 0) -- 172
			_with_0:attachPolygon(Vec2(0, HH), 10, H, 0, 1, 1, 0) -- 173
			_with_0:attachPolygon(Vec2(W, HH), 10, H, 0, 1, 1, 0) -- 174
			_with_0:attachPolygonSensor(LeftDoorSensor, Vec2(75, 175), 150, 350) -- 175
			_with_0:attachPolygonSensor(RightDoorSensor, Vec2(W - 75, 175), 150, 350) -- 176
			if withElevator then -- 177
				_with_0:attachPolygonSensor(ElevatorSensor, Vec2(passageDef.elevator.frame.x, 175), 270, 350) -- 178
			end -- 177
			_with_0.position = Vec2(0, Offset) -- 179
			terrainDef = _with_0 -- 169
		end -- 169
		self._layers.leftwall.opened = false -- 181
		self._layers.rightwall.opened = false -- 182
		local DoorSpeed <const> = 1.5 -- 183
		self:addChild((function() -- 184
			local _with_0 = Body(terrainDef, self, Vec2.zero) -- 184
			_with_0.group = Data.groupTerrain -- 185
			_with_0:slot("BodyEnter", function(body, sensorTag) -- 186
				if not body.entity then -- 187
					return -- 187
				end -- 187
				if not body.entity.player then -- 188
					return -- 188
				end -- 188
				local door, animation, route -- 189
				if LeftDoorSensor == sensorTag then -- 190
					door, animation, route = self._layers.leftwall, "openL", "left" -- 191
				elseif RightDoorSensor == sensorTag then -- 192
					door, animation, route = self._layers.rightwall, "openR", "right" -- 193
				elseif ElevatorSensor == sensorTag then -- 194
					door, animation, route = self._layers.elevatorDoor, "openElevator", "center" -- 195
				end -- 189
				local enter, targets -- 196
				name, enter, targets = Map.getRoute(self._name, route) -- 196
				if name then -- 196
					do -- 197
						local _with_1 = body.entity -- 197
						if body.velocityX == 0 then -- 198
							_with_1.moveFromRight = route ~= "right" -- 198
						else -- 198
							_with_1.moveFromRight = body.velocityX < 0 -- 198
						end -- 198
						_with_1.moveRouteName = name -- 199
						_with_1.moveEnter = enter -- 200
						_with_1.moveTargets = Array(targets) -- 201
					end -- 197
					if #targets > 0 and not door.opened then -- 202
						door.opened = true -- 204
						door.recovery = 1 -- 205
						door.speed = DoorSpeed -- 206
						door:play(animation) -- 207
						return door -- 203
					end -- 202
				end -- 196
			end) -- 186
			_with_0:slot("BodyLeave", function(body, sensorTag) -- 208
				if not body.entity then -- 209
					return -- 209
				end -- 209
				if not body.entity.player then -- 210
					return -- 210
				end -- 210
				if not body.entity.moveTargets then -- 211
					return -- 211
				end -- 211
				local available = not body.entity.moveTargets.empty -- 212
				do -- 213
					local _with_1 = body.entity -- 213
					_with_1.moveFromRight = nil -- 214
					_with_1.moveRouteName = nil -- 215
					_with_1.moveEnter = nil -- 216
					_with_1.moveTargets = nil -- 217
				end -- 213
				if not available then -- 218
					return -- 218
				end -- 218
				local door, animation -- 219
				if LeftDoorSensor == sensorTag then -- 220
					door, animation = self._layers.leftwall, "closeL" -- 221
				elseif RightDoorSensor == sensorTag then -- 222
					door, animation = self._layers.rightwall, "closeR" -- 223
				elseif ElevatorSensor == sensorTag then -- 224
					door, animation = self._layers.elevatorDoor, "closeElevator" -- 225
				end -- 219
				door.opened = false -- 227
				door.recovery = 1 -- 228
				door.speed = DoorSpeed -- 229
				door:play(animation) -- 230
				return door -- 226
			end) -- 208
			return _with_0 -- 184
		end)()) -- 184
		self._zoom = 1.0 -- 231
		self:gslot("AppChange", function(settingName) -- 232
			if settingName == "Size" then -- 232
				return self:updateZoom() -- 232
			end -- 232
		end) -- 232
		return self:updateZoom() -- 233
	end, -- 134
	loadAsync = function() -- 235
		return Cache:loadAsync("spine:passage") -- 235
	end -- 235
}) -- 82
return _module_0 -- 1
