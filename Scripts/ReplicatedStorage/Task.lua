--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Task
  Path:     game.ReplicatedStorage.MainModule.Task
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:20 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local v2 = {};
local u3 = {};
v2.Type = "Task";

function v2.Spawn(p4, p5, ...) -- Line: 22
    -- upvalues: u3 (copy), u1 (ref)
    return task.spawn(table.remove(u3) or task.spawn(u1), p5, ...);
end;

function v2.Defer(p6, p7, ...) -- Line: 26
    -- upvalues: u3 (copy), u1 (ref)
    return task.defer(table.remove(u3) or task.spawn(u1), p7, ...);
end;

function v2.Delay(p8, p9, p10, ...) -- Line: 30
    -- upvalues: u3 (copy), u1 (ref)
    return task.delay(p9, table.remove(u3) or task.spawn(u1), p10, ...);
end;

local function Call(p11: function, ...) -- Line: 36
    -- upvalues: u3 (copy)
    p11(...);
    table.insert(u3, coroutine.running());
end;

u1 = function() -- Line: 41, Name: Thread
    -- upvalues: Call (ref)
    while true do
        Call(coroutine.yield());
    end;
end;

return v2;