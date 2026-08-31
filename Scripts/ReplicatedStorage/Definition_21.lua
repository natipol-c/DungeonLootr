--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Ronin.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:55 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Ronin",
    Description = "A wandering swordsman who wields a katana with deadly precision.",
    Rarity = "Rare",
    DamageType = "Physical",
    DamageMultiplier = 1.15,
    CritChance = 0.06,
    CritMultiplier = 1.6,
    AttackSpeed = 1,
    TurnCount = 4,
    Range = 13,
    HitboxSize = Vector3.new(13, 10, 13),
    DodgeVelocity = 85,
    DodgeDuration = 0.35,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.7,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.2,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Corsair_A",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 12,
        DEX = 10,
        VIT = 8,
        INT = 5,
        LCK = 5
    },
    Skills = { "Ichimonji", "Setting Horizon", "Swallow Cut", "Falling Blossom", "(Lv. 13 Passive) Dodge Blossom" },
    SkillInfo = { {
            Description = "Forward dash with full invulnerability into a precise double strike.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Dashes in your input direction into a three-hit rushing combo two quick cuts flowing into a wider finishing sweep. No defensive frames. 2 charges.",
            TotalMultiplier = 3.5
        }, {
            Description = "Backward dash with an active parry frame, then a five-slice afterimage flurry.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "Forward dash with a parry frame into an eight-hit cascade a rapid three-cut burst flowing into five trailing slices.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "After dodging, the next basic attack within 3 seconds activates a lesser Falling Blossom a forward dash with three cuts at reduced damage and no parry protection."
        } },
    StationarySkills = { false, true, false, false },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://130677652203723",
        run = "rbxassetid://85701763280978"
    }
};