--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Shinobi.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:55 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Shinobi",
    Description = "A shadow-born blade dancer whose strikes land in pairs. Moves like smoke on the battlefield disappearing, reappearing, and leaving nothing but silence in his wake.",
    Rarity = "Legendary",
    DamageType = "Physical",
    DamageMultiplier = 0.8,
    CritChance = 0.06,
    CritMultiplier = 1.6,
    AttackSpeed = 1.1,
    TurnCount = 3,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2,
    Range = 14,
    HitboxSize = Vector3.new(18, 10, 14),
    DodgeVelocity = 90,
    DodgeDuration = 0.3,
    DodgeCooldown = 1.5,
    DodgeIFrameDuration = 0.75,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Sword_Swings",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 12,
        DEX = 12,
        VIT = 6,
        INT = 5,
        LCK = 5
    },
    Skills = { "Flash Rend", "Kurogiri", "Guillotine Drop", "Oni Rend" },
    SkillInfo = { {
            Description = "A blinding three-hit blade flurry, each strike trailing a shadow clone. Fully invulnerable for the duration. 2 charges.",
            TotalMultiplier = 3,
            Protection = "Dodge"
        }, {
            Description = "Crouches low and bursts a black-smoke bomb, then dash-steps into a sweeping horizontal slash. Invulnerable through the dashes.",
            TotalMultiplier = 2.7,
            Protection = "Dodge"
        }, {
            Description = "Aerial flip into a devastating multi-hit ground slam. Massive AoE. Dodge frame after the dash.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Dashes in with a focused four-hit blade combo — three measured strikes into a heavy finisher. Parry frames activate after the third strike.",
            TotalMultiplier = 5,
            Protection = "Parry"
        } },
    StationarySkills = { false, false, false, true },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://82921578624086"
    }
};