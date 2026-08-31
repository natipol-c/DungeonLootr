--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     profilestore
  Path:     game.ReplicatedStorage.Packages._Index.aykut92_profilestore@1.0.21.profilestore
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:39 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = 300;
local u2 = 10;
local u3 = 5;
local u4 = 40;
local u5 = 630;
local u6 = 120;
local u7 = 5;
local u8 = 120;
local u9 = 120;
local u10 = 1000;
local u11 = nil;

local function AcquireRunnerThreadAndCallEventHandler(p12, ...) -- Line: 199
    -- upvalues: u11 (ref)
    local v13 = u11;
    u11 = nil;
    p12(...);
    u11 = v13;
end;

local function RunEventHandlerInFreeThread(...) -- Line: 207
    -- upvalues: AcquireRunnerThreadAndCallEventHandler (copy)
    AcquireRunnerThreadAndCallEventHandler(...);

    while true do
        AcquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

local u14 = {};
u14.__index = u14;
local u15 = {};
u15.__index = u15;

function u14.Disconnect(p16) -- Line: 220
    if p16.is_connected == false then
        return;
    end;

    local signal = p16.signal;
    p16.is_connected = false;
    signal.listener_count = signal.listener_count - 1;

    if signal.head == p16 then
        signal.head = p16.next;

        return;
    end;

    local head = signal.head;

    while head ~= nil and head.next ~= p16 do
        head = head.next;
    end;

    if head ~= nil then
        head.next = p16.next;
    end;
end;

function u15.New() -- Line: 244
    -- upvalues: u15 (copy)
    local v17 = {
        head = nil,
        listener_count = 0
    };
    setmetatable(v17, u15);

    return v17;
end;

function u15.Connect(p18: table, p19: function) -- Line: 256
    -- upvalues: u14 (copy)
    if type(p19) ~= "function" then
        error((`[{script.Name}]: "listener" must be a function; Received {typeof(p19)}`));
    end;

    local v20 = {
        is_connected = true,
        listener = p19,
        signal = p18,
        next = p18.head
    };
    setmetatable(v20, u14);
    p18.head = v20;
    p18.listener_count = p18.listener_count + 1;

    return v20;
end;

function u15.GetListenerCount(p21) -- Line: 277
    return p21.listener_count;
end;

function u15.Fire(p22, ...) -- Line: 281
    -- upvalues: u11 (ref), RunEventHandlerInFreeThread (copy)
    local head = p22.head;

    while head ~= nil do
        if head.is_connected == true then
            if not u11 then
                u11 = coroutine.create(RunEventHandlerInFreeThread);
            end;

            task.spawn(u11, head.listener, ...);
        end;

        head = head.next;
    end;
end;

function u15.Wait(p23) -- Line: 294
    local coroutine_running_ret = coroutine.running();
    local u24 = nil;
    u24 = p23:Connect(function(...) -- Line: 297
        -- upvalues: u24 (ref), coroutine_running_ret (copy)
        u24:Disconnect();
        task.spawn(coroutine_running_ret, ...);
    end);

    return coroutine.yield();
end;

local table_freeze_ret = table.freeze({
    New = u15.New
});
local u25 = {};
local u26 = {};
local u27 = {};
local DataStoreService = game:GetService("DataStoreService");
local MessagingService = game:GetService("MessagingService");
local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local game_PlaceId = game.PlaceId;
local game_JobId = game.JobId;
local u28 = 1;
local os_clock_ret = os.clock();
local u29 = 0;
local u30 = 0;
local u31 = 0;
local u32 = 0;
local u33 = RunService:IsStudio();
local u34 = "NotReady";
local u35 = {};
local u36 = {};
local u37 = false;
local u38 = table_freeze_ret.New();
local u39 = table_freeze_ret.New();
local u40 = {};

local function WaitInUpdateQueue(u41) -- Line: 353
    -- upvalues: u40 (copy)
    local v42;

    if u40[u41] == nil then
        u40[u41] = {};
        v42 = true;
    else
        v42 = false;
    end;

    local u43 = u40[u41];

    if v42 == false then
        table.insert(u43, coroutine.running());
        coroutine.yield();
    end;

    return function() -- Line: 369
        -- upvalues: u43 (copy), u40 (ref), u41 (copy)
        local table_remove_ret = table.remove(u43, 1);

        if table_remove_ret == nil then
            u40[u41] = nil;

            return;
        end;

        coroutine.resume(table_remove_ret);
    end;
end;

local function SessionToken(p44, p45, p46) -- Line: 380
    -- upvalues: u34 (ref)
    return (p46 == true and "U_" or (u34 ~= "Access" and "M_" or "L_")) .. p44 .. "\0" .. p45;
end;

local function DeepCopyTable(p47) -- Line: 396
    -- upvalues: DeepCopyTable (copy)
    local v48 = {};

    for i, v in pairs(p47) do
        if type(v) == "table" then
            v48[i] = DeepCopyTable(v);
        else
            v48[i] = v;
        end;
    end;

    return v48;
end;

local function ReconcileTable(p49, p50) -- Line: 408
    -- upvalues: DeepCopyTable (copy), ReconcileTable (copy)
    for i, v in pairs(p50) do
        if type(i) == "string" then
            if p49[i] == nil then
                if type(v) == "table" then
                    p49[i] = DeepCopyTable(v);
                else
                    p49[i] = v;
                end;
            elseif type(p49[i]) == "table" and type(v) == "table" then
                ReconcileTable(p49[i], v);
            end;
        end;
    end;
end;

local function RegisterError(p51, p52, p53) -- Line: 424
    -- upvalues: u27 (copy), u38 (copy)
    warn((`[{script.Name}]: DataStore API error (STORE:{p52}; KEY:{p53}) - {tostring(p51)}`));
    table.insert(u27, os.clock());
    u38:Fire(tostring(p51), p52, p53);
end;

local function RegisterOverwrite(p54, p55) -- Line: 430
    -- upvalues: u39 (copy)
    warn((`[{script.Name}]: Invalid profile was overwritten (STORE:{p54}; KEY:{p55})`));
    u39:Fire(p54, p55);
end;

local function NewMockDataStoreKeyInfo(p56) -- Line: 435
    -- upvalues: DeepCopyTable (copy)
    local v57 = tostring(p56.VersionId or 0);
    local u58 = p56.MetaData or {};
    local u59 = p56.UserIds or {};

    return {
        CreatedTime = p56.CreatedTime,
        UpdatedTime = p56.UpdatedTime,
        Version = string.rep("0", 16) .. "." .. string.rep("0", 10 - string.len(v57)) .. v57 .. "." .. string.rep("0", 16) .. ".01",

        GetMetadata = function() -- Line: 448, Name: GetMetadata
            -- upvalues: DeepCopyTable (ref), u58 (copy)
            return DeepCopyTable(u58);
        end,

        GetUserIds = function() -- Line: 452, Name: GetUserIds
            -- upvalues: DeepCopyTable (ref), u59 (copy)
            return DeepCopyTable(u59);
        end
    };
end;

