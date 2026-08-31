--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LeaderboardBoards
  Path:     game.ReplicatedStorage.GameInfo.LeaderboardBoards
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    WIPEABLE = {
        Level = {
            AutoRewrite = true
        },
        Kills = {
            AutoRewrite = true
        },
        DungeonClears = {
            AutoRewrite = true
        },
        PVPKills = {
            AutoRewrite = true
        },
        Robux = {
            AutoRewrite = true
        },
        Power = {
            AutoRewrite = true,
            StatReset = {
                Value = 0,
                Path = { "PeakGearScore" }
            }
        },
        BossRushSolo = {
            AutoRewrite = false
        },
        ChallengeSolo = {
            AutoRewrite = false
        },
        BossRushParty = {
            AutoRewrite = false,
            Party = true
        },
        ChallengeParty = {
            AutoRewrite = false,
            Party = true
        }
    }
};

function u1.GetWipeableNames() -- Line: 65
    -- upvalues: u1 (copy)
    local v2 = {};

    for i in u1.WIPEABLE do
        table.insert(v2, i);
    end;

    table.sort(v2);

    return v2;
end;

return u1;