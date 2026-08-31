--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Demonbane.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:46 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Demonbane",
    Description = "The Slayer. A celestial mage who annihilates demons with overwhelming arcane force, each swing carving searing waves of mana through everything before her.",
    Rarity = "Celestial",
    Summonable = false,
    DamageType = "Magic",
    DamageMultiplier = 1,
    CritChance = 0.06,
    CritMultiplier = 1.6,
    AttackSpeed = 1.1,
    TurnCount = 4,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.6,
    Range = 40,
    HitboxSize = Vector3.new(15, 20, 40),
    DodgeVelocity = 90,
    DodgeDuration = 0.35,
    DodgeCooldown = 1.8,
    DodgeIFrameDuration = 0.75,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Magic_Shoot",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 2,
        DEX = 10,
        VIT = 1,
        INT = 16,
        LCK = 1
    },
    Skills = { "Zoltraak", "Vollzanbel", "Gravity Well", "Catastravia" },
    SkillInfo = { {
            Description = "Unleashes a straightforward blast of mana for a single hard-hitting strike. 2 charges.",
            TotalMultiplier = 4
        }, {
            Description = "Channels a towering pillar of fire that scorches everything ahead, striking five times.",
            TotalMultiplier = 5
        }, {
            Description = "Conjures a black hole ahead that drags every nearby enemy toward its core for 5 seconds.",
            TotalMultiplier = 0
        }, {
            Description = "Saturates a vast area ahead with annihilating arcane energy, raining damage every fraction of a second for two seconds.",
            TotalMultiplier = 5
        } },
    StationarySkills = { false, true, false, true },
    NoKnockbackSkills = { true },
    FX_Order = { "Shoot", "Shoot", "Shoot", "Shoot" },
    AnimationOverrides = {
        idle = "rbxassetid://114512065003613"
    }
};