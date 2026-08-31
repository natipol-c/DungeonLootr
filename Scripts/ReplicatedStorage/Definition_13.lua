--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Bowman.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Bowman",
    Description = "A nimble marksman who strikes from distance with precision arrows, weaving between shots with directional strafing and finishing targets with a devastating charged crit.",
    Rarity = "Rare",
    DamageType = "Ranged",
    DamageMultiplier = 1.05,
    CritChance = 0.08,
    CritMultiplier = 1.8,
    AttackSpeed = 1.05,
    TurnCount = 4,
    Range = 34,
    HitboxSize = Vector3.new(14, 12, 34),
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.5,
    UtilitySkill = "",
    SwingSoundFolder = "Magic_Bow",
    BaseStats = {
        STR = 8,
        DEX = 12,
        VIT = 6,
        INT = 4,
        LCK = 10
    },
    Skills = { "Fadeaway Shot", "Phantom Stride", "Hail Volley", "Deadeye" },
    SkillInfo = { {
            Description = "Backward twirl with invulnerability that fires a high-damage long-range arrow.",
            TotalMultiplier = 4,
            Protection = "Dodge"
        }, {
            Description = "Quick forward dash with shadow clones and full invulnerability, sweeping a wide burst of arrows around you.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Rapid three-shot combo with directional dashing between each arrow.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Devastating charged shot with extreme range and guaranteed critical hit.",
            TotalMultiplier = 4
        } },
    StationarySkills = { false, false, false, true },
    FX_Order = { "Shot", "Shot", "Shot" },
    AnimationOverrides = {
        idle = "rbxassetid://90974298119945"
    }
};