--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Input
  Path:     game.ReplicatedStorage.Packages._Index.michael-48_iris@2.3.1.iris.widgets.Input
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);

return function(u1, u2) -- Line: 3
    local u5 = {
        Init = function(p3) -- Line: 5
        end,

        Get = function(p4) -- Line: 6
            -- upvalues: u1 (copy)
            return p4.lastNumberChangedTick == u1._cycleTick;
        end
    };

    local function getValueByIndex(p6: any, p7: number, p8: any) -- Line: 11
        if typeof(p6) == "number" then
            return p6;
        end;

        if typeof(p6) == "Vector2" then
            if p7 == 1 then
                return p6.X;
            end;

            if p7 == 2 then
                return p6.Y;
            end;
        elseif typeof(p6) == "Vector3" then
            if p7 == 1 then
                return p6.X;
            end;

            if p7 == 2 then
                return p6.Y;
            end;

            if p7 == 3 then
                return p6.Z;
            end;
        elseif typeof(p6) == "UDim" then
            if p7 == 1 then
                return p6.Scale;
            end;

            if p7 == 2 then
                return p6.Offset;
            end;
        elseif typeof(p6) == "UDim2" then
            if p7 == 1 then
                return p6.X.Scale;
            end;

            if p7 == 2 then
                return p6.X.Offset;
            end;

            if p7 == 3 then
                return p6.Y.Scale;
            end;

            if p7 == 4 then
                return p6.Y.Offset;
            end;
        elseif typeof(p6) == "Color3" then
            local v9 = p8.UseHSV and { p6:ToHSV() } or { p6.R, p6.G, p6.B };

            if p7 == 1 then
                return v9[1];
            end;

            if p7 == 2 then
                return v9[2];
            end;

            if p7 == 3 then
                return v9[3];
            end;
        elseif typeof(p6) == "Rect" then
            if p7 == 1 then
                return p6.Min.X;
            end;

            if p7 == 2 then
                return p6.Min.Y;
            end;

            if p7 == 3 then
                return p6.Max.X;
            end;

            if p7 == 4 then
                return p6.Max.Y;
            end;
        elseif typeof(p6) == "table" then
            return p6[p7];
        end;

        error((`Incorrect datatype or value: {p6} {typeof(p6)} {p7}`));
    end;

    local function updateValueByIndex(p10: any, p11: number, p12: number, p13: any) -- Line: 70
        if typeof(p10) == "number" then
            return p12;
        end;

        if typeof(p10) == "Vector2" then
            if p11 == 1 then
                return Vector2.new(p12, p10.Y);
            end;

            if p11 == 2 then
                return Vector2.new(p10.X, p12);
            end;
        elseif typeof(p10) == "Vector3" then
            if p11 == 1 then
                return Vector3.new(p12, p10.Y, p10.Z);
            end;

            if p11 == 2 then
                return Vector3.new(p10.X, p12, p10.Z);
            end;

            if p11 == 3 then
                return Vector3.new(p10.X, p10.Y, p12);
            end;
        elseif typeof(p10) == "UDim" then
            if p11 == 1 then
                return UDim.new(p12, p10.Offset);
            end;

            if p11 == 2 then
                return UDim.new(p10.Scale, p12);
            end;
        elseif typeof(p10) == "UDim2" then
            if p11 == 1 then
                return UDim2.new(UDim.new(p12, p10.X.Offset), p10.Y);
            end;

            if p11 == 2 then
                return UDim2.new(UDim.new(p10.X.Scale, p12), p10.Y);
            end;

            if p11 == 3 then
                return UDim2.new(p10.X, UDim.new(p12, p10.Y.Offset));
            end;

            if p11 == 4 then
                return UDim2.new(p10.X, UDim.new(p10.Y.Scale, p12));
            end;
        elseif typeof(p10) == "Rect" then
            if p11 == 1 then
                return Rect.new(Vector2.new(p12, p10.Min.Y), p10.Max);
            end;

            if p11 == 2 then
                return Rect.new(Vector2.new(p10.Min.X, p12), p10.Max);
            end;

            if p11 == 3 then
                return Rect.new(p10.Min, Vector2.new(p12, p10.Max.Y));
            end;

            if p11 == 4 then
                return Rect.new(p10.Min, Vector2.new(p10.Max.X, p12));
            end;
        elseif typeof(p10) == "Color3" then
            if p13.UseHSV then
                local v14, v15, v16 = p10:ToHSV();

                if p11 == 1 then
                    return Color3.fromHSV(p12, v15, v16);
                end;

                if p11 == 2 then
                    return Color3.fromHSV(v14, p12, v16);
                end;

                if p11 == 3 then
                    return Color3.fromHSV(v14, v15, p12);
                end;
            end;

            if p11 == 1 then
                return Color3.new(p12, p10.G, p10.B);
            end;

            if p11 == 2 then
                return Color3.new(p10.R, p12, p10.B);
            end;

            if p11 == 3 then
                return Color3.new(p10.R, p10.G, p12);
            end;
        end;

        error((`Incorrect datatype or value {p10} {typeof(p10)} {p11}`));
    end;

    local u17 = {
        Num = { 1 },
        Vector2 = { 1, 1 },
        Vector3 = { 1, 1, 1 },
        UDim = { 0.01, 1 },
        UDim2 = { 0.01, 1, 0.01, 1 },
        Color3 = { 1, 1, 1 },
        Color4 = { 1, 1, 1, 1 },
        Rect = { 1, 1, 1, 1 }
    };
    local u18 = {
        Num = { 0 },
        Vector2 = { 0, 0 },
        Vector3 = { 0, 0, 0 },
        UDim = { 0, 0 },
        UDim2 = { 0, 0, 0, 0 },
        Rect = { 0, 0, 0, 0 }
    };
    local u19 = {
        Num = { 100 },
        Vector2 = { 100, 100 },
        Vector3 = { 100, 100, 100 },
        UDim = { 1, 960 },
        UDim2 = { 1, 960, 1, 960 },
        Rect = { 960, 960, 960, 960 }
    };
    local u20 = {
        Num = { "" },
        Vector2 = { "X: ", "Y: " },
        Vector3 = { "X: ", "Y: ", "Z: " },
        UDim = { "", "" },
        UDim2 = { "", "", "", "" },
        Color3_RGB = { "R: ", "G: ", "B: " },
        Color3_HSV = { "H: ", "S: ", "V: " },
        Color4_RGB = { "R: ", "G: ", "B: ", "T: " },
        Color4_HSV = { "H: ", "S: ", "V: ", "T: " },
        Rect = { "X: ", "Y: ", "X: ", "Y: " }
    };
    local u21 = {
        Num = { 0 },
        Vector2 = { 0, 0 },
        Vector3 = { 0, 0, 0 },
        UDim = { 3, 0 },
        UDim2 = { 3, 0, 3, 0 },
        Color3 = { 0, 0, 0 },
        Color4 = { 0, 0, 0, 0 },
        Rect = { 0, 0, 0, 0 }
    };

    local function generateButtons(u22: any, p23: userdata, p24: number, p25: number) -- Line: 194
        -- upvalues: u1 (copy), u2 (copy), getValueByIndex (copy)
        local v26 = p24 + (2 * u1._config.ItemInnerSpacing.X + p25 * 2);
        local v27 = u2.abstractButton.Generate(u22);
        v27.Name = "SubButton";
        v27.ZIndex = 5;
        v27.LayoutOrder = 5;
        v27.TextXAlignment = Enum.TextXAlignment.Center;
        v27.Text = "-";
        v27.Size = UDim2.fromOffset(u1._config.TextSize + 2 * u1._config.FramePadding.Y, u1._config.TextSize);
        v27.Parent = p23;
        u2.applyButtonClick(u22, v27, function() -- Line: 206
            -- upvalues: u2 (ref), u22 (copy), getValueByIndex (ref), u1 (ref)
            local v28 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl);
            local v29 = u22.arguments.Increment and getValueByIndex(u22.arguments.Increment, 1, u22.arguments) or 1;
            local v30 = u22.state.number.value - v29 * (v28 and 100 or 1);

            if u22.arguments.Min ~= nil then
                v30 = math.max(v30, getValueByIndex(u22.arguments.Min, 1, u22.arguments));
            end;

            if u22.arguments.Max ~= nil then
                v30 = math.min(v30, getValueByIndex(u22.arguments.Max, 1, u22.arguments));
            end;

            u22.state.number:set(v30);
            u22.lastNumberChangedTick = u1._cycleTick + 1;
        end);
        local v31 = u2.abstractButton.Generate(u22);
        v31.Name = "AddButton";
        v31.ZIndex = 6;
        v31.LayoutOrder = 6;
        v31.TextXAlignment = Enum.TextXAlignment.Center;
        v31.Text = "+";
        v31.Size = UDim2.fromOffset(u1._config.TextSize + 2 * u1._config.FramePadding.Y, u1._config.TextSize);
        v31.Parent = p23;
        u2.applyButtonClick(u22, v31, function() -- Line: 229
            -- upvalues: u2 (ref), u22 (copy), getValueByIndex (ref), u1 (ref)
            local v32 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl);
            local v33 = u22.arguments.Increment and getValueByIndex(u22.arguments.Increment, 1, u22.arguments) or 1;
            local v34 = u22.state.number.value + v33 * (v32 and 100 or 1);

            if u22.arguments.Min ~= nil then
                v34 = math.max(v34, getValueByIndex(u22.arguments.Min, 1, u22.arguments));
            end;

            if u22.arguments.Max ~= nil then
                v34 = math.min(v34, getValueByIndex(u22.arguments.Max, 1, u22.arguments));
            end;

            u22.state.number:set(v34);
            u22.lastNumberChangedTick = u1._cycleTick + 1;
        end);

        return v26;
    end;

    local function generateInputScalar(u35: any, u36: number, u37: any) -- Line: 246
        -- upvalues: u5 (copy), u2 (copy), u1 (copy), generateButtons (copy), getValueByIndex (copy), updateValueByIndex (copy), u21 (copy), u20 (copy)
        return {
            hasState = true,
            hasChildren = false,
            Args = {
                Text = 1,
                Increment = 2,
                Min = 3,
                Max = 4,
                Format = 5
            },
            Events = {
                numberChanged = u5,
                hovered = u2.EVENTS.hover(function(p38) -- Line: 259
                    return p38.Instance;
                end)
            },

            Generate = function(u39) -- Line: 263, Name: Generate
                -- upvalues: u35 (copy), u2 (ref), u1 (ref), u36 (copy), generateButtons (ref), getValueByIndex (ref), updateValueByIndex (ref)
                local Frame = Instance.new("Frame");
                Frame.Name = "Iris_Input" .. u35;
                Frame.Size = UDim2.fromScale(1, 0);
                Frame.BackgroundTransparency = 1;
                Frame.BorderSizePixel = 0;
                Frame.LayoutOrder = u39.ZIndex;
                Frame.AutomaticSize = Enum.AutomaticSize.Y;
                u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local v40 = 0;
                local v41 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;

                if u36 == 1 then
                    v40 = generateButtons(u39, Frame, v40, v41);
                end;

                local UDim_new_ret = UDim.new(u1._config.ContentWidth.Scale / u36, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u36 - 1) - v40) / u36);
                local UDim_new_ret2 = UDim.new(UDim_new_ret.Scale * (u36 - 1), UDim_new_ret.Offset * (u36 - 1) + u1._config.ItemInnerSpacing.X * (u36 - 1) + v40);
                local v42 = u1._config.ContentWidth - UDim_new_ret2;

                for i = 1, u36 do
                    local TextBox = Instance.new("TextBox");
                    TextBox.Name = "InputField" .. tostring(i);
                    TextBox.LayoutOrder = i;

                    if i == u36 then
                        TextBox.Size = UDim2.new(v42, u1._config.ContentHeight);
                    else
                        TextBox.Size = UDim2.new(UDim_new_ret, u1._config.ContentHeight);
                    end;

                    TextBox.AutomaticSize = Enum.AutomaticSize.Y;
                    TextBox.BackgroundColor3 = u1._config.FrameBgColor;
                    TextBox.BackgroundTransparency = u1._config.FrameBgTransparency;
                    TextBox.ClearTextOnFocus = false;
                    TextBox.TextTruncate = Enum.TextTruncate.AtEnd;
                    TextBox.ClipsDescendants = true;
                    u2.applyFrameStyle(TextBox);
                    u2.applyTextStyle(TextBox);
                    u2.UISizeConstraint(TextBox, Vector2.new(1, 0));
                    TextBox.Parent = Frame;
                    TextBox.FocusLost:Connect(function() -- Line: 312
                        -- upvalues: TextBox (copy), u39 (copy), getValueByIndex (ref), i (copy), updateValueByIndex (ref), u1 (ref)
                        local v43 = tonumber(TextBox.Text:match("-?%d*%.?%d*"));

                        if v43 ~= nil then
                            if u39.arguments.Min ~= nil then
                                v43 = math.max(v43, getValueByIndex(u39.arguments.Min, i, u39.arguments));
                            end;

                            if u39.arguments.Max ~= nil then
                                v43 = math.min(v43, getValueByIndex(u39.arguments.Max, i, u39.arguments));
                            end;

                            if u39.arguments.Increment then
                                local v44 = v43 / getValueByIndex(u39.arguments.Increment, i, u39.arguments);
                                v43 = math.round(v44) * getValueByIndex(u39.arguments.Increment, i, u39.arguments);
                            end;

                            u39.state.number:set(updateValueByIndex(u39.state.number.value, i, v43, u39.arguments));
                            u39.lastNumberChangedTick = u1._cycleTick + 1;
                        end;

                        local v45 = u39.arguments.Format[i] or u39.arguments.Format[1];

                        if u39.arguments.Prefix then
                            v45 = u39.arguments.Prefix[i] .. v45;
                        end;

                        TextBox.Text = string.format(v45, getValueByIndex(u39.state.number.value, i, u39.arguments));
                        u39.state.editingText:set(0);
                    end);
                    TextBox.Focused:Connect(function() -- Line: 338
                        -- upvalues: TextBox (copy), u39 (copy), i (copy)
                        TextBox.CursorPosition = #TextBox.Text + 1;
                        TextBox.SelectionStart = 1;
                        u39.state.editingText:set(i);
                    end);
                    local _ = i;
                end;

                local TextLabel = Instance.new("TextLabel");
                TextLabel.Name = "TextLabel";
                TextLabel.BackgroundTransparency = 1;
                TextLabel.BorderSizePixel = 0;
                TextLabel.LayoutOrder = 7;
                TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
                u2.applyTextStyle(TextLabel);
                TextLabel.Parent = Frame;

                return Frame;
            end,

            Update = function(p46) -- Line: 360, Name: Update
                -- upvalues: u35 (copy), u36 (copy), u21 (ref), getValueByIndex (ref), u20 (ref)
                local Instance2 = p46.Instance;
                Instance2.TextLabel.Text = p46.arguments.Text or `Input {u35}`;

                if u36 == 1 then
                    Instance2.SubButton.Visible = not p46.arguments.NoButtons;
                    Instance2.AddButton.Visible = not p46.arguments.NoButtons;
                end;

                if p46.arguments.Format and typeof(p46.arguments.Format) ~= "table" then
                    p46.arguments.Format = { p46.arguments.Format };

                    return;
                end;

                if not p46.arguments.Format then
                    local v47 = {};

                    for i = 1, u36 do
                        local v48 = u21[u35][i];

                        if p46.arguments.Increment then
                            local v49 = getValueByIndex(p46.arguments.Increment, i, p46.arguments);
                            local v50 = -math.log10(v49 == 0 and 1 or v49);
                            local math_ceil_ret = math.ceil(v50);
                            v48 = math.max(v48, math_ceil_ret, v48);
                        end;

                        if p46.arguments.Max then
                            local v51 = getValueByIndex(p46.arguments.Max, i, p46.arguments);
                            local v52 = -math.log10(v51 == 0 and 1 or v51);
                            local math_ceil_ret = math.ceil(v52);
                            v48 = math.max(v48, math_ceil_ret, v48);
                        end;

                        if p46.arguments.Min then
                            local v53 = getValueByIndex(p46.arguments.Min, i, p46.arguments);
                            local v54 = -math.log10(v53 == 0 and 1 or v53);
                            local math_ceil_ret = math.ceil(v54);
                            v48 = math.max(v48, math_ceil_ret, v48);
                        end;

                        local v55;

                        if v48 > 0 then
                            v47[i] = `%.{v48}f`;
                            v55 = i;
                        else
                            v47[i] = "%d";
                            v55 = i;
                        end;
                    end;

                    p46.arguments.Format = v47;
                    p46.arguments.Prefix = u20[u35];
                end;
            end,

            Discard = function(p56) -- Line: 405, Name: Discard
                -- upvalues: u2 (ref)
                p56.Instance:Destroy();
                u2.discardState(p56);
            end,

            GenerateState = function(p57) -- Line: 409, Name: GenerateState
                -- upvalues: u1 (ref), u37 (copy)
                if p57.state.number == nil then
                    p57.state.number = u1._widgetState(p57, "number", u37);
                end;

                if p57.state.editingText == nil then
                    p57.state.editingText = u1._widgetState(p57, "editingText", 0);
                end;
            end,

            UpdateState = function(p58) -- Line: 417, Name: UpdateState
                -- upvalues: u36 (copy), getValueByIndex (ref)
                local Instance2 = p58.Instance;

                for i = 1, u36 do
                    local v59 = Instance2:FindFirstChild("InputField" .. tostring(i));
                    local v60 = p58.arguments.Format[i] or p58.arguments.Format[1];

                    if p58.arguments.Prefix then
                        v60 = p58.arguments.Prefix[i] .. v60;
                    end;

                    v59.Text = string.format(v60, getValueByIndex(p58.state.number.value, i, p58.arguments));
                    local _ = i;
                end;
            end
        };
    end;

    local u61 = 0;
    local u62 = false;
    local u63 = nil;
    local u64 = 0;
    local u65 = "";

    local function updateActiveDrag() -- Line: 445
        -- upvalues: u2 (copy), u61 (ref), u62 (ref), u63 (ref), u65 (ref), u64 (ref), getValueByIndex (copy), u17 (copy), updateValueByIndex (copy), u1 (copy)
        local X = u2.getMouseLocation().X;
        local v66 = X - u61;
        u61 = X;

        if u62 == false then
            return;
        end;

        if u63 == nil then
            return;
        end;

        local number = u63.state.number;

        if u65 == "Color3" or u65 == "Color4" then
            number = u63.state.color;

            if u64 == 4 then
                number = u63.state.transparency;
            end;
        end;

        local v67 = (u63.arguments.Increment and getValueByIndex(u63.arguments.Increment, u64, u63.arguments) or u17[u65][u64]) * ((u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightShift)) and 10 or 1) * ((u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightAlt)) and 0.1 or 1) * ((u65 == "Color3" or u65 == "Color4") and 5 or 1);
        local v68 = getValueByIndex(number.value, u64, u63.arguments) + v66 * v67;

        if u63.arguments.Min ~= nil then
            v68 = math.max(v68, getValueByIndex(u63.arguments.Min, u64, u63.arguments));
        end;

        if u63.arguments.Max ~= nil then
            v68 = math.min(v68, getValueByIndex(u63.arguments.Max, u64, u63.arguments));
        end;

        number:set(updateValueByIndex(number.value, u64, v68, u63.arguments));
        u63.lastNumberChangedTick = u1._cycleTick + 1;
    end;

    local function DragMouseDown(p69: any, p70: any, p71: number, p72: number, p73: number) -- Line: 484
        -- upvalues: u2 (copy), u1 (copy), u62 (ref), u63 (ref), u64 (ref), u65 (ref), updateActiveDrag (copy)
        local Time = u2.getTime();
        local v74 = Time - p69.lastClickedTime < u1._config.MouseDoubleClickTime;
        local v75 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl);

        if v74 and (Vector2.new(p72, p73) - p69.lastClickedPosition).Magnitude < u1._config.MouseDoubleClickMaxDist or v75 then
            p69.state.editingText:set(p71);

            return;
        end;

        p69.lastClickedTime = Time;
        p69.lastClickedPosition = Vector2.new(p72, p73);
        u62 = true;
        u63 = p69;
        u64 = p71;
        u65 = p70;
        updateActiveDrag();
    end;

    u2.registerEvent("InputChanged", function() -- Line: 502
        -- upvalues: u1 (copy), updateActiveDrag (copy)
        if not u1._started then
            return;
        end;

        updateActiveDrag();
    end);
    u2.registerEvent("InputEnded", function(p76: userdata) -- Line: 509
        -- upvalues: u1 (copy), u62 (ref), u63 (ref), u64 (ref)
        if not u1._started then
            return;
        end;

        if p76.UserInputType == Enum.UserInputType.MouseButton1 and u62 then
            u62 = false;
            u63 = nil;
            u64 = 0;
        end;
    end);

    local function generateDragScalar(u77: any, u78: number, u79: any) -- Line: 520
        -- upvalues: u5 (copy), u2 (copy), u1 (copy), getValueByIndex (copy), updateValueByIndex (copy), DragMouseDown (copy), u21 (copy), u20 (copy)
        return {
            hasState = true,
            hasChildren = false,
            Args = {
                Text = 1,
                Increment = 2,
                Min = 3,
                Max = 4,
                Format = 5
            },
            Events = {
                numberChanged = u5,
                hovered = u2.EVENTS.hover(function(p80) -- Line: 533
                    return p80.Instance;
                end)
            },

            Generate = function(u81) -- Line: 537, Name: Generate
                -- upvalues: u77 (copy), u2 (ref), u1 (ref), u78 (copy), getValueByIndex (ref), updateValueByIndex (ref), DragMouseDown (ref)
                u81.lastClickedTime = -1;
                u81.lastClickedPosition = Vector2.zero;
                local Frame = Instance.new("Frame");
                Frame.Name = "Iris_Drag" .. u77;
                Frame.Size = UDim2.fromScale(1, 0);
                Frame.BackgroundTransparency = 1;
                Frame.BorderSizePixel = 0;
                Frame.LayoutOrder = u81.ZIndex;
                Frame.AutomaticSize = Enum.AutomaticSize.Y;
                u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local v82 = 0;
                local v83 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;

                if u77 == "Color3" or u77 == "Color4" then
                    v82 = v82 + (u1._config.ItemInnerSpacing.X + v83);
                    local ImageLabel = Instance.new("ImageLabel");
                    ImageLabel.Name = "ColorBox";
                    ImageLabel.BorderSizePixel = 0;
                    ImageLabel.Size = UDim2.fromOffset(v83, v83);
                    ImageLabel.LayoutOrder = 5;
                    ImageLabel.Image = u2.ICONS.ALPHA_BACKGROUND_TEXTURE;
                    ImageLabel.ImageTransparency = 1;
                    u2.applyFrameStyle(ImageLabel, true);
                    ImageLabel.Parent = Frame;
                end;

                local UDim_new_ret = UDim.new(u1._config.ContentWidth.Scale / u78, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u78 - 1) - v82) / u78);
                local UDim_new_ret2 = UDim.new(UDim_new_ret.Scale * (u78 - 1), UDim_new_ret.Offset * (u78 - 1) + u1._config.ItemInnerSpacing.X * (u78 - 1) + v82);
                local v84 = u1._config.ContentWidth - UDim_new_ret2;

                for i = 1, u78 do
                    local TextButton = Instance.new("TextButton");
                    TextButton.Name = "DragField" .. tostring(i);
                    TextButton.LayoutOrder = i;

                    if i == u78 then
                        TextButton.Size = UDim2.new(v84, u1._config.ContentHeight);
                    else
                        TextButton.Size = UDim2.new(UDim_new_ret, u1._config.ContentHeight);
                    end;

                    TextButton.AutomaticSize = Enum.AutomaticSize.Y;
                    TextButton.BackgroundColor3 = u1._config.FrameBgColor;
                    TextButton.BackgroundTransparency = u1._config.FrameBgTransparency;
                    TextButton.AutoButtonColor = false;
                    TextButton.Text = "";
                    TextButton.ClipsDescendants = true;
                    u2.applyFrameStyle(TextButton);
                    u2.applyTextStyle(TextButton);
                    u2.UISizeConstraint(TextButton, Vector2.new(1, 0));
                    TextButton.TextXAlignment = Enum.TextXAlignment.Center;
                    TextButton.Parent = Frame;
                    u2.applyInteractionHighlights(u81, TextButton, TextButton, {
                        ButtonColor = u1._config.FrameBgColor,
                        ButtonTransparency = u1._config.FrameBgTransparency,
                        ButtonHoveredColor = u1._config.FrameBgHoveredColor,
                        ButtonHoveredTransparency = u1._config.FrameBgHoveredTransparency,
                        ButtonActiveColor = u1._config.FrameBgActiveColor,
                        ButtonActiveTransparency = u1._config.FrameBgActiveTransparency
                    });
                    local TextBox = Instance.new("TextBox");
                    TextBox.Name = "InputField";
                    TextBox.Size = UDim2.new(1, 0, 1, 0);
                    TextBox.BackgroundTransparency = 1;
                    TextBox.ClearTextOnFocus = false;
                    TextBox.TextTruncate = Enum.TextTruncate.AtEnd;
                    TextBox.ClipsDescendants = true;
                    TextBox.Visible = false;
                    u2.applyFrameStyle(TextBox, true);
                    u2.applyTextStyle(TextBox);
                    TextBox.Parent = TextButton;
                    TextBox.FocusLost:Connect(function() -- Line: 625
                        -- upvalues: TextBox (copy), u81 (copy), u77 (ref), i (copy), getValueByIndex (ref), updateValueByIndex (ref), u1 (ref)
                        local v85 = tonumber(TextBox.Text:match("-?%d*%.?%d*"));
                        local number = u81.state.number;

                        if u77 == "Color4" and i == 4 then
                            number = u81.state.transparency;
                        elseif u77 == "Color3" or u77 == "Color4" then
                            number = u81.state.color;
                        end;

                        if v85 ~= nil then
                            if u77 == "Color3" or u77 == "Color4" and not u81.arguments.UseFloats then
                                v85 = v85 / 255;
                            end;

                            if u81.arguments.Min ~= nil then
                                v85 = math.max(v85, getValueByIndex(u81.arguments.Min, i, u81.arguments));
                            end;

                            if u81.arguments.Max ~= nil then
                                v85 = math.min(v85, getValueByIndex(u81.arguments.Max, i, u81.arguments));
                            end;

                            if u81.arguments.Increment then
                                local v86 = v85 / getValueByIndex(u81.arguments.Increment, i, u81.arguments);
                                v85 = math.round(v86) * getValueByIndex(u81.arguments.Increment, i, u81.arguments);
                            end;

                            number:set(updateValueByIndex(number.value, i, v85, u81.arguments));
                            u81.lastNumberChangedTick = u1._cycleTick + 1;
                        end;

                        local v87 = getValueByIndex(number.value, i, u81.arguments);

                        if u77 == "Color3" or u77 == "Color4" and not u81.arguments.UseFloats then
                            v87 = math.round(v87 * 255);
                        end;

                        local v88 = u81.arguments.Format[i] or u81.arguments.Format[1];

                        if u81.arguments.Prefix then
                            v88 = u81.arguments.Prefix[i] .. v88;
                        end;

                        TextBox.Text = string.format(v88, v87);
                        u81.state.editingText:set(0);
                        TextBox:ReleaseFocus(true);
                    end);
                    TextBox.Focused:Connect(function() -- Line: 667
                        -- upvalues: TextBox (copy), u81 (copy), i (copy)
                        TextBox.CursorPosition = #TextBox.Text + 1;
                        TextBox.SelectionStart = 1;
                        u81.state.editingText:set(i);
                    end);
                    u2.applyButtonDown(u81, TextButton, function(p89: number, p90: number) -- Line: 675
                        -- upvalues: DragMouseDown (ref), u81 (copy), u77 (ref), i (copy)
                        DragMouseDown(u81, u77, i, p89, p90);
                    end);
                    local _ = i;
                end;

                local TextLabel = Instance.new("TextLabel");
                TextLabel.Name = "TextLabel";
                TextLabel.BackgroundTransparency = 1;
                TextLabel.BorderSizePixel = 0;
                TextLabel.LayoutOrder = 6;
                TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
                u2.applyTextStyle(TextLabel);
                TextLabel.Parent = Frame;

                return Frame;
            end,

            Update = function(p91) -- Line: 693, Name: Update
                -- upvalues: u77 (copy), u78 (copy), u21 (ref), getValueByIndex (ref), u20 (ref)
                p91.Instance.TextLabel.Text = p91.arguments.Text or `Drag {u77}`;

                if p91.arguments.Format and typeof(p91.arguments.Format) ~= "table" then
                    p91.arguments.Format = { p91.arguments.Format };

                    return;
                end;

                if not p91.arguments.Format then
                    local v92 = {};

                    for i = 1, u78 do
                        local v93 = u21[u77][i];

                        if p91.arguments.Increment then
                            local v94 = getValueByIndex(p91.arguments.Increment, i, p91.arguments);
                            local v95 = -math.log10(v94 == 0 and 1 or v94);
                            local math_ceil_ret = math.ceil(v95);
                            v93 = math.max(v93, math_ceil_ret, v93);
                        end;

                        if p91.arguments.Max then
                            local v96 = getValueByIndex(p91.arguments.Max, i, p91.arguments);
                            local v97 = -math.log10(v96 == 0 and 1 or v96);
                            local math_ceil_ret = math.ceil(v97);
                            v93 = math.max(v93, math_ceil_ret, v93);
                        end;

                        if p91.arguments.Min then
                            local v98 = getValueByIndex(p91.arguments.Min, i, p91.arguments);
                            local v99 = -math.log10(v98 == 0 and 1 or v98);
                            local math_ceil_ret = math.ceil(v99);
                            v93 = math.max(v93, math_ceil_ret, v93);
                        end;

                        local v100;

                        if v93 > 0 then
                            v92[i] = `%.{v93}f`;
                            v100 = i;
                        else
                            v92[i] = "%d";
                            v100 = i;
                        end;
                    end;

                    p91.arguments.Format = v92;
                    p91.arguments.Prefix = u20[u77];
                end;
            end,

            Discard = function(p101) -- Line: 733, Name: Discard
                -- upvalues: u2 (ref)
                p101.Instance:Destroy();
                u2.discardState(p101);
            end,

            GenerateState = function(p102) -- Line: 737, Name: GenerateState
                -- upvalues: u1 (ref), u79 (copy)
                if p102.state.number == nil then
                    p102.state.number = u1._widgetState(p102, "number", u79);
                end;

                if p102.state.editingText == nil then
                    p102.state.editingText = u1._widgetState(p102, "editingText", false);
                end;
            end,

            UpdateState = function(p103) -- Line: 745, Name: UpdateState
                -- upvalues: u78 (copy), u77 (copy), getValueByIndex (ref), u1 (ref)
                local Instance2 = p103.Instance;

                for i = 1, u78 do
                    local number = p103.state.number;

                    if u77 == "Color3" or u77 == "Color4" then
                        number = p103.state.color;

                        if i == 4 then
                            number = p103.state.transparency;
                        end;
                    end;

                    local v104 = Instance2:FindFirstChild("DragField" .. tostring(i));
                    local InputField = v104.InputField;
                    local v105 = getValueByIndex(number.value, i, p103.arguments);

                    if (u77 == "Color3" or u77 == "Color4") and not p103.arguments.UseFloats then
                        v105 = math.round(v105 * 255);
                    end;

                    local v106 = p103.arguments.Format[i] or p103.arguments.Format[1];

                    if p103.arguments.Prefix then
                        v106 = p103.arguments.Prefix[i] .. v106;
                    end;

                    v104.Text = string.format(v106, v105);
                    InputField.Text = tostring(v105);
                    local v107;

                    if p103.state.editingText.value == i then
                        InputField.Visible = true;
                        InputField:CaptureFocus();
                        v104.TextTransparency = 1;
                        v107 = i;
                    else
                        InputField.Visible = false;
                        v104.TextTransparency = u1._config.TextTransparency;
                        v107 = i;
                    end;
                end;

                if u77 == "Color3" or u77 == "Color4" then
                    local ColorBox = Instance2.ColorBox;
                    ColorBox.BackgroundColor3 = p103.state.color.value;

                    if u77 == "Color4" then
                        ColorBox.ImageTransparency = 1 - p103.state.transparency.value;
                    end;
                end;
            end
        };
    end;

    local function generateColorDragScalar(u108, ...) -- Line: 793
        -- upvalues: generateDragScalar (ref), u2 (copy), u20 (copy), u1 (copy)
        local u109 = { ... };
        local v110 = generateDragScalar(u108, u108 == "Color4" and 4 or 3, u109[1]);

        return u2.extend(v110, {
            Args = {
                Text = 1,
                UseFloats = 2,
                UseHSV = 3,
                Format = 4
            },

            Update = function(p111) -- Line: 804, Name: Update
                -- upvalues: u108 (copy), u20 (ref), u1 (ref)
                p111.Instance.TextLabel.Text = p111.arguments.Text or `Drag {u108}`;

                if p111.arguments.Format and typeof(p111.arguments.Format) ~= "table" then
                    p111.arguments.Format = { p111.arguments.Format };
                elseif not p111.arguments.Format then
                    if p111.arguments.UseFloats then
                        p111.arguments.Format = { "%.3f" };
                    else
                        p111.arguments.Format = { "%d" };
                    end;

                    p111.arguments.Prefix = u20[u108 .. (p111.arguments.UseHSV and "_HSV" or "_RGB")];
                end;

                p111.arguments.Min = { 0, 0, 0, 0 };
                p111.arguments.Max = { 1, 1, 1, 1 };
                p111.arguments.Increment = { 0.001, 0.001, 0.001, 0.001 };

                if p111.state then
                    u1._widgets[p111.type].UpdateState(p111);
                end;
            end,

            GenerateState = function(p112) -- Line: 831, Name: GenerateState
                -- upvalues: u1 (ref), u109 (copy), u108 (copy)
                if p112.state.color == nil then
                    p112.state.color = u1._widgetState(p112, "color", u109[1]);
                end;

                if u108 == "Color4" and p112.state.transparency == nil then
                    p112.state.transparency = u1._widgetState(p112, "transparency", u109[2]);
                end;

                if p112.state.editingText == nil then
                    p112.state.editingText = u1._widgetState(p112, "editingText", false);
                end;
            end
        });
    end;

    local u113 = false;
    local u114 = nil;
    local u115 = 0;
    local u116 = "";

    local function updateActiveSlider() -- Line: 859
        -- upvalues: u113 (ref), u114 (ref), u115 (ref), getValueByIndex (copy), u17 (copy), u116 (ref), u18 (copy), u19 (copy), u2 (copy), updateValueByIndex (copy), u1 (copy)
        if u113 == false then
            return;
        end;

        if u114 == nil then
            return;
        end;

        local v117 = u114.Instance:FindFirstChild("SliderField" .. tostring(u115));
        local GrabBar = v117.GrabBar;
        local v118 = u114.arguments.Increment and getValueByIndex(u114.arguments.Increment, u115, u114.arguments) or u17[u116][u115];
        local v119 = u114.arguments.Min and getValueByIndex(u114.arguments.Min, u115, u114.arguments) or u18[u116][u115];
        local v120 = u114.arguments.Max and getValueByIndex(u114.arguments.Max, u115, u114.arguments) or u19[u116][u115];
        local X = GrabBar.AbsoluteSize.X;
        local v121 = (u2.getMouseLocation().X - (v117.AbsolutePosition.X - u2.GuiOffset.X + X / 2)) / (v117.AbsoluteSize.X - X) * math.floor((v120 - v119) / v118);
        local v122 = math.round(v121) * v118 + v119;
        local math_clamp_ret = math.clamp(v122, v119, v120);
        u114.state.number:set(updateValueByIndex(u114.state.number.value, u115, math_clamp_ret, u114.arguments));
        u114.lastNumberChangedTick = u1._cycleTick + 1;
    end;

    local function SliderMouseDown(p123: any, p124: any, p125: number) -- Line: 885
        -- upvalues: u2 (copy), u113 (ref), u114 (ref), u115 (ref), u116 (ref), updateActiveSlider (copy)
        if u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
            p123.state.editingText:set(p125);

            return;
        end;

        u113 = true;
        u114 = p123;
        u115 = p125;
        u116 = p124;
        updateActiveSlider();
    end;

    u2.registerEvent("InputChanged", function() -- Line: 898
        -- upvalues: u1 (copy), updateActiveSlider (copy)
        if not u1._started then
            return;
        end;

        updateActiveSlider();
    end);
    u2.registerEvent("InputEnded", function(p126: userdata) -- Line: 905
        -- upvalues: u1 (copy), u113 (ref), u114 (ref), u115 (ref), u116 (ref)
        if not u1._started then
            return;
        end;

        if p126.UserInputType == Enum.UserInputType.MouseButton1 and u113 then
            u113 = false;
            u114 = nil;
            u115 = 0;
            u116 = "";
        end;
    end);

    local function generateSliderScalar(u127: any, u128: number, u129: any) -- Line: 917
        -- upvalues: u5 (copy), u2 (copy), u1 (copy), getValueByIndex (copy), updateValueByIndex (copy), SliderMouseDown (copy), u21 (copy), u20 (copy), u17 (copy), u18 (copy), u19 (copy)
        return {
            hasState = true,
            hasChildren = false,
            Args = {
                Text = 1,
                Increment = 2,
                Min = 3,
                Max = 4,
                Format = 5
            },
            Events = {
                numberChanged = u5,
                hovered = u2.EVENTS.hover(function(p130) -- Line: 930
                    return p130.Instance;
                end)
            },

            Generate = function(u131) -- Line: 934, Name: Generate
                -- upvalues: u127 (copy), u2 (ref), u1 (ref), u128 (copy), getValueByIndex (ref), updateValueByIndex (ref), SliderMouseDown (ref)
                local Frame = Instance.new("Frame");
                Frame.Name = "Iris_Slider" .. u127;
                Frame.Size = UDim2.fromScale(1, 0);
                Frame.BackgroundTransparency = 1;
                Frame.BorderSizePixel = 0;
                Frame.LayoutOrder = u131.ZIndex;
                Frame.AutomaticSize = Enum.AutomaticSize.Y;
                u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local UDim_new_ret = UDim.new(u1._config.ContentWidth.Scale / u128, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u128 - 1)) / u128);
                local UDim_new_ret2 = UDim.new(UDim_new_ret.Scale * (u128 - 1), UDim_new_ret.Offset * (u128 - 1) + u1._config.ItemInnerSpacing.X * (u128 - 1));
                local v132 = u1._config.ContentWidth - UDim_new_ret2;

                for i = 1, u128 do
                    local TextButton = Instance.new("TextButton");
                    TextButton.Name = "SliderField" .. tostring(i);
                    TextButton.LayoutOrder = i;

                    if i == u128 then
                        TextButton.Size = UDim2.new(v132, u1._config.ContentHeight);
                    else
                        TextButton.Size = UDim2.new(UDim_new_ret, u1._config.ContentHeight);
                    end;

                    TextButton.AutomaticSize = Enum.AutomaticSize.Y;
                    TextButton.BackgroundColor3 = u1._config.FrameBgColor;
                    TextButton.BackgroundTransparency = u1._config.FrameBgTransparency;
                    TextButton.AutoButtonColor = false;
                    TextButton.Text = "";
                    TextButton.ClipsDescendants = true;
                    u2.applyFrameStyle(TextButton);
                    u2.applyTextStyle(TextButton);
                    u2.UISizeConstraint(TextButton, Vector2.new(1, 0));
                    TextButton.Parent = Frame;
                    local TextLabel = Instance.new("TextLabel");
                    TextLabel.Name = "OverlayText";
                    TextLabel.Size = UDim2.fromScale(1, 1);
                    TextLabel.BackgroundTransparency = 1;
                    TextLabel.BorderSizePixel = 0;
                    TextLabel.ZIndex = 10;
                    TextLabel.ClipsDescendants = true;
                    u2.applyTextStyle(TextLabel);
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
                    TextLabel.Parent = TextButton;
                    u2.applyInteractionHighlights(u131, TextButton, TextButton, {
                        ButtonColor = u1._config.FrameBgColor,
                        ButtonTransparency = u1._config.FrameBgTransparency,
                        ButtonHoveredColor = u1._config.FrameBgHoveredColor,
                        ButtonHoveredTransparency = u1._config.FrameBgHoveredTransparency,
                        ButtonActiveColor = u1._config.FrameBgActiveColor,
                        ButtonActiveTransparency = u1._config.FrameBgActiveTransparency
                    });
                    local TextBox = Instance.new("TextBox");
                    TextBox.Name = "InputField";
                    TextBox.Size = UDim2.new(1, 0, 1, 0);
                    TextBox.BackgroundTransparency = 1;
                    TextBox.ClearTextOnFocus = false;
                    TextBox.TextTruncate = Enum.TextTruncate.AtEnd;
                    TextBox.ClipsDescendants = true;
                    TextBox.Visible = false;
                    u2.applyFrameStyle(TextBox, true);
                    u2.applyTextStyle(TextBox);
                    TextBox.Parent = TextButton;
                    TextBox.FocusLost:Connect(function() -- Line: 1011
                        -- upvalues: TextBox (copy), u131 (copy), getValueByIndex (ref), i (copy), updateValueByIndex (ref), u1 (ref)
                        local v133 = tonumber(TextBox.Text:match("-?%d*%.?%d*"));

                        if v133 ~= nil then
                            if u131.arguments.Min ~= nil then
                                v133 = math.max(v133, getValueByIndex(u131.arguments.Min, i, u131.arguments));
                            end;

                            if u131.arguments.Max ~= nil then
                                v133 = math.min(v133, getValueByIndex(u131.arguments.Max, i, u131.arguments));
                            end;

                            if u131.arguments.Increment then
                                local v134 = v133 / getValueByIndex(u131.arguments.Increment, i, u131.arguments);
                                v133 = math.round(v134) * getValueByIndex(u131.arguments.Increment, i, u131.arguments);
                            end;

                            u131.state.number:set(updateValueByIndex(u131.state.number.value, i, v133, u131.arguments));
                            u131.lastNumberChangedTick = u1._cycleTick + 1;
                        end;

                        local v135 = u131.arguments.Format[i] or u131.arguments.Format[1];

                        if u131.arguments.Prefix then
                            v135 = u131.arguments.Prefix[i] .. v135;
                        end;

                        TextBox.Text = string.format(v135, getValueByIndex(u131.state.number.value, i, u131.arguments));
                        u131.state.editingText:set(0);
                        TextBox:ReleaseFocus(true);
                    end);
                    TextBox.Focused:Connect(function() -- Line: 1040
                        -- upvalues: TextBox (copy), u131 (copy), i (copy)
                        TextBox.CursorPosition = #TextBox.Text + 1;
                        TextBox.SelectionStart = 1;
                        u131.state.editingText:set(i);
                    end);
                    u2.applyButtonDown(u131, TextButton, function() -- Line: 1048
                        -- upvalues: SliderMouseDown (ref), u131 (copy), u127 (ref), i (copy)
                        SliderMouseDown(u131, u127, i);
                    end);
                    local Frame2 = Instance.new("Frame");
                    Frame2.Name = "GrabBar";
                    Frame2.ZIndex = 5;
                    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
                    Frame2.Position = UDim2.new(0, 0, 0.5, 0);
                    Frame2.BorderSizePixel = 0;
                    Frame2.BackgroundColor3 = u1._config.SliderGrabColor;
                    Frame2.Transparency = u1._config.SliderGrabTransparency;

                    if u1._config.GrabRounding > 0 then
                        u2.UICorner(Frame2, u1._config.GrabRounding);
                    end;

                    u2.UISizeConstraint(Frame2, Vector2.new(u1._config.GrabMinSize, 0));
                    Frame2.Parent = TextButton;
                    local _ = i;
                end;

                local TextLabel = Instance.new("TextLabel");
                TextLabel.Name = "TextLabel";
                TextLabel.BackgroundTransparency = 1;
                TextLabel.BorderSizePixel = 0;
                TextLabel.LayoutOrder = 5;
                TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
                u2.applyTextStyle(TextLabel);
                TextLabel.Parent = Frame;

                return Frame;
            end,

            Update = function(u136) -- Line: 1082, Name: Update
                -- upvalues: u127 (copy), u128 (copy), u21 (ref), getValueByIndex (ref), u20 (ref), u17 (ref), u18 (ref), u19 (ref), u1 (ref)
                local Instance2 = u136.Instance;
                Instance2.TextLabel.Text = u136.arguments.Text or `Slider {u127}`;

                if u136.arguments.Format and typeof(u136.arguments.Format) ~= "table" then
                    u136.arguments.Format = { u136.arguments.Format };
                elseif not u136.arguments.Format then
                    local v137 = {};

                    for i = 1, u128 do
                        local v138 = u21[u127][i];

                        if u136.arguments.Increment then
                            local v139 = getValueByIndex(u136.arguments.Increment, i, u136.arguments);
                            local v140 = -math.log10(v139 == 0 and 1 or v139);
                            local math_ceil_ret = math.ceil(v140);
                            v138 = math.max(v138, math_ceil_ret, v138);
                        end;

                        if u136.arguments.Max then
                            local v141 = getValueByIndex(u136.arguments.Max, i, u136.arguments);
                            local v142 = -math.log10(v141 == 0 and 1 or v141);
                            local math_ceil_ret = math.ceil(v142);
                            v138 = math.max(v138, math_ceil_ret, v138);
                        end;

                        if u136.arguments.Min then
                            local v143 = getValueByIndex(u136.arguments.Min, i, u136.arguments);
                            local v144 = -math.log10(v143 == 0 and 1 or v143);
                            local math_ceil_ret = math.ceil(v144);
                            v138 = math.max(v138, math_ceil_ret, v138);
                        end;

                        local v145;

                        if v138 > 0 then
                            v137[i] = `%.{v138}f`;
                            v145 = i;
                        else
                            v137[i] = "%d";
                            v145 = i;
                        end;
                    end;

                    u136.arguments.Format = v137;
                    u136.arguments.Prefix = u20[u127];
                end;

                for i = 1, u128 do
                    local GrabBar = Instance2:FindFirstChild("SliderField" .. tostring(i)).GrabBar;
                    local v146 = u136.arguments.Increment and getValueByIndex(u136.arguments.Increment, i, u136.arguments) or u17[u127][i];
                    local v147 = u136.arguments.Min and getValueByIndex(u136.arguments.Min, i, u136.arguments) or u18[u127][i];
                    local v148 = u136.arguments.Max and getValueByIndex(u136.arguments.Max, i, u136.arguments) or u19[u127][i];
                    local v149 = 1 / math.floor((v148 + 1 - v147) / v146);
                    GrabBar.Size = UDim2.new(v149, 0, 1, 0);
                    local _ = i;
                end;

                local u150 = #u1._postCycleCallbacks + 1;
                local u151 = u1._cycleTick + 1;

                u1._postCycleCallbacks[u150] = function() -- Line: 1137
                    -- upvalues: u1 (ref), u151 (copy), u136 (copy), u127 (ref), u150 (copy)
                    if u151 <= u1._cycleTick then
                        if u136.lastCycleTick ~= -1 then
                            u1._widgets[`Slider{u127}`].UpdateState(u136);
                        end;

                        u1._postCycleCallbacks[u150] = nil;
                    end;
                end;
            end,

            Discard = function(p152) -- Line: 1146, Name: Discard
                -- upvalues: u2 (ref)
                p152.Instance:Destroy();
                u2.discardState(p152);
            end,

            GenerateState = function(p153) -- Line: 1150, Name: GenerateState
                -- upvalues: u1 (ref), u129 (copy)
                if p153.state.number == nil then
                    p153.state.number = u1._widgetState(p153, "number", u129);
                end;

                if p153.state.editingText == nil then
                    p153.state.editingText = u1._widgetState(p153, "editingText", false);
                end;
            end,

            UpdateState = function(p154) -- Line: 1158, Name: UpdateState
                -- upvalues: u128 (copy), getValueByIndex (ref), u17 (ref), u127 (copy), u18 (ref), u19 (ref)
                local Instance2 = p154.Instance;

                for i = 1, u128 do
                    local v155 = Instance2:FindFirstChild("SliderField" .. tostring(i));
                    local InputField = v155.InputField;
                    local OverlayText = v155.OverlayText;
                    local GrabBar = v155.GrabBar;
                    local v156 = getValueByIndex(p154.state.number.value, i, p154.arguments);
                    local v157 = p154.arguments.Format[i] or p154.arguments.Format[1];

                    if p154.arguments.Prefix then
                        v157 = p154.arguments.Prefix[i] .. v157;
                    end;

                    OverlayText.Text = string.format(v157, v156);
                    InputField.Text = tostring(v156);
                    local v158 = p154.arguments.Increment and getValueByIndex(p154.arguments.Increment, i, p154.arguments) or u17[u127][i];
                    local v159 = p154.arguments.Min and getValueByIndex(p154.arguments.Min, i, p154.arguments) or u18[u127][i];
                    local v160 = p154.arguments.Max and getValueByIndex(p154.arguments.Max, i, p154.arguments) or u19[u127][i];
                    local X = v155.AbsoluteSize.X;
                    local v161 = X - GrabBar.AbsoluteSize.X;
                    local math_floor_ret = math.floor((v160 - v159) / v158);
                    local v162 = math.floor((v156 - v159) / (v160 - v159) * math_floor_ret) / math_floor_ret;
                    local math_clamp_ret = math.clamp(v162, 0, 1);
                    GrabBar.Position = UDim2.new(v161 / X * math_clamp_ret + (1 - v161 / X) / 2, 0, 0.5, 0);
                    local v163;

                    if p154.state.editingText.value == i then
                        InputField.Visible = true;
                        OverlayText.Visible = false;
                        GrabBar.Visible = false;
                        InputField:CaptureFocus();
                        v163 = i;
                    else
                        InputField.Visible = false;
                        OverlayText.Visible = true;
                        GrabBar.Visible = true;
                        v163 = i;
                    end;
                end;
            end
        };
    end;

    local function generateEnumSliderScalar(u164: userdata, u165: userdata) -- Line: 1204
        -- upvalues: generateSliderScalar (ref), u2 (copy), u1 (copy)
        local v166 = generateSliderScalar("Enum", 1, u165.Value);
        local v167 = { string };

        for _, v in u164:GetEnumItems() do
            v167[v.Value] = v.Name;
        end;

        return u2.extend(v166, {
            Args = {
                Text = 1
            },

            Update = function(p168) -- Line: 1216, Name: Update
                -- upvalues: u164 (copy)
                local Instance2 = p168.Instance;
                Instance2.TextLabel.Text = p168.arguments.Text or "Input Enum";
                p168.arguments.Increment = 1;
                p168.arguments.Min = 0;
                p168.arguments.Max = #u164:GetEnumItems() - 1;
                local GrabBar = Instance2:FindFirstChild("SliderField1").GrabBar;
                local v169 = #u164:GetEnumItems();
                local v170 = 1 / math.floor(v169);
                GrabBar.Size = UDim2.new(v170, 0, 1, 0);
            end,

            GenerateState = function(p171) -- Line: 1232, Name: GenerateState
                -- upvalues: u1 (ref), u165 (copy)
                if p171.state.number == nil then
                    p171.state.number = u1._widgetState(p171, "number", u165.Value);
                end;

                if p171.state.enumItem == nil then
                    p171.state.enumItem = u1._widgetState(p171, "enumItem", u165);
                end;

                if p171.state.editingText == nil then
                    p171.state.editingText = u1._widgetState(p171, "editingText", false);
                end;
            end
        });
    end;

    local v172 = generateInputScalar("Num", 1, 0);
    v172.Args.NoButtons = 6;
    u1.WidgetConstructor("InputNum", v172);
    u1.WidgetConstructor("InputVector2", generateInputScalar("Vector2", 2, Vector2.zero));
    u1.WidgetConstructor("InputVector3", generateInputScalar("Vector3", 3, Vector3.new(0, 0, 0)));
    u1.WidgetConstructor("InputUDim", generateInputScalar("UDim", 2, UDim.new()));
    u1.WidgetConstructor("InputUDim2", generateInputScalar("UDim2", 4, UDim2.new()));
    u1.WidgetConstructor("InputRect", generateInputScalar("Rect", 4, Rect.new(0, 0, 0, 0)));
    u1.WidgetConstructor("DragNum", generateDragScalar("Num", 1, 0));
    u1.WidgetConstructor("DragVector2", generateDragScalar("Vector2", 2, Vector2.zero));
    u1.WidgetConstructor("DragVector3", generateDragScalar("Vector3", 3, Vector3.new(0, 0, 0)));
    u1.WidgetConstructor("DragUDim", generateDragScalar("UDim", 2, UDim.new()));
    u1.WidgetConstructor("DragUDim2", generateDragScalar("UDim2", 4, UDim2.new()));
    u1.WidgetConstructor("DragRect", generateDragScalar("Rect", 4, Rect.new(0, 0, 0, 0)));
    u1.WidgetConstructor("InputColor3", generateColorDragScalar("Color3", Color3.fromRGB(0, 0, 0)));
    u1.WidgetConstructor("InputColor4", generateColorDragScalar("Color4", Color3.fromRGB(0, 0, 0), 0));
    u1.WidgetConstructor("SliderNum", generateSliderScalar("Num", 1, 0));
    u1.WidgetConstructor("SliderVector2", generateSliderScalar("Vector2", 2, Vector2.zero));
    u1.WidgetConstructor("SliderVector3", generateSliderScalar("Vector3", 3, Vector3.new(0, 0, 0)));
    u1.WidgetConstructor("SliderUDim", generateSliderScalar("UDim", 2, UDim.new()));
    u1.WidgetConstructor("SliderUDim2", generateSliderScalar("UDim2", 4, UDim2.new()));
    u1.WidgetConstructor("SliderRect", generateSliderScalar("Rect", 4, Rect.new(0, 0, 0, 0)));
    u1.WidgetConstructor("InputText", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            TextHint = 2,
            ReadOnly = 3,
            MultiLine = 4
        },
        Events = {
            textChanged = {
                Init = function(p173) -- Line: 1288
                    p173.lastTextchangeTick = 0;
                end,

                Get = function(p174) -- Line: 1291
                    -- upvalues: u1 (copy)
                    return p174.lastTextchangeTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p175) -- Line: 1295
                return p175.Instance;
            end)
        },

        Generate = function(u176) -- Line: 1299, Name: Generate
            -- upvalues: u2 (copy), u1 (copy)
            local Frame = Instance.new("Frame");
            Frame.Name = "Iris_InputText";
            Frame.AutomaticSize = Enum.AutomaticSize.Y;
            Frame.Size = UDim2.fromScale(1, 0);
            Frame.BackgroundTransparency = 1;
            Frame.BorderSizePixel = 0;
            Frame.ZIndex = u176.ZIndex;
            Frame.LayoutOrder = u176.ZIndex;
            u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local TextBox = Instance.new("TextBox");
            TextBox.Name = "InputField";
            TextBox.Size = UDim2.new(u1._config.ContentWidth, u1._config.ContentHeight);
            TextBox.AutomaticSize = Enum.AutomaticSize.Y;
            TextBox.BackgroundColor3 = u1._config.FrameBgColor;
            TextBox.BackgroundTransparency = u1._config.FrameBgTransparency;
            TextBox.Text = "";
            TextBox.TextYAlignment = Enum.TextYAlignment.Top;
            TextBox.PlaceholderColor3 = u1._config.TextDisabledColor;
            TextBox.ClearTextOnFocus = false;
            TextBox.ClipsDescendants = true;
            u2.applyFrameStyle(TextBox);
            u2.applyTextStyle(TextBox);
            u2.UISizeConstraint(TextBox, Vector2.new(1, 0));
            TextBox.Parent = Frame;
            TextBox.FocusLost:Connect(function() -- Line: 1330
                -- upvalues: u176 (copy), TextBox (copy), u1 (ref)
                u176.state.text:set(TextBox.Text);
                u176.lastTextchangeTick = u1._cycleTick + 1;
            end);
            local v177 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "TextLabel";
            TextLabel.Size = UDim2.fromOffset(0, v177);
            TextLabel.AutomaticSize = Enum.AutomaticSize.X;
            TextLabel.BackgroundTransparency = 1;
            TextLabel.BorderSizePixel = 0;
            TextLabel.LayoutOrder = 1;
            u2.applyTextStyle(TextLabel);
            TextLabel.Parent = Frame;

            return Frame;
        end,

        Update = function(p178) -- Line: 1351, Name: Update
            local Instance2 = p178.Instance;
            local InputField = Instance2.InputField;
            Instance2.TextLabel.Text = p178.arguments.Text or "Input Text";
            InputField.PlaceholderText = p178.arguments.TextHint or "";
            InputField.TextEditable = not p178.arguments.ReadOnly;
            InputField.MultiLine = p178.arguments.MultiLine;
        end,

        Discard = function(p179) -- Line: 1361, Name: Discard
            -- upvalues: u2 (copy)
            p179.Instance:Destroy();
            u2.discardState(p179);
        end,

        GenerateState = function(p180) -- Line: 1365, Name: GenerateState
            -- upvalues: u1 (copy)
            if p180.state.text == nil then
                p180.state.text = u1._widgetState(p180, "text", "");
            end;
        end,

        UpdateState = function(p181) -- Line: 1370, Name: UpdateState
            p181.Instance.InputField.Text = p181.state.text.value;
        end
    });
end;