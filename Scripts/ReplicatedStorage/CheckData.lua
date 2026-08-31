--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CheckData
  Path:     game.ReplicatedStorage.GameInfo.CheckData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
local u1;

if RunService:IsServer() then
    u1 = require(ReplicatedStorage.Packages.Knit);
else
    u1 = nil;
end;

local v2 = {
    CLAIM_DELAY = 10
};
local v15 = {
    GrantSpins = function(u3: string, u4: number) -- Line: 65, Name: GrantSpins
        -- upvalues: u1 (ref)
        return function(p5) -- Line: 66
            -- upvalues: u1 (ref), u3 (copy), u4 (copy)
            u1.GetService("SummoningService"):GrantSpins(p5, u3, u4);

            return true;
        end;
    end,

    GrantIngots = function(u6: string, u7: number) -- Line: 78, Name: GrantIngots
        -- upvalues: u1 (ref)
        return function(p8) -- Line: 79
            -- upvalues: u1 (ref), u6 (copy), u7 (copy)
            local Service = u1.GetService("DataService");
            local v9 = Service:Get(p8);

            if not v9 then
                return false, "NoData";
            end;

            local v10 = u6 .. " Ingot";
            Service:Set(p8, { "CraftingMaterials", v10 }, ((v9.Data.Data.CraftingMaterials or {})[v10] or 0) + u7);

            return true;
        end;
    end,

    GrantCurrency = function(u11: number) -- Line: 93, Name: GrantCurrency
        -- upvalues: u1 (ref)
        return function(p12) -- Line: 94
            -- upvalues: u1 (ref), u11 (copy)
            u1.GetService("DataService"):Increment(p12, { "Currency" }, u11);

            return true;
        end;
    end,

    GrantStars = function(u13: number) -- Line: 101, Name: GrantStars
        -- upvalues: u1 (ref)
        return function(p14) -- Line: 102
            -- upvalues: u1 (ref), u13 (copy)
            u1.GetService("DataService"):Increment(p14, { "Stars" }, u13);

            return true;
        end;
    end
};
v2.Checks = {
    {
        Username = "@3Kieru",
        Role = "Owner / Lead Developer",
        RewardName = "10 Lucky Spins",
        Rarity = "Legendary",
        Amount = 10,
        Image = Image_Data.Rewards.LuckySpins,
        Reward = v15.GrantSpins("Lucky", 10)
    },
    {
        Username = "@noctisnine",
        Role = "",
        RewardName = "10 Lucky Spins",
        Rarity = "Legendary",
        Amount = 10,
        Image = Image_Data.Rewards.LuckySpins,
        Reward = v15.GrantSpins("Lucky", 10)
    },
    {
        Username = "@AnimSizn",
        Role = "Combat Animator",
        RewardName = "25 Uncommon Ingot",
        Rarity = "Uncommon",
        Amount = 25,
        Image = Image_Data.Ingots.Uncommon,
        Reward = v15.GrantIngots("Uncommon", 25)
    },
    {
        Username = "@Monkedeus",
        Role = "VFX Artist",
        RewardName = "15 Rare Ingot",
        Rarity = "Rare",
        Amount = 15,
        Image = Image_Data.Ingots.Rare,
        Reward = v15.GrantIngots("Rare", 15)
    },
    {
        Username = "@lolly2711",
        Role = "UI Artist",
        RewardName = "5 Normal Spins",
        Rarity = "Epic",
        Amount = 5,
        Image = Image_Data.Rewards.NormalSpins,
        Reward = v15.GrantSpins("Normal", 5)
    }
};
v2.Helpers = v15;

return v2;