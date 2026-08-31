--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     MutationData
  Path:     game.ReplicatedStorage.GameInfo.MutationData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Mutations = {
        Shiny = {
            Chance = 0.01,
            Benefit_Multiplier = 1.3,
            Cost_Multiplier = 2.5
        },
        Fairy = {
            Chance = 0.0033333333333333335,
            Benefit_Multiplier = 1.75,
            Cost_Multiplier = 2.5
        },
        Dusk = {
            Chance = 0.0014285714285714286,
            Benefit_Multiplier = 1.8,
            Cost_Multiplier = 2.8
        },
        Money = {
            Chance = 0.001,
            Benefit_Multiplier = 1.99,
            Cost_Multiplier = 3
        },
        Flaming = {
            Chance = 0.0005,
            Benefit_Multiplier = 2.5,
            Cost_Multiplier = 3.2
        },
        Surging = {
            Chance = 0.0004,
            Benefit_Multiplier = 3.5,
            Cost_Multiplier = 3.2
        },
        Magical = {
            Chance = 0.0003333333333333333,
            Benefit_Multiplier = 4,
            Cost_Multiplier = 3.5
        },
        Frosted = {
            Chance = 0.0002,
            Benefit_Multiplier = 5,
            Cost_Multiplier = 5
        },
        Shadow = {
            Chance = 0.000125,
            Benefit_Multiplier = 5,
            Cost_Multiplier = 5
        },
        Demonic = {
            Chance = 0.0001,
            Benefit_Multiplier = 7,
            Cost_Multiplier = 7
        },
        Plasma = {
            Chance = 0.00006666666666666667,
            Benefit_Multiplier = 12,
            Cost_Multiplier = 7
        },
        Absolute = {
            Chance = 0.00004,
            Benefit_Multiplier = 20,
            Cost_Multiplier = 7
        },
        Divinity = {
            Chance = 0.000025,
            Benefit_Multiplier = 50,
            Cost_Multiplier = 7
        }
    },
    ActiveBuffs = {}
};

local function GetEffectiveChance(p2: string, p3: number) -- Line: 102
    -- upvalues: u1 (copy)
    local v4 = u1.ActiveBuffs[p2];

    if not v4 then
        return p3;
    end;

    if os.clock() < v4.ExpiresAt then
        return math.min(p3 * (1 + v4.BoostPercent / 100), 1);
    end;

    u1.ActiveBuffs[p2] = nil;

    return p3;
end;

function u1.RollMutation() -- Line: 119
    -- upvalues: u1 (copy)
    for i, v in pairs(u1.Mutations) do
        local Chance = v.Chance;
        local v5 = u1.ActiveBuffs[i];

        if v5 then
            if os.clock() >= v5.ExpiresAt then
                u1.ActiveBuffs[i] = nil;
            else
                Chance = math.min(Chance * (1 + v5.BoostPercent / 100), 1);
            end;
        end;

        if math.random() < Chance then
            return i;
        end;
    end;

    return nil;
end;

function u1.GetMultipliers(p6: string?) -- Line: 129
    -- upvalues: u1 (copy)
    if not p6 then
        return 1, 1;
    end;

    local v7 = u1.Mutations[p6];

    if v7 then
        return v7.Benefit_Multiplier or 1, v7.Cost_Multiplier or 1;
    end;

    return 1, 1;
end;

function u1.GetMutationNames() -- Line: 141
    -- upvalues: u1 (copy)
    local v8 = {};

    for i in pairs(u1.Mutations) do
        table.insert(v8, i);
    end;

    table.sort(v8);

    return v8;
end;

