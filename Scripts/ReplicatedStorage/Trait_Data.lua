--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Trait_Data
  Path:     game.ReplicatedStorage.Weapons.Weapon_Traits.Trait_Data
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

local Knit = require(game.ReplicatedStorage.Packages.Knit);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    Index = {},
    ByTier = {},
    TierOrder = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic" },
    TierWeights = {
        Common = 0.3333333333333333,
        Uncommon = 0.2,
        Rare = 0.08333333333333333,
        Epic = 0.025,
        Legendary = 0.005555555555555556,
        Mythic = 0.0011111111111111111
    },
    MAX_TRAITS = 1
};
local u2 = {
    Stackable = false,
    Conflicts = {}
};

local function makeTrait(p3) -- Line: 81
    -- upvalues: u2 (copy), u1 (copy)
    for i, v in u2 do
        if p3[i] == nil then
            if type(v) == "table" then
                p3[i] = table.clone(v);
            else
                p3[i] = v;
            end;
        end;
    end;

    assert(p3.Name, "Trait must have a Name");
    assert(p3.Tier, "Trait must have a Tier: " .. p3.Name);
    u1.Index[p3.Name] = p3;

    if not u1.ByTier[p3.Tier] then
        u1.ByTier[p3.Tier] = {};
    end;

    table.insert(u1.ByTier[p3.Tier], p3.Name);

    return p3;
end;

