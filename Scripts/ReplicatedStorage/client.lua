--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     client
  Path:     game.ReplicatedStorage.Packages._Index.aykut92_replica@0.1.7.replica.client
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

local Shared = script.Parent.Shared;
local Remote = require(Shared.Remote);
local Signal = require(Shared.Signal);
local Maid = require(Shared.Maid);
local u1 = {};
local CollectionService = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
game:GetService("Players");
local u2 = false;
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = Remote.New("ReplicaRequestData");
local v9 = Remote.New("ReplicaSet");
local v10 = Remote.New("ReplicaSetValues");
local v11 = Remote.New("ReplicaTableInsert");
local v12 = Remote.New("ReplicaTableRemove");
local v13 = Remote.New("ReplicaWrite");
local u14 = Remote.New("ReplicaSignal");
local v15 = Remote.New("ReplicaParent");
local v16 = Remote.New("ReplicaCreate");
local v17 = Remote.New("ReplicaBind");
local v18 = Remote.New("ReplicaDestroy");
local u19 = Remote.New("ReplicaSignalUnreliable", true);
local u20 = {};
local u21 = false;

local function LoadWriteLib(p22: userdata) -- Line: 115
    -- upvalues: u20 (copy)
    local v23 = u20[p22];

    if v23 ~= nil then
        return v23;
    end;

    local v24 = require(p22);
    local v25 = {};

    for i, v in pairs(v24) do
        table.insert(v25, { i, v });
    end;

    table.sort(v25, function(p26, p27) -- Line: 131
        return p26[1] < p27[1];
    end);
    local v28 = {};

    for i, v in ipairs(v25) do
        local v29 = {
            Name = v[1],
            Id = i,
            fn = v[2]
        };
        v28[v[1]] = v29;
        v28[i] = v29;
    end;

    u20[p22] = v28;

    return v28;
end;

local u30 = {};
u30.__index = u30;
local u31 = nil;

local function AcquireRunnerThreadAndCallEventHandler(p32, ...) -- Line: 188
    -- upvalues: u31 (ref)
    local v33 = u31;
    u31 = nil;
    p32(...);
    u31 = v33;
end;

local function RunEventHandlerInFreeThread(...) -- Line: 196
    -- upvalues: AcquireRunnerThreadAndCallEventHandler (copy)
    AcquireRunnerThreadAndCallEventHandler(...);

    while true do
        AcquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

function ConnectionNew(p34, p35)
    -- upvalues: u30 (copy)
    local v36 = setmetatable({
        t = p34,
        fn = p35
    }, u30);
    p34[v36] = true;

    return v36;
end;

function ConnectionFire(p37, ...)
    -- upvalues: u31 (ref), RunEventHandlerInFreeThread (copy)
    if not u31 then
        u31 = coroutine.create(RunEventHandlerInFreeThread);
    end;

    task.spawn(u31, p37.fn, ...);
end;

function u30.Disconnect(p38) -- Line: 223
    p38.t[p38] = nil;
end;

local u39 = {
    IsReady = false,
    OnLocalReady = Signal.New()
};
u39.__index = u39;

local function ReplicaNew(p40: number, p41: table) -- Line: 233
    -- upvalues: LoadWriteLib (copy), u5 (copy), u4 (copy), Signal (copy), Maid (copy), u1 (copy), u39 (copy)
    local v42;

    if p41[5] == nil then
        v42 = nil;
    else
        v42 = LoadWriteLib(p41[5]);
    end;

    local v43 = u5[p41[4]] or u4[p41[4]];
    local v44 = {
        BoundInstance = nil,
        Tags = p41[2],
        Data = p41[3],
        Id = p40,
        Token = p41[1],
        Parent = v43,
        Children = {},
        OnClientEvent = Signal.New(),
        Maid = Maid.New(u1),
        self_creation = p41,
        write_lib = v42,
        set_listeners = {},
        write_listeners = {},
        changed_listeners = {}
    };
    local v45 = setmetatable(v44, u39);

    if v43 ~= nil then
        v43.Children[v45] = true;
    end;

    return v45;
