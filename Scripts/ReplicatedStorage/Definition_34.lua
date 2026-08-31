--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Mori.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:00 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Mori",
    Description = "A prodigy martial artist who answers every fight head-on, chaining renewal kicks into crashing talon strikes and calling on a roaring dragon\'s might. Unshakable, overwhelming, all-out.",
    Rarity = "Exotic",
    Summonable = false,
    IndexHidden = true,
    DamageType = "Physical",
    DamageMultiplier = 1.15,
    CritChance = 0.07,
    CritMultiplier = 1.8,
    AttackSpeed = 1.05,
    TurnCount = 4,
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
    SwingSoundFolder = "Short_Punches",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 15,
        DEX = 11,
        VIT = 6,
        INT = 3,
        LCK = 5
    },
    Skills = { "Crashing Talon", "Renewal Flurry", "Twin Dragons", "Hundred Kicks", "(Lv. 30 Passive) Relentless" },
    SkillInfo = { {
            Description = "Dash in your input direction and drive a single crushing talon strike home, trailing blue after-images. Dodge frame on cast.",
            TotalMultiplier = 4,
            Protection = "Dodge"
        }, {
            Description = "A rooted three-hit renewal combo, each strike carrying a short directional step — the final blow lands with double the force. 40% chance on use to instantly ready Crashing Talon. 2 charges.",
            TotalMultiplier = 5
        }, {
            Description = "Unleash a two-hit dragon assault across a huge forward reach, the second blow erupting with a roaring finish.",
            TotalMultiplier = 5
        }, {
            Description = "Plant and rip a rapid flurry of kicks, then close with one heavy finishing kick.",
            TotalMultiplier = 5
        }, {
            Description = "Every skill you cast has a 20% chance to instantly reset its own cooldown."
        } },
    StationarySkills = {
        [2] = true,
        [4] = true
    },
    NoKnockbackSkills = {
        [4] = true
    },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://115497589143818",
        run = "rbxassetid://136413112658607"
    }
};