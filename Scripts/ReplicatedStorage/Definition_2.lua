--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Founder.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Founder",
    Description = "The Monkey King reborn — a primordial sage hatched from heaven-and-earth stone, older than the world he walks. He wields the Ruyi Jingu Bang, a golden cudgel that shrinks to a needle or grows into a heaven-piercing pillar, crashing from the clouds, thrusting a thousandfold, and splitting into a legion of himself.",
    Rarity = "Exotic",
    Summonable = false,
    DamageType = "Physical",
    DamageMultiplier = 1.1,
    CritChance = 0.05,
    CritMultiplier = 1.5,
    AttackSpeed = 1,
    TurnCount = 5,
    ComboEndlag = 0.3,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.4,
    Range = 19,
    HitboxSize = Vector3.new(15, 10, 19),
    DodgeVelocity = 80,
    DodgeDuration = 0.3,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.6,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Wukong",
    HitSoundFolder = "Hit",
    ForgeVFX = true,
    BaseStats = {
        STR = 14,
        DEX = 4,
        VIT = 10,
        INT = 4,
        LCK = 8
    },
    Skills = { "Somersault Crash", "Thousandfold Thrust", "Pillar of Heaven", "Cyclone Sweep", "(Lv. 30 Passive) Body Outside the Body" },
    SkillInfo = {
        {
            Description = "Leap skyward on a somersault cloud and crash down in a wide 40-stud shockwave, dealing heavy single-hit damage. A parry frame guards the wind-up, and there\'s a 35% chance to instantly reset Skill 3\'s cooldown.",
            TotalMultiplier = 4,
            Protection = "Parry"
        },
        {
            Description = "A rapid six-hit thrusting barrage with the golden cudgel, stepping forward with each strike. Stationary and non-displacing — enemies stay pinned in the cone.",
            TotalMultiplier = 5
        },
        {
            Description = "Climb a swirling, heaven-piercing pillar — a parry frame guards the wind-up and dodge frames cover the ascent — then crash down in a towering slam for the kit\'s highest single-hit damage.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        },
        {
            Description = "Dash in on a whirling staff cyclone behind dodge frames, then sweep through three wide 30-stud strikes, stepping with your input each hit. 2 charges.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        },
        {
            Description = "Each skill cast has a 10% chance to pluck a hair and summon a clone in front of you that mirrors the exact same skill — same effects — for 70% of its damage."
        }
    },
    StationarySkills = { false, true, false, true },
    NoKnockbackSkills = {
        [2] = true
    },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash", "Right_Slash", "Side_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://129471067358090"
    }
};