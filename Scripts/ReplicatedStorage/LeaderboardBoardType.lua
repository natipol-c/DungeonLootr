--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LeaderboardBoardType
  Path:     game.ReplicatedStorage.CmdrClient.Types.LeaderboardBoardType
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(script.Parent.Parent.Shared.Util);

local function GetBoardNames() -- Line: 8
    -- upvalues: ReplicatedStorage (copy)
    local success, result = pcall(require, ReplicatedStorage.GameInfo.LeaderboardBoards);

    if success then
        return result.GetWipeableNames();
    end;

    warn("[Cmdr] Failed to load LeaderboardBoards for leaderboardBoard type:", result);

    return {};
end;

return function(p1) -- Line: 17
    -- upvalues: Util (copy), GetBoardNames (copy)
    p1:RegisterType("leaderboardBoard", Util.MakeEnumType("LeaderboardBoard", GetBoardNames()));
end;