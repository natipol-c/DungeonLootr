--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Weapon_Data
  Path:     game.ReplicatedStorage.Weapons.Weapon_Data
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Weapon_Callbacks = require(ReplicatedStorage.Weapons.Weapon_Callbacks);
local u2 = {
    Rarity = "Common",
    Knockback = 20,
    CritChance = 0.05,
    CritMultiplier = 1.5,
    TurnCount = 4,
    AttackSpeed = 1,
    DodgeVelocity = 55,
    DodgeDuration = 0.2,
    DodgeCooldown = 2,
    SwingSoundFolder = "Sword_Swings",
    HitSound = "Hit",
    SwingVolume = 1,
    HitVolume = 1,
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" }
};

local function makeWeapon(p3) -- Line: 39
    -- upvalues: u2 (copy)
    local v4 = {};

    for i, v in u2 do
        if type(v) == "table" then
            v4[i] = table.clone(v);
        else
            v4[i] = v;
        end;
    end;

    for i, v in p3 do
        v4[i] = v;
    end;

    return v4;
end;

v1.Katana = makeWeapon({
    Damage = 15,
    PVP_Damage = 8,
    Range = 12,
    HitboxSize = Vector3.new(10, 10, 12),
    TurnCount = 4,
    AttackSpeed = 1,
    Skill = "Flurry",
    SkillCooldown = 10,
    OnHit = Weapon_Callbacks.Katana.OnHit,
    OnSwing = Weapon_Callbacks.Katana.OnSwing
});
v1["Dual Katana"] = makeWeapon({
    Damage = 13,
    PVP_Damage = 8,
    Range = 12,
    HitboxSize = Vector3.new(11, 10, 12),
    TurnCount = 3,
    AttackSpeed = 1.1,
    SwingVolume = 0.4,
    Skill = "Flurry",
    SkillCooldown = 10,
    FX_Order = { "Right_Slash", "Left_Slash", "Center_Slash" }
});
v1["Assassin Dagger"] = makeWeapon({
    Rarity = "Uncommon",
    Damage = 16,
    PVP_Damage = 8,
    Range = 10,
    HitboxSize = Vector3.new(11, 10, 10),
    TurnCount = 3,
    AttackSpeed = 1.1,
    DodgeCooldown = 0.9,
    SwingSoundFolder = "Magic_Swings",
    SwingVolume = 0.4,
    Skill = "Tsujigiri",
    SkillCooldown = 5,
    FX_Order = { "Right_Slash", "Reverse_Slash", "Random_Slash" }
});
v1["Hunter Daggers"] = makeWeapon({
    Rarity = "Uncommon",
    Damage = 18,
    PVP_Damage = 8,
    Range = 10,
    HitboxSize = Vector3.new(11, 10, 10),
    TurnCount = 5,
    AttackSpeed = 1.3,
    DodgeCooldown = 0.9,
    SwingSoundFolder = "Magic_Swings",
    SwingVolume = 0.4,
    Skill = "Flurry",
    SkillCooldown = 5,
    FX_Order = { "Right_Slash", "Reverse_Slash", "Right_Slash", "Right_Slash", "Reverse_Slash" }
});
v1.Bow = makeWeapon({
    Damage = 20,
    PVP_Damage = 7,
    Range = 18,
    HitboxSize = Vector3.new(10, 10, 18),
    TurnCount = 3,
    DodgeCooldown = 1,
    SwingSoundFolder = "Regular_Bow_Shots",
    FX_Order = { "BowSlash", "BowSlash", "BowSlash" }
});
v1["Dual Gun"] = makeWeapon({
    Rarity = "Rare",
    Damage = 20,
    PVP_Damage = 7,
    Range = 19,
    HitboxSize = Vector3.new(10, 10, 19),
    TurnCount = 3,
    AttackSpeed = 1.5,
    DodgeCooldown = 1,
    SwingSoundFolder = "Pistol_Shot",
    SwingVolume = 0.8,
    HitVolume = 0.8,
    FX_Order = { "RightShot", "RightShot", "RightShot" }
});
v1.Tsurugi = makeWeapon({
    Rarity = "Rare",
    Damage = 25,
    PVP_Damage = 7,
    Range = 10,
    HitboxSize = Vector3.new(11, 10, 10),
    AttackSpeed = 0.85,
    SwingSoundFolder = "Flame_Swing",
    SwingVolume = 0.4,
    Skill = "Tsujigiri",
    SkillCooldown = 7
});
v1["Monkey Staff"] = makeWeapon({
    Rarity = "Rare",
    Damage = 23,
    PVP_Damage = 8,
    Range = 14,
    HitboxSize = Vector3.new(11, 10, 14),
    AttackSpeed = 0.9,
    TurnCount = 4,
    SwingSoundFolder = "Flame_Swing",
    SwingVolume = 0.4,
    Skill = "Flurry",
    SkillCooldown = 10
});
v1["Lightning Fist"] = makeWeapon({
    Rarity = "Rare",
    Damage = 20,
    PVP_Damage = 7,
    Range = 13,
    HitboxSize = Vector3.new(14, 12, 14),
    TurnCount = 2,
    AttackSpeed = 1.7,
    SwingSoundFolder = "Flame_Swing",
    SwingVolume = 0.4,
    HitVolume = 1,
    Skill = "Flurry",
    SkillCooldown = 7,
    FX_Order = { "Left_Slash", "Right_Slash" }
});
v1.Polearm = makeWeapon({
    Rarity = "Rare",
    Damage = 28,
    PVP_Damage = 10,
    Range = 14,
    HitboxSize = Vector3.new(11, 10, 14),
    AttackSpeed = 1.2,
    SwingSoundFolder = "Flame_Swing",
    SwingVolume = 0.4,
    Skill = "Tsujigiri",
    SkillCooldown = 10
});
v1["Lionheart Sword"] = makeWeapon({
    Rarity = "Epic",
    Damage = 32,
    PVP_Damage = 9,
    Range = 14,
    HitboxSize = Vector3.new(11, 10, 14),
    AttackSpeed = 1.3,
    DodgeCooldown = 1.6,
    SwingSoundFolder = "Flame_Swing",
    SwingVolume = 0.4
});
v1.Chainsaws = makeWeapon({
    Rarity = "Epic",
    Damage = 26,
    PVP_Damage = 8,
    Range = 13,
    HitboxSize = Vector3.new(13, 10, 13),
    AttackSpeed = 1.5,
    SwingSoundFolder = "Chainsaw",
    SwingVolume = 0.4,
    Skill = "Flurry",
    SkillCooldown = 5,
    FX_Order = { "Right_Slash", "Left_Slash", "Random_Slash", "Random_Slash" }
});
v1["Bomb Touch"] = makeWeapon({
    Rarity = "Epic",
    Damage = 28,
    PVP_Damage = 9,
    Range = 22,
    HitboxSize = Vector3.new(10, 10, 22),
    TurnCount = 5,
    AttackSpeed = 1.3,
    SwingSoundFolder = "Bow_Shot",
    SwingVolume = 0.5,
    HitVolume = 0.5,
    FX_Order = { "BowSlash", "BowSlash", "BowSlash", "BowSlash", "Tsar" }
});
v1["Waterfall Katana"] = makeWeapon({
    Rarity = "Epic",
    Damage = 35,
    PVP_Damage = 8,
    Range = 16,
    HitboxSize = Vector3.new(13, 10, 16),
    TurnCount = 4,
    AttackSpeed = 1.3,
    SwingSoundFolder = "Water_Swings",
    SwingVolume = 0.8,
    HitVolume = 0.5,
    Skill = "Tsujigiri",
    SkillCooldown = 5
});
v1.Mistblade = makeWeapon({
    Rarity = "Legendary",
    Damage = 32,
    PVP_Damage = 8,
    Range = 17,
    HitboxSize = Vector3.new(11, 10, 17),
    SwingSoundFolder = "Water_Swings",
    TurnCount = 4,
    AttackSpeed = 1.6,
    DodgeCooldown = 1.7,
    Skill = "Judgement",
    SkillCooldown = 15
});
v1.Buster = makeWeapon({
    Rarity = "Epic",
    Damage = 42,
    PVP_Damage = 15,
    Range = 13,
    HitboxSize = Vector3.new(11, 10, 13),
    AttackSpeed = 0.5,
    SwingSoundFolder = "Flame_Swing",
    Skill = "Tsujigiri",
    SkillCooldown = 12,
    SwingVolume = 0.4
});
v1["Wolf Katana"] = makeWeapon({
    Rarity = "Legendary",
    Damage = 34,
    PVP_Damage = 7,
    Range = 14,
    HitboxSize = Vector3.new(11, 10, 14),
    TurnCount = 4,
    AttackSpeed = 1.6,
    SwingSoundFolder = "Flame_Swing",
    Skill = "Flurry",
    SkillCooldown = 11,
    SwingVolume = 0.4
});
v1["Flaming Spear"] = makeWeapon({
    Rarity = "Epic",
    Damage = 33,
    PVP_Damage = 8,
    Range = 16,
    HitboxSize = Vector3.new(10, 10, 16),
    TurnCount = 5,
    AttackSpeed = 1,
    SwingSoundFolder = "Flame_Swing",
    SwingVolume = 0.5,
    HitVolume = 0.5,
    Skill = "Flurry",
    SkillCooldown = 8,
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Right_Slash", "Random_Slash" }
});
v1["Phoenix Fans"] = makeWeapon({
    Rarity = "Legendary",
    Damage = 35,
    PVP_Damage = 9,
    Range = 16,
    HitboxSize = Vector3.new(15, 10, 16),
    TurnCount = 4,
    AttackSpeed = 1.2,
    SwingSoundFolder = "Flame_Swing",
    SwingVolume = 0.5,
    HitVolume = 0.5,
    Skill = "Flurry",
    SkillCooldown = 8
});
v1["Great Mage Staff"] = makeWeapon({
    Rarity = "Legendary",
    Damage = 33,
    PVP_Damage = 9,
    Range = 20,
    HitboxSize = Vector3.new(10, 10, 20),
    TurnCount = 4,
    AttackSpeed = 1,
    SwingSoundFolder = "Ice_Magic",
    SwingVolume = 0.5,
    HitVolume = 0.5,
    Skill = "Magic Barrage",
    SkillCooldown = 20,
    AnimationOverrides = {
        idle = "rbxassetid://138009009504715"
    }
});
v1["Chain Dagger"] = makeWeapon({
    Rarity = "Mythic",
    Damage = 40,
    PVP_Damage = 9,
    Range = 17,
    HitboxSize = Vector3.new(12, 10, 17),
    AttackSpeed = 1.1,
    SwingSoundFolder = "Chain_Swing",
    Skill = "Tsujigiri",
    SkillCooldown = 6,
    FX_Order = {},
    Motor6D_Overrides = {
        Dagger = {
            Part0 = "Right Arm"
        }
    }
});
v1["Umbral Rapier"] = makeWeapon({
    Rarity = "Mythic",
    Damage = 40,
    PVP_Damage = 8,
    Range = 17,
    HitboxSize = Vector3.new(12, 10, 17),
    DodgeCooldown = 1.3,
    AttackSpeed = 1.2,
    SwingSoundFolder = "Magic_Swings",
    Skill = "Tsujigiri",
    SkillCooldown = 6,
    Motor6D_Overrides = {
        Motor6D = {
            Part0 = "Right Arm"
        }
    }
});
v1["Azure Dragon"] = makeWeapon({
    Rarity = "Mythic",
    Damage = 42,
    PVP_Damage = 9,
    Range = 13,
    HitboxSize = Vector3.new(14, 12, 13),
    AttackSpeed = 1.3,
    SwingSoundFolder = "Flame_Swing",
    DodgeCooldown = 1.6,
    SwingVolume = 0.4,
    HitVolume = 1,
    Skill = "Tsujigiri",
    SkillCooldown = 7
});
v1["Demonic Warblades"] = makeWeapon({
    Rarity = "Legendary",
    Damage = 40,
    PVP_Damage = 8,
    Range = 13,
    HitboxSize = Vector3.new(11, 10, 13),
    AttackSpeed = 1.5,
    SwingSoundFolder = "Flame_Swing",
    SwingVolume = 0.4,
    FX_Order = { "Right_Slash", "Left_Slash", "Random_Slash", "Random_Slash" }
});
v1["Ice Magic"] = makeWeapon({
    Rarity = "Epic",
    Damage = 35,
    PVP_Damage = 7,
    Range = 18,
    HitboxSize = Vector3.new(10, 10, 18),
    TurnCount = 2,
    AttackSpeed = 1.2,
    SwingSoundFolder = "Ice_Magic",
    SwingVolume = 0.5,
    HitVolume = 0.5,
    FX_Order = { "Left_Slash", "Right_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://138009009504715"
    }
});
v1["Cursed Hand"] = makeWeapon({
    Rarity = "Celestial",
    Damage = 55,
    PVP_Damage = 9,
    Range = 16,
    HitboxSize = Vector3.new(14, 12, 16),
    AttackSpeed = 1.2,
    SwingSoundFolder = "Magic_Swings",
    SwingVolume = 0.5,
    HitVolume = 0.5,
    FX_Order = { "Slash1", "Slash1", "Slash1", "Slash2" }
});
v1["Blazing Katana"] = makeWeapon({
    Rarity = "Legendary",
    Damage = 36,
    PVP_Damage = 8,
    Range = 16,
    HitboxSize = Vector3.new(10, 10, 16),
    TurnCount = 4,
    AttackSpeed = 1.2,
    SwingSoundFolder = "Flame_Swing",
    SwingVolume = 0.8,
    HitVolume = 0.5,
    Skill = "Tsujigiri",
    SkillCooldown = 5
});
v1["Tenka Kokin"] = makeWeapon({
    Rarity = "Mythic",
    Damage = 43,
    PVP_Damage = 9,
    Range = 16,
    HitboxSize = Vector3.new(10, 10, 16),
    TurnCount = 3,
    AttackSpeed = 1.3,
    SwingSoundFolder = "Magic_Swings",
    SwingVolume = 0.8,
    HitVolume = 0.5,
    DodgeCooldown = 1.7,
    Skill = "Tenka Gyakusei",
    SkillCooldown = 7
});
v1["Flaming Fist"] = makeWeapon({
    Rarity = "Legendary",
    Damage = 42,
    PVP_Damage = 9,
    Range = 14,
    HitboxSize = Vector3.new(14, 12, 14),
    AttackSpeed = 1,
    SwingSoundFolder = "Flame_Swing",
    SwingVolume = 0.4,
    HitVolume = 1,
    Skill = "Flurry",
    SkillCooldown = 7,
    FX_Order = { "Left_Slash", "Right_Slash", "Right_Slash", "Right_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://131172667964774"
    }
});
v1["Darkflame Fist"] = makeWeapon({
    Rarity = "Mythic",
    Damage = 40,
    PVP_Damage = 8,
    Range = 14,
    HitboxSize = Vector3.new(14, 12, 14),
    TurnCount = 5,
    AttackSpeed = 1.2,
    SwingSoundFolder = "Flame_Swing",
    SwingVolume = 0.4,
    HitVolume = 1,
    Skill = "Tsujigiri",
    SkillCooldown = 6,
    FX_Order = { "Left_Slash", "Right_Slash", "Right_Slash", "Right_Slash", "Right_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://127550176984868"
    }
});
v1["Tenrai Kojin"] = makeWeapon({
    Rarity = "Mythic",
    Damage = 38,
    PVP_Damage = 9,
    Range = 17,
    HitboxSize = Vector3.new(15, 15, 17),
    SwingSoundFolder = "Water_Swings",
    TurnCount = 4,
    AttackSpeed = 1.7,
    DodgeCooldown = 1.7,
    Skill = "Judgement",
    SkillCooldown = 15
});
v1["Korin Zangetsu"] = makeWeapon({
    Rarity = "Legendary",
    Damage = 40,
    PVP_Damage = 12,
    Range = 13,
    HitboxSize = Vector3.new(11, 10, 13),
    AttackSpeed = 1.2,
    SwingSoundFolder = "Flame_Swing",
    Skill = "Tsujigiri",
    SkillCooldown = 8,
    SwingVolume = 0.4
});
v1["Dragon Gauntlets"] = makeWeapon({
    Rarity = "Celestial",
    Damage = 48,
    PVP_Damage = 8,
    Range = 14,
    HitboxSize = Vector3.new(14, 12, 14),
    TurnCount = 5,
    AttackSpeed = 1.1,
    SwingSoundFolder = "Magic_Swings",
    SwingVolume = 0.4,
    HitVolume = 1,
    Skill = "Flurry",
    SkillCooldown = 5,
    FX_Order = { "Left_Slash", "Right_Slash", "Left_Slash", "Right_Slash", "Right_Slash" }
});
v1["Chaos Scythe"] = makeWeapon({
    Rarity = "Legendary",
    Damage = 37,
    PVP_Damage = 9,
    Range = 15,
    HitboxSize = Vector3.new(16, 12, 15),
    AttackSpeed = 1.4,
    SwingSoundFolder = "Magic_Swings",
    SwingVolume = 0.5,
    HitVolume = 0.5
});
v1["Frost Axe"] = makeWeapon({
    Rarity = "Epic",
    Damage = 42,
    PVP_Damage = 8,
    Range = 10,
    HitboxSize = Vector3.new(13, 10, 10),
    AttackSpeed = 1.1,
    SwingSoundFolder = "Magic_Swings"
});
v1["Demon Daggers"] = makeWeapon({
    Rarity = "Celestial",
    Damage = 50,
    PVP_Damage = 9,
    Range = 15,
    HitboxSize = Vector3.new(13, 10, 15),
    SwingSoundFolder = "Magic_Swings",
    DodgeCooldown = 1.6,
    Skill = "Rolling Slice",
    SkillCooldown = 10,
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Cross_Slash" }
});
v1["Cursed Blade"] = makeWeapon({
    Rarity = "Celestial",
    Damage = 55,
    PVP_Damage = 9,
    Range = 14,
    HitboxSize = Vector3.new(10, 12, 14),
    TurnCount = 4,
    AttackSpeed = 1.1,
    SwingSoundFolder = "Magic_Swings",
    SwingVolume = 0.5,
    HitVolume = 0.5,
    AnimationOverrides = {
        idle = "rbxassetid://101372247901723"
    }
});
v1.Yamato = makeWeapon({
    Rarity = "Celestial",
    Damage = 50,
    PVP_Damage = 8,
    Range = 15,
    HitboxSize = Vector3.new(13, 10, 15),
    TurnCount = 4,
    AttackSpeed = 1.1,
    DodgeCooldown = 1.3,
    SwingSoundFolder = "Magic_Swings",
    Skill = "Judgement",
    SkillCooldown = 12,
    OnHit = Weapon_Callbacks.Yamato.OnHit,
    OnSwing = Weapon_Callbacks.Yamato.OnSwing,
    OnSwingEnd = Weapon_Callbacks.Yamato.OnSwingEnd
});
v1.Masamune = makeWeapon({
    Rarity = "Admin",
    Damage = 50,
    PVP_Damage = 9,
    Range = 15,
    HitboxSize = Vector3.new(13, 10, 15),
    TurnCount = 4,
    AttackSpeed = 1.4,
    DodgeCooldown = 1,
    SwingSoundFolder = "Magic_Swings",
    Skill = "Judgement",
    SkillCooldown = 7
});
v1.Kinsatsu = makeWeapon({
    Rarity = "Admin",
    Damage = 50,
    PVP_Damage = 9,
    Range = 15,
    HitboxSize = Vector3.new(13, 10, 15),
    TurnCount = 3,
    AttackSpeed = 1.4,
    DodgeCooldown = 0.8,
    SwingSoundFolder = "Magic_Swings",
    Skill = "Shadow Dash",
    SkillCooldown = 9
});
v1["Heavens Bow"] = makeWeapon({
    Rarity = "Celestial",
    Damage = 48,
    PVP_Damage = 8,
    Range = 20,
    HitboxSize = Vector3.new(10, 10, 20),
    TurnCount = 6,
    AttackSpeed = 1.3,
    SwingSoundFolder = "Bow_Shot",
    Skill = "Arrow Rain",
    SkillCooldown = 15,
    FX_Order = { "Shot_1", "Shot_2", "Shot_3", "Shot_2", "Shot_1", "Shot_2" },
    AnimationOverrides = {
        idle = "rbxassetid://138009009504715"
    }
});
v1["Coyote Pistols"] = makeWeapon({
    Rarity = "Celestial",
    Damage = 50,
    PVP_Damage = 9,
    Range = 20,
    HitboxSize = Vector3.new(10, 10, 20),
    TurnCount = 5,
    AttackSpeed = 1.1,
    SwingSoundFolder = "Bow_Shot",
    Skill = "Coyote Barrage",
    SkillCooldown = 25,
    FX_Order = { "Left_Slash", "Right_Slash", "Shoot_1", "Shoot_1", "Shoot_1" }
});
v1["Lucky Revolvers"] = makeWeapon({
    Rarity = "Legendary",
    Damage = 34,
    PVP_Damage = 8,
    Range = 23,
    HitboxSize = Vector3.new(10, 10, 23),
    TurnCount = 5,
    AttackSpeed = 1.35,
    DodgeCooldown = 1.3,
    SwingSoundFolder = "Gun_Shots",
    Skill = "Slide Shootin",
    SkillCooldown = 7,
    FX_Order = { "Right_Shot", "Left_Shot", "DoubleShot", "DoubleShot" },
    AnimationOverrides = {
        idle = "rbxassetid://127550176984868"
    }
});
v1["Wicked Fair"] = makeWeapon({
    Rarity = "Celestial",
    Damage = 50,
    PVP_Damage = 10,
    Range = 23,
    HitboxSize = Vector3.new(10, 10, 23),
    TurnCount = 5,
    AttackSpeed = 1.3,
    DodgeCooldown = 1.1,
    SwingSoundFolder = "Gun_Shots",
    Skill = "Wicked Flair",
    SkillCooldown = 7,
    FX_Order = { "Left_Shot", "0", "0", "0", "0" },
    AnimationOverrides = {
        idle = "rbxassetid://127550176984868"
    }
});
v1["Frozen Staff"] = makeWeapon({
    Rarity = "Epic",
    Damage = 35,
    PVP_Damage = 9,
    Range = 15,
    HitboxSize = Vector3.new(15, 10, 15),
    SwingSoundFolder = "Ice_Magic",
    FX_Order = { "FrosteFury", "FrostExplosion", "FrosteFury", "FrostExplosion2" },
    AnimationOverrides = {
        idle = "rbxassetid://138009009504715"
    }
});
v1["Golden Crescent Horn"] = makeWeapon({
    Rarity = "Exotic",
    Damage = 60,
    PVP_Damage = 10,
    Range = 18,
    HitboxSize = Vector3.new(18, 20, 18),
    TurnCount = 5,
    AttackSpeed = 1,
    DodgeCooldown = 1.5,
    SwingSoundFolder = "Flame_Swing",
    Skill = "Tenka Gyakusei",
    SkillCooldown = 7
});

return v1;