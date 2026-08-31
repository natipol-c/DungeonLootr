--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     server
  Path:     game.ReplicatedStorage.Packages._Index.aykut92_replica@0.1.7.replica.server
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

local Shared = script.Parent.Shared;
local RateLimit = require(Shared.RateLimit);
local Remote = require(Shared.Remote);
local Signal = require(Shared.Signal);
local Maid = require(Shared.Maid);
local u1 = {};
local u2 = {};
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local u3 = RateLimit.New(120);
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = Remote.New("ReplicaRequestData");
local u10 = Remote.New("ReplicaSet");
local u11 = Remote.New("ReplicaSetValues");
local u12 = Remote.New("ReplicaTableInsert");
local u13 = Remote.New("ReplicaTableRemove");
local u14 = Remote.New("ReplicaWrite");
local u15 = Remote.New("ReplicaSignal");
local u16 = Remote.New("ReplicaParent");
local u17 = Remote.New("ReplicaCreate");
local u18 = Remote.New("ReplicaBind");
local u19 = Remote.New("ReplicaDestroy");
local u20 = Remote.New("ReplicaSignalUnreliable", true);
local u21 = 0;
local u22 = {};
local u23 = false;
local u24 = {};
local u25 = {};
local NumberValue = Instance.new("NumberValue");
NumberValue.Name = "ReplicaBind";
CollectionService:AddTag(NumberValue, "REPLICA");

local function IterateGroup(p26, p27) -- Line: 142
    -- upvalues: IterateGroup (copy)
    p27(p26);

    for i in pairs(p26.Children) do
        IterateGroup(i, p27);
    end;
end;

local function LoadWriteLib(p28: userdata) -- Line: 149
    -- upvalues: u22 (copy), ReplicatedStorage (copy)
    local v29 = u22[p28];

    if v29 ~= nil then
        return v29;
    end;

    if typeof(p28) == "Instance" and p28:IsA("ModuleScript") == true then
        if p28:IsDescendantOf(ReplicatedStorage) == false then
            error((`[{script.Name}]: "WriteLib" module must be a descendant of ReplicatedStorage`));
        end;
    else
        error((`[{script.Name}]: "WriteLib" is not a ModuleScript`));
    end;

    local v30 = require(p28);

    if type(v30) ~= "table" then
        error((`[{script.Name}]: A "WriteLib" ModuleScript must return a table`));
    end;

    local v31 = {};

    for i, v in pairs(v30) do
        if type(i) == "string" then
            if type(v) ~= "function" then
                error((`[{script.Name}]: "WriteLib" table values must be functions`));
            end;
        else
            error((`[{script.Name}]: "WriteLib" table keys must be strings`));
        end;

        table.insert(v31, { i, v });
    end;

    table.sort(v31, function(p32, p33) -- Line: 180
        return p32[1] < p33[1];
    end);
    local v34 = {};

    for i, v in ipairs(v31) do
        local v35 = {
            Id = i,
            fn = v[2]
        };
        v34[v[1]] = v35;
        v34[i] = v35;
    end;

    u22[p28] = v34;

    return v34;
end;

function GenerateCreation(p36)
    -- upvalues: IterateGroup (copy)
    local u37 = {};
    local u38 = {};
    local self_creation = p36.self_creation;
    self_creation[4] = p36.Parent == nil and 0 or p36.Parent.Id;
    u38[tostring(p36.Id)] = self_creation;
    p36.creation = u38;
    p36.replication = u37;

    local function v40(p39) -- Line: 201
        -- upvalues: u38 (copy), u37 (copy)
        local self_creation2 = p39.self_creation;
        self_creation2[4] = p39.Parent == nil and 0 or p39.Parent.Id;
        u38[tostring(p39.Id)] = self_creation2;
        p39.creation = u38;
        p39.replication = u37;
    end;

    for i in pairs(p36.Children) do
        IterateGroup(i, v40);
    end;
end;

local u41 = {
    ReadyPlayers = u4,
    NewReadyPlayer = Signal.New(),
    RemovingReadyPlayer = Signal.New()
};
u41.__index = u41;
local u42 = {};
u42.__index = u42;
local u43 = {};
u43.__index = u43;

