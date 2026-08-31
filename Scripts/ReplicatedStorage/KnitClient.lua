--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     KnitClient
  Path:     game.ReplicatedStorage.Packages._Index.sleitnick_knit@1.7.0.knit.KnitClient
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    ServicePromises = true,
    Middleware = nil,
    PerServiceMiddleware = {}
};
local u2 = nil;
local v3 = {
    Player = game:GetService("Players").LocalPlayer,
    Util = script.Parent.Parent
};
local Promise = require(v3.Util.Promise);
local ClientComm = require(v3.Util.Comm).ClientComm;
local u4 = {};
local u5 = {};
local u6 = nil;
local u7 = false;
local u8 = false;
local BindableEvent = Instance.new("BindableEvent");

local function DoesControllerExist(p9: string) -- Line: 127
    -- upvalues: u4 (copy)
    return u4[p9] ~= nil;
end;

local function GetServicesFolder() -- Line: 133
    -- upvalues: u6 (ref)
    if not u6 then
        u6 = script.Parent:WaitForChild("Services");
    end;

    return u6;
end;

local function GetMiddlewareForService(p10: string) -- Line: 141
    -- upvalues: u2 (ref)
    local v11 = u2.Middleware == nil and {} or u2.Middleware;
    local v12 = u2.PerServiceMiddleware[p10];

    if v12 == nil then
        return v11;
    end;

    return v12;
end;

local function BuildService(p13: string) -- Line: 148
    -- upvalues: u6 (ref), u2 (ref), ClientComm (copy), u5 (copy)
    if not u6 then
        u6 = script.Parent:WaitForChild("Services");
    end;

    local v14 = u2.Middleware == nil and {} or u2.Middleware;
    local v15 = u2.PerServiceMiddleware[p13];

    if v15 == nil then
        v15 = v14;
    end;

    local v16 = ClientComm.new(u6, u2.ServicePromises, p13):BuildObject(v15.Inbound, v15.Outbound);
    u5[p13] = v16;

    return v16;
end;

function v3.CreateController(p17: table) -- Line: 180
    -- upvalues: u4 (copy), u7 (ref)
    local v18 = type(p17) == "table";
    local v19 = `Controller must be a table; got {type(p17)}`;
    assert(v18, v19);
    local v20 = type(p17.Name) == "string";
    local v21 = `Controller.Name must be a string; got {type(p17.Name)}`;
    assert(v20, v21);
    assert(#p17.Name > 0, "Controller.Name must be a non-empty string");
    local v22 = u4[p17.Name] == nil;
    local v23 = `Controller {p17.Name} already exists`;
    assert(v22, v23);
    assert(not u7, "Controllers cannot be created after calling \"Knit.Start()\"");
    u4[p17.Name] = p17;

    return p17;
end;

function v3.AddControllers(p24: userdata) -- Line: 200
    -- upvalues: u7 (ref)
    assert(not u7, "Controllers cannot be added after calling \"Knit.Start()\"");
    local v25 = {};

    for _, child in p24:GetChildren() do
        if child:IsA("ModuleScript") then
            table.insert(v25, require(child));
        end;
    end;

    return v25;
end;

function v3.AddControllersDeep(p26: userdata) -- Line: 218
    -- upvalues: u7 (ref)
    assert(not u7, "Controllers cannot be added after calling \"Knit.Start()\"");
    local v27 = {};

    for _, descendant in p26:GetDescendants() do
        if descendant:IsA("ModuleScript") then
            table.insert(v27, require(descendant));
        end;
    end;

    return v27;
end;

function v3.GetService(p28: string) -- Line: 285
    -- upvalues: u5 (copy), u7 (ref), u6 (ref), u2 (ref), ClientComm (copy)
    local v29 = u5[p28];

    if v29 then
        return v29;
    end;

    assert(u7, "Cannot call GetService until Knit has been started");
    local v30 = type(p28) == "string";
    local v31 = `ServiceName must be a string; got {type(p28)}`;
    assert(v30, v31);

    if not u6 then
        u6 = script.Parent:WaitForChild("Services");
    end;

    local v32 = u2.Middleware == nil and {} or u2.Middleware;
    local v33 = u2.PerServiceMiddleware[p28];

    if v33 == nil then
        v33 = v32;
    end;

    local v34 = ClientComm.new(u6, u2.ServicePromises, p28):BuildObject(v33.Inbound, v33.Outbound);
    u5[p28] = v34;

    return v34;
end;

function v3.GetController(p35: string) -- Line: 301
    -- upvalues: u4 (copy), u7 (ref)
    local v36 = u4[p35];

    if v36 then
        return v36;
    end;

    assert(u7, "Cannot call GetController until Knit has been started");
    local v37 = type(p35) == "string";
    local v38 = `ControllerName must be a string; got {type(p35)}`;
    assert(v37, v38);
    error(`Could not find controller "{p35}". Check to verify a controller with this name exists.`, 2);
end;

function v3.GetControllers() -- Line: 315
    -- upvalues: u7 (ref), u4 (copy)
    assert(u7, "Cannot call GetControllers until Knit has been started");

    return u4;
end;

function v3.Start(p39: table?) -- Line: 338
    -- upvalues: u7 (ref), Promise (copy), u4 (copy), u2 (ref), u1 (copy), u8 (ref), BindableEvent (copy)
    if u7 then
        return Promise.reject("Knit already started");
    end;

    u7 = true;
    table.freeze(u4);

    if p39 == nil then
        u2 = u1;
    else
        local v40 = typeof(p39) == "table";
        local v41 = `KnitOptions should be a table or nil; got {typeof(p39)}`;
        assert(v40, v41);
        u2 = p39;

        for i, v in u1 do
            if u2[i] == nil then
                u2[i] = v;
            end;
        end;
    end;

    if type(u2.PerServiceMiddleware) ~= "table" then
        u2.PerServiceMiddleware = {};
    end;

    return Promise.new(function(p42) -- Line: 362
        -- upvalues: u4 (ref), Promise (ref)
        local v43 = {};

        for _, v in u4 do
            if type(v.KnitInit) == "function" then
                table.insert(v43, Promise.new(function(p44) -- Line: 370
                    -- upvalues: v (copy)
                    debug.setmemorycategory(v.Name);
                    v:KnitInit();
                    p44();
                end));
            end;
        end;

        p42(Promise.all(v43));
    end):andThen(function() -- Line: 380
        -- upvalues: u4 (ref), u8 (ref), BindableEvent (ref)
        for _, v in u4 do
            if type(v.KnitStart) == "function" then
                task.spawn(function() -- Line: 384
                    -- upvalues: v (copy)
                    debug.setmemorycategory(v.Name);
                    v:KnitStart();
                end);
            end;
        end;

        u8 = true;
        BindableEvent:Fire();
        task.defer(function() -- Line: 394
            -- upvalues: BindableEvent (ref)
            BindableEvent:Destroy();
        end);
    end);
end;

function v3.OnStart() -- Line: 412
    -- upvalues: u8 (ref), Promise (copy), BindableEvent (copy)
    if u8 then
        return Promise.resolve();
    end;

    return Promise.fromEvent(BindableEvent.Event);
end;

return v3;