makeTrait({
    Name = "Sharp I",
    Tier = "Common",
    Description = "+5% damage.",
    StatModifiers = {
        Damage = 1.05
    }
});
makeTrait({
    Name = "Lightweight I",
    Tier = "Common",
    Description = "-5% dodge cooldown.",
    StatModifiers = {
        DodgeCooldown = 0.95
    }
});
makeTrait({
    Name = "Quick I",
    Tier = "Common",
    Description = "+5% attack speed.",
    StatModifiers = {
        AttackSpeed = {
            Flat = 0.05
        }
    }
});
makeTrait({
    Name = "Balanced I",
    Tier = "Common",
    Description = "+3% attack speed, +5% damage.",
    StatModifiers = {
        Damage = 1.05,
        AttackSpeed = {
            Flat = 0.03
        }
    }
});
makeTrait({
    Name = "Sharp II",
    Tier = "Uncommon",
    Description = "+8% damage.",
    StatModifiers = {
        Damage = 1.08
    }
});
makeTrait({
    Name = "Lightweight II",
    Tier = "Uncommon",
    Description = "-8% dodge cooldown.",
    StatModifiers = {
        DodgeCooldown = 0.92
    }
});
makeTrait({
    Name = "Critical I",
    Tier = "Uncommon",
    Description = "+5% critical hit chance.",

    OnApply = function(p4, p5) -- Line: 159, Name: OnApply
        p4.CritChance = (p4.CritChance or 0) + 0.05;
    end
});
makeTrait({
    Name = "Quick II",
    Tier = "Uncommon",
    Description = "+8% attack speed.",
    StatModifiers = {
        AttackSpeed = {
            Flat = 0.08
        }
    }
});
makeTrait({
    Name = "Balanced II",
    Tier = "Uncommon",
    Description = "+6% attack speed, +8% damage.",
    StatModifiers = {
        Damage = 1.08,
        AttackSpeed = {
            Flat = 0.06
        }
    }
});
makeTrait({
    Name = "Lifesteal I",
    Tier = "Rare",
    Description = "Recover 3 HP per hit.",
    Hooks = {
        OnHit = function(p6, p7, p8) -- Line: 187, Name: OnHit
            local v9 = p6.Character and p6.Character:FindFirstChild("Humanoid");

            if v9 and v9.Health > 0 then
                v9.Health = math.min(v9.MaxHealth, v9.Health + 3);
            end;
        end
    }
});
makeTrait({
    Name = "Critical II",
    Tier = "Rare",
    Description = "+8% critical hit chance.",

    OnApply = function(p10, p11) -- Line: 200, Name: OnApply
        p10.CritChance = (p10.CritChance or 0) + 0.08;
    end
});
makeTrait({
    Name = "Parry I",
    Tier = "Rare",
    Description = "Parry window lasts 10% longer.",
    StatModifiers = {
        ParryWindowMult = {
            Flat = 0.1
        }
    }
});
makeTrait({
    Name = "Venomous",
    Tier = "Rare",
    Description = "Hits apply poison dealing 15% damage per second for 5 seconds.",
    EffectModule = "Venomous"
});
makeTrait({
    Name = "Lifesteal II",
    Tier = "Rare",
    Description = "Recover 5 HP per hit.",
    Hooks = {
        OnHit = function(p12, p13, p14) -- Line: 229, Name: OnHit
            local v15 = p12.Character and p12.Character:FindFirstChild("Humanoid");

            if v15 and v15.Health > 0 then
                v15.Health = math.min(v15.MaxHealth, v15.Health + 5);
            end;
        end
    }
});
makeTrait({
    Name = "Sharp III",
    Tier = "Epic",
    Description = "+14% damage.",
    StatModifiers = {
        Damage = 1.14
    }
});
makeTrait({
    Name = "Lightweight III",
    Tier = "Epic",
    Description = "-14% dodge cooldown.",
    StatModifiers = {
        DodgeCooldown = 0.86
    }
});
makeTrait({
    Name = "Critical III",
    Tier = "Epic",
    Description = "+14% critical hit chance.",

    OnApply = function(p16, p17) -- Line: 256, Name: OnApply
        p16.CritChance = (p16.CritChance or 0) + 0.14;
    end
});
makeTrait({
    Name = "Quick III",
    Tier = "Epic",
    Description = "+14% attack speed.",
    StatModifiers = {
        AttackSpeed = {
            Flat = 0.14
        }
    }
});
makeTrait({
    Name = "Powerful",
    Tier = "Epic",
    Description = "+20% damage, -20% attack speed.",
    StatModifiers = {
        Damage = 1.2
    },
    Penalties = {
        AttackSpeed = {
            Flat = -0.2
        }
    }
});
makeTrait({
    Name = "Berserker",
    Tier = "Epic",
    Description = "Deal up to +25% more damage the lower your HP.",
    Hooks = {
        OnHit = function(p18, p19, p20) -- Line: 281, Name: OnHit
            local v21 = p18.Character and p18.Character:FindFirstChild("Humanoid");

            if not v21 then
                return;
            end;

            p18._TraitDamageMult = (p18._TraitDamageMult or 1) + (1 - v21.Health / v21.MaxHealth) * 0.25;
        end
    }
});
makeTrait({
    Name = "Swift Cast",
    Tier = "Epic",
    Description = "Skill cooldown reduced by 25%.",

    OnApply = function(p22, p23) -- Line: 295, Name: OnApply
        p22.SkillCooldown = (p22.SkillCooldown or 5) * 0.75;
    end
});
makeTrait({
    Name = "Relentless",
    Tier = "Legendary",
    Description = "Kills reset your dodge cooldown instantly.",
    Hooks = {
        OnKill = function(p24, p25) -- Line: 310, Name: OnKill
            p24.Last_Dodge_Time = 0;

            if p24.Player then
                p24.Player:SetAttribute("Dodge_Cooldown_Active", false);
            end;
        end
    }
});
makeTrait({
    Name = "Vampiric",
    Tier = "Legendary",
    Description = "Lifesteal 5% of damage dealt as HP.",
    Hooks = {
        OnHit = function(p26, p27, p28) -- Line: 324, Name: OnHit
            if not p28 then
                return;
            end;

            local v29 = p26.Character and p26.Character:FindFirstChild("Humanoid");

            if v29 and v29.Health > 0 then
                local math_floor_ret = math.floor(p28 * 0.05);

                if math_floor_ret > 0 then
                    v29.Health = math.min(v29.MaxHealth, v29.Health + math_floor_ret);
                end;
            end;
        end
    },
    Conflicts = { "Lifesteal I" }
});
makeTrait({
    Name = "Extreme Haste",
    Tier = "Legendary",
    Description = "Kills shave 2 seconds off your skill cooldown.",
    Hooks = {
        OnKill = function(p30, p31) -- Line: 343, Name: OnKill
            -- upvalues: Knit (copy)
            local Skill = p30.Wep_Data.Skill;

            if not Skill then
                return;
            end;

            local v32 = p30.Skill_Cooldowns[Skill];

            if not v32 then
                return;
            end;

            local v33 = v32 - 2;
            p30.Skill_Cooldowns[Skill] = v33;

            if p30.Player then
                p30.Player:SetAttribute("Skill_CooldownEnd", v33);

                if v33 <= os.clock() then
                    p30.Player:SetAttribute("Skill_OnCooldown", false);
                    Knit.GetService("NotificationService"):SendMessageToPlr(p30.Player, "SKILL_READY", Skill);
                end;
            end;
        end
    }
});
makeTrait({
    Name = "Executioner",
    Tier = "Legendary",
    Description = "Deal 50% bonus damage to targets below 25% HP.",
    EffectModule = "Executioner"
});
makeTrait({
    Name = "Soul Chain",
    Tier = "Legendary",
    Description = "Hits chain to one nearby enemy for 40% damage.",
    EffectModule = "Soul_Chain"
});
makeTrait({
    Name = "Crit Surge",
    Tier = "Legendary",
    Description = "Every 5th critical hit heals you for 50 HP.",
    EffectModule = "Crit_Surge"
});
makeTrait({
    Name = "Momentum",
    Tier = "Legendary",
    Description = "Each consecutive hit increases damage by 4%. Resets on miss or dodge.",
    EffectModule = "Momentum"
});
makeTrait({
    Name = "Thunderstrike",
    Tier = "Legendary",
    Description = "Every 10th hit deals double damage with a lightning effect.",
    EffectModule = "Thunderstrike"
});
makeTrait({
    Name = "Infinity Edge",
    Tier = "Legendary",
    Description = "+15% crit chance, +25% crit damage.",

    OnApply = function(p34, p35) -- Line: 405, Name: OnApply
        p34.CritChance = (p34.CritChance or 0) + 0.15;
        p34.CritMultiplier = (p34.CritMultiplier or 1.5) + 0.25;
    end
});
makeTrait({
    Name = "Sharp IV",
    Tier = "Legendary",
    Description = "+20% damage.",
    StatModifiers = {
        Damage = 1.2
    }
});
makeTrait({
    Name = "Lightweight IV",
    Tier = "Legendary",
    Description = "-20% dodge cooldown.",
    StatModifiers = {
        DodgeCooldown = 0.8
    }
});
makeTrait({
    Name = "Critical IV",
    Tier = "Legendary",
    Description = "+20% critical hit chance.",

    OnApply = function(p36, p37) -- Line: 429, Name: OnApply
        p36.CritChance = (p36.CritChance or 0) + 0.2;
    end
});
makeTrait({
    Name = "Quick IV",
    Tier = "Legendary",
    Description = "+20% attack speed.",
    StatModifiers = {
        AttackSpeed = {
            Flat = 0.2
        }
    }
});
makeTrait({
    Name = "Death\'s Dance",
    Tier = "Mythic",
    Description = "+30% Attack Speed, +3% Lifesteal, -50% Skill Cooldown",
    Hooks = {
        OnHit = function(p38, p39, p40) -- Line: 450, Name: OnHit
            if not p40 then
                return;
            end;

            local v41 = p38.Character and p38.Character:FindFirstChild("Humanoid");

            if v41 and v41.Health > 0 then
                local math_floor_ret = math.floor(p40 * 0.03);

                if math_floor_ret > 0 then
                    v41.Health = math.min(v41.MaxHealth, v41.Health + math_floor_ret);
                end;
            end;
        end
    },

    OnApply = function(p42, p43) -- Line: 461, Name: OnApply
        p42.CritChance = (p42.CritChance or 0) + 0.3;
        p42.SkillCooldown = (p42.SkillCooldown or 5) * 0.5;
    end,

    StatModifiers = {
        AttackSpeed = {
            Flat = 0.3
        }
    }
});
makeTrait({
    Name = "Worldbreaker",
    Tier = "Mythic",
    Description = "+30% critical hit chance, +25% Damage, +15% Attack Speed",

    OnApply = function(p44, p45) -- Line: 474, Name: OnApply
        p44.CritChance = (p44.CritChance or 0) + 0.3;
    end,

    StatModifiers = {
        Damage = 1.3,
        AttackSpeed = {
            Flat = 0.15
        }
    }
});