function u41.Token(p44: string) -- Line: 256
    -- upvalues: u24 (copy), u42 (copy), u25 (copy)
    if type(p44) ~= "string" then
        error((`[{script.Name}]: name must be a string`));
    end;

    if u24[p44] == true then
        error((`[{script.Name}]: Token "{p44}" duplicate`));
    end;

    u24[p44] = true;
    local v45 = setmetatable({
        Name = p44
    }, u42);
    u25[v45] = true;

    return v45;
end;

function u41.New(p46: table) -- Line: 278
    -- upvalues: u25 (copy), LoadWriteLib (copy), u21 (ref), Signal (copy), Maid (copy), u1 (copy), u41 (copy), u5 (copy)
    local Token = p46.Token;
    local v47 = p46.Tags or {};
    local v48 = p46.Data or {};
    local v49 = nil;

    if u25[Token] == nil then
        error((`[{script.Name}]: "Token" is not valid ({tostring(Token)})`));
    elseif type(v47) == "table" then
        if type(v48) == "table" then
            if v47.Bind ~= nil then
                error((`[{script.Name}]: "Tags.Bind" key is reserved`));
            end;
        else
            error((`[{script.Name}]: "Data" is not a table`));
        end;
    else
        error((`[{script.Name}]: "Tags" is not a table`));
    end;

    if p46.WriteLib ~= nil then
        v49 = LoadWriteLib(p46.WriteLib);
    end;

    u21 = u21 + 1;
    local v50 = {
        Parent = nil,
        BoundInstance = nil,
        creation = nil,
        replication = nil,
        bind_value = nil,
        Tags = v47,
        Data = v48,
        Id = u21,
        Token = Token.Name,
        Children = {},
        OnServerEvent = Signal.New(),
        Maid = Maid.New(u1),
        self_creation = {
            Token.Name,
            v47,
            v48,
            0,
            p46.WriteLib
        },
        write_lib = v49,
        write_lib_module = p46.WriteLib
    };
    local v51 = setmetatable(v50, u41);
    u5[u21] = v51;

    return v51;
end;

function u41.FromId(p52: number) -- Line: 328
    -- upvalues: u5 (copy)
    return u5[p52];
end;

function u41.Test() -- Line: 332
    -- upvalues: u5 (copy), u6 (copy), u7 (copy), u8 (copy)
    return {
        Replicas = u5,
        TopReplicas = u6,
        ReplicationAllReplicas = u7,
        SelectiveSubscriptions = u8
    };
end;

