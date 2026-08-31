--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BankData
  Path:     game.ReplicatedStorage.GameInfo.BankData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    CountSources = { "CraftingMaterials", "Consumables", "Potions", "BuffPotions" },
    CountSourceSet = {}
};

for _, v in u1.CountSources do
    u1.CountSourceSet[v] = true;
end;

u1.Unbankable = {
    Potions = {
        SmallHealPercent = true
    }
};

function u1.IsUnbankable(p2: string?, p3: string?) -- Line: 48
    -- upvalues: u1 (copy)
    if not (p2 and p3) then
        return false;
    end;

    local v4 = u1.Unbankable[p2];
    local v5;

    if v4 == nil then
        v5 = false;
    else
        v5 = v4[p3] == true;
    end;

    return v5;
end;

return u1;