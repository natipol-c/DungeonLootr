--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BuffData
  Path:     game.ReplicatedStorage.GameInfo.BuffData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
local u1 = {
    Buffs = {
        {
            Id = "dmg_up",
            Title = "Overwhelming Force",
            EffectType = "DamagePct",
            Sign = "positive",
            Unit = "percent",
            Min = 10,
            Max = 30,
            Step = 5,
            Desc = "+{v} Overall Damage",
            StatKey = "BonusDamage",
            Weight = 1
        },
        {
            Id = "move_up",
            Title = "Fleetfoot",
            EffectType = "MoveSpeed",
            Sign = "positive",
            Unit = "percent",
            Min = 5,
            Max = 15,
            Step = 1,
            Desc = "+{v} Movement Speed",
            StatKey = "MovementSpeed",
            Weight = 1,
            Cap = 50
        },
        {
            Id = "hp_up",
            Title = "Ironhide",
            EffectType = "MaxHP",
            Sign = "positive",
            Unit = "percent",
            Min = 10,
            Max = 25,
            Step = 5,
            Desc = "+{v} Max HP",
            StatKey = "MaxHP",
            Weight = 1
        },
        {
            Id = "kill_xp",
            Title = "Bloodlust",
            EffectType = "KillXP",
            Sign = "positive",
            Unit = "percent",
            Min = 15,
            Max = 35,
            Step = 5,
            Desc = "+{v} Enemy Kill EXP",
            Weight = 1,
            Cap = 100,
            Icon = Image_Data.BuffPotions.DoubleClassEXP
        },
        {
            Id = "clear_xp",
            Title = "Scholar\'s Insight",
            EffectType = "CompletionXP",
            Sign = "positive",
            Unit = "percent",
            Min = 25,
            Max = 50,
            Step = 5,
            Desc = "+{v} Completion EXP",
            Weight = 1,
            Cap = 100,
            Icon = Image_Data.BuffPotions.DoublePlayerEXP
        },
        {
            Id = "coins",
            Title = "Fortune",
            EffectType = "Coins",
            Sign = "positive",
            Unit = "flat",
            Min = 500,
            Max = 1500,
            Step = 100,
            Desc = "+{v} Coins",
            Weight = 1,
            Icon = Image_Data.Rewards.Cash
        },
        {
            Id = "skill_dmg",
            Title = "Arcane Might",
            EffectType = "SkillDamagePct",
            Sign = "positive",
            Unit = "percent",
            Min = 5,
            Max = 30,
            Step = 5,
            Desc = "+{v} Skill Damage",
            StatKey = "SkillDamageBonus",
            Weight = 1
        },
        {
            Id = "crit_rate",
            Title = "Deadeye",
            EffectType = "CritRatePct",
            Sign = "positive",
            Unit = "percent",
            Min = 5,
            Max = 50,
            Step = 5,
            Desc = "+{v} Crit Rate",
            StatKey = "CritRate",
            Weight = 1,
            Cap = 50
        },
        {
            Id = "skill_crit_rate",
            Title = "Focused Casting",
            EffectType = "SkillCritRatePct",
            Sign = "positive",
            Unit = "percent",
            Min = 2,
            Max = 10,
            Step = 1,
            Desc = "+{v} Skill Crit Rate",
            StatKey = "SkillCritChance",
            Weight = 1,
            Cap = 50
        },
        {
            Id = "skill_crit_dmg",
            Title = "Devastation",
            EffectType = "SkillCritDamagePct",
            Sign = "positive",
            Unit = "percent",
            Min = 10,
            Max = 50,
            Step = 5,
            Desc = "+{v} Skill Crit Damage",
            StatKey = "SkillCritDamage",
            Weight = 1
        },
        {
            Id = "dmg_reduction",
            Title = "Bulwark",
            EffectType = "DamageReductionPct",
            Sign = "positive",
            Unit = "percent",
            Min = 5,
            Max = 30,
            Step = 5,
            Desc = "+{v} Damage Reduction",
            StatKey = "DamageReduction",
            Weight = 1,
            Cap = 50
        },
        {
            Id = "parry_window",
            Title = "Steadfast",
            EffectType = "ParryWindow",
            Sign = "positive",
            Unit = "seconds",
            Min = 0.05,
            Max = 0.3,
            Step = 0.05,
            Desc = "+{v} Parry Window",
            StatKey = "ParryExtension",
            Weight = 1,
            Cap = 0.5
        },
        {
            Id = "dodge_cd",
            Title = "Nimble",
            EffectType = "DodgeCooldown",
            Sign = "positive",
            Unit = "seconds",
            Min = 0.1,
            Max = 0.3,
            Step = 0.05,
            Desc = "-{v} Dodge Cooldown",
            StatKey = "MovementSpeed",
            Weight = 1,
            Cap = 1
        },
        {
            Id = "skill_cd",
            Title = "Flowstate",
            EffectType = "SkillCooldownPct",
            Sign = "positive",
            Unit = "percent",
            Min = 5,
            Max = 30,
            Step = 5,
            Desc = "-{v} Skill Cooldown",
            StatKey = "CooldownReduction",
            Weight = 1,
            Cap = 50
        }
    }
};
local u2 = {};

for _, v in u1.Buffs do
    u2[v.Id] = v;
end;

