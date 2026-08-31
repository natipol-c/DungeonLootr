--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     widgets
  Path:     game.ReplicatedStorage.Packages._Index.michael-48_iris@2.3.1.iris.widgets
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
local u1 = {};

return function(u2) -- Line: 5
    -- upvalues: u1 (copy)
    u1.GuiService = game:GetService("GuiService");
    u1.RunService = game:GetService("RunService");
    u1.UserInputService = game:GetService("UserInputService");
    u1.ContextActionService = game:GetService("ContextActionService");
    u1.TextService = game:GetService("TextService");
    u1.ICONS = {
        RIGHT_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_right.png",
        DOWN_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_down.png",
        MULTIPLICATION_SIGN = "rbxasset://textures/AnimationEditor/icon_close.png",
        BOTTOM_RIGHT_CORNER = "rbxasset://textures/ui/InspectMenu/gr-item-selector-triangle.png",
        CHECK_MARK = "rbxasset://textures/AnimationEditor/icon_checkmark.png",
        ALPHA_BACKGROUND_TEXTURE = "rbxasset://textures/meshPartFallback.png",
        UNKNOWN_TEXTURE = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    };
    u1.IS_STUDIO = u1.RunService:IsStudio();

    function u1.getTime() -- Line: 23
        -- upvalues: u1 (ref)
        if u1.IS_STUDIO then
            return os.clock();
        end;

        return time();
    end;

    u1.GuiOffset = Vector2.zero;
    local v3;

    if u2._config.IgnoreGuiInset then
        v3 = Vector2.zero;
    else
        v3 = u1.GuiService:GetGuiInset();
    end;

    u1.MouseOffset = v3;
    local u5 = u1.GuiService:GetPropertyChangedSignal("TopbarInset"):Once(function() -- Line: 38
        -- upvalues: u1 (ref), u2 (copy)
        local v4;

        if u2._config.IgnoreGuiInset then
            v4 = Vector2.zero;
        else
            v4 = u1.GuiService:GetGuiInset();
        end;

        u1.MouseOffset = v4;
    end);
    task.delay(3, function() -- Line: 42
        -- upvalues: u5 (copy)
        u5:Disconnect();
    end);

    function u1.getMouseLocation() -- Line: 46
        -- upvalues: u1 (ref)
        return u1.UserInputService:GetMouseLocation() - u1.MouseOffset;
    end;

    function u1.isPosInsideRect(p6, p7, p8) -- Line: 50
        local v9;

        if p6.X > p7.X and (p6.X < p8.X and p6.Y > p7.Y) then
            v9 = p6.Y < p8.Y;
        else
            v9 = false;
        end;

        return v9;
    end;

    function u1.findBestWindowPosForPopup(p10, p11, p12, p13) -- Line: 54
        local v14;

        if p10.X + p11.X + 20 > p13.X then
            if p10.Y + p11.Y + 20 > p13.Y then
                v14 = p10 + Vector2.new(0, -(20 + p11.Y));
            else
                v14 = p10 + Vector2.new(0, 20);
            end;
        else
            v14 = p10 + Vector2.new(20, 0);
        end;

        local Vector2_new = Vector2.new;
        local v15 = math.min(v14.X + p11.X, p13.X) - p11.X;
        local math_max_ret = math.max(v15, p12.X);
        local v16 = math.min(v14.Y + p11.Y, p13.Y) - p11.Y;

        return Vector2_new(math_max_ret, (math.max(v16, p12.Y)));
    end;

    function u1.getScreenSizeForWindow(p17) -- Line: 74
        if p17.Instance:IsA("GuiBase2d") then
            return p17.Instance.AbsoluteSize;
        end;

        local Parent = p17.Instance.Parent;

        if Parent:IsA("GuiBase2d") then
            return Parent.AbsoluteSize;
        end;

        if Parent.Parent:IsA("GuiBase2d") then
            return Parent.AbsoluteSize;
        end;

        return workspace.CurrentCamera.ViewportSize;
    end;

    function u1.extend(p18, p19) -- Line: 91
        local table_clone_ret = table.clone(p18);

        for i, v in p19 do
            table_clone_ret[i] = v;
        end;

        return table_clone_ret;
    end;

    function u1.UIPadding(p20: userdata, p21) -- Line: 99
        local UIPadding = Instance.new("UIPadding");
        UIPadding.PaddingLeft = UDim.new(0, p21.X);
        UIPadding.PaddingRight = UDim.new(0, p21.X);
        UIPadding.PaddingTop = UDim.new(0, p21.Y);
        UIPadding.PaddingBottom = UDim.new(0, p21.Y);
        UIPadding.Parent = p20;

        return UIPadding;
    end;

    function u1.UIListLayout(p22: userdata, p23: any, p24) -- Line: 109
        local UIListLayout = Instance.new("UIListLayout");
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout.Padding = p24;
        UIListLayout.FillDirection = p23;
        UIListLayout.Parent = p22;

        return UIListLayout;
    end;

    function u1.UIStroke(p25: userdata, p26: number, p27, p28: number) -- Line: 118
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Thickness = p26;
        UIStroke.Color = p27;
        UIStroke.Transparency = p28;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
        UIStroke.Parent = p25;

        return UIStroke;
    end;

    function u1.UICorner(p29: userdata, p30: number?) -- Line: 129
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(p30 and 0 or 1, p30 or 0);
        UICorner.Parent = p29;

        return UICorner;
    end;

    function u1.UISizeConstraint(p31: userdata, p32, p33) -- Line: 136
        local UISizeConstraint = Instance.new("UISizeConstraint");
        UISizeConstraint.MinSize = p32 or UISizeConstraint.MinSize;
        UISizeConstraint.MaxSize = p33 or UISizeConstraint.MaxSize;
        UISizeConstraint.Parent = p31;

        return UISizeConstraint;
    end;

    function u1.UIReference(p34: userdata, p35: userdata, p36: string) -- Line: 144
        local ObjectValue = Instance.new("ObjectValue");
        ObjectValue.Name = p36;
        ObjectValue.Value = p35;
        ObjectValue.Parent = p34;

        return ObjectValue;
    end;

    local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
    GetTextBoundsParams.Font = u2._config.TextFont;
    GetTextBoundsParams.Size = u2._config.TextSize;
    GetTextBoundsParams.Width = (1 / 0);

    function u1.calculateTextSize(p37: string, p38: number?) -- Line: 159
        -- upvalues: GetTextBoundsParams (copy), u1 (ref)
        if p38 then
            GetTextBoundsParams.Width = p38;
        end;

        GetTextBoundsParams.Text = p37;
        local TextBoundsAsync = u1.TextService:GetTextBoundsAsync(GetTextBoundsParams);

        if p38 then
            GetTextBoundsParams.Width = (1 / 0);
        end;

        return TextBoundsAsync;
    end;

    function u1.applyTextStyle(p39) -- Line: 174
        -- upvalues: u2 (copy)
        p39.FontFace = u2._config.TextFont;
        p39.TextSize = u2._config.TextSize;
        p39.TextColor3 = u2._config.TextColor;
        p39.TextTransparency = u2._config.TextTransparency;
        p39.TextXAlignment = Enum.TextXAlignment.Left;
        p39.RichText = u2._config.RichText;
        p39.TextWrapped = u2._config.TextWrapped;
        p39.AutoLocalize = false;
    end;

    function u1.applyInteractionHighlights(p40: any, p41: userdata, u42: userdata, u43: table) -- Line: 186
        -- upvalues: u1 (ref), u2 (copy)
        local u44 = false;
        u1.applyMouseEnter(p40, p41, function() -- Line: 188
            -- upvalues: u42 (copy), u43 (copy), u44 (ref)
            u42.BackgroundColor3 = u43.ButtonHoveredColor;
            u42.BackgroundTransparency = u43.ButtonHoveredTransparency;
            u44 = false;
        end);
        u1.applyMouseLeave(p40, p41, function() -- Line: 195
            -- upvalues: u42 (copy), u43 (copy), u44 (ref)
            u42.BackgroundColor3 = u43.ButtonColor;
            u42.BackgroundTransparency = u43.ButtonTransparency;
            u44 = true;
        end);
        u1.applyInputBegan(p40, p41, function(p45: userdata) -- Line: 202
            -- upvalues: u42 (copy), u43 (copy)
            if p45.UserInputType ~= Enum.UserInputType.MouseButton1 and p45.UserInputType ~= Enum.UserInputType.Gamepad1 then
                return;
            end;

            u42.BackgroundColor3 = u43.ButtonActiveColor;
            u42.BackgroundTransparency = u43.ButtonActiveTransparency;
        end);
        u1.applyInputEnded(p40, p41, function(p46: userdata) -- Line: 210
            -- upvalues: u44 (ref), u42 (copy), u43 (copy)
            if p46.UserInputType ~= Enum.UserInputType.MouseButton1 and p46.UserInputType ~= Enum.UserInputType.Gamepad1 or u44 then
                return;
            end;

            if p46.UserInputType == Enum.UserInputType.MouseButton1 then
                u42.BackgroundColor3 = u43.ButtonHoveredColor;
                u42.BackgroundTransparency = u43.ButtonHoveredTransparency;
            end;

            if p46.UserInputType == Enum.UserInputType.Gamepad1 then
                u42.BackgroundColor3 = u43.ButtonColor;
                u42.BackgroundTransparency = u43.ButtonTransparency;
            end;
        end);
        p41.SelectionImageObject = u2.SelectionImageObject;
    end;

    function u1.applyInteractionHighlightsWithMultiHighlightee(p47: any, p48: userdata, u49: table) -- Line: 227
        -- upvalues: u1 (ref), u2 (copy)
        local u50 = false;
        u1.applyMouseEnter(p47, p48, function() -- Line: 229
            -- upvalues: u49 (copy), u50 (ref)
            for _, v in u49 do
                v[1].BackgroundColor3 = v[2].ButtonHoveredColor;
                v[1].BackgroundTransparency = v[2].ButtonHoveredTransparency;
                u50 = false;
            end;
        end);
        u1.applyMouseLeave(p47, p48, function() -- Line: 238
            -- upvalues: u49 (copy), u50 (ref)
            for _, v in u49 do
                v[1].BackgroundColor3 = v[2].ButtonColor;
                v[1].BackgroundTransparency = v[2].ButtonTransparency;
                u50 = true;
            end;
        end);
        u1.applyInputBegan(p47, p48, function(p51: userdata) -- Line: 247
            -- upvalues: u49 (copy)
            if p51.UserInputType ~= Enum.UserInputType.MouseButton1 and p51.UserInputType ~= Enum.UserInputType.Gamepad1 then
                return;
            end;

            for _, v in u49 do
                v[1].BackgroundColor3 = v[2].ButtonActiveColor;
                v[1].BackgroundTransparency = v[2].ButtonActiveTransparency;
            end;
        end);
        u1.applyInputEnded(p47, p48, function(p52: userdata) -- Line: 257
            -- upvalues: u50 (ref), u49 (copy)
            if p52.UserInputType ~= Enum.UserInputType.MouseButton1 and p52.UserInputType ~= Enum.UserInputType.Gamepad1 or u50 then
                return;
            end;

            for _, v in u49 do
                if p52.UserInputType == Enum.UserInputType.MouseButton1 then
                    v[1].BackgroundColor3 = v[2].ButtonHoveredColor;
                    v[1].BackgroundTransparency = v[2].ButtonHoveredTransparency;
                end;

                if p52.UserInputType == Enum.UserInputType.Gamepad1 then
                    v[1].BackgroundColor3 = v[2].ButtonColor;
                    v[1].BackgroundTransparency = v[2].ButtonTransparency;
                end;
            end;
        end);
        p48.SelectionImageObject = u2.SelectionImageObject;
    end;

    function u1.applyImageInteractionHighlights(p53: any, p54: userdata, u55: userdata, u56: table) -- Line: 276
        -- upvalues: u1 (ref), u2 (copy)
        local u57 = false;
        u1.applyMouseEnter(p53, p54, function() -- Line: 278
            -- upvalues: u55 (copy), u56 (copy), u57 (ref)
            u55.ImageColor3 = u56.ButtonHoveredColor;
            u55.ImageTransparency = u56.ButtonHoveredTransparency;
            u57 = false;
        end);
        u1.applyMouseLeave(p53, p54, function() -- Line: 285
            -- upvalues: u55 (copy), u56 (copy), u57 (ref)
            u55.ImageColor3 = u56.ButtonColor;
            u55.ImageTransparency = u56.ButtonTransparency;
            u57 = true;
        end);
        u1.applyInputBegan(p53, p54, function(p58: userdata) -- Line: 292
            -- upvalues: u55 (copy), u56 (copy)
            if p58.UserInputType ~= Enum.UserInputType.MouseButton1 and p58.UserInputType ~= Enum.UserInputType.Gamepad1 then
                return;
            end;

            u55.ImageColor3 = u56.ButtonActiveColor;
            u55.ImageTransparency = u56.ButtonActiveTransparency;
        end);
        u1.applyInputEnded(p53, p54, function(p59: userdata) -- Line: 300
            -- upvalues: u57 (ref), u55 (copy), u56 (copy)
            if p59.UserInputType ~= Enum.UserInputType.MouseButton1 and p59.UserInputType ~= Enum.UserInputType.Gamepad1 or u57 then
                return;
            end;

            if p59.UserInputType == Enum.UserInputType.MouseButton1 then
                u55.ImageColor3 = u56.ButtonHoveredColor;
                u55.ImageTransparency = u56.ButtonHoveredTransparency;
            end;

            if p59.UserInputType == Enum.UserInputType.Gamepad1 then
                u55.ImageColor3 = u56.ButtonColor;
                u55.ImageTransparency = u56.ButtonTransparency;
            end;
        end);
        p54.SelectionImageObject = u2.SelectionImageObject;
    end;

    function u1.applyTextInteractionHighlights(p60: any, p61: userdata, u62: any, u63: table) -- Line: 317
        -- upvalues: u1 (ref), u2 (copy)
        local u64 = false;
        u1.applyMouseEnter(p60, p61, function() -- Line: 319
            -- upvalues: u62 (copy), u63 (copy), u64 (ref)
            u62.TextColor3 = u63.ButtonHoveredColor;
            u62.TextTransparency = u63.ButtonHoveredTransparency;
            u64 = false;
        end);
        u1.applyMouseLeave(p60, p61, function() -- Line: 326
            -- upvalues: u62 (copy), u63 (copy), u64 (ref)
            u62.TextColor3 = u63.ButtonColor;
            u62.TextTransparency = u63.ButtonTransparency;
            u64 = true;
        end);
        u1.applyInputBegan(p60, p61, function(p65: userdata) -- Line: 333
            -- upvalues: u62 (copy), u63 (copy)
            if p65.UserInputType ~= Enum.UserInputType.MouseButton1 and p65.UserInputType ~= Enum.UserInputType.Gamepad1 then
                return;
            end;

            u62.TextColor3 = u63.ButtonActiveColor;
            u62.TextTransparency = u63.ButtonActiveTransparency;
        end);
        u1.applyInputEnded(p60, p61, function(p66: userdata) -- Line: 341
            -- upvalues: u64 (ref), u62 (copy), u63 (copy)
            if p66.UserInputType ~= Enum.UserInputType.MouseButton1 and p66.UserInputType ~= Enum.UserInputType.Gamepad1 or u64 then
                return;
            end;

            if p66.UserInputType == Enum.UserInputType.MouseButton1 then
                u62.TextColor3 = u63.ButtonHoveredColor;
                u62.TextTransparency = u63.ButtonHoveredTransparency;
            end;

            if p66.UserInputType == Enum.UserInputType.Gamepad1 then
                u62.TextColor3 = u63.ButtonColor;
                u62.TextTransparency = u63.ButtonTransparency;
            end;
        end);
        p61.SelectionImageObject = u2.SelectionImageObject;
    end;

    function u1.applyFrameStyle(p67: userdata, p68: boolean?, p69: boolean?) -- Line: 358
        -- upvalues: u2 (copy), u1 (ref)
        local FrameBorderSize = u2._config.FrameBorderSize;
        local FrameRounding = u2._config.FrameRounding;
        p67.BorderSizePixel = 0;

        if FrameBorderSize > 0 then
            u1.UIStroke(p67, FrameBorderSize, u2._config.BorderColor, u2._config.BorderTransparency);
        end;

        if FrameRounding > 0 and not p69 then
            u1.UICorner(p67, FrameRounding);
        end;

        if not p68 then
            u1.UIPadding(p67, u2._config.FramePadding);
        end;
    end;

    function u1.applyButtonClick(p70: any, p71: userdata, u72: function) -- Line: 376
        p71.MouseButton1Click:Connect(function() -- Line: 377
            -- upvalues: u72 (copy)
            u72();
        end);
    end;

    function u1.applyButtonDown(p73: any, p74: userdata, u75: function) -- Line: 382
        p74.MouseButton1Down:Connect(function(...) -- Line: 383
            -- upvalues: u75 (copy)
            u75(...);
        end);
    end;

    function u1.applyMouseEnter(p76: any, p77: userdata, u78: function) -- Line: 388
        p77.MouseEnter:Connect(function(...) -- Line: 389
            -- upvalues: u78 (copy)
            u78(...);
        end);
    end;

    function u1.applyMouseLeave(p79: any, p80: userdata, u81: function) -- Line: 394
        p80.MouseLeave:Connect(function(...) -- Line: 395
            -- upvalues: u81 (copy)
            u81(...);
        end);
    end;

    function u1.applyInputBegan(p82: any, p83: userdata, u84: function) -- Line: 400
        p83.InputBegan:Connect(function(...) -- Line: 401
            -- upvalues: u84 (copy)
            u84(...);
        end);
    end;

    function u1.applyInputEnded(p85: any, p86: userdata, u87: function) -- Line: 406
        p86.InputEnded:Connect(function(...) -- Line: 407
            -- upvalues: u87 (copy)
            u87(...);
        end);
    end;

    function u1.discardState(p88) -- Line: 412
        for _, v in p88.state do
            v.ConnectedWidgets[p88.ID] = nil;
        end;
    end;

    function u1.registerEvent(u89: string, u90: function) -- Line: 418
        -- upvalues: u2 (copy), u1 (ref)
        table.insert(u2._initFunctions, function() -- Line: 419
            -- upvalues: u2 (ref), u1 (ref), u89 (copy), u90 (copy)
            table.insert(u2._connections, u1.UserInputService[u89]:Connect(u90));
        end);
    end;

    u1.EVENTS = {
        hover = function(u91: function) -- Line: 425, Name: hover
            -- upvalues: u1 (ref)
            return {
                Init = function(u92) -- Line: 427
                    -- upvalues: u91 (copy), u1 (ref)
                    local v93 = u91(u92);
                    u1.applyMouseEnter(u92, v93, function() -- Line: 429
                        -- upvalues: u92 (copy)
                        u92.isHoveredEvent = true;
                    end);
                    u1.applyMouseLeave(u92, v93, function() -- Line: 432
                        -- upvalues: u92 (copy)
                        u92.isHoveredEvent = false;
                    end);
                    u92.isHoveredEvent = false;
                end,

                Get = function(p94) -- Line: 437
                    return p94.isHoveredEvent;
                end
            };
        end,

        click = function(u95: function) -- Line: 443, Name: click
            -- upvalues: u1 (ref), u2 (copy)
            return {
                Init = function(u96) -- Line: 445
                    -- upvalues: u95 (copy), u1 (ref), u2 (ref)
                    local v97 = u95(u96);
                    u96.lastClickedTick = -1;
                    u1.applyButtonClick(u96, v97, function() -- Line: 449
                        -- upvalues: u96 (copy), u2 (ref)
                        u96.lastClickedTick = u2._cycleTick + 1;
                    end);
                end,

                Get = function(p98) -- Line: 453
                    -- upvalues: u2 (ref)
                    return p98.lastClickedTick == u2._cycleTick;
                end
            };
        end,

        rightClick = function(u99: function) -- Line: 459, Name: rightClick
            -- upvalues: u2 (copy)
            return {
                Init = function(u100) -- Line: 461
                    -- upvalues: u99 (copy), u2 (ref)
                    local v101 = u99(u100);
                    u100.lastRightClickedTick = -1;
                    v101.MouseButton2Click:Connect(function() -- Line: 465
                        -- upvalues: u100 (copy), u2 (ref)
                        u100.lastRightClickedTick = u2._cycleTick + 1;
                    end);
                end,

                Get = function(p102) -- Line: 469
                    -- upvalues: u2 (ref)
                    return p102.lastRightClickedTick == u2._cycleTick;
                end
            };
        end,

        doubleClick = function(u103: function) -- Line: 475, Name: doubleClick
            -- upvalues: u1 (ref), u2 (copy)
            return {
                Init = function(u104) -- Line: 477
                    -- upvalues: u103 (copy), u1 (ref), u2 (ref)
                    local v105 = u103(u104);
                    u104.lastClickedTime = -1;
                    u104.lastClickedPosition = Vector2.zero;
                    u104.lastDoubleClickedTick = -1;
                    u1.applyButtonDown(u104, v105, function(p106: number, p107: number) -- Line: 483
                        -- upvalues: u1 (ref), u104 (copy), u2 (ref)
                        local Time = u1.getTime();

                        if Time - u104.lastClickedTime < u2._config.MouseDoubleClickTime and (Vector2.new(p106, p107) - u104.lastClickedPosition).Magnitude < u2._config.MouseDoubleClickMaxDist then
                            u104.lastDoubleClickedTick = u2._cycleTick + 1;

                            return;
                        end;

                        u104.lastClickedTime = Time;
                        u104.lastClickedPosition = Vector2.new(p106, p107);
                    end);
                end,

                Get = function(p108) -- Line: 494
                    -- upvalues: u2 (ref)
                    return p108.lastDoubleClickedTick == u2._cycleTick;
                end
            };
        end,

        ctrlClick = function(u109: function) -- Line: 500, Name: ctrlClick
            -- upvalues: u1 (ref), u2 (copy)
            return {
                Init = function(u110) -- Line: 502
                    -- upvalues: u109 (copy), u1 (ref), u2 (ref)
                    local v111 = u109(u110);
                    u110.lastCtrlClickedTick = -1;
                    u1.applyButtonClick(u110, v111, function() -- Line: 506
                        -- upvalues: u1 (ref), u110 (copy), u2 (ref)
                        if u1.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u1.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
                            u110.lastCtrlClickedTick = u2._cycleTick + 1;
                        end;
                    end);
                end,

                Get = function(p112) -- Line: 512
                    -- upvalues: u2 (ref)
                    return p112.lastCtrlClickedTick == u2._cycleTick;
                end
            };
        end
    };
    u2._utility = u1;
    require(script.Root)(u2, u1);
    require(script.Window)(u2, u1);
    require(script.Menu)(u2, u1);
    require(script.Format)(u2, u1);
    require(script.Text)(u2, u1);
    require(script.Button)(u2, u1);
    require(script.Checkbox)(u2, u1);
    require(script.RadioButton)(u2, u1);
    require(script.Image)(u2, u1);
    require(script.Tree)(u2, u1);
    require(script.Input)(u2, u1);
    require(script.Combo)(u2, u1);
    require(script.Plot)(u2, u1);
    require(script.Table)(u2, u1);
end;