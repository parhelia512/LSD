-- [yue]: UI/MessageBox.yue
local _module_0 = nil -- 1
local _ENV = Dora -- 1
local require <const> = require -- 2
local Class <const> = Class -- 2
local Size <const> = Size -- 2
local MessageBox = require("UI.View.MessageBox") -- 3
local Message = require("UI.Message") -- 4
local Struct = require("Utils").Struct -- 5
local Item = Struct.MessageBox.Item("title", "special", "text") -- 7
local Array = Struct.Array() -- 8
_module_0 = Class(MessageBox, { -- 11
	__init = function(self) -- 11
		do -- 12
			local _with_0 = Array() -- 12
			_with_0.__added = function(index, item) -- 13
				return self.view:addChild(Message(item), index) -- 14
			end -- 13
			_with_0.__updated = function() -- 15
				self.area:adjustSizeWithAlign("Auto", 0, Size(700, 204)) -- 16
				return self.area:scrollToPosY(0) -- 17
			end -- 15
			self._messages = _with_0 -- 12
		end -- 12
		return self:gslot("MessageBox.Add", function(item) -- 18
			return self._messages:insert(Item({ -- 20
				title = item.title, -- 20
				special = item.special, -- 21
				text = item.text -- 22
			})) -- 19
		end) -- 18
	end -- 11
}) -- 10
return _module_0 -- 1
