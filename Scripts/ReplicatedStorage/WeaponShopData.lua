--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     WeaponShopData
  Path:     game.ReplicatedStorage.GameInfo.WeaponShopData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    TierProducts = {
        Common = {
            Key = "WeaponTier_Common",
            RobuxCost = 99
        },
        Uncommon = {
            Key = "WeaponTier_Uncommon",
            RobuxCost = 99
        },
        Rare = {
            Key = "WeaponTier_Rare",
            RobuxCost = 149
        },
        Epic = {
            Key = "WeaponTier_Epic",
            RobuxCost = 249
        },
        Legendary = {
            Key = "WeaponTier_Legendary",
            RobuxCost = 649
        },
        Mythic = {
            Key = "WeaponTier_Mythic",
            RobuxCost = 1299
        },
        Celestial = {
            Key = "WeaponTier_Celestial",
            RobuxCost = 1899
        }
    },
    Items = {
        {
            Id = "Dual Gun",
            Type = "Weapon",
            Cost = 2000,
            RobuxCost = 99,
            RequiredRebirth = 0,
            LayoutOrder = 1,
            StockConfig = {
                MaxStock = 3,
                RestockAmount = 3
            }
        },
        {
            Id = "Bow",
            Type = "Weapon",
            Cost = 3000,
            RobuxCost = 99,
            RequiredRebirth = 0,
            LayoutOrder = 1,
            StockConfig = {
                MaxStock = 3,
                RestockAmount = 3
            }
        },
        {
            Id = "Dual Katana",
            Type = "Weapon",
            Cost = 5000,
            RobuxCost = 99,
            RequiredRebirth = 0,
            LayoutOrder = 1,
            StockConfig = {
                MaxStock = 3,
                RestockAmount = 3
            }
        },
        {
            Id = "Hunter Daggers",
            Type = "Weapon",
            Cost = 5000,
            RobuxCost = 99,
            RequiredRebirth = 0,
            LayoutOrder = 1,
            StockConfig = {
                MaxStock = 3,
                RestockAmount = 3
            }
        },
        {
            Id = "Monkey Staff",
            Type = "Weapon",
            Cost = 10000,
            RobuxCost = 99,
            RequiredRebirth = 0,
            LayoutOrder = 1,
            StockConfig = {
                MaxStock = 3,
                RestockAmount = 3
            }
        },
        {
            Id = "Lightning Fist",
            Type = "Weapon",
            Cost = 50000,
            RobuxCost = 149,
            RequiredRebirth = 0,
            LayoutOrder = 2,
            StockConfig = {
                MaxStock = 2,
                RestockAmount = 2
            }
        },
        {
            Id = "Frozen Staff",
            Type = "Weapon",
            Cost = 90000,
            RobuxCost = 199,
            RequiredRebirth = 0,
            LayoutOrder = 10,
            StockConfig = {
                MaxStock = 2,
                RestockAmount = 2
            }
        },
        {
            Id = "Flaming Spear",
            Type = "Weapon",
            Cost = 250000,
            RobuxCost = 249,
            RequiredRebirth = 1,
            LayoutOrder = 11,
            StockConfig = {
                MaxStock = 2,
                RestockAmount = 2
            }
        },
        {
            Id = "Waterfall Katana",
            Type = "Weapon",
            Cost = 1000000,
            RobuxCost = 349,
            RequiredRebirth = 1,
            LayoutOrder = 12,
            StockConfig = {
                MaxStock = 1,
                RestockAmount = 1
            }
        },
        {
            Id = "Flaming Fist",
            Type = "Weapon",
            Cost = 50000000,
            RobuxCost = 499,
            RequiredRebirth = 2,
            LayoutOrder = 20,
            StockConfig = {
                MaxStock = 1,
                RestockAmount = 1
            }
        },
        {
            Id = "Korin Zangetsu",
            Type = "Weapon",
            Cost = 65000000,
            RobuxCost = 649,
            RequiredRebirth = 2,
            LayoutOrder = 21,
            StockConfig = {
                MaxStock = 1,
                RestockAmount = 1
            }
        },
        {
            Id = "Phoenix Fans",
            Type = "Weapon",
            Cost = 65000000,
            RobuxCost = 799,
            RequiredRebirth = 3,
            LayoutOrder = 22,
            StockConfig = {
                MaxStock = 1,
                RestockAmount = 1
            }
        },
        {
            Id = "Blazing Katana",
            Type = "Weapon",
            Cost = 65000000,
            RobuxCost = 799,
            RequiredRebirth = 3,
            LayoutOrder = 23,
            StockConfig = {
                MaxStock = 1,
                RestockAmount = 1
            }
        },
        {
            Id = "Darkflame Fist",
            Type = "Weapon",
            Cost = 100000000,
            RobuxCost = 999,
            RequiredRebirth = 3,
            LayoutOrder = 30,
            StockConfig = {
                MaxStock = 1,
                RestockAmount = 1
            }
        },
        {
            Id = "Umbral Rapier",
            Type = "Weapon",
            Cost = 120000000,
            RobuxCost = 1299,
            RequiredRebirth = 4,
            LayoutOrder = 31,
            StockConfig = {
                MaxStock = 1,
                RestockAmount = 1
            }
        },
        {
            Id = "Tenrai Kojin",
            Type = "Weapon",
            Cost = 200000000,
            RobuxCost = 1299,
            RequiredRebirth = 4,
            LayoutOrder = 32,
            StockConfig = {
                MaxStock = 1,
                RestockAmount = 1
            }
        },
        {
            Id = "Cursed Blade",
            Type = "Weapon",
            Cost = 900000000,
            RobuxCost = 1899,
            RequiredRebirth = 5,
            LayoutOrder = 41,
            StockConfig = {
                MaxStock = 1,
                RestockAmount = 1
            }
        },
        {
            Id = "Chaos Scythe",
            Type = "Weapon",
            Cost = 600000000,
            RobuxCost = 1899,
            RequiredRebirth = 5,
            LayoutOrder = 40,
            StockConfig = {
                MaxStock = 1,
                RestockAmount = 1
            }
        }
    }
};

function u1.GetItem(p2: string) -- Line: 238
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1.Items) do
        if v.Id == p2 then
            return v;
        end;
    end;

    return nil;
end;

function u1.GetAvailableItems(p3: number) -- Line: 248
    -- upvalues: u1 (copy)
    local v4 = {};

    for _, v in ipairs(u1.Items) do
        if v.RequiredRebirth <= p3 then
            table.insert(v4, v);
        end;
    end;

    return v4;
end;

return u1;