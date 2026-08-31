--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     FastDefer
  Path:     game.ReplicatedStorage.Packages._Index.howmanysmall_janitor@1.18.3.janitor.FastDefer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

local table_create_ret = table.create(500);

local function RunFunction(p1: function, p2: thread, ...) -- Line: 6
    -- upvalues: table_create_ret (copy)
    p1(...);
    table.insert(table_create_ret, p2);
end;

local function Yield() -- Line: 11
    -- upvalues: RunFunction (copy)
    while true do
        RunFunction(coroutine.yield());
    end;
end;

return function(p3: function, ...) -- Line: 17, Name: FastDefer
    -- upvalues: table_create_ret (copy), Yield (copy)
    local v4 = #table_create_ret;
    local v5;

    if v4 > 0 then
        v5 = table_create_ret[v4];
        table_create_ret[v4] = nil;
    else
        v5 = coroutine.create(Yield);
        coroutine.resume(v5);
    end;

    return task.defer(v5, p3, v5, ...);
end;