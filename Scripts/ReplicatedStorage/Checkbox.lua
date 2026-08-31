--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Checkbox
  Path:     game.ReplicatedStorage.Packages._Index.michael-48_iris@2.3.1.iris.widgets.Checkbox
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);

return function(u1, u2) -- Line: 3
    u1.WidgetConstructor("Checkbox", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1
        },
        Events = {
            checked = {
                Init = function(p3) -- Line: 13
                end,

                Get = function(p4) -- Line: 14
                    -- upvalues: u1 (copy)
                    return p4.lastCheckedTick == u1._cycleTick;
                end
            },
            unchecked = {
                Init = function(p5) -- Line: 19
                end,

                Get = function(p6) -- Line: 20
                    -- upvalues: u1 (copy)
                    return p6.lastUncheckedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p7) -- Line: 24
                return p7.Instance;
            end)
        },

        Generate = function(u8) -- Line: 28, Name: Generate
            -- upvalues: u2 (copy), u1 (copy)
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "Iris_Checkbox";
            TextButton.AutomaticSize = Enum.AutomaticSize.XY;
            TextButton.Size = UDim2.fromOffset(0, 0);
            TextButton.BackgroundTransparency = 1;
            TextButton.BorderSizePixel = 0;
            TextButton.Text = "";
            TextButton.AutoButtonColor = false;
            TextButton.ZIndex = u8.ZIndex;
            TextButton.LayoutOrder = u8.ZIndex;
            u2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local v9 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            local Frame = Instance.new("Frame");
            Frame.Name = "Box";
            Frame.Size = UDim2.fromOffset(v9, v9);
            Frame.BackgroundColor3 = u1._config.FrameBgColor;
            Frame.BackgroundTransparency = u1._config.FrameBgTransparency;
            u2.applyFrameStyle(Frame, true);
            u2.UIPadding(Frame, v9 // 10 * Vector2.one);
            u2.applyInteractionHighlights(u8, TextButton, Frame, {
                ButtonColor = u1._config.FrameBgColor,
                ButtonTransparency = u1._config.FrameBgTransparency,
                ButtonHoveredColor = u1._config.FrameBgHoveredColor,
                ButtonHoveredTransparency = u1._config.FrameBgHoveredTransparency,
                ButtonActiveColor = u1._config.FrameBgActiveColor,
                ButtonActiveTransparency = u1._config.FrameBgActiveTransparency
            });
            Frame.Parent = TextButton;
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "Checkmark";
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageColor3 = u1._config.CheckMarkColor;
            ImageLabel.ImageTransparency = u1._config.CheckMarkTransparency;
            ImageLabel.ScaleType = Enum.ScaleType.Fit;
            ImageLabel.Parent = Frame;
            u2.applyButtonClick(u8, TextButton, function() -- Line: 75
                -- upvalues: u8 (copy)
                u8.state.isChecked:set(not u8.state.isChecked.value);
            end);
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "TextLabel";
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel.BackgroundTransparency = 1;
            TextLabel.BorderSizePixel = 0;
            TextLabel.LayoutOrder = 1;
            u2.applyTextStyle(TextLabel);
            TextLabel.Parent = TextButton;

            return TextButton;
        end,

        Update = function(p10) -- Line: 92, Name: Update
            p10.Instance.TextLabel.Text = p10.arguments.Text or "Checkbox";
        end,

        Discard = function(p11) -- Line: 96, Name: Discard
            -- upvalues: u2 (copy)
            p11.Instance:Destroy();
            u2.discardState(p11);
        end,

        GenerateState = function(p12) -- Line: 100, Name: GenerateState
            -- upvalues: u1 (copy)
            if p12.state.isChecked == nil then
                p12.state.isChecked = u1._widgetState(p12, "checked", false);
            end;
        end,

        UpdateState = function(p13) -- Line: 105, Name: UpdateState
            -- upvalues: u2 (copy), u1 (copy)
            local Checkmark = p13.Instance.Box.Checkmark;

            if p13.state.isChecked.value then
                Checkmark.Image = u2.ICONS.CHECK_MARK;
                p13.lastCheckedTick = u1._cycleTick + 1;

                return;
            end;

            Checkmark.Image = "";
            p13.lastUncheckedTick = u1._cycleTick + 1;
        end
    });
end;