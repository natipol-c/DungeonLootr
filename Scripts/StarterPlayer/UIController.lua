--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UIController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.UIController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local GamepadService = game:GetService("GamepadService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local workspace_CurrentCamera = workspace.CurrentCamera;
local FieldOfView = workspace_CurrentCamera.FieldOfView;
local spr = require(script.Parent.Parent.ClientUtils.spr);
local BlurEffect = Instance.new("BlurEffect");
BlurEffect.Name = "UIBlur";
BlurEffect.Size = 0;
BlurEffect.Parent = game.Lighting;
Players.LocalPlayer:SetAttribute("OpenWindow", nil);

local function buildHeaderTransparency(p1: number) -- Line: 48
    return NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(math.clamp(p1 * 0.8025 + 0.0975, 0.001, 0.999), (math.clamp(p1 * -1 + 1, 0, 1))), NumberSequenceKeypoint.new(1, 1) });
end;

local function findHeaderGradient(p2: userdata) -- Line: 59
    local Header_Group = p2:FindFirstChild("Header_Group");

    return Header_Group and Header_Group:FindFirstChildWhichIsA("UIGradient") or nil;
end;

local SFX = SoundService:WaitForChild("SFX");

local function playFrameSound(p3: string) -- Line: 69
    -- upvalues: SFX (copy)
    local v4 = SFX:FindFirstChild(p3);

    if v4 and v4:IsA("Sound") then
        v4:Play();
    end;
end;

local u5 = {
    currentWindow = nil,
    _cached = {},
    exceptions = {},
    _cachedHUD = {},
    _cachedBottom = {},
    names = {}
};
u5.__index = u5;

function u5.new(p6: userdata, p7: any) -- Line: 80
    -- upvalues: u5 (copy), buildHeaderTransparency (copy)
    if u5._cached[p6] then
        u5._cached[p6]:destroy();
    end;

    local v8 = setmetatable({}, u5);
    v8._frame = p6;
    v8.isOpen = v8._frame.Visible;
    v8.hiddenInstances = {};
    v8.onClose = nil;
    v8.originalPosition = v8._frame.Position;
    v8.orginalSize = v8._frame.Size;
    local Header_Group = v8._frame:FindFirstChild("Header_Group");
    local u9 = Header_Group and Header_Group:FindFirstChildWhichIsA("UIGradient") or nil;

    if u9 then
        v8.headerGradient = u9;
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Name = "_HeaderRevealAlpha";
        NumberValue.Value = 0;
        NumberValue.Parent = u9;
        NumberValue.Changed:Connect(function(p10) -- Line: 105
            -- upvalues: u9 (copy), buildHeaderTransparency (ref)
            u9.Transparency = buildHeaderTransparency(p10);
        end);
        v8.headerAlpha = NumberValue;
        u9.Transparency = buildHeaderTransparency(0);
    end;

    u5._cached[p6] = v8;
    u5.names[p6.Name] = v8;

    return v8;
end;

function u5.closeAll() -- Line: 118
    -- upvalues: u5 (copy)
    for _, v in pairs(u5._cached) do
        if v.isOpen and not u5.exceptions[v._frame] then
            v:close();
        end;
    end;
end;

function u5.open(u11) -- Line: 126
    -- upvalues: u5 (copy), spr (copy), SFX (copy), SoundService (copy)
    u5.closeAll();
    u11._frame.Position = UDim2.new(u11.originalPosition.X.Scale, u11.originalPosition.X.Offset, u11.originalPosition.Y.Scale * -2, u11.originalPosition.Y.Offset);
    spr.target(u11._frame, 0.8, 3, {
        Position = u11.originalPosition,
        Size = u11.orginalSize
    });
    u11._frame.Visible = true;
    u11.isOpen = true;

    if u11.headerAlpha then
        spr.stop(u11.headerAlpha);
        u11.headerAlpha.Value = 0;
        u11._headerRevealToken = (u11._headerRevealToken or 0) + 1;
        local _headerRevealToken = u11._headerRevealToken;
        task.delay(0.25, function() -- Line: 152
            -- upvalues: u11 (copy), _headerRevealToken (copy), spr (ref)
            if u11._headerRevealToken == _headerRevealToken and u11.isOpen then
                spr.target(u11.headerAlpha, 0.8, 1.7, {
                    Value = 1
                });
            end;
        end);
    end;

    local Frame_Open = SFX:FindFirstChild("Frame_Open");

    if Frame_Open and Frame_Open:IsA("Sound") then
        Frame_Open:Play();
    end;

    u11.sound = SoundService.Frames:FindFirstChild(u11._frame.Name) or nil;

    if u11._frame:GetAttribute("HideHUD") then
        u5.hideHUD();
    elseif u11._frame:GetAttribute("HideBottom") then
        u5.hideBottom();
    else
        u5.showHUD();
    end;

    if u11._frame:GetAttribute("HideActions") then
        u5.hideActionsAndPlay();
    end;

    u5.currentWindow = u11;
    u5.update();

    if u11.sound then
        u11.sound:Play();
    end;
