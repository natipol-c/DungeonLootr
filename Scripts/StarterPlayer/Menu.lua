--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Menu
  Path:     game.StarterPlayer.StarterPlayerScripts.Satchel.Satchel.Packages._Index.legitatx_topbarplus@3.0.5.topbarplus.Elements.Menu
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

return function(u1) -- Line: 1
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "Menu";
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.Visible = true;
    ScrollingFrame.ZIndex = 1;
    ScrollingFrame.Size = UDim2.fromScale(1, 1);
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.TopImage = "";
    ScrollingFrame.BottomImage = "";
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.Always;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1);
    ScrollingFrame.ScrollingEnabled = true;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X;
    ScrollingFrame.ZIndex = 20;
    ScrollingFrame.ScrollBarThickness = 3;
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255);
    ScrollingFrame.ScrollBarImageTransparency = 0.8;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.Selectable = false;
    local iconModule = require(u1.iconModule);
    local u2 = iconModule.container.TopbarStandard:FindFirstChild("UIListLayout", true):Clone();
    u2.Name = "MenuUIListLayout";
    u2.VerticalAlignment = Enum.VerticalAlignment.Center;
    u2.Parent = ScrollingFrame;
    local Frame = Instance.new("Frame");
    Frame.Name = "MenuGap";
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.AnchorPoint = Vector2.new(0, 0.5);
    Frame.ZIndex = 5;
    Frame.Parent = ScrollingFrame;
    local u3 = false;
    local Themes = require(script.Parent.Parent.Features.Themes);
    u1.menuChildAdded:Connect(function() -- Line: 39, Name: totalChildrenChanged
        -- upvalues: u1 (copy), u3 (ref), ScrollingFrame (copy), Themes (copy), u2 (copy)
        local menuJanitor = u1.menuJanitor;
        local v4 = #u1.menuIcons;

        if u3 then
            if v4 <= 0 then
                menuJanitor:clean();
                u3 = false;
            end;

            return;
        end;

        u3 = true;
        menuJanitor:add(u1.toggled:Connect(function() -- Line: 53
            -- upvalues: u1 (ref)
            if #u1.menuIcons > 0 then
                u1.updateSize:Fire();
            end;
        end));
        local _, u5 = u1:modifyTheme({ { "Menu", "Active", true } });
        task.defer(function() -- Line: 63
            -- upvalues: menuJanitor (copy), u1 (ref), u5 (copy)
            menuJanitor:add(function() -- Line: 64
                -- upvalues: u1 (ref), u5 (ref)
                u1:removeModification(u5);
            end);
        end);
        local X = ScrollingFrame.AbsoluteCanvasSize.X;

        local function rightAlignCanvas() -- Line: 73
            -- upvalues: u1 (ref), ScrollingFrame (ref), X (ref)
            if u1.alignment == "Right" then
                local X2 = ScrollingFrame.AbsoluteCanvasSize.X;
                local v6 = X - X2;
                X = X2;
                ScrollingFrame.CanvasPosition = Vector2.new(ScrollingFrame.CanvasPosition.X - v6, 0);
            end;
        end;

        menuJanitor:add(u1.selected:Connect(rightAlignCanvas));
        menuJanitor:add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(rightAlignCanvas));
        local StateGroup = u1:getStateGroup();

        if Themes.getThemeValue(StateGroup, "IconImage", "Image", "Deselected") == Themes.getThemeValue(StateGroup, "IconImage", "Image", "Selected") then
            local Font_new_ret = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Light, Enum.FontStyle.Normal);
            u1:removeModificationWith("IconLabel", "Text", "Viewing");
            u1:removeModificationWith("IconLabel", "Image", "Viewing");
            u1:modifyTheme({
                {
                    "IconLabel",
                    "FontFace",
                    Font_new_ret,
                    "Selected"
                },
                { "IconLabel", "Text", "X", "Selected" },
                { "IconLabel", "TextSize", 20, "Selected" },
                { "IconLabel", "TextStrokeTransparency", 0.8, "Selected" },
                { "IconImage", "Image", "", "Selected" }
            });
        end;

        local Instance2 = u1:getInstance("IconSpot");
        local Instance3 = u1:getInstance("MenuGap");
        menuJanitor:add(u1.alignmentChanged:Connect(function() -- Line: 105, Name: updateAlignent
            -- upvalues: u1 (ref), Instance2 (copy), Instance3 (copy)
            if u1.alignment == "Right" then
                Instance2.LayoutOrder = 99999;
                Instance3.LayoutOrder = 99998;

                return;
            end;

            Instance2.LayoutOrder = -99999;
            Instance3.LayoutOrder = -99998;
        end));

        if u1.alignment == "Right" then
            Instance2.LayoutOrder = 99999;
            Instance3.LayoutOrder = 99998;
        else
            Instance2.LayoutOrder = -99999;
            Instance3.LayoutOrder = -99998;
        end;

        ScrollingFrame:GetAttributeChangedSignal("MenuCanvasWidth"):Connect(function() -- Line: 120
            -- upvalues: ScrollingFrame (ref)
            local Attribute = ScrollingFrame:GetAttribute("MenuCanvasWidth");
            local Y = ScrollingFrame.CanvasSize.Y;
            ScrollingFrame.CanvasSize = UDim2.new(0, Attribute, Y.Scale, Y.Offset);
        end);
        menuJanitor:add(u1.updateMenu:Connect(function() -- Line: 125
            -- upvalues: ScrollingFrame (ref), u2 (ref)
            local Attribute = ScrollingFrame:GetAttribute("MaxIcons");

            if not Attribute then
                return;
            end;

            local v7 = {};

            for _, child in pairs(ScrollingFrame:GetChildren()) do
                if child:GetAttribute("WidgetUID") and child.Visible then
                    table.insert(v7, { child, child.AbsolutePosition.X });
                end;
            end;

            table.sort(v7, function(p8, p9) -- Line: 137
                return p8[2] < p9[2];
            end);
            local v10 = 0;

            for i = 1, Attribute do
                local v11 = v7[i];

                if not v11 then
                    break;
                end;

                v10 = v10 + (v11[1].AbsoluteSize.X + u2.Padding.Offset);
                local _ = i;
            end;

            ScrollingFrame:SetAttribute("MenuWidth", v10);
        end));

        local function startMenuUpdate() -- Line: 152
            -- upvalues: u1 (ref)
            task.delay(0.1, function() -- Line: 153
                -- upvalues: u1 (ref)
                u1.startMenuUpdate:Fire();
            end);
        end;

        local _ = u1:getInstance("IconButton").AbsoluteSize.X;
        menuJanitor:add(ScrollingFrame.ChildAdded:Connect(startMenuUpdate));
        menuJanitor:add(ScrollingFrame.ChildRemoved:Connect(startMenuUpdate));
        menuJanitor:add(ScrollingFrame:GetAttributeChangedSignal("MaxIcons"):Connect(startMenuUpdate));
        menuJanitor:add(ScrollingFrame:GetAttributeChangedSignal("MaxWidth"):Connect(startMenuUpdate));
        task.delay(0.1, function() -- Line: 153
            -- upvalues: u1 (ref)
            u1.startMenuUpdate:Fire();
        end);
    end);
    u1.menuSet:Connect(function(p12) -- Line: 167
        -- upvalues: u1 (copy), iconModule (copy)
        for _, v in pairs(u1.menuIcons) do
            iconModule.getIconByUID(v):destroy();
        end;

        local _ = #p12;

        if type(p12) == "table" then
            for _, v in pairs(p12) do
                v:joinMenu(u1);
            end;
        end;
    end);

    return ScrollingFrame;
end;