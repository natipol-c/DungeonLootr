--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Spell Breaker.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Spell Breaker",
    Description = "A sword-mage who answers overwhelming magic with relentless steel every strike rushes, rises, and accelerates beyond sight.",
    Rarity = "Admin",
    IndexHidden = true,
    DamageType = "Physical",
    DamageMultiplier = 1.15,
    CritChance = 0.05,
    CritMultiplier = 1.6,
    AttackSpeed = 1,
    TurnCount = 6,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.8,
    Range = 23,
    HitboxSize = Vector3.new(20, 20, 25),
    DodgeVelocity = 90,
    DodgeDuration = 0.3,
    DodgeCooldown = 1.8,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.6,
    ParryCooldown = 2,
    ParrySuccessCooldown = 0.6,
    UtilitySkill = "",
    SwingSoundFolder = "Ninja",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 13,
        DEX = 13,
        VIT = 14,
        INT = 0,
        LCK = 0
    },
    Skills = { "Rushing Edge", "Rising Tempest", "Blade Flurry", "Hypersonic Rush" },
    SkillInfo = { {
            Description = "Three charges. Dash in your input direction into a rapid three-hit rush capped by a spinning heavy kick. A mid-combo dodge grants a brief invulnerability window.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Two charges. On the ground, a rising tornado of three spinning strikes that lifts you skyward. Cast airborne, a diving downward strike instead.",
            TotalMultiplier = 5
        }, {
            Description = "A blistering four-hit sword combo, each strike dashing you forward in your input direction.",
            TotalMultiplier = 5
        }, {
            Description = "Commit in place and shred everything ahead with a hyper-speed multi-hit flurry, ticking rapid damage. Enemies can\'t be knocked out of it.",
            TotalMultiplier = 5
        } },
    StationarySkills = { false, false, false, true },
    NoKnockbackSkills = {
        [2] = true,
        [3] = true,
        [4] = true
    },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://128065084237704"
    }
};