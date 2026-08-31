--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Honored One.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:53 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Honored One",
    Description = "",
    Rarity = "Exotic",
    Summonable = false,
    BaseStats = {
        STR = 5,
        DEX = 5,
        VIT = 0,
        INT = 15,
        LCK = 14
    },
    DamageType = "Magic",
    DamageMultiplier = 1.15,
    CritChance = 0.07,
    CritMultiplier = 1.8,
    AttackSpeed = 1,
    TurnCount = 4,
    ComboEndlag = 0.3,
    Range = 20,
    HitboxSize = Vector3.new(13, 15, 20),
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.5,
    DodgeVelocity = 90,
    DodgeDuration = 0.3,
    DodgeCooldown = 1.8,
    DodgeIFrameDuration = 0.65,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    Skills = { "Blue", "Red", "Hollow Purple", "Infinity", "" },
    UtilitySkill = "",
    SpecialTurnCount = 6,
    Ultimate = "Infinite Void",
    UltimateMeterCost = 100,
    StationarySkills = {
        [1] = true,
        E = true
    },
    NoKnockbackSkills = {
        [1] = true,
        E = true
    },
    SkillInfo = {
        [1] = {
            Description = "Conjure a singularity ahead that drags in every nearby enemy, grinding them with continuous chip damage, then collapse it into a single devastating blast. Fully invulnerable throughout.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        },
        [2] = {
            Description = "Reversal blast. Tap for a single devastating forward strike; hold to detonate the same force in a centered blast around you.",
            TotalMultiplier = 4
        },
        [3] = {
            Description = "Collide Red and Blue into an imaginary mass. Charge in place, then unleash Hollow Purple — a single annihilating beam that obliterates everything in a long line ahead.",
            TotalMultiplier = 4
        },
        [4] = {
            Description = "Limitless. TAP for Infinity: 30s of 50% damage reduction, +15% attack speed and +15% movement. HOLD for Reverse Cursed Technique: instantly heal 20% Max HP, then 5% more over 5s. While either is active your moveset transforms.",
            TotalMultiplier = 0
        },
        E = {
            Description = "ULTIMATE — Infinite Void: expand the limitless domain. Every enemy within 100 studs is caught in the void — flooded with infinite information and frozen helpless for 15 seconds.",
            TotalMultiplier = 0
        },
        [5] = {
            Description = "On successful parry, 3 phantom clones surround the enemy and each performs a Projection Jab triple strike."
        }
    },
    SwingSoundFolder = "Short_Punches",
    SwingSoundOrder = { "Short_Punches", "Short_Punches", "Hard_Kick", "Blue_Shoot" },
    HitSoundFolder = "Hit",
    FX_Order = { "Empty", "Empty", "Empty", "Empty" },
    ForgeVFX = true,
    AnimationOverrides = {
        idle = "rbxassetid://82921578624086",
        run = "rbxassetid://136413112658607"
    }
};