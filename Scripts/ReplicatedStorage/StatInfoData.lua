--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     StatInfoData
  Path:     game.ReplicatedStorage.GameInfo.StatInfoData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EquipmentData = require(ReplicatedStorage.GameInfo.EquipmentData);
local CombatBaseStats = require(ReplicatedStorage.GameInfo.CombatBaseStats);
local v1 = {
    Entries = {
        {
            Key = "MaxHP",
            Computed = "MaxHP"
        },
        {
            Key = "CooldownReduction",
            Computed = "CooldownReduction",
            Cap = {
                Value = 75
            }
        },
        {
            Key = "MovementSpeed",
            Computed = "MovementSpeed"
        },
        {
            Key = "ParryExtension",
            Computed = "ParryExtension"
        },
        {
            Key = "ParryWindow",
            DisplayName = "Parry Window",
            FormatKey = "ParryExtension",
            Description = "The active window in which a parry can land.",
            Computed = "ParryExtension",
            ClassBase = {
                Field = "ParryDuration"
            }
        },
        {
            Key = "ParryCooldown",
            DisplayName = "Parry Cooldown",
            FormatKey = "ParryExtension",
            Description = "Time before you can parry again.",
            ClassBase = {
                Field = "ParryCooldown"
            }
        },
        {
            Key = "DodgeCooldown",
            DisplayName = "Dodge Cooldown",
            Description = "Time before you can dodge again.",
            Computed = "DodgeCooldown",
            ClassBase = {
                Field = "DodgeCooldown"
            },
            Cap = {
                Value = 1,
                Inverted = true
            }
        },
        {
            Key = "DodgeRate",
            Computed = "DodgeRate",
            Cap = {
                Value = 30
            }
        },
        {
            Key = "Defense",
            Computed = "Defense"
        },
        {
            Key = "DamageReduction",
            Computed = "DamageReduction"
        },
        {
            Key = "BlockMaxHealth",
            Computed = "BlockMaxHealth"
        },
        {
            Key = "BonusDamage",
            RingAffix = true
        },
        {
            Key = "AttackDamageBonus",
            Computed = "AttackDamageBonus"
        },
        {
            Key = "CritRate",
            Computed = "CritRate",
            ClassBase = {
                Field = "CritChance",
                Scale = 100
            }
        },
        {
            Key = "CritDamage",
            Computed = "CritDamage",
            ClassBase = {
                Field = "CritMultiplier",
                Offset = -1,
                Scale = 100
            }
        },
        {
            Key = "AttackSpeed",
            Computed = "AttackSpeed",
            Cap = {
                Value = 60
            }
        },
        {
            Key = "SkillDamageBonus",
            Computed = "SkillDamageBonus"
        },
        {
            Key = "ArmorShred",
            Computed = "ArmorShred"
        },
        {
            Key = "LifeSteal",
            Computed = "LifeSteal",
            Cap = {
                Value = EquipmentData.FORGE_CAP_ABSOLUTE.LifeSteal
            }
        },
        {
            Key = "SkillCritChance",
            Computed = "SkillCritChance",
            ConstBase = {
                Field = "SkillCritChanceBase",
                Scale = 100
            }
        },
        {
            Key = "SkillCritDamage",
            Computed = "SkillCritDamage",
            ConstBase = {
                Field = "SkillCritMultBase",
                Offset = -1,
                Scale = 100
            }
        }
    }
};

local function transform(p2: number, p3: any) -- Line: 96
    return (p2 + (p3.Offset or 0)) * (p3.Scale or 1);
end;

function v1.Get(p4) -- Line: 102
    -- upvalues: EquipmentData (copy)
    local Key = p4.Key;

    return {
        DisplayName = p4.DisplayName or (EquipmentData.StatDisplayNames[Key] or Key),
        Description = p4.Description or (EquipmentData.StatDescriptions[Key] or "")
    };
end;

function v1.ResolveValue(p5: any, p6: any, p7: any, p8: number?) -- Line: 116
    -- upvalues: CombatBaseStats (copy)
    local v9 = 0;

    if p5.Computed then
        v9 = v9 + (p6 and (p6[p5.Computed] or 0) or 0);
    end;

    if p5.RingAffix then
        v9 = v9 + (p8 or 0);
    end;

    if p5.ClassBase and p7 then
        local ClassBase = p5.ClassBase;
        v9 = v9 + ((p7[p5.ClassBase.Field] or 0) + (ClassBase.Offset or 0)) * (ClassBase.Scale or 1);
    end;

    if p5.ConstBase then
        local ConstBase = p5.ConstBase;
        v9 = v9 + ((CombatBaseStats[p5.ConstBase.Field] or 0) + (ConstBase.Offset or 0)) * (ConstBase.Scale or 1);
    end;

    return v9;
end;

function v1.FormatValue(p10: any, p11: number?) -- Line: 138
    -- upvalues: EquipmentData (copy)
    return EquipmentData.FormatStatValue(p10.FormatKey or p10.Key, p11 or 0);
end;

function v1.ResolveDisplay(p12: any, p13: number) -- Line: 154
    local Cap = p12.Cap;

    if not Cap then
        return p13, false;
    end;

    if Cap.Inverted then
        return math.max(p13, Cap.Value), p13 <= Cap.Value + 0.001;
    end;

    return math.min(p13, Cap.Value), Cap.Value - 0.001 <= p13;
end;

return v1;