end;

function u39.RequestData() -- Line: 272
    -- upvalues: u2 (ref), u8 (copy), u39 (copy)
    if u2 == true then
        return;
    end;

    u2 = true;
    task.spawn(function() -- Line: 280
        -- upvalues: u8 (ref), u39 (ref)
        u8:FireServer();

        while task.wait(2) and u39.IsReady ~= true do
            u8:FireServer();
        end;
    end);
end;

function u39.OnNew(p46: string, p47: function) -- Line: 295
    -- upvalues: u7 (copy), u3 (copy)
    if type(p46) ~= "string" then
        error((`[{script.Name}]: "token" must be a string`));
    end;

    local v48 = u7[p46];

    if v48 == nil then
        v48 = {};
        u7[p46] = v48;
    end;

    local v49 = u3[p46];
    local v50 = ConnectionNew(v48, p47);

    if v49 ~= nil then
        for i in pairs(v49) do
            ConnectionFire(v50, i);
        end;
    end;

    return v50;
end;

function u39.FromId(p51: number) -- Line: 322
    -- upvalues: u4 (copy)
    return u4[p51];
end;

function u39.Test() -- Line: 326
    -- upvalues: u3 (copy), u4 (copy), u5 (copy), u6 (copy)
    return {
        TokenReplicas = u3,
        Replicas = u4,
        BindReplicas = u5,
        BindInstances = u6
    };
end;

function u39.OnSet(p52: table, p53: table, p54: function) -- Line: 335
    local table_concat_ret = table.concat(p53, ".");
    local v55 = p52.set_listeners[table_concat_ret];

    if v55 == nil then
        v55 = {};
        p52.set_listeners[table_concat_ret] = v55;
    end;

    return ConnectionNew(v55, p54);
end;

function u39.OnWrite(p56: table, p57: string, p58: function) -- Line: 346
    local v59 = p56.write_listeners[p57];

    if v59 == nil then
        v59 = {};
        p56.write_listeners[p57] = v59;
    end;

    return ConnectionNew(v59, p58);
end;

function u39.OnChange(p60: table, p61: function) -- Line: 356
    return ConnectionNew(p60.changed_listeners, p61);
end;

function u39.GetChild(p62: table, p63: string) -- Line: 360
    if type(p63) ~= "string" then
        error((`[{script.Name}]: "token" must be a string`));
    end;

    for i in pairs(p62.Children) do
        if i.Token == p63 then
            return i;
        end;
    end;

    return nil;
end;

function u39.FireServer(p64, ...) -- Line: 372
    -- upvalues: u14 (copy)
    u14:FireServer(p64.Id, ...);
end;

function u39.UFireServer(p65, ...) -- Line: 376
    -- upvalues: u19 (copy)
    u19:FireServer(p65.Id, ...);
end;

function u39.Identify(p66) -- Line: 380
    local v67 = "";
    local v68 = true;

    for i, v in pairs(p66.Tags) do
        v67 = v67 .. `{v68 == true and "" or ";"}{tostring(i)}={tostring(v)}`;
        v68 = false;
    end;

    return `[Id:{p66.Id};Token:{p66.Token};Tags:\{{v67}}]`;
end;

function u39.IsActive(p69) -- Line: 390
    return p69.Maid:IsActive();
end;

