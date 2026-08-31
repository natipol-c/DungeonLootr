--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Kage.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Kage",
    Description = "A phantom operative who strikes from the boundary between magic and flesh. Every blow carries the weight of shadow some echo with arcane force, others land with raw, bone-crushing impact.",
    Rarity = "Legendary",
    Summonable = true,
    DamageType = "Physical",
    DamageMultiplier = 1,
    CritChance = 0.05,
    CritMultiplier = 1.5,
    AttackSpeed = 1,
    TurnCount = 4,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2,
    Range = 17,
    HitboxSize = Vector3.new(15, 15, 17),
    DodgeVelocity = 80,
    DodgeDuration = 0.3,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.6,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Magic_Swings",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 10,
        DEX = 10,
        VIT = 4,
        INT = 10,
        LCK = 0
    },
    Skills = { "Shadow Step", "Heart Stab", "Devouring Gale", "Fists of Ruin", "(Lv. 13 Passive) Shadow Pursuit" },
    SkillInfo = { {
            Description = "Vanishes and reappears behind the nearest enemy with a devastating strike. Shadow clones at cast and exit. 3 charges. Dodge frame.",
            TotalMultiplier = 3.5,
            Protection = "Dodge"
        }, {
            Description = "Warps behind the nearest enemy and delivers a double strike, then chains to up to 3 additional targets above 20% HP. Shadow clones between each teleport.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "A wide spinning circular strike that cleaves everything nearby. Parry frame on the first hit.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "An unstoppable twenty-four-hit barrage of fists capped by a devastating final blow. Shadow clones every other hit. Parry throughout.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "On dodge, automatically casts Shadow Step at full damage behind the nearest enemy. No charge consumed, on a short internal cooldown."
        } },
    SwingSoundOrder = { "Magic_Swings", "Magic_Swings", "New_Punch", "New_Punch" },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    NoKnockbackSkills = {
        [3] = true
    },
    AnimationOverrides = {
        idle = "rbxassetid://124270295444984"
    }
};