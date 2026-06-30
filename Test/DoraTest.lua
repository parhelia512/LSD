-- [yue]: Test/DoraTest.yue
local _ENV = Dora(Dora.ImGui) -- 1
local Path <const> = Path -- 2
local Content <const> = Content -- 2
local require <const> = require -- 2
local Director <const> = Director -- 2
local Spine <const> = Spine -- 2
local p <const> = p -- 2
local Node <const> = Node -- 2
local Size <const> = Size -- 2
local SpriteEffect <const> = SpriteEffect -- 2
local Color <const> = Color -- 2
local print <const> = print -- 2
local tostring <const> = tostring -- 2
local loop <const> = loop -- 2
local sleep <const> = sleep -- 2
local Label <const> = Label -- 2
local Sequence <const> = Sequence -- 2
local Spawn <const> = Spawn -- 2
local Scale <const> = Scale -- 2
local Ease <const> = Ease -- 2
local Delay <const> = Delay -- 2
local Opacity <const> = Opacity -- 2
local Event <const> = Event -- 2
local Vec2 <const> = Vec2 -- 2
local App <const> = App -- 2
local SetNextWindowPos <const> = SetNextWindowPos -- 2
local SetNextWindowSize <const> = SetNextWindowSize -- 2
local Begin <const> = Begin -- 2
local TextWrapped <const> = TextWrapped -- 2
local Checkbox <const> = Checkbox -- 2
do -- 4
	local scriptPath = Path:getScriptPath(...) -- 4
	if scriptPath then -- 4
		scriptPath = Path:getPath(scriptPath) -- 5
		local _list_0 = { -- 7
			scriptPath, -- 7
			Path(scriptPath, "Script"), -- 8
			Path(scriptPath, "Spine"), -- 9
			Path(scriptPath, "Image"), -- 10
			Path(scriptPath, "Font") -- 11
		} -- 6
		for _index_0 = 1, #_list_0 do -- 6
			local path = _list_0[_index_0] -- 6
			Content:insertSearchPath(1, path) -- 13
		end -- 6
	else -- 14
		return -- 14
	end -- 4
end -- 4
local LsdOSBack = require("UI.LsdOSBack") -- 16
Director.entry:addChild((function() -- 18
	local _with_0 = LsdOSBack() -- 18
	_with_0:alignLayout() -- 19
	return _with_0 -- 18
end)()) -- 18
local spineStr = "ninilite" -- 21
local animations = Spine:getAnimations(spineStr) -- 23
local looks = Spine:getLooks(spineStr) -- 24
p(animations, looks) -- 25
local spineShadow -- 27
do -- 27
	local s = Spine(spineStr) -- 27
	s.x = 200 -- 28
	s.y = 190 -- 29
	s.scaleY = -1.0 -- 30
	s.look = looks[1] -- 31
	s:play(animations[1], true) -- 32
	spineShadow = s -- 27
end -- 27
local _anon_func_0 = function(spineShadow) -- 54
	local _with_0 = Spine("coldweapon") -- 54
	_with_0.look = "grenade" -- 55
	_with_0.scaleX = 0.04 -- 56
	_with_0.scaleY = 0.04 -- 57
	return _with_0 -- 54
end -- 54
local _anon_func_1 = function(_with_0) -- 59
	local _with_1 = Spine("coldweapon") -- 59
	_with_1.look = "grenade" -- 60
	_with_1.scaleX = 0.04 -- 61
	_with_1.scaleY = 0.04 -- 62
	return _with_1 -- 59
end -- 59
local _anon_func_2 = function(spineShadow) -- 66
	local _with_0 = Spine("coldweapon") -- 66
	_with_0.look = "comm" -- 67
	_with_0.scaleX = 0.06 -- 68
	_with_0.scaleY = 0.06 -- 69
	return _with_0 -- 66
end -- 66
local _anon_func_3 = function(_with_0) -- 71
	local _with_1 = Spine("coldweapon") -- 71
	_with_1.look = "comm" -- 72
	_with_1.scaleX = 0.06 -- 73
	_with_1.scaleY = 0.06 -- 74
	return _with_1 -- 71
end -- 71
local _anon_func_4 = function(spineShadow) -- 78
	local _with_0 = Spine("coldweapon") -- 78
	_with_0.look = "comp" -- 79
	_with_0.scaleX = 0.1 -- 80
	_with_0.scaleY = 0.1 -- 81
	return _with_0 -- 78
end -- 78
local _anon_func_5 = function(_with_0) -- 83
	local _with_1 = Spine("coldweapon") -- 83
	_with_1.look = "comp" -- 84
	_with_1.scaleX = 0.1 -- 85
	_with_1.scaleY = 0.1 -- 86
	return _with_1 -- 83
end -- 83
local _anon_func_6 = function(spineShadow) -- 90
	local _with_0 = Spine("coldweapon") -- 90
	_with_0.look = "shield" -- 91
	_with_0.scaleX = 0.2 -- 92
	_with_0.scaleY = 0.2 -- 93
	return _with_0 -- 90
