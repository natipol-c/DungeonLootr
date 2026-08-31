--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RaidData
  Path:     game.ReplicatedStorage.GameInfo.RaidData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    MAX_PARTY_SIZE = 4,
    STARTING_LIVES = 3,
    MAP_ROOT = "Boss_Rush",
    MAP_LOAD_TIME = 10,
    LOADING_TIME = 15,
    PARTY_HP_SCALE = 0,
    UNLOCK_LEVEL = 100
};

function u1.CanEnter(p2: table) -- Line: 53
    -- upvalues: u1 (copy)
    if p2 then
        p2 = p2.Data;
    end;

    if not p2 then
        return false, "Data not loaded";
    end;

    if (p2.PlayerLevel or 0) >= u1.UNLOCK_LEVEL then
        return true, nil;
    end;

    return false, "Reach Player Level " .. u1.UNLOCK_LEVEL .. " to enter Raids";
end;

u1.DIFFICULTY_ORDER = { "Normal", "Extreme", "Impossible" };
u1.DIFFICULTY_INDEX = {};

for i, v in u1.DIFFICULTY_ORDER do
    u1.DIFFICULTY_INDEX[v] = i;
end;

u1.Raids = {
    ["The Beginning"] = {
        BossId = "Genesis",
        DisplayName = "The Beginning",
        BossDisplayName = "Genesis",
        Map = "Throne_Room",
        LightingPreset = "Throne_Room",
        Scale = nil,
        ModuleName = "TheBeginning",
        PhaseThresholds = { 0.5, 0.25 },
        Difficulties = {
            Normal = {
                Health = 85000000,
                Damage = 3500,
                TimeLimit = 1200
            },
            Extreme = {
                Health = 200000000,
                Damage = 5800,
                TimeLimit = 1200
            },
            Impossible = {
                Health = 700000000,
                Damage = 8500,
                TimeLimit = 1200
            }
        }
    }
};
u1.RAID_ORDER = { "The Beginning" };
u1.DEFAULT_RAID = u1.RAID_ORDER[1];
u1.DEFAULT_DIFFICULTY = u1.DIFFICULTY_ORDER[1];

function u1.GetRaid(p3: string?) -- Line: 125
    -- upvalues: u1 (copy)
    return p3 and u1.Raids[p3] or nil;
end;

function u1.GetDifficulty(p4: string?, p5: string?) -- Line: 130
    -- upvalues: u1 (copy)
    local Raid = u1.GetRaid(p4);

    if Raid and p5 then
        return Raid.Difficulties[p5];
    end;

    return nil;
end;

function u1.IsValidDifficulty(p6: string?) -- Line: 137
    -- upvalues: u1 (copy)
    local v7;

    if p6 == nil then
        v7 = false;
    else
        v7 = u1.DIFFICULTY_INDEX[p6] ~= nil;
    end;

    return v7;
end;

function u1.CalcBossStats(p8: string, p9: string, p10: number) -- Line: 143
    -- upvalues: u1 (copy)
    local Difficulty = u1.GetDifficulty(p8, p9);

    if not Difficulty then
        return nil;
    end;

    local v11 = 1 + u1.PARTY_HP_SCALE * (math.max(1, p10 or 1) - 1);

    return {
        Health = math.floor(Difficulty.Health * v11),
        Damage = Difficulty.Damage,
        TimeLimit = Difficulty.TimeLimit
    };
end;

function u1.BestTimeKey(p12: string) -- Line: 158
    return "Raids:" .. p12;
end;

return u1;