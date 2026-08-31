--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Internal
  Path:     game.ReplicatedStorage.Packages._Index.michael-48_iris@2.3.1.iris.Internal
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
require(script.Parent.Types);

return function(u1) -- Line: 5
    -- upvalues: HttpService (copy)
    local u2 = {
        _version = " 2.3.1 ",
        _started = false,
        _shutdown = false,
        _cycleTick = 0,
        _globalRefreshRequested = false,
        _localRefreshActive = false,
        _widgets = {},
        _stackIndex = 1,
        _rootInstance = nil
    };
    u2._rootWidget = {
        ID = "R",
        type = "Root",
        ZIndex = 0,
        ZOffset = 0,
        Instance = u2._rootInstance
    };
    u2._lastWidget = u2._rootWidget;
    u2._rootConfig = {};
    u2._config = u2._rootConfig;
    u2._IDStack = { "R" };
    u2._usedIDs = {};
    u2._pushedId = nil;
    u2._nextWidgetId = nil;
    u2._states = {};
    u2._postCycleCallbacks = {};
    u2._connectedFunctions = {};
    u2._connections = {};
    u2._initFunctions = {};
    u2._fullErrorTracebacks = game:GetService("RunService"):IsStudio();
    u2._cycleCoroutine = coroutine.create(function() -- Line: 71
        -- upvalues: u2 (copy)
        while u2._started do
            for _, v in u2._connectedFunctions do
                debug.profilebegin("Iris/Connection");
                local success, result = pcall(v);
                debug.profileend();

                if not success then
                    u2._stackIndex = 1;
                    coroutine.yield(false, result);
                end;
            end;

            coroutine.yield(true);
        end;
    end);
    local v3 = {};
    v3.__index = v3;

    function v3.get(p4) -- Line: 130
        return p4.value;
    end;

    function v3.set(p5, p6) -- Line: 140
        -- upvalues: u2 (copy)
        if p6 == p5.value then
            return p5.value;
        end;

        p5.value = p6;

        for _, v in p5.ConnectedWidgets do
            u2._widgets[v.type].UpdateState(v);
        end;

        for _, v in p5.ConnectedFunctions do
            v(p6);
        end;

        return p5.value;
    end;

    function v3.onChange(u7: table, p8: function) -- Line: 161
        local u9 = #u7.ConnectedFunctions + 1;
        u7.ConnectedFunctions[u9] = p8;

        return function() -- Line: 164
            -- upvalues: u7 (copy), u9 (copy)
            u7.ConnectedFunctions[u9] = nil;
        end;
    end;

    u2.StateClass = v3;

    function u2._cycle() -- Line: 183
        -- upvalues: u1 (copy), u2 (copy)
        if u1.Disabled then
            return;
        end;

        u2._rootWidget.lastCycleTick = u2._cycleTick;

        if u2._rootInstance == nil or u2._rootInstance.Parent == nil then
            u1.ForceRefresh();
        end;

        for _, v in u2._lastVDOM do
            if v.lastCycleTick ~= u2._cycleTick and v.lastCycleTick ~= -1 then
                u2._DiscardWidget(v);
            end;
        end;

        setmetatable(u2._lastVDOM, {
            __mode = "kv"
        });
        u2._lastVDOM = u2._VDOM;
        u2._VDOM = u2._generateEmptyVDOM();
        task.spawn(function() -- Line: 209
            -- upvalues: u2 (ref)
            for _, v in u2._postCycleCallbacks do
                v();
            end;
        end);

        if u2._globalRefreshRequested then
            u2._generateSelectionImageObject();
            u2._globalRefreshRequested = false;

            for _, v in u2._lastVDOM do
                u2._DiscardWidget(v);
            end;

            u2._generateRootInstance();
            u2._lastVDOM = u2._generateEmptyVDOM();
        end;

        local v10 = u2;
        v10._cycleTick = v10._cycleTick + 1;
        table.clear(u2._usedIDs);

        if (u2.parentInstance:IsA("GuiBase2d") or u2.parentInstance:IsA("CoreGui") or (u2.parentInstance:IsA("PluginGui") or u2.parentInstance:IsA("PlayerGui"))) == false then
            error("Iris Parent Instance cant contain GUI");
        end;

        if u2._fullErrorTracebacks then
            for _, v in u2._connectedFunctions do
                v();
            end;
        else
            local coroutine_status_ret = coroutine.status(u2._cycleCoroutine);

            if coroutine_status_ret == "suspended" then
                local _, v11, v12 = coroutine.resume(u2._cycleCoroutine);

                if v11 == false then
                    error(v12, 0);
                end;
            elseif coroutine_status_ret == "running" then
                error("Iris cycleCoroutine took to long to yield. Connected functions should not yield.");
            else
                error("unrecoverable state");
            end;
        end;

        if u2._stackIndex ~= 1 then
            u2._stackIndex = 1;
            error("Callback has too few calls to Iris.End()", 0);
        end;
    end;

    function u2._NoOp() -- Line: 286
    end;

    function u2.WidgetConstructor(p13: string, p14: any) -- Line: 300
        -- upvalues: u2 (copy), u1 (copy)
        local v15 = {
            All = {
                Required = { "Generate", "Discard", "Update", "Args", "Events", "hasChildren", "hasState" },
                Optional = {}
            },
            IfState = {
                Required = { "GenerateState", "UpdateState" },
                Optional = {}
            },
            IfChildren = {
                Required = { "ChildAdded" },
                Optional = { "ChildDiscarded" }
            }
        };
        local v16 = {};

        for _, v in v15.All.Required do
            local v17 = p14[v] ~= nil;
            local v18 = `field {v} is missing from widget {p13}, it is required for all widgets`;
            assert(v17, v18);
            v16[v] = p14[v];
        end;

        for _, v in v15.All.Optional do
            if p14[v] == nil then
                v16[v] = u2._NoOp;
            else
                v16[v] = p14[v];
            end;
        end;

        if p14.hasState then
            for _, v in v15.IfState.Required do
                local v19 = p14[v] ~= nil;
                local v20 = `field {v} is missing from widget {p13}, it is required for all widgets with state`;
                assert(v19, v20);
                v16[v] = p14[v];
            end;

            for _, v in v15.IfState.Optional do
                if p14[v] == nil then
                    v16[v] = u2._NoOp;
                else
                    v16[v] = p14[v];
                end;
            end;
        end;

        if p14.hasChildren then
            for _, v in v15.IfChildren.Required do
                local v21 = p14[v] ~= nil;
                local v22 = `field {v} is missing from widget {p13}, it is required for all widgets with children`;
                assert(v21, v22);
                v16[v] = p14[v];
            end;

            for _, v in v15.IfChildren.Optional do
                if p14[v] == nil then
                    v16[v] = u2._NoOp;
                else
                    v16[v] = p14[v];
                end;
            end;
        end;

        u2._widgets[p13] = v16;
        u1.Args[p13] = v16.Args;
        local v23 = {};

        for i, v in v16.Args do
            v23[v] = i;
        end;

        v16.ArgNames = v23;

        for i, _ in v16.Events do
            if u1.Events[i] == nil then
                u1.Events[i] = function() -- Line: 391
                    -- upvalues: u2 (ref), i (copy)
                    return u2._EventCall(u2._lastWidget, i);
                end;
            end;
        end;
    end;

    function u2._Insert(p24: string, p25: any, p26: any) -- Line: 409
        -- upvalues: u2 (copy)
        local v27 = u2._getID(3);
        local v28 = u2._widgets[p24];

        if u2._VDOM[v27] then
            return u2._ContinueWidget(v27, p24);
        end;

        local v29 = {};

        if p25 ~= nil then
            for i, v in type(p25) ~= "table" and { p25 } or p25 do
                v29[v28.ArgNames[i]] = v;
            end;
        end;

        table.freeze(v29);
        local v30 = u2._lastVDOM[v27];

        if v30 and (p24 == v30.type and u2._localRefreshActive) then
            u2._DiscardWidget(v30);
            v30 = nil;
        end;

        if v30 == nil then
            v30 = u2._GenNewWidget(p24, v29, p26, v27);
        end;

        local parentWidget = v30.parentWidget;

        if v30.type ~= "Window" and v30.type ~= "Tooltip" then
            if v30.ZIndex ~= parentWidget.ZOffset then
                parentWidget.ZUpdate = true;
            end;

            if parentWidget.ZUpdate then
                v30.ZIndex = parentWidget.ZOffset;

                if v30.Instance then
                    v30.Instance.ZIndex = v30.ZIndex;
                    v30.Instance.LayoutOrder = v30.ZIndex;
                end;
            end;
        end;

        if u2._deepCompare(v30.providedArguments, v29) == false then
            v30.arguments = u2._deepCopy(v29);
            v30.providedArguments = v29;
            v28.Update(v30);
        end;

        v30.lastCycleTick = u2._cycleTick;
        parentWidget.ZOffset = parentWidget.ZOffset + 1;

        if v28.hasChildren then
            v30.ZOffset = 0;
            v30.ZUpdate = false;
            local v31 = u2;
            v31._stackIndex = v31._stackIndex + 1;
            u2._IDStack[u2._stackIndex] = v30.ID;
        end;

        u2._VDOM[v27] = v30;
        u2._lastWidget = v30;

        return v30;
    end;

    function u2._GenNewWidget(p32: string, p33: any, p34: any, p35: any) -- Line: 502
        -- upvalues: u2 (copy), HttpService (ref)
        local v36 = u2._VDOM[u2._IDStack[u2._stackIndex]];
        local v37 = u2._widgets[p32];
        local u38 = {};
        setmetatable(u38, u38);
        u38.ID = p35;
        u38.type = p32;
        u38.parentWidget = v36;
        u38.trackedEvents = {};
        u38.UID = HttpService:GenerateGUID(false):sub(0, 8);
        u38.ZIndex = v36.ZOffset;
        u38.Instance = v37.Generate(u38);
        local parentWidget = u38.parentWidget;

        if u2._config.Parent then
            u38.Instance.Parent = u2._config.Parent;
        else
            u38.Instance.Parent = u2._widgets[parentWidget.type].ChildAdded(parentWidget, u38);
        end;

        u38.providedArguments = p33;
        u38.arguments = u2._deepCopy(p33);
        v37.Update(u38);
        local v39;

        if v37.hasState then
            if p34 then
                for i, v in p34 do
                    if type(v) ~= "table" or getmetatable(v) ~= u2.StateClass then
                        p34[i] = u2._widgetState(u38, i, v);
                    end;
                end;

                u38.state = p34;

                for _, v in p34 do
                    v.ConnectedWidgets[u38.ID] = u38;
                end;
            else
                u38.state = {};
            end;

            v37.GenerateState(u38);
            v37.UpdateState(u38);
            u38.stateMT = {};
            setmetatable(u38.state, u38.stateMT);
            u38.__index = u38.state;
            v39 = u38.stateMT;
        else
            v39 = u38;
        end;

        function v39.__index(p40: any, u41: string) -- Line: 566
            -- upvalues: u2 (ref), u38 (copy)
            return function() -- Line: 567
                -- upvalues: u2 (ref), u38 (ref), u41 (copy)
                return u2._EventCall(u38, u41);
            end;
        end;

        return u38;
    end;

    function u2._ContinueWidget(p42: any, p43: string) -- Line: 585
        -- upvalues: u2 (copy)
        local v44 = u2._VDOM[p42];

        if u2._widgets[p43].hasChildren then
            local v45 = u2;
            v45._stackIndex = v45._stackIndex + 1;
            u2._IDStack[u2._stackIndex] = v44.ID;
        end;

        u2._lastWidget = v44;

        return v44;
    end;

    function u2._DiscardWidget(p46) -- Line: 608
        -- upvalues: u2 (copy)
        local parentWidget = p46.parentWidget;

        if parentWidget then
            u2._widgets[parentWidget.type].ChildDiscarded(parentWidget, p46);
        end;

        u2._widgets[p46.type].Discard(p46);
        p46.lastCycleTick = -1;
    end;

    function u2._widgetState(p47: any, p48: string, p49: any) -- Line: 633
        -- upvalues: u2 (copy)
        local v50 = p47.ID .. p48;

        if u2._states[v50] then
            u2._states[v50].ConnectedWidgets[p47.ID] = p47;

            return u2._states[v50];
        end;

        u2._states[v50] = {
            value = p49,
            ConnectedWidgets = {
                [p47.ID] = p47
            },
            ConnectedFunctions = {}
        };
        setmetatable(u2._states[v50], u2.StateClass);

        return u2._states[v50];
    end;

    function u2._EventCall(p51: any, p52: string) -- Line: 659
        -- upvalues: u2 (copy)
        local v53 = u2._widgets[p51.type].Events[p52];
        local v54 = `widget {p51.type} has no event of name {p52}`;
        assert(v53 ~= nil, v54);

        if p51.trackedEvents[p52] == nil then
            v53.Init(p51);
            p51.trackedEvents[p52] = true;
        end;

        return v53.Get(p51);
    end;

    function u2._GetParentWidget() -- Line: 678
        -- upvalues: u2 (copy)
        return u2._VDOM[u2._IDStack[u2._stackIndex]];
    end;

    function u2._generateEmptyVDOM() -- Line: 691
        -- upvalues: u2 (copy)
        return {
            R = u2._rootWidget
        };
    end;

    function u2._generateRootInstance() -- Line: 704
        -- upvalues: u2 (copy)
        u2._rootInstance = u2._widgets.Root.Generate(u2._widgets.Root);
        u2._rootInstance.Parent = u2.parentInstance;
        u2._rootWidget.Instance = u2._rootInstance;
    end;

    function u2._generateSelectionImageObject() -- Line: 718
        -- upvalues: u2 (copy)
        if u2.SelectionImageObject then
            u2.SelectionImageObject:Destroy();
        end;

        local Frame = Instance.new("Frame");
        Frame.Position = UDim2.fromOffset(-1, -1);
        Frame.Size = UDim2.new(1, 2, 1, 2);
        Frame.BackgroundColor3 = u2._config.SelectionImageObjectColor;
        Frame.BackgroundTransparency = u2._config.SelectionImageObjectTransparency;
        Frame.BorderSizePixel = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Thickness = 1;
        UIStroke.Color = u2._config.SelectionImageObjectBorderColor;
        UIStroke.Transparency = u2._config.SelectionImageObjectBorderTransparency;
        UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.Parent = Frame;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0, 2);
        UICorner.Parent = Frame;
        u2.SelectionImageObject = Frame;
    end;

    function u2._getID(p55: number) -- Line: 758
        -- upvalues: u2 (copy)
        if u2._nextWidgetId then
            local _nextWidgetId = u2._nextWidgetId;
            u2._nextWidgetId = nil;

            return _nextWidgetId;
        end;

        local v56 = 1 + (p55 or 1);
        local debug_info_ret = debug.info(v56, "l");
        local v57 = "";

        while debug_info_ret ~= -1 and debug_info_ret ~= nil do
            v57 = v57 .. "+" .. debug_info_ret;
            v56 = v56 + 1;
            debug_info_ret = debug.info(v56, "l");
        end;

        if u2._usedIDs[v57] then
            local _usedIDs = u2._usedIDs;
            _usedIDs[v57] = _usedIDs[v57] + 1;
        else
            u2._usedIDs[v57] = 1;
        end;

        local v58;

        if u2._pushedId then
            v58 = u2._pushedId;
        else
            v58 = u2._usedIDs[v57];
        end;

        return v57 .. ":" .. v58;
    end;

    function u2._deepCompare(p59: table, p60: table) -- Line: 796
        -- upvalues: u2 (copy)
        for i, v in p59 do
            local v61 = p60[i];

            if type(v) == "table" then
                if not v61 or type(v61) ~= "table" then
                    return false;
                end;

                if u2._deepCompare(v, v61) == false then
                    return false;
                end;
            elseif type(v) ~= type(v61) or v ~= v61 then
                return false;
            end;
        end;

        return true;
    end;

    function u2._deepCopy(p62: table) -- Line: 826
        -- upvalues: u2 (copy)
        local table_clone_ret = table.clone(p62);

        for i, v in pairs(p62) do
            if type(v) == "table" then
                table_clone_ret[i] = u2._deepCopy(v);
            end;
        end;

        return table_clone_ret;
    end;

    u2._lastVDOM = u2._generateEmptyVDOM();
    u2._VDOM = u2._generateEmptyVDOM();
    u1.Internal = u2;
    u1._config = u2._config;

    return u2;
end;