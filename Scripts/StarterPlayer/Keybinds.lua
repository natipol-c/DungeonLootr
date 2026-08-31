--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Keybinds
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Keybinds
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GamepadService = game:GetService("GamepadService");
local Packages = ReplicatedStorage:WaitForChild("Packages");
local Knit = require(Packages:WaitForChild("Knit"));
local InputMapData = require(ReplicatedStorage:WaitForChild("Player"):WaitForChild("Modules"):WaitForChild("InputMapData"));
local u1 = {
    Attack = "Attack",
    Dodge = "Dodge",
    Parry = "ParryBlock",
    Skill1 = "Skill1",
    Skill2 = "Skill2",
    Skill3 = "Skill3",
    Skill4 = "Skill4",
    Ultimate = "SkillE",
    Health = "Potion_Health",
    ShiftLock = "ShiftLock",
    Sprint = "Sprint",
    Walk = "Walk",
    Inventory = "Inventory",
    Settings = "SettingsMenu",
    ClassMenu = "ClassMenu",
    Emote = "Emote"
};
local Color3_fromRGB_ret = Color3.fromRGB(180, 180, 180);
local Color3_fromRGB_ret2 = Color3.fromRGB(120, 220, 140);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 205, 60);
local Color3_fromRGB_ret4 = Color3.fromRGB(255, 80, 80);
local u2 = {
    [Enum.KeyCode.ButtonA] = "A",
    [Enum.KeyCode.ButtonB] = "B",
    [Enum.KeyCode.ButtonX] = "X",
    [Enum.KeyCode.ButtonY] = "Y"
};
local v3 = {};
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = "Keyboard";
local u10 = {};
local u11 = {};
local u12 = {};
local u13 = nil;

local function GetIBC() -- Line: 129
    -- upvalues: Knit (copy)
    return Knit.GetController("InputBindingController");
end;

local function isGamepadType(p14) -- Line: 133
    return (p14 == Enum.UserInputType.Gamepad1 or (p14 == Enum.UserInputType.Gamepad2 or p14 == Enum.UserInputType.Gamepad3)) and true or p14 == Enum.UserInputType.Gamepad4;
end;

local function gamepadGlyph(u15) -- Line: 143
    -- upvalues: UserInputService (copy), u2 (copy)
    local success, result = pcall(function() -- Line: 144
        -- upvalues: UserInputService (ref), u15 (copy)
        return UserInputService:GetStringForKeyCode(u15);
    end);

    if success and (type(result) == "string" and (result ~= "" and not string.match(result, "^Button"))) then
        return result;
    end;

    return u2[u15] or u15.Name;
end;

local function showInputNotice() -- Line: 156
    -- upvalues: u6 (ref), u7 (ref), u8 (ref), u9 (ref), gamepadGlyph (copy)
    if not u6 then
        return;
    end;

    if u7 then
        u7.Text = "PRESS DESIRED INPUT KEY";
    end;

    if u8 then
        if u9 == "Gamepad" then
            u8.Text = string.format("HOLD %s TO CANCEL", (gamepadGlyph(Enum.KeyCode.ButtonB)));
        else
            u8.Text = "PRESS ESC TO CANCEL";
        end;
    end;

    u6.Visible = true;
end;

local function hideInputNotice() -- Line: 171
    -- upvalues: u6 (ref)
    if u6 then
        u6.Visible = false;
    end;
end;

local function setInputNoticeCombo() -- Line: 179
    -- upvalues: u7 (ref)
    if u7 then
        u7.Text = "SETTING COMBO INPUT — PRESS ANOTHER INPUT";
    end;
end;

