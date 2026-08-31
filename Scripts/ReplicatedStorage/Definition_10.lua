--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Shadow Vagrant.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:48 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Shadow Vagrant",
    Description = "A sovereign of shadows who moves between dimensions, striking with phantom blades that rend space itself. His power defies classification existing beyond the boundaries of known strength.",
    Rarity = "Exotic",
    Summonable = false,
    BaseStats = {
        STR = 13,
        DEX = 17,
        VIT = 4,
        INT = 9,
        LCK = 10
    },
    DamageType = "Physical",
    DamageMultiplier = 1.15,
    CritChance = 0.08,
    CritMultiplier = 1.8,
    AttackSpeed = 1.3,
    TurnCount = 5,
    Range = 18,
    HitboxSize = Vector3.new(13, 14, 18),
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.8,
    DodgeVelocity = 95,
    DodgeDuration = 0.3,
    DodgeCooldown = 1.5,
    DodgeIFrameDuration = 0.65,
    ParryDuration = 0.5,
    ParryCooldown = 2.5,
    Skills = { "Flickering Step", "Rolling Crescent", "Foxclaw", "Mutilate", "(Lv. 13 Passive) Evasive Stride" },
    UtilitySkill = "",
    Ultimate = "Sovereign of Shadows",
    UltimateMeterCost = 111,
    SkillInfo = {
        [1] = {
            Description = "Blink-step in your input direction with dodge frames, flashing across the battlefield with three wide AoE strikes. Each strike opens a brief parry window. 3 charges.",
            TotalMultiplier = 4.8,
            Protection = "Dodge"
        },
        [2] = {
            Description = "A six-hit forward-spinning crescent with parry frames the whole way through. Hold to leap skyward instead and hurl a crescent that detonates the ground ahead in a wide AoE.",
            TotalMultiplier = 5,
            Protection = "Parry"
        },
        [3] = {
            Description = "A blistering six-strike foxclaw flurry that shreds anything in front. Pure offense — no defensive frames.",
            TotalMultiplier = 5
        },
        [4] = {
            Description = "Dash in and pin the target in a grinding shadow-claw vortex, ticking rapid damage into a devastating finisher. Dodge frames bookend the channel; enemies are held in place.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        },
        [5] = {
            Description = "After dodging, the next basic attack triggers a lesser shadow flicker — a rapid 3-hit phantom flurry. No iFrame protection."
        },
        E = {
            Description = "ULTIMATE — Sovereign of Shadows: rip open a wide summoning strike and call forth four black shadow clones that fight at your side for 30 seconds, each striking with your basic combo for 50% damage. Invulnerable throughout the cast.",
            TotalMultiplier = 6,
            Protection = "Dodge"
        }
    },
    StationarySkills = { false, false, false, true },
    NoKnockbackSkills = {
        [4] = true
    },
    SwingSoundFolder = "Ninja",
    HitSoundFolder = "Hit",
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Side_Slash", "Right_Side_Slash" },
    ForgeVFX = true,
    AnimationOverrides = {
        idle = "rbxassetid://82921578624086",
        run = "rbxassetid://85701763280978"
    }
};