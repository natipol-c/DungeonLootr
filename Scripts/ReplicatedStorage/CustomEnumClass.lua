--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CustomEnumClass
  Path:     game.ReplicatedStorage.Globals.Modules.Enums.CustomEnumClass
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.Extend(p2: string, p3: number, p4: table, p5: string) -- Line: 19
    -- upvalues: u1 (copy)
    local v6 = setmetatable({}, u1);
    v6.Name = p2;
    v6.Class = p5;
    v6.Value = p3;
    v6.EnumType = p4;

    return v6;
end;

function u1.IsA(p7: table, p8: string) -- Line: 30
    return p7.Class == p8;
end;

local u9 = {};
u9.__index = u9;

function u9.Extend() -- Line: 38
    -- upvalues: u9 (copy)
    return setmetatable({}, u9);
end;

function u9.GetEnumItems(p10) -- Line: 44
    local v11 = {};

    for _, v in p10 do
        if typeof(v) == "table" then
            v11[v.Value + 1] = v.Name;
        end;
    end;

    return v11;
end;

function u9.FromName(p12: table, p13: string) -- Line: 55
    for _, v in p12 do
        if typeof(v) == "table" and v.Name == p13 then
            return v;
        end;
    end;
end;

function u9.FromValue(p14: table, p15: number) -- Line: 62
    for _, v in p14 do
        if typeof(v) == "table" and v.Value == p15 then
            return v;
        end;
    end;
end;

local v16 = {};
v16.__index = v16;

function v16.GetEnums(p17) -- Line: 73
    local v18 = {};
    local v19 = 1;

    for _, v in p17 do
        if typeof(v) == "table" then
            v18[v19] = v;
            v19 = v19 + 1;
        end;
    end;

    return v18;
end;

return {
    CustomEnumItem = u1,
    CustomEnum = u9,
    CustomEnums = v16
};