function u39.Set(p70: table, p71: table, p72: any) -- Line: 394
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "Set()" can't be called outside of WriteLibs client-side`));
    end;

    local Data = p70.Data;

    for i = 1, #p71 - 1 do
        Data = Data[p71[i]];
        local _ = i;
    end;

    local v73 = p71[#p71];
    local v74 = Data[v73];
    Data[v73] = p72;

    if next(p70.set_listeners) ~= nil then
        local v75 = p70.set_listeners[table.concat(p71, ".")];

        if v75 ~= nil then
            for i in pairs(v75) do
                ConnectionFire(i, p72, v74);
            end;
        end;
    end;

    for i in pairs(p70.changed_listeners) do
        ConnectionFire(i, "Set", p71, p72, v74);
    end;
end;

function u39.SetValues(p76: table, p77: table, p78: table) -- Line: 426
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "SetValues()" can't be called outside of WriteLibs client-side`));
    end;

    local Data = p76.Data;

    for _, v in ipairs(p77) do
        Data = Data[v];
    end;

    for i, v in pairs(p78) do
        Data[i] = v;
    end;

    for i in pairs(p76.changed_listeners) do
        ConnectionFire(i, "SetValues", p77, p78);
    end;
end;

function u39.TableInsert(p79: table, p80: table, p81: any, p82: number?) -- Line: 450
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "TableInsert()" can't be called outside of WriteLibs client-side`));
    end;

    local Data = p79.Data;

    for _, v in ipairs(p80) do
        Data = Data[v];
    end;

    if p82 == nil then
        table.insert(Data, p81);
        p82 = #Data;
    else
        table.insert(Data, p82, p81);
    end;

    for i in pairs(p79.changed_listeners) do
        ConnectionFire(i, "TableInsert", p80, p81, p82);
    end;

    return p82;
end;

function u39.TableRemove(p83: table, p84: table, p85: number) -- Line: 479
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "TableRemove()" can't be called outside of WriteLibs client-side`));
    end;

    local Data = p83.Data;

    for _, v in ipairs(p84) do
        Data = Data[v];
    end;

    local table_remove_ret = table.remove(Data, p85);

    for i in pairs(p83.changed_listeners) do
        ConnectionFire(i, "TableRemove", p84, table_remove_ret, p85);
    end;

    return table_remove_ret;
end;

function u39.Write(p86: table, p87: string, ...) -- Line: 503
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "Write()" can't be called outside of WriteLibs client-side`));
    end;

    local table_pack_ret = table.pack(p86.write_lib[p87].fn(p86, ...));
    local v88 = p86.write_listeners[p87];

    if v88 ~= nil then
        for i in pairs(v88) do
            ConnectionFire(i, ...);
        end;
    end;

    return table.unpack(table_pack_ret);
end;

local function DestroyReplica(p89, p90) -- Line: 527
    -- upvalues: DestroyReplica (copy), u3 (copy), u4 (copy), u5 (copy), u1 (copy)
    for _, v in ipairs(p89.Children) do
        DestroyReplica(v, true);
    end;

    if p90 ~= true and p89.Parent ~= nil then
        p89.Parent.Children[p89] = nil;
    end;

    local Id = p89.Id;
    local v91 = u3[p89.Token];

    if v91 ~= nil then
        v91[p89] = nil;
    end;

    if u4[Id] == p89 then
        u4[Id] = nil;
    end;

    if u5[Id] == p89 then
        u5[Id] = nil;
    end;

    p89.Maid:Unlock(u1);
    p89.Maid:Cleanup();
    p89.BoundInstance = nil;
end;

local function ReplicaToBindBuffer(p92, p93) -- Line: 559
    -- upvalues: ReplicaNew (copy), u5 (copy), ReplicaToBindBuffer (copy), DestroyReplica (copy)
    local v94 = ReplicaNew(p92.Id, p92.self_creation);
    u5[p92.Id] = v94;

    for i in pairs(p92.Children) do
        ReplicaToBindBuffer(i, true);
    end;

    if p93 ~= true then
        DestroyReplica(p92);
    end;

    return v94;
end;

local function ReplicaFromBindBuffer(p95, p96) -- Line: 580
    -- upvalues: u5 (copy), u3 (copy), u4 (copy), ReplicaFromBindBuffer (copy), u7 (copy)
    local v97;

    if p96 == nil then
        p96 = {};
        v97 = true;
    else
        v97 = false;
    end;

    u5[p95.Id] = nil;
    local Token = p95.Token;
    local v98 = u3[Token];

    if v98 == nil then
        v98 = {};
        u3[Token] = v98;
    end;

    v98[p95] = true;
    u4[p95.Id] = p95;
    table.insert(p96, p95);

    for i in pairs(p95.Children) do
        ReplicaFromBindBuffer(i, p96);
    end;

    if v97 == true then
        for _, v in ipairs(p96) do
            local v99 = u7[v.Token];

            if v99 ~= nil then
                local v100 = v;

                for i in pairs(v99) do
                    ConnectionFire(i, v100);
                end;
            end;
        end;
    end;
end;

local function CreationScan(p101, p102, p103) -- Line: 621
    -- upvalues: CreationScan (copy)
    local v104 = p101[p103];

    if v104 ~= nil then
        table.sort(v104, function(p105, p106) -- Line: 625
            return p105.Id < p106.Id;
        end);

        for _, v in ipairs(v104) do
            p102(v.Id, v.SelfCreation);
            CreationScan(p101, p102, v.Id);
        end;
    end;
end;

local function BreadthCreationSort(p107: table, p108: number?, p109: function) -- Line: 637
    -- upvalues: CreationScan (copy)
    local v110 = {};
    local v111 = {};
    local v112 = {};

    if type(p107[1]) == "table" then
        for _, v in ipairs(p107) do
            local v113 = v;

            for i, v2 in pairs(v) do
                local v114 = {
                    Id = tonumber(i),
                    SelfCreation = v2
                };
                local v115 = v2[4];

                if v115 == 0 or v114.Id == p108 then
                    table.insert(v110, v114);
                elseif v113[tostring(v115)] == nil then
                    table.insert(v112, v114);
                else
                    local v116 = v111[v115];

                    if v116 == nil then
                        v116 = {};
                        v111[v115] = v116;
                    end;

                    table.insert(v116, v114);
                end;
            end;
        end;
    else
        for i, v in pairs(p107) do
            local v117 = {
                Id = tonumber(i),
                SelfCreation = v
            };
            local v118 = v[4];

            if v118 == 0 or v117.Id == p108 then
                table.insert(v110, v117);
            elseif p107[tostring(v118)] == nil then
                table.insert(v112, v117);
            else
                local v119 = v111[v118];

                if v119 == nil then
                    v119 = {};
                    v111[v118] = v119;
                end;

                table.insert(v119, v117);
            end;
        end;
    end;

    table.sort(v110, function(p120, p121) -- Line: 688
        return p120.Id < p121.Id;
    end);
    local v122 = {};

    for _, v in ipairs(v110) do
        p109(v.Id, v.SelfCreation);
        CreationScan(v111, p109, v.Id);
    end;

    if #v112 ~= 0 then
        local v123 = `[{script.Name}]: GROUP REPLICATION ERROR - Missing parents for:\n`;

        for i = 1, math.min(#v112, 50) do
            local v124 = v112[i];
            local SelfCreation = v124.SelfCreation;
            local _ = i;
            local v125 = "";
            local v126 = true;

            for i2, v in pairs(SelfCreation[2]) do
                v125 = v125 .. `{v126 == true and "" or ";"}{tostring(i2)}={tostring(v)}`;
                v126 = false;
            end;

            v123 = v123 .. `[Id:{v124.Id};ParentId:{SelfCreation[4]};Token:{SelfCreation[1]};Tags:\{{v125}}]\n`;
        end;

        if #v112 > 50 then
            v123 = v123 .. `(hiding {50 - #v112} more)\n`;
        end;

        local v127 = v123 .. "Traceback:\n" .. debug.traceback();
        warn(v127);
    end;

    return v122;
end;

local function GetInternalReplica(p128) -- Line: 729
    -- upvalues: u4 (copy), u5 (copy)
    local v129 = u4[p128] or u5[p128];

    if v129 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p128}]`));
    end;

    return v129;
end;

u8.OnClientEvent:Connect(function() -- Line: 739
    -- upvalues: u39 (copy)
    if u39.IsReady == true then
        return;
    end;

    u39.IsReady = true;
    print((`[{script.Name}]: Initial data received`));
    u39.OnLocalReady:Fire();
end);
v9.OnClientEvent:Connect(function(p130: number, p131: table, p132: any) -- Line: 751
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v133 = u4[p130] or u5[p130];

    if v133 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p130}]`));
    end;

    u21 = true;
    local success, result = pcall(v133.Set, v133, p131, p132);
    u21 = false;

    if success ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v133:Identify()}\n` .. result);
    end;
end);
v10.OnClientEvent:Connect(function(p134: number, p135: table, p136: table) -- Line: 761
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v137 = u4[p134] or u5[p134];

    if v137 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p134}]`));
    end;

    u21 = true;
    local success, result = pcall(v137.SetValues, v137, p135, p136);
    u21 = false;

    if success ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v137:Identify()}\n` .. result);
    end;
end);
v11.OnClientEvent:Connect(function(p138: number, p139: table, p140: any, p141: number?) -- Line: 771
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v142 = u4[p138] or u5[p138];

    if v142 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p138}]`));
    end;

    u21 = true;
    local success, result = pcall(v142.TableInsert, v142, p139, p140, p141);
    u21 = false;

    if success ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v142:Identify()}\n` .. result);
    end;
end);
v12.OnClientEvent:Connect(function(p143: number, p144: table, p145: number) -- Line: 781
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v146 = u4[p143] or u5[p143];

    if v146 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p143}]`));
    end;

    u21 = true;
    local success, result = pcall(v146.TableRemove, v146, p144, p145);
    u21 = false;

    if success ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v146:Identify()}\n` .. result);
    end;
end);
v13.OnClientEvent:Connect(function(p147: number, p148: number, ...) -- Line: 791
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v149 = u4[p147] or u5[p147];

    if v149 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p147}]`));
    end;

    u21 = true;
    local success, result = pcall(v149.Write, v149, v149.write_lib[p148].Name, ...);
    u21 = false;

    if success ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v149:Identify()}\n` .. result);
    end;
end);

local function RemoteSignalHandle(p150: number, ...) -- Line: 802
    -- upvalues: u4 (copy), u5 (copy)
    local v151 = u4[p150] or u5[p150];

    if v151 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p150}]`));
    end;

    v151.OnClientEvent:Fire(...);