end;

function u5.close(p12) -- Line: 184
    -- upvalues: LocalPlayer (copy), spr (copy), SFX (copy), u5 (copy)
    if LocalPlayer:GetAttribute("LockWindow") then
        return;
    end;

    if p12.onClose then
        p12.onClose();
    end;

    for _, v in p12.hiddenInstances do
        spr.target(v[1], 0.8, 3, {
            Position = v[2]
        });
    end;

    p12._frame.Visible = false;
    p12.isOpen = false;

    if p12.headerAlpha then
        spr.stop(p12.headerAlpha);
        p12.headerAlpha.Value = 0;
        p12._headerRevealToken = (p12._headerRevealToken or 0) + 1;
    end;

    local Frame_Close = SFX:FindFirstChild("Frame_Close");

    if Frame_Close and Frame_Close:IsA("Sound") then
        Frame_Close:Play();
    end;

    if p12._frame:GetAttribute("HideHUD") then
        u5.showHUD();
    elseif p12._frame:GetAttribute("HideBottom") then
        u5.showBottom();
    end;

    if p12._frame:GetAttribute("HideActions") then
        u5.showActionsAndPlay();
    end;

    u5.currentWindow = nil;
    u5.update();
end;

function u5.destroy(p13) -- Line: 224
    -- upvalues: u5 (copy)
    p13._frame:Destroy();
    u5._cached[p13._frame] = nil;
end;

function u5.toggle(p14) -- Line: 229
    if p14.isOpen then
        p14:close();

        return;
    end;

    p14:open();
end;

function u5.getByName(p15) -- Line: 237
    -- upvalues: u5 (copy)
    for _, v in pairs(u5._cached) do
        if v._frame.Name == p15 then
            return v;
        end;
    end;

    return nil;
end;

function u5.getOpenFrames() -- Line: 246
    -- upvalues: u5 (copy)
    local v16 = {};

    for _, v in pairs(u5._cached) do
        if v.isOpen then
            table.insert(v16, v._frame);
        end;
    end;

    return v16;
end;

function u5.update() -- Line: 256
    -- upvalues: u5 (copy), spr (copy), workspace_CurrentCamera (copy), FieldOfView (copy), BlurEffect (copy), Players (copy), UserInputService (copy), GamepadService (copy)
    local OpenFrames = u5.getOpenFrames();
    local v17 = #OpenFrames > 0;
    local v18 = 0;

    for _, v in OpenFrames do
        local v19 = u5._cached[v];

        if v19 and not v19.noBlur then
            v18 = v18 + 1;
        end;
    end;

    if v18 > 0 then
        spr.target(workspace_CurrentCamera, 1, 5, {
            FieldOfView = 60
        });
    elseif v17 then
        spr.stop(workspace_CurrentCamera, "FieldOfView");
    else
        spr.target(workspace_CurrentCamera, 1, 5, {
            FieldOfView = FieldOfView
        });
    end;

    spr.target(BlurEffect, 1, 5, {
        Size = v18 > 0 and 10 or 0
    });
    Players.LocalPlayer:SetAttribute("OpenWindow", v17);
    local LastInputType = UserInputService:GetLastInputType();

    if (LastInputType == Enum.UserInputType.Gamepad1 or (LastInputType == Enum.UserInputType.Gamepad2 or LastInputType == Enum.UserInputType.Gamepad3)) and true or LastInputType == Enum.UserInputType.Gamepad4 then
        if v17 then
            if not GamepadService.GamepadCursorEnabled then
                GamepadService:EnableGamepadCursor(nil);
            end;
        elseif GamepadService.GamepadCursorEnabled then
            GamepadService:DisableGamepadCursor();
        end;
    end;
end;

local Main = PlayerGui:WaitForChild("Main");
local HUD = Main:WaitForChild("HUD");
local Actions = HUD:FindFirstChild("Actions");
local Play = HUD:FindFirstChild("Play");
local u20 = false;
local u21 = true;
local u22 = true;
local Frames = Main:FindFirstChild("Frames");

if Frames then
    for _, child in Frames:GetChildren() do
        local Header_Group = child:FindFirstChild("Header_Group");
        local v23 = Header_Group and Header_Group:FindFirstChildWhichIsA("UIGradient") or nil;

        if v23 then
            v23.Transparency = buildHeaderTransparency(0);
        end;
    end;
end;

