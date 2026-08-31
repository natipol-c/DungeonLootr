--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     QuestRewardData
  Path:     game.ReplicatedStorage.GameInfo.QuestRewardData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local GroupService = game:GetService("GroupService");
game:GetService("SocialService");
local u1 = {};
local u2 = nil;

function u1.IsInGroup(u3: userdata) -- Line: 33
    -- upvalues: u2 (ref)
    if u2 ~= nil then
        return u2;
    end;

    local success, result = pcall(function() -- Line: 36
        -- upvalues: u3 (copy)
        return u3:IsInGroupAsync(110427303);
    end);

    if success then
        u2 = result;

        return result;
    end;

    warn("[QuestRewardData] IsInGroupAsync failed:", result);

    return false;
end;

function u1.PromptGroupJoin() -- Line: 51
    -- upvalues: GroupService (copy), u2 (ref)
    local success, result = pcall(function() -- Line: 52
        -- upvalues: GroupService (ref)
        return GroupService:PromptJoinAsync(110427303);
    end);

    if not success then
        warn("[QuestRewardData] PromptJoinAsync failed:", result);

        return false;
    end;

    if result ~= Enum.GroupMembershipStatus.Joined and result ~= Enum.GroupMembershipStatus.AlreadyMember then
        return false;
    end;

    u2 = true;

    return true;
end;

function u1.EnsureGroupMembership(p4: userdata) -- Line: 72
    -- upvalues: u1 (copy)
    return u1.IsInGroup(p4) and true or u1.PromptGroupJoin();
end;

