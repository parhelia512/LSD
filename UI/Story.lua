-- [yue]: UI/Story.yue
local _module_0 = nil -- 1
local _ENV = Dora -- 1
local require <const> = require -- 2
local type <const> = type -- 2
local Class <const> = Class -- 2
local property <const> = property -- 2
local print <const> = print -- 2
local thread <const> = thread -- 2
local tostring <const> = tostring -- 2
local Cache <const> = Cache -- 2
local sleep <const> = sleep -- 2
local View <const> = View -- 2
local Pass <const> = Pass -- 2
local SpriteEffect <const> = SpriteEffect -- 2
local emit <const> = emit -- 2
local collectgarbage <const> = collectgarbage -- 2
local Story = require("UI.View.Story") -- 3
local StoryFigure = require("UI.StoryFigure") -- 4
local Answer = require("UI.Answer") -- 5
local Struct = require("Utils").Struct -- 6
local YarnRunner = require("YarnRunner") -- 7
local Config = require("Data.Config") -- 8
local Command = require("System.Command") -- 9
local Dialog = Struct.Story.Dialog("character", "name", "text") -- 11
local getCharName -- 13
getCharName = function(current) -- 13
	if current.marks then -- 14
		local _list_0 = current.marks -- 15
		for _index_0 = 1, #_list_0 do -- 15
			local mark = _list_0[_index_0] -- 15
			local _type_0 = type(mark) -- 16
			local _tab_0 = "table" == _type_0 or "userdata" == _type_0 -- 16
			if _tab_0 then -- 16
				local attr = mark.name -- 16
				local name -- 16
				do -- 16
					local _obj_0 = mark.attrs -- 16
					local _type_1 = type(_obj_0) -- 16
					if "table" == _type_1 or "userdata" == _type_1 then -- 16
						name = _obj_0.name -- 16
					end -- 16
				end -- 16
				local id -- 16
				do -- 16
					local _obj_0 = mark.attrs -- 16
					local _type_1 = type(_obj_0) -- 16
					if "table" == _type_1 or "userdata" == _type_1 then -- 16
						id = _obj_0.id -- 16
					end -- 16
				end -- 16
				if name == nil then -- 16
					name = '' -- 16
				end -- 16
				if id == nil then -- 16
					id = '' -- 16
				end -- 16
				if attr ~= nil then -- 16
					if ("char" == attr or "Character" == attr) then -- 17
						if id == "char" then -- 18
							id = Config.char -- 18
						end -- 18
						return name, id -- 19
					end -- 17
				end -- 16
			end -- 16
		end -- 15
	end -- 14
	return '', '' -- 20
