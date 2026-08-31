--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Framebreaker.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Framebreaker",
    Description = "A reality-warping fighter who projects devastating force through sheer willpower. Zero vitality, absolute aggression every strike bends the frame of existence itself.",
    Rarity = "Exotic",
    Summonable = false,
    IndexHidden = true,
    DamageType = "Physical",
    DamageMultiplier = 1.15,
    CritChance = 0.07,
    CritMultiplier = 1.8,
    AttackSpeed = 1.05,
    TurnCount = 5,
    ComboEndlag = 0.3,
    Range = 20,
    HitboxSize = Vector3.new(13, 15, 20),
    DirectionalLunge = true,
    DirectionalLungeStrength = 2,
    DodgeVelocity = 90,
    DodgeDuration = 0.3,
    DodgeCooldown = 1.8,
    DodgeIFrameDuration = 0.65,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Naoya_Punches",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 14,
        DEX = 5,
        VIT = 0,
        INT = 5,
        LCK = 14
    },
    Skills = { "Frame Skip", "Projection Jab", "Earthshatter", "24-Frame Onslaught", "(Lv. 13 Passive) Projection Retaliation" },
    SkillInfo = { {
            Description = "Three-charge projection snap. Each charge teleports forward and strikes at point-blank range with full invulnerability.",
            TotalMultiplier = 4,
            Protection = "Dodge"
        }, {
            Description = "Rapid three-hit projection jab combo. Low commitment, low cost.",
            TotalMultiplier = 5
        }, {
            Description = "Slams the ground with projection force, unleashing twelve continuous shockwave hits with full invulnerability.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Devastating five-hit projection assault. Pure damage commitment with massive reach.",
            TotalMultiplier = 5
        }, {
            Description = "On successful parry, 3 phantom clones surround the enemy and each performs a Projection Jab triple strike."
        } },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://82837107921468",
        run = "rbxassetid://136413112658607"
    }
};