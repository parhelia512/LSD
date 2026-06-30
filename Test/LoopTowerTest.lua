-- [yue]: Test/LoopTowerTest.yue
local _ENV = Dora -- 1
local Path <const> = Path -- 2
local Content <const> = Content -- 2
local Director <const> = Director -- 2
local Node <const> = Node -- 2
local View <const> = View -- 2
local math <const> = math -- 2
local Sprite <const> = Sprite -- 2
local Vec2 <const> = Vec2 -- 2
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
return Director.entry:addChild((function() -- 16
	local _with_0 = Node() -- 16
	_with_0.scaleX = 1 -- 17
	_with_0.scaleY = 1 -- 18
	_with_0.size = View.size -- 19
	_with_0.height = _with_0.height + 600 -- 20
	do -- 21
		local _with_1 = _with_0:grab(10, 1) -- 21
		for x = 1, 11 do -- 22
			for y = 1, 2 do -- 23
				local pos = _with_1:getPos(x, y) -- 24
				_with_1:setPos(x, y, pos, math.sin(math.abs(x - 6) * math.pi / 50) * math.abs(x - 6) * 200) -- 25
			end -- 23
		end -- 22
	end -- 21
	_with_0:addChild((function() -- 26
		local _with_1 = Sprite("Image/loopTower.png") -- 26
		_with_1.position = Vec2(0.5, 0.5) * View.size -- 27
		_with_1.y = _with_1.y + 350 -- 28
		local scale = View.size.height / 1563 -- 29
		_with_1.scaleX = scale -- 30
		_with_1.scaleY = scale -- 31
		return _with_1 -- 26
	end)()) -- 26
	return _with_0 -- 16
end)()) -- 16
