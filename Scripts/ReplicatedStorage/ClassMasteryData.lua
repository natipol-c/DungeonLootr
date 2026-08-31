--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ClassMasteryData
  Path:     game.ReplicatedStorage.GameInfo.ClassMasteryData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {
    STR = true,
    DEX = true,
    VIT = true,
    INT = true,
    LCK = true
};
u1.Milestones = {
    Ronin = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [13] = { {
                Type = "Passive",
                PassiveId = "Dodge_Blossom"
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Assassin = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Bowman = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "DEX",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Greatsword = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Monk = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Frost Mage"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "INT",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Flame Bastion"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Healing Fist"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "INT",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Boxer = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Reaper = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "INT",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Witch Gunner"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "DEX",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Demonbane = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "INT",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Shinobi = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Divergent = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [13] = { {
                Type = "Passive",
                PassiveId = "Flash_Proc"
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Cursed Child"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Azure Devil"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [13] = { {
                Type = "Passive",
                PassiveId = "Phantom_Strikes"
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Hitman = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "DEX",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Shadow Vagrant"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "INT",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [13] = { {
                Type = "Passive",
                PassiveId = "Evasive_Stride"
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Dark Rider"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Vacio = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "INT",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Master Swordsman"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Wanderer = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Forge Archon"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "DEX",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Nightbloom = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "INT",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Unrestricted = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Coyote = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "DEX",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Oathbreaker = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Lichborn = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Founder = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } },
        [30] = { {
                Type = "Passive",
                PassiveId = "Body_Outside_the_Body"
            } }
    },
    Archer = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "DEX",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Framebreaker = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [13] = { {
                Type = "Passive",
                PassiveId = "Projection_Retaliation"
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Artemis = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "DEX",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [13] = { {
                Type = "Passive",
                PassiveId = "Spectral_Hunt"
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Homura = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [13] = { {
                Type = "Passive",
                PassiveId = "Burning_Strikes"
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Mooncarver = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [13] = { {
                Type = "Passive",
                PassiveId = "Lunar_Riposte"
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Kage = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [13] = { {
                Type = "Passive",
                PassiveId = "Shadow_Pursuit"
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Chaotic Fist"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [13] = { {
                Type = "Passive",
                PassiveId = "Chaotic_Counter"
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Streamline = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Dreadlord = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Master Ronin"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Prisma = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Sea King"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Typhoon = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "DEX",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Sinister Trigger"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "DEX",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } },
        [50] = { {
                Type = "Passive",
                PassiveId = "Deadeye"
            } }
    },
    ["Anti Magic"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Jetstream = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Awakened Devil EX"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [13] = { {
                Type = "Passive",
                PassiveId = "Summoned_Sword"
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Zero = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [13] = { {
                Type = "Passive",
                PassiveId = "Shimotsuki"
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Mori = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } },
        [30] = { {
                Type = "Passive",
                PassiveId = "Relentless"
            } }
    },
    ["Honored One"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "INT",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Cursed King"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Hitman = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "DEX",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } },
        [30] = { {
                Type = "Passive",
                PassiveId = "Body_Double"
            } }
    },
    Hollow = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    Sunless = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "INT",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    },
    ["Spell Breaker"] = {
        [5] = { {
                Type = "SkillDamage",
                Slot = 1,
                Bonus = 0.2
            } },
        [7] = { {
                Type = "Stat",
                Stat = "STR",
                Value = 4,
                Scope = "Active"
            } },
        [10] = { {
                Type = "SkillDamage",
                Slot = 2,
                Bonus = 0.2
            } },
        [15] = { {
                Type = "SkillDamage",
                Slot = 3,
                Bonus = 0.2
            } },
        [17] = { {
                Type = "CooldownReduction",
                Value = 5
            } },
        [20] = { {
                Type = "SkillDamage",
                Slot = 4,
                Bonus = 0.2
            } }
    }
};

local function EffectiveLevel(p3) -- Line: 572
    return not p3 and 1 or math.max(p3.Level or 1, p3.HighestLevel or 0);
end;

function u1.GetGlobalStatBonuses(p4: table) -- Line: 583
    -- upvalues: u1 (copy), u2 (copy)
    local v5 = {
        STR = 0,
        DEX = 0,
        VIT = 0,
        INT = 0,
        LCK = 0
    };

    for i, v in p4 do
        local v6 = u1.Milestones[i];

        if v6 then
            local v7 = not v and 1 or math.max(v.Level or 1, v.HighestLevel or 0);

            for i2, v2 in v6 do
                if i2 <= v7 then
                    for _, v3 in v2 do
                        if v3.Type == "Stat" and (v3.Scope == "Global" and u2[v3.Stat]) then
                            local Stat = v3.Stat;
                            v5[Stat] = v5[Stat] + v3.Value;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v5;
end;

function u1.GetActiveStatBonuses(p8: table, p9: string) -- Line: 609
    -- upvalues: u1 (copy), u2 (copy)
    local v10 = {
        STR = 0,
        DEX = 0,
        VIT = 0,
        INT = 0,
        LCK = 0
    };

    if not p9 or p9 == "" then
        return v10;
    end;

    local v11 = p8[p9];

    if not v11 then
        return v10;
    end;

    local v12 = u1.Milestones[p9];

    if not v12 then
        return v10;
    end;

    local v13 = not v11 and 1 or math.max(v11.Level or 1, v11.HighestLevel or 0);

    for i, v in v12 do
        if i <= v13 then
            for _, v2 in v do
                if v2.Type == "Stat" and (v2.Scope == "Active" and u2[v2.Stat]) then
                    local Stat = v2.Stat;
                    v10[Stat] = v10[Stat] + v2.Value;
                end;
            end;
        end;
    end;

    return v10;
end;

function u1.GetActiveSkillDamageBonuses(p14: table, p15: string) -- Line: 638
    -- upvalues: u1 (copy)
    local v16 = {};

    if not p15 or p15 == "" then
        return v16;
    end;

    local v17 = p14[p15];

    if not v17 then
        return v16;
    end;

    local v18 = u1.Milestones[p15];

    if not v18 then
        return v16;
    end;

    local v19 = not v17 and 1 or math.max(v17.Level or 1, v17.HighestLevel or 0);

    for i, v in v18 do
        if i <= v19 then
            for _, v2 in v do
                if v2.Type == "SkillDamage" and v2.Slot then
                    v16[v2.Slot] = (v16[v2.Slot] or 0) + v2.Bonus;
                end;
            end;
        end;
    end;

    return v16;
end;

function u1.GetActiveCooldownReduction(p20: table, p21: string) -- Line: 668
    -- upvalues: u1 (copy)
    local v22 = 0;

    if not p21 or p21 == "" then
        return v22;
    end;

    local v23 = p20[p21];

    if not v23 then
        return v22;
    end;

    local v24 = u1.Milestones[p21];

    if not v24 then
        return v22;
    end;

    local v25 = not v23 and 1 or math.max(v23.Level or 1, v23.HighestLevel or 0);

    for i, v in v24 do
        if i <= v25 then
            for _, v2 in v do
                if v2.Type == "CooldownReduction" then
                    v22 = v22 + v2.Value;
                end;
            end;
        end;
    end;

    return v22;
end;

function u1.GetMilestonesAtLevel(p26: string, p27: number) -- Line: 697
    -- upvalues: u1 (copy)
    local v28 = u1.Milestones[p26];

    return v28 and (v28[p27] or {}) or {};
end;

function u1.GetAllUnclaimedItemRewards(p29: table, p30: table) -- Line: 708
    -- upvalues: u1 (copy)
    local v31 = {};

    for i, v in p29 do
        local v32 = u1.Milestones[i];

        if v32 then
            local v33 = not v and 1 or math.max(v.Level or 1, v.HighestLevel or 0);
            local v34 = i;

            for i2, v2 in v32 do
                if i2 <= v33 then
                    local v35 = i2;

                    for _, v3 in v2 do
                        if v3.Type == "ItemReward" and not p30[v34 .. "_" .. v35] then
                            table.insert(v31, {
                                ClassName = v34,
                                Level = v35,
                                RewardId = v3.RewardId
                            });
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v31;
end;

function u1.GetActiveMasteryPassives(p36: table, p37: string) -- Line: 742
    -- upvalues: u1 (copy)
    local v38 = {};

    if not p37 or p37 == "" then
        return v38;
    end;

    local v39 = p36[p37];

    if not v39 then
        return v38;
    end;

    local v40 = u1.Milestones[p37];

    if not v40 then
        return v38;
    end;

    local v41 = not v39 and 1 or math.max(v39.Level or 1, v39.HighestLevel or 0);

    for i, v in v40 do
        if i <= v41 then
            for _, v2 in v do
                if v2.Type == "Passive" and v2.PassiveId then
                    table.insert(v38, {
                        PassiveId = v2.PassiveId
                    });
                end;
            end;
        end;
    end;

    return v38;
end;

return u1;