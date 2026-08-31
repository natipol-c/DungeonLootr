--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ItemData_Backup
  Path:     game.ReplicatedStorage.GameInfo.ItemData_Backup
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = {
    Mistwalker = {
        Name = "Mistwalker",
        Rarity = "Common",
        Damage = 1,
        WalkSpeed = 10,
        Health = 100,
        Lifespan = 120,
        Attack_Speed = 0.7,
        Endlag = 1.5,
        Unlockable = "Mistblade",
        WalkAnim = "rbxassetid://73586771848615",
        IdleAnim = "rbxassetid://72402887392404",
        DeadAnim = "",
        Info = {
            Income = 1,
            Price = 0
        },
        AttackAnims = { "rbxassetid://105520255900501", "rbxassetid://77885283729359", "rbxassetid://94617911765649", "rbxassetid://76852922865606" },
        FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
        ViewportOffset = Vector2.new(0, 0.5)
    },
    ["3Kieru"] = {
        Name = "3Kieru",
        Rarity = "Common",
        Damage = 1,
        WalkSpeed = 10,
        Health = 100,
        Lifespan = 120,
        WalkAnim = "rbxassetid://73586771848615",
        AttackAnim = "",
        IdleAnim = "rbxassetid://72402887392404",
        DeadAnim = "",
        Info = {
            Income = 1,
            Price = 0
        },
        ViewportOffset = Vector2.new(0, 0.5)
    },
    vintageceline = {
        Name = "vintageceline",
        Rarity = "Rare",
        Damage = 1,
        WalkSpeed = 10,
        Health = 100,
        Lifespan = 120,
        WalkAnim = "rbxassetid://73586771848615",
        AttackAnim = "",
        IdleAnim = "rbxassetid://72402887392404",
        DeadAnim = "",
        Info = {
            Income = 1,
            Price = 0
        },
        ViewportOffset = Vector2.new(0, 0.5)
    },
    xMiyuLee = {
        Name = "xMiyuLee",
        Rarity = "Rare",
        Damage = 1,
        WalkSpeed = 10,
        Health = 100,
        Lifespan = 120,
        WalkAnim = "rbxassetid://73586771848615",
        AttackAnim = "",
        IdleAnim = "rbxassetid://72402887392404",
        DeadAnim = "",
        Info = {
            Income = 1,
            Price = 0
        },
        ViewportOffset = Vector2.new(0, 0.5)
    },
    ["Ice Angel"] = {
        Name = "Ice Angel",
        Rarity = "Epic",
        Damage = 1,
        WalkSpeed = 10,
        Health = 100,
        Lifespan = 120,
        Unlockable = "Ice Magic",
        WalkAnim = "rbxassetid://73586771848615",
        AttackAnim = "",
        IdleAnim = "rbxassetid://72402887392404",
        DeadAnim = "",
        Info = {
            Income = 1,
            Price = 0
        },
        ViewportOffset = Vector2.new(0, 0.5)
    },
    Advent = {
        Name = "Advent",
        Rarity = "Epic",
        Damage = 1,
        WalkSpeed = 10,
        Health = 100,
        Lifespan = 120,
        Unlockable = "Buster",
        WalkAnim = "rbxassetid://73586771848615",
        AttackAnim = "",
        IdleAnim = "rbxassetid://72402887392404",
        DeadAnim = "",
        Info = {
            Income = 1,
            Price = 0
        },
        ViewportOffset = Vector2.new(0, 0.5)
    },
    ["Vermillion Blade"] = {
        Name = "Vermillion Blade",
        Rarity = "Rare",
        Damage = 1,
        WalkSpeed = 10,
        Health = 100,
        Lifespan = 120,
        Unlockable = "Wolf Katana",
        WalkAnim = "rbxassetid://73586771848615",
        AttackAnim = "",
        IdleAnim = "rbxassetid://72402887392404",
        DeadAnim = "",
        Info = {
            Income = 1,
            Price = 0
        },
        ViewportOffset = Vector2.new(0, 0.5)
    },
    Betrayer = {
        Name = "Betrayer",
        Rarity = "Rare",
        Damage = 1,
        WalkSpeed = 10,
        Health = 100,
        Lifespan = 120,
        Unlockable = "Dual Blades",
        WalkAnim = "rbxassetid://73586771848615",
        AttackAnim = "",
        IdleAnim = "rbxassetid://72402887392404",
        DeadAnim = "",
        Info = {
            Income = 1,
            Price = 0
        },
        ViewportOffset = Vector2.new(0, 0.5)
    },
    SvininaBombardino = {
        Name = "Svinina Bombardino",
        Rarity = "Common",
        Damage = 8,
        WalkSpeed = 10,
        Health = 400,
        Lifespan = 120,
        AttackCooldown = 3,
        WalkAnim = "",
        AttackAnim = "",
        IdleAnim = "",
        DeadAnim = "",
        Info = {
            Income = 10,
            Price = 1200
        },
        ViewportOffset = Vector2.new(0, -3.5)
    },
    TrippiTroppi = {
        Name = "Trippi Troppi",
        Rarity = "Rare",
        Damage = 10,
        WalkSpeed = 10,
        Health = 410,
        Lifespan = 120,
        WalkAnim = "",
        AttackAnim = "",
        IdleAnim = "",
        DeadAnim = "",
        Info = {
            Income = 15,
            Price = 2000
        },
        ViewportOffset = Vector2.new(0, -3.5)
    },
    TungTungSahur = {
        Name = "Tung Tung Sahur",
        Rarity = "Rare",
        Offset = Vector3.new(0, 4, 0),
        Damage = 12,
        WalkSpeed = 13,
        Health = 450,
        Lifespan = 120,
        WalkAnim = "",
        AttackAnim = "",
        IdleAnim = "",
        DeadAnim = "",
        Info = {
            Income = 25,
            Price = 3000
        }
    },
    GangsterFootera = {
        Name = "Gangster Footera",
        Rarity = "Rare",
        Damage = 14,
        WalkSpeed = 10,
        Health = 475,
        Lifespan = 120,
        WalkAnim = "",
        AttackAnim = "",
        IdleAnim = "",
        DeadAnim = "",
        Info = {
            Income = 30,
            Price = 4000
        },
        ViewportOffset = Vector2.new(0, -2)
    },
    BonecaAmbalabu = {
        Name = "Boneca Ambalabu",
        Rarity = "Rare",
        Damage = 15,
        WalkSpeed = 10,
        Health = 500,
        Lifespan = 120,
        ViewportDistance = -5,
        WalkAnim = "",
        AttackAnim = "",
        IdleAnim = "",
        DeadAnim = "",
        Info = {
            Income = 40,
            Price = 5000
        },
        ViewportOffset = Vector2.new(0, -3.5)
    },
    TaTaTaTaSahur = {
        Name = "Ta Ta Ta Ta Sahur",
        Rarity = "Rare",
        Damage = 18,
        WalkSpeed = 10,
        Health = 510,
        Lifespan = 120,
        AttackCooldown = 3,
        WalkAnim = "",
        AttackAnim = "",
        IdleAnim = "",
        DeadAnim = "",
        Info = {
            Income = 55,
            Price = 7500
        },
        ViewportOffset = Vector2.new(0, -3.5)
    },
    CappuccinoAssassino = {
        Name = "Cappuccino Assassino",
        Rarity = "Uncommon",
        Offset = Vector3.new(0, 4, 0),
        Damage = 20,
        WalkSpeed = 10,
        Health = 525,
        WalkAnim = "",
        AttackAnim = "",
        IdleAnim = "",
        DeadAnim = "",
        Info = {
            Income = 100,
            Price = 50
        }
    },
    BrrBrrPatapim = {
        Name = "Brr Brr Patapim",
        Rarity = "Epic",
        Damage = 22,
        WalkSpeed = 10,
        Health = 550,
        Lifespan = 120,
        WalkAnim = "",
        AttackAnim = "",
        IdleAnim = "",
        DeadAnim = "",
        Info = {
            Income = 100,
            Price = 15000
        },
        ViewportOffset = Vector2.new(0, -3.5)
    },
    TrulimeroTrulicina = {
        Name = "Trulimero Trulicina",
        Rarity = "Epic",
        Damage = 25,
        WalkSpeed = 14,
        Health = 600,
        Lifespan = 120,
        WalkAnim = "",
        AttackAnim = "",
        IdleAnim = "",
        DeadAnim = "",
        Info = {
            Income = 125,
            Price = 20000
        },
        ViewportOffset = Vector2.new(0, -3.5)
    },
    BananitaDolphinita = {
        Name = "Bananita Dolphinita",
        Rarity = "Epic",
        Damage = 28,
        WalkSpeed = 10,
        Health = 625,
        Lifespan = 120,
        ViewportDistance = -4,
        WalkAnim = "",
        AttackAnim = "",
        IdleAnim = "",
        DeadAnim = "",
        Info = {
            Income = 150,
            Price = 25000
        },
        ViewportOffset = Vector2.new(0, -1)
    }
};
local v2 = { "Mistwalker", "3Kieru", "vintageceline", "xMiyuLee", "Ice Angel", "Buster", "Vermillion Blade", "Betrayer", "SvininaBombardino", "TrippiTroppi", "TungTungSahur", "GangsterFootera", "BonecaAmbalabu", "TaTaTaTaSahur", "CappuccinoAssassino" };

for i, v in v1 do
    v.Id = i;
end;

return {
    Index = v1,
    DisplayOrder = v2
};