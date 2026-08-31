--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LoadoutData
  Path:     game.ReplicatedStorage.GameInfo.LoadoutData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    FREE_SLOTS = 2,
    MAX_SLOTS = 10,
    MAX_NAME_LENGTH = 20,
    EquipmentSlots = { "Head", "Body", "Ring" },
    CosmeticSlots = require(script.Parent.CosmeticData).Slots,
    COIN_COSTS = { 2500, 5000, 10000, 20000, 35000, 50000, 75000, 100000 }
};

function u1.GetNextSlotCost(p2: number) -- Line: 54
    -- upvalues: u1 (copy)
    if u1.MAX_SLOTS <= p2 then
        return nil;
    end;

    return u1.COIN_COSTS[p2 - u1.FREE_SLOTS + 1];
end;

function u1.NewEquipmentEntry() -- Line: 61
    return {
        Name = "",
        Saved = false,
        Items = {
            Head = "",
            Body = "",
            Ring = ""
        }
    };
end;

function u1.NewCosmeticEntry() -- Line: 70
    -- upvalues: u1 (copy)
    local v3 = {};

    for _, v in u1.CosmeticSlots do
        v3[v] = "";
    end;

    return {
        Name = "",
        Saved = false,
        Sets = v3
    };
end;

return u1;