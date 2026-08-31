--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Remote
  Path:     game.ReplicatedStorage.Packages._Index.aykut92_replica@0.1.7.replica.Shared.Remote
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = RunService:IsStudio();
local u2 = RunService:IsServer();
local u3 = {};
local u4 = nil;
local u5;

if u2 == true then
    u5 = ReplicatedStorage:FindFirstChild("RemoteEvents");

    if u5 == nil then
        u5 = Instance.new("Folder");
        u5.Name = "RemoteEvents";
        u5.Parent = ReplicatedStorage;
    elseif v1 == true then
        warn((`[{script.Name}]: ReplicatedStorage "RemoteEvents" container was already defined`));
    end;
else
    u5 = ReplicatedStorage:FindFirstChild("RemoteEvents");

    if u5 == nil then
        u4 = Instance.new("BindableEvent");
        task.spawn(function() -- Line: 50
            -- upvalues: u5 (ref), ReplicatedStorage (copy), u4 (ref)
            while task.wait() do
                u5 = ReplicatedStorage:FindFirstChild("RemoteEvents");

                if u5 ~= nil then
                    u4:Fire();

                    return;
                end;
            end;
        end);
    end;
end;

local u6 = {};
u6.__index = u6;

function u6.New(p7) -- Line: 71
    -- upvalues: u6 (copy)
    return setmetatable({
        is_disconnected = false,
        real_connection = nil,
        fn = p7
    }, u6);
end;

function u6.Disconnect(p8) -- Line: 79
    p8.is_disconnected = true;

    if p8.real_connection ~= nil then
        p8.real_connection:Disconnect();
    end;
end;

local u9 = {};
u9.__index = u9;

function u9.New(u10: string, p11: boolean) -- Line: 89
    -- upvalues: u2 (copy), u3 (copy), u5 (ref), u6 (copy), u9 (copy), u4 (ref)
    if type(u10) ~= "string" then
        error((`[{script.Name}]: name must be a string`));
    end;

    if u2 == true then
        if u3[u10] ~= nil then
            error((`[{script.Name}]: RemoteEvent {u10} was already defined`));
        end;

        u3[u10] = true;
        local Instance_new_ret = Instance.new(p11 == true and "UnreliableRemoteEvent" or "RemoteEvent");
        Instance_new_ret.Name = u10;
        Instance_new_ret.Parent = u5;

        return Instance_new_ret;
    end;

    local u12 = u5 and u5:FindFirstChild(u10);

    if u12 ~= nil then
        return u12;
    end;

    local u13 = {};
    local u17 = setmetatable({
        RemoteEvent = nil,
        OnClientEvent = {
            Connect = function(p14, p15) -- Line: 121, Name: Connect
                -- upvalues: u12 (ref), u6 (ref), u13 (ref)
                if u12 ~= nil then
                    return u12.OnClientEvent:Connect(p15);
                end;

                local v16 = u6.New(p15);
                table.insert(u13, v16);

                return v16;
            end
        },
        OnServerEvent = {
            Connect = function() -- Line: 134, Name: Connect
                error((`[{script.Name}]: Can't connect to "OnServerEvent" client-side`));
            end
        }
    }, u9);

    local function on_container_ready() -- Line: 141
        -- upvalues: u12 (ref), u5 (ref), u10 (copy), u13 (ref), u17 (copy)
        local os_clock_ret = os.clock();

        while true do
            u12 = u5:FindFirstChild(u10);

            if u12 ~= nil then
                break;
            end;

            if os_clock_ret ~= nil and os.clock() - os_clock_ret > 20 then
                warn((`[{script.Name}]: RemoteEvent "{u10}" hasn't been defined server-side`));
                os_clock_ret = nil;
            end;

            task.wait();
        end;

        for _, v in ipairs(u13) do
            if v.is_disconnected == false then
                v.real_connection = u12.OnClientEvent:Connect(v.fn);
            end;
        end;

        u17.RemoteEvent = u12;
        u13 = nil;
    end;

    if u5 == nil then
        local u18 = nil;
        u18 = u4.Event:Connect(function() -- Line: 173
            -- upvalues: u18 (ref), on_container_ready (copy)
            u18:Disconnect();
            on_container_ready();
        end);
    else
        task.spawn(on_container_ready);
    end;

    return u17;
end;

function u9.FireServer(p19, ...) -- Line: 185
    if p19.RemoteEvent ~= nil then
        p19.RemoteEvent:FireServer(...);
    end;
end;

function u9.FireClient(p20) -- Line: 191
    error((`[{script.Name}]: Can't use "FireClient" client-side`));
end;

function u9.FireAllClients(p21) -- Line: 195
    error((`[{script.Name}]: Can't use "FireAllClients" client-side`));
end;

return u9;