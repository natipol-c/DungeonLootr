--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Sinister Trigger.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Sinister Trigger",
    Description = "A relentless devil-hunter who fights with a pair of custom handguns and no restraint — chaining rapid crossfire, sliding breakdance sweeps, and airborne spins into one unbroken barrage. Style is survival.",
    Rarity = "Exotic",
    Summonable = true,
    IndexHidden = false,
    DamageType = "Ranged",
    DamageMultiplier = 1.8,
    CritChance = 0.1,
    CritMultiplier = 1.9,
    AttackSpeed = 1.05,
    TurnCount = 5,
    ComboEndlag = 0.12,
    Range = 35,
    HitboxSize = Vector3.new(27, 20, 38),
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.3,
    DodgeVelocity = 85,
    DodgeDuration = 0.35,
    DodgeCooldown = 1.8,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.25,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Revolver",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 8,
        DEX = 20,
        VIT = 6,
        INT = 6,
        LCK = 8
    },
    Skills = { "Crossfire", "Showstopper", "Rainstorm", "Hysteria", "(Lv. 50 Passive) Deadeye" },
    SkillInfo = {
        {
            Description = "A four-shot barrage with a directional dash and shadow clone on every shot. 3 charges. Dodge frame. Each cast has a 10% chance to enter an enhanced state — +30% damage and demon-charged rounds. Cast airborne for a diving gun-slam.",
            TotalMultiplier = 19.2,
            Protection = "Dodge"
        },
        {
            Description = "Tap to slide forward in a breakdance sweep, shredding everything in your path with rapid ticks under full parry. Hold to rise into a spinning tornado of shots instead. 10% chance on cast to instantly reset Rainstorm.",
            TotalMultiplier = 7.7
        },
        {
            Description = "Launch skyward and hang inverted, spinning as you rain rounds into the ground below. Frozen in place and invulnerable while the barrage rips. 15% chance on cast to instantly reset Showstopper.",
            TotalMultiplier = 8,
            Protection = "iFrame"
        },
        {
            Description = "Empty both magazines in a relentless seven-shot rapid fire, the final round hitting twice as hard. At 500+ combo it erupts into a nine-shot demon-charged variant for 45% more damage.",
            TotalMultiplier = 11.2
        },
        {
            Description = "Deadeye: basic AND gun-skill hits have a 50% chance to conjure phantom rounds above each struck enemy. After a brief delay, every round fires down for 190% damage. (Class Level 50)"
        }
    },
    StationarySkills = { false, true, true, false },
    NoKnockbackSkills = {
        [2] = true,
        [3] = true
    },
    FX_Order = { "Shot", "Demon_Shot", "Shot", "Demon_Shot", "Shot" },
    AnimationOverrides = {
        idle = "rbxassetid://129588233878835",
        run = "rbxassetid://136413112658607"
    }
};