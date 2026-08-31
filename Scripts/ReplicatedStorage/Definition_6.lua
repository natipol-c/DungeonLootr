--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Divergent.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:46 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Divergent",
    Description = "A brawler who channels cursed energy through raw physical prowess. Every strike lands with unshakable conviction fists, kicks, and the fabled Black Flash.",
    Rarity = "Mythic",
    DamageType = "Physical",
    DamageMultiplier = 1.1,
    CritChance = 0.09,
    CritMultiplier = 1.5,
    AttackSpeed = 1,
    TurnCount = 4,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.3,
    Range = 15,
    HitboxSize = Vector3.new(15, 15, 15),
    DodgeVelocity = 85,
    DodgeDuration = 0.35,
    DodgeCooldown = 2.5,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.65,
    ParryCooldown = 2,
    ParrySuccessCooldown = 0.7,
    UtilitySkill = "",
    SwingSoundFolder = "Naoya_Punches",
    HitSoundFolder = "Hit",
    ForgeVFX = true,
    BaseStats = {
        STR = 15,
        DEX = 1,
        VIT = 10,
        INT = 7,
        LCK = 1
    },
    Skills = { "Tri-Step", "Triple Kick", "Black Flash", "Black Flash Combo", "(Lv. 13 Passive) Flash Proc" },
    SkillInfo = { {
            Description = "Three charges. Gain dodge frames on cast, then step through three quick strikes across a wide reach. 25% chance on use to instantly ready Black Flash.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Step in and unleash a rapid three-kick combo across a wide hitbox. Pure offense, low cooldown. 35% chance on use to instantly ready Black Flash.",
            TotalMultiplier = 5
        }, {
            Description = "Channels cursed energy into a single Black Flash strike. Extreme damage, no protection.",
            TotalMultiplier = 4
        }, {
            Description = "A seven-hit brawler combo capped by a devastating Black Flash finisher.",
            TotalMultiplier = 5
        }, {
            Description = "Critical hits have a 50% chance to instantly trigger a lesser Black Flash same impact and hitbox at reduced damage. 3-second cooldown."
        } },
    NoKnockbackSkills = {
        [1] = true,
        [2] = true,
        [4] = true
    },
    StationarySkills = { true, true },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://82921578624086"
    }
};