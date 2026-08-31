--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Coyote.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Coyote",
    Description = "A lone predator who hunts from a distance, splitting into a spectral pack and answering every threat with a relentless storm of soul-fire. Calm until cornered then absolute.",
    Rarity = "Celestial",
    Summonable = false,
    IndexHidden = true,
    DamageType = "Ranged",
    DamageMultiplier = 1,
    CritChance = 0.09,
    CritMultiplier = 1.7,
    AttackSpeed = 0.95,
    TurnCount = 4,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.5,
    Range = 30,
    HitboxSize = Vector3.new(14, 10, 30),
    DodgeVelocity = 85,
    DodgeDuration = 0.3,
    DodgeCooldown = 1.5,
    DodgeIFrameDuration = 0.6,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Cero_Shoot",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 4,
        DEX = 16,
        VIT = 8,
        INT = 8,
        LCK = 6
    },
    Skills = { "Triple Fang", "Pack Hunt", "Howling Barrage", "Apex Predator" },
    SkillInfo = { {
            Description = "Three rapid shots, each carrying a directional dash and a trail of spectral clones. Dodge frame throughout. 3 charges.",
            TotalMultiplier = 13.5,
            Protection = "Dodge"
        }, {
            Description = "Tap: a blinding five-hit flurry, each strike trailing a blue spectral clone; fully invulnerable, enemies aren\'t knocked back. Hold: summon two spectral pack-mates that hunt alongside you. Shared 2 charges.",
            TotalMultiplier = 10,
            Protection = "Dodge"
        }, {
            Description = "Channels a sustained barrage of soul-fire that scorches everything ahead, raining damage every fraction of a second. Stationary commitment; enemies aren\'t knocked back.",
            TotalMultiplier = 12
        }, {
            Description = "Charges the gathered pack into a single annihilating field, saturating a vast area ahead with soul energy for the duration of the howl. Stationary; enemies aren\'t knocked back.",
            TotalMultiplier = 43
        } },
    StationarySkills = { false, false, true, true },
    NoKnockbackSkills = {
        [2] = true,
        [3] = true,
        [4] = true
    },
    FX_Order = { "Shot", "Shot", "Shot", "Shot" },
    AnimationOverrides = {
        idle = "rbxassetid://82837107921468"
    }
};