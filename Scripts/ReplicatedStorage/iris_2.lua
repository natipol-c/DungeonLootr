--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     iris
  Path:     game.ReplicatedStorage.Packages._Index.michael-48_iris@2.3.1.iris
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

require(script.Types);
local u1 = {};
local u2 = require(script.Internal)(u1);
u1.Disabled = false;
u1.Args = {};
u1.Events = {};

function u1.Init(p3: userdata?, u4: any) -- Line: 70
    -- upvalues: u2 (copy), u1 (copy)
    assert(u2._started == false, "Iris.Init can only be called once.");
    assert(u2._shutdown == false, "Iris.Init cannot be called once shutdown.");

    if p3 == nil then
        p3 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
    end;

    if u4 == nil then
        u4 = game:GetService("RunService").Heartbeat;
    end;

    u2.parentInstance = p3;
    u2._started = true;
    u2._generateRootInstance();
    u2._generateSelectionImageObject();

    for _, v in u2._initFunctions do
        v();
    end;

    task.spawn(function() -- Line: 93
        -- upvalues: u4 (ref), u2 (ref)
        if typeof(u4) == "function" then
            while u2._started do
                u4();
                u2._cycle();
            end;
        elseif u4 ~= nil then
            u2._eventConnection = u4:Connect(function() -- Line: 100
                -- upvalues: u2 (ref)
                u2._cycle();
            end);
        end;
    end);

    return u1;
end;

function u1.Shutdown() -- Line: 114
    -- upvalues: u2 (copy)
    u2._started = false;
    u2._shutdown = true;

    if u2._eventConnection then
        u2._eventConnection:Disconnect();
    end;

    u2._eventConnection = nil;

    if u2._rootWidget then
        if u2._rootWidget.Instance then
            u2._widgets.Root.Discard(u2._rootWidget);
        end;

        u2._rootInstance = nil;
    end;

    if u2.SelectionImageObject then
        u2.SelectionImageObject:Destroy();
    end;

    for _, v in u2._connections do
        v:Disconnect();
    end;
end;

function u1.Connect(p5: table, p6: function) -- Line: 149
    -- upvalues: u2 (copy)
    if u2._started == false then
        warn("Iris:Connect() was called before calling Iris.Init(), the connected function will never run");
    end;

    local u7 = #u2._connectedFunctions + 1;
    u2._connectedFunctions[u7] = p6;

    return function() -- Line: 155
        -- upvalues: u2 (ref), u7 (copy)
        u2._connectedFunctions[u7] = nil;
    end;
end;

function u1.Append(p8: userdata) -- Line: 169
    -- upvalues: u2 (copy)
    local v9 = u2._GetParentWidget();
    local v10;

    if u2._config.Parent then
        v10 = u2._config.Parent;
    else
        v10 = u2._widgets[v9.type].ChildAdded(v9, {
            type = "userInstance"
        });
    end;

    p8.Parent = v10;
end;

function u1.End() -- Line: 206
    -- upvalues: u2 (copy)
    if u2._stackIndex == 1 then
        error("Callback has too many calls to Iris.End()", 2);
    end;

    u2._IDStack[u2._stackIndex] = nil;
    local v11 = u2;
    v11._stackIndex = v11._stackIndex - 1;
end;

function u1.ForceRefresh() -- Line: 230
    -- upvalues: u2 (copy)
    u2._globalRefreshRequested = true;
end;

function u1.UpdateGlobalConfig(p12: table) -- Line: 251
    -- upvalues: u2 (copy), u1 (copy)
    for i, v in p12 do
        u2._rootConfig[i] = v;
    end;

    u1.ForceRefresh();
end;

function u1.PushConfig(p13: table) -- Line: 275
    -- upvalues: u1 (copy), u2 (copy)
    local v14 = u1.State(-1);

    if v14.value == -1 then
        v14:set(p13);
    elseif u2._deepCompare(v14:get(), p13) == false then
        u2._localRefreshActive = true;
        v14:set(p13);
    end;

    u2._config = setmetatable(p13, {
        __index = u2._config
    });
end;

function u1.PopConfig() -- Line: 300
    -- upvalues: u2 (copy)
    u2._localRefreshActive = false;
    u2._config = getmetatable(u2._config).__index;
end;

u1.TemplateConfig = require(script.config);
u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark);
u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault);
u1.UpdateGlobalConfig(u1.TemplateConfig.utilityDefault);
u2._globalRefreshRequested = false;

function u1.PushId(p15) -- Line: 329
    -- upvalues: u2 (copy)
    local v16 = typeof(p15) == "string";
    assert(v16, "Iris expected Iris.PushId id to PushId to be a string.");
    u2._pushedId = tostring(p15);
end;

function u1.PopId() -- Line: 340
    -- upvalues: u2 (copy)
    u2._pushedId = nil;
end;

function u1.SetNextWidgetID(p17) -- Line: 365
    -- upvalues: u2 (copy)
    u2._nextWidgetId = p17;
end;

function u1.State(p18) -- Line: 404
    -- upvalues: u2 (copy)
    local v19 = u2._getID(2);

    if u2._states[v19] then
        return u2._states[v19];
    end;

    u2._states[v19] = {
        value = p18,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(u2._states[v19], u2.StateClass);

    return u2._states[v19];
end;

function u1.WeakState(p20) -- Line: 425
    -- upvalues: u2 (copy)
    local v21 = u2._getID(2);

    if u2._states[v21] then
        if next(u2._states[v21].ConnectedWidgets) ~= nil then
            return u2._states[v21];
        end;

        u2._states[v21] = nil;
    end;

    u2._states[v21] = {
        value = p20,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(u2._states[v21], u2.StateClass);

    return u2._states[v21];
end;

function u1.ComputedState(p22: any, u23: function) -- Line: 459
    -- upvalues: u2 (copy)
    local u24 = u2._getID(2);

    if u2._states[u24] then
        return u2._states[u24];
    end;

    u2._states[u24] = {
        value = u23(p22.value),
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    p22:onChange(function(p25) -- Line: 470
        -- upvalues: u2 (ref), u24 (copy), u23 (copy)
        u2._states[u24]:set(u23(p25));
    end);
    setmetatable(u2._states[u24], u2.StateClass);

    return u2._states[u24];
end;

u1.ShowDemoWindow = require(script.demoWindow)(u1);
require(script.widgets)(u2);
require(script.API)(u1);

return u1;