local function registerHideTarget(p24) -- Line: 350
    -- upvalues: u5 (copy)
    local Attribute = p24:GetAttribute("Hide");

    if not Attribute then
        return;
    end;

    p24:SetAttribute("OriginalPosition", p24.Position);

    if Attribute == "Bottom" then
        table.insert(u5._cachedBottom, p24);
    end;

    table.insert(u5._cachedHUD, p24);
end;

for _, child in HUD:GetChildren() do
    local Attribute = child:GetAttribute("Hide");

    if Attribute then
        child:SetAttribute("OriginalPosition", child.Position);

        if Attribute == "Bottom" then
            table.insert(u5._cachedBottom, child);
        end;

        table.insert(u5._cachedHUD, child);
    end;
end;

local Actions2 = HUD:FindFirstChild("Actions");

if Actions2 then
    for _, child in Actions2:GetChildren() do
        local Attribute = child:GetAttribute("Hide");

        if Attribute then
            child:SetAttribute("OriginalPosition", child.Position);

            if Attribute == "Bottom" then
                table.insert(u5._cachedBottom, child);
            end;

            table.insert(u5._cachedHUD, child);
        end;
    end;
end;

function u5.showButtons() -- Line: 371
    -- upvalues: u5 (copy), spr (copy)
    for _, v in u5._cachedHUD do
        spr.target(v, 0.8, 2, {
            Position = v:GetAttribute("OriginalPosition")
        });
    end;
end;

function u5.hideButtons() -- Line: 379
    -- upvalues: u5 (copy), spr (copy)
    for _, v in ipairs(u5._cachedHUD) do
        local Attribute = v:GetAttribute("OriginalPosition");
        local Attribute2 = v:GetAttribute("Hide");

        if Attribute2 == "Left" then
            Attribute = UDim2.new(-1, 0, Attribute.Y.Scale, Attribute.Y.Offset);
        elseif Attribute2 == "Right" then
            Attribute = UDim2.new(2, 0, Attribute.Y.Scale, Attribute.Y.Offset);
        elseif Attribute2 == "Up" then
            Attribute = UDim2.new(Attribute.X.Scale, Attribute.X.Offset, -1, 0);
        elseif Attribute2 == "Bottom" then
            Attribute = UDim2.fromScale(Attribute.X.Scale, Attribute.Y.Scale + 1);
        end;

        spr.target(v, 0.8, 2, {
            Position = Attribute
        });
    end;
end;

function u5.hideBottom() -- Line: 399
    -- upvalues: u5 (copy), spr (copy)
    for _, v in ipairs(u5._cachedHUD) do
        if v.Name == "Bottom" then
            local Attribute = v:GetAttribute("OriginalPosition");
            local Attribute2 = v:GetAttribute("Hide");

            if Attribute2 == "Left" then
                Attribute = UDim2.new(-1, 0, Attribute.Y.Scale, Attribute.Y.Offset);
            elseif Attribute2 == "Right" then
                Attribute = UDim2.new(1, 0, Attribute.Y.Scale, Attribute.Y.Offset);
            elseif Attribute2 == "Up" then
                Attribute = UDim2.new(Attribute.X.Scale, Attribute.X.Offset, -1, 0);
            elseif Attribute2 == "Bottom" then
                Attribute = UDim2.fromScale(Attribute.X.Scale, Attribute.Y.Scale + 1);
            end;

            spr.target(v, 0.8, 2, {
                Position = Attribute
            });
        end;
    end;
end;

function u5.showBottom() -- Line: 422
    -- upvalues: u5 (copy), spr (copy)
    for _, v in u5._cachedHUD do
        if v.Name == "Bottom" then
            spr.target(v, 0.8, 2, {
                Position = v:GetAttribute("OriginalPosition")
            });
        end;
    end;
end;

function u5.showHUD() -- Line: 433
    -- upvalues: u5 (copy)
    u5.showButtons();
end;

function u5.hideHUD() -- Line: 437
    -- upvalues: u5 (copy)
    u5.hideButtons();
end;

function u5.hideActionsAndPlay() -- Line: 446
    -- upvalues: u20 (ref), Actions (copy), u21 (ref), Play (copy), u22 (ref)
    if u20 then
        return;
    end;

    u20 = true;

    if Actions then
        u21 = Actions.Visible;
        Actions.Visible = false;
    end;

    if Play then
        u22 = Play.Visible;
        Play.Visible = false;
    end;
end;

function u5.showActionsAndPlay() -- Line: 459
    -- upvalues: u20 (ref), Actions (copy), u21 (ref), Play (copy), u22 (ref)
    if not u20 then
        return;
    end;

    u20 = false;

    if Actions then
        Actions.Visible = u21;
    end;

    if Play then
        Play.Visible = u22;
    end;
end;

return u5;