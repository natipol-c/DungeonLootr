--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     StatData
  Path:     game.ReplicatedStorage.GameInfo.StatData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Order = { "STR", "DEX", "INT", "VIT" },
    Stats = {
        STR = {
            DisplayName = "Strength",
            Description = "Raises <b>Attack</b> and <b>Skill Damage</b> for <b>Physical</b> classes."
        },
        DEX = {
            DisplayName = "Dexterity",
            Description = "Raises <b>Attack</b> and <b>Skill Damage</b> for <b>Ranged</b> classes, plus <b>Crit Rate</b>, <b>Attack Speed</b>, and <b>Dodge Rate</b>."
        },
        INT = {
            DisplayName = "Intelligence",
            Description = "Raises <b>Attack</b> and <b>Skill Damage</b> for <b>Magic</b> classes, plus <b>Cooldown Reduction</b>."
        },
        VIT = {
            DisplayName = "Vitality",
            Description = "Raises <b>Max HP</b> and grants a small amount of <b>HP Regen</b>."
        },
        LCK = {
            DisplayName = "Luck",
            Description = "Raises <b>Crit Damage</b> and improves <b>loot rarity</b>."
        }
    }
};

function u1.Get(p2: string) -- Line: 45
    -- upvalues: u1 (copy)
    return u1.Stats[p2];
end;

return u1;