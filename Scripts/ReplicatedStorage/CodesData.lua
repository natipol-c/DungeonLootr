--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CodesData
  Path:     game.ReplicatedStorage.GameInfo.CodesData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1;

if game:GetService("RunService"):IsServer() then
    u1 = require(ReplicatedStorage.Packages.Knit);
else
    u1 = nil;
end;

local v42 = {
    AddCurrency = function(u2: number) -- Line: 47, Name: AddCurrency
        -- upvalues: u1 (ref)
        return function(p3) -- Line: 48
            -- upvalues: u1 (ref), u2 (copy)
            u1.GetService("DataService"):Increment(p3, { "Currency" }, u2);
            u1.GetService("NotificationService"):SendMessageToPlr(p3, "CODE_CURRENCY", u2);

            return true;
        end;
    end,

    UnlockTitle = function(u4: string) -- Line: 56, Name: UnlockTitle
        -- upvalues: u1 (ref)
        return function(p5) -- Line: 57
            -- upvalues: u1 (ref), u4 (copy)
            if u1.GetService("TitleService"):UnlockTitle(p5, u4) then
                return true;
            end;

            return false, "Title already unlocked or doesn\'t exist";
        end;
    end,

    UnlockWeapon = function(u6: string) -- Line: 68, Name: UnlockWeapon
        -- upvalues: u1 (ref)
        return function(p7) -- Line: 69
            -- upvalues: u1 (ref), u6 (copy)
            if not u1.GetService("WeaponService"):UnlockWeapon(p7, u6) then
                return false, "Weapon already owned or doesn\'t exist";
            end;

            u1.GetService("NotificationService"):SendMessageToPlr(p7, "WEAPON_UNLOCKED", u6);

            return true;
        end;
    end,

    GrantHero = function(u8: string) -- Line: 80, Name: GrantHero
        -- upvalues: u1 (ref)
        return function(p9) -- Line: 81
            -- upvalues: u1 (ref), u8 (copy)
            if not u1.GetService("InventoryService"):AddItem(p9, u8, true) then
                return false, "No inventory space or item doesn\'t exist";
            end;

            u1.GetService("NotificationService"):SendMessageToPlr(p9, "CODE_HERO", u8);

            return true;
        end;
    end,

    AwardTool = function(u10: string, p11: boolean?) -- Line: 92, Name: AwardTool
        -- upvalues: u1 (ref)
        local u12 = p11 ~= false;

        return function(p13) -- Line: 94
            -- upvalues: u1 (ref), u10 (copy), u12 (ref)
            if not u1.GetService("ToolsService"):AwardTool(p13, u10, u12) then
                return false, "Tool already owned or doesn\'t exist";
            end;

            u1.GetService("NotificationService"):SendMessageToPlr(p13, "CODE_TOOL", u10);

            return true;
        end;
    end,

    AddRebirths = function(u14: number) -- Line: 105, Name: AddRebirths
        -- upvalues: u1 (ref)
        return function(p15) -- Line: 106
            -- upvalues: u1 (ref), u14 (copy)
            u1.GetService("DataService"):Increment(p15, { "Rebirths" }, u14);
            u1.GetService("NotificationService"):SendMessageToPlr(p15, "CODE_REBIRTHS", u14);

            return true;
        end;
    end,

    GrantPackage = function(u16: string, u17: string, p18: number?) -- Line: 114, Name: GrantPackage
        -- upvalues: u1 (ref)
        local u19 = p18 or 1;

        return function(p20) -- Line: 116
            -- upvalues: u1 (ref), u16 (copy), u19 (ref), u17 (copy)
            local Service = u1.GetService("DataService");
            local v21 = Service:Get(p20);

            if not v21 then
                return false, "NoData";
            end;

            Service:Set(p20, { "Packs", u16 }, (v21.Data.Data.Packs and v21.Data.Data.Packs[u16] or 0) + u19);
            u1.GetService("NotificationService"):SendMessageToPlr(p20, "CHEST_TO_INVENTORY", u17, u19);

            return true;
        end;
    end,

    GrantConsumable = function(u22: string, u23: string, u24: number) -- Line: 130, Name: GrantConsumable
        -- upvalues: u1 (ref)
        return function(p25) -- Line: 131
            -- upvalues: u1 (ref), u22 (copy), u24 (copy), u23 (copy)
            u1.GetService("ConsumableService"):Grant(p25, u22, u24);
            u1.GetService("NotificationService"):SendMessageToPlr(p25, "CHEST_TO_INVENTORY", u23, u24);

            return true;
        end;
    end,

    GrantBuffPotion = function(u26: string, u27: string, u28: number) -- Line: 142, Name: GrantBuffPotion
        -- upvalues: u1 (ref)
        return function(p29) -- Line: 143
            -- upvalues: u1 (ref), u26 (copy), u28 (copy), u27 (copy)
            local Service = u1.GetService("DataService");
            local v30 = Service:Get(p29);

            if not v30 then
                return false, "NoData";
            end;

            local v31 = v30.Data.Data.BuffPotions or {};
            v31[u26] = (v31[u26] or 0) + u28;
            Service:Set(p29, { "BuffPotions" }, v31);
            u1.GetService("NotificationService"):SendMessageToPlr(p29, "CHEST_TO_INVENTORY", u27, u28);

            return true;
        end;
    end,

    GrantCraftingMaterial = function(u32: string, u33: number) -- Line: 157, Name: GrantCraftingMaterial
        -- upvalues: u1 (ref)
        return function(p34) -- Line: 158
            -- upvalues: u1 (ref), u32 (copy), u33 (copy)
            local Service = u1.GetService("DataService");
            local v35 = Service:Get(p34);

            if not v35 then
                return false, "NoData";
            end;

            Service:Set(p34, { "CraftingMaterials", u32 }, ((v35.Data.Data.CraftingMaterials or {})[u32] or 0) + u33);

            return true;
        end;
    end,

    MultiReward = function(u36: table) -- Line: 171, Name: MultiReward
        return function(p37) -- Line: 172
            -- upvalues: u36 (copy)
            local v38 = true;
            local v39 = nil;

            for _, v in ipairs(u36) do
                local v40, v41 = v(p37);

                if not v40 then
                    v39 = v41;
                    v38 = false;
                end;
            end;

            return v38, v39;
        end;
    end
};

