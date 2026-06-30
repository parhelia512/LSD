-- [yue]: Script/Control.yue
local _ENV = Dora(Dora.Platformer) -- 1
local require <const> = require -- 2
local Data <const> = Data -- 2
local App <const> = App -- 2
local Group <const> = Group -- 2
local Menu <const> = Menu -- 2
local math <const> = math -- 2
local Vec2 <const> = Vec2 -- 2
local Director <const> = Director -- 2
local Keyboard <const> = Keyboard -- 2
local Controller <const> = Controller -- 2
local Node <const> = Node -- 2
local AlignNode = require("UI.Control.Basic.AlignNode") -- 3
local CircleButton = require("UI.Control.Basic.CircleButton") -- 4
local Store = Data.store -- 6
local keyboardEnabled -- 8
do -- 8
	local _exp_0 = App.platform -- 8
	if "macOS" == _exp_0 or "Windows" == _exp_0 or "Linux" == _exp_0 then -- 9
		keyboardEnabled = true -- 9
	else -- 10
		keyboardEnabled = false -- 10
	end -- 8
end -- 8
Store.keyboardEnabled = keyboardEnabled -- 12
local playerGroup = Group({ -- 14
	"player" -- 14
}) -- 14
local updatePlayerControl -- 15
updatePlayerControl = function(key, flag, vpad) -- 15
	if vpad == nil then -- 15
		vpad = false -- 15
	end -- 15
	if keyboardEnabled then -- 16
		if vpad then -- 17
			Store.keyboardEnabled = not flag -- 17
		end -- 17
	end -- 16
	return playerGroup:each(function(self) -- 18
		self[key] = flag -- 18
	end) -- 18
