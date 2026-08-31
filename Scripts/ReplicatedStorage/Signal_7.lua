--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Signal
  Path:     game.ReplicatedStorage.Packages._Index.aykut92_replica@0.1.7.replica.Shared.Signal
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = nil;

local function AcquireRunnerThreadAndCallEventHandler(p2, ...) -- Line: 44
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;

local function RunEventHandlerInFreeThread(...) -- Line: 52
    -- upvalues: AcquireRunnerThreadAndCallEventHandler (copy)
    AcquireRunnerThreadAndCallEventHandler(...);

    while true do
        AcquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

local u4 = {};
u4.__index = u4;
local u5 = {};
u5.__index = u5;

function u4.Disconnect(p6) -- Line: 80
    if p6.is_connected == false then
        return;
    end;

    local signal = p6.signal;
    p6.is_connected = false;
    signal.listener_count = signal.listener_count - 1;

    if signal.head == p6 then
        signal.head = p6.next;

        return;
    end;

    local head = signal.head;

    while head ~= nil and head.next ~= p6 do
        head = head.next;
    end;

    if head ~= nil then
        head.next = p6.next;
    end;
end;

function u5.New() -- Line: 104
    -- upvalues: u5 (copy)
    local v7 = {
        head = nil,
        listener_count = 0
    };
    setmetatable(v7, u5);

    return v7;
end;

function u5.Connect(p8: table, p9: function) -- Line: 116
    -- upvalues: u4 (copy)
    if type(p9) ~= "function" then
        error((`[{script.Name}]: "listener" must be a function; Received {typeof(p9)}`));
    end;

    local v10 = {
        is_connected = true,
        listener = p9,
        signal = p8,
        next = p8.head
    };
    setmetatable(v10, u4);
    p8.head = v10;
    p8.listener_count = p8.listener_count + 1;

    return v10;
end;

function u5.GetListenerCount(p11) -- Line: 137
    return p11.listener_count;
end;

function u5.Fire(p12, ...) -- Line: 141
    -- upvalues: u1 (ref), RunEventHandlerInFreeThread (copy)
    local head = p12.head;

    while head ~= nil do
        if head.is_connected == true then
            if not u1 then
                u1 = coroutine.create(RunEventHandlerInFreeThread);
            end;

            task.spawn(u1, head.listener, ...);
        end;

        head = head.next;
    end;
end;

function u5.Wait(p13) -- Line: 154
    local coroutine_running_ret = coroutine.running();
    local u14 = nil;
    u14 = p13:Connect(function(...) -- Line: 157
        -- upvalues: u14 (ref), coroutine_running_ret (copy)
        u14:Disconnect();
        task.spawn(coroutine_running_ret, ...);
    end);

    return coroutine.yield();
end;

function u5.FireUntil(p15: table, u16: function, ...) -- Line: 164
    if type(u16) ~= "function" then
        error((`[{script.Name}]: "continue_callback" must be a function; Received {typeof(u16)}`));
    end;

    local table_pack_ret = table.pack(...);
    local head = p15.head;
    local u17 = {};

    while head ~= nil do
        table.insert(u17, head);
        head = head.next;
    end;

    task.spawn(function() -- Line: 179
        -- upvalues: u17 (copy), table_pack_ret (copy), u16 (copy)
        for _, v in ipairs(u17) do
            if v.is_connected == true then
                v.listener(table.unpack(table_pack_ret));

                if u16() ~= true then
                    return;
                end;
            end;
        end;
    end);
end;

return table.freeze({
    New = u5.New
});