u1.Quests = {
    AuraIronSights = {
        NPC = "Aura",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Witch Gunner",
                Min = 50
            }, {
                Type = "Material",
                ItemId = "Celestial Ingot",
                Count = 67
            }, {
                Type = "Currency",
                Min = 1000000
            } },
        Rewards = { {
                Type = "Title",
                Id = "Iron Sights"
            } },
        Consume = { {
                Type = "Material",
                ItemId = "Celestial Ingot",
                Count = 67
            }, {
                Type = "Currency",
                Amount = 1000000
            } }
    },
    GroupReward = {
        NPC = "GroupReward",
        RequiresGroup = true,
        Conditions = {},
        Rewards = { {
                Type = "Cosmetic",
                Id = "Group Aura"
            }, {
                Type = "Package",
                Id = "RareGearPack"
            } },
        Consume = {}
    },
    MimikaGoldenKatana = {
        NPC = "Mimika",
        Conditions = { {
                Type = "PlayerLevel",
                Min = 50
            }, {
                Type = "ClassMasteryLevel",
                Class = "Ronin",
                Min = 30
            }, {
                Type = "QuestItem",
                ItemId = "Flaming Crystal",
                Count = 3
            }, {
                Type = "Currency",
                Min = 50000
            } },
        Rewards = { {
                Type = "ClassItem",
                Id = "Golden Katana"
            } },
        Consume = { {
                Type = "QuestItem",
                ItemId = "Flaming Crystal",
                Count = 3
            }, {
                Type = "Currency",
                Amount = 50000
            } }
    },
    ValenMotivated = {
        NPC = "Valen",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Azure Devil",
                Min = 50
            } },
        Rewards = { {
                Type = "Title",
                Id = "Motivated"
            }, {
                Type = "Coins",
                Amount = 1000000
            } },
        Consume = {}
    },
    ValenTheStorm = {
        NPC = "Valen",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Awakened Devil EX",
                Min = 50
            } },
        Rewards = { {
                Type = "Title",
                Id = "The Storm"
            }, {
                Type = "Coins",
                Amount = 1000000
            } },
        Consume = {}
    },
    ValenJudgement = {
        NPC = "Valen",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Azure Devil",
                Min = 50
            }, {
                Type = "QuestItem",
                ItemId = "Devil Heart",
                Count = 1
            }, {
                Type = "Currency",
                Min = 1000000
            } },
        Rewards = { {
                Type = "ClassItem",
                Id = "Judgements Edge"
            } },
        Consume = { {
                Type = "QuestItem",
                ItemId = "Devil Heart",
                Count = 1
            }, {
                Type = "Currency",
                Amount = 1000000
            } }
    },
    ValenStormcaller = {
        NPC = "Valen",
        Conditions = { {
                Type = "CompletedQuest",
                QuestId = "ValenJudgement"
            }, {
                Type = "AwakenedDevilEXKills",
                Min = 50000
            } },
        Rewards = { {
                Type = "Package",
                Id = "ADEXPack"
            } },
        Consume = {}
    },
    RoseSilverKey = {
        NPC = "Rose",
        Conditions = { {
                Type = "PlayerLevel",
                Min = 5
            }, {
                Type = "HasKey",
                Tier = 2,
                Count = 1
            } },
        Rewards = { {
                Type = "Package",
                Id = "EpicGearPack"
            } },
        Consume = { {
                Type = "Key",
                Tier = 2,
                Count = 1
            } }
    },
    GuideKickstart = {
        NPC = "Guide",
        Conditions = { {
                Type = "PlayerLevel",
                Min = 10
            } },
        Rewards = { {
                Type = "Package",
                Id = "EpicGearPack"
            } },
        Consume = {}
    },
    ForgeGuideMaterialBag = {
        NPC = "ForgeGuide",
        Conditions = {},
        Rewards = { {
                Type = "Package",
                Id = "MaterialBundle_Tier1",
                Amount = 5
            } },
        Consume = {}
    },
    KageMask = {
        NPC = "Kage",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Kage",
                Min = 50
            } },
        Rewards = { {
                Type = "ClassItem",
                Id = "Kage\'s Mask"
            }, {
                Type = "Title",
                Id = "Black Falcon"
            }, {
                Type = "Coins",
                Amount = 1000000
            } },
        Consume = {}
    },
    MooncarverDemonsEye = {
        NPC = "Mooncarver",
        Conditions = { {
                Type = "PlayerLevel",
                Min = 40
            }, {
                Type = "ClassMasteryLevel",
                Class = "Master Swordsman",
                Min = 30
            }, {
                Type = "ClassMasteryLevel",
                Class = "Ronin",
                Min = 30
            }, {
                Type = "ClassMasteryLevel",
                Class = "Cursed Child",
                Min = 30
            }, {
                Type = "Currency",
                Min = 50000
            } },
        Rewards = { {
                Type = "ClassItem",
                Id = "Demons Eye"
            }, {
                Type = "Title",
                Id = "Mooncarver"
            } },
        Consume = { {
                Type = "Currency",
                Amount = 50000
            } }
    },
    CoyotePack = {
        NPC = "Coyote",
        Conditions = { {
                Type = "PlayerLevel",
                Min = 50
            }, {
                Type = "ClassMasteryLevel",
                Class = "Kage",
                Min = 5
            }, {
                Type = "Currency",
                Min = 100000
            } },
        Rewards = { {
                Type = "Package",
                Id = "CoyotePack"
            }, {
                Type = "Title",
                Id = "Coyote"
            } },
        Consume = { {
                Type = "Currency",
                Amount = 100000
            } }
    },
    OggePartyAnimal = {
        NPC = "Ogge",
        Conditions = { {
                Type = "PlayerLevel",
                Min = 30
            }, {
                Type = "ClassMasteryLevel",
                Class = "Monk",
                Min = 30
            }, {
                Type = "ClassMasteryLevel",
                Class = "Healing Fist",
                Min = 30
            }, {
                Type = "Currency",
                Min = 10000
            }, {
                Type = "HasEquipment",
                ItemId = "BlueFedora"
            } },
        Rewards = { {
                Type = "Cosmetic",
                Id = "Party Animal"
            }, {
                Type = "Title",
                Id = "Party Animal"
            } },
        Consume = { {
                Type = "Currency",
                Amount = 10000
            } }
    },
    ArtemisArrow = {
        NPC = "Artemis",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Artemis",
                Min = 50
            } },
        Rewards = { {
                Type = "Title",
                Id = "God Hunter"
            }, {
                Type = "ClassItem",
                Id = "Artemis\'s Arrow"
            } },
        Consume = {}
    },
    CursedKingMastery = {
        NPC = "CursedKing",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Cursed King",
                Min = 50
            } },
        Rewards = { {
                Type = "Title",
                Id = "King of Curses"
            }, {
                Type = "Coins",
                Amount = 1000000
            } },
        Consume = {}
    },
    GreatMageDemonbane = {
        NPC = "GreatMage",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Demonbane",
                Min = 50
            }, {
                Type = "Currency",
                Min = 1000000
            } },
        Rewards = { {
                Type = "Title",
                Id = "The Slayer"
            } },
        Consume = { {
                Type = "Currency",
                Amount = 1000000
            } }
    },
    JetstreamCyberneticKatana = {
        NPC = "Jetstream",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Azure Devil",
                Min = 50
            }, {
                Type = "QuestItem",
                ItemId = "Devil Heart",
                Count = 3
            }, {
                Type = "Material",
                ItemId = "Exotic Shattered Armor",
                Count = 1
            }, {
                Type = "Currency",
                Min = 200000
            } },
        Rewards = { {
                Type = "ClassItem",
                Id = "Cybernetic Katana"
            } },
        Consume = { {
                Type = "QuestItem",
                ItemId = "Devil Heart",
                Count = 3
            }, {
                Type = "Material",
                ItemId = "Exotic Shattered Armor",
                Count = 1
            }, {
                Type = "Currency",
                Amount = 200000
            } }
    },
    JetstreamMinuano = {
        NPC = "Jetstream",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Jetstream",
                Min = 50
            }, {
                Type = "Currency",
                Min = 1000000
            } },
        Rewards = { {
                Type = "Title",
                Id = "The Minuano"
            } },
        Consume = { {
                Type = "Currency",
                Amount = 1000000
            } }
    },
    AwakenedDevilJudgementsEdge = {
        NPC = "AwakenedDevil",
        Conditions = { {
                Type = "PlayerLevel",
                Min = 50
            }, {
                Type = "ClassPrestigeLevel",
                Class = "Azure Devil",
                Min = 1
            } },
        Rewards = { {
                Type = "ClassItem",
                Id = "Judgements Edge"
            } },
        Consume = {}
    },
    ShadowMonarchBlackHeart = {
        NPC = "ShadowMonarch",
        Conditions = { {
                Type = "PlayerLevel",
                Min = 50
            } },
        Rewards = { {
                Type = "ClassItem",
                Id = "Black Heart"
            } },
        Consume = {}
    },
    ZhugeOnyxFans = {
        NPC = "Zhuge",
        Conditions = { {
                Type = "PlayerLevel",
                Min = 60
            }, {
                Type = "QuestItem",
                ItemId = "Corrupted Feather",
                Count = 30
            }, {
                Type = "Currency",
                Min = 90000
            } },
        Rewards = { {
                Type = "ClassItem",
                Id = "Onyx Hand Fans"
            } },
        Consume = { {
                Type = "QuestItem",
                ItemId = "Corrupted Feather",
                Count = 30
            }, {
                Type = "Currency",
                Amount = 90000
            } }
    },
    UnrestrictedInvertedSpear = {
        NPC = "Unrestricted",
        Conditions = { {
                Type = "PlayerLevel",
                Min = 75
            }, {
                Type = "ClassMasteryLevel",
                Class = "Honored One",
                Min = 25
            }, {
                Type = "QuestItem",
                ItemId = "Heavenly Fragment",
                Count = 10
            }, {
                Type = "Currency",
                Min = 500000
            } },
        Rewards = { {
                Type = "ClassItem",
                Id = "Inverted Spear"
            } },
        Consume = { {
                Type = "QuestItem",
                ItemId = "Heavenly Fragment",
                Count = 10
            }, {
                Type = "Currency",
                Amount = 500000
            } }
    },
    UnrestrictedUnchained = {
        NPC = "Unrestricted",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Unrestricted",
                Min = 50
            }, {
                Type = "Currency",
                Min = 1000000
            } },
        Rewards = { {
                Type = "Title",
                Id = "Unchained"
            } },
        Consume = { {
                Type = "Currency",
                Amount = 1000000
            } }
    },
    DevilHunterMastery = {
        NPC = "DevilHunter",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Sinister Trigger",
                Min = 50
            }, {
                Type = "QuestItem",
                ItemId = "Devil Heart",
                Count = 5
            }, {
                Type = "Material",
                ItemId = "Exotic Ingot",
                Count = 2
            }, {
                Type = "Currency",
                Min = 2000000
            } },
        Rewards = { {
                Type = "Title",
                Id = "Devil Hunter"
            } },
        Consume = { {
                Type = "QuestItem",
                ItemId = "Devil Heart",
                Count = 5
            }, {
                Type = "Material",
                ItemId = "Exotic Ingot",
                Count = 2
            }, {
                Type = "Currency",
                Amount = 2000000
            } }
    },
    EclipseBuffPotions = {
        NPC = "Eclipse",
        Conditions = { {
                Type = "BossRushFloor",
                Min = 50
            } },
        Rewards = { {
                Type = "Package",
                Id = "BuffPotionBundle",
                Amount = 10
            } },
        Consume = {}
    },
    EclipseCenturion = {
        NPC = "Eclipse",
        Conditions = { {
                Type = "BossRushFloor",
                Min = 100
            } },
        Rewards = { {
                Type = "Title",
                Id = "Centurion"
            } },
        Consume = {}
    },
    SupremeWarrior100 = {
        NPC = "Supreme",
        Conditions = { {
                Type = "PVPKills",
                Min = 100
            } },
        Rewards = { {
                Type = "Package",
                Id = "SupremeWarriorPackage"
            } },
        Consume = {}
    },
    SupremeWarrior800 = {
        NPC = "Supreme",
        Conditions = { {
                Type = "PVPKills",
                Min = 800
            } },
        Rewards = { {
                Type = "Package",
                Id = "AltSupremeWarriorPackage"
            } },
        Consume = {}
    },
    SupremeWarrior1000 = {
        NPC = "Supreme",
        Conditions = { {
                Type = "PVPKills",
                Min = 1000
            } },
        Rewards = { {
                Type = "Cosmetic",
                Id = "Supreme Aura"
            } },
        Consume = {}
    },
    SupremeWarrior1500 = {
        NPC = "Supreme",
        Conditions = { {
                Type = "PVPKills",
                Min = 1500
            } },
        Rewards = { {
                Type = "Title",
                Id = "Supreme Being"
            } },
        Consume = {}
    },
    ForgeArchonMastery = {
        NPC = "ForgeArchon",
        Conditions = { {
                Type = "ClassMasteryLevel",
                Class = "Forge Archon",
                Min = 50
            } },
        Rewards = { {
                Type = "Title",
                Id = "Infinite Blade Works"
            }, {
                Type = "Coins",
                Amount = 1000000
            } },
        Consume = {}
    }
};
local u35 = {
    PlayerLevel = function(p5, p6) -- Line: 607, Name: PlayerLevel
        return (p6.PlayerLevel or 0) >= (p5.Min or 0);
    end,

    ClassMasteryLevel = function(p7, p8) -- Line: 611, Name: ClassMasteryLevel
        local v9 = p8.ClassMastery and p8.ClassMastery[p7.Class];

        if v9 then
            return (v9.Level or 0) >= (p7.Min or 0);
        end;

        return false;
    end,

    ClassPrestigeLevel = function(p10, p11) -- Line: 621, Name: ClassPrestigeLevel
        local v12 = p11.ClassPrestige and p11.ClassPrestige[p10.Class];

        if v12 then
            return (v12.Prestiges or 0) >= (p10.Min or 0);
        end;

        return false;
    end,

    QuestItem = function(p13, p14) -- Line: 627, Name: QuestItem
        return (p14.QuestItems and (p14.QuestItems[p13.ItemId] or 0) or 0) >= (p13.Count or 1);
    end,

    Material = function(p15, p16) -- Line: 635, Name: Material
        return (p16.CraftingMaterials and (p16.CraftingMaterials[p15.ItemId] or 0) or 0) >= (p15.Count or 1);
    end,

    Currency = function(p17, p18) -- Line: 640, Name: Currency
        return (p18.Currency or 0) >= (p17.Min or 0);
    end,

    HasKey = function(p19, p20) -- Line: 644, Name: HasKey
        local Keys = p20.Keys;

        if Keys then
            return (Keys["T" .. tostring(p19.Tier)] or 0) >= (p19.Count or 1);
        end;

        return false;
    end,

    BossRushFloor = function(p21, p22) -- Line: 653, Name: BossRushFloor
        local BossRush = p22.BossRush;

        if BossRush then
            return (BossRush.HighestFloor or 0) >= (p21.Min or 0);
        end;

        return false;
    end,

    PVPKills = function(p23, p24) -- Line: 662, Name: PVPKills
        local Stats = p24.Stats;

        if Stats then
            return (Stats.PVPKills or 0) >= (p23.Min or 0);
        end;

        return false;
    end,

    AwakenedDevilEXKills = function(p25, p26) -- Line: 672, Name: AwakenedDevilEXKills
        local Stats = p26.Stats;

        if Stats then
            return (Stats.AwakenedDevilEXKills or 0) >= (p25.Min or 0);
        end;

        return false;
    end,

    CompletedQuest = function(p27, p28) -- Line: 678, Name: CompletedQuest
        local CompletedQuests = p28.CompletedQuests;

        if CompletedQuests then
            CompletedQuests = CompletedQuests[p27.QuestId] == true;
        end;

        return CompletedQuests;
    end,

    HasEquipment = function(p29, p30) -- Line: 683, Name: HasEquipment
        local ItemId = p29.ItemId;

        if p30.Equipment then
            for _, v in p30.Equipment do
                if type(v) == "table" and v.ItemId == ItemId then
                    return true;
                end;
            end;
        end;

        if p30.EquipmentInventory then
            for _, v in p30.EquipmentInventory do
                if v.ItemId == ItemId then
                    return true;
                end;
            end;
        end;

        return false;
    end,

    CanPrestigeActiveClass = function(p31, p32) -- Line: 711, Name: CanPrestigeActiveClass
        local PrestigeData = require(game:GetService("ReplicatedStorage").GameInfo.PrestigeData);
        local v33 = p31.Class or p32.ActiveClass;

        if not v33 or v33 == "" then
            return false;
        end;

        local v34 = p32.ClassMastery and p32.ClassMastery[v33];

        return (v34 and v34.Level or 1) >= PrestigeData.REQUIRED_CLASS_LEVEL;
    end
};

function u1.CheckConditions(p36, p37) -- Line: 727
    -- upvalues: u35 (copy)
    if not (p36 and p36.Conditions) then
        return false;
    end;

    if not p37 then
        return false;
    end;

    for _, v in p36.Conditions do
        local v38 = u35[v.Type];

        if not v38 then
            warn("[QuestRewardData] Unknown condition type:", v.Type);

            return false;
        end;

        if not v38(v, p37) then
            return false;
        end;
    end;

    return true;
end;

function u1.GetQuestsForNPC(p39: string) -- Line: 748
    -- upvalues: u1 (copy)
    local v40 = {};

    for i, v in u1.Quests do
        if v.NPC == p39 then
            table.insert(v40, {
                questId = i,
                questDef = v
            });
        end;
    end;

    return v40;
end;

return u1;