function u1.ApplyStatModifiers(p46, p47) -- Line: 484
    if not p47 then
        return;
    end;

    for i, v in p47 do
        local v48 = p46[i];

        if v48 == nil then
            if type(v) == "table" then
                if v.Set == nil then
                    if v.Flat ~= nil then
                        p46[i] = v.Flat;
                    end;
                else
                    p46[i] = v.Set;
                end;
            end;
        elseif type(v) == "number" then
            if type(v48) == "number" then
                p46[i] = v48 * v;
            elseif typeof(v48) == "Vector3" then
                p46[i] = v48 * v;
            end;
        elseif type(v) == "table" then
            if v.Set == nil then
                if v.Flat ~= nil then
                    if type(v48) == "number" then
                        p46[i] = v48 + v.Flat;
                    elseif typeof(v48) == "Vector3" and typeof(v.Flat) == "Vector3" then
                        p46[i] = v48 + v.Flat;
                    end;
                end;
            else
                p46[i] = v.Set;
            end;
        end;
    end;
end;

local u49 = ReplicatedStorage:FindFirstChild("Weapons") and ReplicatedStorage.Weapons:FindFirstChild("Weapon_Traits") and ReplicatedStorage.Weapons.Weapon_Traits:FindFirstChild("Trait_Effects");