end -- 15
local uiScale = App.devicePixelRatio -- 19
do -- 21
	local _with_0 = AlignNode({ -- 21
		isRoot = true, -- 21
		inUI = true -- 21
	}) -- 21
	_with_0.opacity = 0.5 -- 22
	_with_0:addChild((function() -- 24
		local _with_1 = AlignNode() -- 24
		_with_1.hAlign = "Left" -- 25
		_with_1.vAlign = "Bottom" -- 26
		_with_1:addChild((function() -- 27
			local _with_2 = Menu() -- 27
			_with_2:addChild((function() -- 28
				local _with_3 = CircleButton({ -- 29
					text = "左(a)", -- 29
					x = 20 * uiScale, -- 30
					y = 60 * uiScale, -- 31
					radius = 30 * uiScale, -- 32
					fontSize = math.floor(18 * uiScale) -- 33
				}) -- 28
				_with_3.anchor = Vec2.zero -- 35
				_with_3:slot("TapBegan", function() -- 36
					return updatePlayerControl("keyLeft", true, true) -- 36
				end) -- 36
				_with_3:slot("TapEnded", function() -- 37
					return updatePlayerControl("keyLeft", false, true) -- 37
				end) -- 37
				return _with_3 -- 28
			end)()) -- 28
			_with_2:addChild((function() -- 38
				local _with_3 = CircleButton({ -- 39
					text = "右(d)", -- 39
					x = 90 * uiScale, -- 40
					y = 60 * uiScale, -- 41
					radius = 30 * uiScale, -- 42
					fontSize = math.floor(18 * uiScale) -- 43
				}) -- 38
				_with_3.anchor = Vec2.zero -- 45
				_with_3:slot("TapBegan", function() -- 46
					return updatePlayerControl("keyRight", true, true) -- 46
				end) -- 46
				_with_3:slot("TapEnded", function() -- 47
					return updatePlayerControl("keyRight", false, true) -- 47
				end) -- 47
				return _with_3 -- 38
			end)()) -- 38
			_with_2:addChild((function() -- 48
				local _with_3 = CircleButton({ -- 49
					text = "左退(q)", -- 49
					x = 20 * uiScale, -- 50
					y = (60 * 2 + 10) * uiScale, -- 51
					radius = 30 * uiScale, -- 52
					fontSize = math.floor(18 * uiScale) -- 53
				}) -- 48
				_with_3.anchor = Vec2.zero -- 55
				_with_3:slot("TapBegan", function() -- 56
					return updatePlayerControl("keyBLeft", true, true) -- 56
				end) -- 56
				_with_3:slot("TapEnded", function() -- 57
					return updatePlayerControl("keyBLeft", false, true) -- 57
				end) -- 57
				return _with_3 -- 48
			end)()) -- 48
			_with_2:addChild((function() -- 58
				local _with_3 = CircleButton({ -- 59
					text = "右退(e)", -- 59
					x = 90 * uiScale, -- 60
					y = (60 * 2 + 10) * uiScale, -- 61
					radius = 30 * uiScale, -- 62
					fontSize = math.floor(18 * uiScale) -- 63
				}) -- 58
				_with_3.anchor = Vec2.zero -- 65
				_with_3:slot("TapBegan", function() -- 66
					return updatePlayerControl("keyBRight", true, true) -- 66
				end) -- 66
				_with_3:slot("TapEnded", function() -- 67
					return updatePlayerControl("keyBRight", false, true) -- 67
				end) -- 67
				return _with_3 -- 58
			end)()) -- 58
			return _with_2 -- 27
		end)()) -- 27
		return _with_1 -- 24
	end)()) -- 24
	_with_0:addChild((function() -- 68
		local _with_1 = AlignNode() -- 68
		_with_1.hAlign = "Right" -- 69
		_with_1.vAlign = "Bottom" -- 70
		_with_1:addChild((function() -- 71
			local _with_2 = Menu() -- 71
			_with_2:addChild((function() -- 72
				local _with_3 = CircleButton({ -- 73
					text = "跳(k)", -- 73
					x = -80 * uiScale, -- 74
					y = 60 * uiScale, -- 75
					radius = 30 * uiScale, -- 76
					fontSize = math.floor(18 * uiScale) -- 77
				}) -- 72
				_with_3.anchor = Vec2.zero -- 79
				_with_3:slot("TapBegan", function() -- 80
					return updatePlayerControl("keyUp", true, true) -- 80
				end) -- 80
				_with_3:slot("TapEnded", function() -- 81
					return updatePlayerControl("keyUp", false, true) -- 81
				end) -- 81
				return _with_3 -- 72
			end)()) -- 72
			_with_2:addChild((function() -- 82
				local _with_3 = CircleButton({ -- 83
					text = "手枪(j)", -- 83
					x = -150 * uiScale, -- 84
					y = 60 * uiScale, -- 85
					radius = 30 * uiScale, -- 86
					fontSize = math.floor(18 * uiScale) -- 87
				}) -- 82
				_with_3.anchor = Vec2.zero -- 89
				_with_3:slot("TapBegan", function() -- 90
					return updatePlayerControl("keyShoot", true, true) -- 90
				end) -- 90
				_with_3:slot("TapEnded", function() -- 91
					return updatePlayerControl("keyShoot", false, true) -- 91
				end) -- 91
				return _with_3 -- 82
			end)()) -- 82
			return _with_2 -- 71
		end)()) -- 71
		_with_1:addChild((function() -- 92
			local _with_2 = Menu() -- 92
			_with_2:addChild((function() -- 93
				local _with_3 = CircleButton({ -- 94
					text = "闪避(i)", -- 94
					x = -80 * uiScale, -- 95
					y = (60 * 2 + 10) * uiScale, -- 96
					radius = 30 * uiScale, -- 97
					fontSize = math.floor(18 * uiScale) -- 98
				}) -- 93
				_with_3.anchor = Vec2.zero -- 100
				_with_3:slot("TapBegan", function() -- 101
					return updatePlayerControl("keyEvade", true, true) -- 101
				end) -- 101
				_with_3:slot("TapEnded", function() -- 102
					return updatePlayerControl("keyEvade", false, true) -- 102
				end) -- 102
				return _with_3 -- 93
			end)()) -- 93
			_with_2:addChild((function() -- 103
				local _with_3 = CircleButton({ -- 104
					text = "冲刺(u)", -- 104
					x = -150 * uiScale, -- 105
					y = (60 * 2 + 10) * uiScale, -- 106
					radius = 30 * uiScale, -- 107
					fontSize = math.floor(18 * uiScale) -- 108
				}) -- 103
				_with_3.anchor = Vec2.zero -- 110
				_with_3:slot("TapBegan", function() -- 111
					return updatePlayerControl("keyRush", true, true) -- 111
				end) -- 111
				_with_3:slot("TapEnded", function() -- 112
					return updatePlayerControl("keyRush", false, true) -- 112
				end) -- 112
				return _with_3 -- 103
			end)()) -- 103
			_with_2:addChild((function() -- 113
				local _with_3 = CircleButton({ -- 114
					text = "倒地起身(o)", -- 114
					x = -150 * uiScale, -- 115
					y = (60 * 3 + 20) * uiScale, -- 116
					radius = 30 * uiScale, -- 117
					fontSize = math.floor(18 * uiScale) -- 118
				}) -- 113
				_with_3.anchor = Vec2.zero -- 120
				_with_3:slot("TapBegan", function() -- 121
					return updatePlayerControl("keyFall", true, true) -- 121
				end) -- 121
				_with_3:slot("TapEnded", function() -- 122
					return updatePlayerControl("keyFall", false, true) -- 122
				end) -- 122
				return _with_3 -- 113
			end)()) -- 113
			_with_2:addChild((function() -- 123
				local _with_3 = CircleButton({ -- 124
					text = "普攻(l)", -- 124
					x = -80 * uiScale, -- 125
					y = (60 * 3 + 20) * uiScale, -- 126
					radius = 30 * uiScale, -- 127
					fontSize = math.floor(18 * uiScale) -- 128
				}) -- 123
				_with_3.anchor = Vec2.zero -- 130
				_with_3:slot("TapBegan", function() -- 131
					return updatePlayerControl("keyMelee", true, true) -- 131
				end) -- 131
				_with_3:slot("TapEnded", function() -- 132
					return updatePlayerControl("keyMelee", false, true) -- 132
				end) -- 132
				return _with_3 -- 123
			end)()) -- 123
			return _with_2 -- 92
		end)()) -- 92
		return _with_1 -- 68
	end)()) -- 68
	_with_0:addTo((function() -- 133
		local _with_1 = Director.ui -- 133
		_with_1.renderGroup = true -- 134
		return _with_1 -- 133
	end)()) -- 133
