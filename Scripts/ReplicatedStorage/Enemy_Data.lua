--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Enemy_Data
  Path:     game.ReplicatedStorage.GameInfo.Enemy_Data
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    WalkAnim = "rbxassetid://122199389926212",
    RunAnim = "rbxassetid://122199389926212",
    IdleAnim = "rbxassetid://72402887392404",
    DeadAnim = "",
    AttackAnims = { "rbxassetid://135574878267886", "rbxassetid://98156227119234", "rbxassetid://114297885360212", "rbxassetid://131310982008669" }
};

local function E(p2, p3, p4, p5) -- Line: 49
    -- upvalues: u1 (copy)
    local v6 = {
        Rarity = "Enemy",
        Info = {
            Income = 0,
            Price = 0
        },
        Damage = p2 * 1.5,
        Health = p3 * 1.5,
        WalkSpeed = p4
    };

    for i, v in u1 do
        if type(v) == "table" then
            v6[i] = table.clone(v);
        else
            v6[i] = v;
        end;
    end;

    if p5 then
        for i, v in p5 do
            v6[i] = v;
        end;
    end;

    return v6;
end;

local v7 = {
    Bandit = E(6, 200, 16),
    Rogue = E(4, 190, 20, {
        AttackCooldown = 0.8,
        AnimationSet = "Daggers"
    }),
    Archer = E(
        8,
        160,
        14,
        {
            AnimationSet = "Bow",
            Archetype = "Ranged",
            ProjectileId = "Arrow",
            ProjectileSpeed = 105,
            ProjectileArc = 0,
            PreferredRange = 30,
            RetreatRange = 12
        }
    ),
    ["Strong Bandit"] = E(8, 290, 14, {
        Archetype = "Armored"
    }),
    ["Bandit Chief"] = E(
        15,
        1500,
        16,
        {
            AttackCooldown = 0.9,
            WalkAnim = "rbxassetid://110039686734119",
            RunAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://72080662146225"
        }
    ),
    Goblin = E(10, 450, 16),
    ["Goblin Rogue"] = E(8, 340, 20, {
        AttackCooldown = 0.8,
        AnimationSet = "Daggers"
    }),
    ["Goblin Shaman"] = E(
        12,
        300,
        14,
        {
            AnimationSet = "Mage",
            Archetype = "Caster",
            PreferredRange = 38,
            AttackCooldown = 5,
            Spells = { "GroupHeal", "WardBarrier", "MeteorZones" }
        }
    ),
    ["Strong Goblin"] = E(12, 650, 14, {
        Archetype = "Armored"
    }),
    ["Goblin Chief"] = E(20, 4000, 16, {
        AttackCooldown = 0.9,
        WalkAnim = "rbxassetid://110039686734119"
    }),
    Knight = E(16, 750, 16),
    ["Knight Rogue"] = E(14, 640, 20, {
        AttackCooldown = 0.8,
        AnimationSet = "Daggers"
    }),
    ["Knight Archer"] = E(
        22,
        500,
        14,
        {
            AnimationSet = "Bow",
            Archetype = "Ranged",
            ProjectileId = "Arrow",
            ProjectileSpeed = 105,
            ProjectileArc = 0,
            PreferredRange = 30,
            RetreatRange = 12
        }
    ),
    ["Strong Knight"] = E(18, 1100, 14, {
        Archetype = "Armored"
    }),
    ["Knight Lord"] = E(
        26,
        10000,
        16,
        {
            AttackCooldown = 0.9,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://72080662146225"
        }
    ),
    ["Bone Soldier"] = E(30, 1800, 16),
    ["Dark Acolyte"] = E(
        32,
        1200,
        14,
        {
            AnimationSet = "Mage",
            Archetype = "Caster",
            PreferredRange = 40,
            AttackCooldown = 5,
            Spells = { "MeteorZones", "WardBarrier", "GroupHeal" }
        }
    ),
    Wraith = E(28, 1400, 22, {
        AttackCooldown = 0.7,
        AnimationSet = "Daggers"
    }),
    ["Fallen Knight"] = E(35, 2200, 14),
    Verath = E(45, 20000, 16, {
        AttackCooldown = 0.9,
        WalkAnim = "rbxassetid://110039686734119"
    }),
    Viking = E(45, 3200, 16),
    Wayfarer = E(38, 2600, 22, {
        AttackCooldown = 0.8,
        AnimationSet = "Daggers"
    }),
    ["Tribal Archer"] = E(
        63,
        2000,
        14,
        {
            AnimationSet = "Bow",
            Archetype = "Ranged",
            ProjectileId = "Arrow",
            ProjectileSpeed = 105,
            ProjectileArc = 0,
            PreferredRange = 30,
            RetreatRange = 12
        }
    ),
    ["Berserker Wayfarer"] = E(55, 4650, 14, {
        Archetype = "Armored",
        IdleAnim = "rbxassetid://72080662146225"
    }),
    Valkskar = E(60, 35000, 16, {
        AttackCooldown = 0.9,
        WalkAnim = "rbxassetid://110039686734119"
    }),
    ["Awakened Devil"] = E(
        70,
        60000,
        20,
        {
            AttackCooldown = 0.8,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://79157534199452"
        }
    ),
    Valen = E(
        85,
        180000,
        26,
        {
            AttackCooldown = 0.7,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://79157534199452"
        }
    ),
    ["Shadow Monarch"] = E(
        80,
        100000,
        25,
        {
            AttackCooldown = 0.8,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://139307351041159"
        }
    ),
    Kieru = E(
        80,
        150000,
        27,
        {
            AttackCooldown = 0.6,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://139307351041159"
        }
    ),
    ["Scarlet Knight"] = E(
        85,
        110000,
        24,
        {
            AttackCooldown = 0.8,
            WalkAnim = "rbxassetid://85701763280978",
            RunAnim = "rbxassetid://85701763280978",
            IdleAnim = "rbxassetid://82921578624086"
        }
    ),
    Imperator = E(
        95,
        130000,
        22,
        {
            AttackCooldown = 0.9,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://129471067358090"
        }
    ),
    Daemon = E(
        90,
        8000,
        16,
        {
            AttackCooldown = 0.7,
            IdleAnim = "rbxassetid://72080662146225",
            RunAnim = "rbxassetid://77328342017757"
        }
    ),
    ["Rogue Daemon"] = E(
        76,
        6500,
        20,
        {
            AttackCooldown = 0.8,
            AnimationSet = "Daggers",
            IdleAnim = "rbxassetid://90974298119945"
        }
    ),
    ["Archer Daemon"] = E(
        126,
        5000,
        14,
        {
            AnimationSet = "Bow",
            Archetype = "Ranged",
            ProjectileId = "Red_Arrow",
            ProjectileSpeed = 105,
            ProjectileArc = 0,
            PreferredRange = 30,
            RetreatRange = 12,
            IdleAnim = "rbxassetid://76371199358822",
            RunAnim = "rbxassetid://77328342017757"
        }
    ),
    ["Underworld Gatekeeper"] = E(
        120,
        87500,
        16,
        {
            AttackCooldown = 0.9,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://72080662146225"
        }
    ),
    Miyu = E(
        72,
        120000,
        25,
        {
            AttackCooldown = 0.7,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://82837107921468"
        }
    ),
    Ogge = E(
        78,
        135000,
        25,
        {
            AttackCooldown = 0.7,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://129471067358090"
        }
    ),
    ["Broken Reality"] = E(
        82,
        145000,
        26,
        {
            AttackCooldown = 0.75,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://84179058783112"
        }
    ),
    Hitman = E(
        72,
        120000,
        25,
        {
            AttackCooldown = 0.7,
            IdleAnim = "rbxassetid://139307351041159",
            WalkAnim = "rbxassetid://82921578624086"
        }
    ),
    Mimika = E(
        76,
        90000,
        24,
        {
            AttackCooldown = 0.75,
            WalkAnim = "rbxassetid://78988120608596",
            IdleAnim = "rbxassetid://85228396447576"
        }
    ),
    ["Forge Archon"] = E(
        85,
        175000,
        27,
        {
            AttackCooldown = 0.55,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://82921578624086"
        }
    ),
    ["Anti Mage"] = E(
        170,
        350000,
        27,
        {
            AttackCooldown = 0.5,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://72080662146225"
        }
    ),
    ["Great Mage"] = E(
        150,
        300000,
        25,
        {
            AttackCooldown = 0.7,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://114512065003613"
        }
    ),
    Raijin = E(
        85,
        160000,
        27,
        {
            AttackCooldown = 0.65,
            WalkAnim = "rbxassetid://78988120608596",
            RunAnim = "rbxassetid://78988120608596",
            IdleAnim = "rbxassetid://89816005116992"
        }
    ),
    Genesis = E(
        260,
        1500000,
        27,
        {
            AttackCooldown = 0.6,
            WalkAnim = "rbxassetid://78988120608596",
            RunAnim = "rbxassetid://78988120608596",
            IdleAnim = "rbxassetid://89816005116992"
        }
    ),
    ["Frigid Monarch"] = E(
        150,
        300000,
        27,
        {
            AttackCooldown = 0.55,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://82921578624086"
        }
    ),
    ["Unrestricted Fighter"] = E(
        83,
        160000,
        26,
        {
            AttackCooldown = 0.65,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://82921578624086"
        }
    ),
    ["Unrestricted EX"] = E(
        83,
        160000,
        26,
        {
            AttackCooldown = 0.65,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://82921578624086"
        }
    ),
    ["Shadow Knight"] = E(
        83,
        160000,
        26,
        {
            AttackCooldown = 0.65,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://82921578624086"
        }
    ),
    Satori = E(
        85,
        200000,
        26,
        {
            AttackCooldown = 1.1,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://82921578624086"
        }
    ),
    ["Cursed King"] = E(
        85,
        220000,
        26,
        {
            AttackCooldown = 1.1,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://94004890321007"
        }
    ),
    Tenebris = E(
        55,
        45000,
        19,
        {
            AttackCooldown = 0.9,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://79157534199452"
        }
    ),
    Karasu = E(
        55,
        30000,
        16,
        {
            AttackCooldown = 0.9,
            WalkAnim = "rbxassetid://110039686734119",
            IdleAnim = "rbxassetid://79157534199452"
        }
    ),
    ["Bandit Enforcer"] = E(10, 500, 14),
    ["Goblin Warchief"] = E(18, 1500, 14),
    ["Knight Champion"] = E(28, 4000, 14),
    ["Dark Revenant"] = E(38, 8000, 14, {
        IdleAnim = "rbxassetid://72080662146225"
    }),
    ["Frost Warden"] = E(50, 15000, 14, {
        IdleAnim = "rbxassetid://72080662146225"
    }),
    ["Black Fang"] = E(95, 35000, 14, {
        IdleAnim = "rbxassetid://124270295444984"
    })
};

for i, v in v7 do
    v.Id = i;
    v.Name = i;
end;

return {
    Index = v7
};