end;

u14.OnClientEvent:Connect(RemoteSignalHandle);
u19.OnClientEvent:Connect(RemoteSignalHandle);
v15.OnClientEvent:Connect(function(p152: number, p153: number) -- Line: 810
    -- upvalues: u4 (copy), u5 (copy), ReplicaFromBindBuffer (copy), ReplicaToBindBuffer (copy)
    local v154 = u4[p152] or u5[p152];

    if v154 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p152}]`));
    end;

    local Parent = v154.Parent;
    local v155 = u4[p153] or u5[p153];

    if v155 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p153}]`));
    end;

    Parent.Children[v154] = nil;
    v155.Children[v154] = true;
    v154.Parent = v155;
    v154.self_creation[4] = p153;

    if u5[Parent.Id] == nil or u4[p153] == nil then
        if u4[Parent.Id] ~= nil and u5[p153] ~= nil then
            ReplicaToBindBuffer(v154);
        end;

        return;
    end;

    ReplicaFromBindBuffer(v154);
end);
v16.OnClientEvent:Connect(function(p156: table, p157: number?) -- Line: 831
    -- upvalues: BreadthCreationSort (copy), ReplicaNew (copy), u6 (copy), u5 (copy), u3 (copy), u4 (copy), u7 (copy)
    local u158 = {};
    BreadthCreationSort(p156, p157, function(p159: number, p160: table) -- Line: 835
        -- upvalues: ReplicaNew (ref), u6 (ref), u5 (ref), u3 (ref), u4 (ref), u158 (copy)
        local v161 = p160[4];
        local v162 = ReplicaNew(p159, p160);
        local v163 = false;

        if v161 == 0 then
            if v162.Tags.Bind == true then
                local v164 = u6[p159];
                v162.BoundInstance = v164;
                v163 = v164 == nil and true or v163;
            end;
        else
            v163 = u5[v161] ~= nil and true or v163;
        end;

        if v163 == true then
            u5[p159] = v162;

            return;
        end;

        local Token = v162.Token;
        local v165 = u3[Token];

        if v165 == nil then
            v165 = {};
            u3[Token] = v165;
        end;

        v165[v162] = true;
        u4[p159] = v162;
        table.insert(u158, v162);
    end);

    for _, v in ipairs(u158) do
        local v166 = u7[v.Token];

        if v166 ~= nil then
            local v167 = v;

            for i in pairs(v166) do
                ConnectionFire(i, v167);
            end;
        end;
    end;
end);
v17.OnClientEvent:Connect(function(p168: number) -- Line: 892
    -- upvalues: u4 (copy), u5 (copy), u6 (copy), ReplicaToBindBuffer (copy)
    local v169 = u4[p168] or u5[p168];

    if v169 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p168}]`));
    end;

    v169.Tags.Bind = true;
    local v170 = u6[p168];
    v169.BoundInstance = v170;

    if v170 == nil then
        ReplicaToBindBuffer(v169);
    end;
end);
v18.OnClientEvent:Connect(function(p171: number) -- Line: 906
    -- upvalues: u4 (copy), u5 (copy), DestroyReplica (copy)
    local v172 = u4[p171] or u5[p171];

    if v172 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p171}]`));
    end;

    DestroyReplica(v172);
