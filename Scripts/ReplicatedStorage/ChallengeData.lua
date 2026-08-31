--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ChallengeData
  Path:     game.ReplicatedStorage.GameInfo.ChallengeData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    ARENA_ROOT = "Challenge_Dungeons",
    MAP_LOAD_TIME = 10,
    LOADING_TIME = 15,
    START_TIME = 60,
    TIME_PER_KILL = 1.5,
    TIME_PER_BOSS_KILL = 5,
    TIME_CAP = 120,
    BOSS_WAVE_INTERVAL = 10,
    TIMER_RESET_INTERVAL = 10,
    CHEST_WAVE_INTERVAL = 5,
    CHEST_COUNT = 3,
    BLESSING_WAVE_INTERVAL = 10,
    BLESSING_GRACE = 5,
    CHEST_LIFETIME = 60,
    WAVE_BASE_SIZE = 8,
    WAVE_SIZE_DIVISOR = 2,
    MAX_ALIVE = 16,
    SCALING_STEP = 5,
    SCALING_MULT = 1.1,
    PARTY_HP_SCALE = 0.35,
    STARTING_LIVES = 3,
    PARTY_CAP = 4,
    UNLOCK_LEVEL = 55,
    FEATURED_DUNGEON = "Double Dungeon",
    BOSS_PREVIEW_ORDER = { {
            HeroId = "Scarlet Knight",
            Name = "Scarlet Knight, The Crimson Revenant"
        }, {
            HeroId = "Imperator",
            Name = "Imperator, The Sovereign of Ruin"
        }, {
            HeroId = "Shadow Knight",
            Name = "Shadow Knight"
        }, {
            HeroId = "Unrestricted EX",
            Name = "Unrestricted EX"
        }, {
            HeroId = "Awakened Devil",
            Name = "Awakened Devil"
        }, {
            HeroId = "Frigid Monarch",
            Name = "Frigid Monarch"
        } },
    SHOWCASE_REWARDS = {
        Items = { {
                Type = "Consumable",
                Id = "BossRushSkipTicket"
            }, {
                Type = "ProtectionScroll"
            }, {
                Type = "QuestItem",
                Id = "Devil Heart"
            }, {
                Type = "Material",
                Id = "Exotic Essence"
            }, {
                Type = "Material",
                Id = "Exotic Ore"
            } }
    },
    NO_REPEAT_TOP_RARITY = true
};

function u1.GetWaveMult(p2: number) -- Line: 131
    -- upvalues: u1 (copy)
    local v3 = (math.max(p2, 1) - 1) / u1.SCALING_STEP;
    local math_floor_ret = math.floor(v3);

    return u1.SCALING_MULT ^ math_floor_ret;
end;

function u1.GetWaveSize(p4: number) -- Line: 137
    -- upvalues: u1 (copy)
    local WAVE_BASE_SIZE = u1.WAVE_BASE_SIZE;
    local v5 = math.max(p4, 1) / u1.WAVE_SIZE_DIVISOR;
    local v6 = WAVE_BASE_SIZE + math.floor(v5);

    return math.min(v6, u1.MAX_ALIVE);
end;

function u1.IsBossWave(p7: number) -- Line: 142
    -- upvalues: u1 (copy)
    return p7 % u1.BOSS_WAVE_INTERVAL == 0;
end;

function u1.IsTimerResetWave(p8: number) -- Line: 146
    -- upvalues: u1 (copy)
    return p8 % u1.TIMER_RESET_INTERVAL == 0;
end;

function u1.IsChestWave(p9: number) -- Line: 150
    -- upvalues: u1 (copy)
    return p9 % u1.CHEST_WAVE_INTERVAL == 0;
end;

function u1.IsBlessingWave(p10: number) -- Line: 154
    -- upvalues: u1 (copy)
    return p10 % u1.BLESSING_WAVE_INTERVAL == 0;
end;

function u1.TimeForKill(p11: boolean) -- Line: 159
    -- upvalues: u1 (copy)
    return p11 and u1.TIME_PER_BOSS_KILL or u1.TIME_PER_KILL;
end;

function u1.GetPartyHealthMult(p12: number) -- Line: 164
    -- upvalues: u1 (copy)
    return 1 + u1.PARTY_HP_SCALE * math.max(0, (p12 or 1) - 1);
end;

function u1.MeetsLevel(p13: table, p14: number?) -- Line: 170
    -- upvalues: u1 (copy)
    if p13 then
        p13 = p13.Data;
    end;

    if not p13 then
        return false, "Data not loaded";
    end;

    local v15 = p14 or u1.UNLOCK_LEVEL;

    if v15 <= (p13.PlayerLevel or 0) then
        return true, nil;
    end;

    return false, "Reach Player Level " .. v15 .. " to enter this Challenge Dungeon";
end;

return u1;