--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ConsumableData
  Path:     game.ReplicatedStorage.GameInfo.ConsumableData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local Image_Data = require(script.Parent:WaitForChild("Image_Data"));
local u1 = {
    DEFINITIONS_FOLDER = "Consumables",
    Consumables = {
        {
            Id = "AspectGem",
            Name = "Aspect Gem",
            Description = "Consume to roll a random Aspect onto your currently equipped class.",
            Rarity = "Legendary",
            MaxStack = 99,
            LayoutOrder = 1,
            Icon = Image_Data.Consumables and (Image_Data.Consumables.AspectGem or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "BossRushSkipTicket",
            Name = "Boss Rush Skip Ticket",
            Description = "Spend at the Boss Rush select screen to skip ahead in 10-floor steps (up to Floor 50). Skipping forfeits leaderboard time for the whole party — Floor Milestone rewards are still earned.",
            Rarity = "Epic",
            MaxStack = 999,
            LayoutOrder = 2,
            Usable = false,
            Icon = Image_Data.Consumables and Image_Data.Consumables.BossRushSkipTicket or "rbxassetid://0"
        }
    },
    Index = {}
};

for _, v in ipairs(u1.Consumables) do
    u1.Index[v.Id] = v;
end;

function u1.GetConsumable(p2: string) -- Line: 66
    -- upvalues: u1 (copy)
    return u1.Index[p2];
end;

function u1.GetMaxStack(p3: string) -- Line: 71
    -- upvalues: u1 (copy)
    local v4 = u1.Index[p3];

    return v4 and v4.MaxStack or 99;
end;

return u1;