u1.ClassWeaponAspects = {
    Blaze = {
        DisplayName = "Blaze",
        Chance = 0.025,
        Description = "Basic attacks apply a Fire DoT, dealing damage over time.",
        Trigger = "OnBasicHit",
        Color = Color3.fromRGB(255, 110, 40),
        Effect = {
            Type = "DoT",
            DamagePercent = 25,
            Duration = 4,
            Ticks = 4
        }
    },
    Fulmin = {
        DisplayName = "Fulmin",
        Chance = 0.025,
        Description = "Basic attacks have a chance to chain lightning to nearby enemies.",
        Trigger = "OnBasicHit",
        Color = Color3.fromRGB(120, 200, 255),
        Effect = {
            Type = "Chain",
            ProcChance = 0.25,
            ChainCount = 3,
            ChainRange = 18,
            Falloff = 0.6
        }
    },
    Glaciel = {
        DisplayName = "Glaciel",
        Chance = 0.025,
        Description = "Basic attacks have a chance to frost enemies, slowing them and amplifying the damage they take.",
        Trigger = "OnBasicHit",
        Color = Color3.fromRGB(150, 230, 255),
        Effect = {
            Type = "Frost",
            ProcChance = 0.2,
            SlowPercent = 30,
            DamageAmpPercent = 15,
            Duration = 3
        }
    },
    Verdant = {
        DisplayName = "Verdant",
        Chance = 0.025,
        Description = "Basic attacks apply a stacking poison, dealing ramping damage over time.",
        Trigger = "OnBasicHit",
        Color = Color3.fromRGB(120, 210, 70),
        Effect = {
            Type = "DoT",
            ProcChance = 0.15,
            DamagePercent = 15,
            Duration = 5,
            Ticks = 5,
            MaxStacks = 5
        }
    },
    Sanguine = {
        DisplayName = "Sanguine",
        Chance = 0.025,
        Description = "Attacks have a chance to trigger a short Lifesteal window, healing you for a portion of the damage dealt.",
        Trigger = "OnHit",
        Color = Color3.fromRGB(200, 40, 60),
        Effect = {
            Type = "Lifesteal",
            ProcChance = 0.1,
            HealPercent = 10,
            HealCapPercent = 5,
            WindowDuration = 3,
            Cooldown = 15
        }
    },
    Umbral = {
        DisplayName = "Umbral",
        Chance = 0.025,
        Description = "Critical hits can detonate a shadow burst, dealing bonus damage to nearby enemies and briefly stunning them.",
        Trigger = "OnCrit",
        Color = Color3.fromRGB(150, 60, 200),
        Effect = {
            Type = "Burst",
            ProcChance = 0.35,
            DamagePercent = 150,
            Radius = 15,
            Stun = 1.5,
            Cooldown = 3
        }
    },
    Aegis = {
        DisplayName = "Aegis",
        Chance = 0.025,
        Description = "A successful parry releases a radiant nova, damaging and stunning nearby foes and empowering your damage.",
        Trigger = "OnParry",
        Color = Color3.fromRGB(255, 215, 90),
        Effect = {
            Type = "Nova",
            DamagePercent = 250,
            Radius = 18,
            Stun = 3,
            BuffPercent = 25,
            BuffDuration = 5
        }
    },
    Tempest = {
        DisplayName = "Tempest",
        Tier = "Apex",
        Chance = 0.01,
        Description = "Every skill cast builds a Storm stack (+5% skill damage each, up to +40%). At max stacks your next skill unleashes a lightning storm for 200% damage and resets the charge.",
        Trigger = "OnSkillUse",
        Color = Color3.fromRGB(120, 100, 245),
        Effect = {
            Type = "Storm",
            PerStackPercent = 5,
            MaxStacks = 8,
            PayoffPercent = 200,
            PayoffRadius = 22
        }
    },
    Phantom = {
        DisplayName = "Phantom",
        Tier = "Apex",
        Chance = 0.01,
        Description = "Dodging leaves a shadow clone that detonates for damage. If the clone lands a kill, you gain +25% overall damage for 5s (refreshes, doesn\'t stack).",
        Trigger = "OnDodge",
        Color = Color3.fromRGB(120, 235, 220),
        Effect = {
            Type = "AfterImage",
            DamagePercent = 150,
            Radius = 12,
            BuffPercent = 25,
            BuffDuration = 5
        }
    },
    Ruin = {
        DisplayName = "Ruin",
        Tier = "Apex",
        Chance = 0.01,
        Description = "Basic attacks stack Sunder on a single enemy, ramping the damage it takes (up to +75%). All your hits, skills included, benefit, but only basic attacks build it, and striking a new enemy resets the mark. A true boss-killer.",
        Trigger = "OnBasicHit",
        Color = Color3.fromRGB(180, 75, 45),
        Effect = {
            Type = "Sunder",
            PerStackPercent = 2.5,
            MaxStacks = 30,
            MaxAmpPercent = 75
        }
    },
    Alacrity = {
        DisplayName = "Alacrity",
        Tier = "Apex",
        Chance = 0.01,
        Description = "Basic attacks have a 20% chance to enter a 10s haste window: +60% attack speed. 7s cooldown, beginning after the buff ends.",
        Trigger = "OnBasicHit",
        Color = Color3.fromRGB(130, 215, 250),
        Effect = {
            Type = "Haste",
            ProcChance = 0.2,
            AttackSpeedPercent = 60,
            Duration = 10,
            Cooldown = 7
        }
    }
};
local u9 = {};

for i in pairs(u1.ClassWeaponAspects) do
    table.insert(u9, i);
end;

table.sort(u9, function(p10, p11) -- Line: 308
    -- upvalues: u1 (copy)
    return u1.ClassWeaponAspects[p10].Chance < u1.ClassWeaponAspects[p11].Chance;
end);
u1.HUNTER_BONUS_CHANCE = 0.0215;

function u1.RollClassWeaponAspect(p12: number?) -- Line: 331
    -- upvalues: u9 (copy), u1 (copy)
    local v13 = 1;

    if p12 and p12 > 0 then
        local v14 = 0;

        for _, v in u9 do
            v14 = v14 + u1.ClassWeaponAspects[v].Chance;
        end;

        if v14 > 0 then
            v13 = (v14 + p12) / v14;
        end;
    end;

    local math_random_ret = math.random();
    local v15 = 0;

    for _, v in u9 do
        v15 = v15 + u1.ClassWeaponAspects[v].Chance * v13;

        if math_random_ret < v15 then
            return v;
        end;
    end;

    return nil;
end;

function u1.RollGuaranteedClassWeaponAspect() -- Line: 363
    -- upvalues: u9 (copy), u1 (copy)
    local v16 = 0;

    for _, v in u9 do
        v16 = v16 + u1.ClassWeaponAspects[v].Chance;
    end;

    if v16 <= 0 then
        return u9[1];
    end;

    local v17 = math.random() * v16;
    local v18 = 0;

    for _, v in u9 do
        v18 = v18 + u1.ClassWeaponAspects[v].Chance;

        if v17 <= v18 then
            return v;
        end;
    end;

    return u9[#u9];
end;

function u1.GetClassWeaponAspect(p19: string?) -- Line: 384
    -- upvalues: u1 (copy)
    if p19 then
        return u1.ClassWeaponAspects[p19];
    end;

    return nil;
end;

function u1.GetClassWeaponAspectNames() -- Line: 390
    -- upvalues: u1 (copy)
    local v20 = {};

    for i in pairs(u1.ClassWeaponAspects) do
        table.insert(v20, i);
    end;

    table.sort(v20);

    return v20;
end;

return u1;