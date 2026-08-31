--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Plot
  Path:     game.ReplicatedStorage.Packages._Index.michael-48_iris@2.3.1.iris.widgets.Plot
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);

return function(u1, u2) -- Line: 3
    u1.WidgetConstructor("ProgressBar", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Format = 2
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p3) -- Line: 14
                return p3.Instance;
            end),
            changed = {
                Init = function(p4) -- Line: 18
                end,

                Get = function(p5) -- Line: 19
                    -- upvalues: u1 (copy)
                    return p5.lastNumberChangedTick == u1._cycleTick;
                end
            }
        },

        Generate = function(p6) -- Line: 24, Name: Generate
            -- upvalues: u1 (copy), u2 (copy)
            local Frame = Instance.new("Frame");
            Frame.Name = "Iris_ProgressBar";
            Frame.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
            Frame.BackgroundTransparency = 1;
            Frame.AutomaticSize = Enum.AutomaticSize.Y;
            Frame.LayoutOrder = p6.ZIndex;
            u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local Frame2 = Instance.new("Frame");
            Frame2.Name = "Bar";
            Frame2.Size = UDim2.new(u1._config.ContentWidth, u1._config.ContentHeight);
            Frame2.BackgroundColor3 = u1._config.FrameBgColor;
            Frame2.BackgroundTransparency = u1._config.FrameBgTransparency;
            Frame2.BorderSizePixel = 0;
            Frame2.AutomaticSize = Enum.AutomaticSize.Y;
            Frame2.ClipsDescendants = true;
            u2.applyFrameStyle(Frame2, true);
            Frame2.Parent = Frame;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "Progress";
            TextLabel.AutomaticSize = Enum.AutomaticSize.Y;
            TextLabel.Size = UDim2.new(UDim.new(0, 0), u1._config.ContentHeight);
            TextLabel.BackgroundColor3 = u1._config.PlotHistogramColor;
            TextLabel.BackgroundTransparency = u1._config.PlotHistogramTransparency;
            TextLabel.BorderSizePixel = 0;
            u2.applyTextStyle(TextLabel);
            u2.UIPadding(TextLabel, u1._config.FramePadding);
            u2.UICorner(TextLabel, u1._config.FrameRounding);
            TextLabel.Text = "";
            TextLabel.Parent = Frame2;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "Value";
            TextLabel2.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel2.Size = UDim2.new(UDim.new(0, 0), u1._config.ContentHeight);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.BorderSizePixel = 0;
            TextLabel2.ZIndex = 1;
            u2.applyTextStyle(TextLabel2);
            u2.UIPadding(TextLabel2, u1._config.FramePadding);
            TextLabel2.Parent = Frame2;
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.Name = "TextLabel";
            TextLabel3.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel3.AnchorPoint = Vector2.new(0, 0.5);
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.BorderSizePixel = 0;
            TextLabel3.LayoutOrder = 1;
            u2.applyTextStyle(TextLabel3);
            u2.UIPadding(TextLabel2, u1._config.FramePadding);
            TextLabel3.Parent = Frame;

            return Frame;
        end,

        GenerateState = function(p7) -- Line: 91, Name: GenerateState
            -- upvalues: u1 (copy)
            if p7.state.progress == nil then
                p7.state.progress = u1._widgetState(p7, "Progress", 0);
            end;
        end,

        Update = function(p8) -- Line: 96, Name: Update
            local Instance2 = p8.Instance;
            local TextLabel = Instance2.TextLabel;
            local Value = Instance2.Bar.Value;

            if p8.arguments.Format ~= nil and typeof(p8.arguments.Format) == "string" then
                Value.Text = p8.arguments.Format;
            end;

            TextLabel.Text = p8.arguments.Text or "Progress Bar";
        end,

        UpdateState = function(p9) -- Line: 108, Name: UpdateState
            -- upvalues: u1 (copy)
            local Bar = p9.Instance.Bar;
            local Progress = Bar.Progress;
            local Value = Bar.Value;
            local math_clamp_ret = math.clamp(p9.state.progress.value, 0, 1);

            if Value.AbsoluteSize.X > Bar.AbsoluteSize.X * (1 - math_clamp_ret) then
                Value.AnchorPoint = Vector2.xAxis;
                Value.Position = UDim2.fromScale(1, 0);
            else
                Value.AnchorPoint = Vector2.zero;
                Value.Position = UDim2.new(math_clamp_ret, 0, 0, 0);
            end;

            Progress.Size = UDim2.new(UDim.new(math_clamp_ret, 0), Progress.Size.Height);

            if p9.arguments.Format == nil or typeof(p9.arguments.Format) ~= "string" then
                Value.Text = string.format("%d%%", math_clamp_ret * 100);
            else
                Value.Text = p9.arguments.Format;
            end;

            p9.lastNumberChangedTick = u1._cycleTick + 1;
        end,

        Discard = function(p10) -- Line: 134, Name: Discard
            -- upvalues: u2 (copy)
            p10.Instance:Destroy();
            u2.discardState(p10);
        end
    });
end;