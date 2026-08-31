--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CoroutinePool
  Path:     game.ReplicatedStorage.Globals.Modules.CoroutinePool
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local script_CoroutineCache = require(script.CoroutineCache);

function u1.new(p2: number) -- Line: 10
    -- upvalues: u1 (copy), script_CoroutineCache (copy)
    local v3 = setmetatable({}, u1);
    v3.Count = p2 or 1;
    v3.Coroutines = {};

    for i = 1, v3.Count do
        v3.Coroutines[i] = script_CoroutineCache.new();
        local _ = i;
    end;

    return v3;
end;

function u1.Get(p4) -- Line: 21
    -- upvalues: script_CoroutineCache (copy)
    for _, v in p4.Coroutines do
        if v.Status == "Free" then
            v:Obtain();

            return v;
        end;
    end;

    local v5 = script_CoroutineCache.new();
    table.insert(p4.Coroutines, v5);
    v5:Obtain();
    p4.Count = p4.Count + 1;

    return v5;
end;

function u1.GetCount(p6) -- Line: 37
    return p6.Count;
end;

function u1.SetCount(p7: table, p8: number) -- Line: 42
    -- upvalues: script_CoroutineCache (copy)
    if p8 <= 0 or p7.Count == p8 then
        return;
    end;

    if p8 < p7.Count then
        for i = p7.Count, p8 + 1, -1 do
            table.remove(p7.Coroutines, i):Close();
            local _ = i;
        end;
    else
        for i = p7.Count + 1, p8 do
            p7.Coroutines[i] = script_CoroutineCache.new();
            local _ = i;
        end;
    end;

    p7.Count = p8;
end;

function u1.Reset(p9) -- Line: 55
    -- upvalues: script_CoroutineCache (copy)
    for _, v in p9.Coroutines do
        v:Close();
    end;

    table.clear(p9.Coroutines);
    p9.Count = 1;
    table.insert(p9.Coroutines, script_CoroutineCache.new());
end;

function u1.Destroy(p10) -- Line: 63
    for i, _ in p10.Coroutines do
        p10.Coroutines[i]:Close();
    end;

    table.clear(p10.Coroutines);
    table.clear(p10);
end;

return u1;