end -- 21
local keyboardControl -- 136
keyboardControl = function() -- 136
	if not Store.keyboardEnabled then -- 137
		return -- 137
	end -- 137
	updatePlayerControl("keyLeft", Keyboard:isKeyPressed("A") or Controller:isButtonPressed(0, "dpleft")) -- 138
	updatePlayerControl("keyRight", Keyboard:isKeyPressed("D") or Controller:isButtonPressed(0, "dpright")) -- 139
	updatePlayerControl("keyBLeft", Keyboard:isKeyPressed("Q")) -- 140
	updatePlayerControl("keyBRight", Keyboard:isKeyPressed("E")) -- 141
	updatePlayerControl("keyUp", Keyboard:isKeyPressed("K")) -- 142
	updatePlayerControl("keyShoot", Keyboard:isKeyPressed("J") or Controller:isButtonPressed(0, "a")) -- 143
	updatePlayerControl("keyRush", Keyboard:isKeyPressed("U")) -- 144
	updatePlayerControl("keyEvade", Keyboard:isKeyPressed("I")) -- 145
	updatePlayerControl("keyFall", Keyboard:isKeyPressed("O")) -- 146
	updatePlayerControl("keyMelee", Keyboard:isKeyPressed("L")) -- 147
	return updatePlayerControl("keyTest", Keyboard:isKeyPressed("T")) -- 148
end -- 136
return Director.entry:addChild((function() -- 150
	local _with_0 = Node() -- 150
	_with_0:schedule(keyboardControl) -- 151
	return _with_0 -- 150
end)()) -- 150