local function GrantSpinsAndCurrency(u43: number?, u44: number?, u45: number?) -- Line: 195
    -- upvalues: u1 (ref)
    return function(p46) -- Line: 196
        -- upvalues: u1 (ref), u45 (copy), u43 (copy), u44 (copy)
        local Service = u1.GetService("DataService");
        local Service2 = u1.GetService("SummoningService");

        if u45 and u45 > 0 then
            Service:Increment(p46, { "Currency" }, u45);
        end;

        if u43 and u43 > 0 then
            Service2:GrantSpins(p46, "Normal", u43);
        end;

        if u44 and u44 > 0 then
            Service2:GrantSpins(p46, "Lucky", u44);
        end;

        u1.GetService("NotificationService"):SendMessageToPlr(p46, "CODE_CUSTOM");

        return true;
    end;
end;

local v47 = {};
local v48 = {
    Active = true
};
local u49 = 1000;
local u50 = 10;
local u51 = 3;

function v48.Reward(p52) -- Line: 196
    -- upvalues: u1 (ref), u49 (copy), u50 (copy), u51 (copy)
    local Service = u1.GetService("DataService");
    local Service2 = u1.GetService("SummoningService");

    if u49 and u49 > 0 then
        Service:Increment(p52, { "Currency" }, u49);
    end;

    if u50 and u50 > 0 then
        Service2:GrantSpins(p52, "Normal", u50);
    end;

    if u51 and u51 > 0 then
        Service2:GrantSpins(p52, "Lucky", u51);
    end;

    u1.GetService("NotificationService"):SendMessageToPlr(p52, "CODE_CUSTOM");

    return true;
end;

v47.RELEASE = v48;
local v53 = {
    Active = true
};
local MultiReward = v42.MultiReward;
local v54 = {};
local u55 = 1000;
local u56 = 0;
local u57 = 5;
v54[1], v54[2] = v42.GrantPackage("RandomGMBlessing", "Random GM Blessing", 1), function(p58) -- Line: 196
    -- upvalues: u1 (ref), u55 (copy), u56 (copy), u57 (copy)
    local Service = u1.GetService("DataService");
    local Service2 = u1.GetService("SummoningService");

    if u55 and u55 > 0 then
        Service:Increment(p58, { "Currency" }, u55);
    end;

    if u56 and u56 > 0 then
        Service2:GrantSpins(p58, "Normal", u56);
    end;

    if u57 and u57 > 0 then
        Service2:GrantSpins(p58, "Lucky", u57);
    end;

    u1.GetService("NotificationService"):SendMessageToPlr(p58, "CODE_CUSTOM");

    return true;
