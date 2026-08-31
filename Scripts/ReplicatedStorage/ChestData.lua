--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ChestData
  Path:     game.ReplicatedStorage.GameInfo.ChestData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    RewardTypes = {
        Hero = "Hero",
        Weapon = "Weapon",
        Title = "Title",
        Cash = "Cash",
        Stars = "Stars",
        Item = "Item",
        Crystal = "Crystal"
    },
    Chests = {
        FrozenChest = {
            Name = "Frozen Chest",
            Limited = true,
            Contents = { {
                    Id = "Yamato",
                    Type = "Weapon",
                    Chance = 0.15,
                    DisplayName = "YAMATO"
                }, {
                    Id = "Valen",
                    Type = "Hero",
                    Chance = 2,
                    DisplayName = "VALEN"
                }, {
                    Id = "Motivated",
                    Type = "Title",
                    Chance = 5,
                    DisplayName = "MOTIVATED TITLE"
                }, {
                    Id = "Cash_25K",
                    Type = "Cash",
                    Amount = 25000,
                    Chance = 25,
                    DisplayName = "25k CASH"
                }, {
                    Id = "Cash_5K",
                    Type = "Cash",
                    Amount = 5000,
                    Chance = 68,
                    DisplayName = "5k CASH"
                }, {
                    Id = "Celestial Crystal",
                    Type = "Crystal",
                    Amount = 3,
                    Chance = 68,
                    DisplayName = "3x Celestial Crystal"
                }, {
                    Id = "ProtScroll_Frozen",
                    Type = "ProtectionScroll",
                    Amount = 1,
                    Chance = 3,
                    DisplayName = "PROTECTION SCROLL"
                }, {
                    Id = "Stones_Legendary_Plus",
                    Type = "UpgradeStone",
                    MinRarity = "Legendary",
                    Chance = 15,
                    DisplayName = "1-3x Legendary+ Stones",
                    Amount = { 1, 3 }
                } }
        },
        MoltenChest = {
            Name = "Molten Chest",
            Limited = true,
            Contents = { {
                    Id = "Demon Daggers",
                    Type = "Weapon",
                    Chance = 1,
                    DisplayName = "DEMON DAGGERS"
                }, {
                    Id = "Duskwraith",
                    Type = "Hero",
                    Chance = 5,
                    DisplayName = "DUSKWRAITH"
                }, {
                    Id = "Stars_175",
                    Type = "Stars",
                    Amount = 175,
                    Chance = 10,
                    DisplayName = "175 STARS"
                }, {
                    Id = "Mythic Crystal",
                    Type = "Crystal",
                    Chance = 40,
                    DisplayName = "3-8x Mythic Crystal",
                    Amount = { 3, 8 }
                }, {
                    Id = "Cash_10K",
                    Type = "Cash",
                    Amount = 10000,
                    Chance = 54,
                    DisplayName = "10k CASH"
                }, {
                    Id = "ProtScroll_Molten",
                    Type = "ProtectionScroll",
                    Amount = 1,
                    Chance = 7,
                    DisplayName = "PROTECTION SCROLL"
                }, {
                    Id = "Stones_Epic_Plus",
                    Type = "UpgradeStone",
                    MinRarity = "Epic",
                    Chance = 12,
                    DisplayName = "2-5x Epic+ Stones",
                    Amount = { 2, 5 }
                } }
        },
        CoyoteChest = {
            Name = "Coyote Chest",
            Limited = true,
            Contents = { {
                    Id = "Coyote Pistols",
                    Type = "Weapon",
                    Chance = 1,
                    DisplayName = "COYOTE PISTOLS"
                }, {
                    Id = "Coyote",
                    Type = "Title",
                    Chance = 5,
                    DisplayName = "COYOTE TITLE"
                }, {
                    Id = "Stars_175",
                    Type = "Stars",
                    Amount = 175,
                    Chance = 10,
                    DisplayName = "175 STARS"
                }, {
                    Id = "Cash_25K",
                    Type = "Cash",
                    Amount = 25000,
                    Chance = 20,
                    DisplayName = "25k CASH"
                }, {
                    Id = "Cash_5K",
                    Type = "Cash",
                    Amount = 5000,
                    Chance = 30,
                    DisplayName = "5k CASH"
                }, {
                    Id = "Celestial Crystal",
                    Type = "Crystal",
                    Amount = 3,
                    Chance = 68,
                    DisplayName = "3x Celestial Crystal"
                }, {
                    Id = "ProtScroll_Coyote",
                    Type = "ProtectionScroll",
                    Amount = 1,
                    Chance = 6,
                    DisplayName = "PROTECTION SCROLL"
                }, {
                    Id = "Stones_Legendary_Plus",
                    Type = "UpgradeStone",
                    MinRarity = "Mythic",
                    Chance = 15,
                    DisplayName = "1-3x Mythic+ Stones",
                    Amount = { 1, 3 }
                } }
        }
    },
    FreeChests = { {
            ChestId = "MoltenChest",
            RequiredRebirth = 0,
            ButtonName = "Buy1"
        }, {
            ChestId = "FrozenChest",
            RequiredRebirth = 3,
            ButtonName = "Buy2"
        }, {
            ChestId = "CoyoteChest",
            RequiredRebirth = 5,
            ButtonName = "Buy3"
        } },
    FREE_CHEST_RESET_INTERVAL = 86400
};

function u1.GetChest(p2: string) -- Line: 230
    -- upvalues: u1 (copy)
    return u1.Chests[p2];
end;

function u1.GetWeightedContents(p3: string) -- Line: 235
    -- upvalues: u1 (copy)
    local v4 = u1.Chests[p3];

    if not v4 then
        return nil;
    end;

    local v5 = {};

    for _, v in ipairs(v4.Contents) do
        v5[v.Id] = v.Chance;
    end;

    return v5;
end;

function u1.GetItemFromChest(p6: string, p7: string) -- Line: 247
    -- upvalues: u1 (copy)
    local v8 = u1.Chests[p6];

    if not v8 then
        return nil;
    end;

    for _, v in ipairs(v8.Contents) do
        if v.Id == p7 then
            return v;
        end;
    end;

    return nil;
end;

return u1;