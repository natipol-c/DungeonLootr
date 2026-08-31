--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Jetstream.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:48 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Jetstream",
    Description = "A high-speed cyborg swordsman with a high-frequency blade and jet-boost reflexes. Every strike is measured, every parry a declaration Let\'s dance.",
    Rarity = "Exotic",
    Summonable = false,
    IndexHidden = false,
    BaseStats = {
        STR = 14,
        DEX = 14,
        VIT = 12,
        INT = 0,
        LCK = 0
    },
    DamageType = "Physical",
    ForgeVFX = true,
    DamageMultiplier = 1.15,
    CritChance = 0.07,
    CritMultiplier = 1.7,
    AttackSpeed = 1,
    TurnCount = 4,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.3,
    Range = 25,
    HitboxSize = Vector3.new(20, 10, 25),
    DodgeVelocity = 90,
    DodgeDuration = 0.35,
    DodgeCooldown = 1.8,
    DodgeIFrameDuration = 0.75,
    ParryDuration = 0.65,
    ParryCooldown = 1.8,
    ParrySuccessCooldown = 0.5,
    Skills = { "Blade Flicker", "Rising Flicker", "Tempest Edge", "Jetstream Sheath" },
    UtilitySkill = "",
    SkillInfo = { {
            Description = "An instant spin draw-strike: three lightning-fast rotating cuts. The first two dash in the input direction, leaving red shadow clones. Parry active through the flurry.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "A near-instant forward snap-dash that erupts into a rapid four-hit slash barrage. Dodge frame covers the dash and the barrage.",
            TotalMultiplier = 4,
            Protection = "Dodge"
        }, {
            Description = "Plants and unleashes a stationary six-hit slash storm, finishing by sheathing the blade in a decisive cut. Dodge frame covers the full sequence.",
            TotalMultiplier = 4,
            Protection = "Dodge"
        }, {
            Description = "Dashes in the input direction and lands a single sheathe-draw slash of devastating power. Dodge frame covers the dash and the strike.",
            TotalMultiplier = 4,
            Protection = "Dodge"
        } },
    StationarySkills = { false, false, true, false },
    NoKnockbackSkills = { true, false, true, false },
    SwingSoundOrder = { "Electric_Swing", "Electric_Swing", "Electric_Fist", "Electric_Swing" },
    SwingSoundFolder = "Maewha",
    HitSoundFolder = "Hit",
    FX_Order = { "Right_Slash", "Left_Slash", "", "Right_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://89816005116992",
        run = "rbxassetid://78988120608596"
    }
};