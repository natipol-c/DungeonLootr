--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ModifierData
  Path:     game.ReplicatedStorage.GameInfo.ModifierData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Modifiers = {
        IncreasedEnemies = {
            DisplayName = "Increased Enemies",
            Description = "+50% enemies per wave",
            XPMult = 0,
            LuckBonus = 0,
            Conflicts = {}
        },
        TougherEnemies = {
            DisplayName = "Tougher Enemies",
            Description = "Enemies deal 2.1x damage",
            XPMult = 0.15,
            LuckBonus = 0.2,
            Conflicts = {}
        },
        MoreElites = {
            DisplayName = "More Elites",
            Description = "+8 elite spawns, slightly better rarity",
            XPMult = 0,
            LuckBonus = 0.2,
            Conflicts = { "OnlyElites" }
        },
        NoSprinting = {
            DisplayName = "No Sprinting",
            Description = "Sprinting is disabled",
            XPMult = 0.05,
            LuckBonus = 0,
            Conflicts = {}
        },
        NoDodging = {
            DisplayName = "No Dodging",
            Description = "Dodge roll is disabled",
            XPMult = 0.05,
            LuckBonus = 0,
            Conflicts = {}
        },
        NoParrying = {
            DisplayName = "No Parrying",
            Description = "Parry is disabled",
            XPMult = 0.05,
            LuckBonus = 0,
            Conflicts = {}
        },
        DoubleHealth = {
            DisplayName = "2x Enemy Health",
            Description = "Enemies have double HP",
            XPMult = 0.1,
            LuckBonus = 0,
            Conflicts = {}
        },
        OnlyElites = {
            DisplayName = "Only Elites",
            Description = "Every mob is elite",
            XPMult = 0.3,
            LuckBonus = 0.35,
            Conflicts = { "MoreElites" }
        }
    },
    DisplayOrder = { "IncreasedEnemies", "TougherEnemies", "MoreElites", "DoubleHealth", "OnlyElites", "NoSprinting", "NoDodging", "NoParrying" }
};

function u1.ValidateModifiers(p2: table) -- Line: 92
    -- upvalues: u1 (copy)
    if not p2 or #p2 == 0 then
        return {}, nil;
    end;

    local v3 = {};
    local v4 = {};

    for _, v in p2 do
        if not u1.Modifiers[v] then
            return {}, `Unknown modifier: {v}`;
        end;

        if not v3[v] then
            v3[v] = true;
            table.insert(v4, v);
        end;
    end;

    for _, v in v4 do
        local v5 = v;

        for _, v2 in u1.Modifiers[v].Conflicts do
            if v3[v2] then
                return {}, `Modifier conflict: {v5} and {v2} cannot be active together`;
            end;
        end;
    end;

    return v4, nil;
end;

function u1.ComputeBonuses(p6: table) -- Line: 130
    -- upvalues: u1 (copy)
    local v7 = 0;
    local v8 = 0;

    for _, v in p6 do
        local v9 = u1.Modifiers[v];

        if v9 then
            v7 = v7 + v9.XPMult;
            v8 = v8 + v9.LuckBonus;
        end;
    end;

    return {
        XPMult = v7 + 1,
        LuckBonus = v8
    };
end;

function u1.HasModifier(p10: table, p11: string) -- Line: 149
    if p10 then
        return table.find(p10, p11) ~= nil;
    end;

    return false;
end;

return u1;