function u1.ApplyTraits(p50: any, p51: table) -- Line: 528
    -- upvalues: u1 (copy), u49 (copy)
    local v52 = {
        ActiveTraits = {},
        Hooks = {
            OnHit = {},
            OnSwing = {},
            OnSwingEnd = {},
            OnDodge = {},
            OnParry = {},
            OnKill = {},
            OnTakeDamage = {}
        },
        EffectStates = {}
    };

    for _, v in p51 do
        local v53 = u1.Index[v];

        if v53 then
            table.insert(v52.ActiveTraits, v53);
            u1.ApplyStatModifiers(p50, v53.StatModifiers);
            u1.ApplyStatModifiers(p50, v53.Penalties);

            if v53.OnApply then
                v53.OnApply(p50, v52);
            end;

            local v54;

            if v53.Hooks then
                v54 = v;

                for i, v2 in v53.Hooks do
                    if v52.Hooks[i] then
                        table.insert(v52.Hooks[i], v2);
                    end;
                end;
            else
                v54 = v;
            end;

            if v53.EffectModule and u49 then
                local v55 = u49:FindFirstChild(v53.EffectModule);

                if v55 then
                    local v56 = require(v55);
                    local u57 = v56.Init and (v56.Init() or {}) or {};
                    v52.EffectStates[v54] = u57;

                    if v56.Hooks then
                        for i, v2 in v56.Hooks do
                            if v52.Hooks[i] then
                                table.insert(v52.Hooks[i], function(p58, ...) -- Line: 581
                                    -- upvalues: v2 (copy), u57 (copy)
                                    return v2(u57, p58, ...);
                                end);
                            end;
                        end;
                    end;
                else
                    warn("[Weapon_Traits] EffectModule not found: " .. v53.EffectModule);
                end;
            end;
        else
            warn("[Weapon_Traits] Unknown trait: " .. tostring(v));
        end;
    end;

    return v52;
