--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CameraInput
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.CameraInput
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:20 2026
]]

-- Decompiled with Potassium's decompiler.

local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
game:GetService("RunService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local VRService = game:GetService("VRService");
local GuiService = game:GetService("GuiService");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local UserFlag = FlagUtil.getUserFlag("UserPSSinkUnknownTouchEvents");
local UserFlag2 = FlagUtil.getUserFlag("UserPSTextboxResetCameraInput");
local UserFlag3 = FlagUtil.getUserFlag("UserFixVRCameraGamepadReset");
local LocalPlayer = Players.LocalPlayer;
local Value = Enum.ContextActionPriority.Medium.Value;
local u1 = Vector2.new(1, 0.77) * 0.06981317007977318 * 60;
local u2 = Vector2.new(1, 0.77) * 0.008726646259971648;
local u3 = Vector2.new(1, 0.77) * 0.12217304763960307;
local u4 = Vector2.new(1, 0.66) * 0.017453292519943295;
local BindableEvent = Instance.new("BindableEvent");
local BindableEvent2 = Instance.new("BindableEvent");
local Event = BindableEvent.Event;
local Event2 = BindableEvent2.Event;
UserInputService.InputBegan:Connect(function(p5, p6) -- Line: 45
    -- upvalues: BindableEvent (copy)
    if not p6 and p5.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent:Fire();
    end;
end);
UserInputService.InputEnded:Connect(function(p7, p8) -- Line: 51
    -- upvalues: BindableEvent2 (copy)
    if p7.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent2:Fire();
    end;
end);

local function thumbstickCurve(p9) -- Line: 62
    local v10 = (math.abs(p9) - 0.1) / 0.9 * 2;
    local v11 = (math.exp(v10) - 1) / 6.38905609893065;

    return math.sign(p9) * math.clamp(v11, 0, 1);
end;

local function adjustTouchPitchSensitivity(p12) -- Line: 76
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return p12;
    end;

    local v13 = workspace_CurrentCamera.CFrame:ToEulerAnglesYXZ();

    if p12.Y * v13 >= 0 then
        return p12;
    end;

    local v14 = (1 - (math.abs(v13) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;

    return Vector2.new(1, v14) * p12;
end;

local function isInDynamicThumbstickArea(p15: vector) -- Line: 102
    -- upvalues: LocalPlayer (copy)
    local v16 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v16 then
        v16 = v16:FindFirstChild("TouchGui");
    end;

    local v17;

    if v16 then
        v17 = v16:FindFirstChild("TouchControlFrame");
    else
        v17 = v16;
    end;

    if v17 then
        v17 = v17:FindFirstChild("DynamicThumbstickFrame");
    end;

    if not v17 then
        return false;
    end;

    if not v16.Enabled then
        return false;
    end;

    local AbsolutePosition = v17.AbsolutePosition;
    local v18 = AbsolutePosition + v17.AbsoluteSize;
    local v19;

    if p15.X >= AbsolutePosition.X and (p15.Y >= AbsolutePosition.Y and p15.X <= v18.X) then
        v19 = p15.Y <= v18.Y;
    else
        v19 = false;
    end;

    return v19;
end;

local v20 = {};
local u21 = {};
local u22 = 0;

local function incPanInputCount() -- Line: 132
    -- upvalues: u22 (ref)
    u22 = math.max(0, u22 + 1);
end;

local function decPanInputCount() -- Line: 136
    -- upvalues: u22 (ref)
    u22 = math.max(0, u22 - 1);
end;

local function resetPanInputCount() -- Line: 140
    -- upvalues: u22 (ref)
    u22 = 0;
end;

local u23 = {
    Thumbstick2 = Vector2.new()
};
local u24 = {
    Left = 0,
    Right = 0,
    I = 0,
    O = 0
};
local u25 = {
    Wheel = 0,
    Pinch = 0,
    Movement = Vector2.new(),
    Pan = Vector2.new()
};
local u26 = {
    Pinch = 0,
    Move = Vector2.new()
};
local BindableEvent3 = Instance.new("BindableEvent");
v20.gamepadZoomPress = BindableEvent3.Event;
local u27;

if UserFlag3 then
    u27 = Instance.new("BindableEvent");
    v20.gamepadReset = u27.Event;
else
    u27 = VRService.VREnabled and Instance.new("BindableEvent") or nil;

    if VRService.VREnabled then
        v20.gamepadReset = u27.Event;
    end;
end;

function v20.getRotationActivated() -- Line: 179
    -- upvalues: u22 (ref), u23 (copy)
    return u22 > 0 and true or u23.Thumbstick2.Magnitude > 0;
end;

function v20.getRotation(p28: any, p29: boolean?) -- Line: 183
    -- upvalues: UserGameSettings (copy), u24 (copy), u23 (copy), u25 (copy), adjustTouchPitchSensitivity (copy), u26 (copy), u1 (copy), u2 (copy), u3 (copy), u4 (copy)
    local Vector2_new_ret = Vector2.new(1, UserGameSettings:GetCameraYInvertValue());
    local v30 = Vector2.new(u24.Right - u24.Left, 0) * p28;
    local v31 = u23.Thumbstick2 * UserGameSettings.GamepadCameraSensitivity * p28;
    local Movement = u25.Movement;
    local Pan = u25.Pan;
    local v32 = adjustTouchPitchSensitivity(u26.Move);

    if p29 then
        v30 = Vector2.new();
    end;

    return (v30 * 2.0943951023931953 + v31 * u1 + Movement * u2 + Pan * u3 + v32 * u4) * Vector2_new_ret;
end;

function v20.getZoomDelta() -- Line: 208
    -- upvalues: u24 (copy), u25 (copy), u26 (copy)
    return (u24.O - u24.I) * 0.1 + (-u25.Wheel + u25.Pinch) * 1 + -u26.Pinch * 0.04;
end;

local function thumbstick(p33, p34, p35) -- Line: 216
    -- upvalues: u23 (copy), thumbstickCurve (ref)
    local Position = p35.Position;
    u23[p35.KeyCode.Name] = Vector2.new(thumbstickCurve(Position.X), -thumbstickCurve(Position.Y));

    return Enum.ContextActionResult.Pass;
end;

local function mouseMovement(p36) -- Line: 222
    -- upvalues: u25 (copy)
    local Delta = p36.Delta;
    u25.Movement = Vector2.new(Delta.X, Delta.Y);
end;

local function mouseWheel(p37, p38, p39) -- Line: 227
    -- upvalues: u25 (copy)
    u25.Wheel = p39.Position.Z;

    return Enum.ContextActionResult.Pass;
end;

local function keypress(p40, p41, p42) -- Line: 232
    -- upvalues: u24 (copy)
    u24[p42.KeyCode.Name] = p41 == Enum.UserInputState.Begin and 1 or 0;
end;

local function gamepadZoomPress(p43, p44, p45) -- Line: 236
    -- upvalues: BindableEvent3 (copy)
    if p44 == Enum.UserInputState.Begin then
        BindableEvent3:Fire();
    end;
end;

local function gamepadReset(p46, p47, p48) -- Line: 242
    -- upvalues: u27 (ref)
    if p47 == Enum.UserInputState.Begin then
        u27:Fire();
    end;
end;

local function resetInputDevices() -- Line: 248
    -- upvalues: u23 (copy), u24 (copy), u25 (copy), u26 (copy), u22 (ref)
    for _, v in pairs({
        u23,
        u24,
        u25,
        u26
    }) do
        local v49 = v;

        for i, v2 in pairs(v) do
            if type(v2) == "boolean" then
                v49[i] = false;
            else
                v49[i] = v49[i] * 0;
            end;
        end;
    end;

    u22 = 0;
end;

local u50 = {};
local u51 = nil;
local u52 = nil;

local function touchBegan(p53: userdata, p54: boolean) -- Line: 274
    -- upvalues: u51 (ref), isInDynamicThumbstickArea (copy), u22 (ref), u50 (ref)
    assert(p53.UserInputType == Enum.UserInputType.Touch);
    assert(p53.UserInputState == Enum.UserInputState.Begin);

    if u51 == nil and (isInDynamicThumbstickArea(p53.Position) and not p54) then
        u51 = p53;

        return;
    end;

    if not p54 then
        u22 = math.max(0, u22 + 1);
    end;

    u50[p53] = p54;
end;

local function touchEnded(p55: userdata, p56: boolean) -- Line: 294
    -- upvalues: u51 (ref), u50 (ref), u52 (ref), u22 (ref)
    assert(p55.UserInputType == Enum.UserInputType.Touch);
    assert(p55.UserInputState == Enum.UserInputState.End);

    if p55 == u51 then
        u51 = nil;
    end;

    if u50[p55] == false then
        u52 = nil;
        u22 = math.max(0, u22 - 1);
    end;

    u50[p55] = nil;
end;

local function touchChanged(p57, p58) -- Line: 313
    -- upvalues: u51 (ref), u50 (ref), UserFlag (copy), u26 (copy), u52 (ref)
    assert(p57.UserInputType == Enum.UserInputType.Touch);
    assert(p57.UserInputState == Enum.UserInputState.Change);

    if p57 == u51 then
        return;
    end;

    if u50[p57] == nil then
        if UserFlag then
            u50[p57] = true;
        else
            u50[p57] = p58;
        end;
    end;

    local v59 = {};

    for i, v in pairs(u50) do
        if not v then
            table.insert(v59, i);
        end;
    end;

    if #v59 == 1 and u50[p57] == false then
        local Delta = p57.Delta;
        local v60 = u26;
        v60.Move = v60.Move + Vector2.new(Delta.X, Delta.Y);
    end;

    if #v59 ~= 2 then
        u52 = nil;

        return;
    end;

    local Magnitude = (v59[1].Position - v59[2].Position).Magnitude;

    if u52 then
        local v61 = u26;
        v61.Pinch = v61.Pinch + (Magnitude - u52);
    end;

    u52 = Magnitude;
end;

local function resetTouchState() -- Line: 361
    -- upvalues: u50 (ref), u51 (ref), u52 (ref), u22 (ref)
    u50 = {};
    u51 = nil;
    u52 = nil;
    u22 = 0;
end;

local function pointerAction(p62, p63, p64, p65) -- Line: 369
    -- upvalues: u25 (copy)
    if not p65 then
        u25.Wheel = p62;
        u25.Pan = p63;
        u25.Pinch = -p64;
    end;
end;

local function inputBegan(p66, p67) -- Line: 377
    -- upvalues: touchBegan (ref), u22 (ref)
    if p66.UserInputType == Enum.UserInputType.Touch then
        touchBegan(p66, p67);

        return;
    end;

    if p66.UserInputType == Enum.UserInputType.MouseButton2 and not p67 then
        u22 = math.max(0, u22 + 1);
    end;
end;

local function inputChanged(p68, p69) -- Line: 386
    -- upvalues: touchChanged (ref), u25 (copy)
    if p68.UserInputType == Enum.UserInputType.Touch then
        touchChanged(p68, p69);

        return;
    end;

    if p68.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = p68.Delta;
        u25.Movement = Vector2.new(Delta.X, Delta.Y);
    end;
end;

local function inputEnded(p70, p71) -- Line: 395
    -- upvalues: touchEnded (ref), u22 (ref)
    if p70.UserInputType == Enum.UserInputType.Touch then
        touchEnded(p70, p71);

        return;
    end;

    if p70.UserInputType == Enum.UserInputType.MouseButton2 then
        u22 = math.max(0, u22 - 1);
    end;
end;

local u72 = false;

function v20.setInputEnabled(p73) -- Line: 406
    -- upvalues: u72 (ref), resetInputDevices (copy), resetTouchState (ref), ContextActionService (copy), thumbstick (copy), Value (copy), keypress (copy), VRService (copy), gamepadReset (copy), gamepadZoomPress (copy), u21 (ref), UserInputService (copy), inputBegan (copy), inputChanged (copy), inputEnded (copy), pointerAction (copy), GuiService (copy)
    if u72 == p73 then
        return;
    end;

    u72 = p73;
    resetInputDevices();
    resetTouchState();

    if not u72 then
        ContextActionService:UnbindAction("RbxCameraThumbstick");
        ContextActionService:UnbindAction("RbxCameraMouseMove");
        ContextActionService:UnbindAction("RbxCameraMouseWheel");
        ContextActionService:UnbindAction("RbxCameraKeypress");
        ContextActionService:UnbindAction("RbxCameraGamepadZoom");

        if VRService.VREnabled then
            ContextActionService:UnbindAction("RbxCameraGamepadReset");
        end;

        for _, v in pairs(u21) do
            v:Disconnect();
        end;

        u21 = {};

        return;
    end;

    ContextActionService:BindActionAtPriority("RbxCameraThumbstick", thumbstick, false, Value, Enum.KeyCode.Thumbstick2);
    ContextActionService:BindActionAtPriority("RbxCameraKeypress", keypress, false, Value, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O);

    if VRService.VREnabled then
        ContextActionService:BindAction("RbxCameraGamepadReset", gamepadReset, false, Enum.KeyCode.ButtonL3);
    end;

    ContextActionService:BindAction("RbxCameraGamepadZoom", gamepadZoomPress, false, Enum.KeyCode.ButtonR3);
    table.insert(u21, UserInputService.InputBegan:Connect(inputBegan));
    table.insert(u21, UserInputService.InputChanged:Connect(inputChanged));
    table.insert(u21, UserInputService.InputEnded:Connect(inputEnded));
    table.insert(u21, UserInputService.PointerAction:Connect(pointerAction));
    table.insert(u21, GuiService.MenuOpened:connect(resetTouchState));
end;

function v20.getInputEnabled() -- Line: 475
    -- upvalues: u72 (ref)
    return u72;
end;

function v20.resetInputForFrameEnd() -- Line: 479
    -- upvalues: u25 (copy), u26 (copy)
    u25.Movement = Vector2.new();
    u26.Move = Vector2.new();
    u26.Pinch = 0;
    u25.Wheel = 0;
    u25.Pan = Vector2.new();
    u25.Pinch = 0;
end;

UserInputService.WindowFocused:Connect(resetInputDevices);
UserInputService.WindowFocusReleased:Connect(resetInputDevices);

if UserFlag2 then
    UserInputService.TextBoxFocusReleased:Connect(resetInputDevices);
end;

local u74 = false;
local u75 = false;
local u76 = 0;

function v20.getHoldPan() -- Line: 503
    -- upvalues: u74 (ref)
    return u74;
end;

function v20.getTogglePan() -- Line: 507
    -- upvalues: u75 (ref)
    return u75;
end;

function v20.getPanning() -- Line: 511
    -- upvalues: u75 (ref), u74 (ref)
    return u75 or u74;
end;

function v20.setTogglePan(p77: boolean) -- Line: 515
    -- upvalues: u75 (ref)
    u75 = p77;
end;

local u78 = false;
local u79 = nil;
local u80 = nil;

function v20.enableCameraToggleInput() -- Line: 523
    -- upvalues: u78 (ref), u74 (ref), u75 (ref), u79 (ref), u80 (ref), Event (ref), u76 (ref), Event2 (ref), UserInputService (copy)
    if u78 then
        return;
    end;

    u78 = true;
    u74 = false;
    u75 = false;

    if u79 then
        u79:Disconnect();
    end;

    if u80 then
        u80:Disconnect();
    end;

    u79 = Event:Connect(function() -- Line: 540
        -- upvalues: u74 (ref), u76 (ref)
        u74 = true;
        u76 = tick();
    end);
    u80 = Event2:Connect(function() -- Line: 545
        -- upvalues: u74 (ref), u76 (ref), u75 (ref), UserInputService (ref)
        u74 = false;

        if tick() - u76 < 0.3 and (u75 or UserInputService:GetMouseDelta().Magnitude < 2) then
            u75 = not u75;
        end;
    end);
end;

function v20.disableCameraToggleInput() -- Line: 553
    -- upvalues: u78 (ref), u79 (ref), u80 (ref)
    if not u78 then
        return;
    end;

    u78 = false;

    if u79 then
        u79:Disconnect();
        u79 = nil;
    end;

    if u80 then
        u80:Disconnect();
        u80 = nil;
    end;
end;

return v20;