--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Vector
  Path:     game.ReplicatedStorage.CmdrClient.Types.Vector
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

local Util = require(script.Parent.Parent.Shared.Util);

local function validateVector(p1, p2) -- Line: 3
    if p1 == nil then
        return false, ("Invalid or missing number at position %d in Vector type."):format(p2);
    end;

    return true;
end;

local u3 = Util.MakeSequenceType({
    Length = 3,
    ValidateEach = validateVector,
    TransformEach = tonumber,
    Constructor = Vector3.new
});
local u4 = Util.MakeSequenceType({
    Length = 2,
    ValidateEach = validateVector,
    TransformEach = tonumber,
    Constructor = Vector2.new
});

return function(p5) -- Line: 25
    -- upvalues: u3 (copy), Util (copy), u4 (copy)
    p5:RegisterType("vector3", u3);
    p5:RegisterType("vector3s", Util.MakeListableType(u3));
    p5:RegisterType("vector2", u4);
    p5:RegisterType("vector2s", Util.MakeListableType(u4));
end;