--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiveableItem
  Path:     game.ReplicatedStorage.CmdrClient.Types.GiveableItem
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

local GameInfo = game:GetService("ReplicatedStorage"):WaitForChild("GameInfo");
local PotionData = require(GameInfo:WaitForChild("PotionData"));
local BuffPotionData = require(GameInfo:WaitForChild("BuffPotionData"));
local PackageData = require(GameInfo:WaitForChild("PackageData"));
local CosmeticData = require(GameInfo:WaitForChild("CosmeticData"));
local TitleData = require(GameInfo:WaitForChild("TitleData"));
local QuestItemData = require(GameInfo:WaitForChild("QuestItemData"));
local ItemData = require(GameInfo:WaitForChild("ItemData"));
local ConsumableData = require(GameInfo:WaitForChild("ConsumableData"));
local u1 = { "IncreasedLuck", "2xPlayerEXP", "2xClassEXP", "AspectHunter" };

local function BuildItemList() -- Line: 24
    -- upvalues: PotionData (copy), BuffPotionData (copy), ConsumableData (copy), u1 (copy), PackageData (copy), CosmeticData (copy), TitleData (copy), QuestItemData (copy), ItemData (copy)
    local v2 = {};
    table.insert(v2, "Coins");
    table.insert(v2, "Stars");
    table.insert(v2, "NormalSpins");
    table.insert(v2, "LuckySpins");

    for _, v in ipairs(PotionData.Potions) do
        table.insert(v2, "Potion:" .. v.Id);
    end;

    for _, v in ipairs(BuffPotionData.Potions) do
        table.insert(v2, "Buff:" .. v.Id);
    end;

    for _, v in ipairs(ConsumableData.Consumables) do
        table.insert(v2, "Consumable:" .. v.Id);
    end;

    for _, v in ipairs(u1) do
        table.insert(v2, "Perk:" .. v);
    end;

    for i, _ in PackageData.Packages do
        table.insert(v2, "Package:" .. i);
    end;

    for _, v in CosmeticData.GetAll() do
        table.insert(v2, "Cosmetic:" .. v);
    end;

    for i, _ in TitleData.Titles do
        table.insert(v2, "Title:" .. i);
    end;

    for i, _ in QuestItemData.Items do
        table.insert(v2, "QuestItem:" .. i);
    end;

    for i in ItemData.Index do
        table.insert(v2, "Material:" .. i);
    end;

    table.insert(v2, "BattlepassXP");
    table.sort(v2);

    return v2;
end;

return function(p3) -- Line: 92
    -- upvalues: BuildItemList (copy)
    local u4 = BuildItemList();
    local u5 = {};

    for _, v in ipairs(u4) do
        u5[v:lower()] = v;
    end;

    p3:RegisterType("giveableItem", {
        DisplayName = "Item",

        Transform = function(p6) -- Line: 104, Name: Transform
            return p6;
        end,

        Validate = function(p7) -- Line: 108, Name: Validate
            -- upvalues: u5 (copy)
            if u5[p7:lower()] then
                return true;
            end;

            return false, `"{p7}" is not a valid item. Use autocomplete to see options.`;
        end,

        Autocomplete = function(p8) -- Line: 115, Name: Autocomplete
            -- upvalues: u4 (copy)
            local v9 = p8:lower();
            local v10 = {};

            for _, v in ipairs(u4) do
                if v:lower():sub(1, #v9) == v9 then
                    table.insert(v10, v);
                end;
            end;

            if #v10 == 0 then
                for _, v in ipairs(u4) do
                    if v:lower():find(v9, 1, true) then
                        table.insert(v10, v);
                    end;
                end;
            end;

            return v10;
        end,

        Parse = function(p11) -- Line: 138, Name: Parse
            -- upvalues: u5 (copy)
            return u5[p11:lower()] or p11;
        end
    });
end;