end -- 90
local _anon_func_7 = function(_with_0) -- 95
	local _with_1 = Spine("coldweapon") -- 95
	_with_1.look = "shield" -- 96
	_with_1.scaleX = 0.2 -- 97
	_with_1.scaleY = 0.2 -- 98
	return _with_1 -- 95
end -- 95
local _anon_func_8 = function(_with_0, mname) -- 102
	local _with_1 = Spine("coldweapon") -- 102
	_with_1.look = mname -- 103
	_with_1.scaleX = 0.2 -- 104
	_with_1.scaleY = 0.2 -- 105
	return _with_1 -- 102
end -- 102
local _anon_func_9 = function(_with_0, mname) -- 106
	local _with_1 = Spine("coldweapon") -- 106
	_with_1.look = mname -- 107
	_with_1.scaleX = 0.2 -- 108
	_with_1.scaleY = 0.2 -- 109
	return _with_1 -- 106
end -- 106
local _anon_func_10 = function(spineShadow) -- 116
	local _with_0 = Spine("coldweapon") -- 116
	_with_0.look = "bow" -- 117
	_with_0.scaleX = 0.2 -- 118
	_with_0.scaleY = 0.2 -- 119
	return _with_0 -- 116
end -- 116
local _anon_func_11 = function(_with_0) -- 121
	local _with_1 = Spine("coldweapon") -- 121
	_with_1.look = "bow" -- 122
	_with_1.scaleX = 0.2 -- 123
	_with_1.scaleY = 0.2 -- 124
	return _with_1 -- 121
end -- 121
local _anon_func_12 = function(gname, spineShadow) -- 129
	local _with_0 = Spine(gname) -- 129
	_with_0.look = "PT" -- 130
	_with_0.scaleX = 0.2 -- 131
	_with_0.scaleY = 0.2 -- 132
	return _with_0 -- 129
end -- 129
local _anon_func_13 = function(_with_0, gname) -- 134
	local _with_1 = Spine(gname) -- 134
	_with_1.look = "PT" -- 135
	_with_1.scaleX = 0.2 -- 136
	_with_1.scaleY = 0.2 -- 137
	return _with_1 -- 134
end -- 134
local _anon_func_14 = function(_with_0, gname, gtype) -- 141
	local _with_1 = Spine(gname) -- 141
	_with_1.look = gtype -- 142
	_with_1.scaleX = 0.2 -- 143
	_with_1.scaleY = 0.2 -- 144
	return _with_1 -- 141
end -- 141
local _anon_func_15 = function(_with_0, gname, gtype) -- 145
	local _with_1 = Spine(gname) -- 145
	_with_1.look = gtype -- 146
	_with_1.scaleX = 0.2 -- 147
	_with_1.scaleY = 0.2 -- 148
	return _with_1 -- 145
end -- 145
local _anon_func_16 = function(_with_0, name, x, y) -- 160
	local _with_1 = Label("NotoSansHans-Regular", 30) -- 160
	_with_1.text = name -- 161
	_with_1.color = Color(0xff00ffff) -- 162
	_with_1:perform(Sequence(Spawn(Scale(1, 0, 2, Ease.OutQuad), Sequence(Delay(0.5), Opacity(0.5, 1, 0))), Event("Stop"))) -- 163
	_with_1.position = Vec2(x, y) -- 170
	_with_1:slot("Stop", function() -- 171
		return _with_1:removeFromParent() -- 171
	end) -- 171
	return _with_1 -- 160