end;
v53.Reward = MultiReward(v54);
v47.LOOTR = v53;
local v59 = {
    Active = true,
    RequiresRole = "Content Creator"
};
local MultiReward2 = v42.MultiReward;
local v60 = {};
local u61 = 5000;
local u62 = 50;
local u63 = 25;
v60[1], v60[2] = v42.GrantPackage("RandomGMBlessing", "Random GM Blessing", 5), function(p64) -- Line: 196
    -- upvalues: u1 (ref), u61 (copy), u62 (copy), u63 (copy)
    local Service = u1.GetService("DataService");
    local Service2 = u1.GetService("SummoningService");

    if u61 and u61 > 0 then
        Service:Increment(p64, { "Currency" }, u61);
    end;

    if u62 and u62 > 0 then
        Service2:GrantSpins(p64, "Normal", u62);
    end;

    if u63 and u63 > 0 then
        Service2:GrantSpins(p64, "Lucky", u63);
    end;

    u1.GetService("NotificationService"):SendMessageToPlr(p64, "CODE_CUSTOM");

    return true;
end;
v59.Reward = MultiReward2(v60);
v47.CCPACK = v59;
local v65 = {
    Active = true,
    RequiresRole = "Tester"
};
local MultiReward3 = v42.MultiReward;
local v66 = {};
local u67 = 2500;
local u68 = 25;
local u69 = 10;
v66[1], v66[2] = v42.GrantPackage("RandomGMBlessing", "Random GM Blessing", 3), function(p70) -- Line: 196
    -- upvalues: u1 (ref), u67 (copy), u68 (copy), u69 (copy)
    local Service = u1.GetService("DataService");
    local Service2 = u1.GetService("SummoningService");

    if u67 and u67 > 0 then
        Service:Increment(p70, { "Currency" }, u67);
    end;

    if u68 and u68 > 0 then
        Service2:GrantSpins(p70, "Normal", u68);
    end;

    if u69 and u69 > 0 then
        Service2:GrantSpins(p70, "Lucky", u69);
    end;

    u1.GetService("NotificationService"):SendMessageToPlr(p70, "CODE_CUSTOM");

    return true;
end;
v65.Reward = MultiReward3(v66);
v47.TESTER = v65;
v47.FORGESKIP = {
    Active = true,
    Reward = v42.MultiReward({ v42.GrantPackage("ForgeStonePackage", "Forge Stone Bundle", 3), v42.GrantPackage("ReforgeStonePackage", "Reforge Stone Bundle", 3) })
};
local v71 = {
    Active = true
};
local u72 = 0;
local u73 = 30;
local u74 = 30;

function v71.Reward(p75) -- Line: 196
    -- upvalues: u1 (ref), u72 (copy), u73 (copy), u74 (copy)
    local Service = u1.GetService("DataService");
    local Service2 = u1.GetService("SummoningService");

    if u72 and u72 > 0 then
        Service:Increment(p75, { "Currency" }, u72);
    end;

    if u73 and u73 > 0 then
        Service2:GrantSpins(p75, "Normal", u73);
    end;

    if u74 and u74 > 0 then
        Service2:GrantSpins(p75, "Lucky", u74);
    end;

    u1.GetService("NotificationService"):SendMessageToPlr(p75, "CODE_CUSTOM");

    return true;
end;

v47["8KLIKE"] = v71;
local v76 = {
    Active = true
};
local u77 = 0;
local u78 = 30;
local u79 = 45;

function v76.Reward(p80) -- Line: 196
    -- upvalues: u1 (ref), u77 (copy), u78 (copy), u79 (copy)
    local Service = u1.GetService("DataService");
    local Service2 = u1.GetService("SummoningService");

    if u77 and u77 > 0 then
        Service:Increment(p80, { "Currency" }, u77);
    end;

    if u78 and u78 > 0 then
        Service2:GrantSpins(p80, "Normal", u78);
    end;

    if u79 and u79 > 0 then
        Service2:GrantSpins(p80, "Lucky", u79);
    end;

    u1.GetService("NotificationService"):SendMessageToPlr(p80, "CODE_CUSTOM");

    return true;
end;

