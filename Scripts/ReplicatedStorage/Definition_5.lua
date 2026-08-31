--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Cursed King.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:45 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Cursed King",
    Description = "",
    Rarity = "Exotic",
    Summonable = false,
    BaseStats = {
        STR = 14,
        DEX = 5,
        VIT = 0,
        INT = 5,
        LCK = 14
    },
    DamageType = "Physical",
    DamageMultiplier = 1.15,
    CritChance = 0.07,
    CritMultiplier = 1.8,
    AttackSpeed = 1,
    TurnCount = 5,
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
    Skills = { "Cleave Rush", "Slash Combo", "Cleaving Rush", "Fuuga", "" },
    UtilitySkill = "",
    Ultimate = "Malevolent Sanctum",
    UltimateMeterCost = 100,
    StationarySkills = {
        [1] = true,
        [2] = true,
        E = true
    },
    NoKnockbackSkills = {
        [1] = true,
        [2] = true,
        [3] = true,
        [4] = true,
        E = true
    },
    SkillInfo = {
        [1] = {
            Description = "Dash forward and rip a rapid flurry of projection cleaves across the target, fully invulnerable throughout.",
            TotalMultiplier = 6,
            Protection = "Dodge"
        },
        [2] = {
            Description = "Plant and unleash a rapid projection slash combo, fully invulnerable throughout.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        },
        [3] = {
            Description = "Fire three long-range projection slashes, then plant a sustained cleaving finale — fully invulnerable throughout.",
            TotalMultiplier = 7,
            Protection = "Dodge"
        },
        [4] = {
            Description = "Commit in place and channel a rising cursed pressure that detonates into a lingering field of continual damage.",
            TotalMultiplier = 10
        },
        E = {
            Description = "ULTIMATE — Malevolent Sanctum: expand a cursed domain. The caster channels in place as a sure-hit field forms, ripping every enemy caught inside it.",
            TotalMultiplier = 35
        },
        [5] = {
            Description = "On successful parry, 3 phantom clones surround the enemy and each performs a Projection Jab triple strike."
        }
    },
    SwingSoundFolder = "Sukuna",
    HitSoundFolder = "Hit",
    FX_Order = { "1", "2", "3", "4", "5" },
    ForgeVFX = true,
    AnimationOverrides = {
        idle = "rbxassetid://94004890321007"
    }
};