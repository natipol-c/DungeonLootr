--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Chaotic Fist.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:58 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Chaotic Fist",
    Description = "A berserker who abandoned all defense, all cunning, all fortune and bet everything on the fist. Pure strength made manifest. When the heat rises, even chaos submits to the rhythm of his strikes.",
    Rarity = "Admin",
    Summonable = false,
    IndexHidden = true,
    BaseStats = {
        STR = 20,
        DEX = 0,
        VIT = 0,
        INT = 0,
        LCK = 0
    },
    DamageType = "Physical",
    DamageMultiplier = 1.1,
    CritChance = 0.03,
    CritMultiplier = 1.5,
    AttackSpeed = 1.1,
    TurnCount = 4,
    Range = 17,
    HitboxSize = Vector3.new(17, 10, 25),
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.3,
    DodgeVelocity = 80,
    DodgeDuration = 0.3,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.6,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UseHeat = true,
    HeatMax = 100,
    HeatPerHit = 2,
    HeatPerSkill = 10,
    HeatDecayDelay = 5,
    HeatDecayRate = 3,
    HeatBonuses = { {
            Stat = "CDR",
            Value = 0.2
        }, {
            Stat = "DamageMultiplier",
            Value = 0.4
        } },
    Skills = { "Air Type", "Annihilation Type", "8 Layered Demon Core", "Chaotic Blue Silver Afterglow", "(Lv. 13 Passive) Chaotic Counter" },
    UtilitySkill = "",
    SkillInfo = { {
            Description = "Leaps upward and backward with full invulnerability, then delivers two devastating strikes. Each hit scans a wide hitbox and fires three homing mana projectiles from projection points.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "A single devastating strike backed by full parry protection. Unleashes a shockwave explosion on impact.",
            TotalMultiplier = 3,
            Protection = "Parry"
        }, {
            Description = "A three-hit combo with duplicated strikes. Each hit dashes in the input direction and spawns shadow clones. The third hit detonates with amplified FX.",
            TotalMultiplier = 5
        }, {
            Description = "Channels destructive energy into a demon compass formation, then unleashes a relentless barrage of blue silver afterglow capped by a devastating 10× finisher."
        }, {
            Description = "On successful parry, automatically unleashes Annihilation Type without consuming cooldown or mana."
        } },
    ProjectileTracking = true,
    ProjectileTrackSpeed = 12,
    ProjectileMaxRange = 120,
    ProjectileHitRadius = 4,
    ProjectilePierceCount = 3,
    SwingSoundFolder = "Naoya_Punches",
    HitSoundFolder = "Hit",
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    NoKnockbackSkills = {
        [4] = true
    },
    AnimationOverrides = {
        idle = "rbxassetid://133312431516312"
    }
};