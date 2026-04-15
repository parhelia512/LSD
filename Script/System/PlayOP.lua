-- [yue]: Script/System/PlayOP.yue
local _module_0 = nil -- 1
local _ENV = Dora -- 1
local View <const> = View -- 2
local Director <const> = Director -- 2
local Color <const> = Color -- 2
local Cache <const> = Cache -- 2
local tostring <const> = tostring -- 2
local Playable <const> = Playable -- 2
local once <const> = once -- 2
local Audio <const> = Audio -- 2
local sleep <const> = sleep -- 2
local require <const> = require -- 2
local wait <const> = wait -- 2
local PVInfo -- 4
PVInfo = { -- 5
	{ -- 5
		3003, -- 5
		1688, -- 5
		3.1666667461395 -- 5
	}, -- 5
	{ -- 6
		3000, -- 6
		1686, -- 6
		4.0 -- 6
	}, -- 6
	{ -- 7
		3013, -- 7
		1699, -- 7
		4.2666668891907 -- 7
	}, -- 7
	{ -- 8
		2988, -- 8
		1700, -- 8
		5.0000004768372 -- 8
	}, -- 8
	{ -- 9
		3017, -- 9
		1704, -- 9
		5.3333334922791 -- 9
	}, -- 9
	{ -- 10
		3021, -- 10
		1704, -- 10
		5.0000004768372 -- 10
	}, -- 10
	{ -- 11
		3018, -- 11
		1703, -- 11
		2.8333334922791 -- 11
	}, -- 11
	{ -- 12
		3018, -- 12
		1706, -- 12
		3.0000002384186, -- 12
		0.1 -- 12
	}, -- 12
	{ -- 13
		3020, -- 13
		1707, -- 13
		3.0000002384186 -- 13
	}, -- 13
	{ -- 14
		1162, -- 14
		656, -- 14
		4.1666669845581 -- 14
	}, -- 14
	{ -- 15
		2999, -- 15
		1687, -- 15
		4.6666669845581 -- 15
	}, -- 15
	{ -- 16
		2928, -- 16
		1650, -- 16
		4.0 -- 16
	}, -- 16
	{ -- 17
		2926, -- 17
		1650, -- 17
		1.5000001192093 -- 17
	}, -- 17
	{ -- 18
		2927, -- 18
		1651, -- 18
		1.5000001192093 -- 18
	}, -- 18
	{ -- 19
		2926, -- 19
		1651, -- 19
		2.566666841507 -- 19
	}, -- 19
	{ -- 20
		2927, -- 20
		1650, -- 20
		1.6666667461395 -- 20
	}, -- 20
	{ -- 21
		2903, -- 21
		1629, -- 21
		1.5000001192093 -- 21
	}, -- 21
	{ -- 22
		3006, -- 22
		1689, -- 22
		5.0000004768372 -- 22
	}, -- 22
	{ -- 23
		2907, -- 23
		1632, -- 23
		0.66666668653488 -- 23
	}, -- 23
	{ -- 24
		2999, -- 24
		1686, -- 24
		2.0 -- 24
	}, -- 24
	{ -- 25
		2907, -- 25
		1631, -- 25
		1.0666667222977 -- 25
	}, -- 25
	{ -- 26
		2907, -- 26
		1631, -- 26
		3, -- 26
		1.0 -- 26
	}, -- 26
	{ -- 27
		2907, -- 27
		1631, -- 27
		5.3333334922791 -- 27
	}, -- 27
	{ -- 28
		2998, -- 28
		1685, -- 28
		1.1666667461395 -- 28
	}, -- 28
	{ -- 29
		3353, -- 29
		1882, -- 29
		4.0 -- 29
	}, -- 29
	{ -- 30
		2918, -- 30
		1646, -- 30
		6.6666669845581 -- 30
	} -- 30
} -- 4
local scaleView -- 33
scaleView = function(self, index) -- 33
	local width, height, time, target -- 34
	do -- 34
		local _obj_0 = PVInfo[index] -- 34
		width, height, time, target = _obj_0[1], _obj_0[2], _obj_0[3], _obj_0[4] -- 34
		if target == nil then -- 34
			target = time -- 34
		end -- 34
	end -- 34
	local w, h -- 35
	do -- 35
		local _obj_0 = View.size -- 35
		w, h = _obj_0.width, _obj_0.height -- 35
	end -- 35
	local scale -- 36
	if (w / h) > (width / height) then -- 36
		scale = h / height -- 37
	else -- 39
		scale = w / width -- 39
	end -- 36
	self.scaleX = scale -- 40
	self.scaleY = scale -- 41
	self.speed = time * 1.25 / target -- 42
end -- 33
local playOP -- 44
playOP = function() -- 44
	Director.clearColor = Color(0xff000000) -- 45
	local start = 1 -- 46
	Cache:loadAsync("spine:PV1/PV1_" .. tostring(start)) -- 47
	for i = start, #PVInfo do -- 48
		if (8 == i or 19 == i) then -- 49
			goto _continue_0 -- 49
		end -- 49
		local playEnded = false -- 50
		local nextViewLoaded = false -- 51
		local playable = Playable("spine:PV1/PV1_" .. tostring(i)) -- 52
		playable:play("animation", i == 1) -- 53
		playable:gslot("AppChange", function(settingName) -- 54
			if settingName == "Size" then -- 54
				return scaleView(playable, i) -- 54
			end -- 54
		end) -- 54
		scaleView(playable, i) -- 55
		if i + 1 <= #PVInfo then -- 56
			playable:schedule(once(function() -- 57
				Cache:loadAsync("spine:PV1/PV1_" .. tostring(i + 1)) -- 58
				nextViewLoaded = true -- 59
			end)) -- 57
		else -- 61
			nextViewLoaded = true -- 61
		end -- 56
		playable:addTo(Director.entry) -- 62
		Cache:unload("PV1/PV1_" .. tostring(i) .. ".atlas") -- 63
		Cache:unload("spine:PV1/PV1_" .. tostring(i)) -- 64
		if i == 1 then -- 65
			Audio:playStream("Music/L·S·Depart.mp3", true) -- 66
			sleep(3) -- 67
			local Story = require("UI.Story") -- 68
			local story -- 69
			do -- 69
				local _with_0 = Story("Tutorial/Dialog/startUp.yarn") -- 69
				_with_0:slot("Ended", function() -- 70
					playEnded = true -- 70
				end) -- 70
				_with_0:showAsync() -- 71
				_with_0:addTo(Director.ui3D) -- 72
				story = _with_0 -- 69
			end -- 69
			wait(function() -- 73
				return playEnded -- 73
			end) -- 73
			Audio:playStream("Music/L·S·DepartII.mp3", false, 1) -- 74
			sleep(2) -- 75
		else -- 77
			playable:slot("end", function() -- 77
				playEnded = true -- 77
			end) -- 77
			playable:slot("AnimationEnd", function() -- 78
				playEnded = true -- 78
			end) -- 78
		end -- 65
		wait(function() -- 79
			return playEnded and nextViewLoaded -- 79
		end) -- 79
		if i + 1 <= #PVInfo then -- 80
			playable:removeFromParent() -- 81
			Cache:removeUnused("Texture") -- 82
		end -- 80
		::_continue_0:: -- 49
	end -- 48
end -- 44
_module_0 = playOP -- 84
return _module_0 -- 1
