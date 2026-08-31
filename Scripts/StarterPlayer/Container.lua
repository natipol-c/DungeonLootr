--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Container
  Path:     game.StarterPlayer.StarterPlayerScripts.Satchel.Satchel.Packages._Index.legitatx_topbarplus@3.0.5.topbarplus.Elements.Container
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

return function(u1) -- Line: 1
    local GuiService = game:GetService("GuiService");
    local isOldTopbar = u1.isOldTopbar;
    local v2 = {};
    local GuiInset = GuiService:GetGuiInset();
    local v3 = GuiService:IsTenFootInterface();
    local v4 = v3 and 10 or (isOldTopbar and 12 or GuiInset.Y - 46);
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui:SetAttribute("StartInset", v4);
    ScreenGui.Name = "TopbarStandard";
    ScreenGui.Enabled = true;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets;
    v2[ScreenGui.Name] = ScreenGui;
    ScreenGui.DisplayOrder = u1.baseDisplayOrder;
    u1.baseDisplayOrderChanged:Connect(function() -- Line: 22
        -- upvalues: ScreenGui (copy), u1 (copy)
        ScreenGui.DisplayOrder = u1.baseDisplayOrder;
    end);
    local Frame = Instance.new("Frame");
    local v5 = isOldTopbar and 2 or 0;
    local u6;

    if v3 then
        v5 = v5 + 13;
        u6 = 50;
    else
        u6 = -2;
    end;

    Frame.Name = "Holders";
    Frame.BackgroundTransparency = 1;
    Frame.Position = UDim2.new(0, 0, 0, v5);
    Frame.Size = UDim2.new(1, 0, 1, u6);
    Frame.Visible = true;
    Frame.ZIndex = 1;
    Frame.Parent = ScreenGui;
    local u7 = ScreenGui:Clone();
    local Holders = u7.Holders;
    local GuiService2 = game:GetService("GuiService");

    local function updateCenteredHoldersHeight() -- Line: 44
        -- upvalues: Holders (copy), GuiService2 (copy), u6 (ref)
        Holders.Size = UDim2.new(1, 0, 0, GuiService2.TopbarInset.Height + u6);
    end;

    u7.Name = "TopbarCentered";
    u7.ScreenInsets = Enum.ScreenInsets.None;
    u1.baseDisplayOrderChanged:Connect(function() -- Line: 49
        -- upvalues: u7 (copy), u1 (copy)
        u7.DisplayOrder = u1.baseDisplayOrder;
    end);
    v2[u7.Name] = u7;
    GuiService2:GetPropertyChangedSignal("TopbarInset"):Connect(updateCenteredHoldersHeight);
    Holders.Size = UDim2.new(1, 0, 0, GuiService2.TopbarInset.Height + u6);
    local u8 = ScreenGui:Clone();
    u8.Name = u8.Name .. "Clipped";
    u8.DisplayOrder = u8.DisplayOrder + 1;
    u1.baseDisplayOrderChanged:Connect(function() -- Line: 59
        -- upvalues: u8 (copy), u1 (copy)
        u8.DisplayOrder = u1.baseDisplayOrder + 1;
    end);
    v2[u8.Name] = u8;
    local u9 = u7:Clone();
    u9.Name = u9.Name .. "Clipped";
    u9.DisplayOrder = u9.DisplayOrder + 1;
    u1.baseDisplayOrderChanged:Connect(function() -- Line: 67
        -- upvalues: u9 (copy), u1 (copy)
        u9.DisplayOrder = u1.baseDisplayOrder + 1;
    end);
    v2[u9.Name] = u9;

    if isOldTopbar then
        task.defer(function() -- Line: 73
            -- upvalues: GuiService2 (copy), u1 (copy)
            local function decideToHideTopbar() -- Line: 74
                -- upvalues: GuiService2 (ref), u1 (ref)
                if GuiService2.MenuIsOpen then
                    u1.setTopbarEnabled(false, true);

                    return;
                end;

                u1.setTopbarEnabled();
            end;

            GuiService2:GetPropertyChangedSignal("MenuIsOpen"):Connect(decideToHideTopbar);

            if GuiService2.MenuIsOpen then
                u1.setTopbarEnabled(false, true);

                return;
            end;

            u1.setTopbarEnabled();
        end);
    end;

    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame:SetAttribute("IsAHolder", true);
    ScrollingFrame.Name = "Left";
    ScrollingFrame.Position = UDim2.fromOffset(v4, 0);
    ScrollingFrame.Size = UDim2.new(1, -24, 1, 0);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.Visible = true;
    ScrollingFrame.ZIndex = 1;
    ScrollingFrame.Active = false;
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1);
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X;
    ScrollingFrame.ScrollBarThickness = 0;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.Selectable = false;
    ScrollingFrame.ScrollingEnabled = false;
    ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.Never;
    ScrollingFrame.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Padding = UDim.new(0, v4);
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIListLayout.Parent = ScrollingFrame;
    local v10 = ScrollingFrame:Clone();
    v10.ScrollingEnabled = false;
    v10.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    v10.Name = "Center";
    v10.Parent = Holders;
    local v11 = ScrollingFrame:Clone();
    v11.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
    v11.Name = "Right";
    v11.AnchorPoint = Vector2.new(1, 0);
    v11.Position = UDim2.new(1, -12, 0, 0);
    v11.Parent = Frame;

    return v2;
end;