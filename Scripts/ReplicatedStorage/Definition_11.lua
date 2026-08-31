--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Greatsword.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:49 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Greatsword",
    Description = "A towering blade of flame and iron. Slow, deliberate, and utterly devastating every swing is a commitment, and every hit is a statement.",
    Rarity = "Rare",
    DamageType = "Physical",
    DamageMultiplier = 1.3,
    CritChance = 0.03,
    CritMultiplier = 2.2,
    AttackSpeed = 1,
    TurnCount = 5,
    Range = 18,
    HitboxSize = Vector3.new(19, 10, 19),
    DodgeVelocity = 85,
    DodgeDuration = 0.35,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.7,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.2,
    ParryDuration = 0.6,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Maewha",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 14,
        DEX = 5,
        VIT = 12,
        INT = 4,
        LCK = 5
    },
    Skills = { "Skull Splitter", "Great Chase", "Blazing Spiral", "Cataclysm" },
    SkillInfo = { {
            Description = "Dash along your input direction and bring the greatsword down in a towering overhead split. Dodge frames cover the lunge. 2 charges.",
            TotalMultiplier = 3.25,
            Protection = "Dodge"
        }, {
            Description = "Stand your ground behind a parry frame and unleash a rising slash into a crashing falling slash.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "A wide circular spin that whips the greatsword all the way around, striking everything nearby six times. Pure offense.",
            TotalMultiplier = 5
        }, {
            Description = "Long winding overhead slam with extreme range and a guaranteed critical hit. Dodge frames cover the wind-up.",
            TotalMultiplier = 4,
            Protection = "Dodge"
        } },
    StationarySkills = { false, true, true, true },
    NoKnockbackSkills = {
        [3] = true
    },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://100096261825488"
    }
};