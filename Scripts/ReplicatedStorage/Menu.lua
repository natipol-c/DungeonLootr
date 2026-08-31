--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Menu
  Path:     game.ReplicatedStorage.Packages._Index.michael-48_iris@2.3.1.iris.widgets.Menu
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);

return function(u1, u2) -- Line: 3
    local u3 = false;
    local u4 = nil;
    local u5 = {};

    local function EmptyMenuStack(p6: number?) -- Line: 8
        -- upvalues: u5 (copy), u1 (copy), u3 (ref), u4 (ref)
        for i = #u5, p6 and p6 + 1 or 1, -1 do
            local v7 = u5[i];
            v7.state.isOpened:set(false);
            v7.Instance.BackgroundColor3 = u1._config.HeaderColor;
            v7.Instance.BackgroundTransparency = 1;
            table.remove(u5, i);
            local _ = i;
        end;

        if #u5 == 0 then
            u3 = false;
            u4 = nil;
        end;
    end;

    local function UpdateChildContainerTransform(p8) -- Line: 25
        -- upvalues: u2 (copy), u1 (copy)
        local v9 = p8.parentWidget.type == "Menu";
        local Instance2 = p8.Instance;
        local ChildContainer = p8.ChildContainer;
        ChildContainer.Size = UDim2.fromOffset(Instance2.AbsoluteSize.X, 0);

        if ChildContainer.Parent == nil then
            return;
        end;

        local v10 = Instance2.AbsolutePosition - u2.GuiOffset;
        local AbsoluteSize = Instance2.AbsoluteSize;
        local AbsoluteSize2 = ChildContainer.AbsoluteSize;
        local PopupBorderSize = u1._config.PopupBorderSize;
        local AbsoluteSize3 = ChildContainer.Parent.AbsoluteSize;
        local X = v10.X;
        local Vector2_zero = Vector2.zero;

        if v9 then
            if v10.X + AbsoluteSize2.X > AbsoluteSize3.X then
                Vector2_zero = Vector2.xAxis;
            else
                X = v10.X + AbsoluteSize.X;
            end;
        end;

        local v11;

        if v10.Y + AbsoluteSize2.Y > AbsoluteSize3.Y then
            v11 = v10.Y - PopupBorderSize + (v9 and AbsoluteSize.Y or 0);
            Vector2_zero = Vector2_zero + Vector2.yAxis;
        else
            v11 = v10.Y + PopupBorderSize + (v9 and 0 or AbsoluteSize.Y);
        end;

        ChildContainer.Position = UDim2.fromOffset(X, v11);
        ChildContainer.AnchorPoint = Vector2_zero;
    end;

    u2.registerEvent("InputBegan", function(p12: userdata) -- Line: 65
        -- upvalues: u1 (copy), u3 (ref), u4 (ref), u2 (copy), u5 (copy), EmptyMenuStack (copy)
        if not u1._started then
            return;
        end;

        if p12.UserInputType ~= Enum.UserInputType.MouseButton1 and p12.UserInputType ~= Enum.UserInputType.MouseButton2 then
            return;
        end;

        if u3 == false then
            return;
        end;

        if u4 == nil then
            return;
        end;

        local MouseLocation = u2.getMouseLocation();
        local v13 = false;

        for _, v in u5 do
            for _, v2 in { v.ChildContainer, v.Instance } do
                local v14 = v2.AbsolutePosition - u2.GuiOffset;

                if u2.isPosInsideRect(MouseLocation, v14, v14 + v2.AbsoluteSize) then
                    v13 = true;
                    break;
                end;
            end;

            if v13 then
                break;
            end;
        end;

        if not v13 then
            EmptyMenuStack();
        end;
    end);
    u1.WidgetConstructor("MenuBar", {
        hasState = false,
        hasChildren = true,
        Args = {},
        Events = {},

        Generate = function(p15) -- Line: 107, Name: Generate
            -- upvalues: u1 (copy), u2 (copy)
            local Frame = Instance.new("Frame");
            Frame.Name = "MenuBar";
            Frame.Size = UDim2.fromScale(1, 0);
            Frame.AutomaticSize = Enum.AutomaticSize.Y;
            Frame.BackgroundColor3 = u1._config.MenubarBgColor;
            Frame.BackgroundTransparency = u1._config.MenubarBgTransparency;
            Frame.BorderSizePixel = 0;
            Frame.LayoutOrder = p15.ZIndex;
            Frame.ClipsDescendants = true;
            u2.UIPadding(Frame, Vector2.new(u1._config.WindowPadding.X, 1));
            u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Center;
            u2.applyFrameStyle(Frame, true, true);

            return Frame;
        end,

        Update = function() -- Line: 124, Name: Update
        end,

        ChildAdded = function(p16) -- Line: 127, Name: ChildAdded
            return p16.Instance;
        end,

        Discard = function(p17) -- Line: 130, Name: Discard
            p17.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("Menu", {
        hasState = true,
        hasChildren = true,
        Args = {
            Text = 1
        },
        Events = {
            clicked = u2.EVENTS.click(function(p18) -- Line: 143
                return p18.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p19) -- Line: 146
                return p19.Instance;
            end),
            opened = {
                Init = function(p20) -- Line: 150
                end,

                Get = function(p21) -- Line: 151
                    -- upvalues: u1 (copy)
                    return p21.lastOpenedTick == u1._cycleTick;
                end
            },
            closed = {
                Init = function(p22) -- Line: 156
                end,

                Get = function(p23) -- Line: 157
                    -- upvalues: u1 (copy)
                    return p23.lastClosedTick == u1._cycleTick;
                end
            }
        },

        Generate = function(u24) -- Line: 162, Name: Generate
            -- upvalues: u1 (copy), u2 (copy), u5 (copy), u3 (ref), u4 (ref), EmptyMenuStack (copy)
            u24.ButtonColors = {
                ButtonTransparency = 1,
                ButtonColor = u1._config.HeaderColor,
                ButtonHoveredColor = u1._config.HeaderHoveredColor,
                ButtonHoveredTransparency = u1._config.HeaderHoveredTransparency,
                ButtonActiveColor = u1._config.HeaderHoveredColor,
                ButtonActiveTransparency = u1._config.HeaderHoveredTransparency
            };
            local v25;

            if u24.parentWidget.type == "Menu" then
                v25 = Instance.new("TextButton");
                v25.Name = "Menu";
                v25.BackgroundColor3 = u1._config.HeaderColor;
                v25.BackgroundTransparency = 1;
                v25.BorderSizePixel = 0;
                v25.Size = UDim2.fromScale(1, 0);
                v25.Text = "";
                v25.AutomaticSize = Enum.AutomaticSize.Y;
                v25.LayoutOrder = u24.ZIndex;
                v25.AutoButtonColor = false;
                local v26 = u2.UIPadding(v25, u1._config.FramePadding);
                v26.PaddingTop = v26.PaddingTop - UDim.new(0, 1);
                u2.UIListLayout(v25, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local TextLabel = Instance.new("TextLabel");
                TextLabel.Name = "TextLabel";
                TextLabel.AnchorPoint = Vector2.new(0, 0);
                TextLabel.BackgroundTransparency = 1;
                TextLabel.BorderSizePixel = 0;
                TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
                u2.applyTextStyle(TextLabel);
                TextLabel.Parent = v25;
                local v27 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
                local v28 = v27 - math.round(v27 * 0.2) * 2;
                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.Name = "Icon";
                ImageLabel.Size = UDim2.fromOffset(v28, v28);
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.BorderSizePixel = 0;
                ImageLabel.ImageColor3 = u1._config.TextColor;
                ImageLabel.ImageTransparency = u1._config.TextTransparency;
                ImageLabel.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE;
                ImageLabel.LayoutOrder = 1;
                ImageLabel.Parent = v25;
            else
                v25 = Instance.new("TextButton");
                v25.Name = "Menu";
                v25.AutomaticSize = Enum.AutomaticSize.XY;
                v25.Size = UDim2.fromScale(0, 0);
                v25.BackgroundColor3 = u1._config.HeaderColor;
                v25.BackgroundTransparency = 1;
                v25.BorderSizePixel = 0;
                v25.Text = "";
                v25.LayoutOrder = u24.ZIndex;
                v25.AutoButtonColor = false;
                v25.ClipsDescendants = true;
                u2.applyTextStyle(v25);
                u2.UIPadding(v25, Vector2.new(u1._config.ItemSpacing.X, u1._config.FramePadding.Y));
            end;

            u2.applyInteractionHighlights(u24, v25, v25, u24.ButtonColors);
            u2.applyButtonClick(u24, v25, function() -- Line: 233
                -- upvalues: u5 (ref), u24 (copy), u3 (ref), u4 (ref)
                local v29 = #u5 > 1 and true or not u24.state.isOpened.value;
                u24.state.isOpened:set(v29);
                u3 = v29;
                u4 = v29 and u24 or nil;

                if #u5 <= 1 then
                    if v29 then
                        table.insert(u5, u24);

                        return;
                    end;

                    table.remove(u5);
                end;
            end);
            u2.applyMouseEnter(u24, v25, function() -- Line: 249
                -- upvalues: u3 (ref), u4 (ref), u24 (copy), u5 (ref), EmptyMenuStack (ref)
                if u3 and (u4 and u4 ~= u24) then
                    EmptyMenuStack((table.find(u5, u24.parentWidget)));
                    u24.state.isOpened:set(true);
                    u4 = u24;
                    u3 = true;
                    table.insert(u5, u24);
                end;
            end);
            local ScrollingFrame = Instance.new("ScrollingFrame");
            ScrollingFrame.Name = "MenuContainer";
            ScrollingFrame.BackgroundColor3 = u1._config.PopupBgColor;
            ScrollingFrame.BackgroundTransparency = u1._config.PopupBgTransparency;
            ScrollingFrame.BorderSizePixel = 0;
            ScrollingFrame.Size = UDim2.fromOffset(0, 0);
            ScrollingFrame.AutomaticSize = Enum.AutomaticSize.XY;
            ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            ScrollingFrame.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency;
            ScrollingFrame.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor;
            ScrollingFrame.ScrollBarThickness = u1._config.ScrollbarSize;
            ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0);
            ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
            ScrollingFrame.ZIndex = 6;
            ScrollingFrame.LayoutOrder = 6;
            ScrollingFrame.ClipsDescendants = true;
            u2.UIStroke(ScrollingFrame, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency);
            u2.UIPadding(ScrollingFrame, Vector2.new(2, u1._config.WindowPadding.Y - u1._config.ItemSpacing.Y));
            u2.UIListLayout(ScrollingFrame, Enum.FillDirection.Vertical, UDim.new(0, 1)).VerticalAlignment = Enum.VerticalAlignment.Top;
            local v30 = u1._rootInstance and u1._rootInstance:FindFirstChild("PopupScreenGui");
            ScrollingFrame.Parent = v30;
            u24.ChildContainer = ScrollingFrame;

            return v25;
        end,

        Update = function(p31) -- Line: 299, Name: Update
            local Instance2 = p31.Instance;

            if p31.parentWidget.type == "Menu" then
                Instance2 = Instance2.TextLabel;
            end;

            Instance2.Text = p31.arguments.Text or "Menu";
        end,

        ChildAdded = function(p32, p33) -- Line: 309, Name: ChildAdded
            -- upvalues: UpdateChildContainerTransform (copy)
            UpdateChildContainerTransform(p32);

            return p32.ChildContainer;
        end,

        ChildDiscarded = function(p34, p35) -- Line: 313, Name: ChildDiscarded
            -- upvalues: UpdateChildContainerTransform (copy)
            UpdateChildContainerTransform(p34);
        end,

        GenerateState = function(p36) -- Line: 316, Name: GenerateState
            -- upvalues: u1 (copy)
            if p36.state.isOpened == nil then
                p36.state.isOpened = u1._widgetState(p36, "isOpened", false);
            end;
        end,

        UpdateState = function(p37) -- Line: 321, Name: UpdateState
            -- upvalues: u1 (copy), UpdateChildContainerTransform (copy)
            local ChildContainer = p37.ChildContainer;

            if not p37.state.isOpened.value then
                p37.lastClosedTick = u1._cycleTick + 1;
                p37.ButtonColors.ButtonTransparency = 1;
                ChildContainer.Visible = false;

                return;
            end;

            p37.lastOpenedTick = u1._cycleTick + 1;
            p37.ButtonColors.ButtonTransparency = u1._config.HeaderTransparency;
            ChildContainer.Visible = true;
            UpdateChildContainerTransform(p37);
        end,

        Discard = function(p38) -- Line: 336, Name: Discard
            -- upvalues: u2 (copy)
            p38.Instance:Destroy();
            u2.discardState(p38);
        end
    });
    u1.WidgetConstructor("MenuItem", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1,
            KeyCode = 2,
            ModifierKey = 3
        },
        Events = {
            clicked = u2.EVENTS.click(function(p39) -- Line: 352
                return p39.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p40) -- Line: 355
                return p40.Instance;
            end)
        },

        Generate = function(u41) -- Line: 359, Name: Generate
            -- upvalues: u2 (copy), u1 (copy), EmptyMenuStack (copy), u3 (ref), u4 (ref), u5 (copy)
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "MenuItem";
            TextButton.BackgroundTransparency = 1;
            TextButton.BorderSizePixel = 0;
            TextButton.Size = UDim2.fromScale(1, 0);
            TextButton.Text = "";
            TextButton.AutomaticSize = Enum.AutomaticSize.Y;
            TextButton.LayoutOrder = u41.ZIndex;
            TextButton.AutoButtonColor = false;
            local v42 = u2.UIPadding(TextButton, u1._config.FramePadding);
            v42.PaddingTop = v42.PaddingTop - UDim.new(0, 1);
            u2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X));
            u2.applyInteractionHighlights(u41, TextButton, TextButton, {
                ButtonTransparency = 1,
                ButtonColor = u1._config.HeaderColor,
                ButtonHoveredColor = u1._config.HeaderHoveredColor,
                ButtonHoveredTransparency = u1._config.HeaderHoveredTransparency,
                ButtonActiveColor = u1._config.HeaderHoveredColor,
                ButtonActiveTransparency = u1._config.HeaderHoveredTransparency
            });
            u2.applyButtonClick(u41, TextButton, function() -- Line: 383
                -- upvalues: EmptyMenuStack (ref)
                EmptyMenuStack();
            end);
            u2.applyMouseEnter(u41, TextButton, function() -- Line: 387
                -- upvalues: u41 (copy), u3 (ref), u4 (ref), u5 (ref), EmptyMenuStack (ref)
                local parentWidget = u41.parentWidget;

                if u3 and (u4 and u4 ~= parentWidget) then
                    EmptyMenuStack((table.find(u5, parentWidget)));
                    u4 = parentWidget;
                    u3 = true;
                end;
            end);
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "TextLabel";
            TextLabel.AnchorPoint = Vector2.new(0, 0);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.BorderSizePixel = 0;
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(TextLabel);
            TextLabel.Parent = TextButton;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "Shortcut";
            TextLabel2.AnchorPoint = Vector2.new(0, 0);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.BorderSizePixel = 0;
            TextLabel2.LayoutOrder = 1;
            TextLabel2.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(TextLabel2);
            TextLabel2.Text = "";
            TextLabel2.TextColor3 = u1._config.TextDisabledColor;
            TextLabel2.TextTransparency = u1._config.TextDisabledTransparency;
            TextLabel2.Parent = TextButton;

            return TextButton;
        end,

        Update = function(p43) -- Line: 427, Name: Update
            local Instance2 = p43.Instance;
            local Shortcut = Instance2.Shortcut;
            Instance2.TextLabel.Text = p43.arguments.Text;

            if p43.arguments.KeyCode then
                if p43.arguments.ModifierKey then
                    Shortcut.Text = p43.arguments.ModifierKey.Name .. " + " .. p43.arguments.KeyCode.Name;

                    return;
                end;

                Shortcut.Text = p43.arguments.KeyCode.Name;
            end;
        end,

        Discard = function(p44) -- Line: 441, Name: Discard
            p44.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("MenuToggle", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            KeyCode = 2,
            ModifierKey = 3
        },
        Events = {
            checked = {
                Init = function(p45) -- Line: 457
                end,

                Get = function(p46) -- Line: 458
                    -- upvalues: u1 (copy)
                    return p46.lastCheckedTick == u1._cycleTick;
                end
            },
            unchecked = {
                Init = function(p47) -- Line: 463
                end,

                Get = function(p48) -- Line: 464
                    -- upvalues: u1 (copy)
                    return p48.lastUncheckedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p49) -- Line: 468
                return p49.Instance;
            end)
        },

        Generate = function(u50) -- Line: 472, Name: Generate
            -- upvalues: u2 (copy), u1 (copy), EmptyMenuStack (copy), u3 (ref), u4 (ref), u5 (copy)
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "MenuItem";
            TextButton.BackgroundTransparency = 1;
            TextButton.BorderSizePixel = 0;
            TextButton.Size = UDim2.fromScale(1, 0);
            TextButton.Text = "";
            TextButton.AutomaticSize = Enum.AutomaticSize.Y;
            TextButton.LayoutOrder = u50.ZIndex;
            TextButton.AutoButtonColor = false;
            local v51 = u2.UIPadding(TextButton, u1._config.FramePadding);
            v51.PaddingTop = v51.PaddingTop - UDim.new(0, 1);
            u2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            u2.applyInteractionHighlights(u50, TextButton, TextButton, {
                ButtonTransparency = 1,
                ButtonColor = u1._config.HeaderColor,
                ButtonHoveredColor = u1._config.HeaderHoveredColor,
                ButtonHoveredTransparency = u1._config.HeaderHoveredTransparency,
                ButtonActiveColor = u1._config.HeaderHoveredColor,
                ButtonActiveTransparency = u1._config.HeaderHoveredTransparency
            });
            u2.applyButtonClick(u50, TextButton, function() -- Line: 496
                -- upvalues: u50 (copy), EmptyMenuStack (ref)
                u50.state.isChecked:set(not u50.state.isChecked.value);
                EmptyMenuStack();
            end);
            u2.applyMouseEnter(u50, TextButton, function() -- Line: 502
                -- upvalues: u50 (copy), u3 (ref), u4 (ref), u5 (ref), EmptyMenuStack (ref)
                local parentWidget = u50.parentWidget;

                if u3 and (u4 and u4 ~= parentWidget) then
                    EmptyMenuStack((table.find(u5, parentWidget)));
                    u4 = parentWidget;
                    u3 = true;
                end;
            end);
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "TextLabel";
            TextLabel.AnchorPoint = Vector2.new(0, 0);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.BorderSizePixel = 0;
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(TextLabel);
            TextLabel.Parent = TextButton;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "Shortcut";
            TextLabel2.AnchorPoint = Vector2.new(0, 0);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.BorderSizePixel = 0;
            TextLabel2.LayoutOrder = 1;
            TextLabel2.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(TextLabel2);
            TextLabel2.Text = "";
            TextLabel2.TextColor3 = u1._config.TextDisabledColor;
            TextLabel2.TextTransparency = u1._config.TextDisabledTransparency;
            TextLabel2.Parent = TextButton;
            local v52 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            local v53 = v52 - math.round(v52 * 0.2) * 2;
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "Icon";
            ImageLabel.Size = UDim2.fromOffset(v53, v53);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.BorderSizePixel = 0;
            ImageLabel.ImageColor3 = u1._config.TextColor;
            ImageLabel.ImageTransparency = u1._config.TextTransparency;
            ImageLabel.Image = u2.ICONS.CHECK_MARK;
            ImageLabel.LayoutOrder = 2;
            ImageLabel.Parent = TextButton;

            return TextButton;
        end,

        GenerateState = function(p54) -- Line: 558, Name: GenerateState
            -- upvalues: u1 (copy)
            if p54.state.isChecked == nil then
                p54.state.isChecked = u1._widgetState(p54, "isChecked", false);
            end;
        end,

        Update = function(p55) -- Line: 563, Name: Update
            local Instance2 = p55.Instance;
            local Shortcut = Instance2.Shortcut;
            Instance2.TextLabel.Text = p55.arguments.Text;

            if p55.arguments.KeyCode then
                if p55.arguments.ModifierKey then
                    Shortcut.Text = p55.arguments.ModifierKey.Name .. " + " .. p55.arguments.KeyCode.Name;

                    return;
                end;

                Shortcut.Text = p55.arguments.KeyCode.Name;
            end;
        end,

        UpdateState = function(p56) -- Line: 577, Name: UpdateState
            -- upvalues: u2 (copy), u1 (copy)
            local Icon = p56.Instance.Icon;

            if p56.state.isChecked.value then
                Icon.Image = u2.ICONS.CHECK_MARK;
                p56.lastCheckedTick = u1._cycleTick + 1;

                return;
            end;

            Icon.Image = "";
            p56.lastUncheckedTick = u1._cycleTick + 1;
        end,

        Discard = function(p57) -- Line: 589, Name: Discard
            -- upvalues: u2 (copy)
            p57.Instance:Destroy();
            u2.discardState(p57);
        end
    });
end;