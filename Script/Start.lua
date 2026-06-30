-- [yue]: Script/Start.yue
local _ENV = Dora -- 1
local DB <const> = DB -- 2
local Path <const> = Path -- 2
local Content <const> = Content -- 2
local tostring <const> = tostring -- 2
local Director <const> = Director -- 2
local once <const> = once -- 2
local require <const> = require -- 2
if not DB:existDB("lsd") then -- 4
	local dbPath = Path(Content.writablePath, "lsd.db") -- 5
	DB:exec("ATTACH DATABASE '" .. tostring(dbPath) .. "' AS lsd;") -- 6
end -- 4
Director.entry:slot("Cleanup", function() -- 7
	return DB:exec("DETACH DATABASE lsd") -- 7
end) -- 7
return Director.entry:schedule(once(function() -- 9
	local Config = require("Data.Config") -- 10
	Config:loadAsync() -- 11
	Config.skipOP = 0 -- 12
	Config.char = "charM" -- 13
	Config.charName = "瑾" -- 14
	Config.heroine = "于灵" -- 15
	if Config.skipOP == nil or Config.skipOP == 0 then -- 17
		Config.skipOP = 1 -- 18
		local PlayOP = require("System.PlayOP") -- 19
		PlayOP() -- 20
	end -- 17
	local TutorialLevel = require("Tutorial.Level") -- 22
	return TutorialLevel() -- 23
end)) -- 9