local function MockUpdateAsync(p60, p61, p62, p63, p64) -- Line: 459
    -- upvalues: NewMockDataStoreKeyInfo (copy), DeepCopyTable (copy)
    local v65 = p60[p61];

    if v65 == nil then
        v65 = {};
        p60[p61] = v65;
    end;

    local v66 = os.time() * 1000;
    local math_floor_ret = math.floor(v66);
    local v67 = v65[p62];
    local v68;

    if v67 == nil then
        v68 = true;

        if p64 ~= true then
            v67 = {
                Data = nil,
                VersionId = 0,
                CreatedTime = math_floor_ret,
                UpdatedTime = math_floor_ret,
                UserIds = {},
                MetaData = {}
            };
            v65[p62] = v67;
        end;
    else
        v68 = false;
    end;

    local v69;

    if v68 == false then
        v69 = NewMockDataStoreKeyInfo(v67) or nil;
    else
        v69 = nil;
    end;

    local v70;

    if v67 then
        v70 = v67.Data;
    else
        v70 = v67;
    end;

    local v71, v72, v73 = p63(v70, v69);

    if v71 == nil then
        return nil;
    end;

    if v67 ~= nil and p64 ~= true then
        v67.Data = DeepCopyTable(v71);
        v67.UserIds = DeepCopyTable(v72 or {});
        v67.MetaData = DeepCopyTable(v73 or {});
        v67.VersionId = v67.VersionId + 1;
        v67.UpdatedTime = math_floor_ret;
    end;

    local v74 = DeepCopyTable(v71);
    local v75;

    if v67 == nil then
        v75 = nil;
    else
        v75 = NewMockDataStoreKeyInfo(v67) or nil;
    end;

    return v74, v75;
end;

local function UpdateAsync(u76, u77, u78, u79, u80, u81) -- Line: 507
    -- upvalues: WaitInUpdateQueue (copy), u34 (ref), MockUpdateAsync (copy), u36 (copy), u35 (copy), u39 (copy), u27 (copy), u38 (copy)
    local u82 = nil;
    local u83 = nil;
    local v84 = WaitInUpdateQueue((u79 == true and "U_" or (u34 ~= "Access" and "M_" or "L_")) .. u76.Name .. "\0" .. u77);
    local success, result = pcall(function() -- Line: 520
        -- upvalues: u78 (copy), u79 (copy), u82 (ref), u83 (ref), MockUpdateAsync (ref), u36 (ref), u76 (copy), u77 (copy), u80 (copy), u34 (ref), u35 (ref), u81 (copy)
        local function v89(p85) -- Line: 521
            -- upvalues: u78 (ref)
            local v86 = false;
            local v87 = false;
            local v88 = { 0, {} };

            if p85 == nil then
                v86 = true;
            elseif type(p85) == "table" then
                if type(p85.Data) == "table" and (type(p85.MetaData) == "table" and type(p85.GlobalUpdates) == "table") then
                    p85.WasOverwritten = false;
                    v88 = p85.GlobalUpdates;

                    if u78.ExistingProfileHandle ~= nil then
                        u78.ExistingProfileHandle(p85);
                    end;
                elseif p85.Data == nil and (p85.MetaData == nil and type(p85.GlobalUpdates) == "table") then
                    p85.WasOverwritten = false;
                    v88 = p85.GlobalUpdates or v88;
                    v86 = true;
                else
                    v86 = true;
                    v87 = true;
                end;
            else
                v86 = true;
                v87 = true;
            end;

            if v86 == true then
                p85 = {
                    GlobalUpdates = v88
                };

                if u78.MissingProfileHandle ~= nil then
                    u78.MissingProfileHandle(p85);
                end;
            end;

            if u78.EditProfile ~= nil then
                u78.EditProfile(p85);
            end;

            if v87 == true then
                p85.WasOverwritten = true;
            end;

            return p85, p85.UserIds, p85.RobloxMetaData;
        end;

        if u79 == true then
            local v90, v91 = MockUpdateAsync(u36, u76.Name, u77, v89, u80);
            u82 = v90;
            u83 = v91;
            task.wait();

            return;
        end;

        if u34 == "Access" then
            if u80 == true then
                if u81 == nil then
                    local Async, v92 = u76.data_store:GetAsync(u77);
                    u82 = Async;
                    u83 = v92;
                else
                    local success, result = pcall(function() -- Line: 607
                        -- upvalues: u82 (ref), u83 (ref), u76 (ref), u77 (ref), u81 (ref)
                        local VersionAsync, v93 = u76.data_store:GetVersionAsync(u77, u81);
                        u82 = VersionAsync;
                        u83 = v93;
                    end);

                    if success == false and (type(result) == "string" and string.find(result, "not valid") ~= nil) then
                        warn(`[{script.Name}]: Passed version argument is not valid; Traceback:\n` .. debug.traceback());
                    end;
                end;

                u82 = v89(u82);

                return;
            end;

            local v94, v95 = u76.data_store:UpdateAsync(u77, v89);
            u82 = v94;
            u83 = v95;

            return;
        end;

        local v96, v97 = MockUpdateAsync(u35, u76.Name, u77, v89, u80);
        u82 = v96;
        u83 = v97;
        task.wait();
    end);
    v84();

    if success == true and type(u82) == "table" then
        if u82.WasOverwritten == true and u80 ~= true then
            local Name = u76.Name;
            warn((`[{script.Name}]: Invalid profile was overwritten (STORE:{Name}; KEY:{u77})`));
            u39:Fire(Name, u77);
        end;

        return u82, u83;
    end;

    local v98 = result or "Undefined error";
    local Name = u76.Name;
    warn((`[{script.Name}]: DataStore API error (STORE:{Name}; KEY:{u77}) - {tostring(v98)}`));
    table.insert(u27, os.clock());
    u38:Fire(tostring(v98), Name, u77);

    return nil;
end;

local function IsThisSession(p99) -- Line: 658
    -- upvalues: game_PlaceId (copy), game_JobId (copy)
    local v100;

    if p99[1] == game_PlaceId then
        v100 = p99[2] == game_JobId;
    else
        v100 = false;
    end;

    return v100;
end;

local function ReadMockFlag() -- Line: 662
    -- upvalues: u37 (ref)
    local v101 = u37;
    u37 = false;

    return v101;
end;

local function WaitForStoreReady(p102) -- Line: 668
    while p102.is_ready == false do
        task.wait();
    end;
end;

local function AddProfileToAutoSave(p103) -- Line: 674
    -- upvalues: u25 (copy), u26 (copy), u28 (ref), os_clock_ret (ref)
    u25[p103.session_token] = p103;
    table.insert(u26, u28, p103);

    if #u26 > 1 then
        u28 = u28 + 1;

        return;
    end;

    if #u26 == 1 then
        os_clock_ret = os.clock();
    end;
end;

local function RemoveProfileFromAutoSave(p104) -- Line: 691
    -- upvalues: u25 (copy), u26 (copy), u28 (ref)
    u25[p104.session_token] = nil;
    local table_find_ret = table.find(u26, p104);

    if table_find_ret ~= nil then
        table.remove(u26, table_find_ret);

        if table_find_ret < u28 then
            u28 = u28 - 1;
        end;

        if u26[u28] == nil then
            u28 = 1;
        end;
    end;
end;

