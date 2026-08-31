--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LevelData
  Path:     game.ReplicatedStorage.GameInfo.LevelData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    PLAYER_LEVEL_CAP = 100,
    CLASS_LEVEL_CAP = 50,
    SKILL_POINTS_PER_LEVEL = 2,
    BASE_KILL_XP = 6,
    CLASS_KILL_XP = 30,
    ELITE_KILL_XP = 45,
    ELITE_CLASS_KILL_XP = 60,
    BOSS_KILL_XP = { 60, 75, 90, 110, 135, 165 },
    CLASS_BOSS_XP = { 40, 50, 60, 73, 88, 105 },
    DIFFICULTY_XP_MULT = {
        Easy = 1,
        Normal = 1.35,
        Hard = 1.5,
        Nightmare = 1.95,
        Endless = 2.3
    },
    DUNGEON_CLEAR_XP = {
        Easy = 500,
        Normal = 3200,
        Hard = 5500,
        Nightmare = 9000,
        Endless = 8500
    },
    DUNGEON_CLEAR_TIER_MULT = { 1, 1.3, 2, 3.2, 5, 12 },
    EXTRACTION_XP = 100,
    QUEST_COMPLETE_XP = 50,
    PlayerXPCurve = {}
};
u1.PlayerXPCurve[2] = 100;
u1.PlayerXPCurve[3] = 200;
u1.PlayerXPCurve[4] = 300;
u1.PlayerXPCurve[5] = 400;
u1.PlayerXPCurve[6] = 500;
u1.PlayerXPCurve[7] = 1000;
u1.PlayerXPCurve[8] = 1500;
u1.PlayerXPCurve[9] = 2000;
u1.PlayerXPCurve[10] = 2500;

for i = 11, 50 do
    u1.PlayerXPCurve[i] = math.floor((i - 1 - 4) * 500 * ((i - 1 - 9) * 0.03 + 1));
    local _ = i;
end;

for i = 51, u1.PLAYER_LEVEL_CAP do
    u1.PlayerXPCurve[i] = math.floor((i - 1 - 4) * 500 * ((i - 1 - 9) * 0.03 + 1) * (((i - 50) / 50) ^ 1.6 * 3.5 + 1));
    local _ = i;
end;

u1.ClassXPCurve = {};

for i = 2, u1.CLASS_LEVEL_CAP do
    u1.ClassXPCurve[i] = math.floor(i ^ 1.3 * 50);
    local _ = i;
end;

function u1.GetPlayerXPForLevel(p2: number) -- Line: 204
    -- upvalues: u1 (copy)
    return u1.PLAYER_LEVEL_CAP < p2 and (1 / 0) or (u1.PlayerXPCurve[p2] or (1 / 0));
end;

function u1.GetClassXPForLevel(p3: number) -- Line: 211
    -- upvalues: u1 (copy)
    return u1.CLASS_LEVEL_CAP < p3 and (1 / 0) or (u1.ClassXPCurve[p3] or (1 / 0));
end;

function u1.GetCumulativePlayerXP(p4: number) -- Line: 218
    -- upvalues: u1 (copy)
    local v5 = 0;

    for i = 2, math.min(p4, u1.PLAYER_LEVEL_CAP) do
        v5 = v5 + (u1.PlayerXPCurve[i] or 0);
        local _ = i;
    end;

    return v5;
end;

function u1.GetCumulativeClassXP(p6: number) -- Line: 227
    -- upvalues: u1 (copy)
    local v7 = 0;

    for i = 2, math.min(p6, u1.CLASS_LEVEL_CAP) do
        v7 = v7 + (u1.ClassXPCurve[i] or 0);
        local _ = i;
    end;

    return v7;
end;

function u1.GetDungeonClearXP(p8: string, p9: number?) -- Line: 241
    -- upvalues: u1 (copy)
    return math.floor((u1.DUNGEON_CLEAR_XP[p8] or u1.DUNGEON_CLEAR_XP.Easy) * (p9 and (u1.DUNGEON_CLEAR_TIER_MULT[p9] or 1) or 1));
end;

function u1.GetLevelDiffXPMult(p10: number, p11: number) -- Line: 252
    return math.clamp((p10 - p11) * 0.06 + 1, 0.5, 1.5);
end;

return u1;