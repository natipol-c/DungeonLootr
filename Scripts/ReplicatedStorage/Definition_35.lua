--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Sunless.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:00 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Sunless",
    Description = "A sovereign of the eclipse who fights with drawn steel and summoned shadow. Where the sun fails, its blade answers.",
    Rarity = "Admin",
    Summonable = false,
    IndexHidden = true,
    BaseStats = {
        STR = 0,
        DEX = 14,
        VIT = 10,
        INT = 16,
        LCK = 0
    },
    DamageType = "Magic",
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
    Skills = { "Eclipse Draw", "Umbral Rite", "Nightfall Onslaught", "Sunless Sovereign" },
    UtilitySkill = "",
    SkillInfo = { {
            Description = "Two charges. Dash in your input direction and land a single sheathe-draw slash of devastating power. A dodge frame covers the dash and the strike.",
            TotalMultiplier = 4,
            Protection = "Dodge"
        }, {
            Description = "A stationary summoning rite that strikes once with a burst of eclipse force. A dodge frame covers the cast.",
            TotalMultiplier = 4,
            Protection = "Dodge"
        }, {
            Description = "A four-hit onslaught swept through a massive arc, gathering shadow on the charge before the final crushing blow.",
            TotalMultiplier = 8,
            Protection = "Dodge"
        }, {
            Description = "Call down the sovereign of the sunless: a single, screen-shaking summon strike of overwhelming force over a huge area.",
            TotalMultiplier = 12,
            Protection = "Dodge"
        } },
    StationarySkills = { false, true, false, false },
    NoKnockbackSkills = {
        [3] = true
    },
    SwingSoundOrder = { "Maewha", "Maewha", "Maewha", "Maewha" },
    SwingSoundFolder = "Maewha",
    HitSoundFolder = "Hit",
    FX_Order = { "Right_Slash", "Left_Slash", "", "Right_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://89816005116992",
        run = "rbxassetid://78988120608596"
    }
};