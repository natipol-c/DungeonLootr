--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LeaderboardSeason
  Path:     game.ReplicatedStorage.GameInfo.LeaderboardSeason
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    SEASON = 3,
    EXEMPT = {
        Robux = true
    }
};

function u1.Suffix(p2: string) -- Line: 39
    -- upvalues: u1 (copy)
    return u1.EXEMPT[p2] and "" or "_s" .. u1.SEASON;
end;

function u1.OrderedStoreName(p3: string) -- Line: 47
    -- upvalues: u1 (copy)
    return "Leaderboard_" .. p3 .. u1.Suffix(p3);
end;

function u1.DetailsStoreName(p4: string) -- Line: 54
    -- upvalues: u1 (copy)
    return p4 .. "_Details" .. u1.Suffix(p4);
end;

return u1;