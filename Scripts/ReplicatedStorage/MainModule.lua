--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     MainModule
  Path:     game.ReplicatedStorage.MainModule
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:20 2026
]]

-- Decompiled with Potassium's decompiler.

local script_Signal = require(script.Signal);
local script_Task = require(script.Task);
local script_Types = require(script.Types);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Reads = script_Types.Reads;
local Writes = script_Types.Writes;
local Import = script_Types.Import;
local Export = script_Types.Export;
local Truncate = script_Types.Truncate;
local Ended = script_Types.Ended;
local NumberU8 = Reads.NumberU8;
local NumberU82 = Writes.NumberU8;
local NumberU16 = Reads.NumberU16;
local NumberU162 = Writes.NumberU16;
local u6 = {};
local u7 = {};
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = {
    BufferLength = 128,
    BufferOffset = 0,
    InstancesOffset = 0,
    Buffer = buffer.create(128),
    Instances = {}
};

local function Constructor(p14: any, p15: string, ...) -- Line: 50
    -- upvalues: u7 (copy), u6 (copy), RunService (copy), u12 (ref), script_Signal (copy), u11 (ref), u1 (ref)
    local v16 = u7[p15];

    if v16 then
        return v16;
    end;

    local v17 = setmetatable({}, u6);
    v17.Name = p15;

    if RunService:IsServer() then
        v17.Id = u12;
        v17.OnServerEvent = script_Signal();
        u11:SetAttribute(p15, u12);
        u7[u12] = v17;
        u12 = u12 + 1;
    else
        v17.Id = u11:GetAttribute(p15);
        v17.OnClientEvent = script_Signal();

        if v17.Id then
            u7[v17.Id] = v17;
        end;
    end;

    local v18, v19 = u1(table.pack(...));
    v17.Reads = v18;
    v17.Writes = v19;
    u7[v17.Name] = v17;

    return v17;
end;

u6.__index = u6;
u6.Type = "Packet";

function u6.Response(p20, ...) -- Line: 76
    -- upvalues: u1 (ref)
    p20.ResponseTimeout = p20.ResponseTimeout or 10;
    local v21, v22 = u1(table.pack(...));
    p20.ResponseReads = v21;
    p20.ResponseWrites = v22;

    return p20;
end;

function u6.Fire(p23, ...) -- Line: 82
    -- upvalues: RunService (copy), u10 (ref), Import (copy), u13 (ref), NumberU82 (copy), script_Task (copy), u5 (ref), u4 (ref), Export (copy)
    if not p23.ResponseReads then
        Import(u13);
        NumberU82(p23.Id);
        u4(p23.Writes, { ... });
        u13 = Export();

        return;
    end;

    if RunService:IsServer() then
        error("You must use FireClient(player)", 2);
    end;

    local v24 = nil;

    for i = 1, 128 do
        v24 = u10[u10.Index];

        if not v24 then
            break;
        end;

        u10.Index = (u10.Index + 1) % 128;
        local _ = i;
    end;

    if v24 then
        error("Cannot have more than 128 yielded threads", 2);
    end;

    Import(u13);
    NumberU82(p23.Id);
    NumberU82(u10.Index);
    u10[u10.Index] = {
        Yielded = coroutine.running(),
        Timeout = script_Task:Delay(p23.ResponseTimeout, u5, u10, u10.Index, p23.ResponseTimeoutValue)
    };
    u10.Index = (u10.Index + 1) % 128;
    u4(p23.Writes, { ... });
    u13 = Export();

    return coroutine.yield();
end;

