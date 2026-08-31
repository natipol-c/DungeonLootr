--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Cursed Child.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:51 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Cursed Child",
    Description = "A cursed swordsman bound to a vengeful spirit, channeling overwhelming force through every strike.",
    Rarity = "Mythic",
    DamageType = "Physical",
    DamageMultiplier = 1.05,
    CritChance = 0.07,
    CritMultiplier = 1.7,
    AttackSpeed = 1,
    TurnCount = 5,
    Range = 18,
    HitboxSize = Vector3.new(15, 10, 18),
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.2,
    DodgeVelocity = 90,
    DodgeDuration = 0.35,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Corsair_A",
    HitSoundFolder = "Hit",
    ForgeVFX = true,
    BaseStats = {
        STR = 14,
        DEX = 9,
        VIT = 7,
        INT = 4,
        LCK = 6
    },
    Skills = { "Hollow Rush", "Severance", "Cursed Speech", "Cursed Love" },
    SkillInfo = { {
            Description = "Blink-dash in your input direction with dodge frames, opening on a strike then a rapid three-hit flurry that ends on a heavy finishing slash.",
            TotalMultiplier = 4.3,
            Protection = "Dodge"
        }, {
            Description = "Dash in your input direction and carve a devastating wide side slash. Pure aggression — no defensive frames. 3 charges.",
            TotalMultiplier = 4
        }, {
            Description = "Cursed speech — \"Don\'t Move.\" Command every enemy in a wide area to freeze in place, chaining and stunning them for a few seconds. Bosses resist the stun.",
            TotalMultiplier = 1.75
        }, {
            Description = "Channel a beam of cursed love, flooding a wide volume ahead with a torrent of rapid, high-damage ticks for over a second.",
            TotalMultiplier = 5
        } },
    StationarySkills = { false, true, true, true },
    NoKnockbackSkills = {
        [4] = true
    },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash", "Right_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://89768564509943"
    }
};