local function inputToKeyName(p16: userdata) -- Line: 185
    local UserInputType = p16.UserInputType;

    if UserInputType == Enum.UserInputType.Keyboard then
        return p16.KeyCode.Name, "Keyboard";
    end;

    if UserInputType == Enum.UserInputType.MouseButton1 then
        return "MouseButton1", "Keyboard";
    end;

    if UserInputType == Enum.UserInputType.MouseButton2 then
        return "MouseButton2", "Keyboard";
    end;

    if UserInputType == Enum.UserInputType.MouseButton3 then
        return "MouseButton3", "Keyboard";
    end;

    if UserInputType == Enum.UserInputType.Gamepad1 or (UserInputType == Enum.UserInputType.Gamepad2 or (UserInputType == Enum.UserInputType.Gamepad3 or UserInputType == Enum.UserInputType.Gamepad4)) then
        return p16.KeyCode.Name, "Gamepad";
    end;

    return nil, nil;
end;

local function detectPlatform() -- Line: 206
    -- upvalues: UserInputService (copy)
    local LastInputType = UserInputService:GetLastInputType();

    return (LastInputType == Enum.UserInputType.Gamepad1 or (LastInputType == Enum.UserInputType.Gamepad2 or (LastInputType == Enum.UserInputType.Gamepad3 or LastInputType == Enum.UserInputType.Gamepad4))) and "Gamepad" or "Keyboard";
end;

