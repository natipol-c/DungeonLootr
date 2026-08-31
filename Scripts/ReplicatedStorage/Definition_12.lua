--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Oathbreaker.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:49 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Oathbreaker",
    Description = "A merciless warrior who claimed the Oathbound\'s polearm and turned its might against all who stand. Raw strength incarnate every swing reshapes the battlefield.",
    Rarity = "Mythic",
    Summonable = false,
    IndexHidden = true,
    DamageType = "Physical",
    DamageMultiplier = 1.1,
    CritChance = 0.04,
    CritMultiplier = 1.5,
    AttackSpeed = 0.9,
    TurnCount = 4,
    Range = 17,
    HitboxSize = Vector3.new(14, 15, 17),
    DirectionalLunge = true,
    DirectionalLungeStrength = 1.7,
    DodgeVelocity = 80,
    DodgeDuration = 0.35,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.65,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Flame_Swing",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 18,
        DEX = 4,
        VIT = 10,
        INT = 3,
        LCK = 3
    },
    Skills = { "Shattered Sweep", "Ruin Onslaught", "Iron Stride", "Ruin Eruption" },
    SkillInfo = { {
            Description = "Devastating twirling sweep with three hits and a parry frame. Massive AoE.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "Three-phase polearm assault: two crushing blows followed by a five-tick explosive barrage with a ground eruption.",
            TotalMultiplier = 5
        }, {
            Description = "Heavy two-hit dash-strike with invulnerability.",
            TotalMultiplier = 4.2,
            Protection = "Dodge"
        }, {
            Description = "Slams the polearm into the earth twice, triggering massive eruptions at each impact. A forward dash separates the two blasts.",
            TotalMultiplier = 5
        } },
    StationarySkills = { true, true, false, false },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" }
};