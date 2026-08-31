--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Range
  Path:     game.ReplicatedStorage.Part_Icles.Range
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:26 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    RandomValueFromRange = function(p1) -- Line: 4, Name: RandomValueFromRange
        if p1.Min == p1.Max then
            return p1.Min;
        end;

        return p1.Min + (p1.Max - p1.Min) * math.random();
    end
};