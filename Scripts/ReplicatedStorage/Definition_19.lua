--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Witch Gunner.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:53 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Witch Gunner",
    Description = "A trigger-happy gunslinger who channels dark magic through twin pistols, unleashing relentless barrages at blinding speed.",
    Rarity = "Legendary",
    DamageType = "Ranged",
    DamageMultiplier = 0.7,
    CritChance = 0.12,
    CritMultiplier = 2,
    AttackSpeed = 1.3,
    TurnCount = 5,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2,
    Range = 22,
    HitboxSize = Vector3.new(17, 10, 25),
    DodgeVelocity = 95,
    DodgeDuration = 0.3,
    DodgeCooldown = 1.5,
    DodgeIFrameDuration = 0.6,
    ParryDuration = 0.5,
    ParryCooldown = 2.5,
    UtilitySkill = "",
    SwingSoundFolder = "Gun_Shots",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 5,
        DEX = 10,
        VIT = 6,
        INT = 10,
        LCK = 9
    },
    Skills = { "Witch Twist", "Bullet Carnival", "Thorn Recoil", "Wicked Sabbath" },
    SkillInfo = { {
            Description = "Spinning side-jump with four shots and full invulnerability. 2 charges.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Rapid-fire five-shot barrage with wide area coverage. No protection.",
            TotalMultiplier = 5
        }, {
            Description = "Two shots forward, backward dash, then three trailing shots with invulnerability.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "A nine-shot spinning gun flourish that roots you in place through a savage close-range storm. Full commitment.",
            TotalMultiplier = 5
        } },
    StationarySkills = { false, false, false, false },
    FX_Order = { "Left_Shot", "0", "0", "0", "0" },
    AnimationOverrides = {
        idle = "rbxassetid://127550176984868",
        run = "rbxassetid://136413112658607"
    }
};