end);

local function OnBindInstanceAdded(p173: userdata) -- Line: 913
    -- upvalues: u6 (copy), u5 (copy), ReplicaFromBindBuffer (copy)
    local Value = p173.Value;
    local Parent = p173.Parent;
    u6[Value] = Parent;
    local v174 = u5[Value];

    if v174 ~= nil then
        v174.BoundInstance = Parent;
        ReplicaFromBindBuffer(v174);
    end;
end;

local function OnBindInstanceRemoved(p175: userdata) -- Line: 928
    -- upvalues: u6 (copy), u4 (copy), ReplicaToBindBuffer (copy)
    local Value = p175.Value;
    u6[Value] = nil;
    local v176 = u4[Value];

    if v176 ~= nil then
        ReplicaToBindBuffer(v176);
    end;
end;

CollectionService:GetInstanceAddedSignal("REPLICA"):Connect(function(p177: userdata) -- Line: 941
    -- upvalues: u6 (copy), u5 (copy), ReplicaFromBindBuffer (copy)
    if p177:IsA("NumberValue") == true then
        local Value = p177.Value;
        local Parent = p177.Parent;
        u6[Value] = Parent;
        local v178 = u5[Value];

        if v178 ~= nil then
            v178.BoundInstance = Parent;
            ReplicaFromBindBuffer(v178);
        end;
    end;
end);
CollectionService:GetInstanceRemovedSignal("REPLICA"):Connect(function(p179: userdata) -- Line: 947
    -- upvalues: u6 (copy), u4 (copy), ReplicaToBindBuffer (copy)
    if p179:IsA("NumberValue") == true then
        local Value = p179.Value;
        u6[Value] = nil;
        local v180 = u4[Value];

        if v180 ~= nil then
            ReplicaToBindBuffer(v180);
        end;
    end;
end);

for _, v in pairs(CollectionService:GetTagged("REPLICA")) do
    if v:IsA("NumberValue") == true then
        local Value = v.Value;
        local Parent = v.Parent;
        u6[Value] = Parent;
        local v181 = u5[Value];

        if v181 ~= nil then
            v181.BoundInstance = Parent;
            ReplicaFromBindBuffer(v181);
        end;
    end;
end;

return u39;