end -- 13
_module_0 = Class(Story, { -- 23
	reviewVisible = property(function(self) -- 23
		return self._reviewVisible -- 23
	end, function(self, value) -- 24
		self._reviewVisible = value -- 25
		self.reviewMask.visible = value -- 26
		self.topCenter.visible = value -- 27
		self.reviewBack.visible = value -- 28
		self.reviewArea.visible = value -- 29
	end), -- 23
	advance = function(self, option) -- 31
		local action, result = self._runner:advance(option) -- 32
		if "Text" == action then -- 33
			if result.optionsFollowed then -- 34
				local _ -- 35
				_, self._options = self._runner:advance() -- 35
			else -- 37
				self._options = nil -- 37
			end -- 34
			self._current = result -- 38
			return true -- 39
		elseif "Command" == action then -- 40
			self._current = nil -- 41
			self._options = nil -- 42
			self.answerList:removeAllChildren() -- 43
			self.continueIcon.visible = true -- 44
			self._advancing = true -- 45
			do -- 46
				local _type_0 = type(result) -- 46
				local _tab_0 = "table" == _type_0 or "userdata" == _type_0 -- 46
				if _tab_0 then -- 46
					local preload = result.preload -- 46
					if preload ~= nil then -- 46
						self._preload = preload -- 47
						return self:advance() -- 48
					end -- 46
				end -- 46
			end -- 46
			return true -- 49
		elseif "Error" == action then -- 50
			print(result) -- 51
			return false -- 52
		else -- 54
			return false -- 54
		end -- 33
	end, -- 31
	__init = function(self, dialogFile) -- 56
		self._runner = YarnRunner(dialogFile, "Start", Config, Command) -- 57
		self:advance() -- 58
		self.reviewVisible = false -- 59
		self._advancing = false -- 60
		local nextSentence -- 61
		nextSentence = function() -- 61
			if self._advancing then -- 62
				return -- 62
			end -- 62
			if self._options then -- 63
				return -- 63
			end -- 63
			if self:advance() then -- 64
				return thread(function() -- 65
					return self:updateDialogAsync() -- 65
				end) -- 65
			else -- 67
				return self:hide() -- 67
			end -- 64
		end -- 61
		self:gslot("Story.Advance", function() -- 68
			self._advancing = false -- 69
			return nextSentence() -- 70
		end) -- 68
		self.confirm:slot("Tapped", nextSentence) -- 71
		self.textArea:slot("NoneScrollTapped", nextSentence) -- 72
		self.reviewButton:slot("Tapped", function() -- 73
			if self._advancing then -- 74
				return -- 74
			end -- 74
			self.reviewVisible = true -- 75
			return self:alignLayout() -- 76
		end) -- 73
		self.reviewBack:slot("Tapped", function() -- 77
			self.reviewVisible = false -- 77
		end) -- 77
		self.reviewArea:slot("NoneScrollTapped", function() -- 78
			self.reviewVisible = false -- 78
		end) -- 78
		do -- 79
			local _with_0 = Dialog() -- 79
			_with_0.__modified = function(key, value) -- 80
				if "character" == key then -- 81
					self.figure:removeAllChildren() -- 82
					if (value ~= nil) and value ~= "" then -- 83
						return self.figure:addChild(StoryFigure({ -- 84
							char = value -- 84
						})) -- 84
					end -- 83
				elseif "name" == key then -- 85
					if (value ~= nil) then -- 86
						self.name.text = value -- 86
					end -- 86
				elseif "text" == key then -- 87
					if (value ~= nil) then -- 88
						self.text.text = value -- 88
					end -- 88
				end -- 80
			end -- 80
			_with_0.__updated = function() -- 89
				return self:alignLayout() -- 89
			end -- 89
			self._dialog = _with_0 -- 79
		end -- 79
		self._reviews = { } -- 90
		self.visible = false -- 91
	end, -- 56
	updateDialogAsync = function(self) -- 93
		if self._preload then -- 94
			local _list_0 = self._preload -- 95
			for _index_0 = 1, #_list_0 do -- 95
				local item = _list_0[_index_0] -- 95
				local figureFile -- 96
				if 'char' == item then -- 97
					figureFile = "spine:" .. tostring(Config.char) .. "Figure" -- 97
				elseif 'vivi' == item then -- 98
					figureFile = "spine:vikaFigure" -- 98
				else -- 99
					figureFile = "spine:" .. tostring(item) .. "Figure" -- 99
				end -- 96
				Cache:loadAsync(figureFile) -- 100
			end -- 95
			self._preload = nil -- 101
		end -- 94
		if not self._current then -- 102
			return -- 102
		end -- 102
		if self._advancing then -- 103
			return -- 103
		end -- 103
		self._advancing = true -- 104
		local name, characterId = getCharName(self._current) -- 105
		local figureFile -- 106
		if 'char' == characterId then -- 107
			figureFile = "spine:" .. tostring(Config.char) .. "Figure" -- 107
		elseif 'vivi' == characterId then -- 108
			figureFile = "spine:vikaFigure" -- 108
		else -- 109
			figureFile = "spine:" .. tostring(characterId) .. "Figure" -- 109
		end -- 106
		if characterId and characterId ~= "" then -- 110
			Cache:loadAsync(figureFile) -- 110
		end -- 110
		local text = self._current.text -- 111
		do -- 112
			local _obj_0 = self._reviews -- 112
			_obj_0[#_obj_0 + 1] = { -- 112
				name = name, -- 112
				text = text -- 112
			} -- 112
		end -- 112
		self._dialog.character = characterId -- 113
		self._dialog.name = name -- 114
		self._dialog.text = text -- 115
		self.answerList:removeAllChildren() -- 116
		if self._options then -- 117
			self.continueIcon.visible = false -- 118
			local count = #self._options -- 119
			for i = 1, count do -- 120
				local option = self._options[i] -- 121
				name = getCharName(option) -- 122
				local optionText = option.text -- 123
				self.answerList:addChild((function() -- 124
					local _with_0 = Answer({ -- 124
						text = optionText -- 124
					}) -- 124
					_with_0:slot("Tapped", function() -- 125
						_with_0.touchEnabled = false -- 126
						return thread(function() -- 127
							sleep(0.3) -- 128
							do -- 129
								local _obj_0 = self._reviews -- 129
								_obj_0[#_obj_0 + 1] = { -- 129
									name = name, -- 129
									text = optionText -- 129
								} -- 129
							end -- 129
							if self:advance(i) then -- 130
								return thread(function() -- 131
									return self:updateDialogAsync() -- 131
								end) -- 131
							else -- 133
								return self:hide() -- 133
							end -- 130
						end) -- 127
					end) -- 125
					return _with_0 -- 124
				end)()) -- 124
			end -- 120
			local size = self.answerList:alignItems(40) -- 134
			self.answerList.size = size -- 135
			self.answerList:alignItems(40) -- 136
		else -- 138
			self.continueIcon.visible = true -- 138
		end -- 117
		self._advancing = false -- 139
	end, -- 93
	showAsync = function(self) -- 141
		self:updateDialogAsync() -- 142
		self.visible = true -- 143
		self._viewScale = View.scale -- 144
		self._viewEffect = View.postEffect -- 145
		View.scale = 4 * self._viewScale -- 146
		local size = View.size -- 147
		local blurH -- 148
		do -- 148
			local _with_0 = Pass("builtin:vs_sprite", "builtin:fs_spriteblurh") -- 148
			_with_0.grabPass = true -- 149
			_with_0:set("u_radius", size.width) -- 150
			blurH = _with_0 -- 148
		end -- 148
		local blurV -- 151
		do -- 151
			local _with_0 = Pass("builtin:vs_sprite", "builtin:fs_spriteblurv") -- 151
			_with_0.grabPass = true -- 152
			_with_0:set("u_radius", size.height) -- 153
			blurV = _with_0 -- 151
		end -- 151
		do -- 154
			local _with_0 = SpriteEffect() -- 154
			for _ = 1, 3 do -- 155
				_with_0:add(blurH) -- 156
				_with_0:add(blurV) -- 157
			end -- 155
			View.postEffect = _with_0 -- 154
		end -- 154
		self:gslot("AppChange", function(settingName) -- 158
			if settingName == "Size" then -- 158
				local width, height -- 159
				do -- 159
					local _obj_0 = View.size -- 159
					width, height = _obj_0.width, _obj_0.height -- 159
				end -- 159
				blurH:set("u_radius", width) -- 160
				return blurV:set("u_radius", height) -- 161
			end -- 158
		end) -- 158
		return emit("Story.Display", true) -- 162
	end, -- 141
	hide = function(self) -- 164
		self:gslot("AppChange", nil) -- 165
		self:emit("Ended") -- 166
		self:removeFromParent() -- 167
		local viewScale = self._viewScale -- 168
		local viewEffect = self._viewEffect -- 169
		return thread(function() -- 170
			collectgarbage() -- 171
			Cache:removeUnused() -- 172
			emit("Story.Display", false) -- 173
			View.scale = viewScale -- 174
			sleep() -- 175
			View.postEffect = viewEffect -- 176
		end) -- 170
	end -- 164
}) -- 22
return _module_0 -- 1