end;

function u1.FireHook(p59: any, p60: string, ...) -- Line: 600
    if not (p59 and p59.Hooks[p60]) then
        return;
    end;

    for _, v in p59.Hooks[p60] do
        local success, result = pcall(v, ...);

        if not success then
            warn("[Weapon_Traits] Hook error in " .. p60 .. ": " .. tostring(result));
        end;
    end;
end;

function u1.RollTraits(p61: number?, p62: number?, p63: string?) -- Line: 614
    -- upvalues: u1 (copy)
    local v64 = p62 or 0;
    local v65 = {};
    local v66 = {};

    for i = 1, p61 or u1.MAX_TRAITS do
        local v67 = u1._RollTier(v64);

        if p63 then
            if (table.find(u1.TierOrder, p63) or 1) > (table.find(u1.TierOrder, v67) or 1) then
                v67 = p63;
            end;
        end;

        local v68 = u1.ByTier[v67];
        local _ = i;
        local v69 = {};

        for _, v in (not v68 or #v68 == 0) and (u1.ByTier.Common or {}) or v68 do
            if not v65[v] or u1.Index[v].Stackable then
                local v70 = false;
                local v71 = u1.Index[v];
                local v72;

                if v71.Conflicts then
                    v72 = v;

                    for _, v2 in v71.Conflicts do
                        if v65[v2] then
                            v70 = true;
                            break;
                        end;
                    end;
                else
                    v72 = v;
                end;

                for _, v2 in v66 do
                    local v73 = u1.Index[v2];

                    if v73.Conflicts and table.find(v73.Conflicts, v72) then
                        v70 = true;
                        break;
                    end;
                end;

                if not v70 then
                    table.insert(v69, v72);
                end;
            end;
        end;

        if #v69 > 0 then
            local v74 = v69[math.random(1, #v69)];
            table.insert(v66, v74);
            v65[v74] = true;
        end;
    end;

    return v66;
end;

function u1._RollTier(p75: number) -- Line: 678
    -- upvalues: u1 (copy)
    local v76 = {};
    local v77 = 0;

    for _, v in u1.TierOrder do
        local v78 = (u1.TierWeights[v] or 0) * (1 + p75 * 0.08 * (table.find(u1.TierOrder, v) or 1));
        table.insert(v76, {
            Tier = v,
            Weight = v78
        });
        v77 = v77 + v78;
    end;

    local v79 = math.random() * v77;
    local v80 = 0;

    for _, v in v76 do
        v80 = v80 + v.Weight;

        if v79 <= v80 then
            return v.Tier;
        end;
    end;

    return "Common";
end;

function u1.HasConflicts(p81: table) -- Line: 706
    -- upvalues: u1 (copy)
    local v82 = {};

    for _, v in p81 do
        local v83 = u1.Index[v];

        if v83 then
            local v84;

            if v83.Conflicts then
                v84 = v;

                for _, v2 in v83.Conflicts do
                    if v82[v2] then
                        return true;
                    end;
                end;
            else
                v84 = v;
            end;

            for i in v82 do
                local v85 = u1.Index[i];

                if v85.Conflicts and table.find(v85.Conflicts, v84) then
                    return true;
                end;
            end;

            v82[v84] = true;
        end;
    end;

    return false;
end;

function u1.GetTraitSummary(p86: table) -- Line: 730
    -- upvalues: u1 (copy)
    local v87 = {};

    for _, v in p86 do
        local v88 = u1.Index[v];

        if v88 then
            table.insert(v87, string.format("[%s] %s — %s", v88.Tier, v88.Name, v88.Description));
        end;
    end;

    return v87;
end;

return u1;