local function SaveProfileAsync(u105, u106, u107, p108) -- Line: 709
    -- upvalues: u25 (copy), u26 (copy), u28 (ref), u31 (ref), UpdateAsync (copy), game_PlaceId (copy), game_JobId (copy), SaveProfileAsync (copy), DeepCopyTable (copy)
    if type(u105.Data) ~= "table" then
        error((`[{script.Name}]: Developer code likely set "Profile.Data" to a non-table value! (STORE:{u105.ProfileStore.Name}; KEY:{u105.Key})`));
    end;

    u105.OnSave:Fire();

    if u106 == true then
        u105.OnLastSave:Fire(p108 or "Manual");
    end;

    if u106 == true and u107 ~= true then
        if u105.roblox_message_subscription ~= nil then
            u105.roblox_message_subscription:Disconnect();
        end;

        u25[u105.session_token] = nil;
        local table_find_ret = table.find(u26, u105);

        if table_find_ret ~= nil then
            table.remove(u26, table_find_ret);

            if table_find_ret < u28 then
                u28 = u28 - 1;
            end;

            if u26[u28] == nil then
                u28 = 1;
            end;
        end;

        u105.OnSessionEnd:Fire();
    end;

    u31 = u31 + 1;
    local v109 = true;
    local v110 = 1;

    while v109 == true do
        if u106 ~= true then
            v109 = false;
        end;

        local v115, v116 = UpdateAsync(u105.ProfileStore, u105.Key, {
            ExistingProfileHandle = nil,
            MissingProfileHandle = nil,

            EditProfile = function(p111) -- Line: 747, Name: EditProfile
                -- upvalues: u107 (copy), game_PlaceId (ref), game_JobId (ref), u105 (copy), u106 (copy)
                local v112 = false;

                if u107 == true then
                    v112 = true;
                else
                    local ActiveSession = p111.MetaData.ActiveSession;
                    local SessionLoadCount = p111.MetaData.SessionLoadCount;

                    if type(ActiveSession) == "table" then
                        if ActiveSession[1] == game_PlaceId then
                            v112 = ActiveSession[2] == game_JobId;
                        else
                            v112 = false;
                        end;

                        if v112 then
                            v112 = SessionLoadCount == u105.load_index;
                        end;
                    end;
                end;

                if v112 == true then
                    local locked_global_updates = u105.locked_global_updates;
                    local v113 = p111.GlobalUpdates[2];

                    if next(locked_global_updates) ~= nil then
                        local v114 = 1;

                        while v114 <= #v113 do
                            if locked_global_updates[v113[v114][1]] == true then
                                table.remove(v113, v114);
                            else
                                v114 = v114 + 1;
                            end;
                        end;
                    end;

                    p111.Data = u105.Data;
                    p111.RobloxMetaData = u105.RobloxMetaData;
                    p111.UserIds = u105.UserIds;

                    if u107 == true then
                        p111.MetaData.ActiveSession = nil;
                        p111.MetaData.ForceLoadSession = nil;
                    else
                        p111.MetaData.LastUpdate = os.time();

                        if u106 == true then
                            p111.MetaData.ActiveSession = nil;
                        end;
                    end;
                end;
            end
        }, u105.is_mock);

        if v115 == nil or v116 == nil then
            if v109 == true then
                task.wait(v110);
                v110 = math.min(p108 == "Shutdown" and 8 or 20, v110 * 2);
            end;
        else
            if u107 == true then
                break;
            end;

            v109 = false;
            local ActiveSession = v115.MetaData.ActiveSession;
            local SessionLoadCount = v115.MetaData.SessionLoadCount;
            local v117;

            if type(ActiveSession) == "table" then
                if ActiveSession[1] == game_PlaceId then
                    v117 = ActiveSession[2] == game_JobId;
                else
                    v117 = false;
                end;

                if v117 then
                    v117 = SessionLoadCount == u105.load_index;
                end;
            else
                v117 = false;
            end;

            local ForceLoadSession = v115.MetaData.ForceLoadSession;
            local v118;

            if type(ForceLoadSession) == "table" then
                local v119;

                if ForceLoadSession[1] == game_PlaceId then
                    v119 = ForceLoadSession[2] == game_JobId;
                else
                    v119 = false;
                end;

                v118 = not v119;
            else
                v118 = false;
            end;

            local v120 = u105:IsActive();

            if v118 == true and v117 == true then
                if v120 == true then
                    SaveProfileAsync(u105, true, false, "External");
                end;

                break;
            end;

            local locked_global_updates = u105.locked_global_updates;
            local received_global_updates = u105.received_global_updates;
            local v121 = {};
            local v122 = {};

            for _, v in ipairs(v115.GlobalUpdates[2]) do
                if locked_global_updates[v[1]] == true then
                    v122[v[1]] = true;
                elseif received_global_updates[v[1]] ~= true then
                    received_global_updates[v[1]] = true;
                    table.insert(v121, v);
                end;
            end;

            for i in pairs(locked_global_updates) do
                if v122[i] ~= true then
                    locked_global_updates[i] = nil;
                end;
            end;

            u105.KeyInfo = v116;
            u105.LastSavedData = v115.Data;
            u105.global_updates = v115.GlobalUpdates and v115.GlobalUpdates[2] or {};

            if v117 == true then
                if v120 == true and u106 ~= true then
                    for _, v in ipairs(v121) do
                        local u123 = v[1];
                        local v124 = v[#v];

                        for _, v2 in ipairs(u105.message_handlers) do
                            local u125 = false;

                            local function v126() -- Line: 893
                                -- upvalues: u125 (ref), locked_global_updates (copy), u123 (copy)
                                u125 = true;
                                locked_global_updates[u123] = true;
                            end;

                            local v127 = DeepCopyTable(v124);
                            task.spawn(v2, v127, v126);

                            if u125 == true then
                                break;
                            end;
                        end;
                    end;
                end;
            else
                if u105.roblox_message_subscription ~= nil then
                    u105.roblox_message_subscription:Disconnect();
                end;

                if v120 == true then
                    u25[u105.session_token] = nil;
                    local table_find_ret = table.find(u26, u105);

                    if table_find_ret ~= nil then
                        table.remove(u26, table_find_ret);

                        if table_find_ret < u28 then
                            u28 = u28 - 1;
                        end;

                        if u26[u28] == nil then
                            u28 = 1;
                        end;
                    end;

                    u105.OnSessionEnd:Fire();
                end;
            end;

            u105.OnAfterSave:Fire(u105.LastSavedData);
        end;
    end;

    u31 = u31 - 1;
end;

local u128 = {};
u128.__index = u128;

function u128.New(p129, p130, p131, p132, p133, p134) -- Line: 1033
    -- upvalues: DeepCopyTable (copy), table_freeze_ret (ref), u128 (copy)
    local v135 = p129.Data or {};
    local v136;

    if p129.MetaData then
        v136 = p129.MetaData.ActiveSession or nil;
    else
        v136 = nil;
    end;

    local v137 = p129.GlobalUpdates and (p129.GlobalUpdates[2] or {}) or {};
    local v138 = {};

    for _, v in ipairs(v137) do
        v138[v[1]] = true;
    end;

    local v139 = {
        Data = v135,
        LastSavedData = DeepCopyTable(v135),
        FirstSessionTime = p129.MetaData and (p129.MetaData.ProfileCreateTime or 0) or 0,
        SessionLoadCount = p129.MetaData and (p129.MetaData.SessionLoadCount or 0) or 0,
        Session = v136 and {
            PlaceId = v136[1],
            JobId = v136[2]
        },
        RobloxMetaData = p129.RobloxMetaData or {},
        UserIds = p129.UserIds or {},
        KeyInfo = p130,
        OnAfterSave = table_freeze_ret.New(),
        OnSave = table_freeze_ret.New(),
        OnLastSave = table_freeze_ret.New(),
        OnSessionEnd = table_freeze_ret.New(),
        ProfileStore = p131,
        Key = p132,
        load_timestamp = os.clock(),
        is_mock = p133,
        session_token = p134 or "",
        load_index = p129.MetaData and p129.MetaData.SessionLoadCount or 0,
        locked_global_updates = {},
        received_global_updates = v138,
        message_handlers = {},
        global_updates = v137
    };
    setmetatable(v139, u128);

    return v139;
end;

function u128.IsActive(p140) -- Line: 1082
    -- upvalues: u25 (copy)
    return u25[p140.session_token] == p140;
end;

function u128.Reconcile(p141) -- Line: 1086
    -- upvalues: ReconcileTable (copy)
    ReconcileTable(p141.Data, p141.ProfileStore.template);
end;

function u128.EndSession(p142) -- Line: 1090
    -- upvalues: SaveProfileAsync (copy)
    if p142:IsActive() == true then
        task.spawn(SaveProfileAsync, p142, true, nil, "Manual");
    end;
end;

function u128.AddUserId(p143, p144) -- Line: 1096
    -- upvalues: u34 (ref)
    if type(p144) ~= "number" or p144 % 1 ~= 0 then
        warn(`[{script.Name}]: Invalid UserId argument for :AddUserId() ({tostring(p144)}); Traceback:\n` .. debug.traceback());

        return;
    end;

    if p144 < 0 and (p143.is_mock ~= true and u34 == "Access") then
        return;
    end;

    if table.find(p143.UserIds, p144) == nil then
        table.insert(p143.UserIds, p144);
    end;
end;

function u128.RemoveUserId(p145, p146) -- Line: 1113
    if type(p146) ~= "number" or p146 % 1 ~= 0 then
        warn(`[{script.Name}]: Invalid UserId argument for :RemoveUserId() ({tostring(p146)}); Traceback:\n` .. debug.traceback());

        return;
    end;

    local table_find_ret = table.find(p145.UserIds, p146);

    if table_find_ret ~= nil then
        table.remove(p145.UserIds, table_find_ret);
    end;
end;

function u128.SetAsync(p147) -- Line: 1128
    -- upvalues: SaveProfileAsync (copy)
    if p147.view_mode ~= true then
        error((`[{script.Name}]: :SetAsync() can only be used in view mode`));
    end;

    SaveProfileAsync(p147, nil, true);
end;

function u128.MessageHandler(p148, p149) -- Line: 1138
    -- upvalues: DeepCopyTable (copy)
    if type(p149) ~= "function" then
        error((`[{script.Name}]: fn argument is not a function`));
    end;

    if p148.view_mode ~= true and p148:IsActive() ~= true then
        return;
    end;

    local locked_global_updates = p148.locked_global_updates;
    table.insert(p148.message_handlers, p149);

    for _, v in ipairs(p148.global_updates) do
        local u150 = v[1];
        local v151 = v[#v];

        if locked_global_updates[u150] ~= true then
            local v152 = DeepCopyTable(v151);
            task.spawn(p149, v152, function() -- Line: 1158
                -- upvalues: locked_global_updates (copy), u150 (copy)
                locked_global_updates[u150] = true;
            end);
        end;
    end;
end;

function u128.Save(p153) -- Line: 1172
    -- upvalues: u25 (copy), u26 (copy), u28 (ref), os_clock_ret (ref), SaveProfileAsync (copy)
    if p153.view_mode == true then
        error((`[{script.Name}]: Can't save profile in view mode; Should you be calling :SetAsync() instead?`));
    end;

    if p153:IsActive() == false then
        warn(`[{script.Name}]: Attempted saving an inactive profile (STORE:{p153.ProfileStore.Name}; KEY:{p153.Key});` .. " Traceback:\n" .. debug.traceback());

        return;
    end;

    u25[p153.session_token] = nil;
    local table_find_ret = table.find(u26, p153);

    if table_find_ret ~= nil then
        table.remove(u26, table_find_ret);

        if table_find_ret < u28 then
            u28 = u28 - 1;
        end;

        if u26[u28] == nil then
            u28 = 1;
        end;
    end;

    u25[p153.session_token] = p153;
    table.insert(u26, u28, p153);

    if #u26 > 1 then
        u28 = u28 + 1;
    elseif #u26 == 1 then
        os_clock_ret = os.clock();
    end;

    task.spawn(SaveProfileAsync, p153);
end;

local u154 = {
    IsClosing = false,
    IsCriticalState = false,
    DataStoreState = "NotReady",
    OnError = u38,
    OnOverwrite = u39,
    OnCriticalToggle = table_freeze_ret.New()
};
u154.__index = u154;

function u154.SetConstant(p155, p156) -- Line: 1205
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref)
    if type(p156) ~= "number" then
        error((`[{script.Name}]: Invalid value type`));
    end;

    if p155 == "AUTO_SAVE_PERIOD" then
        u1 = p156;

        return;
    end;

    if p155 == "LOAD_REPEAT_PERIOD" then
        u2 = p156;

        return;
    end;

    if p155 == "FIRST_LOAD_REPEAT" then
        u3 = p156;

        return;
    end;

    if p155 == "SESSION_STEAL" then
        u4 = p156;

        return;
    end;

    if p155 == "ASSUME_DEAD" then
        u5 = p156;

        return;
    end;

    if p155 == "START_SESSION_TIMEOUT" then
        u6 = p156;

        return;
    end;

    if p155 == "CRITICAL_STATE_ERROR_COUNT" then
        u7 = p156;

        return;
    end;

    if p155 == "CRITICAL_STATE_ERROR_EXPIRE" then
        u8 = p156;

        return;
    end;

    if p155 == "CRITICAL_STATE_EXPIRE" then
        u9 = p156;

        return;
    end;

    if p155 == "MAX_MESSAGE_QUEUE" then
        u10 = p156;

        return;
    end;

    error((`[{script.Name}]: Invalid constant name was provided`));
end;

function u154.Test() -- Line: 1237
    -- upvalues: u25 (copy), u26 (copy), u30 (ref), u31 (ref), u35 (copy), u36 (copy), u40 (copy)
    return {
        ActiveSessionCheck = u25,
        AutoSaveList = u26,
        ActiveProfileLoadJobs = u30,
        ActiveProfileSaveJobs = u31,
        MockStore = u35,
        UserMockStore = u36,
        UpdateQueue = u40
    };
end;

function u154.New(u157, p158) -- Line: 1249
    -- upvalues: u37 (ref), u154 (copy), u34 (ref), DataStoreService (copy)
    local v159 = p158 or {};

    if type(u157) == "string" then
        if string.len(u157) == 0 then
            error((`[{script.Name}]: store_name cannot be an empty string`));
        elseif string.len(u157) > 50 then
            error((`[{script.Name}]: store_name is too long`));
        end;
    else
        error((`[{script.Name}]: Invalid or missing "store_name"`));
    end;

    if type(v159) ~= "table" then
        error((`[{script.Name}]: Invalid template argument`));
    end;

    local u160 = nil;
    u160 = {
        data_store = nil,
        is_ready = true,
        Mock = {
            Name = u157,

            StartSessionAsync = function(p161, p162) -- Line: 1272, Name: StartSessionAsync
                -- upvalues: u37 (ref), u160 (ref)
                u37 = true;

                return u160:StartSessionAsync(p162);
            end,

            MessageAsync = function(p163, p164, p165) -- Line: 1276, Name: MessageAsync
                -- upvalues: u37 (ref), u160 (ref)
                u37 = true;

                return u160:MessageAsync(p164, p165);
            end,

            GetAsync = function(p166, p167, p168) -- Line: 1280, Name: GetAsync
                -- upvalues: u37 (ref), u160 (ref)
                u37 = true;

                return u160:GetAsync(p167, p168);
            end,

            VersionQuery = function(p169, p170, p171, p172, p173) -- Line: 1284, Name: VersionQuery
                -- upvalues: u37 (ref), u160 (ref)
                u37 = true;

                return u160:VersionQuery(p170, p171, p172, p173);
            end,

            RemoveAsync = function(p174, p175) -- Line: 1288, Name: RemoveAsync
                -- upvalues: u37 (ref), u160 (ref)
                u37 = true;

                return u160:RemoveAsync(p175);
            end
        },
        Name = u157,
        template = v159,
        load_jobs = {},
        mock_load_jobs = {}
    };
    setmetatable(u160, u154);
    local DataStoreOptions = Instance.new("DataStoreOptions");
    DataStoreOptions:SetExperimentalFeatures({
        v2 = true
    });

    if u34 == "NotReady" then
        u160.is_ready = false;
        task.spawn(function() -- Line: 1314
            -- upvalues: u34 (ref), u160 (ref), DataStoreService (ref), u157 (copy), DataStoreOptions (copy)
            repeat
                task.wait();
            until u34 ~= "NotReady";

            if u34 == "Access" then
                u160.data_store = DataStoreService:GetDataStore(u157, nil, DataStoreOptions);
            end;

            u160.is_ready = true;
        end);
    elseif u34 == "Access" then
        u160.data_store = DataStoreService:GetDataStore(u157, nil, DataStoreOptions);
    end;

    return u160;
end;

function u154.StartSessionAsync(u176, p177, p178) -- Line: 1336
    -- upvalues: u37 (ref), u154 (copy), u34 (ref), u25 (copy), u30 (ref), u29 (ref), HttpService (copy), UpdateAsync (copy), game_PlaceId (copy), game_JobId (copy), u5 (ref), DeepCopyTable (copy), u128 (copy), u26 (copy), u28 (ref), os_clock_ret (ref), MessagingService (copy), SaveProfileAsync (copy), u4 (ref), u2 (ref), u3 (ref), u6 (ref)
    local v179 = u37;
    u37 = false;

    if type(p177) == "string" then
        if string.len(p177) == 0 then
            error((`[{script.Name}]: Invalid profile_key`));
        elseif string.len(p177) > 50 then
            error((`[{script.Name}]: profile_key is too long`));
        end;
    else
        error((`[{script.Name}]: profile_key must be a string`));
    end;

    if p178 ~= nil and type(p178) ~= "table" then
        error((`[{script.Name}]: Invalid params`));
    end;

    if u154.IsClosing == true then
        return nil;
    end;

    local u180 = p178 or {};

    while u176.is_ready == false do
        task.wait();
    end;

    local v181 = (v179 == true and "U_" or (u34 ~= "Access" and "M_" or "L_")) .. u176.Name .. "\0" .. p177;

    if u25[v181] ~= nil then
        error((`[{script.Name}]: Profile (STORE:{u176.Name}; KEY:{p177}) is already loaded in this session`));
    end;

    u30 = u30 + 1;
    local u182 = false;

    local function cancel_condition() -- Line: 1370
        -- upvalues: u182 (ref), u180 (ref)
        if u182 ~= false then
            return true;
        end;

        if u180.Cancel ~= nil then
            u182 = u180.Cancel() == true;
        end;

        return u182;
    end;

    local u183 = u180.Steal == true;
    local os_clock_ret2 = os.clock();
    local u184 = true;
    local v185 = 0;
    local v186 = 1;
    local u187 = false;

    while true do
        while true do
            if u154.IsClosing ~= false then
                u30 = u30 - 1;

                return nil;
            end;

            local v188;

            if u182 == false then
                if u180.Cancel ~= nil then
                    if u180.Cancel() == true then
                        u182 = true;
                    else
                        u182 = false;
                    end;
                end;

                v188 = u182;
            else
                v188 = true;
            end;

            if v188 ~= false then
                u30 = u30 - 1;

                return nil;
            end;

            u29 = u29 + 1;
            local v189 = u29;
            local v190 = v179 == true and u176.mock_load_jobs or u176.load_jobs;
            local v191 = v190[p177];
            local u192 = HttpService:GenerateGUID(false);
            local v193, v194;

            if v191 == nil then
                local v195 = { v189, nil };
                v190[p177] = v195;
                v195[2] = table.pack(UpdateAsync(u176, p177, {
                    ExistingProfileHandle = function(p196) -- Line: 1428, Name: ExistingProfileHandle
                        -- upvalues: u154 (ref), u182 (ref), u180 (ref), game_PlaceId (ref), game_JobId (ref), u192 (copy), u5 (ref), u187 (ref), u183 (copy), u184 (ref)
                        if u154.IsClosing ~= true then
                            local v197;

                            if u182 == false then
                                if u180.Cancel ~= nil then
                                    u182 = u180.Cancel() == true;
                                end;

                                v197 = u182;
                            else
                                v197 = true;
                            end;

                            if v197 ~= true then
                                local ActiveSession = p196.MetaData.ActiveSession;
                                local ForceLoadSession = p196.MetaData.ForceLoadSession;

                                if ActiveSession ~= nil then
                                    if type(ActiveSession) == "table" then
                                        local v198;

                                        if ActiveSession[1] == game_PlaceId then
                                            v198 = ActiveSession[2] == game_JobId;
                                        else
                                            v198 = false;
                                        end;

                                        if v198 == false then
                                            local LastUpdate = p196.MetaData.LastUpdate;

                                            if LastUpdate ~= nil and u5 < os.time() - LastUpdate then
                                                p196.MetaData.ActiveSession = { game_PlaceId, game_JobId, u192 };
                                                p196.MetaData.ForceLoadSession = nil;

                                                return;
                                            end;

                                            if u187 == true or u183 == true then
                                                local v199;

                                                if ForceLoadSession == nil then
                                                    v199 = true;
                                                else
                                                    local v200;

                                                    if ForceLoadSession[1] == game_PlaceId then
                                                        v200 = ForceLoadSession[2] == game_JobId;
                                                    else
                                                        v200 = false;
                                                    end;

                                                    v199 = not v200;
                                                end;

                                                if v199 == false or u183 == true then
                                                    p196.MetaData.ActiveSession = { game_PlaceId, game_JobId, u192 };
                                                    p196.MetaData.ForceLoadSession = nil;

                                                    return;
                                                end;
                                            elseif u184 == true then
                                                p196.MetaData.ForceLoadSession = { game_PlaceId, game_JobId };

                                                return;
                                            end;
                                        else
                                            p196.MetaData.ForceLoadSession = nil;
                                        end;
                                    end;

                                    return;
                                end;

                                p196.MetaData.ActiveSession = { game_PlaceId, game_JobId, u192 };
                                p196.MetaData.ForceLoadSession = nil;
                            end;
                        end;
                    end,

                    MissingProfileHandle = function(p201) -- Line: 1465, Name: MissingProfileHandle
                        -- upvalues: u154 (ref), u182 (ref), u180 (ref), DeepCopyTable (ref), u176 (copy), game_PlaceId (ref), game_JobId (ref), u192 (copy)
                        local v202;

                        if u154.IsClosing == true then
                            v202 = true;
                        else
                            local v203;

                            if u182 == false then
                                if u180.Cancel ~= nil then
                                    u182 = u180.Cancel() == true;
                                end;

                                v203 = u182;
                            else
                                v203 = true;
                            end;

                            v202 = v203 == true;
                        end;

                        p201.Data = DeepCopyTable(u176.template);
                        p201.MetaData = {
                            SessionLoadCount = 0,
                            ForceLoadSession = nil,
                            ProfileCreateTime = os.time(),
                            ActiveSession = v202 == false and { game_PlaceId, game_JobId, u192 } or nil,
                            MetaTags = {}
                        };
                    end,

                    EditProfile = function(p204) -- Line: 1479, Name: EditProfile
                        -- upvalues: u154 (ref), u182 (ref), u180 (ref), game_PlaceId (ref), game_JobId (ref)
                        if u154.IsClosing ~= true then
                            local v205;

                            if u182 == false then
                                if u180.Cancel ~= nil then
                                    u182 = u180.Cancel() == true;
                                end;

                                v205 = u182;
                            else
                                v205 = true;
                            end;

                            if v205 ~= true then
                                local ActiveSession = p204.MetaData.ActiveSession;

                                if ActiveSession ~= nil then
                                    local v206;

                                    if ActiveSession[1] == game_PlaceId then
                                        v206 = ActiveSession[2] == game_JobId;
                                    else
                                        v206 = false;
                                    end;

                                    if v206 == true then
                                        p204.MetaData.SessionLoadCount = p204.MetaData.SessionLoadCount + 1;
                                        p204.MetaData.LastUpdate = os.time();
                                    end;
                                end;
                            end;
                        end;
                    end
                }, v179));

                if v195[1] ~= v189 then
                    u30 = u30 - 1;

                    return nil;
                end;

                v193, v194 = table.unpack(v195[2]);
                v190[p177] = nil;
            else
                v191[1] = v189;

                while v191[2] == nil do
                    task.wait();
                end;

                if v191[1] ~= v189 then
                    u30 = u30 - 1;

                    return nil;
                end;

                v193, v194 = table.unpack(v191[2]);
                v190[p177] = nil;
            end;

            if v193 == nil or v194 == nil then
                break;
            end;

            local ActiveSession = v193.MetaData.ActiveSession;

            if type(ActiveSession) ~= "table" then
                u30 = u30 - 1;

                return nil;
            end;

            local v207;

            if ActiveSession[1] == game_PlaceId then
                v207 = ActiveSession[2] == game_JobId;
            else
                v207 = false;
            end;

            if v207 == true then
                local u208 = u128.New(v193, v194, u176, p177, v179, v181);
                local v209 = u208;
                u25[v209.session_token] = v209;
                table.insert(u26, u28, v209);

                if #u26 > 1 then
                    u28 = u28 + 1;
                elseif #u26 == 1 then
                    os_clock_ret = os.clock();
                end;

                if v179 ~= true and u34 == "Access" then
                    local u210 = 0;
                    u208.roblox_message_subscription = MessagingService:SubscribeAsync("PS_" .. u192, function(p211) -- Line: 1523
                        -- upvalues: u208 (ref), u210 (ref), SaveProfileAsync (ref)
                        if type(p211.Data) == "table" and (p211.Data.LoadCount == u208.SessionLoadCount and os.clock() - u210 > 6) then
                            u210 = os.clock();

                            if u208:IsActive() == true then
                                if p211.Data.EndSession == true then
                                    SaveProfileAsync(u208, true, false, "External");

                                    return;
                                end;

                                u208:Save();
                            end;
                        end;
                    end);
                end;

                if u154.IsClosing == true then
                    SaveProfileAsync(u208, true);
                    u208 = nil;
                else
                    local v212;

                    if u182 == false then
                        if u180.Cancel ~= nil then
                            if u180.Cancel() == true then
                                u182 = true;
                            else
                                u182 = false;
                            end;
                        end;

                        v212 = u182;
                    else
                        v212 = true;
                    end;

                    if v212 == true then
                        SaveProfileAsync(u208, true);
                        u208 = nil;
                    end;
                end;

                u30 = u30 - 1;

                return u208;
            end;

            if u154.IsClosing == true then
                u30 = u30 - 1;

                return nil;
            end;

            local v213;

            if u182 == false then
                if u180.Cancel ~= nil then
                    if u180.Cancel() == true then
                        u182 = true;
                    else
                        u182 = false;
                    end;
                end;

                v213 = u182;
            else
                v213 = true;
            end;

            if v213 == true then
                u30 = u30 - 1;

                return nil;
            end;

            local ForceLoadSession = v193.MetaData.ForceLoadSession;
            local v214;

            if ForceLoadSession == nil then
                v214 = true;
            else
                local v215;

                if ForceLoadSession[1] == game_PlaceId then
                    v215 = ForceLoadSession[2] == game_JobId;
                else
                    v215 = false;
                end;

                v214 = not v215;
            end;

            if v214 ~= false then
                u30 = u30 - 1;

                return nil;
            end;

            if u184 == false then
                v185 = v185 + 1;

                if math.ceil(u4 / u2) <= v185 then
                    u187 = true;
                end;
            end;

            if type(ActiveSession[3]) == "string" then
                MessagingService:PublishAsync("PS_" .. ActiveSession[3], {
                    EndSession = true,
                    LoadCount = v193.MetaData.SessionLoadCount or 0
                });
            end;

            local os_clock_ret3 = os.clock();
            local v216;

            if u184 == true then
                v216 = u3;
            else
                v216 = u2;
            end;

            repeat
                task.wait();
            until os_clock_ret3 + v216 <= os.clock() or u154.IsClosing == true;

            u184 = false;
        end;

        local v217;

        if u180.Cancel == nil then
            v217 = u6 <= os.clock() - os_clock_ret2;
        else
            v217 = false;
        end;

        if v217 == true or u154.IsClosing == true then
            break;
        end;

        local v218;

        if u182 == false then
            if u180.Cancel ~= nil then
                if u180.Cancel() == true then
                    u182 = true;
                else
                    u182 = false;
                end;
            end;

            v218 = u182;
        else
            v218 = true;
        end;

        if v218 == true then
            break;
        end;

        task.wait(v186);
        v186 = math.min(20, v186 * 2);
    end;

    u30 = u30 - 1;

    return nil;
end;

function u154.MessageAsync(p219, p220, u221) -- Line: 1622
    -- upvalues: u37 (ref), u154 (copy), UpdateAsync (copy), u10 (ref), u34 (ref), u25 (copy), MessagingService (copy)
    local v222 = u37;
    u37 = false;

    if type(p220) == "string" then
        if string.len(p220) == 0 then
            error((`[{script.Name}]: Invalid profile_key`));
        elseif string.len(p220) > 50 then
            error((`[{script.Name}]: profile_key is too long`));
        end;
    else
        error((`[{script.Name}]: profile_key must be a string`));
    end;

    if type(u221) ~= "table" then
        error((`[{script.Name}]: message must be a table`));
    end;

    if u154.IsClosing == true then
        return false;
    end;

    while p219.is_ready == false do
        task.wait();
    end;

    local v223 = 1;

    while u154.IsClosing == false do
        local v226 = UpdateAsync(p219, p220, {
            ExistingProfileHandle = nil,
            MissingProfileHandle = nil,

            EditProfile = function(p224) -- Line: 1656, Name: EditProfile
                -- upvalues: u221 (copy), u10 (ref)
                local GlobalUpdates = p224.GlobalUpdates;
                local v225 = GlobalUpdates[2];
                GlobalUpdates[1] = GlobalUpdates[1] + 1;
                table.insert(v225, { GlobalUpdates[1], u221 });

                while u10 < #v225 do
                    table.remove(v225, 1);
                end;
            end
        }, v222);

        if v226 ~= nil then
            local v227 = u25[(v222 == true and "U_" or (u34 ~= "Access" and "M_" or "L_")) .. p219.Name .. "\0" .. p220];

            if v227 == nil then
                local v228 = v226.MetaData or {};
                local ActiveSession = v228.ActiveSession;
                local v229 = v228.SessionLoadCount or 0;

                if type(ActiveSession) == "table" and type(ActiveSession[3]) == "string" then
                    MessagingService:PublishAsync("PS_" .. ActiveSession[3], {
                        LoadCount = v229
                    });
                end;
            else
                v227:Save();
            end;

            return true;
        end;

        task.wait(v223);
        v223 = math.min(20, v223 * 2);
    end;

    return false;
end;

function u154.GetAsync(u230, p231, p232) -- Line: 1720
    -- upvalues: u37 (ref), u154 (copy), u34 (ref), UpdateAsync (copy), DeepCopyTable (copy), u128 (copy)
    local v233 = u37;
    u37 = false;

    if type(p231) == "string" then
        if string.len(p231) == 0 then
            error((`[{script.Name}]: Invalid profile_key`));
        elseif string.len(p231) > 50 then
            error((`[{script.Name}]: profile_key is too long`));
        end;
    else
        error((`[{script.Name}]: profile_key must be a string`));
    end;

    if u154.IsClosing == true then
        return nil;
    end;

    while u230.is_ready == false do
        task.wait();
    end;

    if p232 ~= nil and (v233 or u34 ~= "Access") then
        return nil;
    end;

    local v234 = 1;

    while u154.IsClosing == false do
        local v236, v237 = UpdateAsync(u230, p231, {
            ExistingProfileHandle = nil,
            EditProfile = nil,

            MissingProfileHandle = function(p235) -- Line: 1753, Name: MissingProfileHandle
                -- upvalues: DeepCopyTable (ref), u230 (copy)
                p235.Data = DeepCopyTable(u230.template);
                p235.MetaData = {
                    SessionLoadCount = 0,
                    ActiveSession = nil,
                    ForceLoadSession = nil,
                    ProfileCreateTime = os.time(),
                    MetaTags = {}
                };
            end
        }, v233, true, p232);

        if v236 ~= nil then
            if v237 == nil then
                return nil;
            end;

            local v238 = u128.New(v236, v237, u230, p231, v233);
            v238.view_mode = true;

            return v238;
        end;

        task.wait(v234);
        v234 = math.min(20, v234 * 2);
    end;

    return nil;
end;

function u154.RemoveAsync(u239, u240) -- Line: 1798
    -- upvalues: u37 (ref), u154 (copy), WaitInUpdateQueue (copy), u34 (ref), u36 (copy), u35 (copy)
    local v241 = u37;
    u37 = false;

    if type(u240) ~= "string" or string.len(u240) == 0 then
        error((`[{script.Name}]: Invalid profile_key`));
    end;

    if u154.IsClosing == true then
        return false;
    end;

    while u239.is_ready == false do
        task.wait();
    end;

    local v242 = WaitInUpdateQueue((v241 == true and "U_" or (u34 ~= "Access" and "M_" or "L_")) .. u239.Name .. "\0" .. u240);
    local v243;

    if v241 == true then
        local v244 = u36[u239.Name];

        if v244 ~= nil then
            v244[u240] = nil;

            if next(v244) == nil then
                u36[u239.Name] = nil;
            end;
        end;

        task.wait();
        v243 = true;
    elseif u34 == "Access" then
        v243 = pcall(function() -- Line: 1846
            -- upvalues: u239 (copy), u240 (copy)
            u239.data_store:RemoveAsync(u240);
        end);
    else
        local v245 = u35[u239.Name];

        if v245 ~= nil then
            v245[u240] = nil;

            if next(v245) == nil then
                u35[u239.Name] = nil;
            end;
        end;

        task.wait();
        v243 = true;
    end;

    v242();

    return v243;
end;

local u246 = {};
u246.__index = u246;

function u246.New(p247, p248, p249, p250, p251, p252) -- Line: 1861
    -- upvalues: u246 (copy)
    local v253 = {
        query_pages = nil,
        query_index = 0,
        query_failure = false,
        is_query_yielded = false,
        profile_store = p247,
        profile_key = p248,
        sort_direction = p249,
        min_date = p250,
        max_date = p251,
        query_queue = {},
        is_mock = p252
    };
    setmetatable(v253, u246);

    return v253;
end;

function MoveVersionQueryQueue(p254)
    while #p254.query_queue > 0 do
        local table_remove_ret = table.remove(p254.query_queue, 1);
        task.spawn(table_remove_ret);

        if p254.is_query_yielded == true then
            break;
        end;
    end;
end;

local u255 = false;
local u256 = false;

function u246.NextAsync(u257) -- Line: 1902
    -- upvalues: u255 (ref), u154 (copy), u34 (ref), u33 (copy), u256 (ref)
    local v258 = u255 == true;
    u255 = false;

    while u257.profile_store.is_ready == false do
        task.wait();
    end;

    if u154.IsClosing == true then
        return nil;
    end;

    if u257.is_mock == true or u34 ~= "Access" then
        if u33 == true and u256 == false then
            u256 = true;
            warn((`[{script.Name}]: :VersionQuery() is not supported in mock mode!`));
        end;

        return nil;
    end;

    local u259 = nil;
    local u260 = false;

    local function query_job() -- Line: 1924
        -- upvalues: u257 (copy), u260 (ref), u255 (ref), u259 (ref)
        if u257.query_failure == true then
            u260 = true;

            return;
        end;

        if u257.query_pages == nil then
            u257.is_query_yielded = true;
            task.spawn(function() -- Line: 1937
                -- upvalues: u255 (ref), u259 (ref), u257 (ref), u260 (ref)
                u255 = true;
                u259 = u257:NextAsync();
                u260 = true;
            end);
            local success, result = pcall(function() -- Line: 1943
                -- upvalues: u257 (ref)
                u257.query_pages = u257.profile_store.data_store:ListVersionsAsync(u257.profile_key, u257.sort_direction, u257.min_date, u257.max_date);
                u257.query_index = 0;
            end);

            if success == false or u257.query_pages == nil then
                warn((`[{script.Name}]: Version query fail - {tostring(result)}`));
                u257.query_failure = true;
            end;

            u257.is_query_yielded = false;
            MoveVersionQueryQueue(u257);

            return;
        end;

        local v261 = u257.query_pages:GetCurrentPage()[u257.query_index + 1];

        if u257.query_pages.IsFinished == true and v261 == nil then
            u260 = true;

            return;
        end;

        if v261 ~= nil then
            local v262 = u257;
            v262.query_index = v262.query_index + 1;
            u259 = u257.profile_store:GetAsync(u257.profile_key, v261.Version);
            u260 = true;

            return;
        end;

        u257.is_query_yielded = true;
        task.spawn(function() -- Line: 1981
            -- upvalues: u255 (ref), u259 (ref), u257 (ref), u260 (ref)
            u255 = true;
            u259 = u257:NextAsync();
            u260 = true;
        end);
        local success, _ = pcall(function() -- Line: 1987
            -- upvalues: u257 (ref)
            u257.query_pages:AdvanceToNextPageAsync();
            u257.query_index = 0;
        end);

        if success == false or #u257.query_pages:GetCurrentPage() == 0 then
            u257.query_failure = true;
        end;

        u257.is_query_yielded = false;
        MoveVersionQueryQueue(u257);
    end;

    if u257.is_query_yielded == false then
        query_job();
    elseif v258 == true then
        table.insert(u257.query_queue, 1, query_job);
    else
        table.insert(u257.query_queue, query_job);
    end;

    while u260 == false do
        task.wait();
    end;

    return u259;
end;

function u154.VersionQuery(p263, p264, p265, p266, p267) -- Line: 2029
    -- upvalues: u37 (ref), u246 (copy)
    local v268 = u37;
    u37 = false;

    if type(p264) ~= "string" or string.len(p264) == 0 then
        error((`[{script.Name}]: Invalid profile_key`));
    end;

    if p265 ~= nil and (typeof(p265) ~= "EnumItem" or p265.EnumType ~= Enum.SortDirection) then
        error((`[{script.Name}]: Invalid sort_direction ({tostring(p265)})`));
    end;

    if p266 ~= nil and (typeof(p266) ~= "DateTime" and typeof(p266) ~= "number") then
        error((`[{script.Name}]: Invalid min_date ({tostring(p266)})`));
    end;

    if p267 ~= nil and (typeof(p267) ~= "DateTime" and typeof(p267) ~= "number") then
        error((`[{script.Name}]: Invalid max_date ({tostring(p267)})`));
    end;

    if typeof(p266) == "DateTime" then
        p266 = p266.UnixTimestampMillis or p266;
    end;

    if typeof(p267) == "DateTime" then
        p267 = p267.UnixTimestampMillis or p267;
    end;

    return u246.New(p263, p264, p265, p266, p267, v268);
end;

if u33 == true then
    task.spawn(function() -- Line: 2063
        -- upvalues: DataStoreService (copy), u34 (ref), u154 (copy)
        local success, result = pcall(function() -- Line: 2067
            -- upvalues: DataStoreService (ref)
            DataStoreService:GetDataStore("____PS"):SetAsync("____PS", os.time());
        end);
        local v269;

        if success == false then
            v269 = string.find(result, "ConnectFail", 1, true) ~= nil;
        else
            v269 = false;
        end;

        if v269 == true then
            warn((`[{script.Name}]: No internet access - check your network connection`));
        end;

        local v270;

        if success == false and (string.find(result, "403", 1, true) ~= nil or (string.find(result, "must publish", 1, true) ~= nil or v269 == true)) then
            v270 = v269 == true and "NoInternet" or "NoAccess";
            print((`[{script.Name}]: Roblox API services unavailable - data will not be saved`));
        else
            print((`[{script.Name}]: Roblox API services available - data will be saved`));
            v270 = "Access";
        end;

        u34 = v270;
        u154.DataStoreState = v270;
    end);
else
    u34 = "Access";
    u154.DataStoreState = "Access";
end;

RunService.Heartbeat:Connect(function() -- Line: 2104
    -- upvalues: u26 (copy), u1 (ref), os_clock_ret (ref), u28 (ref), SaveProfileAsync (copy), u154 (copy), u27 (copy), u7 (ref), u32 (ref), u9 (ref), u8 (ref)
    local v271 = #u26;

    if v271 > 0 then
        local v272 = u1 / v271;
        local os_clock_ret2 = os.clock();

        while v272 < os_clock_ret2 - os_clock_ret do
            os_clock_ret = os_clock_ret + v272;
            local v273 = u26[u28];

            if os_clock_ret2 - v273.load_timestamp < u1 / 2 then
                v273 = nil;

                for i = 1, v271 - 1 do
                    u28 = u28 + 1;

                    if v271 < u28 then
                        u28 = 1;
                    end;

                    v273 = u26[u28];

                    if os_clock_ret2 - v273.load_timestamp >= u1 / 2 then
                        break;
                    end;

                    local _ = i;
                    v273 = nil;
                end;
            end;

            u28 = u28 + 1;

            if v271 < u28 then
                u28 = 1;
            end;

            if v273 ~= nil then
                task.spawn(SaveProfileAsync, v273);
            end;
        end;
    end;

    if u154.IsCriticalState == false then
        if u7 <= #u27 then
            u154.IsCriticalState = true;
            u154.OnCriticalToggle:Fire(true);
            u32 = os.clock();
            warn((`[{script.Name}]: Entered critical state`));
        end;
    elseif u7 <= #u27 then
        u32 = os.clock();
    elseif u9 < os.clock() - u32 then
        u154.IsCriticalState = false;
        u154.OnCriticalToggle:Fire(false);
        warn((`[{script.Name}]: Critical state ended`));
    end;

    while true do
        local v274 = u27[1];

        if v274 == nil then
            break;
        end;

        if u8 >= os.clock() - v274 then
            return;
        end;

        table.remove(u27, 1);
    end;
end);
task.spawn(function() -- Line: 2180
    -- upvalues: u34 (ref), u154 (copy), u26 (copy), SaveProfileAsync (copy), u30 (ref), u31 (ref)
    while u34 == "NotReady" do
        task.wait();
    end;

    if u34 == "Access" then
        game:BindToClose(function() -- Line: 2197
            -- upvalues: u154 (ref), u26 (ref), SaveProfileAsync (ref), u30 (ref), u31 (ref)
            u154.IsClosing = true;
            local v275 = {};
            local u276 = 0;

            for i, v in ipairs(u26) do
                v275[i] = v;
            end;

            for _, v in ipairs(v275) do
                if v:IsActive() == true then
                    u276 = u276 + 1;
                    task.spawn(function() -- Line: 2214
                        -- upvalues: SaveProfileAsync (ref), v (copy), u276 (ref)
                        SaveProfileAsync(v, true, nil, "Shutdown");
                        u276 = u276 - 1;
                    end);
                end;
            end;

            while u276 > 0 or (u30 > 0 or u31 > 0) do
                task.wait();
            end;
        end);

        return;
    end;

    game:BindToClose(function() -- Line: 2188
        -- upvalues: u154 (ref)
        u154.IsClosing = true;
        task.wait();
    end);
end);

return u154;