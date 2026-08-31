--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Hitman.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Hitman",
    Description = "A cold-blooded operative who alternates between blade and bullet, weaving lethal combos at mid-range while strafing with surgical precision.",
    Rarity = "Admin",
    Summonable = false,
    IndexHidden = true,
    DamageType = "Ranged",
    DamageMultiplier = 1.7,
    CritChance = 0.15,
    CritMultiplier = 1.9,
    AttackSpeed = 1.05,
    TurnCount = 5,
    Range = 24,
    HitboxSize = Vector3.new(23, 10, 30),
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.3,
    DodgeVelocity = 85,
    DodgeDuration = 0.35,
    DodgeCooldown = 1.8,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.25,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Ninja",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 8,
        DEX = 20,
        VIT = 4,
        INT = 7,
        LCK = 8
    },
    Skills = { "Stampede", "Death Sentence", "Slash Storm", "Bullet Typhoon", "(Lv. 30 Passive) Body Double" },
    SkillInfo = { {
            Description = "A rapid triple shot with directional dashing and shadow clones on every hit. 4 charges. Dodge frame.",
            TotalMultiplier = 18,
            Protection = "Dodge"
        }, {
            Description = "Plants and channels a relentless storm of slashes, then two heavy finisher strikes — the last a devastating double-force blow.",
            TotalMultiplier = "Variable"
        }, {
            Description = "A rooted three-hit combo, each strike carrying a short directional step — the final blow lands with double the force. 2 charges.",
            TotalMultiplier = 5
        }, {
            Description = "An eight-shot rapid fire barrage with full dodge protection. Shadow clones and directional dashes on every hit.",
            TotalMultiplier = 13.6,
            Protection = "Dodge"
        }, {
            Description = "On dash, leave behind a gold body-double that hunts your enemies for 5 seconds, dealing 75% of your damage. Only one may exist at a time."
        } },
    StationarySkills = { false, true, true, false },
    NoKnockbackSkills = {
        [2] = true
    },
    SwingSoundOrder = { "Revolver", "Revolver", "Ninja", "Hard_Kick", "Revolver" },
    FX_Order = { "Left_Shot", "Left_Shot", "Right_Slash", "Reverse_Slash", "Left_Shot" },
    AnimationOverrides = {
        idle = "rbxassetid://129588233878835",
        run = "rbxassetid://136413112658607"
    }
};