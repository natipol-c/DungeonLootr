--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Gamepad
  Path:     game.StarterPlayer.StarterPlayerScripts.Satchel.Satchel.Packages._Index.legitatx_topbarplus@3.0.5.topbarplus.Features.Gamepad
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

local GamepadService = game:GetService("GamepadService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local u1 = {};
local u2 = nil;

function u1.start(p3) -- Line: 24
    -- upvalues: u2 (ref), GuiService (copy), UserInputService (copy), u1 (copy), GamepadService (copy)
    u2 = p3;
    u2.highlightKey = Enum.KeyCode.DPadUp;
    u2.highlightIcon = false;
    task.delay(1, function() -- Line: 33
        -- upvalues: u2 (ref), GuiService (ref), UserInputService (ref), u1 (ref), GamepadService (ref)
        local iconsDictionary = u2.iconsDictionary;

        local function getIconFromSelectedObject() -- Line: 36
            -- upvalues: GuiService (ref), iconsDictionary (copy)
            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject then
                SelectedObject = SelectedObject:GetAttribute("CorrespondingIconUID");
            end;

            if SelectedObject then
                SelectedObject = iconsDictionary[SelectedObject];
            end;

            return SelectedObject;
        end;

        local u4 = nil;
        local u5 = false;
        local u6 = false;
        require(script.Parent.Parent.Utility);
        local Selection = require(script.Parent.Parent.Elements.Selection);

        local function updateSelectedObject() -- Line: 50
            -- upvalues: GuiService (ref), iconsDictionary (copy), UserInputService (ref), Selection (copy), u2 (ref), u4 (ref), u6 (ref), u5 (ref), u1 (ref)
            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject then
                SelectedObject = SelectedObject:GetAttribute("CorrespondingIconUID");
            end;

            if SelectedObject then
                SelectedObject = iconsDictionary[SelectedObject];
            end;

            local GamepadEnabled = UserInputService.GamepadEnabled;

            if not SelectedObject then
                local v7;

                if GamepadEnabled and not u5 then
                    v7 = u2.highlightKey;
                else
                    v7 = nil;
                end;

                if not u4 then
                    u4 = u1.getIconToHighlight();
                end;

                if v7 == u2.highlightKey then
                    u5 = true;
                end;

                if u4 then
                    u4:setIndicator(v7);
                end;

                return;
            end;

            if GamepadEnabled then
                local Instance = SelectedObject:getInstance("ClickRegion");
                local selection = SelectedObject.selection;

                if not selection then
                    selection = SelectedObject.janitor:add(Selection(u2));
                    selection:SetAttribute("IgnoreVisibilityUpdater", true);
                    selection.Parent = SelectedObject.widget;
                    SelectedObject.selection = selection;
                    SelectedObject:refreshAppearance(selection);
                end;

                Instance.SelectionImageObject = selection.Selection;
            end;

            if u4 and u4 ~= SelectedObject then
                u4:setIndicator();
            end;

            local v8;

            if GamepadEnabled and not (u6 or SelectedObject.parentIconUID) then
                v8 = Enum.KeyCode.ButtonB;
            else
                v8 = nil;
            end;

            u4 = SelectedObject;
            u2.lastHighlightedIcon = SelectedObject;
            SelectedObject:setIndicator(v8);
        end;

        GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(updateSelectedObject);

        local function checkGamepadEnabled() -- Line: 93
            -- upvalues: UserInputService (ref), u5 (ref), u6 (ref), updateSelectedObject (copy)
            if not UserInputService.GamepadEnabled then
                u5 = false;
                u6 = false;
            end;

            updateSelectedObject();
        end;

        UserInputService:GetPropertyChangedSignal("GamepadEnabled"):Connect(checkGamepadEnabled);

        if not UserInputService.GamepadEnabled then
            u5 = false;
            u6 = false;
        end;

        updateSelectedObject();
        UserInputService.InputBegan:Connect(function(p9, p10) -- Line: 107
            -- upvalues: GuiService (ref), iconsDictionary (copy), u2 (ref), u1 (ref), GamepadService (ref)
            if p9.UserInputType ~= Enum.UserInputType.MouseButton1 then
                if p9.KeyCode ~= u2.highlightKey then
                    return;
                end;

                local IconToHighlight = u1.getIconToHighlight();

                if IconToHighlight then
                    if GamepadService.GamepadCursorEnabled then
                        task.wait(0.2);
                        GamepadService:DisableGamepadCursor();
                    end;

                    GuiService.SelectedObject = IconToHighlight:getInstance("ClickRegion");
                end;

                return;
            end;

            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject then
                SelectedObject = SelectedObject:GetAttribute("CorrespondingIconUID");
            end;

            if SelectedObject then
                SelectedObject = iconsDictionary[SelectedObject];
            end;

            if SelectedObject then
                GuiService.SelectedObject = nil;
            end;
        end);
    end);
end;

function u1.getIconToHighlight() -- Line: 134
    -- upvalues: u2 (ref)
    local iconsDictionary = u2.iconsDictionary;
    local v11 = u2.highlightIcon or u2.lastHighlightedIcon;

    if not v11 then
        local v12 = nil;

        for _, v in pairs(iconsDictionary) do
            if not v.parentIconUID and (not v12 or v.widget.AbsolutePosition.X < v12) then
                v12 = v.widget.AbsolutePosition.X;
                v11 = v;
            end;
        end;
    end;

    return v11;
end;

function u1.registerButton(u13) -- Line: 156
    -- upvalues: UserInputService (copy), GamepadService (copy), GuiService (copy)
    local u14 = false;
    u13.InputBegan:Connect(function(p15) -- Line: 162
        -- upvalues: u14 (ref)
        u14 = true;
        task.wait();
        task.wait();
        u14 = false;
    end);
    local u18 = UserInputService.InputBegan:Connect(function(p16) -- Line: 171
        -- upvalues: u14 (ref), GamepadService (ref), GuiService (ref), u13 (copy)
        task.wait();

        if p16.KeyCode == Enum.KeyCode.ButtonA and u14 then
            task.wait(0.2);
            GamepadService:DisableGamepadCursor();
            GuiService.SelectedObject = u13;

            return;
        end;

        local v17 = GuiService.SelectedObject == u13;
        local Name = p16.KeyCode.Name;

        if table.find({ "ButtonB", "ButtonSelect" }, Name) and (v17 and (Name ~= "ButtonSelect" or GamepadService.GamepadCursorEnabled)) then
            GuiService.SelectedObject = nil;
        end;
    end);
    u13.Destroying:Once(function() -- Line: 192
        -- upvalues: u18 (copy)
        u18:Disconnect();
    end);
end;

return u1;