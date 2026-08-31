--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Streamline.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:44 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Streamline",
    Description = "A disciplined swordsman whose blade moves like a river unbroken, graceful, and impossible to halt once it begins. Every strike flows into the next, carving through all who stand in its current.",
    Rarity = "Celestial",
    Summonable = false,
    BaseStats = {
        STR = 10,
        DEX = 10,
        VIT = 4,
        INT = 10,
        LCK = 0
    },
    DamageType = "Physical",
    DamageMultiplier = 1.1,
    CritChance = 0.06,
    CritMultiplier = 1.6,
    AttackSpeed = 1,
    TurnCount = 4,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.5,
    Range = 22,
    HitboxSize = Vector3.new(18, 15, 25),
    DodgeVelocity = 90,
    DodgeDuration = 0.35,
    DodgeCooldown = 1.8,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    Skills = { "Water Wheel", "Surface Slash", "Flowing Dance", "Constant Flux" },
    UtilitySkill = "",
    Ultimate = "Blessed Rain",
    UltimateMeterCost = 111,
    SkillInfo = {
        [1] = {
            Description = "Glides forward with a sweeping four-hit water wheel, capped by a devastating finishing strike. Parry frames cover the entire technique.",
            TotalMultiplier = 5,
            Protection = "Parry"
        },
        [2] = {
            Description = "Roots in place and delivers a single devastating sweep with a massive omnidirectional reach. Parry frame throughout, and the current sometimes runs on — a 15% chance to instantly ready Water Wheel and Flowing Dance again.",
            TotalMultiplier = 4,
            Protection = "Parry"
        },
        [3] = {
            Description = "An unbroken six-strike dance that flows through the enemy like a rising current. Full invulnerability throughout. The blade occasionally catches fire, blooming into a searing variant of the dance.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        },
        [4] = {
            Description = "An unbroken rotation of eight consecutive strikes, each carrying the blade in the player\'s movement direction. The final blow erupts with a beast\'s roar. Parry frames throughout.",
            TotalMultiplier = 5,
            Protection = "Parry"
        },
        E = {
            Description = "ULTIMATE — Blessed Rain: gather the still water and answer the drought with one overwhelming strike, drowning everything in reach. Invulnerable throughout the cast.",
            TotalMultiplier = 15,
            Protection = "Dodge"
        }
    },
    StationarySkills = {
        [2] = true,
        [3] = true
    },
    NoKnockbackSkills = {
        [3] = true
    },
    SwingSoundFolder = "Water_Swings",
    HitSoundFolder = "Hit",
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    ForgeVFX = true,
    AnimationOverrides = {
        idle = "rbxassetid://98562652237099",
        run = "rbxassetid://116531531279085"
    }
};