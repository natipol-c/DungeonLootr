--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ErrorEnumClass
  Path:     game.ReplicatedStorage.Globals.Modules.ErrorEnums.ErrorEnumClass
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = {};
v1.__index = v1;

function v1.__call(p2, ...) -- Line: 21
    warn(debug.traceback(p2.Call(...), 2));
end;

function v1.IsA(p3: table, p4: string) -- Line: 23
    return p3.Class == p4;
end;

local v5 = {};
v5.__index = v5;

function v5.GetEnumItems(p6) -- Line: 31
    local v7 = {};

    for _, v in p6 do
        if typeof(v) == "table" then
            v7[v.Value + 1] = v;
        end;
    end;

    return v7;
end;

function v5.FromName(p8: table, p9: string) -- Line: 42
    for _, v in p8 do
        if typeof(v) == "table" and v.Name == p9 then
            return v;
        end;
    end;
end;

function v5.FromValue(p10: table, p11: number) -- Line: 49
    for _, v in p10 do
        if typeof(v) == "table" and v.Value == p11 then
            return v;
        end;
    end;
end;

local v12 = {};
v12.__index = v12;

function v12.GetEnums(p13) -- Line: 60
    local v14 = {};
    local v15 = 1;

    for _, v in p13 do
        if typeof(v) == "table" then
            v14[v15] = v;
            v15 = v15 + 1;
        end;
    end;

    return v14;
end;

return {
    CustomEnumItem = v1,
    CustomEnum = v5,
    CustomEnums = v12
};