function u6.FireClient(p25, p26, ...) -- Line: 107
    -- upvalues: u9 (ref), Import (copy), u8 (ref), NumberU82 (copy), script_Task (copy), u5 (ref), u4 (ref), Export (copy)
    if p26.Parent == nil then
        return;
    end;

    if not p25.ResponseReads then
        Import(u8[p26] or {
            BufferLength = 128,
            BufferOffset = 0,
            InstancesOffset = 0,
            Buffer = buffer.create(128),
            Instances = {}
        });
        NumberU82(p25.Id);
        u4(p25.Writes, { ... });
        u8[p26] = Export();

        return;
    end;

    local v27 = u9[p26];

    if v27 == nil then
        v27 = {
            Index = 0
        };
        u9[p26] = v27;
    end;

    local v28 = nil;

    for i = 1, 128 do
        v28 = v27[v27.Index];

        if not v28 then
            break;
        end;

        v27.Index = (v27.Index + 1) % 128;
        local _ = i;
    end;

    if not v28 then
        Import(u8[p26] or {
            BufferLength = 128,
            BufferOffset = 0,
            InstancesOffset = 0,
            Buffer = buffer.create(128),
            Instances = {}
        });
        NumberU82(p25.Id);
        NumberU82(v27.Index);
        v27[v27.Index] = {
            Yielded = coroutine.running(),
            Timeout = script_Task:Delay(p25.ResponseTimeout, u5, v27, v27.Index, p25.ResponseTimeoutValue)
        };
        v27.Index = (v27.Index + 1) % 128;
        u4(p25.Writes, { ... });
        u8[p26] = Export();

        return coroutine.yield();
    end;

    error("Cannot have more than 128 yielded threads", 2);
end;

function u6.Serialize(p29, ...) -- Line: 134
    -- upvalues: Import (copy), u4 (ref), Truncate (copy)
    Import({
        BufferLength = 128,
        BufferOffset = 0,
        InstancesOffset = 0,
        Buffer = buffer.create(128),
        Instances = {}
    });
    u4(p29.Writes, { ... });

    return Truncate();
end;

function u6.Deserialize(p30, p31, p32) -- Line: 140
    -- upvalues: Import (copy), u3 (ref)
    Import({
        BufferOffset = 0,
        InstancesOffset = 0,
        Buffer = p31,
        BufferLength = buffer.len(p31),
        Instances = p32 or {}
    });

    return u3(p30.Reads);
end;

