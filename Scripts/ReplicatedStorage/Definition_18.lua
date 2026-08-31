--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Boxer.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:53 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Boxer",
    Description = "A relentless bare-knuckle brawler who closes distance in the blink of an eye, weaving short dashes between every punch and chaining low-cooldown combos into a stationary finishing flurry.",
    Rarity = "Epic",
    DamageType = "Physical",
    DamageMultiplier = 1,
    CritChance = 0.08,
    CritMultiplier = 1.8,
    AttackSpeed = 1,
    TurnCount = 4,
    Range = 15,
    HitboxSize = Vector3.new(12, 10, 15),
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.5,
    UtilitySkill = "",
    SwingSoundFolder = "Short_Punches",
    BaseStats = {
        STR = 12,
        DEX = 8,
        VIT = 6,
        INT = 7,
        LCK = 4
    },
    Skills = { "Quick Jab", "Gazelle Sweep", "Tri-Jab", "Wolfs Fang" },
    SkillInfo = { {
            Description = "A lightning quick jab with 4 charges.",
            TotalMultiplier = 4
        }, {
            Description = "Quick step in with a devastating left hook.",
            TotalMultiplier = 4,
            Protection = "Dodge"
        }, {
            Description = "Quick jab 3 times with precision.",
            TotalMultiplier = 5
        }, {
            Description = "Body blow into overhand devastation.",
            TotalMultiplier = 5
        } },
    StationarySkills = { false, false, false, true },
    NoKnockbackSkills = {
        [4] = true
    },
    FX_Order = { "Jab", "Jab", "Jab" },
    AnimationOverrides = {
        idle = "rbxassetid://138411693143851"
    }
};