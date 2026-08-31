--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BaseUpgradeData
  Path:     game.ReplicatedStorage.GameInfo.BaseUpgradeData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Floors = {
        [2] = {
            Cost = 50000000,
            SlotRange = { 11, 20 }
        }
    }
};

function u1.GetFloorCost(p2: number) -- Line: 11
    -- upvalues: u1 (copy)
    if u1.Floors[p2] then
        return u1.Floors[p2].Cost;
    end;

    return nil;
end;

function u1.GetNextFloor(p3: number) -- Line: 18
    -- upvalues: u1 (copy)
    local v4 = p3 + 1;

    if u1.Floors[v4] then
        return v4, u1.Floors[v4];
    end;

    return nil, nil;
end;

function u1.GetFloorSlotRange(p5: number) -- Line: 26
    -- upvalues: u1 (copy)
    if p5 == 1 then
        return 1, 10;
    end;

    if u1.Floors[p5] then
        return u1.Floors[p5].SlotRange[1], u1.Floors[p5].SlotRange[2];
    end;

    return nil, nil;
end;

function u1.GetMaxFloor() -- Line: 36
    -- upvalues: u1 (copy)
    local v6 = 1;

    for i, _ in pairs(u1.Floors) do
        if v6 < i then
            v6 = i;
        end;
    end;

    return v6;
end;

function u1.GetTotalSlotsForFloor(p7: number) -- Line: 46
    -- upvalues: u1 (copy)
    if p7 == 1 then
        return 10;
    end;

    local v8 = 10;

    for i = 2, p7 do
        local v9;

        if u1.Floors[i] then
            v8 = u1.Floors[i].SlotRange[2];
            v9 = i;
        else
            v9 = i;
        end;
    end;

    return v8;
end;

return u1;