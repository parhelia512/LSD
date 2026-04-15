-- [yue]: Test/FigureTest.yue
local _ENV = Dora(Dora.ImGui) -- 1
local Path <const> = Path -- 2
local Content <const> = Content -- 2
local require <const> = require -- 2
local Director <const> = Director -- 2
local Spine <const> = Spine -- 2
local Node <const> = Node -- 2
local App <const> = App -- 2
local SetNextWindowBgAlpha <const> = SetNextWindowBgAlpha -- 2
local SetNextWindowPos <const> = SetNextWindowPos -- 2
local Vec2 <const> = Vec2 -- 2
local SetNextWindowSize <const> = SetNextWindowSize -- 2
local Begin <const> = Begin -- 2
local Text <const> = Text -- 2
local Separator <const> = Separator -- 2
local Combo <const> = Combo -- 2
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
local RoleStats = require("UI.RoleStats") -- 16
local roleStats -- 18
do -- 18
	local _with_0 = RoleStats() -- 18
	_with_0:alignLayout() -- 19
	roleStats = _with_0 -- 18
end -- 18
Director.ui3D:addChild(roleStats) -- 20
local figures = { -- 23
	"molingFigure", -- 23
	"ayanFigure", -- 24
	"charFFigure", -- 25
	"charFigure", -- 26
	"charMFigure", -- 27
	"liyenaFigure", -- 28
	"moyuFigure", -- 29
	"niniliteFigure", -- 30
	"sunbornFigure", -- 31
	"villywanFigure", -- 32
	"wuyunFigure", -- 33
	"yuzijiangFigure" -- 34
} -- 22
local currentFigure = 1 -- 36
local spine -- 38
do -- 38
	local _with_0 = Spine(figures[currentFigure]) -- 38
	_with_0.look = "full" -- 39
	_with_0:play("idle", true) -- 40
	_with_0.scaleX = 0.21 -- 41
	_with_0.scaleY = 0.21 -- 42
	spine = _with_0 -- 38
end -- 38
roleStats.figure:addChild(spine) -- 43
return Director.entry:addChild((function() -- 45
	local _with_0 = Node() -- 45
	local windowFlags = { -- 47
		"NoDecoration", -- 47
		"AlwaysAutoResize", -- 48
		"NoSavedSettings", -- 49
		"NoFocusOnAppearing", -- 50
		"NoNav", -- 51
		"NoMove" -- 52
	} -- 46
	_with_0:schedule(function() -- 53
		local width, height -- 54
		do -- 54
			local _obj_0 = App.visualSize -- 54
			width, height = _obj_0.width, _obj_0.height -- 54
		end -- 54
		SetNextWindowBgAlpha(0.35) -- 55
		SetNextWindowPos(Vec2(width - 10, 10), "Always", Vec2(1, 0)) -- 56
		SetNextWindowSize(Vec2(100, 0), "FirstUseEver") -- 57
		return Begin("FigureTest", windowFlags, function() -- 58
			Text("Figure") -- 59
			Separator() -- 60
			local changed -- 61
			changed, currentFigure = Combo("Change", currentFigure, figures) -- 61
			if changed then -- 62
				spine:removeFromParent() -- 63
				do -- 64
					local _with_1 = Spine(figures[currentFigure]) -- 64
					_with_1.look = "full" -- 65
					_with_1:play("idle", true) -- 66
					_with_1.scaleX = 0.21 -- 67
					_with_1.scaleY = 0.21 -- 68
					spine = _with_1 -- 64
				end -- 64
				return roleStats.figure:addChild(spine) -- 69
			end -- 62
		end) -- 58
	end) -- 53
	return _with_0 -- 45
end)()) -- 45
