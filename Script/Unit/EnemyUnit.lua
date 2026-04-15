-- [yue]: Script/Unit/EnemyUnit.yue
local _ENV = Dora(Dora.Platformer) -- 1
local Data <const> = Data -- 2
local Dictionary <const> = Dictionary -- 2
local Vec2 <const> = Vec2 -- 2
local Size <const> = Size -- 2
local TargetAllow <const> = TargetAllow -- 2
local Array <const> = Array -- 2
local Store = Data.store -- 3
do -- 5
	local _with_0 = Dictionary() -- 5
	_with_0.linearAcceleration = Vec2(0, -15) -- 6
	_with_0.bodyType = "Dynamic" -- 7
	_with_0.scale = 1.0 -- 8
	_with_0.density = 1.0 -- 9
	_with_0.friction = 1.0 -- 10
	_with_0.restitution = 0.0 -- 11
	_with_0.playable = "spine:xiaotaotie" -- 12
	_with_0.defaultFaceRight = true -- 13
	_with_0.size = Size(100, 300) -- 14
	_with_0.sensity = 0.5 -- 15
	_with_0.move = 300 -- 16
	_with_0.jump = 800 -- 17
	_with_0.detectDistance = 1200 -- 18
	_with_0.hp = 3.0 -- 19
	_with_0.decisionTree = "AI:XIAOTAOTIE" -- 20
	_with_0.usePreciseHit = false -- 21
	_with_0.attackDelay = 0.5 -- 22
	_with_0.attackSpeed = 1 -- 23
	_with_0.attackRange = Size(260 + 84 / 2, 250) -- 24
	_with_0.attackEffectDelay = 0.08 -- 25
	_with_0.attackPower = Vec2(100, 100) -- 26
	_with_0.attackTarget = "Single" -- 27
	do -- 28
		local config -- 29
		do -- 29
			local _with_1 = TargetAllow() -- 29
			_with_1.terrainAllowed = true -- 30
			_with_1:allow("Enemy", true) -- 31
			config = _with_1 -- 29
		end -- 29
		_with_0.targetAllow = config:toValue() -- 32
	end -- 28
	_with_0.actions = Array({ -- 34
		"idle", -- 34
		"turn", -- 35
		"fmove", -- 36
		"jump", -- 37
		"fallOff", -- 38
		"cancel", -- 39
		"keepIdle", -- 40
		"keepMove", -- 41
		"idle1", -- 42
		"hit", -- 43
		"lose", -- 44
		"bomb", -- 45
		"dizzy1", -- 46
		"dizzy", -- 47
		"swing", -- 48
		"butt", -- 49
		"roll", -- 50
		"rollStart", -- 51
		"rollEnd", -- 52
		"blow" -- 53
	}) -- 33
	Store["xiaotaotie"] = _with_0 -- 5
end -- 5
local _with_0 = Dictionary() -- 56
_with_0.linearAcceleration = Vec2(0, -15) -- 57
_with_0.bodyType = "Dynamic" -- 58
_with_0.scale = 1.0 -- 59
_with_0.density = 1.0 -- 60
_with_0.friction = 1.0 -- 61
_with_0.restitution = 0.0 -- 62
_with_0.playable = "spine:dataotie" -- 63
_with_0.defaultFaceRight = false -- 64
_with_0.size = Size(450, 450) -- 65
_with_0.sensity = 0.5 -- 66
_with_0.move = 300 -- 67
_with_0.jump = 800 -- 68
_with_0.detectDistance = 1200 -- 69
_with_0.hp = 5.0 -- 70
_with_0.decisionTree = "AI:DATAOTIE" -- 71
_with_0.usePreciseHit = false -- 72
_with_0.attackDelay = 0.5 -- 73
_with_0.attackSpeed = 1 -- 74
_with_0.attackRange = Size(260 + 84 / 2, 500) -- 75
_with_0.attackEffectDelay = 0.08 -- 76
_with_0.actions = Array({ -- 78
	"idle", -- 78
	"turn", -- 79
	"fmove", -- 80
	"jump", -- 81
	"fallOff", -- 82
	"cancel", -- 83
	"keepIdle", -- 84
	"keepMove", -- 85
	"idle1", -- 86
	"hit", -- 87
	"lose", -- 88
	"trample", -- 89
	"rush2", -- 90
	"shot", -- 91
	"rush3", -- 92
	"dizzy1", -- 93
	"dizzy2", -- 94
	"swing", -- 95
	"pounce", -- 96
	"rush", -- 97
	"fmove1", -- 98
	"dtdRush1" -- 99
}) -- 77
Store["dataotie"] = _with_0 -- 56
