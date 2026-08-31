--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Dreadlord.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:55 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Dreadlord",
    Description = "A dread warrior who wields the Black Steel Sword with crushing force. Each swing carves a trail of blood, and the earth answers with underworld lightning.",
    Rarity = "Exotic",
    Summonable = false,
    BaseStats = {
        STR = 20,
        DEX = 0,
        VIT = 20,
        INT = 0,
        LCK = 0
    },
    DamageType = "Physical",
    DamageMultiplier = 1.15,
    CritChance = 0.04,
    CritMultiplier = 1.6,
    AttackSpeed = 1,
    TurnCount = 4,
    ComboEndlag = 0.3,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.1,
    Range = 25,
    HitboxSize = Vector3.new(20, 10, 29),
    DodgeVelocity = 80,
    DodgeDuration = 0.3,
    DodgeCooldown = 2.5,
    DodgeIFrameDuration = 0.6,
    ParryDuration = 0.65,
    ParryCooldown = 2,
    ParrySuccessCooldown = 0.6,
    Skills = { "Crimson Rush", "Dread Vortex", "Gravefall", "Rose Cataclysm" },
    UtilitySkill = "",
    SkillInfo = { {
            Description = "A heavy two-hit crimson assault. Each strike dashes in your current movement direction, leaving red shadow clones in its wake. Full invulnerability throughout.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Spins the Black Steel Sword in a colossal circle, carving a five-hit death vortex around the Dreadlord. Immune to knockback and protected by parry throughout the spin.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "A massive forward leap into a crashing overhead slam. The Black Steel Sword meets the earth with the fury of underworld thunder. Single devastating hit with extreme reach.",
            TotalMultiplier = 4
        }, {
            Description = "Charges the Black Steel Sword with underworld power, unleashing a devastating opening cleave before triggering five staggered explosions across the battlefield.",
            TotalMultiplier = 5
        } },
    StationarySkills = { false, false, false, true },
    NoKnockbackSkills = {
        [4] = true
    },
    SwingSoundFolder = "Flame_Swing",
    HitSoundFolder = "Hit",
    Motor6D_Overrides = {
        Handle = {
            Part0 = "Right Arm"
        }
    },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://72080662146225",
        run = "rbxassetid://116531531279085"
    }
};