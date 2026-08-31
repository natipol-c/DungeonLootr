--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TypeMarshaller
  Path:     game.ReplicatedStorage.Modules.FastCastRedux.TypeMarshaller
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = typeof;

return function(p2) -- Line: 5, Name: typeof
    -- upvalues: u1 (copy)
    local v3 = u1(p2);

    if v3 ~= "table" then
        return v3;
    end;

    local v4 = getmetatable(p2);

    if u1(v4) ~= "table" then
        return v3;
    end;

    local __type = v4.__type;

    if __type == nil then
        return v3;
    end;

    return __type;
end;