end -- 160
local spine -- 34
do -- 34
	local _with_0 = Spine(spineStr) -- 34
	_with_0.y = -200 -- 35
	_with_0:addChild((function() -- 36
		local _with_1 = Node() -- 36
		_with_1.order = -1 -- 37
		_with_1.size = Size(400, 400) -- 38
		do -- 40
			local _with_2 = _with_1:grab() -- 40
			do -- 41
				local _with_3 = SpriteEffect("builtin::vs_sprite", "builtin::fs_spriteoutlinecolor") -- 41
				_with_3:get(1):set("u_linecolor", Color(0xff00ffff)) -- 42
				_with_3:get(1):set("u_lineoffset", 5, 5, 0.1) -- 43
				_with_2.effect = _with_3 -- 41
			end -- 41
			_with_2:setColor(1, 2, Color(0x007ec0f8)) -- 44
			_with_2:setColor(2, 2, Color(0x007ec0f8)) -- 45
		end -- 40
		_with_1:addChild(spineShadow) -- 46
		return _with_1 -- 36
	end)()) -- 36
	_with_0.scaleX = 2.0 -- 47
	_with_0.scaleY = 2.0 -- 48
	_with_0.look = looks[1] -- 49
	_with_0:play(animations[1], true) -- 50
	_with_0:slot("AnimationEnd", function(name) -- 51
		return print(tostring(name) .. " end!") -- 51
	end) -- 51
	_with_0:schedule(loop(function() -- 52
		spineShadow:setSlot("item", _anon_func_0(spineShadow)) -- 54
		spineShadow:play("throw") -- 58
		_with_0:setSlot("item", _anon_func_1(_with_0)) -- 59
		sleep(_with_0:play("throw")) -- 63
		spineShadow:setSlot("comm", _anon_func_2(spineShadow)) -- 66
		spineShadow:play("comm") -- 70
		_with_0:setSlot("comm", _anon_func_3(_with_0)) -- 71
		sleep(_with_0:play("comm")) -- 75
		spineShadow:setSlot("comp", _anon_func_4(spineShadow)) -- 78
		spineShadow:play("comp") -- 82
		_with_0:setSlot("comp", _anon_func_5(_with_0)) -- 83
		sleep(_with_0:play("comp")) -- 87
		spineShadow:setSlot("shield", _anon_func_6(spineShadow)) -- 90
		spineShadow:play("defence") -- 94
		_with_0:setSlot("shield", _anon_func_7(_with_0)) -- 95
		sleep(_with_0:play("defence")) -- 99
		local _list_0 = { -- 101
			"sword", -- 101
			"shovel", -- 101
			"axe" -- 101
		} -- 101
		for _index_0 = 1, #_list_0 do -- 101
			local mname = _list_0[_index_0] -- 101
			spineShadow:setSlot("melee", _anon_func_8(_with_0, mname)) -- 102
			_with_0:setSlot("melee", _anon_func_9(_with_0, mname)) -- 106
			spineShadow:play("melee") -- 110
			sleep(_with_0:play("melee")) -- 111
			spineShadow:play("parry") -- 112
			sleep(_with_0:play("parry")) -- 113
		end -- 101
		spineShadow:setSlot("bow", _anon_func_10(spineShadow)) -- 116
		spineShadow:play("bow") -- 120
		_with_0:setSlot("bow", _anon_func_11(_with_0)) -- 121
		sleep(_with_0:play("bow")) -- 125
		local _list_1 = { -- 127
			"kineticgun", -- 127
			"lasergun", -- 127
			"empgun" -- 127
		} -- 127
		for _index_0 = 1, #_list_1 do -- 127
			local gname = _list_1[_index_0] -- 127
			spineShadow:setSlot("pistol", _anon_func_12(gname, spineShadow)) -- 129
			spineShadow:play("pistol") -- 133
			_with_0:setSlot("pistol", _anon_func_13(_with_0, gname)) -- 134
			sleep(_with_0:play("pistol")) -- 138
			local _list_2 = { -- 140
				"AR", -- 140
				"LMG", -- 140
				"SMG", -- 140
				"SR", -- 140
				"SCG", -- 140
				"SG" -- 140
			} -- 140
			for _index_1 = 1, #_list_2 do -- 140
				local gtype = _list_2[_index_1] -- 140
				spineShadow:setSlot("gun", _anon_func_14(_with_0, gname, gtype)) -- 141
				_with_0:setSlot("gun", _anon_func_15(_with_0, gname, gtype)) -- 145
				spineShadow:play("gun1") -- 149
				sleep(_with_0:play("gun1")) -- 150
				spineShadow:play("gun2") -- 151
				sleep(_with_0:play("gun2")) -- 152
				spineShadow:play("gun3") -- 153
				sleep(_with_0:play("gun3")) -- 154
			end -- 140
		end -- 127
	end)) -- 52
	_with_0.touchEnabled = true -- 156
	_with_0:slot("TapBegan", function(touch) -- 157
		local x, y -- 158
		do -- 158
			local _obj_0 = touch.location -- 158
			x, y = _obj_0.x, _obj_0.y -- 158
		end -- 158
		local name = _with_0:containsPoint(x, y) -- 159
		if name then -- 159
			return _with_0:addChild(_anon_func_16(_with_0, name, x, y)) -- 160
		end -- 159
	end) -- 157
	spine = _with_0 -- 34
end -- 34
Director.entry:addChild(spine) -- 173
return Director.entry:addChild((function() -- 177
	local _with_0 = Node() -- 177
	_with_0:schedule(function() -- 178
		local width, height -- 179
		do -- 179
			local _obj_0 = App.visualSize -- 179
			width, height = _obj_0.width, _obj_0.height -- 179
		end -- 179
		SetNextWindowPos(Vec2(width - 250, 10), "FirstUseEver") -- 180
		SetNextWindowSize(Vec2(240, 140), "FirstUseEver") -- 181
		return Begin("Assembling", { -- 182
			"NoResize", -- 182
			"NoSavedSettings" -- 182
		}, function() -- 182
			TextWrapped("Assembling troops example. Tap it for a hit test.") -- 183
			local _ -- 184
			_, spine.showDebug = Checkbox("BoundingBox", spine.showDebug) -- 184
		end) -- 182
	end) -- 178
	return _with_0 -- 177
end)()) -- 177