u1 = function(p33: table) -- Line: 147, Name: ParametersToFunctions
    -- upvalues: u2 (ref), Reads (copy), Writes (copy)
    local table_create_ret = table.create(#p33);
    local table_create_ret2 = table.create(#p33);

    for i, v in ipairs(p33) do
        if type(v) == "table" then
            local v34, v35 = u2(v);
            table_create_ret[i] = v34;
            table_create_ret2[i] = v35;
        else
            local v36 = Writes[v];
            table_create_ret[i] = Reads[v];
            table_create_ret2[i] = v36;
        end;
    end;

    return table_create_ret, table_create_ret2;
end;

u2 = function(p37: table) -- Line: 159, Name: TableToFunctions
    -- upvalues: u2 (ref), Reads (copy), Writes (copy), NumberU16 (copy), NumberU162 (copy)
    if #p37 == 1 then
        local v38 = p37[1];
        local u39, u40;

        if type(v38) == "table" then
            u39, u40 = u2(v38);
        else
            u39 = Reads[v38];
            u40 = Writes[v38];
        end;

        return function() -- Line: 168
            -- upvalues: NumberU16 (ref), u39 (ref)
            local v41 = NumberU16();
            local table_create_ret = table.create(v41);

            for i = 1, v41 do
                table_create_ret[i] = u39();
                local _ = i;
            end;

            return table_create_ret;
        end, function(p42: table) -- Line: 174
            -- upvalues: NumberU162 (ref), u40 (ref)
            NumberU162(#p42);

            for _, v in p42 do
                u40(v);
            end;
        end;
    end;

    local u43 = {};

    for i, _ in p37 do
        table.insert(u43, i);
    end;

    table.sort(u43);
    local table_create_ret = table.create(#u43);
    local table_create_ret2 = table.create(#u43);

    for i, v in u43 do
        local v44 = p37[v];

        if type(v44) == "table" then
            local v45, v46 = u2(v44);
            table_create_ret[i] = v45;
            table_create_ret2[i] = v46;
        else
            local v47 = Writes[v44];
            table_create_ret[i] = Reads[v44];
            table_create_ret2[i] = v47;
        end;
    end;

    return function() -- Line: 190
        -- upvalues: table_create_ret (copy), u43 (copy)
        local v48 = {};

        for i, v in table_create_ret do
            v48[u43[i]] = v();
        end;

        return v48;
    end, function(p49: table) -- Line: 195
        -- upvalues: table_create_ret2 (copy), u43 (copy)
        for i, v in table_create_ret2 do
            v(p49[u43[i]]);
        end;
    end;
end;

u3 = function(p50: table) -- Line: 202, Name: ReadParameters
    local table_create_ret = table.create(#p50);

    for i, v in p50 do
        table_create_ret[i] = v();
    end;

    return table.unpack(table_create_ret);
end;

u4 = function(p51: table, p52: table) -- Line: 208, Name: WriteParameters
    for i, v in p51 do
        v(p52[i]);
    end;
end;

u5 = function(p53: table, p54: number, p55: any) -- Line: 212, Name: Timeout
    task.defer(p53[p54].Yielded, p55);
    p53[p54] = nil;
end;

if RunService:IsServer() then
    u8 = {};
    u9 = {};
    u12 = 0;
    u11 = Instance.new("RemoteEvent", script);
    local u56 = {};
    local task_spawn_ret = task.spawn(function() -- Line: 228
        -- upvalues: u13 (ref), u11 (ref), u8 (ref), u56 (copy)
        while true do
            coroutine.yield();

            if u13.BufferOffset > 0 then
                local buffer_create_ret = buffer.create(u13.BufferOffset);
                buffer.copy(buffer_create_ret, 0, u13.Buffer, 0, u13.BufferOffset);

                if u13.InstancesOffset == 0 then
                    u11:FireAllClients(buffer_create_ret);
                else
                    u11:FireAllClients(buffer_create_ret, u13.Instances);
                    u13.InstancesOffset = 0;
                    table.clear(u13.Instances);
                end;

                u13.BufferOffset = 0;
            end;

            for i, v in u8 do
                local buffer_create_ret = buffer.create(v.BufferOffset);
                buffer.copy(buffer_create_ret, 0, v.Buffer, 0, v.BufferOffset);

                if v.InstancesOffset == 0 then
                    u11:FireClient(i, buffer_create_ret);
                else
                    u11:FireClient(i, buffer_create_ret, v.Instances);
                end;
            end;

            table.clear(u8);
            table.clear(u56);
        end;
    end);

    local function u61(p57: table, p58: userdata, p59: number, ...) -- Line: 257
        -- upvalues: RunService (copy), Import (copy), u8 (ref), NumberU82 (copy), u4 (ref), Export (copy)
        if p57.OnServerInvoke == nil then
            if RunService:IsStudio() then
                warn("OnServerInvoke not found for packet:", p57.Name, "discarding event:", ...);
            end;

            return;
        end;

        local v60 = { p57.OnServerInvoke(p58, ...) };

        if p58.Parent == nil then
            return;
        end;

        Import(u8[p58] or {
            BufferLength = 128,
            BufferOffset = 0,
            InstancesOffset = 0,
            Buffer = buffer.create(128),
            Instances = {}
        });
        NumberU82(p57.Id);
        NumberU82(p59 + 128);
        u4(p57.ResponseWrites, v60);
        u8[p58] = Export();
    end;

    local function u71(p62: userdata, p63: buffer, p64: table?) -- Line: 268
        -- upvalues: u56 (copy), RunService (copy), Import (copy), Ended (copy), u7 (copy), NumberU8 (copy), script_Task (copy), u61 (copy), u3 (ref), u9 (ref)
        local v65 = u56[p62] or 0;
        local buffer_len_ret = buffer.len(p63);
        local v66 = v65 + math.max(buffer_len_ret, 800);

        if v66 > 8000 then
            if RunService:IsStudio() then
                warn(p62.Name, "is exceeding the data/rate limit; some events may be dropped");
            end;

            return;
        end;

        u56[p62] = v66;
        Import({
            BufferOffset = 0,
            InstancesOffset = 0,
            Buffer = p63,
            BufferLength = buffer.len(p63),
            Instances = p64 or {}
        });

        while Ended() == false do
            local v67 = u7[NumberU8()];

            if v67.ResponseReads then
                local v68 = NumberU8();

                if v68 < 128 then
                    script_Task:Defer(u61, v67, p62, v68, u3(v67.Reads));
                else
                    local v69 = v68 - 128;
                    local v70 = u9[p62][v69];

                    if v70 then
                        task.cancel(v70.Timeout);
                        task.defer(v70.Yielded, u3(v67.ResponseReads));
                        u9[p62][v69] = nil;
                    elseif RunService:IsStudio() then
                        warn("Response thread not found for packet:", v67.Name, "discarding response:", u3(v67.ResponseReads));
                    else
                        u3(v67.ResponseReads);
                    end;
                end;
            else
                v67.OnServerEvent:Fire(p62, u3(v67.Reads));
            end;
        end;
    end;

    u11.OnServerEvent:Connect(function(p72: userdata, ...) -- Line: 298
        -- upvalues: u71 (copy), RunService (copy)
        local _, result = pcall(u71, p72, ...);

        if result and RunService:IsStudio() then
            warn(p72.Name, result);
        end;
    end);
    Players.PlayerRemoving:Connect(function(p73) -- Line: 303
        -- upvalues: u8 (ref), u9 (ref), u56 (copy)
        u8[p73] = nil;
        u9[p73] = nil;
        u56[p73] = nil;
    end);
    RunService.Heartbeat:Connect(function(p74) -- Line: 309
        -- upvalues: task_spawn_ret (copy)
        task.defer(task_spawn_ret);
    end);
else
    u10 = {
        Index = 0
    };
    u11 = script:WaitForChild("RemoteEvent");
    local u75 = 0;
    local task_spawn_ret = task.spawn(function() -- Line: 315
        -- upvalues: u13 (ref), u11 (ref)
        while true do
            repeat
                coroutine.yield();
            until u13.BufferOffset > 0;

            local buffer_create_ret = buffer.create(u13.BufferOffset);
            buffer.copy(buffer_create_ret, 0, u13.Buffer, 0, u13.BufferOffset);

            if u13.InstancesOffset == 0 then
                u11:FireServer(buffer_create_ret);
            else
                u11:FireServer(buffer_create_ret, u13.Instances);
                u13.InstancesOffset = 0;
                table.clear(u13.Instances);
            end;

            u13.BufferOffset = 0;
        end;
    end);

    local function u79(p76: table, p77: number, ...) -- Line: 333
        -- upvalues: Import (copy), u13 (ref), NumberU82 (copy), u4 (ref), Export (copy)
        if p76.OnClientInvoke == nil then
            warn("OnClientInvoke not found for packet:", p76.Name, "discarding event:", ...);

            return;
        end;

        local v78 = { p76.OnClientInvoke(...) };
        Import(u13);
        NumberU82(p76.Id);
        NumberU82(p77 + 128);
        u4(p76.ResponseWrites, v78);
        u13 = Export();
    end;

    u11.OnClientEvent:Connect(function(p80: buffer, p81: table?) -- Line: 343
        -- upvalues: Import (copy), Ended (copy), u7 (copy), NumberU8 (copy), script_Task (copy), u79 (copy), u3 (ref), u10 (ref)
        Import({
            BufferOffset = 0,
            InstancesOffset = 0,
            Buffer = p80,
            BufferLength = buffer.len(p80),
            Instances = p81 or {}
        });

        while Ended() == false do
            local v82 = u7[NumberU8()];

            if v82.ResponseReads then
                local v83 = NumberU8();

                if v83 < 128 then
                    script_Task:Defer(u79, v82, v83, u3(v82.Reads));
                else
                    local v84 = v83 - 128;
                    local v85 = u10[v84];

                    if v85 then
                        task.cancel(v85.Timeout);
                        task.defer(v85.Yielded, u3(v82.ResponseReads));
                        u10[v84] = nil;
                    else
                        warn("Response thread not found for packet:", v82.Name, "discarding response:", u3(v82.ResponseReads));
                    end;
                end;
            else
                v82.OnClientEvent:Fire(u3(v82.Reads));
            end;
        end;
    end);
    u11.AttributeChanged:Connect(function(p86) -- Line: 368
        -- upvalues: u7 (copy), u11 (ref)
        local v87 = u7[p86];

        if v87 then
            if v87.Id then
                u7[v87.Id] = nil;
            end;

            v87.Id = u11:GetAttribute(p86);

            if v87.Id then
                u7[v87.Id] = v87;
            end;
        end;
    end);
    RunService.Heartbeat:Connect(function(p88) -- Line: 377
        -- upvalues: u75 (ref), task_spawn_ret (copy)
        u75 = u75 + p88;

        if u75 > 0.016666666666666666 then
            u75 = u75 % 0.016666666666666666;
            task.defer(task_spawn_ret);
        end;
    end);
end;

return setmetatable(script_Types.Types, {
    __call = Constructor
});