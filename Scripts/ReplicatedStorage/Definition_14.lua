--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Flame Bastion.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Flame Bastion",
    Description = "A stalwart polearm fighter who commands wide, sweeping flames. Thick as iron and twice as hot every swing covers the battlefield.",
    Rarity = "Epic",
    DamageType = "Physical",
    DamageMultiplier = 1,
    CritChance = 0.05,
    CritMultiplier = 1.5,
    AttackSpeed = 1,
    TurnCount = 4,
    Range = 19,
    HitboxSize = Vector3.new(20, 10, 19),
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.4,
    DodgeVelocity = 85,
    DodgeDuration = 0.35,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Maewha",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 8,
        DEX = 8,
        VIT = 12,
        INT = 6,
        LCK = 6
    },
    Skills = { "Pyre Cyclone", "Blazing Reach", "Ember Step", "Ashen Onslaught" },
    SkillInfo = { {
            Description = "Fiery twirling sweep with three hits and a parry frame.",
            TotalMultiplier = 4.5,
            Protection = "Parry"
        }, {
            Description = "Glides forward with an extreme-reach polearm flurry six rapid flame thrusts.",
            TotalMultiplier = 4.2
        }, {
            Description = "Two-hit forward dash-strike with invulnerability through the dash. 2 charges.",
            TotalMultiplier = 4.5,
            Protection = "Dodge"
        }, {
            Description = "A relentless five-strike polearm assault, each strike carrying you forward.",
            TotalMultiplier = 5
        } },
    StationarySkills = { true, false, false, true },
    FX_Order = { "Front", "Front", "Front", "Front" },
    AnimationOverrides = {
        idle = "rbxassetid://76371199358822"
    }
};