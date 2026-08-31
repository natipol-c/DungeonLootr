--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Widget
  Path:     game.StarterPlayer.StarterPlayerScripts.Satchel.Satchel.Packages._Index.legitatx_topbarplus@3.0.5.topbarplus.Elements.Widget
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

return function(u1, u2) -- Line: 6
    local Frame = Instance.new("Frame");
    Frame:SetAttribute("WidgetUID", u1.UID);
    Frame.Name = "Widget";
    Frame.BackgroundTransparency = 1;
    Frame.Visible = true;
    Frame.ZIndex = 20;
    Frame.Active = false;
    Frame.ClipsDescendants = true;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "IconButton";
    Frame2.Visible = true;
    Frame2.ZIndex = 2;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    Frame2.ClipsDescendants = true;
    Frame2.Active = false;
    u1.deselected:Connect(function() -- Line: 25
        -- upvalues: Frame2 (copy)
        Frame2.ClipsDescendants = true;
    end);
    u1.selected:Connect(function() -- Line: 28
        -- upvalues: u1 (copy), Frame2 (copy)
        task.defer(function() -- Line: 29
            -- upvalues: u1 (ref), Frame2 (ref)
            u1.resizingComplete:Once(function() -- Line: 30
                -- upvalues: u1 (ref), Frame2 (ref)
                if u1.isSelected then
                    Frame2.ClipsDescendants = false;
                end;
            end);
        end);
    end);
    local UICorner = Instance.new("UICorner");
    UICorner:SetAttribute("Collective", "IconCorners");
    UICorner.Parent = Frame2;
    local u3 = require(script.Parent.Menu)(u1);
    local MenuUIListLayout = u3.MenuUIListLayout;
    local MenuGap = u3.MenuGap;
    u3.Parent = Frame2;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "IconSpot";
    Frame3.BackgroundColor3 = Color3.fromRGB(225, 225, 225);
    Frame3.BackgroundTransparency = 0.9;
    Frame3.Visible = true;
    Frame3.AnchorPoint = Vector2.new(0, 0.5);
    Frame3.ZIndex = 5;
    Frame3.Parent = u3;
    UICorner:Clone().Parent = Frame3;
    local v4 = Frame3:Clone();
    v4.Name = "IconOverlay";
    v4.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    v4.ZIndex = Frame3.ZIndex + 1;
    v4.Size = UDim2.new(1, 0, 1, 0);
    v4.Position = UDim2.new(0, 0, 0, 0);
    v4.AnchorPoint = Vector2.new(0, 0);
    v4.Visible = false;
    v4.Parent = Frame3;
    local TextButton = Instance.new("TextButton");
    TextButton:SetAttribute("CorrespondingIconUID", u1.UID);
    TextButton.Name = "ClickRegion";
    TextButton.BackgroundTransparency = 1;
    TextButton.Visible = true;
    TextButton.Text = "";
    TextButton.ZIndex = 20;
    TextButton.Selectable = true;
    TextButton.SelectionGroup = true;
    TextButton.Parent = Frame3;
    require(script.Parent.Parent.Features.Gamepad).registerButton(TextButton);
    UICorner:Clone().Parent = TextButton;
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "Contents";
    Frame4.BackgroundTransparency = 1;
    Frame4.Size = UDim2.fromScale(1, 1);
    Frame4.Parent = Frame3;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "ContentsList";
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly;
    UIListLayout.Padding = UDim.new(0, 3);
    UIListLayout.Parent = Frame4;
    local Frame5 = Instance.new("Frame");
    Frame5.Name = "PaddingLeft";
    Frame5.LayoutOrder = 1;
    Frame5.ZIndex = 5;
    Frame5.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame5.BackgroundTransparency = 1;
    Frame5.BorderSizePixel = 0;
    Frame5.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame5.Parent = Frame4;
    local Frame6 = Instance.new("Frame");
    Frame6.Name = "PaddingCenter";
    Frame6.LayoutOrder = 3;
    Frame6.ZIndex = 5;
    Frame6.Size = UDim2.new(0, 0, 1, 0);
    Frame6.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame6.BackgroundTransparency = 1;
    Frame6.BorderSizePixel = 0;
    Frame6.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame6.Parent = Frame4;
    local Frame7 = Instance.new("Frame");
    Frame7.Name = "PaddingRight";
    Frame7.LayoutOrder = 5;
    Frame7.ZIndex = 5;
    Frame7.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame7.BackgroundTransparency = 1;
    Frame7.BorderSizePixel = 0;
    Frame7.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame7.Parent = Frame4;
    local Frame8 = Instance.new("Frame");
    Frame8.Name = "IconLabelContainer";
    Frame8.LayoutOrder = 4;
    Frame8.ZIndex = 3;
    Frame8.AnchorPoint = Vector2.new(0, 0.5);
    Frame8.Size = UDim2.new(0, 0, 0.5, 0);
    Frame8.BackgroundTransparency = 1;
    Frame8.Position = UDim2.new(0.5, 0, 0.5, 0);
    Frame8.Parent = Frame4;
    local TextLabel = Instance.new("TextLabel");
    local u5 = workspace.CurrentCamera.ViewportSize.X + 200;
    TextLabel.Name = "IconLabel";
    TextLabel.LayoutOrder = 4;
    TextLabel.ZIndex = 15;
    TextLabel.AnchorPoint = Vector2.new(0, 0);
    TextLabel.Size = UDim2.new(0, u5, 1, 0);
    TextLabel.ClipsDescendants = false;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.fromScale(0, 0);
    TextLabel.RichText = true;
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = "";
    TextLabel.TextWrapped = true;
    TextLabel.TextWrap = true;
    TextLabel.TextScaled = false;
    TextLabel.Active = false;
    TextLabel.AutoLocalize = true;
    TextLabel.Parent = Frame8;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "IconImage";
    ImageLabel.LayoutOrder = 2;
    ImageLabel.ZIndex = 15;
    ImageLabel.AnchorPoint = Vector2.new(0, 0.5);
    ImageLabel.Size = UDim2.new(0, 0, 0.5, 0);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Position = UDim2.new(0, 11, 0.5, 0);
    ImageLabel.ScaleType = Enum.ScaleType.Stretch;
    ImageLabel.Active = false;
    ImageLabel.Parent = Frame4;
    local v6 = UICorner:Clone();
    v6:SetAttribute("Collective", nil);
    v6.CornerRadius = UDim.new(0, 0);
    v6.Name = "IconImageCorner";
    v6.Parent = ImageLabel;
    local TweenService = game:GetService("TweenService");
    local u7 = 0;

    local function handleLabelAndImageChangesUnstaggered(p8) -- Line: 184
        -- upvalues: u1 (copy), TextLabel (copy), ImageLabel (copy), Frame8 (copy), Frame5 (copy), Frame6 (copy), Frame7 (copy), Frame2 (copy), UIListLayout (copy), Frame4 (copy), Frame (copy), u5 (copy), u3 (copy), Frame3 (copy), MenuUIListLayout (copy), MenuGap (copy), TweenService (copy), TextButton (copy), u7 (ref), u2 (copy)
        task.defer(function() -- Line: 191
            -- upvalues: u1 (ref), TextLabel (ref), ImageLabel (ref), Frame8 (ref), Frame5 (ref), Frame6 (ref), Frame7 (ref), Frame2 (ref), UIListLayout (ref), Frame4 (ref), Frame (ref), u5 (ref), u3 (ref), Frame3 (ref), MenuUIListLayout (ref), MenuGap (ref), TweenService (ref), TextButton (ref), u7 (ref), u2 (ref)
            local indicator = u1.indicator;

            if indicator then
                indicator = indicator.Visible;
            end;

            local v9 = indicator or TextLabel.Text ~= "";
            local v10;

            if ImageLabel.Image == "" then
                v10 = false;
            else
                v10 = ImageLabel.Image ~= nil;
            end;

            local _ = Enum.HorizontalAlignment.Center;
            local UDim2_fromScale_ret = UDim2.fromScale(1, 1);

            if v10 and not v9 then
                Frame8.Visible = false;
                ImageLabel.Visible = true;
                Frame5.Visible = false;
                Frame6.Visible = false;
                Frame7.Visible = false;
            elseif v10 or not v9 then
                if v10 and v9 then
                    Frame8.Visible = true;
                    ImageLabel.Visible = true;
                    Frame5.Visible = true;
                    Frame6.Visible = not indicator;
                    Frame7.Visible = not indicator;
                    local _ = Enum.HorizontalAlignment.Left;
                end;
            else
                Frame8.Visible = true;
                ImageLabel.Visible = false;
                Frame5.Visible = true;
                Frame6.Visible = false;
                Frame7.Visible = true;
            end;

            Frame2.Size = UDim2_fromScale_ret;

            local function getItemWidth(p11) -- Line: 221
                return p11:GetAttribute("TargetWidth") or p11.AbsoluteSize.X;
            end;

            local Offset = UIListLayout.Padding.Offset;
            Frame8.Size = UDim2.new(0, TextLabel.TextBounds.X, TextLabel.Size.Y.Scale, 0);
            local v12 = Offset;

            for _, child in pairs(Frame4:GetChildren()) do
                if child:IsA("GuiObject") and child.Visible == true then
                    v12 = v12 + ((child:GetAttribute("TargetWidth") or child.AbsoluteSize.X) + Offset);
                end;
            end;

            local Attribute = Frame:GetAttribute("MinimumWidth");
            local Attribute2 = Frame:GetAttribute("MinimumHeight");
            local Attribute3 = Frame:GetAttribute("BorderSize");
            local math_clamp_ret = math.clamp(v12, Attribute, u5);
            local v13 = 0;
            local v14 = #u1.menuIcons > 0 and u1.isSelected;

            if v14 then
                for _, child in pairs(u3:GetChildren()) do
                    if child ~= Frame3 and (child:IsA("GuiObject") and child.Visible) then
                        v13 = v13 + ((child:GetAttribute("TargetWidth") or child.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset);
                    end;
                end;

                if not Frame3.Visible then
                    local v15 = Frame3;
                    math_clamp_ret = math_clamp_ret - ((v15:GetAttribute("TargetWidth") or v15.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset * 2 + Attribute3);
                end;

                v13 = v13 - Attribute3 * 0.5;
                math_clamp_ret = math_clamp_ret + (v13 - Attribute3 * 0.75);
            end;

            if v14 then
                v14 = Frame3.Visible;
            end;

            MenuGap.Visible = v14;
            local Attribute4 = Frame:GetAttribute("DesiredWidth");

            if Attribute4 then
                if math_clamp_ret >= Attribute4 then
                    Attribute4 = math_clamp_ret;
                end;
            else
                Attribute4 = math_clamp_ret;
            end;

            u1.updateMenu:Fire();
            local v16 = math.max(Attribute4 - v13, Attribute) - Attribute3 * 2;
            local Attribute5 = u3:GetAttribute("MenuWidth");

            if Attribute5 then
                Attribute5 = Attribute5 + v16 + MenuUIListLayout.Padding.Offset + 10;
            end;

            if Attribute5 then
                local Attribute6 = u3:GetAttribute("MaxWidth");

                if Attribute6 then
                    Attribute5 = math.max(Attribute6, Attribute);
                end;

                u3:SetAttribute("MenuCanvasWidth", Attribute4);

                if Attribute5 >= Attribute4 then
                    Attribute5 = Attribute4;
                end;
            else
                Attribute5 = Attribute4;
            end;

            local Quint = Enum.EasingStyle.Quint;
            local Out = Enum.EasingDirection.Out;
            local v17 = Frame3;
            local v18 = v17:GetAttribute("TargetWidth") or v17.AbsoluteSize.X;
            local math_max_ret = math.max(v16, v18, Frame3.AbsoluteSize.X);
            local v19 = Frame;
            local v20 = v19:GetAttribute("TargetWidth") or v19.AbsoluteSize.X;
            local math_max_ret2 = math.max(Attribute5, v20, Frame.AbsoluteSize.X);
            local TweenInfo_new_ret = TweenInfo.new(math_max_ret / 750, Quint, Out);
            local TweenInfo_new_ret2 = TweenInfo.new(math_max_ret2 / 750, Quint, Out);
            TweenService:Create(Frame3, TweenInfo_new_ret, {
                Position = UDim2.new(0, Attribute3, 0.5, 0),
                Size = UDim2.new(0, v16, 1, -Attribute3 * 2)
            }):Play();
            TweenService:Create(TextButton, TweenInfo_new_ret, {
                Size = UDim2.new(0, v16, 1, 0)
            }):Play();
            local UDim2_fromOffset_ret = UDim2.fromOffset(Attribute5, Attribute2);

            if Frame.Size.Y.Offset ~= Attribute2 then
                Frame.Size = UDim2_fromOffset_ret;
            end;

            Frame:SetAttribute("TargetWidth", UDim2_fromOffset_ret.X.Offset);
            TweenService:Create(Frame, TweenInfo_new_ret2, {
                Size = UDim2_fromOffset_ret
            }):Play();
            u7 = u7 + 1;

            for i = 1, TweenInfo_new_ret2.Time * 100 do
                task.delay(i / 100, function() -- Line: 303
                    -- upvalues: u2 (ref), u1 (ref)
                    u2.iconChanged:Fire(u1);
                end);
                local _ = i;
            end;

            task.delay(TweenInfo_new_ret2.Time - 0.2, function() -- Line: 307
                -- upvalues: u7 (ref), u1 (ref)
                u7 = u7 - 1;
                task.defer(function() -- Line: 309
                    -- upvalues: u7 (ref), u1 (ref)
                    if u7 == 0 then
                        u1.resizingComplete:Fire();
                    end;
                end);
            end);
            u1:updateParent();
        end);
    end;

    local u21 = require(script.Parent.Parent.Utility).createStagger(0.01, handleLabelAndImageChangesUnstaggered);
    local u22 = true;
    u1:setBehaviour("IconLabel", "Text", u21);
    u1:setBehaviour("IconLabel", "FontFace", function(p23) -- Line: 322
        -- upvalues: TextLabel (copy), u21 (copy), u22 (ref)
        if TextLabel.FontFace == p23 then
            return;
        end;

        task.spawn(function() -- Line: 327
            -- upvalues: u21 (ref), u22 (ref)
            u21();

            if u22 then
                u22 = false;

                for i = 1, 10 do
                    task.wait(1);
                    u21();
                    local _ = i;
                end;
            end;
        end);
    end);

    local function updateBorderSize() -- Line: 350
        -- upvalues: Frame (copy), u1 (copy), Frame3 (copy), u3 (copy), MenuGap (copy), MenuUIListLayout (copy), u21 (copy)
        task.defer(function() -- Line: 351
            -- upvalues: Frame (ref), u1 (ref), Frame3 (ref), u3 (ref), MenuGap (ref), MenuUIListLayout (ref), u21 (ref)
            local Attribute = Frame:GetAttribute("BorderSize");
            local alignment = u1.alignment;
            local v24;

            if Frame3.Visible == false then
                v24 = 0;
            elseif alignment == "Right" then
                v24 = -Attribute or Attribute;
            else
                v24 = Attribute;
            end;

            u3.Position = UDim2.new(0, v24, 0, 0);
            MenuGap.Size = UDim2.fromOffset(Attribute, 0);
            MenuUIListLayout.Padding = UDim.new(0, 0);
            u21();
        end);
    end;

    u1:setBehaviour("Widget", "BorderSize", updateBorderSize);
    u1:setBehaviour("IconSpot", "Visible", updateBorderSize);
    u1.startMenuUpdate:Connect(u21);
    u1.updateSize:Connect(u21);
    u1:setBehaviour("ContentsList", "HorizontalAlignment", u21);
    u1:setBehaviour("Widget", "Visible", u21);
    u1:setBehaviour("Widget", "DesiredWidth", u21);
    u1:setBehaviour("Widget", "MinimumWidth", u21);
    u1:setBehaviour("Widget", "MinimumHeight", u21);
    u1:setBehaviour("Indicator", "Visible", u21);
    u1:setBehaviour("IconImageRatio", "AspectRatio", u21);
    u1:setBehaviour("IconImage", "Image", function(p25) -- Line: 372
        -- upvalues: ImageLabel (copy), u21 (copy)
        local v26 = tonumber(p25) and "http://www.roblox.com/asset/?id=" .. p25 or (p25 or "");

        if ImageLabel.Image ~= v26 then
            u21();
        end;

        return v26;
    end);
    u1.alignmentChanged:Connect(function(p27) -- Line: 379
        -- upvalues: MenuUIListLayout (copy), Frame (copy), u1 (copy), Frame3 (copy), u3 (copy), MenuGap (copy), u21 (copy)
        MenuUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[p27 == "Center" and "Left" or p27];
        task.defer(function() -- Line: 351
            -- upvalues: Frame (ref), u1 (ref), Frame3 (ref), u3 (ref), MenuGap (ref), MenuUIListLayout (ref), u21 (ref)
            local Attribute = Frame:GetAttribute("BorderSize");
            local alignment = u1.alignment;
            local v28;

            if Frame3.Visible == false then
                v28 = 0;
            elseif alignment == "Right" then
                v28 = -Attribute or Attribute;
            else
                v28 = Attribute;
            end;

            u3.Position = UDim2.new(0, v28, 0, 0);
            MenuGap.Size = UDim2.fromOffset(Attribute, 0);
            MenuUIListLayout.Padding = UDim.new(0, 0);
            u21();
        end);
    end);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Name = "IconImageScale";
    NumberValue.Parent = ImageLabel;
    NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 390
        -- upvalues: ImageLabel (copy), NumberValue (copy)
        ImageLabel.Size = UDim2.new(NumberValue.Value, 0, NumberValue.Value, 0);
    end);
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.Name = "IconImageRatio";
    UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize;
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height;
    UIAspectRatioConstraint.Parent = ImageLabel;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "IconGradient";
    UIGradient.Enabled = true;
    UIGradient.Parent = Frame2;
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Name = "IconSpotGradient";
    UIGradient2.Enabled = true;
    UIGradient2.Parent = Frame3;

    return Frame;
end;