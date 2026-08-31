--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     MonetizationList
  Path:     game.ReplicatedStorage.GameInfo.MonetizationList
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = RunService:IsServer();
local UnixTimestamp = DateTime.fromUniversalTime(2026, 8, 25, 21, 0, 0).UnixTimestamp;
local UnixTimestamp2 = DateTime.fromUniversalTime(2026, 9, 12, 21, 0, 0).UnixTimestamp;
local u2 = {
    [2] = { 3528254396, 99 },
    [3] = { 3528254495, 225 },
    [4] = { 3528254568, 449 },
    [5] = { 3528254651, 799 },
    [6] = { 3528256129, 1099 },
    [7] = { 3528256225, 1499 },
    [8] = { 3528256320, 1999 },
    [9] = { 3528256481, 2499 },
    [10] = { 3528256551, 2999 }
};

return {
    ProtectHero = {
        Type = "Product",
        Id = 3528902644,
        Robux = 0
    },
    StarterPack = {
        Type = "Product",
        Id = 3374561907,
        Robux = 0,

        DoesPlayerOwn = function(p3: userdata, p4: any) -- Line: 40, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v5 = Knit.GetService("DataService"):Get(p3);

                if v5 then
                    v5 = v5.Data.OwnedStarterPack;
                end;

                return v5;
            end;

            if p4 then
                return p4.OwnedStarterPack;
            end;
        end
    },
    PowerfulStarterPack = {
        Type = "Product",
        Id = 3530226289,
        Robux = 0,

        DoesPlayerOwn = function(p6: userdata, p7: any) -- Line: 57, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v8 = Knit.GetService("DataService"):Get(p6);

                if v8 then
                    v8 = v8.Data.OwnedPowerfulStarterPack;
                end;

                return v8;
            end;

            if p7 then
                return p7.OwnedPowerfulStarterPack;
            end;
        end
    },
    ServerLuck = {
        Type = "Product",

        GetId = function() -- Line: 75, Name: GetId
            -- upvalues: ReplicatedStorage (copy), u2 (copy)
            local Value = ReplicatedStorage.ServerState.Luck.Value;
            local v9 = nil;

            if Value < 10 then
                v9 = u2[Value + 1];
            elseif Value >= 10 or Value == ReplicatedStorage.Configuration.MAX_SERVER_LUCK.Value then
                v9 = u2[10];
            end;

            return v9 or u2[10];
        end,

        GetAllIds = function() -- Line: 86, Name: GetAllIds
            -- upvalues: u2 (copy)
            return u2;
        end
    },
    WaterSword = {
        Type = "Product",
        Id = 3379201149,
        Robux = 0,

        DoesPlayerOwn = function(p10: userdata, p11: any) -- Line: 95, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v12 = Knit.GetService("DataService"):Get(p10);
                local v13 = v12 and v12.Data.PermanentItems and table.find(v12.Data.PermanentItems, "WaterSword");

                return v13;
            end;

            if p11 then
                return table.find(p11.PermanentItems, "WaterSword");
            end;
        end
    },
    PortalFinder = {
        Type = "Product",
        Id = 3528254203,
        Robux = 0,

        DoesPlayerOwn = function(p14: userdata, p15: any) -- Line: 113, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v16 = Knit.GetService("DataService"):Get(p14);
                local v17 = v16 and v16.Data.PermanentItems and table.find(v16.Data.PermanentItems, "PortalFinder");

                return v17;
            end;

            if p15 then
                return table.find(p15.PermanentItems, "PortalFinder");
            end;
        end
    },
    ["2xMoney"] = {
        Type = "Product",
        Id = 3528253895,
        Robux = 0,

        DoesPlayerOwn = function(p18: userdata, p19: any) -- Line: 130, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v20 = Knit.GetService("DataService"):Get(p18);
                local v21 = v20 and v20.Data.Data.PermanentItems and table.find(v20.Data.Data.PermanentItems, "2xMoney");

                return v21;
            end;

            if p19 then
                return table.find(p19.PermanentItems, "2xMoney");
            end;
        end
    },
    ["2xStars"] = {
        Type = "Product",
        Id = 3531421161,
        Robux = 0,

        DoesPlayerOwn = function(p22: userdata, p23: any) -- Line: 145, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v24 = Knit.GetService("DataService"):Get(p22);
                local v25 = v24 and v24.Data.Data.PermanentItems and table.find(v24.Data.Data.PermanentItems, "2xStars");

                return v25;
            end;

            if p23 then
                return table.find(p23.PermanentItems, "2xStars");
            end;
        end
    },
    ["2xCrystals"] = {
        Type = "Product",
        Id = 3531421316,
        Robux = 0,

        DoesPlayerOwn = function(p26: userdata, p27: any) -- Line: 160, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v28 = Knit.GetService("DataService"):Get(p26);
                local v29 = v28 and v28.Data.Data.PermanentItems and table.find(v28.Data.Data.PermanentItems, "2xCrystals");

                return v29;
            end;

            if p27 then
                return table.find(p27.PermanentItems, "2xCrystals");
            end;
        end
    },
    PreventLoss = {
        Type = "Product",
        Id = 3528254008,
        Robux = 0,

        DoesPlayerOwn = function(p30: userdata, p31: any) -- Line: 177, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v32 = Knit.GetService("DataService"):Get(p30);

                return table.find(v32.Data.Data.PermanentItems, "PreventLoss") ~= nil;
            end;

            if p31 then
                return table.find(p31.PermanentItems, "PreventLoss");
            end;

            return false;
        end
    },
    UnlockBase = {
        Type = "Product",
        Id = 3528258312,
        Robux = 0
    },
    CASH_3K = {
        Type = "Product",
        Id = 3528253226,
        Robux = 0
    },
    CASH_25K = {
        Type = "Product",
        Id = 3528253456,
        Robux = 0
    },
    CASH_100K = {
        Type = "Product",
        Id = 3528253536,
        Robux = 0
    },
    CASH_500K = {
        Type = "Product",
        Id = 3528253609,
        Robux = 0
    },
    CASH_1M = {
        Type = "Product",
        Id = 3528253703,
        Robux = 0
    },
    BetterLuck = {
        Type = "Product",
        Id = 3528954841,
        Robux = 0,

        DoesPlayerOwn = function(p33: userdata, p34: any) -- Line: 236, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p34 and p34.PermanentItems then
                    return table.find(p34.PermanentItems, "BetterLuck") ~= nil;
                end;

                return false;
            end;

            local v35 = Knit.GetService("DataService"):Get(p33);
            local v36 = v35.Data.Data.PermanentItems and table.find(v35.Data.Data.PermanentItems, "BetterLuck") ~= nil;

            return v36;
        end
    },
    IncreasedLuck = {
        GamepassId = 1963134727,
        Type = "Product",
        Id = 3612383963,
        Robux = 349,

        DoesPlayerOwn = function(p37: userdata, p38: any) -- Line: 258, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p38 and p38.PermanentItems then
                    return table.find(p38.PermanentItems, "IncreasedLuck") ~= nil;
                end;

                return false;
            end;

            local v39 = Knit.GetService("DataService"):Get(p37);
            local v40 = v39 and v39.Data.Data.PermanentItems and table.find(v39.Data.Data.PermanentItems, "IncreasedLuck") ~= nil;

            return v40;
        end
    },
    AspectHunter = {
        GamepassId = 1963230754,
        Type = "Product",
        Id = 3612384052,
        Robux = 449,

        DoesPlayerOwn = function(p41: userdata, p42: any) -- Line: 282, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p42 and p42.PermanentItems then
                    return table.find(p42.PermanentItems, "AspectHunter") ~= nil;
                end;

                return false;
            end;

            local v43 = Knit.GetService("DataService"):Get(p41);
            local v44 = v43 and v43.Data.Data.PermanentItems and table.find(v43.Data.Data.PermanentItems, "AspectHunter") ~= nil;

            return v44;
        end
    },
    FrozenChest_1x = {
        Type = "Product",
        Id = 3530041438,
        Robux = 0
    },
    FrozenChest_5x = {
        Type = "Product",
        Id = 3530041437,
        Robux = 0
    },
    CoyoteChest_1x = {
        Type = "Product",
        Id = 3531431756,
        Robux = 0
    },
    CoyoteChest_5x = {
        Type = "Product",
        Id = 3531431755,
        Robux = 0
    },
    Chainsaws = {
        Type = "Product",
        Id = 3528921109,
        Robux = 0,

        DoesPlayerOwn = function(p45: userdata, p46: any) -- Line: 324, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v47 = Knit.GetService("DataService"):Get(p45);

                if v47 then
                    v47 = table.find(v47.Data.Data.Owned_Weapons, "Chainsaws") ~= nil;
                end;

                return v47;
            end;

            if p46 then
                return table.find(p46.Owned_Weapons, "Chainsaws");
            end;
        end
    },
    ["Bomb Touch"] = {
        Type = "Product",
        Id = 3529047824,
        Robux = 0,

        DoesPlayerOwn = function(p48: userdata, p49: any) -- Line: 341, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v50 = Knit.GetService("DataService"):Get(p48);

                if v50 then
                    v50 = table.find(v50.Data.Data.Owned_Weapons, "Bomb Touch") ~= nil;
                end;

                return v50;
            end;

            if p49 then
                return table.find(p49.Owned_Weapons, "Bomb Touch");
            end;
        end
    },
    REROLL_QUESTS = {
        Type = "Product",
        Id = 3530041599,
        Robux = 45
    },
    FINISH_ALL = {
        Type = "Product",
        Id = 3530298405,
        Robux = 199
    },
    SkipChestSpin = {
        Type = "Product",
        Id = 3530866098,
        Robux = 0,

        DoesPlayerOwn = function(p51: userdata, p52: any) -- Line: 372, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p52 then
                    return table.find(p52.PermanentItems, "SkipChestSpin") ~= nil;
                end;

                return false;
            end;

            local v53 = Knit.GetService("DataService"):Get(p51);
            local v54 = v53 and v53.Data.Data.PermanentItems and table.find(v53.Data.Data.PermanentItems, "SkipChestSpin") ~= nil;

            return v54;
        end
    },
    VIP = {
        GamepassId = 1962888726,
        Type = "Product",
        Id = 3530883966,
        Robux = 120,

        DoesPlayerOwn = function(p55: userdata, p56: any) -- Line: 389, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v57 = Knit.GetService("DataService"):Get(p55);

                if v57 then
                    v57 = v57.Data.Data.VIP;
                end;

                return v57;
            end;

            if p56 then
                return p56.VIP;
            end;
        end
    },
    ["Steal Common"] = {
        Type = "Product",
        Id = 3536320582,
        Robux = 0
    },
    ["Steal Uncommon"] = {
        Type = "Product",
        Id = 3536320708,
        Robux = 0
    },
    ["Steal Rare"] = {
        Type = "Product",
        Id = 3536320792,
        Robux = 0
    },
    ["Steal Epic"] = {
        Type = "Product",
        Id = 3536320911,
        Robux = 0
    },
    ["Steal Legendary"] = {
        Type = "Product",
        Id = 3536321122,
        Robux = 0
    },
    ["Steal Mythic"] = {
        Type = "Product",
        Id = 3536321259,
        Robux = 0
    },
    ["Steal Celestial"] = {
        Type = "Product",
        Id = 3536321361,
        Robux = 0
    },
    Stone_Common_x1 = {
        Type = "Product",
        Id = 3538075817,
        Robux = 5
    },
    Stone_Common_x10 = {
        Type = "Product",
        Id = 3538075889,
        Robux = 35
    },
    Stone_Uncommon_x1 = {
        Type = "Product",
        Id = 3538076165,
        Robux = 5
    },
    Stone_Uncommon_x10 = {
        Type = "Product",
        Id = 3538076212,
        Robux = 35
    },
    Stone_Rare_x1 = {
        Type = "Product",
        Id = 3538076267,
        Robux = 10
    },
    Stone_Rare_x10 = {
        Type = "Product",
        Id = 3538076319,
        Robux = 75
    },
    Stone_Epic_x1 = {
        Type = "Product",
        Id = 3538076413,
        Robux = 15
    },
    Stone_Epic_x10 = {
        Type = "Product",
        Id = 3538076471,
        Robux = 99
    },
    Stone_Legendary_x1 = {
        Type = "Product",
        Id = 3538076688,
        Robux = 25
    },
    Stone_Legendary_x10 = {
        Type = "Product",
        Id = 3538076736,
        Robux = 175
    },
    Stone_Mythic_x1 = {
        Type = "Product",
        Id = 3538076800,
        Robux = 49
    },
    Stone_Mythic_x10 = {
        Type = "Product",
        Id = 3538076869,
        Robux = 349
    },
    Stone_Celestial_x1 = {
        Type = "Product",
        Id = 3538076945,
        Robux = 75
    },
    Stone_Celestial_x10 = {
        Type = "Product",
        Id = 3538076985,
        Robux = 499
    },
    WeaponTier_Common = {
        Type = "Product",
        Id = 3540166696,
        Robux = 0
    },
    WeaponTier_Uncommon = {
        Type = "Product",
        Id = 3540166742,
        Robux = 0
    },
    WeaponTier_Rare = {
        Type = "Product",
        Id = 3540166828,
        Robux = 0
    },
    WeaponTier_Epic = {
        Type = "Product",
        Id = 3540166889,
        Robux = 0
    },
    WeaponTier_Legendary = {
        Type = "Product",
        Id = 3540166951,
        Robux = 0
    },
    WeaponTier_Mythic = {
        Type = "Product",
        Id = 3540167004,
        Robux = 0
    },
    WeaponTier_Celestial = {
        Type = "Product",
        Id = 3540167057,
        Robux = 0
    },
    Cosmetic_Tier1 = {
        Type = "Product",
        Id = 3627002458,
        Robux = 129
    },
    Cosmetic_Tier2 = {
        Type = "Product",
        Id = 3627007214,
        Robux = 249
    },
    Cosmetic_Tier3 = {
        Type = "Product",
        Id = 3627009652,
        Robux = 449
    },
    Cosmetic_Tier4 = {
        Type = "Product",
        Id = 3627011420,
        Robux = 649
    },
    Emote_Tier1 = {
        Type = "Product",
        Id = 3627099254,
        Robux = 74
    },
    Emote_Tier2 = {
        Type = "Product",
        Id = 3627100619,
        Robux = 129
    },
    Emote_Tier3 = {
        Type = "Product",
        Id = 3627102027,
        Robux = 249
    },
    Emote_Tier4 = {
        Type = "Product",
        Id = 3627103289,
        Robux = 349
    },
    NekoDance = {
        Type = "Product",
        Id = 3682148440,
        Robux = 249
    },
    Founders_Bundle = {
        Type = "Product",
        Id = 3542520048,
        Robux = 4449,

        DoesPlayerOwn = function(p58: userdata, p59: any) -- Line: 509, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v60 = Knit.GetService("DataService"):Get(p58);

                if v60 then
                    v60 = v60.Data.OwnedFoundersBundle;
                end;

                return v60;
            end;

            if p59 then
                return p59.OwnedFoundersBundle;
            end;
        end
    },
    ReleaseBundle = {
        Type = "Product",
        Id = 3542548883,
        Robux = 75,

        DoesPlayerOwn = function(p61: userdata, p62: any) -- Line: 525, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v63 = Knit.GetService("DataService"):Get(p61);

                if v63 then
                    v63 = v63.Data.OwnedReleaseBundle;
                end;

                return v63;
            end;

            if p62 then
                return p62.OwnedReleaseBundle;
            end;
        end
    },
    Massive_Upgrade_Bundle = {
        Type = "Product",
        Id = 3542519234,
        Robux = 0
    },
    Protection_Upgrade_Bundle = {
        Type = "Product",
        Id = 3542519552,
        Robux = 0,

        DoesPlayerOwn = function(p64: userdata, p65: any) -- Line: 547, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v66 = Knit.GetService("DataService"):Get(p64);

                if v66 then
                    v66 = v66.Data.OwnedProtectionUpgradeBundle;
                end;

                return v66;
            end;

            if p65 then
                return p65.OwnedProtectionUpgradeBundle;
            end;
        end
    },
    DungeonRevive = {
        Type = "Product",
        Id = 3544100284,
        Robux = 0
    },
    BossRushRevive = {
        Type = "Product",
        Id = 3579160067,
        Robux = 75
    },
    ExtraPotions1 = {
        Type = "Product",
        Id = 3555092830,
        Robux = 99,

        DoesPlayerOwn = function(p67: userdata, p68: any) -- Line: 578, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p68 and p68.PermanentItems then
                    return table.find(p68.PermanentItems, "ExtraPotions1") ~= nil;
                end;

                return false;
            end;

            local v69 = Knit.GetService("DataService"):Get(p67);
            local v70 = v69 and v69.Data.Data.PermanentItems and table.find(v69.Data.Data.PermanentItems, "ExtraPotions1") ~= nil;

            return v70;
        end
    },
    ExtraPotions2 = {
        Type = "Product",
        Id = 3555092898,
        Robux = 149,

        DoesPlayerOwn = function(p71: userdata, p72: any) -- Line: 593, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p72 and p72.PermanentItems then
                    return table.find(p72.PermanentItems, "ExtraPotions2") ~= nil;
                end;

                return false;
            end;

            local v73 = Knit.GetService("DataService"):Get(p71);
            local v74 = v73 and v73.Data.Data.PermanentItems and table.find(v73.Data.Data.PermanentItems, "ExtraPotions2") ~= nil;

            return v74;
        end
    },
    ["2xClassEXP"] = {
        GamepassId = 1963428763,
        Type = "Product",
        Id = 3555093451,
        Robux = 249,

        DoesPlayerOwn = function(p75: userdata, p76: any) -- Line: 610, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p76 and p76.PermanentItems then
                    return table.find(p76.PermanentItems, "2xClassEXP") ~= nil;
                end;

                return false;
            end;

            local v77 = Knit.GetService("DataService"):Get(p75);
            local v78 = v77 and v77.Data.Data.PermanentItems and table.find(v77.Data.Data.PermanentItems, "2xClassEXP") ~= nil;

            return v78;
        end
    },
    ["2xPlayerEXP"] = {
        GamepassId = 1962762740,
        Type = "Product",
        Id = 3555093405,
        Robux = 249,

        DoesPlayerOwn = function(p79: userdata, p80: any) -- Line: 627, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p80 and p80.PermanentItems then
                    return table.find(p80.PermanentItems, "2xPlayerEXP") ~= nil;
                end;

                return false;
            end;

            local v81 = Knit.GetService("DataService"):Get(p79);
            local v82 = v81 and v81.Data.Data.PermanentItems and table.find(v81.Data.Data.PermanentItems, "2xPlayerEXP") ~= nil;

            return v82;
        end
    },
    DoubleEXPPotion = {
        Type = "Product",
        Id = 3612384278,
        Robux = 75
    },
    LootLuckPotion = {
        Type = "Product",
        Id = 3612384342,
        Robux = 149
    },
    AspectGem = {
        Type = "Product",
        Id = 3612384412,
        Robux = 429
    },
    ProtectionScroll = {
        Type = "Product",
        Id = 3707887286,
        Robux = 75
    },
    PurityStone = {
        Type = "Product",
        Id = 3707887474,
        Robux = 129
    },
    AutoForge = {
        GamepassId = 1962102861,
        Type = "Product",
        Id = 3710333276,
        Robux = 99,

        DoesPlayerOwn = function(p83: userdata, p84: any) -- Line: 687, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p84 and p84.PermanentItems then
                    return table.find(p84.PermanentItems, "AutoForge") ~= nil;
                end;

                return false;
            end;

            local v85 = Knit.GetService("DataService"):Get(p83);
            local v86 = v85 and v85.Data.Data.PermanentItems and table.find(v85.Data.Data.PermanentItems, "AutoForge") ~= nil;

            return v86;
        end
    },
    KeepLoot = {
        Type = "Product",
        Id = 3555093725,
        Robux = 449,

        DoesPlayerOwn = function(p87: userdata, p88: any) -- Line: 705, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p88 and p88.PermanentItems then
                    return table.find(p88.PermanentItems, "KeepLoot") ~= nil;
                end;

                return false;
            end;

            local v89 = Knit.GetService("DataService"):Get(p87);
            local v90 = v89 and v89.Data.Data.PermanentItems and table.find(v89.Data.Data.PermanentItems, "KeepLoot") ~= nil;

            return v90;
        end
    },
    ExtraLife = {
        Type = "Product",
        Id = 3555095556,
        Robux = 345,

        DoesPlayerOwn = function(p91: userdata, p92: any) -- Line: 722, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p92 and p92.PermanentItems then
                    return table.find(p92.PermanentItems, "ExtraLife") ~= nil;
                end;

                return false;
            end;

            local v93 = Knit.GetService("DataService"):Get(p91);
            local v94 = v93 and v93.Data.Data.PermanentItems and table.find(v93.Data.Data.PermanentItems, "ExtraLife") ~= nil;

            return v94;
        end
    },
    ExtraLoot = {
        GamepassId = 1962858722,
        Type = "Product",
        Id = 3612698416,
        Robux = 429,

        DoesPlayerOwn = function(p95: userdata, p96: any) -- Line: 744, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p96 and p96.PermanentItems then
                    return table.find(p96.PermanentItems, "ExtraLoot") ~= nil;
                end;

                return false;
            end;

            local v97 = Knit.GetService("DataService"):Get(p95);
            local v98 = v97 and v97.Data.Data.PermanentItems and table.find(v97.Data.Data.PermanentItems, "ExtraLoot") ~= nil;

            return v98;
        end
    },
    ClassSlotRobux = {
        Type = "Product",
        Id = 3568111919,
        Robux = 134
    },
    NormalSpin_5 = {
        Type = "Product",
        Id = 3555094575,
        Robux = 0
    },
    NormalSpin_20 = {
        Type = "Product",
        Id = 3555094776,
        Robux = 0
    },
    LuckySpin_5 = {
        Type = "Product",
        Id = 3555095027,
        Robux = 0
    },
    LuckySpin_20 = {
        Type = "Product",
        Id = 3555095308,
        Robux = 0
    },
    LuckySpin_1 = {
        Type = "Product",
        Id = 3558595613,
        Robux = 75
    },
    ClassLucky_5 = {
        Type = "Product",
        Id = 3558596647,
        Robux = 325
    },
    ClassLucky_10 = {
        Type = "Product",
        Id = 3558596648,
        Robux = 575
    },
    ClassLucky_20 = {
        Type = "Product",
        Id = 3558596646,
        Robux = 999
    },
    DevelopersBundle = {
        Type = "Product",
        Id = 3557438247,
        Robux = 4450,

        DoesPlayerOwn = function(p99: userdata, p100: any) -- Line: 783, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p100 and p100.ClassItems then
                    return table.find(p100.ClassItems, "Shadow Monarch\'s Dagger") ~= nil;
                end;

                return false;
            end;

            local v101 = Knit.GetService("DataService"):Get(p99);
            local v102 = v101 and v101.Data.Data.ClassItems and table.find(v101.Data.Data.ClassItems, "Shadow Monarch\'s Dagger") ~= nil;

            return v102;
        end
    },
    FoundersClassItem = {
        Type = "Product",
        Id = 3555022662,
        Robux = 4449,

        DoesPlayerOwn = function(p103: userdata, p104: any) -- Line: 801, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p104 then
                    return table.find(p104.ClassItems, "Founder\'s Crest") ~= nil;
                end;

                return false;
            end;

            local v105 = Knit.GetService("DataService"):Get(p103);
            local v106 = v105 and v105.Data.Data.ClassItems and table.find(v105.Data.Data.ClassItems, "Founder\'s Crest") ~= nil;

            return v106;
        end
    },
    GrandSovereignPack = {
        Type = "Product",
        Id = 3644750140,
        Robux = 8449,

        DoesPlayerOwn = function(p107: userdata, p108: any) -- Line: 830, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v109 = Knit.GetService("DataService"):Get(p107);

                if v109 then
                    v109 = v109.Data.Data.OwnedGrandSovereignPack;
                end;

                return v109;
            end;

            if p108 then
                return p108.OwnedGrandSovereignPack;
            end;
        end,

        UnlockTime = UnixTimestamp,
        EndTime = UnixTimestamp2
    },
    ShadowMonarchBundle = {
        Type = "Product",
        Id = 3709085407,
        Robux = 3249,

        DoesPlayerOwn = function(p110: userdata, p111: any) -- Line: 860, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v112 = Knit.GetService("DataService"):Get(p110);

                if v112 then
                    v112 = v112.Data.Data.OwnedShadowMonarchBundle;
                end;

                return v112;
            end;

            if p111 then
                return p111.OwnedShadowMonarchBundle;
            end;
        end,

        UnlockTime = UnixTimestamp,
        EndTime = UnixTimestamp2
    },
    BattlepassPremium = {
        Type = "Product",
        Id = 3566863572,
        Robux = 799,

        DoesPlayerOwn = function(p113: userdata, p114: any) -- Line: 884, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v115 = Knit.GetService("DataService"):Get(p113);

                return v115 and v115.Data.Data.Battlepass and v115.Data.Data.Battlepass.HasPremium;
            end;

            if not p114 then
                return false;
            end;

            return p114.Battlepass and p114.Battlepass.HasPremium;
        end
    },
    BattlepassSkip1 = {
        Type = "Product",
        Id = 3566863252,
        Robux = 99
    },
    BattlepassSkip5 = {
        Type = "Product",
        Id = 3566863339,
        Robux = 399
    },
    BattlepassSkip10 = {
        Type = "Product",
        Id = 3566863442,
        Robux = 699
    },
    ArchonBundle = {
        Type = "Product",
        Id = 3573037421,
        Robux = 250,

        DoesPlayerOwn = function(p116: userdata, p117: any) -- Line: 916, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p117 then
                    return p117.OwnedArchonBundle;
                end;

                return false;
            end;

            local v118 = Knit.GetService("DataService"):Get(p116);

            if v118 then
                v118 = v118.Data.OwnedArchonBundle;
            end;

            return v118;
        end
    },
    EclipseBundle = {
        Type = "Product",
        Id = 3575114851,
        Robux = 250,

        DoesPlayerOwn = function(p119: userdata, p120: any) -- Line: 932, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p120 then
                    return p120.OwnedEclipseBundle;
                end;

                return false;
            end;

            local v121 = Knit.GetService("DataService"):Get(p119);

            if v121 then
                v121 = v121.Data.OwnedEclipseBundle;
            end;

            return v121;
        end
    },
    EastSeasBundle = {
        Type = "Product",
        Id = 3576679001,
        Robux = 400,

        DoesPlayerOwn = function(p122: userdata, p123: any) -- Line: 948, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p123 then
                    return p123.OwnedEastSeasBundle;
                end;

                return false;
            end;

            local v124 = Knit.GetService("DataService"):Get(p122);

            if v124 then
                v124 = v124.Data.OwnedEastSeasBundle;
            end;

            return v124;
        end
    },
    SeaDemonBundle = {
        Type = "Product",
        Id = 3612401334,
        Robux = 349,

        DoesPlayerOwn = function(p125: userdata, p126: any) -- Line: 964, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p126 then
                    return p126.OwnedSeaDemonBundle;
                end;

                return false;
            end;

            local v127 = Knit.GetService("DataService"):Get(p125);

            if v127 then
                v127 = v127.Data.OwnedSeaDemonBundle;
            end;

            return v127;
        end
    },
    BlackSwordsmanBundle = {
        Type = "Product",
        Id = 3612401723,
        Robux = 249,

        DoesPlayerOwn = function(p128: userdata, p129: any) -- Line: 980, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p129 then
                    return p129.OwnedBlackSwordsmanBundle;
                end;

                return false;
            end;

            local v130 = Knit.GetService("DataService"):Get(p128);

            if v130 then
                v130 = v130.Data.OwnedBlackSwordsmanBundle;
            end;

            return v130;
        end
    },
    SunCladBundle = {
        Type = "Product",
        Id = 3612401887,
        Robux = 249,

        DoesPlayerOwn = function(p131: userdata, p132: any) -- Line: 996, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p132 then
                    return p132.OwnedSunCladBundle;
                end;

                return false;
            end;

            local v133 = Knit.GetService("DataService"):Get(p131);

            if v133 then
                v133 = v133.Data.OwnedSunCladBundle;
            end;

            return v133;
        end
    },
    GuildmasterBundle = {
        Type = "Product",
        Id = 3612402065,
        Robux = 349,

        DoesPlayerOwn = function(p134: userdata, p135: any) -- Line: 1012, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p135 then
                    return p135.OwnedGuildmasterBundle;
                end;

                return false;
            end;

            local v136 = Knit.GetService("DataService"):Get(p134);

            if v136 then
                v136 = v136.Data.OwnedGuildmasterBundle;
            end;

            return v136;
        end
    },
    JetstreamBundle = {
        Type = "Product",
        Id = 3581022825,
        Robux = 799,

        DoesPlayerOwn = function(p137: userdata, p138: any) -- Line: 1032, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p138 then
                    return p138.OwnedJetstreamBundle;
                end;

                return false;
            end;

            local v139 = Knit.GetService("DataService"):Get(p137);

            if v139 then
                v139 = v139.Data.OwnedJetstreamBundle;
            end;

            return v139;
        end
    },
    GoodbyeBundle = {
        Type = "Product",
        Id = 3582707553,
        Robux = 15,

        DoesPlayerOwn = function(p140: userdata, p141: any) -- Line: 1049, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if not u1 then
                if p141 then
                    return p141.OwnedGoodbyeBundle;
                end;

                return false;
            end;

            local v142 = Knit.GetService("DataService"):Get(p140);

            if v142 then
                v142 = v142.Data.OwnedGoodbyeBundle;
            end;

            return v142;
        end
    },
    Supporter_Bundle = {
        Type = "Product",
        Id = 3611390416,
        Robux = 15,

        DoesPlayerOwn = function(p143: userdata, p144: any) -- Line: 1069, Name: DoesPlayerOwn
            -- upvalues: u1 (copy), Knit (copy)
            if u1 then
                local v145 = Knit.GetService("DataService"):Get(p143);

                if v145 then
                    v145 = v145.Data.OwnedSupporterBundle;
                end;

                return v145;
            end;

            if p144 then
                return p144.OwnedSupporterBundle;
            end;
        end
    },
    Enchanted_Bundle = {
        Type = "Product",
        Id = 3611390543,
        Robux = 249
    },
    Enchanted_Bundle_Plus = {
        Type = "Product",
        Id = 3611390718,
        Robux = 349
    },
    Kickstart_Bundle = {
        Type = "Product",
        Id = 3611390857,
        Robux = 124
    }
};