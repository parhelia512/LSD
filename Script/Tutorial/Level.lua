-- [yue]: Script/Tutorial/Level.yue
local _module_0 = nil -- 1
local _ENV = Dora(Dora.Platformer) -- 1
local require <const> = require -- 2
local Audio <const> = Audio -- 2
local Director <const> = Director -- 2
local Cache <const> = Cache -- 2
local Data <const> = Data -- 2
local Entity <const> = Entity -- 2
local Vec2 <const> = Vec2 -- 2
local once <const> = once -- 2
local sleep <const> = sleep -- 2
local emit <const> = emit -- 2
local Group <const> = Group -- 2
local threadLoop <const> = threadLoop -- 2
local Spine <const> = Spine -- 2
local thread <const> = thread -- 2
local Observer <const> = Observer -- 2
local TutorialSystem = require("Tutorial.System") -- 4
local TutorialAI = require("Tutorial.AI") -- 5
local TutorialAction = require("Tutorial.Action").default -- 6
local LoopTowerA = require("Scene.LoopTowerA") -- 7
local Config = require("Data.Config") -- 8
local _anon_func_0 = function(_with_0) -- 58
	local _with_1 = Spine("kineticgun") -- 58
	_with_1.look = "PT" -- 59
	_with_1.scaleX = 0.2 -- 60
	_with_1.scaleY = 0.2 -- 60
	return _with_1 -- 58
end -- 58
_module_0 = function() -- 10
	Audio:playStream("Music/军事学园.mp3", true, 1) -- 11
	LoopTowerA:loadAsync() -- 12
	local world = LoopTowerA() -- 13
	do -- 14
		local _with_0 = Director.entry -- 14
		_with_0:removeAllChildren() -- 15
		Cache:removeUnused("Texture") -- 16
		_with_0:addChild(world) -- 17
	end -- 14
	Data:setRelation(1, 2, "Enemy") -- 18
	Entity:clear() -- 20
	Data.store:clear() -- 21
	Data.store.world = world -- 22
	TutorialAction() -- 23
	TutorialAI() -- 24
	TutorialSystem() -- 25
	local chars = { -- 28
		{ -- 28
			'ninilite', -- 28
			500, -- 28
			-2, -- 28
			true -- 28
		}, -- 28
		{ -- 29
			Config.char, -- 29
			800, -- 29
			0, -- 29
			false -- 29
		} -- 29
	} -- 27
	for _index_0 = 1, #chars do -- 30
		local _des_0 = chars[_index_0] -- 30
		local name, x, order, faceRight = _des_0[1], _des_0[2], _des_0[3], _des_0[4] -- 30
		Entity({ -- 32
			name = name, -- 32
			faceRight = faceRight, -- 33
			order = order, -- 34
			player = name == "charF" or name == "charM", -- 35
			group = 1, -- 36
			position = Vec2(x, world.offset), -- 37
			tutorial = true -- 38
		}) -- 31
	end -- 30
	local HUDControl = require("UI.HUDControl") -- 40
	Director.ui3D:addChild((function() -- 42
		local _with_0 = HUDControl() -- 42
		_with_0:schedule(once(function() -- 43
			sleep(0.1) -- 44
			emit("MessageBox.Add", { -- 45
				title = "系统", -- 45
				special = false, -- 45
				text = "已上线/79.03.27.09.24；" -- 45
			}) -- 45
			sleep(0.9) -- 46
			return emit("MessageBox.Add", { -- 47
				title = "系统", -- 47
				special = false, -- 47
				text = "代理日志更新，代理第1天；" -- 47
			}) -- 47
		end)) -- 43
		return _with_0 -- 42
	end)()) -- 42
	Group({ -- 49
		"player", -- 49
		"name" -- 49
	}):each(function(self) -- 49
		local _exp_0 = self.name -- 50
		if "ninilite" == _exp_0 then -- 50
			self.decisionTree = "AI:NiniliteIntro" -- 51
		end -- 50
	end) -- 49
	threadLoop(function() -- 53
		local group = Group({ -- 54
			"player", -- 54
			"name", -- 54
			"unit" -- 54
		}) -- 54
		if group.count > 0 then -- 55
			group:each(function(self) -- 56
				local _exp_0 = self.name -- 56
				if "charF" == _exp_0 or "charM" == _exp_0 then -- 56
					do -- 57
						local _with_0 = self.unit.playable -- 57
						_with_0:setSlot("pistol", _anon_func_0(_with_0)) -- 58
					end -- 57
					return true -- 61
				end -- 56
			end) -- 56
			return true -- 62
		end -- 55
	end) -- 53
	return thread(function() -- 64
		sleep(2) -- 65
		local Story = require("UI.Story") -- 66
		local _with_0 = Story("Tutorial/Dialog/firstMeet.yarn") -- 67
		_with_0:addTo(Director.ui3D) -- 68
		_with_0:showAsync() -- 69
		_with_0:slot("Ended", function() -- 70
			return thread(function() -- 70
				Group({ -- 71
					"player" -- 71
				}):each(function(self) -- 71
					if self.name == "ninilite" then -- 72
						self.unit.playable.speed = 1.0 -- 73
						self.unit.decisionTree = "AI:NiniliteFight" -- 74
						self.unit:start("cancel") -- 75
						return true -- 76
					end -- 72
					return false -- 77
				end) -- 71
				Cache:loadAsync("spine:xiaotaotie") -- 78
				Entity({ -- 80
					name = "xiaotaotie", -- 80
					position = Vec2(1200, 168), -- 81
					group = 2, -- 82
					order = -1, -- 83
					faceRight = false, -- 84
					tutorial = true, -- 85
					monster = true -- 86
				}) -- 79
				sleep(1) -- 87
				emit("HUD.DisplayMove", true) -- 88
				local PlayBubbleChat = require("System.PlayBubbleChat") -- 89
				PlayBubbleChat("Tutorial/Dialog/evade.yarn") -- 90
				local moved = false -- 91
				do -- 92
					local _with_1 = Observer("Add", { -- 92
						"keyLeft", -- 92
						"player" -- 92
					}) -- 92
					_with_1:watch(function(_entity, keyLeft) -- 93
						if keyLeft then -- 93
							return thread(function() -- 93
								if not moved and Group({ -- 94
									"monster" -- 94
								}).count > 0 then -- 94
									moved = true -- 95
									PlayBubbleChat("Tutorial/Dialog/evadeLeft.yarn") -- 96
									sleep(1) -- 97
									PlayBubbleChat("Tutorial/Dialog/weapon.yarn") -- 98
									emit("Tutorial.Weapon") -- 99
								end -- 94
								return true -- 100
							end) -- 93
						end -- 93
					end) -- 93
				end -- 92
				local _with_1 = Observer("AddOrChange", { -- 101
					"keyRight", -- 101
					"player" -- 101
				}) -- 101
				_with_1:watch(function(_entity, keyRight) -- 102
					if keyRight then -- 102
						return thread(function() -- 102
							if not moved and Group({ -- 103
								"monster" -- 103
							}).count > 0 then -- 103
								moved = true -- 104
								PlayBubbleChat("Tutorial/Dialog/evadeRight.yarn") -- 105
								sleep(1) -- 106
								PlayBubbleChat("Tutorial/Dialog/weapon.yarn") -- 107
								emit("Tutorial.Weapon") -- 108
							end -- 103
							return true -- 109
						end) -- 102
					end -- 102
				end) -- 102
				return _with_1 -- 101
			end) -- 70
		end) -- 70
		return _with_0 -- 67
	end) -- 64
end -- 10
return _module_0 -- 1
