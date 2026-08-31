--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiveItemServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.GiveItemServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local Players = game:GetService("Players");
local MessagingService = game:GetService("MessagingService");
local HttpService = game:GetService("HttpService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local GameInfo = ReplicatedStorage.GameInfo;
local PotionData = require(GameInfo.PotionData);
local BuffPotionData = require(GameInfo.BuffPotionData);
local ConsumableData = require(GameInfo.ConsumableData);
require(ServerStorage:WaitForChild("Modules"):WaitForChild("RewardGranter"));

local function GiveToPlayer(p1: userdata, p2: string, p3: number) -- Line: 36
    -- upvalues: Knit (copy), PotionData (copy), BuffPotionData (copy), ConsumableData (copy), ReplicatedStorage (copy), GameInfo (copy)
    local Service = Knit.GetService("DataService");
    local v4 = Service:Get(p1);

    if not v4 then
        return `Failed: No data found for {p1.Name}`;
    end;

    if p2 == "Coins" then
        Service:Increment(p1, { "Currency" }, p3);

        return `Gave {p1.Name} x{p3} Coins`;
    end;

    if p2 == "Stars" then
        Service:Increment(p1, { "Stars" }, p3);

        return `Gave {p1.Name} x{p3} Stars`;
    end;

    if p2 == "NormalSpins" then
        Knit.GetService("SummoningService"):GrantSpins(p1, "Normal", p3);

        return `Gave {p1.Name} x{p3} Normal Spins`;
    end;

    if p2 == "LuckySpins" then
        Knit.GetService("SummoningService"):GrantSpins(p1, "Lucky", p3);

        return `Gave {p1.Name} x{p3} Lucky Spins`;
    end;

    if p2:sub(1, 7) == "Potion:" then
        local v5 = p2:sub(8);
        local Potion = PotionData.GetPotion(v5);

        if not Potion then
            return `Unknown potion: {v5}`;
        end;

        Knit.GetService("PotionService"):AddPotions(p1, v5, p3);

        return `Gave {p1.Name} x{p3} {Potion.Name}`;
    end;

    if p2:sub(1, 5) == "Buff:" then
        local v6 = p2:sub(6);
        local Potion = BuffPotionData.GetPotion(v6);

        if not Potion then
            return `Unknown buff potion: {v6}`;
        end;

        local v7 = v4.Data.Data.BuffPotions or {};
        v7[v6] = (v7[v6] or 0) + p3;
        Service:Set(p1, { "BuffPotions" }, v7);

        return `Gave {p1.Name} x{p3} {Potion.Name}`;
    end;

    if p2:sub(1, 11) == "Consumable:" then
        local v8 = p2:sub(12);
        local Consumable = ConsumableData.GetConsumable(v8);

        if not Consumable then
            return `Unknown consumable: {v8}`;
        end;

        Knit.GetService("ConsumableService"):Grant(p1, v8, p3);

        return `Gave {p1.Name} x{p3} {Consumable.Name}`;
    end;

    if p2:sub(1, 5) == "Perk:" then
        local v9 = p2:sub(6);
        local v10 = require(game:GetService("ServerScriptService").Management.MonetizationFunctions).ByName[v9];

        if not v10 then
            return `Unknown perk: {v9}`;
        end;

        if v10(p1) then
            return `Gave {p1.Name} perk: {v9}`;
        end;

        return `{p1.Name} already owns {v9} (or grant was rejected)`;
    end;

    if p2:sub(1, 8) == "Package:" then
        local v11 = p2:sub(9);
        local v12 = require(ReplicatedStorage.GameInfo.PackageData).Get(v11);

        if not v12 then
            return `Unknown package: {v11}`;
        end;

        Service:Set(p1, { "Packs", v11 }, (v4.Data.Data.Packs and (v4.Data.Data.Packs[v11] or 0) or 0) + p3);

        return `Gave {p1.Name} x{p3} {v12.Name} (stored in inventory)`;
    end;

    if p2:sub(1, 9) == "Cosmetic:" then
        local v13 = p2:sub(10);
        local v14, v15 = Knit.GetService("CosmeticService"):Grant(p1, v13);

        if v14 then
            return `Gave {p1.Name} cosmetic set: {v13}`;
        end;

        return `Failed to grant cosmetic "{v13}": {v15 or "unknown error"}`;
    end;

    if p2:sub(1, 6) == "Title:" then
        local v16 = p2:sub(7);

        if Knit.GetService("TitleService"):UnlockTitle(p1, v16) then
            return `Gave {p1.Name} title: {v16}`;
        end;

        return `Failed to unlock title "{v16}" for {p1.Name}`;
    end;

    if p2:sub(1, 9) == "Material:" then
        local v17 = p2:sub(10);
        local v18 = v4.Data.Data.CraftingMaterials or {};
        local v19 = (v18[v17] or 0) + p3;
        v18[v17] = v19;
        Service:Set(p1, { "CraftingMaterials" }, v18);

        return `Gave {p1.Name} x{p3} {v17} (now has {v19})`;
    end;

    if p2 == "BattlepassXP" then
        local success, result = pcall(Knit.GetService, Knit, "BattlepassService");

        if not (success and result) then
            return "Failed: BattlepassService not available";
        end;

        result:GrantBattlepassXP(p1, p3, "Admin");

        return `Gave {p1.Name} x{p3} Battlepass XP`;
    end;

    if p2:sub(1, 10) ~= "QuestItem:" then
        return `Unknown item: {p2}`;
    end;

    local v20 = p2:sub(11);
    local v21 = require(GameInfo.QuestItemData).Get(v20);

    if not v21 then
        return `Unknown quest item: {v20}`;
    end;

    if Knit.GetService("QuestItemService"):GrantItem(p1, v20, p3) then
        return `Gave {p1.Name} x{p3} {v21.DisplayName}`;
    end;

    return `Failed to grant "{v20}" to {p1.Name} (may be at max)`;
end;

local function GiveToServer(p22: string, p23: number) -- Line: 196
    -- upvalues: Players (copy), GiveToPlayer (copy)
    local Players2 = Players:GetPlayers();
    local v24 = 0;

    for _, v in ipairs(Players2) do
        local v25 = GiveToPlayer(v, p22, p23);

        if v25:sub(1, 4) == "Gave" then
            v24 = v24 + 1;
        else
            warn((`[GiveItem:server] {v25}`));
        end;
    end;

    return `[Server] Gave x{p23} {p22} to {v24}/{#Players2} players`;
end;

local function GiveToGlobal(p26: string, p27: number) -- Line: 216
    -- upvalues: HttpService (copy), MessagingService (copy)
    local u28 = HttpService:JSONEncode({
        ItemId = p26,
        Amount = p27
    });
    task.spawn(function() -- Line: 224
        -- upvalues: MessagingService (ref), u28 (copy)
        local success, result = pcall(function() -- Line: 225
            -- upvalues: MessagingService (ref), u28 (ref)
            MessagingService:PublishAsync("GlobalGiveItem_V1", u28);
        end);

        if not success then
            warn((`[GiveItem:global] MessagingService publish failed: {result}`));
        end;
    end);

    return `[Global] Broadcast x{p27} {p26} to all servers`;
end;

return function(p29, p30, p31, p32, p33) -- Line: 240
    -- upvalues: GiveToServer (copy), GiveToGlobal (copy), GiveToPlayer (copy)
    local math_max_ret = math.max(1, p32 or 1);
    local v34 = p33 or "player";

    if v34 == "server" then
        return GiveToServer(p31, math_max_ret);
    end;

    if v34 == "global" then
        return GiveToGlobal(p31, math_max_ret);
    end;

    return GiveToPlayer(p30, p31, math_max_ret);
end;