local function refreshRow(p17: string) -- Line: 221
    -- upvalues: u10 (copy), Knit (copy), u11 (copy), u9 (ref), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret3 (copy), InputMapData (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    local v18 = u10[p17];

    if not v18 then
        return;
    end;

    local Controller = Knit.GetController("InputBindingController");
    local v19 = u11[p17];

    if v19 then
        v18.textBox.Text = Controller:PrettyKey(v19);
        local v20 = Controller:ValidateBinding(p17, u9, v19);
        v18.textBox.TextColor3 = v20 == "CONFLICT" and Color3_fromRGB_ret4 or Color3_fromRGB_ret3;

        return;
    end;

    local Key = Controller:GetKey(p17, u9);
    local Default = InputMapData.GetDefault(p17, u9);
    v18.textBox.Text = Controller:PrettyKey(Key);

    if v18.remappable and Key ~= Default then
        v18.textBox.TextColor3 = Color3_fromRGB_ret2;

        return;
    end;

    v18.textBox.TextColor3 = Color3_fromRGB_ret;
end;

local function refreshAllRows() -- Line: 245
    -- upvalues: u10 (copy), refreshRow (copy)
    for i in pairs(u10) do
        refreshRow(i);
    end;
end;

local function snapshotBaseline() -- Line: 253
    -- upvalues: Knit (copy), u10 (copy), u12 (copy), u9 (ref)
    local Controller = Knit.GetController("InputBindingController");

    for i in pairs(u10) do
        u12[i] = Controller:GetKey(i, u9);
    end;
end;

local function endCapture(p21: boolean) -- Line: 262
    -- upvalues: u13 (ref), Knit (copy), u6 (ref), Players (copy), GamepadService (copy), refreshRow (copy)
    if not u13 then
        return;
    end;

    if u13.connection then
        u13.connection:Disconnect();
        u13.connection = nil;
    end;

    if u13.endConnection then
        u13.endConnection:Disconnect();
        u13.endConnection = nil;
    end;

    local v22 = u13;
    u13 = nil;
    Knit.GetController("InputBindingController"):SetCapturing(false);

    if u6 then
        u6.Visible = false;
    end;

    if v22.cursorSuppressed and Players.LocalPlayer:GetAttribute("OpenWindow") then
        GamepadService:EnableGamepadCursor(nil);
    end;

    if v22.textBox then
        v22.textBox.PlaceholderText = "";
    end;

    if p21 then
        refreshRow(v22.action);
    end;
end;

local function tryCommit(p23: string) -- Line: 300
    -- upvalues: Knit (copy), u13 (ref), u9 (ref), u11 (copy), endCapture (copy), refreshRow (copy)
    local v24 = Knit.GetController("InputBindingController"):ValidateBinding(u13.action, u9, p23);

    if v24 == "RESERVED" or (v24 == "NOT_REMAPPABLE" or (v24 == "NO_COMBOS" or (v24 == "INVALID_ACTION" or (v24 == "INVALID_PLATFORM" or v24 == "INVALID_COMBO")))) then
        return false;
    end;

    u11[u13.action] = p23;
    local action = u13.action;
    endCapture(false);
    refreshRow(action);

    return true;
end;

local function handleCaptureInput(p25: userdata) -- Line: 316
    -- upvalues: u13 (ref), endCapture (copy), u9 (ref), UserInputService (copy), inputToKeyName (copy), InputMapData (copy), tryCommit (copy), u7 (ref)
    if not u13 then
        return;
    end;

    if p25.UserInputType == Enum.UserInputType.Keyboard and p25.KeyCode == Enum.KeyCode.Escape then
        endCapture(true);

        return;
    end;

    if p25.UserInputType == Enum.UserInputType.MouseButton1 then
        return;
    end;

    if u9 == "Gamepad" then
        local UserInputType = p25.UserInputType;

        if ((UserInputType == Enum.UserInputType.Gamepad1 or (UserInputType == Enum.UserInputType.Gamepad2 or UserInputType == Enum.UserInputType.Gamepad3)) and true or UserInputType == Enum.UserInputType.Gamepad4) and p25.KeyCode == Enum.KeyCode.ButtonB then
            local u26 = (u13.cancelToken or 0) + 1;
            u13.cancelToken = u26;
            u13.bHeld = true;
            local UserInputType2 = p25.UserInputType;
            task.delay(0.5, function() -- Line: 344
                -- upvalues: u13 (ref), u26 (copy), UserInputService (ref), UserInputType2 (copy), endCapture (ref)
                if u13 and (u13.cancelToken == u26 and UserInputService:IsGamepadButtonDown(UserInputType2, Enum.KeyCode.ButtonB)) then
                    endCapture(true);
                end;
            end);

            return;
        end;
    end;

    if u13.armAt and os.clock() < u13.armAt then
        return;
    end;

    local v27, v28 = inputToKeyName(p25);

    if not (v27 and v28) then
        return;
    end;

    if v28 ~= u9 then
        return;
    end;

    if not u13.comboAllowed then
        tryCommit(v27);

        return;
    end;

    if u13.comboPart1 then
        if v27 == u13.comboPart1 then
            return;
        end;

        if InputMapData.IsReservedKey(u9, v27) then
            return;
        end;

        tryCommit(u13.comboPart1 .. "+" .. v27);

        return;
    end;

    if InputMapData.IsReservedKey(u9, v27) then
        return;
    end;

    u13.holdKey = v27;
    local u29 = (u13.holdToken or 0) + 1;
    u13.holdToken = u29;
    local UserInputType = p25.UserInputType;
    local KeyCode = p25.KeyCode;
    task.delay(0.5, function() -- Line: 383
        -- upvalues: u13 (ref), u29 (copy), UserInputService (ref), UserInputType (copy), KeyCode (copy), u7 (ref)
        if not u13 then
            return;
        end;

        if u13.holdToken ~= u29 then
            return;
        end;

        if u13.comboPart1 or not u13.holdKey then
            return;
        end;

        if not UserInputService:IsGamepadButtonDown(UserInputType, KeyCode) then
            return;
        end;

        u13.comboPart1 = u13.holdKey;
        u13.holdKey = nil;

        if u7 then
            u7.Text = "SETTING COMBO INPUT — PRESS ANOTHER INPUT";
        end;
    end);
end;

local function handleCaptureEnded(p30: userdata) -- Line: 405
    -- upvalues: u13 (ref), u9 (ref), tryCommit (copy), inputToKeyName (copy)
    if not u13 then
        return;
    end;

    if u9 == "Gamepad" then
        local UserInputType = p30.UserInputType;

        if ((UserInputType == Enum.UserInputType.Gamepad1 or (UserInputType == Enum.UserInputType.Gamepad2 or UserInputType == Enum.UserInputType.Gamepad3)) and true or UserInputType == Enum.UserInputType.Gamepad4) and (p30.KeyCode == Enum.KeyCode.ButtonB and u13.bHeld) then
            u13.bHeld = false;
            u13.cancelToken = (u13.cancelToken or 0) + 1;

            if u13.armAt and os.clock() < u13.armAt then
                return;
            end;

            if u13.comboAllowed and u13.comboPart1 then
                if u13.comboPart1 ~= "ButtonB" then
                    tryCommit(u13.comboPart1 .. "+ButtonB");

                    return;
                end;
            else
                tryCommit("ButtonB");
            end;

            return;
        end;
    end;

    if u13.comboAllowed and (not u13.comboPart1 and (u13.holdKey and inputToKeyName(p30) == u13.holdKey)) then
        u13.holdToken = (u13.holdToken or 0) + 1;
        local holdKey = u13.holdKey;
        u13.holdKey = nil;
        tryCommit(holdKey);
    end;
end;

local function beginCapture(p31: string, p32: userdata) -- Line: 440
    -- upvalues: u10 (copy), u13 (ref), endCapture (copy), InputMapData (copy), u9 (ref), Knit (copy), GamepadService (copy), Color3_fromRGB_ret3 (copy), u6 (ref), u7 (ref), u8 (ref), gamepadGlyph (copy), UserInputService (copy), handleCaptureInput (copy), handleCaptureEnded (copy)
    local v33 = u10[p31];

    if not (v33 and v33.remappable) then
        return;
    end;

    if u13 then
        if u13.action == p31 then
            return;
        end;

        endCapture(true);
    end;

    u13 = {
        action = p31,
        textBox = p32,
        armAt = os.clock() + 0.35,
        comboAllowed = InputMapData.AllowsCombo(p31, u9)
    };
    Knit.GetController("InputBindingController"):SetCapturing(true);

    if u9 == "Gamepad" and GamepadService.GamepadCursorEnabled then
        u13.cursorSuppressed = true;
        GamepadService:DisableGamepadCursor();
    end;

    p32.Text = "";
    p32.PlaceholderText = "press";
    p32.TextColor3 = Color3_fromRGB_ret3;

    if u6 then
        if u7 then
            u7.Text = "PRESS DESIRED INPUT KEY";
        end;

        if u8 then
            if u9 == "Gamepad" then
                u8.Text = string.format("HOLD %s TO CANCEL", (gamepadGlyph(Enum.KeyCode.ButtonB)));
            else
                u8.Text = "PRESS ESC TO CANCEL";
            end;
        end;

        u6.Visible = true;
    end;

    u13.connection = UserInputService.InputBegan:Connect(handleCaptureInput);
    u13.endConnection = UserInputService.InputEnded:Connect(handleCaptureEnded);
end;

local function applyPending(u34: string) -- Line: 486
    -- upvalues: u11 (copy), Knit (copy), u9 (ref), InputMapData (copy), refreshRow (copy)
    local u35 = u11[u34];

    if not u35 then
        return;
    end;

    local Controller = Knit.GetController("InputBindingController");
    local v36, u37 = Controller:ValidateBinding(u34, u9, u35);

    if v36 == "CONFLICT" and u37 then
        local Action = InputMapData.GetAction(u34);
        local Action2 = InputMapData.GetAction(u37);
        local u38;

        if Action then
            u38 = Action.DisplayName or u34;
        else
            u38 = u34;
        end;

        local u39;

        if Action2 then
            u39 = Action2.DisplayName or u37;
        else
            u39 = u37;
        end;

        task.spawn(function() -- Line: 499
            -- upvalues: Knit (ref), u38 (copy), Controller (copy), u35 (copy), u39 (copy), u11 (ref), u34 (copy), refreshRow (ref), u9 (ref), InputMapData (ref), u37 (copy)
            local u40 = false;
            local Controller2 = Knit.GetController("WarningController");

            if Controller2 then
                pcall(function() -- Line: 503
                    -- upvalues: u40 (ref), Controller2 (copy), u38 (ref), Controller (ref), u35 (ref), u39 (ref)
                    u40 = Controller2:Prompt({
                        ConfirmText = "Rebind",
                        DenyText = "Cancel",
                        Message = string.format("Setting <b>%s</b> to <b>%s</b> will unbind <b>%s</b> from that key.\n\nContinue?", u38, Controller:PrettyKey(u35), u39)
                    });
                end);
            else
                u40 = true;
            end;

            if not u40 then
                u11[u34] = nil;
                refreshRow(u34);

                return;
            end;

            u11[u34] = nil;
            Controller:SetBinding(u34, u9, u35);
            local Default = InputMapData.GetDefault(u37, u9);

            if Default ~= "" and Controller:ValidateBinding(u37, u9, Default) == "OK" then
                Controller:ResetBinding(u37, u9);
            end;

            refreshRow(u34);
            refreshRow(u37);
        end);
    elseif v36 == "OK" then
        u11[u34] = nil;
        Controller:SetBinding(u34, u9, u35);
    else
        u11[u34] = nil;
        refreshRow(u34);
    end;

    local Controller2 = Knit.GetController("SoundController");

    if Controller2 then
        Controller2:Play("Click");
    end;
end;

local function cancelPending(p41: string) -- Line: 560
    -- upvalues: u13 (ref), endCapture (copy), u12 (copy), Knit (copy), u9 (ref), u11 (copy), refreshRow (copy)
    if u13 and u13.action == p41 then
        endCapture(true);
    end;

    local v42 = u12[p41];
    local Key = Knit.GetController("InputBindingController"):GetKey(p41, u9);

    if v42 == nil or v42 == Key then
        u11[p41] = nil;
    else
        u11[p41] = v42;
    end;

    refreshRow(p41);
    local Controller = Knit.GetController("SoundController");

    if Controller then
        Controller:Play("Click");
    end;
end;

local function wireRow(p43: userdata, u44: string) -- Line: 581
    -- upvalues: InputMapData (copy), u9 (ref), u10 (copy), beginCapture (copy), applyPending (copy), cancelPending (copy), refreshRow (copy)
    local TextBox = p43:FindFirstChild("TextBox");
    local Confirm = p43:FindFirstChild("Confirm");
    local Cancel = p43:FindFirstChild("Cancel");

    if not TextBox then
        warn((`[Keybinds] Control row {p43.Name} has no TextBox`));

        return;
    end;

    local v45 = InputMapData.IsRemappable(u44, u9);
    u10[u44] = {
        frameName = p43.Name,
        textBox = TextBox,
        confirm = Confirm,
        cancel = Cancel,
        remappable = v45
    };
    TextBox.TextEditable = false;
    TextBox.ClearTextOnFocus = false;
    TextBox.Focused:Connect(function() -- Line: 603
        -- upvalues: TextBox (copy)
        TextBox:ReleaseFocus();
    end);

    if v45 then
        TextBox.InputBegan:Connect(function(p46) -- Line: 608
            -- upvalues: beginCapture (ref), u44 (copy), TextBox (copy)
            if p46.UserInputType == Enum.UserInputType.MouseButton1 or p46.UserInputType == Enum.UserInputType.Touch then
                beginCapture(u44, TextBox);
            end;
        end);

        if Confirm and Confirm:IsA("GuiButton") then
            Confirm.Activated:Connect(function() -- Line: 615
                -- upvalues: applyPending (ref), u44 (copy)
                applyPending(u44);
            end);
        end;

        if Cancel and Cancel:IsA("GuiButton") then
            Cancel.Activated:Connect(function() -- Line: 620
                -- upvalues: cancelPending (ref), u44 (copy)
                cancelPending(u44);
            end);
        end;
    else
        if Confirm then
            Confirm.Visible = false;
        end;

        if Cancel then
            Cancel.Visible = false;
        end;
    end;

    refreshRow(u44);
end;

local function rebuildForPlatform() -- Line: 634
    -- upvalues: u10 (copy), InputMapData (copy), u9 (ref), refreshRow (copy), snapshotBaseline (copy)
    for i, v in pairs(u10) do
        v.remappable = InputMapData.IsRemappable(i, u9);

        if v.confirm then
            v.confirm.Visible = v.remappable;
        end;

        if v.cancel then
            v.cancel.Visible = v.remappable;
        end;
    end;

    for i in pairs(u10) do
        refreshRow(i);
    end;

    snapshotBaseline();
end;

function v3._Init(p47) -- Line: 646
    -- upvalues: Players (copy), u4 (ref), u6 (ref), u7 (ref), u8 (ref), u13 (ref), endCapture (copy), u5 (ref), u9 (ref), UserInputService (copy), u1 (copy), wireRow (copy), snapshotBaseline (copy), Knit (copy), refreshRow (copy), u11 (copy), rebuildForPlatform (copy), u10 (copy)
    local Settings = (p47.Parent or Players.LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("Settings", 10);

    if not Settings then
        warn("[Keybinds] Settings ScreenGui not found");

        return;
    end;

    u4 = Settings:WaitForChild("Main", 10);

    if not u4 then
        warn("[Keybinds] Settings.Main not found");

        return;
    end;

    u6 = u4:FindFirstChild("Input_Notice");

    if u6 then
        u7 = u6:FindFirstChild("Message");
        u8 = u6:FindFirstChild("Cancel");
        u6.Visible = false;

        if u8 and u8:IsA("GuiButton") then
            u8.Activated:Connect(function() -- Line: 669
                -- upvalues: u13 (ref), endCapture (ref)
                if u13 then
                    endCapture(true);
                end;
            end);
        end;
    else
        warn("[Keybinds] Settings.Main.Input_Notice not found");
    end;

    local Assets = u4:WaitForChild("Assets", 10);

    if Assets then
        Assets = Assets:FindFirstChild("Control");
    end;

    u5 = Assets;

    if not u5 then
        warn("[Keybinds] Settings.Main.Assets.Control not found");

        return;
    end;

    local LastInputType = UserInputService:GetLastInputType();
    u9 = (LastInputType == Enum.UserInputType.Gamepad1 or (LastInputType == Enum.UserInputType.Gamepad2 or (LastInputType == Enum.UserInputType.Gamepad3 or LastInputType == Enum.UserInputType.Gamepad4))) and "Gamepad" or "Keyboard";

    for _, child in u5:GetChildren() do
        local v48 = u1[child.Name];

        if v48 and child:IsA("GuiObject") then
            wireRow(child, v48);
        end;
    end;

    snapshotBaseline();
    Knit.GetController("InputBindingController"):OnBindingsChanged(function(p49, p50) -- Line: 698
        -- upvalues: u9 (ref), refreshRow (ref)
        if p50 == u9 then
            refreshRow(p49);
        end;
    end);
    UserInputService.LastInputTypeChanged:Connect(function() -- Line: 705
        -- upvalues: UserInputService (ref), u9 (ref), u11 (ref), rebuildForPlatform (ref)
        local LastInputType2 = UserInputService:GetLastInputType();
        local v51 = (LastInputType2 == Enum.UserInputType.Gamepad1 or (LastInputType2 == Enum.UserInputType.Gamepad2 or (LastInputType2 == Enum.UserInputType.Gamepad3 or LastInputType2 == Enum.UserInputType.Gamepad4))) and "Gamepad" or "Keyboard";

        if v51 ~= u9 then
            u9 = v51;
            table.clear(u11);
            rebuildForPlatform();
        end;
    end);
    u4:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 717
        -- upvalues: u4 (ref), snapshotBaseline (ref), u13 (ref), endCapture (ref), u11 (ref), u10 (ref), refreshRow (ref)
        if u4.Visible then
            snapshotBaseline();

            return;
        end;

        if u13 then
            endCapture(true);
        end;

        if next(u11) ~= nil then
            table.clear(u11);

            for i in pairs(u10) do
                refreshRow(i);
            end;
        end;
    end);
end;

return v3;