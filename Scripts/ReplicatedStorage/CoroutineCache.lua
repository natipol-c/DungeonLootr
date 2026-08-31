--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CoroutineCache
  Path:     game.ReplicatedStorage.Globals.Modules.CoroutinePool.CoroutineCache
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

local function Runner(p2) -- Line: 5
    while not p2.Break do
        local coroutine_yield_ret, v3 = coroutine.yield();

        if coroutine_yield_ret then
            coroutine_yield_ret(table.unpack(v3));
        end;

        p2:Free();
    end;
end;

function u1.new() -- Line: 15
    -- upvalues: u1 (copy), Runner (copy)
    local v4 = setmetatable({}, u1);
    v4.Break = false;
    v4.Status = "Free";
    v4.Coroutine = coroutine.create(Runner);
    coroutine.resume(v4.Coroutine, v4);

    return v4;
end;

function u1.Obtain(p5) -- Line: 27
    if p5.Status ~= "Free" then
        return;
    end;

    p5.Status = "Busy";
end;

function u1.Free(p6) -- Line: 33
    if p6.Status ~= "Busy" then
        return;
    end;

    p6.Status = "Free";
end;

function u1.Execute(p7: table, p8: function, ...) -- Line: 39
    if p7.Status ~= "Busy" then
        return false;
    end;

    coroutine.resume(p7.Coroutine, p8, { ... });

    return true;
end;

function u1.Close(p9) -- Line: 46
    if p9.Status == "Busy" then
        task.defer(p9.Close, p9);

        return;
    end;

    p9.Break = true;
    coroutine.resume(p9.Coroutine);
    coroutine.close(p9.Coroutine);
    table.clear(p9);
end;

return u1;