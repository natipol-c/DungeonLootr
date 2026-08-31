--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Archer.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:44 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Archer",
    Description = "An elven bowman who channels mystic energy through every arrow. His shots gently curve toward their mark, and his skills launch vertical barrages that rain down like divine judgment.",
    Rarity = "Legendary",
    IndexHidden = false,
    BaseStats = {
        STR = 3,
        DEX = 12,
        VIT = 4,
        INT = 15,
        LCK = 6
    },
    DamageType = "Ranged",
    DamageMultiplier = 0.55,
    CritChance = 0.06,
    CritMultiplier = 1.6,
    AttackSpeed = 1.2,
    TurnCount = 4,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.5,
    Range = 10,
    HitboxSize = Vector3.new(5, 5, 10),
    DodgeVelocity = 85,
    DodgeDuration = 0.35,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    ParrySuccessCooldown = 0.7,
    Skills = { "Radiant Volley", "Luthiens Rain", "Zephyr Barrage", "Divine Volley" },
    UtilitySkill = "",
    SkillInfo = { {
            Description = "Dash forward and fire 6 staggered arrows skyward that arc down onto enemies. 3 charges. Dodge frame.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Leap backward and trigger a triple explosion sequence right, center, left. Each blast deals AoE damage. Dodge frame.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Charge forward firing 5 sweeping volleys of 2 arrows each with moderate arc. Parry on activation.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "Plant your feet and unleash a relentless 9-volley barrage of 2 arrows each with hard lock-on tracking. Dodge frame.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        } },
    SwingSoundFolder = "Bow_Shot",
    HitSoundFolder = "Hit",
    FX_Order = { "Front", "Front", "Front", "Front" },
    UseProjectile = true,
    ProjectileId = "Arrow_2",
    ProjectileSpeed = 110,
    ProjectileArc = 0,
    ProjectileTracking = true,
    ProjectileTrackSpeed = 8,
    ProjectileMaxRange = 140,
    ProjectileHitRadius = 4.5,
    ProjectileSpreadAngle = 5,
    ProjectilePierceCount = 2,
    ProjectilesPerShot = 2,
    AnimationOverrides = {
        idle = "rbxassetid://90974298119945"
    }
};