--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Window
  Path:     game.ReplicatedStorage.Packages._Index.michael-48_iris@2.3.1.iris.widgets.Window
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);

return function(u1, u2) -- Line: 3
    local function relocateTooltips() -- Line: 4
        -- upvalues: u1 (copy), u2 (copy)
        if u1._rootInstance == nil then
            return;
        end;

        local PopupScreenGui = u1._rootInstance:FindFirstChild("PopupScreenGui");
        local TooltipContainer = PopupScreenGui.TooltipContainer;
        local MouseLocation = u2.getMouseLocation();
        local v3 = u2.findBestWindowPosForPopup(MouseLocation, TooltipContainer.AbsoluteSize, u1._config.DisplaySafeAreaPadding, PopupScreenGui.AbsoluteSize);
        TooltipContainer.Position = UDim2.fromOffset(v3.X, v3.Y);
    end;

    u2.registerEvent("InputChanged", function() -- Line: 15
        -- upvalues: u1 (copy), relocateTooltips (copy)
        if not u1._started then
            return;
        end;

        relocateTooltips();
    end);
    u1.WidgetConstructor("Tooltip", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1
        },
        Events = {},

        Generate = function(p4) -- Line: 30, Name: Generate
            -- upvalues: u1 (copy), u2 (copy)
            p4.parentWidget = u1._rootWidget;
            local Frame = Instance.new("Frame");
            Frame.Name = "Iris_Tooltip";
            Frame.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0));
            Frame.AutomaticSize = Enum.AutomaticSize.Y;
            Frame.BorderSizePixel = 0;
            Frame.BackgroundTransparency = 1;
            Frame.ZIndex = p4.ZIndex + 1;
            Frame.LayoutOrder = p4.ZIndex + 1;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "TooltipText";
            TextLabel.Size = UDim2.fromOffset(0, 0);
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel.BackgroundColor3 = u1._config.PopupBgColor;
            TextLabel.BackgroundTransparency = u1._config.PopupBgTransparency;
            TextLabel.BorderSizePixel = u1._config.PopupBorderSize;
            TextLabel.TextWrapped = u1._config.TextWrapped;
            u2.applyTextStyle(TextLabel);
            u2.UIStroke(TextLabel, u1._config.WindowBorderSize, u1._config.BorderActiveColor, u1._config.BorderActiveTransparency);
            u2.UIPadding(TextLabel, u1._config.WindowPadding);

            if u1._config.PopupRounding > 0 then
                u2.UICorner(TextLabel, u1._config.PopupRounding);
            end;

            TextLabel.Parent = Frame;

            return Frame;
        end,

        Update = function(p5) -- Line: 62, Name: Update
            -- upvalues: relocateTooltips (copy)
            local TooltipText = p5.Instance.TooltipText;

            if p5.arguments.Text == nil then
                error("Iris.Text Text Argument is required", 5);
            end;

            TooltipText.Text = p5.arguments.Text;
            relocateTooltips();
        end,

        Discard = function(p6) -- Line: 71, Name: Discard
            p6.Instance:Destroy();
        end
    });
    local u7 = 0;
    local u8 = nil;
    local u9 = false;
    local u10 = nil;
    local u11 = nil;
    local u12 = false;
    local u13 = false;
    local u14 = false;
    local Top = Enum.TopBottom.Top;
    local Left = Enum.LeftRight.Left;
    local u15 = nil;
    local u16 = nil;
    local u17 = false;
    local u18 = {};

    local function quickSwapWindows() -- Line: 95
        -- upvalues: u1 (copy), u18 (copy)
        if u1._config.UseScreenGUIs == false then
            return;
        end;

        local v19 = 65535;
        local v20 = nil;

        for _, v in u18 do
            if v.state.isOpened.value and (not v.arguments.NoNav and v.Instance:IsA("ScreenGui")) then
                local DisplayOrder = v.Instance.DisplayOrder;

                if DisplayOrder < v19 then
                    v20 = v;
                    v19 = DisplayOrder;
                end;
            end;
        end;

        if not v20 then
            return;
        end;

        if v20.state.isUncollapsed.value == false then
            v20.state.isUncollapsed:set(true);
        end;

        u1.SetFocusedWindow(v20);
    end;

    local function fitSizeToWindowBounds(p21: any, p22) -- Line: 126
        -- upvalues: u1 (copy), u2 (copy)
        local Vector2_new_ret = Vector2.new(p21.state.position.value.X, p21.state.position.value.Y);
        local v23 = (u1._config.TextSize + 2 * u1._config.FramePadding.Y) * 2;
        local ScreenSizeForWindow = u2.getScreenSizeForWindow(p21);
        local Vector2_new_ret2 = Vector2.new(u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.X, u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.Y);
        local v24 = ScreenSizeForWindow - Vector2_new_ret - Vector2_new_ret2;
        local Vector2_new = Vector2.new;
        local X = p22.X;
        local math_max_ret = math.max(v24.X, v23);
        local math_clamp_ret = math.clamp(X, v23, math_max_ret);
        local Y = p22.Y;
        local math_max_ret2 = math.max(v24.Y, v23);

        return Vector2_new(math_clamp_ret, (math.clamp(Y, v23, math_max_ret2)));
    end;

    local function fitPositionToWindowBounds(p25: any, p26) -- Line: 136
        -- upvalues: u2 (copy), u1 (copy)
        local Instance2 = p25.Instance;
        local ScreenSizeForWindow = u2.getScreenSizeForWindow(p25);
        local Vector2_new_ret = Vector2.new(u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.X, u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.Y);
        local Vector2_new = Vector2.new;
        local X = p26.X;
        local X2 = Vector2_new_ret.X;
        local math_max_ret = math.max(Vector2_new_ret.X, ScreenSizeForWindow.X - Instance2.WindowButton.AbsoluteSize.X - Vector2_new_ret.X);
        local math_clamp_ret = math.clamp(X, X2, math_max_ret);
        local Y = p26.Y;
        local Y2 = Vector2_new_ret.Y;
        local math_max_ret2 = math.max(Vector2_new_ret.Y, ScreenSizeForWindow.Y - Instance2.WindowButton.AbsoluteSize.Y - Vector2_new_ret.Y);

        return Vector2_new(math_clamp_ret, (math.clamp(Y, Y2, math_max_ret2)));
    end;

    function u1.SetFocusedWindow(p27) -- Line: 147
        -- upvalues: u16 (ref), u17 (ref), u18 (copy), u1 (copy), u7 (ref), u2 (copy)
        if u16 == p27 then
            return;
        end;

        if u17 and u16 ~= nil then
            if u18[u16.ID] then
                local WindowButton = u16.Instance.WindowButton;
                local TitleBar = WindowButton.Content.TitleBar;

                if u16.state.isUncollapsed.value then
                    TitleBar.BackgroundColor3 = u1._config.TitleBgColor;
                    TitleBar.BackgroundTransparency = u1._config.TitleBgTransparency;
                else
                    TitleBar.BackgroundColor3 = u1._config.TitleBgCollapsedColor;
                    TitleBar.BackgroundTransparency = u1._config.TitleBgCollapsedTransparency;
                end;

                WindowButton.UIStroke.Color = u1._config.BorderColor;
            end;

            u17 = false;
            u16 = nil;
        end;

        if p27 ~= nil then
            u17 = true;
            u16 = p27;
            local Instance2 = p27.Instance;
            local WindowButton = Instance2.WindowButton;
            local TitleBar = WindowButton.Content.TitleBar;
            TitleBar.BackgroundColor3 = u1._config.TitleBgActiveColor;
            TitleBar.BackgroundTransparency = u1._config.TitleBgActiveTransparency;
            WindowButton.UIStroke.Color = u1._config.BorderActiveColor;
            u7 = u7 + 1;

            if p27.usesScreenGUI then
                Instance2.DisplayOrder = u7 + u1._config.DisplayOrderOffset;
            else
                Instance2.ZIndex = u7 + u1._config.DisplayOrderOffset;
            end;

            if p27.state.isUncollapsed.value == false then
                p27.state.isUncollapsed:set(true);
            end;

            if u2.GuiService.SelectedObject then
                if TitleBar.Visible then
                    u2.GuiService:Select(TitleBar);

                    return;
                end;

                u2.GuiService:Select(p27.ChildContainer);
            end;
        end;
    end;

    u2.registerEvent("InputBegan", function(p28: userdata) -- Line: 208
        -- upvalues: u1 (copy), u2 (copy), u18 (copy), quickSwapWindows (copy), u13 (ref), u14 (ref), u17 (ref), u16 (ref), Top (ref), Left (ref), u12 (ref), u11 (ref)
        if not u1._started then
            return;
        end;

        if p28.UserInputType == Enum.UserInputType.MouseButton1 then
            local MouseLocation = u2.getMouseLocation();
            local v29 = false;

            for _, v in u18 do
                local v30 = v.Instance and v.Instance.WindowButton.ResizeBorder;

                if v30 and u2.isPosInsideRect(MouseLocation, v30.AbsolutePosition - u2.GuiOffset, v30.AbsolutePosition - u2.GuiOffset + v30.AbsoluteSize) then
                    v29 = true;
                    break;
                end;
            end;

            if not v29 then
                u1.SetFocusedWindow(nil);
            end;
        end;

        if p28.KeyCode == Enum.KeyCode.Tab and (u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
            quickSwapWindows();
        end;

        if p28.UserInputType == Enum.UserInputType.MouseButton1 and (u13 and (not u14 and (u17 and u16))) then
            local v31 = u16.state.position.value + u16.state.size.value / 2;
            local v32 = u2.getMouseLocation() - v31;

            if math.abs(v32.X) * u16.state.size.value.Y >= math.abs(v32.Y) * u16.state.size.value.X then
                Top = Enum.TopBottom.Center;
                local v33;

                if math.sign(v32.X) == -1 then
                    v33 = Enum.LeftRight.Left;
                else
                    v33 = Enum.LeftRight.Right;
                end;

                Left = v33;
            else
                Left = Enum.LeftRight.Center;
                local v34;

                if math.sign(v32.Y) == -1 then
                    v34 = Enum.TopBottom.Top;
                else
                    v34 = Enum.TopBottom.Bottom;
                end;

                Top = v34;
            end;

            u12 = true;
            u11 = u16;
        end;
    end);
    u2.registerEvent("TouchTapInWorld", function(p35: any, p36: boolean) -- Line: 249
        -- upvalues: u1 (copy)
        if not u1._started then
            return;
        end;

        if not p36 then
            u1.SetFocusedWindow(nil);
        end;
    end);
    u2.registerEvent("InputChanged", function(p37: userdata) -- Line: 258
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u2 (copy), u10 (ref), fitPositionToWindowBounds (copy), u12 (ref), u11 (ref), u15 (ref), Left (ref), Top (ref), fitSizeToWindowBounds (copy)
        if not u1._started then
            return;
        end;

        if u9 and u8 then
            local v38;

            if p37.UserInputType == Enum.UserInputType.Touch then
                local Position = p37.Position;
                v38 = Vector2.new(Position.X, Position.Y);
            else
                v38 = u2.getMouseLocation();
            end;

            local WindowButton = u8.Instance.WindowButton;
            local v39 = fitPositionToWindowBounds(u8, v38 - u10);
            WindowButton.Position = UDim2.fromOffset(v39.X, v39.Y);
            u8.state.position.value = v39;
        end;

        if u12 and (u11 and u11.arguments.NoResize ~= true) then
            local WindowButton = u11.Instance.WindowButton;
            local Vector2_new_ret = Vector2.new(WindowButton.Position.X.Offset, WindowButton.Position.Y.Offset);
            local Vector2_new_ret2 = Vector2.new(WindowButton.Size.X.Offset, WindowButton.Size.Y.Offset);
            local v40;

            if p37.UserInputType == Enum.UserInputType.Touch then
                v40 = p37.Delta;
            else
                v40 = u2.getMouseLocation() - u15;
            end;

            local v41 = Vector2_new_ret + Vector2.new(Left ~= Enum.LeftRight.Left and 0 or v40.X, Top ~= Enum.TopBottom.Top and 0 or v40.Y);
            local v42;

            if Left == Enum.LeftRight.Left then
                v42 = -v40.X;
            else
                v42 = Left ~= Enum.LeftRight.Right and 0 or v40.X;
            end;

            local v43;

            if Top == Enum.TopBottom.Top then
                v43 = -v40.Y;
            else
                v43 = Top ~= Enum.TopBottom.Bottom and 0 or v40.Y;
            end;

            local v44 = fitSizeToWindowBounds(u11, Vector2_new_ret2 + Vector2.new(v42, v43));
            local v45 = fitPositionToWindowBounds(u11, v41);
            WindowButton.Size = UDim2.fromOffset(v44.X, v44.Y);
            u11.state.size.value = v44;
            WindowButton.Position = UDim2.fromOffset(v45.X, v45.Y);
            u11.state.position.value = v45;
        end;

        u15 = u2.getMouseLocation();
    end);
    u2.registerEvent("InputEnded", function(p46, p47) -- Line: 312
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u12 (ref), u11 (ref), quickSwapWindows (copy)
        if not u1._started then
            return;
        end;

        if (p46.UserInputType == Enum.UserInputType.MouseButton1 or p46.UserInputType == Enum.UserInputType.Touch) and (u9 and u8) then
            local WindowButton = u8.Instance.WindowButton;
            u9 = false;
            u8.state.position:set(Vector2.new(WindowButton.Position.X.Offset, WindowButton.Position.Y.Offset));
        end;

        if (p46.UserInputType == Enum.UserInputType.MouseButton1 or p46.UserInputType == Enum.UserInputType.Touch) and (u12 and u11) then
            u12 = false;
            u11.state.size:set(u11.Instance.WindowButton.AbsoluteSize);
        end;

        if p46.KeyCode == Enum.KeyCode.ButtonX then
            quickSwapWindows();
        end;
    end);
    u1.WidgetConstructor("Window", {
        hasState = true,
        hasChildren = true,
        Args = {
            Title = 1,
            NoTitleBar = 2,
            NoBackground = 3,
            NoCollapse = 4,
            NoClose = 5,
            NoMove = 6,
            NoScrollbar = 7,
            NoResize = 8,
            NoNav = 9,
            NoMenu = 10
        },
        Events = {
            closed = {
                Init = function(p48) -- Line: 351
                end,

                Get = function(p49) -- Line: 352
                    -- upvalues: u1 (copy)
                    return p49.lastClosedTick == u1._cycleTick;
                end
            },
            opened = {
                Init = function(p50) -- Line: 357
                end,

                Get = function(p51) -- Line: 358
                    -- upvalues: u1 (copy)
                    return p51.lastOpenedTick == u1._cycleTick;
                end
            },
            collapsed = {
                Init = function(p52) -- Line: 363
                end,

                Get = function(p53) -- Line: 364
                    -- upvalues: u1 (copy)
                    return p53.lastCollapsedTick == u1._cycleTick;
                end
            },
            uncollapsed = {
                Init = function(p54) -- Line: 369
                end,

                Get = function(p55) -- Line: 370
                    -- upvalues: u1 (copy)
                    return p55.lastUncollapsedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p56) -- Line: 374
                return p56.Instance.WindowButton;
            end)
        },

        Generate = function(u57) -- Line: 379, Name: Generate
            -- upvalues: u1 (copy), u18 (copy), u2 (copy), u8 (ref), u9 (ref), u10 (ref), u17 (ref), u16 (ref), u12 (ref), Top (ref), Left (ref), u11 (ref), u13 (ref), u14 (ref)
            u57.parentWidget = u1._rootWidget;
            u57.usesScreenGUI = u1._config.UseScreenGUIs;
            u18[u57.ID] = u57;
            local v58;

            if u57.usesScreenGUI then
                v58 = Instance.new("ScreenGui");
                v58.ResetOnSpawn = false;
                v58.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                v58.DisplayOrder = u1._config.DisplayOrderOffset;
                v58.IgnoreGuiInset = u1._config.IgnoreGuiInset;
            else
                v58 = Instance.new("Frame");
                v58.AnchorPoint = Vector2.new(0.5, 0.5);
                v58.Position = UDim2.new(0.5, 0, 0.5, 0);
                v58.Size = UDim2.new(1, 0, 1, 0);
                v58.BackgroundTransparency = 1;
                v58.ZIndex = u1._config.DisplayOrderOffset;
            end;

            v58.Name = "Iris_Window";
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "WindowButton";
            TextButton.Size = UDim2.fromOffset(0, 0);
            TextButton.BackgroundTransparency = 1;
            TextButton.BorderSizePixel = 0;
            TextButton.Text = "";
            TextButton.ClipsDescendants = false;
            TextButton.AutoButtonColor = false;
            TextButton.Selectable = false;
            TextButton.SelectionImageObject = u1.SelectionImageObject;
            TextButton.SelectionGroup = true;
            TextButton.SelectionBehaviorUp = Enum.SelectionBehavior.Stop;
            TextButton.SelectionBehaviorDown = Enum.SelectionBehavior.Stop;
            TextButton.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop;
            TextButton.SelectionBehaviorRight = Enum.SelectionBehavior.Stop;
            u2.UIStroke(TextButton, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency);
            TextButton.Parent = v58;
            u2.applyInputBegan(u57, TextButton, function(p59: userdata) -- Line: 423
                -- upvalues: u57 (copy), u1 (ref), u8 (ref), u9 (ref), u10 (ref), u2 (ref)
                if p59.UserInputType == Enum.UserInputType.MouseMovement or p59.UserInputType == Enum.UserInputType.Keyboard then
                    return;
                end;

                if u57.state.isUncollapsed.value then
                    u1.SetFocusedWindow(u57);
                end;

                if not u57.arguments.NoMove and p59.UserInputType == Enum.UserInputType.MouseButton1 then
                    u8 = u57;
                    u9 = true;
                    u10 = u2.getMouseLocation() - u57.state.position.value;
                end;
            end);
            local Frame = Instance.new("Frame");
            Frame.Name = "Content";
            Frame.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame.Position = UDim2.fromScale(0.5, 0.5);
            Frame.Size = UDim2.fromScale(1, 1);
            Frame.BackgroundTransparency = 1;
            Frame.ClipsDescendants = true;
            Frame.Parent = TextButton;
            local v60 = u2.UIListLayout(Frame, Enum.FillDirection.Vertical, UDim.new(0, 0));
            v60.HorizontalAlignment = Enum.HorizontalAlignment.Center;
            v60.VerticalAlignment = Enum.VerticalAlignment.Top;
            local ScrollingFrame = Instance.new("ScrollingFrame");
            ScrollingFrame.Name = "WindowContainer";
            ScrollingFrame.Size = UDim2.fromScale(1, 1);
            ScrollingFrame.Position = UDim2.fromOffset(0, 0);
            ScrollingFrame.BackgroundColor3 = u1._config.WindowBgColor;
            ScrollingFrame.BackgroundTransparency = u1._config.WindowBgTransparency;
            ScrollingFrame.BorderSizePixel = 0;
            ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            ScrollingFrame.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency;
            ScrollingFrame.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor;
            ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0);
            ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
            ScrollingFrame.LayoutOrder = u57.ZIndex + 65535;
            ScrollingFrame.ClipsDescendants = true;
            u2.UIPadding(ScrollingFrame, u1._config.WindowPadding);
            ScrollingFrame.Parent = Frame;
            local UIFlexItem = Instance.new("UIFlexItem");
            UIFlexItem.FlexMode = Enum.UIFlexMode.Fill;
            UIFlexItem.ItemLineAlignment = Enum.ItemLineAlignment.End;
            UIFlexItem.Parent = ScrollingFrame;
            ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 476
                -- upvalues: u57 (copy), ScrollingFrame (copy)
                u57.state.scrollDistance.value = ScrollingFrame.CanvasPosition.Y;
            end);
            u2.applyInputBegan(u57, ScrollingFrame, function(p61: userdata) -- Line: 481
                -- upvalues: u57 (copy), u1 (ref)
                if p61.UserInputType == Enum.UserInputType.MouseMovement or p61.UserInputType == Enum.UserInputType.Keyboard then
                    return;
                end;

                if u57.state.isUncollapsed.value then
                    u1.SetFocusedWindow(u57);
                end;
            end);
            local Frame2 = Instance.new("Frame");
            Frame2.Name = "TerminatingFrame";
            Frame2.Size = UDim2.fromOffset(0, u1._config.WindowPadding.Y + u1._config.FramePadding.Y);
            Frame2.BackgroundTransparency = 1;
            Frame2.BorderSizePixel = 0;
            Frame2.LayoutOrder = 2147483632;
            u2.UIListLayout(ScrollingFrame, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top;
            Frame2.Parent = ScrollingFrame;
            local Frame3 = Instance.new("Frame");
            Frame3.Name = "TitleBar";
            Frame3.AutomaticSize = Enum.AutomaticSize.Y;
            Frame3.Size = UDim2.fromScale(1, 0);
            Frame3.BorderSizePixel = 0;
            Frame3.ClipsDescendants = true;
            Frame3.Parent = Frame;
            u2.UIPadding(Frame3, Vector2.xAxis * u1._config.FramePadding.X);
            u2.UIListLayout(Frame3, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            u2.applyInputBegan(u57, Frame3, function(p62: userdata) -- Line: 513
                -- upvalues: u57 (copy), u8 (ref), u9 (ref), u10 (ref)
                if p62.UserInputType == Enum.UserInputType.Touch and not u57.arguments.NoMove then
                    u8 = u57;
                    u9 = true;
                    local Position = p62.Position;
                    u10 = Vector2.new(Position.X, Position.Y) - u57.state.position.value;
                end;
            end);
            local v63 = u1._config.TextSize + (u1._config.FramePadding.Y - 1) * 2;
            local TextButton2 = Instance.new("TextButton");
            TextButton2.Name = "CollapseButton";
            TextButton2.AnchorPoint = Vector2.new(0, 0.5);
            TextButton2.Size = UDim2.fromOffset(v63, v63);
            TextButton2.Position = UDim2.new(0, 0, 0.5, 0);
            TextButton2.AutomaticSize = Enum.AutomaticSize.None;
            TextButton2.BackgroundTransparency = 1;
            TextButton2.BorderSizePixel = 0;
            TextButton2.AutoButtonColor = false;
            TextButton2.Text = "";
            u2.UICorner(TextButton2);
            TextButton2.Parent = Frame3;
            u2.applyButtonClick(u57, TextButton2, function() -- Line: 541
                -- upvalues: u57 (copy)
                u57.state.isUncollapsed:set(not u57.state.isUncollapsed.value);
            end);
            u2.applyInteractionHighlights(u57, TextButton2, TextButton2, {
                ButtonTransparency = 1,
                ButtonColor = u1._config.ButtonColor,
                ButtonHoveredColor = u1._config.ButtonHoveredColor,
                ButtonHoveredTransparency = u1._config.ButtonHoveredTransparency,
                ButtonActiveColor = u1._config.ButtonActiveColor,
                ButtonActiveTransparency = u1._config.ButtonActiveTransparency
            });
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "Arrow";
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel.Size = UDim2.fromOffset(math.floor(v63 * 0.7), (math.floor(v63 * 0.7)));
            ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.BorderSizePixel = 0;
            ImageLabel.Image = u2.ICONS.MULTIPLICATION_SIGN;
            ImageLabel.ImageColor3 = u1._config.TextColor;
            ImageLabel.ImageTransparency = u1._config.TextTransparency;
            ImageLabel.Parent = TextButton2;
            local TextButton3 = Instance.new("TextButton");
            TextButton3.Name = "CloseButton";
            TextButton3.AnchorPoint = Vector2.new(1, 0.5);
            TextButton3.Size = UDim2.fromOffset(v63, v63);
            TextButton3.Position = UDim2.new(1, 0, 0.5, 0);
            TextButton3.AutomaticSize = Enum.AutomaticSize.None;
            TextButton3.BackgroundTransparency = 1;
            TextButton3.BorderSizePixel = 0;
            TextButton3.Text = "";
            TextButton3.LayoutOrder = 2;
            TextButton3.AutoButtonColor = false;
            u2.UICorner(TextButton3);
            u2.applyButtonClick(u57, TextButton3, function() -- Line: 580
                -- upvalues: u57 (copy)
                u57.state.isOpened:set(false);
            end);
            u2.applyInteractionHighlights(u57, TextButton3, TextButton3, {
                ButtonTransparency = 1,
                ButtonColor = u1._config.ButtonColor,
                ButtonHoveredColor = u1._config.ButtonHoveredColor,
                ButtonHoveredTransparency = u1._config.ButtonHoveredTransparency,
                ButtonActiveColor = u1._config.ButtonActiveColor,
                ButtonActiveTransparency = u1._config.ButtonActiveTransparency
            });
            TextButton3.Parent = Frame3;
            local ImageLabel2 = Instance.new("ImageLabel");
            ImageLabel2.Name = "Icon";
            ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel2.Size = UDim2.fromOffset(math.floor(v63 * 0.7), (math.floor(v63 * 0.7)));
            ImageLabel2.Position = UDim2.fromScale(0.5, 0.5);
            ImageLabel2.BackgroundTransparency = 1;
            ImageLabel2.BorderSizePixel = 0;
            ImageLabel2.Image = u2.ICONS.MULTIPLICATION_SIGN;
            ImageLabel2.ImageColor3 = u1._config.TextColor;
            ImageLabel2.ImageTransparency = u1._config.TextTransparency;
            ImageLabel2.Parent = TextButton3;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "Title";
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel.BorderSizePixel = 0;
            TextLabel.BackgroundTransparency = 1;
            TextLabel.LayoutOrder = 1;
            TextLabel.ClipsDescendants = true;
            u2.UIPadding(TextLabel, Vector2.yAxis * u1._config.FramePadding.Y);
            u2.applyTextStyle(TextLabel);
            TextLabel.TextXAlignment = Enum.TextXAlignment[u1._config.WindowTitleAlign.Name];
            local UIFlexItem2 = Instance.new("UIFlexItem");
            UIFlexItem2.FlexMode = Enum.UIFlexMode.Fill;
            UIFlexItem2.ItemLineAlignment = Enum.ItemLineAlignment.Center;
            UIFlexItem2.Parent = TextLabel;
            TextLabel.Parent = Frame3;
            local v64 = u1._config.TextSize + u1._config.FramePadding.X;
            local ImageButton = Instance.new("ImageButton");
            ImageButton.Name = "ResizeGrip";
            ImageButton.AnchorPoint = Vector2.new(1, 1);
            ImageButton.Size = UDim2.fromOffset(v64, v64);
            ImageButton.Position = UDim2.fromScale(1, 1);
            ImageButton.Rotation = 90;
            ImageButton.AutoButtonColor = false;
            ImageButton.BorderSizePixel = 0;
            ImageButton.BackgroundTransparency = 1;
            ImageButton.Image = u2.ICONS.BOTTOM_RIGHT_CORNER;
            ImageButton.ImageColor3 = u1._config.ButtonColor;
            ImageButton.ImageTransparency = u1._config.ButtonTransparency;
            ImageButton.Selectable = false;
            ImageButton.ZIndex = 3;
            ImageButton.Parent = TextButton;
            u2.applyImageInteractionHighlights(u57, ImageButton, ImageButton, {
                ButtonColor = u1._config.ButtonColor,
                ButtonTransparency = u1._config.ButtonTransparency,
                ButtonHoveredColor = u1._config.ButtonHoveredColor,
                ButtonHoveredTransparency = u1._config.ButtonHoveredTransparency,
                ButtonActiveColor = u1._config.ButtonActiveColor,
                ButtonActiveTransparency = u1._config.ButtonActiveTransparency
            });
            u2.applyButtonDown(u57, ImageButton, function() -- Line: 656
                -- upvalues: u17 (ref), u16 (ref), u57 (copy), u1 (ref), u12 (ref), Top (ref), Left (ref), u11 (ref)
                if not u17 or u16 ~= u57 then
                    u1.SetFocusedWindow(u57);
                end;

                u12 = true;
                Top = Enum.TopBottom.Bottom;
                Left = Enum.LeftRight.Right;
                u11 = u57;
            end);
            local Frame4 = Instance.new("Frame");
            Frame4.Name = "ResizeBorder";
            Frame4.Size = UDim2.new(1, u1._config.WindowResizePadding.X * 2, 1, u1._config.WindowResizePadding.Y * 2);
            Frame4.Position = UDim2.fromOffset(-u1._config.WindowResizePadding.X, -u1._config.WindowResizePadding.Y);
            Frame4.BackgroundTransparency = 1;
            Frame4.BorderSizePixel = 0;
            Frame4.Active = true;
            Frame4.Selectable = false;
            Frame4.ClipsDescendants = false;
            Frame4.Parent = TextButton;
            u2.applyMouseEnter(u57, Frame4, function() -- Line: 678
                -- upvalues: u16 (ref), u57 (copy), u13 (ref)
                if u16 == u57 then
                    u13 = true;
                end;
            end);
            u2.applyMouseLeave(u57, Frame4, function() -- Line: 683
                -- upvalues: u16 (ref), u57 (copy), u13 (ref)
                if u16 == u57 then
                    u13 = false;
                end;
            end);
            u2.applyMouseEnter(u57, TextButton, function() -- Line: 689
                -- upvalues: u16 (ref), u57 (copy), u14 (ref)
                if u16 == u57 then
                    u14 = true;
                end;
            end);
            u2.applyMouseLeave(u57, TextButton, function() -- Line: 694
                -- upvalues: u16 (ref), u57 (copy), u14 (ref)
                if u16 == u57 then
                    u14 = false;
                end;
            end);
            u57.ChildContainer = ScrollingFrame;

            return v58;
        end,

        Update = function(p65) -- Line: 703, Name: Update
            -- upvalues: u1 (copy)
            local ChildContainer = p65.ChildContainer;
            local WindowButton = p65.Instance.WindowButton;
            local Content = WindowButton.Content;
            local TitleBar = Content.TitleBar;
            local Title = TitleBar.Title;
            local MenuBar = Content:FindFirstChild("MenuBar");
            local ResizeGrip = WindowButton.ResizeGrip;

            if p65.arguments.NoResize == true then
                ResizeGrip.Visible = false;
            else
                ResizeGrip.Visible = true;
            end;

            if p65.arguments.NoScrollbar then
                ChildContainer.ScrollBarThickness = 0;
            else
                ChildContainer.ScrollBarThickness = u1._config.ScrollbarSize;
            end;

            if p65.arguments.NoTitleBar then
                TitleBar.Visible = false;
            else
                TitleBar.Visible = true;
            end;

            if MenuBar then
                if p65.arguments.NoMenu then
                    MenuBar.Visible = false;
                else
                    MenuBar.Visible = true;
                end;
            end;

            if p65.arguments.NoBackground then
                ChildContainer.BackgroundTransparency = 1;
            else
                ChildContainer.BackgroundTransparency = u1._config.WindowBgTransparency;
            end;

            if p65.arguments.NoCollapse then
                TitleBar.CollapseButton.Visible = false;
            else
                TitleBar.CollapseButton.Visible = true;
            end;

            if p65.arguments.NoClose then
                TitleBar.CloseButton.Visible = false;
            else
                TitleBar.CloseButton.Visible = true;
            end;

            Title.Text = p65.arguments.Title or "";
        end,

        Discard = function(p66) -- Line: 755, Name: Discard
            -- upvalues: u16 (ref), u17 (ref), u8 (ref), u9 (ref), u11 (ref), u12 (ref), u18 (copy), u2 (copy)
            if u16 == p66 then
                u16 = nil;
                u17 = false;
            end;

            if u8 == p66 then
                u8 = nil;
                u9 = false;
            end;

            if u11 == p66 then
                u11 = nil;
                u12 = false;
            end;

            u18[p66.ID] = nil;
            p66.Instance:Destroy();
            u2.discardState(p66);
        end,

        ChildAdded = function(p67, p68) -- Line: 772, Name: ChildAdded
            local Content = p67.Instance.WindowButton.Content;

            if p68.type ~= "MenuBar" then
                return p67.ChildContainer;
            end;

            local ChildContainer = p67.ChildContainer;
            p68.Instance.ZIndex = ChildContainer.ZIndex + 1;
            p68.Instance.LayoutOrder = ChildContainer.LayoutOrder - 1;

            return Content;
        end,

        UpdateState = function(u69) -- Line: 784, Name: UpdateState
            -- upvalues: u1 (copy), u2 (copy)
            local value = u69.state.size.value;
            local value2 = u69.state.position.value;
            local value3 = u69.state.isUncollapsed.value;
            local value4 = u69.state.isOpened.value;
            local value5 = u69.state.scrollDistance.value;
            local Instance2 = u69.Instance;
            local ChildContainer = u69.ChildContainer;
            local WindowButton = Instance2.WindowButton;
            local Content = WindowButton.Content;
            local TitleBar = Content.TitleBar;
            local MenuBar = Content:FindFirstChild("MenuBar");
            local ResizeGrip = WindowButton.ResizeGrip;
            WindowButton.Size = UDim2.fromOffset(value.X, value.Y);
            WindowButton.Position = UDim2.fromOffset(value2.X, value2.Y);

            if value4 then
                if u69.usesScreenGUI then
                    Instance2.Enabled = true;
                    WindowButton.Visible = true;
                else
                    Instance2.Visible = true;
                    WindowButton.Visible = true;
                end;

                u69.lastOpenedTick = u1._cycleTick + 1;
            else
                if u69.usesScreenGUI then
                    Instance2.Enabled = false;
                    WindowButton.Visible = false;
                else
                    Instance2.Visible = false;
                    WindowButton.Visible = false;
                end;

                u69.lastClosedTick = u1._cycleTick + 1;
            end;

            if value3 then
                TitleBar.CollapseButton.Arrow.Image = u2.ICONS.DOWN_POINTING_TRIANGLE;

                if MenuBar then
                    MenuBar.Visible = not u69.arguments.NoMenu;
                end;

                ChildContainer.Visible = true;

                if u69.arguments.NoResize ~= true then
                    ResizeGrip.Visible = true;
                end;

                WindowButton.AutomaticSize = Enum.AutomaticSize.None;
                u69.lastUncollapsedTick = u1._cycleTick + 1;
            else
                local Y = TitleBar.AbsoluteSize.Y;
                TitleBar.CollapseButton.Arrow.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE;

                if MenuBar then
                    MenuBar.Visible = false;
                end;

                ChildContainer.Visible = false;
                ResizeGrip.Visible = false;
                WindowButton.Size = UDim2.fromOffset(value.X, Y);
                u69.lastCollapsedTick = u1._cycleTick + 1;
            end;

            if value4 and value3 then
                u1.SetFocusedWindow(u69);
            else
                TitleBar.BackgroundColor3 = u1._config.TitleBgCollapsedColor;
                TitleBar.BackgroundTransparency = u1._config.TitleBgCollapsedTransparency;
                WindowButton.UIStroke.Color = u1._config.BorderColor;
                u1.SetFocusedWindow(nil);
            end;

            if value5 and value5 ~= 0 then
                local u70 = #u1._postCycleCallbacks + 1;
                local u71 = u1._cycleTick + 1;

                u1._postCycleCallbacks[u70] = function() -- Line: 860
                    -- upvalues: u1 (ref), u71 (copy), u69 (copy), ChildContainer (copy), value5 (copy), u70 (copy)
                    if u71 <= u1._cycleTick then
                        if u69.lastCycleTick ~= -1 then
                            ChildContainer.CanvasPosition = Vector2.new(0, value5);
                        end;

                        u1._postCycleCallbacks[u70] = nil;
                    end;
                end;
            end;
        end,

        GenerateState = function(p72) -- Line: 870, Name: GenerateState
            -- upvalues: u1 (copy), u17 (ref), u16 (ref), fitPositionToWindowBounds (copy), fitSizeToWindowBounds (copy)
            if p72.state.size == nil then
                p72.state.size = u1._widgetState(p72, "size", Vector2.new(400, 300));
            end;

            if p72.state.position == nil then
                local state = p72.state;
                local _widgetState = u1._widgetState;
                local v73;

                if u17 and u16 then
                    v73 = u16.state.position.value + Vector2.new(15, 45);
                else
                    v73 = Vector2.new(150, 250);
                end;

                state.position = _widgetState(p72, "position", v73);
            end;

            p72.state.position.value = fitPositionToWindowBounds(p72, p72.state.position.value);
            p72.state.size.value = fitSizeToWindowBounds(p72, p72.state.size.value);

            if p72.state.isUncollapsed == nil then
                p72.state.isUncollapsed = u1._widgetState(p72, "isUncollapsed", true);
            end;

            if p72.state.isOpened == nil then
                p72.state.isOpened = u1._widgetState(p72, "isOpened", true);
            end;

            if p72.state.scrollDistance == nil then
                p72.state.scrollDistance = u1._widgetState(p72, "scrollDistance", 0);
            end;
        end
    });
end;