u1.RunBuffProjection = {
    DamagePct = {
        Attr = "RunBuff_DamagePercent",
        Scale = 100
    },
    MoveSpeed = {
        Attr = "RunBuff_MoveSpeed",
        Scale = 100
    },
    MaxHP = {
        Attr = "RunBuff_MaxHPPct",
        Scale = 100
    },
    KillXP = {
        Attr = "RunBuff_KillXP",
        Scale = 100
    },
    CompletionXP = {
        Attr = "RunBuff_CompletionXP",
        Scale = 100
    },
    SkillDamagePct = {
        Attr = "RunBuff_SkillDamage",
        Scale = 1
    },
    CritRatePct = {
        Attr = "RunBuff_CritRate",
        Scale = 1
    },
    SkillCritRatePct = {
        Attr = "RunBuff_SkillCritChance",
        Scale = 1
    },
    SkillCritDamagePct = {
        Attr = "RunBuff_SkillCritDamage",
        Scale = 1
    },
    DamageReductionPct = {
        Attr = "RunBuff_DamageReduction",
        Scale = 1
    },
    ParryWindow = {
        Attr = "RunBuff_ParryWindow",
        Scale = 1
    },
    DodgeCooldown = {
        Attr = "RunBuff_DodgeCooldown",
        Scale = -1
    },
    SkillCooldownPct = {
        Attr = "RunBuff_CooldownReduction",
        Scale = 1
    }
};
local u3 = {};

for _, v in u1.Buffs do
    local v4 = u1.RunBuffProjection[v.EffectType];

    if v4 then
        u3[v4.Attr] = {
            Def = v,
            Scale = v4.Scale
        };
    end;
end;

function u1.GetById(p5: string) -- Line: 182
    -- upvalues: u2 (copy)
    return u2[p5];
end;

function u1.GetRunBuffByAttr(p6: string) -- Line: 188
    -- upvalues: u3 (copy)
    return u3[p6];
end;

function u1.RunBuffDisplayMagnitude(p7: string, p8: number) -- Line: 196
    -- upvalues: u3 (copy)
    local v9 = u3[p7];

    if v9 then
        return math.floor(p8 * v9.Scale * 1000 + 0.5) / 1000;
    end;

    return nil;
end;

function u1.RollMagnitude(p10: table) -- Line: 209
    local v11 = p10.Step or 1;

    if p10.Max <= p10.Min or v11 <= 0 then
        return p10.Min;
    end;

    local math_floor_ret = math.floor((p10.Max - p10.Min) / v11 + 0.0001);
    local math_random_ret = math.random(0, math_floor_ret);

    if math_random_ret == math_floor_ret and (math_floor_ret > 0 and math.random() < 0.5) then
        math_random_ret = math.random(0, math_floor_ret - 1);
    end;

    return math.floor((p10.Min + math_random_ret * v11) * 1000 + 0.5) / 1000;
end;

function u1.StepCount(p12: table) -- Line: 228
    local v13 = p12.Step or 1;

    return (p12.Max <= p12.Min or v13 <= 0) and 1 or math.floor((p12.Max - p12.Min) / v13 + 0.0001) + 1;
end;

function u1.ValueAtStep(p14: table, p15: number) -- Line: 236
    -- upvalues: u1 (copy)
    local v16 = p14.Step or 1;
    local v17 = u1.StepCount(p14);
    local math_clamp_ret = math.clamp(p15, 1, v17);
    local v18 = math.min(p14.Min + (math_clamp_ret - 1) * v16, p14.Max) * 1000 + 0.5;

    return math.floor(v18) / 1000;
end;

function u1.ResolveIcon(p19: table) -- Line: 244
    -- upvalues: Image_Data (copy)
    if p19.Icon then
        return p19.Icon;
    end;

    if p19.StatKey then
        return Image_Data.GetStatIcon(p19.StatKey);
    end;

    return nil;
end;

local function FormatMagnitude(p20: table, p21: number) -- Line: 253
    if p20.Unit == "percent" then
        return string.format("%d%%", p21);
    end;

    if p20.Unit == "seconds" then
        return string.format("%gs", p21);
    end;

    return string.format("%d", p21):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

function u1.FormatDescription(p22: table, p23: number) -- Line: 268
    -- upvalues: FormatMagnitude (copy)
    local string_format_ret = string.format("<font color=\"%s\">%s</font>", p22.Sign == "negative" and "rgb(255,95,95)" or "rgb(120,255,130)", FormatMagnitude(p22, p23));

    return p22.Desc:gsub("{v}", function() -- Line: 273
        -- upvalues: string_format_ret (copy)
        return string_format_ret;
    end);
end;

function u1.BuildDisplay(p24: table, p25: number) -- Line: 278
    -- upvalues: u1 (copy)
    return {
        Id = p24.Id,
        Title = p24.Title,
        Description = u1.FormatDescription(p24, p25),
        Icon = u1.ResolveIcon(p24)
    };
end;

function u1.RollCandidates(p26: number, p27: table?) -- Line: 292
    -- upvalues: u1 (copy)
    local v28 = {};

    for _, v in u1.Buffs do
        if not (p27 and p27[v.Id]) then
            table.insert(v28, v);
        end;
    end;

    local v29 = {};

    for i = 1, math.min(p26, #v28) do
        local _ = i;
        local v30 = 0;

        for _, v in v28 do
            v30 = v30 + (v.Weight or 1);
        end;

        local v31 = math.random() * v30;
        local v32 = #v28;
        local v33 = 0;

        for i2, v in v28 do
            v33 = v33 + (v.Weight or 1);

            if v31 <= v33 then
                v32 = i2;
                break;
            end;
        end;

        table.insert(v29, v28[v32]);
        table.remove(v28, v32);
    end;

    return v29;
end;

return u1;