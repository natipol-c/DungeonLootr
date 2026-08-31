--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PrestigeData
  Path:     game.ReplicatedStorage.GameInfo.PrestigeData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    REQUIRED_CLASS_LEVEL = 50,
    TOKENS_PER_PRESTIGE = 5,
    MAX_UPGRADES_PER_SKILL = 5,
    MAX_COMBINED_UPGRADES = 10,
    XP_REQUIRED_MULT_PER_PRESTIGE = 0.35,
    NPC_COIN_COST = 100000,
    DAMAGE_PER_UPGRADE = {
        Rare = 0.4,
        Epic = 0.35,
        Legendary = 0.28,
        Mythic = 0.22,
        Celestial = 0.22,
        Exotic = 0.22
    },
    UPGRADE_COSTS = { 15000, 30000, 60000, 120000, 250000 }
};

function u1.GetDamagePerUpgrade(p2: string?) -- Line: 90
    -- upvalues: u1 (copy)
    if p2 then
        return u1.DAMAGE_PER_UPGRADE[p2] or u1.DAMAGE_PER_UPGRADE.Mythic;
    end;

    return u1.DAMAGE_PER_UPGRADE.Mythic;
end;

function u1.GetSkillDamageBonus(p3: string?, p4: number?) -- Line: 97
    -- upvalues: u1 (copy)
    return u1.GetDamagePerUpgrade(p3) * (p4 or 0);
end;

function u1.GetUpgradeCost(p5: number) -- Line: 103
    -- upvalues: u1 (copy)
    local v6 = (p5 or 0) + 1;

    return u1.MAX_UPGRADES_PER_SKILL < v6 and (1 / 0) or (u1.UPGRADE_COSTS[v6] or (1 / 0));
end;

function u1.GetXPRequiredMultiplier(p7: number?) -- Line: 111
    -- upvalues: u1 (copy)
    return 1 + (p7 or 0) * u1.XP_REQUIRED_MULT_PER_PRESTIGE;
end;

function u1.CountTotalUpgrades(p8: table?) -- Line: 118
    if not p8 then
        return 0;
    end;

    local v9 = 0;

    for _, v in p8 do
        if type(v) == "number" then
            v9 = v9 + v;
        end;
    end;

    return v9;
end;

function u1.NewSkillUpgrades() -- Line: 133
    return {
        Skill1 = 0,
        Skill2 = 0,
        Skill3 = 0,
        Skill4 = 0,
        Mastery = 0
    };
end;

function u1.NewPrestigeEntry() -- Line: 144
    -- upvalues: u1 (copy)
    return {
        Prestiges = 0,
        Tokens = 0,
        SkillUpgrades = u1.NewSkillUpgrades()
    };
end;

u1.VALID_UPGRADE_KEYS = {
    Skill1 = true,
    Skill2 = true,
    Skill3 = true,
    Skill4 = true,
    Mastery = true
};

function u1.SlotToDataKey(p10) -- Line: 167
    -- upvalues: u1 (copy)
    if p10 == "Mastery" then
        return "Mastery";
    end;

    if type(p10) == "number" then
        if p10 >= 1 and (p10 <= 4 and p10 == math.floor(p10)) then
            return "Skill" .. tostring(p10);
        end;

        return nil;
    end;

    if type(p10) == "string" then
        if u1.VALID_UPGRADE_KEYS[p10] then
            return p10;
        end;

        local v11 = tonumber(p10);

        if v11 and (v11 >= 1 and (v11 <= 4 and v11 == math.floor(v11))) then
            return "Skill" .. tostring(v11);
        end;
    end;

    return nil;
end;

function u1.GetUpgradeLevel(p12: table?, p13: any) -- Line: 189
    -- upvalues: u1 (copy)
    if not p12 then
        return 0;
    end;

    local v14 = u1.SlotToDataKey(p13);

    if v14 then
        local v15 = p12[v14];

        if type(v15) == "number" then
            return v15;
        end;
    end;

    if type(p13) == "number" then
        local v16 = p12[p13];

        if type(v16) == "number" then
            return v16;
        end;
    end;

    return 0;
end;

function u1.NormalizeUpgradeKey(p17) -- Line: 206
    -- upvalues: u1 (copy)
    return u1.SlotToDataKey(p17);
end;

return u1;