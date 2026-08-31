--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Assassin.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Assassin",
    Description = "A shadow-dwelling rogue who strikes with lethal speed.",
    Rarity = "Epic",
    DamageType = "Physical",
    DamageMultiplier = 0.85,
    CritChance = 0.12,
    CritMultiplier = 2,
    AttackSpeed = 1,
    TurnCount = 5,
    Range = 15,
    HitboxSize = Vector3.new(15, 10, 15),
    DodgeVelocity = 95,
    DodgeDuration = 0.3,
    DodgeCooldown = 1.5,
    DodgeIFrameDuration = 0.6,
    DirectionalLunge = true,
    DirectionalLungeStrength = 1.8,
    ParryDuration = 0.5,
    ParryCooldown = 2.5,
    UtilitySkill = "",
    SwingSoundFolder = "Ninja",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 8,
        DEX = 14,
        VIT = 6,
        INT = 5,
        LCK = 7
    },
    Skills = { "Chasing Spire", "Flickering Shadows", "Cross Slash", "Phantom Swarm" },
    StationarySkills = {
        [2] = true
    },
    NoKnockbackSkills = {
        [2] = true
    },
    SkillInfo = { {
            Description = "Dash through the shadows leaving afterimages, then unleash a six-slash barrage — parry frames cover the final strikes.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "Vanish into the shadows — invisible and untouchable — for a 2.5s barrage of slashes around you.",
            TotalMultiplier = 8.5,
            Protection = "Dodge"
        }, {
            Description = "Twin-charge crossing flurry. Dash in, flicker, and rip a rapid four-hit slash behind a brief parry.",
            TotalMultiplier = 4.5,
            Protection = "Parry"
        }, {
            Description = "Flicker-dash finisher that lands a rapid four-hit strike. Parry and iFrame during the dash.",
            TotalMultiplier = 5,
            Protection = "Parry"
        } },
    AnimationOverrides = {
        idle = "rbxassetid://121310713511589",
        run = "rbxassetid://85701763280978"
    }
};