v47["10KFAV"] = v76;
local v81 = {
    Active = true,
    RequiresRole = "Content Creator"
};
local u82 = 100000;
local u83 = 100;
local u84 = 100;

function v81.Reward(p85) -- Line: 196
    -- upvalues: u1 (ref), u82 (copy), u83 (copy), u84 (copy)
    local Service = u1.GetService("DataService");
    local Service2 = u1.GetService("SummoningService");

    if u82 and u82 > 0 then
        Service:Increment(p85, { "Currency" }, u82);
    end;

    if u83 and u83 > 0 then
        Service2:GrantSpins(p85, "Normal", u83);
    end;

    if u84 and u84 > 0 then
        Service2:GrantSpins(p85, "Lucky", u84);
    end;

    u1.GetService("NotificationService"):SendMessageToPlr(p85, "CODE_CUSTOM");

    return true;
end;

v47.CC_RELEASE = v81;
local v86 = {
    Active = true
};
local MultiReward4 = v42.MultiReward;
local v87 = {};
local u88 = 25000;
local u89 = 25;
local u90 = 25;
v87[1], v87[2] = function(p91) -- Line: 196
    -- upvalues: u1 (ref), u88 (copy), u89 (copy), u90 (copy)
    local Service = u1.GetService("DataService");
    local Service2 = u1.GetService("SummoningService");

    if u88 and u88 > 0 then
        Service:Increment(p91, { "Currency" }, u88);
    end;

    if u89 and u89 > 0 then
        Service2:GrantSpins(p91, "Normal", u89);
    end;

    if u90 and u90 > 0 then
        Service2:GrantSpins(p91, "Lucky", u90);
    end;

    u1.GetService("NotificationService"):SendMessageToPlr(p91, "CODE_CUSTOM");

    return true;
end, v42.GrantBuffPotion("LuckPotionT3", "Luck Potion III", 3);
v86.Reward = MultiReward4(v87);
v47.FULLRELEASE = v86;
local v92 = {
    Active = true
};
local MultiReward5 = v42.MultiReward;
local v93 = {};
local u94 = 0;
local u95 = 10;
local u96 = 0;
v93[1], v93[2] = v42.GrantPackage("ForgeStonePackage", "Forge Stone Bundle", 3), function(p97) -- Line: 196
    -- upvalues: u1 (ref), u94 (copy), u95 (copy), u96 (copy)
    local Service = u1.GetService("DataService");
    local Service2 = u1.GetService("SummoningService");

    if u94 and u94 > 0 then
        Service:Increment(p97, { "Currency" }, u94);
    end;

    if u95 and u95 > 0 then
        Service2:GrantSpins(p97, "Normal", u95);
    end;

    if u96 and u96 > 0 then
        Service2:GrantSpins(p97, "Lucky", u96);
    end;

    u1.GetService("NotificationService"):SendMessageToPlr(p97, "CODE_CUSTOM");

    return true;
end;
v92.Reward = MultiReward5(v93);
v47.LOOTRISBACK = v92;
local v98 = {
    Active = true
};
local MultiReward6 = v42.MultiReward;
local v99 = {};
local u100 = 0;
local u101 = 0;
local u102 = 15;
v99[1], v99[2] = v42.GrantBuffPotion("LuckPotionT3", "Luck Potion III", 5), function(p103) -- Line: 196
    -- upvalues: u1 (ref), u100 (copy), u101 (copy), u102 (copy)
    local Service = u1.GetService("DataService");
    local Service2 = u1.GetService("SummoningService");

    if u100 and u100 > 0 then
        Service:Increment(p103, { "Currency" }, u100);
    end;

    if u101 and u101 > 0 then
        Service2:GrantSpins(p103, "Normal", u101);
    end;

    if u102 and u102 > 0 then
        Service2:GrantSpins(p103, "Lucky", u102);
    end;

    u1.GetService("NotificationService"):SendMessageToPlr(p103, "CODE_CUSTOM");

    return true;
end;
v98.Reward = MultiReward6(v99);
v47.JACKPOT = v98;
v47["20KPLAYERS"] = {
    Active = true,
    Reward = v42.GrantPackage("ReforgeStonePackage", "Reforge Stone Bundle", 5)
};
v47.GIVEMEGEMSPLEASE = {
    Active = true,
    Reward = v42.GrantConsumable("AspectGem", "Aspect Gem", 3)
};

return {
    GROUP_ID = 110427303,
    Codes = v47,
    Helpers = v42
};