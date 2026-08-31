--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Zero.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Zero",
    Description = "A void hunter whose frozen blade only ever leaves its sheath for a single perfect cut. Every drawn stroke falls like snow — quiet, absolute, already over.",
    Rarity = "Admin",
    Summonable = false,
    IndexHidden = true,
    DamageType = "Physical",
    DamageMultiplier = 1.15,
    CritChance = 0.06,
    CritMultiplier = 1.6,
    AttackSpeed = 1,
    TurnCount = 5,
    Range = 20,
    HitboxSize = Vector3.new(25, 20, 22),
    DodgeVelocity = 85,
    DodgeDuration = 0.35,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.7,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.7,
    ParryDuration = 0.75,
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
    Skills = { "Fuuka", "Kazahana", "Fuyubachi", "Hanafubuki", "(Lv. 13 Passive) Shimotsuki" },
    SkillInfo = {
        {
            Description = "Three charges. An invulnerable dash that cleaves everything in a wide arc across four cuts, trailing frozen afterimages. Cast airborne, altitude freezes for a flat air-dash.",
            TotalMultiplier = 5.2,
            Protection = "Dodge"
        },
        {
            Description = "Two charges. Tap: a blinding five-hit flurry, fully invulnerable, enemies aren\'t knocked back. Hold: launch skyward and hang suspended, landing a heavy strike as you rise.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        },
        {
            Description = "Two charges. On the ground: a backward dash with an active parry frame, answered by a single motion that lands as five afterimage slices. Cast in the air: lock in place mid-air and unleash a rapid twelve-hit frost flurry across a massive arc.",
            TotalMultiplier = 5,
            Protection = "Parry"
        },
        {
            Description = "Tap: a six-hit forward-spinning crescent with parry frames the whole way through. Hold: dash in and pin targets in a grinding frost vortex, ticking rapid damage into a devastating finisher.",
            TotalMultiplier = 7.2,
            Protection = "Parry"
        },
        {
            Description = "After dodging, the next basic attack within 3 seconds unleashes a lesser blossom flurry — a forward dash with three cuts at reduced damage and no parry protection."
        }
    },
    StationarySkills = { false, false, false, false },
    NoKnockbackSkills = { true, true },
    SwingSoundOrder = { "Corsair_A", "Power_Swing_Fast", "Corsair_A", "Power_Swing_Fast", "Corsair_A", "Power_Swing_Fast" },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://85228396447576",
        run = "rbxassetid://78988120608596"
    }
};