function u41.Set(p53: table, p54: table, p55: any) -- Line: 341
    -- upvalues: u23 (ref), u4 (copy), u10 (copy)
    local Data = p53.Data;

    for i = 1, #p54 - 1 do
        Data = Data[p54[i]];
        local _ = i;
    end;

    Data[p54[#p54]] = p55;

    if u23 == false then
        local Id = p53.Id;

        if p53.replication ~= nil then
            if p53.replication.ALL == true then
                for i in pairs(u4) do
                    u10:FireClient(i, Id, p54, p55);
                end;

                return;
            end;

            for i in pairs(p53.replication) do
                u10:FireClient(i, Id, p54, p55);
            end;
        end;
    end;
end;

function u41.SetValues(p56: table, p57: table, p58: table) -- Line: 370
    -- upvalues: u23 (ref), u4 (copy), u11 (copy)
    local Data = p56.Data;

    for _, v in ipairs(p57) do
        Data = Data[v];
    end;

    for i, v in pairs(p58) do
        Data[i] = v;
    end;

    if u23 == false then
        local Id = p56.Id;

        if p56.replication ~= nil then
            if p56.replication.ALL == true then
                for i in pairs(u4) do
                    u11:FireClient(i, Id, p57, p58);
                end;

                return;
            end;

            for i in pairs(p56.replication) do
                u11:FireClient(i, Id, p57, p58);
            end;
        end;
    end;
end;

function u41.TableInsert(p59: table, p60: table, p61: any, p62: number?) -- Line: 401
    -- upvalues: u23 (ref), u4 (copy), u12 (copy)
    local Data = p59.Data;

    for _, v in ipairs(p60) do
        Data = Data[v];
    end;

    if p62 == nil then
        table.insert(Data, p61);
    else
        table.insert(Data, p62, p61);
    end;

    if u23 == false then
        local Id = p59.Id;

        if p59.replication ~= nil then
            if p59.replication.ALL == true then
                for i in pairs(u4) do
                    u12:FireClient(i, Id, p60, p61, p62);
                end;
            else
                for i in pairs(p59.replication) do
                    u12:FireClient(i, Id, p60, p61, p62);
                end;
            end;
        end;
    end;

    return p62 or #Data;
end;

function u41.TableRemove(p63: table, p64: table, p65: number) -- Line: 436
    -- upvalues: u23 (ref), u4 (copy), u13 (copy)
    local Data = p63.Data;

    for _, v in ipairs(p64) do
        Data = Data[v];
    end;

    local table_remove_ret = table.remove(Data, p65);

    if u23 == false then
        local Id = p63.Id;

        if p63.replication ~= nil then
            if p63.replication.ALL == true then
                for i in pairs(u4) do
                    u13:FireClient(i, Id, p64, p65);
                end;

                return table_remove_ret;
            end;

            for i in pairs(p63.replication) do
                u13:FireClient(i, Id, p64, p65);
            end;
        end;
    end;

    return table_remove_ret;
end;

function u41.Write(p66: table, p67: string, ...) -- Line: 467
    -- upvalues: u23 (ref), u4 (copy), u14 (copy)
    local v68 = p66.write_lib[p67];

    if u23 == true then
        return v68.fn(p66, ...);
    end;

    u23 = true;
    local table_pack_ret = table.pack(pcall(v68.fn, p66, ...));
    u23 = false;

    if table_pack_ret[1] ~= true then
        error(`[{script.Name}]: (WriteLib) ` .. tostring(table_pack_ret[2]));
    end;

    table.remove(table_pack_ret, 1);
    local Id = p66.Id;
    local Id2 = v68.Id;

    if p66.replication ~= nil then
        if p66.replication.ALL == true then
            for i in pairs(u4) do
                u14:FireClient(i, Id, Id2, ...);
            end;
        else
            for i in pairs(p66.replication) do
                u14:FireClient(i, Id, Id2, ...);
            end;
        end;
    end;

    return table.unpack(table_pack_ret);
end;

function u41.FireClient(p69, p70, ...) -- Line: 508
    -- upvalues: u4 (copy), u15 (copy)
    if p69.replication ~= nil and (p69.replication.ALL == true and u4[p70] == true or p69.replication[p70] ~= nil) then
        u15:FireClient(p70, p69.Id, ...);
    end;
end;

function u41.FireAllClients(p71, ...) -- Line: 516
    -- upvalues: u4 (copy), u15 (copy)
    local Id = p71.Id;

    if p71.replication ~= nil then
        if p71.replication.ALL == true then
            for i in pairs(u4) do
                u15:FireClient(i, Id, ...);
            end;

            return;
        end;

        for i in pairs(p71.replication) do
            u15:FireClient(i, Id, ...);
        end;
    end;
end;

function u41.UFireClient(p72, p73, ...) -- Line: 531
    -- upvalues: u4 (copy), u20 (copy)
    if p72.replication ~= nil and (p72.replication.ALL == true and u4[p73] == true or p72.replication[p73] ~= nil) then
        u20:FireClient(p73, p72.Id, ...);
    end;
end;

function u41.UFireAllClients(p74, ...) -- Line: 539
    -- upvalues: u4 (copy), u20 (copy)
    local Id = p74.Id;

    if p74.replication ~= nil then
        if p74.replication.ALL == true then
            for i in pairs(u4) do
                u20:FireClient(i, Id, ...);
            end;

            return;
        end;

        for i in pairs(p74.replication) do
            u20:FireClient(i, Id, ...);
        end;
    end;
end;

function u41.SetParent(p75, p76) -- Line: 554
    -- upvalues: u41 (copy), u5 (copy), u6 (copy), IterateGroup (copy), u2 (copy), u4 (copy), u19 (copy), u16 (copy), u17 (copy)
    if type(p76) == "table" and getmetatable(p76) == u41 then
        if u5[p76.Id] == nil then
            error((`[{script.Name}]: Can't set destroyed Replica as parent`));
        end;
    else
        error((`[{script.Name}]: new_parent is not a Replica ({tostring(p76)})`));
    end;

    if u6[p75] ~= nil then
        error((`[{script.Name}]: Can't change parent for top level Replica`));
    end;

    local u77;

    if p75.BoundInstance == nil then
        u77 = p76;
    else
        error((`[{script.Name}]: Can't change parent for bound Replica`));
        u77 = p76;
    end;

    while p76 ~= nil do
        p76 = p76.Parent;

        if p76 == p75 then
            error((`[{script.Name}]: Can't set descendant Replica as parent`));
        end;
    end;

    local Parent = p75.Parent;

    if Parent == u77 then
        return;
    end;

    p75.Parent = u77;

    if Parent ~= nil then
        Parent.Children[p75] = nil;
    end;

    u77.Children[p75] = true;

    local function v80(p78) -- Line: 601
        -- upvalues: Parent (copy), u77 (copy)
        local v79 = tostring(p78.Id);

        if Parent ~= nil and Parent.creation ~= nil then
            Parent.creation[v79] = nil;
        end;

        if u77.creation ~= nil then
            local self_creation = p78.self_creation;
            self_creation[4] = p78.Parent.Id;
            u77.creation[v79] = self_creation;
        end;

        p78.creation = u77.creation;
        p78.replication = u77.replication;
    end;

    local v81 = tostring(p75.Id);

    if Parent ~= nil and Parent.creation ~= nil then
        Parent.creation[v81] = nil;
    end;

    if u77.creation ~= nil then
        local self_creation = p75.self_creation;
        self_creation[4] = p75.Parent.Id;
        u77.creation[v81] = self_creation;
    end;

    p75.creation = u77.creation;
    p75.replication = u77.replication;

    for i in pairs(p75.Children) do
        IterateGroup(i, v80);
    end;

    local Id = p75.Id;
    local Id2 = u77.Id;
    local creation = u77.creation;
    local v82 = u2;

    if Parent ~= nil and Parent.replication ~= nil then
        if Parent.replication.ALL == true then
            v82 = u4;
        else
            v82 = Parent.replication;
        end;
    end;

    local v83 = u2;

    if u77 ~= nil and u77.replication ~= nil then
        if u77.replication.ALL == true then
            v83 = u4;
        else
            v83 = u77.replication;
        end;
    end;

    if Parent ~= nil and (Parent.replication ~= nil and (u77.replication ~= Parent.replication and v83 ~= u4)) then
        for i in pairs(v82) do
            if v83[i] == nil then
                u19:FireClient(i, Id);
            end;
        end;
    end;

    if u77.replication ~= nil then
        local u84 = nil;

        for i in pairs(v83) do
            if v82[i] == true then
                u16:FireClient(i, Id, Id2);
            else
                local v85;

                if u84 == nil then
                    u84 = {};

                    local function v88(p86) -- Line: 668
                        -- upvalues: u84 (ref), creation (copy)
                        local v87 = tostring(p86.Id);
                        u84[v87] = creation[v87];
                    end;

                    local v89 = tostring(p75.Id);
                    u84[v89] = creation[v89];
                    v85 = i;

                    for i2 in pairs(p75.Children) do
                        IterateGroup(i2, v88);
                    end;
                else
                    v85 = i;
                end;

                u17:FireClient(v85, u84, Id);
            end;
        end;
    end;
end;

function u41.BindToInstance(p90: table, p91: userdata) -- Line: 682
    -- upvalues: NumberValue (copy), u4 (copy), u18 (copy)
    if typeof(p91) ~= "Instance" then
        error((`[{script.Name}]: "instance" argument is not an Instance ({tostring(p91)})`));
    end;

    if p90.Parent ~= nil then
        error((`[{script.Name}]: Can't bind Replica parented to another Replica`));
    end;

    if p90.BoundInstance ~= nil then
        error((`[{script.Name}]: Can't change Replica bind to another Instance`));
    end;

    if p91:IsA("Model") == true and (p91.ModelStreamingMode == Enum.ModelStreamingMode.Default or p91.ModelStreamingMode == Enum.ModelStreamingMode.Nonatomic) then
        warn(`[{script.Name}]: Bound Replica to a model that has inproper "ModelStreamingMode" setup; Traceback:\n` .. debug.traceback());
    end;

    local v92 = NumberValue:Clone();
    v92.Value = p90.Id;
    p90.Tags.Bind = true;
    p90.BoundInstance = p91;
    p90.bind_value = v92;
    v92.Parent = p91;
    local Id = p90.Id;

    if p90.replication ~= nil then
        if p90.replication.ALL == true then
            for i in pairs(u4) do
                u18:FireClient(i, Id);
            end;

            return;
        end;

        for i in pairs(p90.replication) do
            u18:FireClient(i, Id);
        end;
    end;
end;

function u41.Replicate(p93) -- Line: 724
    -- upvalues: u6 (copy), u4 (copy), u17 (copy), u8 (copy), u7 (copy)
    if p93.Parent ~= nil then
        error((`[{script.Name}]: Can't selectively replicate Replica parented to another Replica`));
    end;

    if p93.creation == nil then
        GenerateCreation(p93);
        u6[p93] = true;
    elseif p93.replication.ALL == true then
        return;
    end;

    local creation = p93.creation;
    local replication = p93.replication;

    for i in pairs(u4) do
        if replication[i] == nil then
            u17:FireClient(i, creation);
        else
            u8[i][p93] = nil;
        end;
    end;

    table.clear(replication);
    replication.ALL = true;
    u7[p93] = true;
end;

function u41.DontReplicate(p94) -- Line: 755
    -- upvalues: u7 (copy), u4 (copy), u19 (copy), u8 (copy)
    if p94.Parent ~= nil then
        error((`[{script.Name}]: Can't selectively replicate Replica parented to another Replica`));
    end;

    local replication = p94.replication;

    if replication == nil or next(replication) == nil then
        return;
    end;

    u7[p94] = nil;
    local Id = p94.Id;

    if replication.ALL == true then
        for i in pairs(u4) do
            u19:FireClient(i, Id);
        end;
    else
        for i in pairs(replication) do
            u19:FireClient(i, Id);
            u8[i][p94] = nil;
        end;
    end;

    table.clear(replication);
end;

function u41.Subscribe(p95: table, p96: userdata) -- Line: 786
    -- upvalues: u6 (copy), u4 (copy), u8 (copy), u17 (copy)
    if p95.Parent ~= nil then
        error((`[{script.Name}]: Can't selectively replicate Replica parented to another Replica`));
    end;

    if p95.creation == nil then
        GenerateCreation(p95);
        u6[p95] = true;
    elseif p95.replication.ALL == true then
        error((`[{script.Name}]: "Subscribe()" is locked after calling "Replicate()"`));
    end;

    if u4[p96] == nil then
        warn(`[{script.Name}]: Called "Subscribe()" on a non-ready player; Traceback:\n` .. debug.traceback());

        return;
    end;

    local creation = p95.creation;
    local replication = p95.replication;

    if replication[p96] ~= nil then
        return;
    end;

    replication[p96] = true;
    u8[p96][p95] = true;
    u17:FireClient(p96, creation);
end;

function u41.Unsubscribe(p97: table, p98: userdata) -- Line: 817
    -- upvalues: u8 (copy), u19 (copy)
    if p97.Parent ~= nil then
        error((`[{script.Name}]: Can't selectively replicate Replica parented to another Replica`));
    end;

    local replication = p97.replication;

    if replication == nil then
        return;
    end;

    if replication.ALL == true then
        error((`[{script.Name}]: "Unsubscribe()" is locked after calling "Replicate()"`));
    end;

    if replication[p98] ~= nil then
        replication[p98] = nil;
        u8[p98][p97] = nil;
        u19:FireClient(p98, p97.Id);
    end;
end;

function u41.Identify(p99) -- Line: 841
    local v100 = "";
    local v101 = true;

    for i, v in pairs(p99.Tags) do
        v100 = v100 .. `{v101 == true and "" or ";"}{tostring(i)}={tostring(v)}`;
        v101 = false;
    end;

    return `[Id:{p99.Id};Token:{p99.Token};Tags:\{{v100}}]`;
end;

function u41.IsActive(p102) -- Line: 851
    return p102.Maid:IsActive();
end;

local function DestroyReplica(p103) -- Line: 855
    -- upvalues: DestroyReplica (copy), u5 (copy), u1 (copy), u43 (copy)
    for i in pairs(p103.Children) do
        DestroyReplica(i);
    end;

    local Id = p103.Id;
    u5[Id] = nil;
    p103.Maid:Unlock(u1);
    p103.Maid:Cleanup();

    if p103.BoundInstance ~= nil then
        p103.BoundInstance = nil;
        p103.bind_value:Destroy();
        p103.bind_value = nil;
    end;

    if p103.creation ~= nil then
        p103.creation[tostring(Id)] = nil;
    end;

    setmetatable(p103, u43);
end;

function u41.Destroy(p104) -- Line: 881
    -- upvalues: u5 (copy), u6 (copy), u4 (copy), u19 (copy), u8 (copy), u7 (copy), DestroyReplica (copy)
    local Id = p104.Id;

    if u5[Id] == nil then
        return;
    end;

    local v105 = u6[p104] == true;

    if p104.replication ~= nil then
        if p104.replication.ALL == true then
            for i in pairs(u4) do
                u19:FireClient(i, Id);
            end;
        else
            for i in pairs(p104.replication) do
                u19:FireClient(i, Id);

                if v105 == true then
                    u8[i][p104] = nil;
                end;
            end;
        end;
    end;

    u6[p104] = nil;
    u7[p104] = nil;

    if p104.Parent ~= nil then
        p104.Parent.Children[p104] = nil;
    end;

    DestroyReplica(p104);
end;

local v106 = {
    Identify = true,
    Destroy = true
};

for i, v in pairs(u41) do
    if i ~= "__index" then
        if v106[i] == true then
            u43[i] = v;
        else
            u43[i] = function(p107) -- Line: 937
                -- upvalues: i (copy)
                error((`[{script.Name}]: Tried to call method "{i}" for a destroyed replica; {p107:Identify()}`));
            end;
        end;
    end;
end;

u9.OnServerEvent:Connect(function(p108: userdata) -- Line: 948
    -- upvalues: u4 (copy), Players (copy), u7 (copy), u17 (copy), u9 (copy), u8 (copy), u41 (copy)
    if u4[p108] ~= nil and p108:IsDescendantOf(Players) == true then
        return;
    end;

    local v109 = {};

    for i in pairs(u7) do
        table.insert(v109, i.creation);
    end;

    u17:FireClient(p108, v109);
    u9:FireClient(p108);
    u4[p108] = true;
    u8[p108] = {};
    u41.NewReadyPlayer:Fire(p108);
end);

local function RemoteSignalHandle(p110: userdata, p111: number, ...) -- Line: 976
    -- upvalues: u4 (copy), u3 (copy), u5 (copy)
    if u4[p110] == nil or (u3:CheckRate(p110) == false or type(p111) ~= "number") then
        return;
    end;

    local v112 = u5[p111];

    if v112 ~= nil and (v112.replication ~= nil and (v112.replication.ALL == true or v112.replication[p110] ~= nil)) then
        v112.OnServerEvent:Fire(p110, ...);
    end;
end;

u15.OnServerEvent:Connect(RemoteSignalHandle);
u20.OnServerEvent:Connect(RemoteSignalHandle);
Players.PlayerRemoving:Connect(function(p113) -- Line: 999
    -- upvalues: u4 (copy), u8 (copy), u41 (copy)
    if u4[p113] == nil then
        return;
    end;

    for i in pairs(u8[p113]) do
        i.replication[p113] = nil;
    end;

    u4[p113] = nil;
    u8[p113] = nil;
    u41.RemovingReadyPlayer:Fire(p113);
end);

return u41;