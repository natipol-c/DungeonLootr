--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Wanderer.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Wanderer",
    Description = "A drifting martial artist who paints the battlefield in sumi ink, channeling ancient Wu-Shu through flowing brush-stroke sweeps and spirit-infused strikes. Every motion is a verse every verse, a storm.",
    Rarity = "Mythic",
    Summonable = true,
    DamageType = "Physical",
    DamageMultiplier = 1.05,
    CritChance = 0.07,
    CritMultiplier = 1.6,
    AttackSpeed = 1.3,
    TurnCount = 5,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.5,
    Range = 20,
    HitboxSize = Vector3.new(15, 10, 20),
    DodgeVelocity = 85,
    DodgeDuration = 0.35,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Scythe",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 11,
        DEX = 2,
        VIT = 7,
        INT = 11,
        LCK = 9
    },
    Skills = { "Ink Mirage", "Ink Volley", "Ink Severance", "Ink Reckoning" },
    SkillInfo = { {
            Description = "Slams the earth with a decisive stomp and dissolves into a sweep of black ink. Invulnerable ink-stroke phantoms erupt around the Wanderer, striking every foe in range.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Unleashes a rapid barrage of four ink-brush bolts that streak forward with tumbling rotation. Each bolt strikes once, hard.",
            TotalMultiplier = 5
        }, {
            Description = "A single sweeping wushu strike that conjures three great ink slashes crashing down in rapid succession.",
            TotalMultiplier = 5
        }, {
            Description = "A climactic six-hit combination. Five sweeping sword strikes lead into a devastating ink-burst explosion finisher.",
            TotalMultiplier = 5
        } },
    StationarySkills = { false, false, false, true },
    NoKnockbackSkills = { true },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://129471067358090"
    }
};