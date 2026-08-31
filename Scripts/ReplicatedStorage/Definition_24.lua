--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Prisma.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Prisma",
    Description = "A predator wrapped in light. Prisma fights with feral grace, pinning targets in place with chained claw strikes before tearing through them in a blur of iridescent slashes.",
    Rarity = "Exotic",
    Summonable = false,
    IndexHidden = true,
    DamageType = "Physical",
    DamageMultiplier = 1,
    CritChance = 0.06,
    CritMultiplier = 1.6,
    AttackSpeed = 1.1,
    TurnCount = 4,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2,
    Range = 19,
    HitboxSize = Vector3.new(20, 10, 19),
    DodgeVelocity = 85,
    DodgeDuration = 0.35,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Claw_Swings",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 10,
        DEX = 4,
        VIT = 13,
        INT = 13,
        LCK = 0
    },
    Skills = { "Fang Rush", "Shackle Rend", "Rake Barrage", "Prism Ruin" },
    SkillInfo = { {
            Description = "Three-charge double claw strike with directional dashing and invulnerability. Shadow clones trail each dash.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Wide claw strike that chains all enemies hit in place, stunning them and preventing knockback for 3 seconds. Bosses are immune to the stun.",
            TotalMultiplier = 3.75
        }, {
            Description = "Relentless ten-hit claw barrage. The final three strikes widen and hit harder, with the ninth slash detonating a burst of energy.",
            TotalMultiplier = 5
        }, {
            Description = "Enters a frenzied claw storm, shredding everything nearby with continuous hits. Ends with a devastating slam that sends out a shockwave.",
            TotalMultiplier = "Variable"
        } },
    StationarySkills = { false, true, true, true },
    NoKnockbackSkills = {
        [4] = true
    },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://89768564509943"
    }
};