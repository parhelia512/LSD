-- [yue]: Script/Unit/HeroUnit.yue
local _ENV = Dora(Dora.Platformer) -- 1
local Data <const> = Data -- 2
local Dictionary <const> = Dictionary -- 2
local Vec2 <const> = Vec2 -- 2
local Size <const> = Size -- 2
local TargetAllow <const> = TargetAllow -- 2
local Array <const> = Array -- 2
local Store = Data.store -- 3
do -- 8
	local _with_0 = Dictionary() -- 8
	_with_0.linearAcceleration = Vec2(0, -15) -- 9
	_with_0.bodyType = "Dynamic" -- 10
	_with_0.scale = 1.0 -- 11
	_with_0.density = 1.0 -- 12
	_with_0.friction = 1.0 -- 13
	_with_0.restitution = 0.0 -- 14
	_with_0.playable = "spine:charF" -- 15
	_with_0.defaultFaceRight = true -- 16
	_with_0.size = Size(100, 300) -- 17
	_with_0.sensity = 0 -- 18
	_with_0.move = 400 -- 19
	_with_0.jump = 1200 -- 20
	_with_0.detectDistance = 350 -- 21
	_with_0.tag = "player" -- 22
	_with_0.hp = 100.0 -- 24
	_with_0.decisionTree = "AI:PlayerControl" -- 25
	_with_0.usePreciseHit = false -- 26
	_with_0.attackDelay = 0.08 -- 27
	_with_0.attackSpeed = 1.2 -- 28
	_with_0.attackRange = Size(260 + 84 / 2, 250) -- 29
	_with_0.attackEffectDelay = 0.10 -- 30
	_with_0.attackPower = Vec2(100, 100) -- 31
	_with_0.attackTarget = "Single" -- 32
	do -- 33
		local config -- 34
		do -- 34
			local _with_1 = TargetAllow() -- 34
			_with_1.terrainAllowed = true -- 35
			_with_1:allow("Enemy", true) -- 36
			config = _with_1 -- 34
		end -- 34
		_with_0.targetAllow = config:toValue() -- 37
	end -- 33
	_with_0.damageType = 0 -- 38
	_with_0.defenceType = 0 -- 39
	_with_0.bulletType = "Bullet_1" -- 40
	_with_0.attackEffect = "" -- 41
	_with_0.hitEffect = "Particle/bloodp.par" -- 42
	_with_0.sndAttack = "" -- 43
	_with_0.sndFallen = "" -- 44
	_with_0.actions = Array({ -- 46
		"idle", -- 46
		"turn", -- 47
		"fallOff", -- 48
		"test", -- 49
		"cancel", -- 50
		"keepIdle", -- 51
		"keepMove", -- 52
		"idle1", -- 53
		"rush", -- 54
		"evade", -- 55
		"jump", -- 56
		"fall", -- 57
		"fmove", -- 58
		"bmove", -- 59
		"hit", -- 60
		"pistol", -- 61
		"melee" -- 62
	}) -- 45
	Store["charF"] = _with_0 -- 8
end -- 8
do -- 65
	local _with_0 = Dictionary() -- 65
	_with_0.linearAcceleration = Vec2(0, -15) -- 66
	_with_0.bodyType = "Dynamic" -- 67
	_with_0.scale = 1.0 -- 68
	_with_0.density = 1.0 -- 69
	_with_0.friction = 1.0 -- 70
	_with_0.restitution = 0.0 -- 71
	_with_0.playable = "spine:charM" -- 72
	_with_0.defaultFaceRight = true -- 73
	_with_0.size = Size(100, 300) -- 74
	_with_0.sensity = 0 -- 75
	_with_0.move = 300 -- 76
	_with_0.jump = 1200 -- 77
	_with_0.detectDistance = 350 -- 78
	_with_0.tag = "player" -- 79
	_with_0.hp = 5.0 -- 81
	_with_0.decisionTree = "AI:NPC" -- 82
	_with_0.usePreciseHit = false -- 83
	_with_0.attackDelay = 0.4 -- 84
	_with_0.attackEffectDelay = 0.1 -- 85
	_with_0.attackPower = Vec2(100, 100) -- 86
	_with_0.attackTarget = "Single" -- 87
	do -- 88
		local config -- 89
		do -- 89
			local _with_1 = TargetAllow() -- 89
			_with_1.terrainAllowed = true -- 90
			_with_1:allow("Enemy", true) -- 91
			config = _with_1 -- 89
		end -- 89
		_with_0.targetAllow = config:toValue() -- 92
	end -- 88
	_with_0.damageType = 0 -- 93
	_with_0.defenceType = 0 -- 94
	_with_0.bulletType = "Bullet_1" -- 95
	_with_0.attackEffect = "" -- 96
	_with_0.hitEffect = "" -- 97
	_with_0.sndAttack = "" -- 98
	_with_0.sndFallen = "" -- 99
	_with_0.actions = Array({ -- 101
		"idle", -- 101
		"turn", -- 102
		"fallOff", -- 103
		"test", -- 104
		"cancel", -- 105
		"keepIdle", -- 106
		"keepMove", -- 107
		"idle1", -- 108
		"rush", -- 109
		"evade", -- 110
		"jump", -- 111
		"pistol", -- 112
		"fall", -- 113
		"fmove", -- 114
		"bmove" -- 115
	}) -- 100
	Store["charM"] = _with_0 -- 65
end -- 65
local _with_0 = Dictionary() -- 118
_with_0.linearAcceleration = Vec2(0, -15) -- 119
_with_0.bodyType = "Dynamic" -- 120
_with_0.scale = 1.0 -- 121
_with_0.density = 1.0 -- 122
_with_0.friction = 1.0 -- 123
_with_0.restitution = 0.0 -- 124
_with_0.playable = "spine:villywan" -- 125
_with_0.defaultFaceRight = true -- 126
_with_0.size = Size(100, 300) -- 127
_with_0.sensity = 0 -- 128
_with_0.move = 300 -- 129
_with_0.jump = 1200 -- 130
_with_0.detectDistance = 350 -- 131
_with_0.tag = "player" -- 132
_with_0.hp = 5.0 -- 134
_with_0.decisionTree = "AI:NPC" -- 135
_with_0.usePreciseHit = false -- 136
_with_0.attackDelay = 0.4 -- 137
_with_0.attackEffectDelay = 0.1 -- 138
_with_0.attackPower = Vec2(100, 100) -- 139
_with_0.attackTarget = "Single" -- 140
do -- 141
	local config -- 142
	do -- 142
		local _with_1 = TargetAllow() -- 142
		_with_1.terrainAllowed = true -- 143
		_with_1:allow("Enemy", true) -- 144
		config = _with_1 -- 142
	end -- 142
	_with_0.targetAllow = config:toValue() -- 145
end -- 141
_with_0.damageType = 0 -- 146
_with_0.defenceType = 0 -- 147
_with_0.bulletType = "Bullet_1" -- 148
_with_0.attackEffect = "" -- 149
_with_0.hitEffect = "" -- 150
_with_0.sndAttack = "" -- 151
_with_0.sndFallen = "" -- 152
_with_0.actions = Array({ -- 154
	"idle", -- 154
	"turn", -- 155
	"fallOff", -- 156
	"test", -- 157
	"cancel", -- 158
	"keepIdle", -- 159
	"keepMove", -- 160
	"idle1", -- 161
	"rush", -- 162
	"evade", -- 163
	"jump", -- 164
	"pistol", -- 165
	"fall", -- 166
	"fmove", -- 167
	"bmove" -- 168
}) -- 153
Store["villywan"] = _with_0 -- 118
