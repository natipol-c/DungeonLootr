--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ChallengeRewardData
  Path:     game.ReplicatedStorage.GameInfo.ChallengeRewardData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    CURRENT_SEASON = 1,
    FLOOR_STEP = 10,
    MAX_FLOOR = 300,
    MILESTONES = {
        {
            Floor = 10,
            Rewards = { {
                    Type = "Coins",
                    Amount = 25000
                } }
        },
        {
            Floor = 20,
            Rewards = { {
                    Type = "CraftingMaterial",
                    Id = "Legendary Ingot",
                    Amount = 15
                } }
        },
        {
            Floor = 30,
            Rewards = { {
                    Type = "BuffPotion",
                    Id = "LuckPotionT2",
                    Amount = 5
                } }
        },
        {
            Floor = 40,
            Rewards = { {
                    Type = "Package",
                    Id = "MaterialBundle_Tier3",
                    Amount = 20
                } }
        },
        {
            Floor = 50,
            Rewards = { {
                    Type = "Coins",
                    Amount = 40000
                }, {
                    Type = "LuckySpins",
                    Amount = 15
                }, {
                    Type = "Stars",
                    Amount = 1000
                }, {
                    Type = "Consumable",
                    Id = "BossRushSkipTicket",
                    Amount = 3
                } }
        },
        {
            Floor = 60,
            Rewards = { {
                    Type = "CraftingMaterial",
                    Id = "Reforge Stone",
                    Amount = 10
                } }
        },
        {
            Floor = 70,
            Rewards = { {
                    Type = "ProtectionScroll",
                    Amount = 5
                } }
        },
        {
            Floor = 80,
            Rewards = { {
                    Type = "BuffPotion",
                    Id = "LuckPotionT3",
                    Amount = 3
                } }
        },
        {
            Floor = 90,
            Rewards = { {
                    Type = "QuestItem",
                    Id = "Purity Stone",
                    Amount = 10
                } }
        },
        {
            Floor = 100,
            Rewards = { {
                    Type = "Coins",
                    Amount = 60000
                }, {
                    Type = "LuckySpins",
                    Amount = 20
                }, {
                    Type = "Stars",
                    Amount = 1500
                }, {
                    Type = "CraftingMaterial",
                    Id = "Legendary Ingot",
                    Amount = 20
                }, {
                    Type = "Consumable",
                    Id = "BossRushSkipTicket",
                    Amount = 4
                } }
        },
        {
            Floor = 110,
            Rewards = { {
                    Type = "Package",
                    Id = "MaterialBundle_Tier3",
                    Amount = 30
                } }
        },
        {
            Floor = 120,
            Rewards = { {
                    Type = "Consumable",
                    Id = "AspectGem",
                    Amount = 3
                } }
        },
        {
            Floor = 130,
            Rewards = { {
                    Type = "CraftingMaterial",
                    Id = "Reforge Stone",
                    Amount = 15
                } }
        },
        {
            Floor = 140,
            Rewards = { {
                    Type = "CraftingMaterial",
                    Id = "Mythic Ingot",
                    Amount = 15
                } }
        },
        {
            Floor = 150,
            Rewards = { {
                    Type = "Package",
                    Id = "MythicGearPack"
                }, {
                    Type = "LuckySpins",
                    Amount = 25
                }, {
                    Type = "Stars",
                    Amount = 2000
                }, {
                    Type = "ProtectionScroll",
                    Amount = 8
                }, {
                    Type = "Consumable",
                    Id = "BossRushSkipTicket",
                    Amount = 5
                } }
        },
        {
            Floor = 160,
            Rewards = { {
                    Type = "BuffPotion",
                    Id = "LuckPotionT2",
                    Amount = 8
                } }
        },
        {
            Floor = 170,
            Rewards = { {
                    Type = "QuestItem",
                    Id = "Purity Stone",
                    Amount = 15
                } }
        },
        {
            Floor = 180,
            Rewards = { {
                    Type = "Coins",
                    Amount = 80000
                } }
        },
        {
            Floor = 190,
            Rewards = { {
                    Type = "BuffPotion",
                    Id = "LuckPotionT3",
                    Amount = 5
                } }
        },
        {
            Floor = 200,
            Rewards = { {
                    Type = "Package",
                    Id = "CelestialGearPack"
                }, {
                    Type = "LuckySpins",
                    Amount = 30
                }, {
                    Type = "Stars",
                    Amount = 3000
                }, {
                    Type = "Consumable",
                    Id = "AspectGem",
                    Amount = 5
                }, {
                    Type = "ProtectionScroll",
                    Amount = 10
                }, {
                    Type = "Consumable",
                    Id = "BossRushSkipTicket",
                    Amount = 10
                } }
        },
        {
            Floor = 210,
            Rewards = { {
                    Type = "CraftingMaterial",
                    Id = "Reforge Stone",
                    Amount = 20
                } }
        },
        {
            Floor = 220,
            Rewards = { {
                    Type = "CraftingMaterial",
                    Id = "Mythic Ingot",
                    Amount = 20
                } }
        },
        {
            Floor = 230,
            Rewards = { {
                    Type = "Package",
                    Id = "MaterialBundle_Tier3",
                    Amount = 40
                } }
        },
        {
            Floor = 240,
            Rewards = { {
                    Type = "QuestItem",
                    Id = "Purity Stone",
                    Amount = 20
                } }
        },
        {
            Floor = 250,
            Rewards = { {
                    Type = "Package",
                    Id = "MythicGearPack"
                }, {
                    Type = "Coins",
                    Amount = 100000
                }, {
                    Type = "LuckySpins",
                    Amount = 35
                }, {
                    Type = "Stars",
                    Amount = 3500
                }, {
                    Type = "Consumable",
                    Id = "AspectGem",
                    Amount = 6
                } }
        },
        {
            Floor = 260,
            Rewards = { {
                    Type = "CraftingMaterial",
                    Id = "Celestial Ingot",
                    Amount = 15
                } }
        },
        {
            Floor = 270,
            Rewards = { {
                    Type = "ProtectionScroll",
                    Amount = 15
                } }
        },
        {
            Floor = 280,
            Rewards = { {
                    Type = "BuffPotion",
                    Id = "LuckPotionT3",
                    Amount = 8
                } }
        },
        {
            Floor = 290,
            Rewards = { {
                    Type = "CraftingMaterial",
                    Id = "Reforge Stone",
                    Amount = 30
                } }
        },
        {
            Floor = 300,
            Rewards = { {
                    Type = "Package",
                    Id = "CelestialGearPack"
                }, {
                    Type = "Coins",
                    Amount = 150000
                }, {
                    Type = "LuckySpins",
                    Amount = 50
                }, {
                    Type = "Stars",
                    Amount = 5000
                }, {
                    Type = "Consumable",
                    Id = "AspectGem",
                    Amount = 10
                }, {
                    Type = "ProtectionScroll",
                    Amount = 20
                }, {
                    Type = "QuestItem",
                    Id = "Purity Stone",
                    Amount = 40
                } }
        }
    },
    _floorToMilestone = {}
};

for i, v in u1.MILESTONES do
    u1._floorToMilestone[v.Floor] = i;
end;

function u1.GetMilestoneForFloor(p2: number) -- Line: 138
    -- upvalues: u1 (copy)
    return u1._floorToMilestone[p2];
end;

function u1.GetUnlockedMilestones(p3: number) -- Line: 143
    -- upvalues: u1 (copy)
    local v4 = {};

    for i, v in u1.MILESTONES do
        if v.Floor <= p3 then
            table.insert(v4, i);
        end;
    end;

    return v4;
end;

return u1;