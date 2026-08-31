--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Hollow.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:00 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Hollow",
    Description = "A fire-forged shinobi who burned away his heart to survive. His Ascetic Blaze turns breath into flame and every strike into an execution — a blade dressed as a man.",
    Rarity = "Admin",
    Summonable = false,
    IndexHidden = true,
    BaseStats = {
        STR = 16,
        DEX = 14,
        VIT = 10,
        INT = 0,
        LCK = 0
    },
    DamageType = "Physical",
    ForgeVFX = true,
    DamageMultiplier = 1.15,
    CritChance = 0.07,
    CritMultiplier = 1.7,
    AttackSpeed = 1.1,
    TurnCount = 4,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.6,
    Range = 23,
    HitboxSize = Vector3.new(25, 12, 25),
    DodgeVelocity = 90,
    DodgeDuration = 0.32,
    DodgeCooldown = 1.6,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.6,
    ParryCooldown = 1.8,
    Skills = { "Flame Step", "Crescent Ember", "Ascetic Rite", "Inferno Drill" },
    UtilitySkill = "",
    SkillInfo = { {
            Description = "Blink-dash in your input direction and land a single blazing cross-slash of devastating power. A dodge frame covers the dash and the strike.",
            TotalMultiplier = 4,
            Protection = "Dodge"
        }, {
            Description = "A single forward crescent kick — a cartwheeling arc of flame that detonates on contact. A dodge frame covers the spin. Two charges.",
            TotalMultiplier = 4.5,
            Protection = "Dodge"
        }, {
            Description = "A stationary rite that strikes once with a burst of fire and calls forth a blazing clone to fight at your side for 10 seconds. A dodge frame covers the cast.",
            TotalMultiplier = 3,
            Protection = "Dodge"
        }, {
            Description = "Dash in and become a drill of fire — five grinding hits that hold the target in place. Parry frame throughout, with a 15% chance to reset Flame Step & Crescent Ember.",
            TotalMultiplier = 5,
            Protection = "Parry"
        } },
    StationarySkills = { false, false, true, false },
    NoKnockbackSkills = {
        [4] = true
    },
    SwingSoundFolder = "Naoya_Punches",
    SwingSoundOrder = { "Naoya_Punches", "Naoya_Punches", "Hard_Kick", "Hard_Kick" },
    HitSoundFolder = "Hit",
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Punch", "Left_Kick" },
    AnimationOverrides = {
        idle = "rbxassetid://115497589143818",
        run = "rbxassetid://136413112658607"
    }
};