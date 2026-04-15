-- [yue]: Script/Academy/Map.yue
local _module_0 = { } -- 1
local Data = require("Platformer").Data -- 1
local routes = { -- 5
	LoopTowerInitial = { -- 6
		name = "开场螺旋塔", -- 6
		right = { -- 8
			name = "右边门", -- 8
			enter = "left", -- 9
			targets = { -- 10
				"PreparationRoom" -- 10
			} -- 10
		} -- 7
	}, -- 5
	PreparationRoom = { -- 13
		name = "备战室", -- 13
		left = { -- 15
			name = "左边门", -- 15
			enter = "right", -- 16
			targets = { -- 17
				"PassageA" -- 17
			} -- 17
		}, -- 14
		right = { -- 19
			name = "右边门", -- 19
			enter = "left", -- 20
			targets = { -- 21
				"PassageB" -- 21
			} -- 21
		} -- 18
	}, -- 12
	OperationRoom = { -- 24
		name = "指挥室", -- 24
		left = { -- 26
			name = "左边门", -- 26
			enter = "right", -- 27
			targets = { -- 28
				"PassageC" -- 28
			} -- 28
		}, -- 25
		right = { -- 30
			name = "右边门", -- 30
			enter = "left", -- 31
			targets = { } -- 32
		} -- 29
	}, -- 23
	RDRoom = { -- 35
		name = "研发室", -- 35
		left = { -- 37
			name = "左边门", -- 37
			enter = "right", -- 38
			targets = { -- 39
				"PassageD" -- 39
			} -- 39
		}, -- 36
		right = { -- 41
			name = "右边门", -- 41
			enter = "", -- 42
			targets = { } -- 43
		} -- 40
	}, -- 34
	RestRoom = { -- 46
		name = "休息室", -- 46
		left = { -- 48
			name = "左边门", -- 48
			enter = "", -- 49
			targets = { } -- 50
		}, -- 47
		right = { -- 52
			name = "右边门", -- 52
			enter = "left", -- 53
			targets = { -- 54
				"PassageA" -- 54
			} -- 54
		} -- 51
	}, -- 45
	TrainingRoom = { -- 57
		name = "训练室", -- 57
		left = { -- 59
			name = "左边门", -- 59
			enter = "right", -- 60
			targets = { -- 61
				"PassageB" -- 61
			} -- 61
		}, -- 58
		right = { -- 63
			name = "右边门", -- 63
			enter = "", -- 64
			targets = { } -- 65
		} -- 62
	}, -- 56
	PassageA = { -- 68
		name = "A区走廊", -- 68
		left = { -- 70
			name = "左边门", -- 70
			enter = "right", -- 71
			targets = { -- 72
				"RestRoom" -- 72
			} -- 72
		}, -- 69
		right = { -- 74
			name = "右边门", -- 74
			enter = "left", -- 75
			targets = { -- 76
				"PreparationRoom" -- 76
			} -- 76
		}, -- 73
		center = { -- 78
			name = "电梯", -- 78
			enter = "center", -- 79
			targets = { -- 80
				"PassageC" -- 80
			} -- 80
		} -- 77
	}, -- 67
	PassageB = { -- 83
		name = "B区走廊", -- 83
		left = { -- 85
			name = "左边门", -- 85
			enter = "right", -- 86
			targets = { -- 87
				"PreparationRoom" -- 87
			} -- 87
		}, -- 84
		right = { -- 89
			name = "右边门", -- 89
			enter = "left", -- 90
			targets = { -- 91
				"TrainingRoom" -- 91
			} -- 91
		}, -- 88
		center = { -- 93
			name = "电梯", -- 93
			enter = "center", -- 94
			targets = { -- 95
				"PassageA", -- 95
				"PassageC" -- 95
			} -- 95
		} -- 92
	}, -- 82
	PassageC = { -- 98
		name = "C区走廊", -- 98
		left = { -- 100
			name = "左边门", -- 100
			enter = "", -- 101
			targets = { } -- 102
		}, -- 99
		right = { -- 104
			name = "右边门", -- 104
			enter = "left", -- 105
			targets = { -- 106
				"OperationRoom" -- 106
			} -- 106
		}, -- 103
		center = { -- 108
			name = "电梯", -- 108
			enter = "center", -- 109
			targets = { -- 110
				"PassageA", -- 110
				"PassageD" -- 110
			} -- 110
		} -- 107
	}, -- 97
	PassageD = { -- 113
		name = "D区走廊", -- 113
		left = { -- 115
			name = "左边门", -- 115
			enter = "", -- 116
			targets = { } -- 117
		}, -- 114
		right = { -- 119
			name = "右边门", -- 119
			enter = "left", -- 120
			targets = { -- 121
				"RDRoom" -- 121
			} -- 121
		}, -- 118
		center = { -- 123
			name = "电梯", -- 123
			enter = "center", -- 124
			targets = { -- 125
				"PassageC" -- 125
			} -- 125
		} -- 122
	} -- 112
} -- 4
local states = { -- 128
	{ -- 128
		PreparationRoom = true, -- 128
		PassageA = true, -- 129
		RestRoom = true -- 130
	}, -- 128
	{ -- 132
		PassageB = true, -- 132
		TrainingRoom = true -- 133
	}, -- 132
	{ -- 135
		PassageC = true, -- 135
		OperationRoom = true -- 136
	}, -- 135
	{ -- 138
		PassageD = true, -- 138
		RDRoom = true -- 139
	} -- 138
} -- 127
local isAvailable -- 141
isAvailable = function(name) -- 141
	local level -- 142
	do -- 142
		local _exp_0 = Data.store.academyLevel -- 142
		if _exp_0 ~= nil then -- 142
			level = _exp_0 -- 142
		else -- 142
			level = #states -- 142
		end -- 142
	end -- 142
	for i = 1, level do -- 143
		if states[i][name] then -- 144
			return true -- 145
		end -- 144
	end -- 143
	return false -- 146
end -- 141
local getRoute -- 148
getRoute = function(name, route) -- 148
	do -- 149
		local _des_0 -- 149
		do -- 149
			local _obj_0 = routes[name] -- 149
			if _obj_0 ~= nil then -- 149
				_des_0 = _obj_0[route] -- 149
			end -- 149
		end -- 149
		if _des_0 then -- 149
			local enter, targets -- 149
			name, enter, targets = _des_0.name, _des_0.enter, _des_0.targets -- 149
			do -- 150
				local _accum_0 = { } -- 150
				local _len_0 = 1 -- 150
				for _index_0 = 1, #targets do -- 150
					local target = targets[_index_0] -- 150
					if isAvailable(target) then -- 150
						_accum_0[_len_0] = target -- 150
						_len_0 = _len_0 + 1 -- 150
					end -- 150
				end -- 150
				targets = _accum_0 -- 150
			end -- 150
			return name, enter, targets -- 151
		end -- 149
	end -- 149
	return nil, nil, nil -- 152
end -- 148
_module_0["getRoute"] = getRoute -- 148
local getName -- 154
getName = function(nameEN) -- 154
	local _obj_0 = routes[nameEN] -- 154
	if _obj_0 ~= nil then -- 154
		return _obj_0.name -- 154
	end -- 154
	return nil -- 154
end -- 154
_module_0["getName"] = getName -- 154
return _module_0 -- 1
