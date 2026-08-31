--[[
  Type:     LocalScript
  Method:   decompile
  Name:     CameraClient
  Path:     game.StarterPlayer.StarterPlayerScripts.CameraClient
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:12 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = false;
local Enums = require(ReplicatedStorage.Globals.Modules.Enums);
local ConnectionManager = require(ReplicatedStorage.Globals.Modules.ConnectionManager);
local Spring = require(ReplicatedStorage.Modules.Spring);
require(script.Parent:WaitForChild("PlayerModule")):GetCameras();
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"));
local u8 = nil;

local function GetIBC() -- Line: 40
    -- upvalues: u8 (ref), Knit (copy)
    if u8 then
        return u8;
    end;

    local success, result = pcall(function() -- Line: 42
        -- upvalues: Knit (ref)
        return Knit.GetController("InputBindingController");
    end);

    if success then
        u8 = result;
    end;

    return u8;
end;

local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0);
local Camera = ConnectionManager.new("Camera");
local FreeLook = Enums.CameraState.FreeLook;
local script_Offset = script.Offset;
Spring.new(Vector3.new(0, 0, 0), 1, 12);
Spring.new(Vector3.new(0, 0, 0), 1, 12);
local u9 = {
    [Enums.CameraState.FreeLook] = {
        Value = CFrame.new(0, 0, 0)
    },
    [Enums.CameraState.ShiftLock] = {
        Value = CFrame.new(3.5, 0, 0)
    }
};
local u10 = 0;
local u11 = Vector3.new(0, 0, 0);
local u12 = 0;
local u13 = 0;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;

local function GetSettingsController() -- Line: 110
    -- upvalues: u22 (ref), Knit (copy)
    if u22 then
        return u22;
    end;

    local success, result = pcall(function() -- Line: 113
        -- upvalues: Knit (ref)
        return Knit.GetController("SettingsController");
    end);

    if success then
        u22 = result;
    end;

    return u22;
end;

local function ShouldReduceMotion() -- Line: 123
    -- upvalues: u22 (ref), Knit (copy)
    local v23;

    if u22 then
        v23 = u22;
    else
        local success, result = pcall(function() -- Line: 113
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u22 = result;
        end;

        v23 = u22;
    end;

    if v23 then
        return v23:ShouldReduceMotion();
    end;

    return false;
end;

local u24 = Spring.new(0, 1, 12);

local function UnwrapAngle(p25: number, p26: number) -- Line: 134
    local v27 = p25 - p26;

    while v27 > 3.141592653589793 do
        p25 = p25 - 6.283185307179586;
        v27 = p25 - p26;
    end;

    while v27 < -3.141592653589793 do
        p25 = p25 + 6.283185307179586;
        v27 = p25 - p26;
    end;

    return p25;
end;

local function SyncFacingSpringToRoot() -- Line: 149
    -- upvalues: u3 (ref), u24 (copy)
    if not u3 then
        return;
    end;

    local LookVector = u3.CFrame.LookVector;
    u24:Reset((math.atan2(-LookVector.X, -LookVector.Z)));
end;

local TouchEnabled = UserInputService.TouchEnabled;
local u28 = false;
local u29 = 0;
local u30 = false;
local u31 = nil;
local u32 = nil;

local function IsAutoShiftLockEnabled() -- Line: 176
    -- upvalues: u22 (ref), Knit (copy)
    local v33;

    if u22 then
        v33 = u22;
    else
        local success, result = pcall(function() -- Line: 113
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u22 = result;
        end;

        v33 = u22;
    end;

    return not v33 and true or v33:IsEnabled("AutoShiftLock");
end;

local function HandleAutoShiftLock() -- Line: 182
    -- upvalues: TouchEnabled (copy), u1 (ref), u22 (ref), Knit (copy), LocalPlayer (copy), u28 (ref), FreeLook (ref), Enums (copy), u32 (ref), u30 (ref), u29 (ref), u31 (ref)
    if not (TouchEnabled and u1) then
        return;
    end;

    local v34;

    if u22 then
        v34 = u22;
    else
        local success, result = pcall(function() -- Line: 113
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u22 = result;
        end;

        v34 = u22;
    end;

    if v34 and not v34:IsEnabled("AutoShiftLock") or LocalPlayer:GetAttribute("Disable_ShiftLock") then
        if u28 then
            u28 = false;

            if FreeLook == Enums.CameraState.ShiftLock and not LocalPlayer:GetAttribute("Disable_ShiftLock") then
                u32();
            end;
        end;

        u30 = false;

        return;
    end;

    local v35 = u1:GetAttribute("Combat_Facing") or false;
    local v36 = tick();

    if v35 then
        u29 = v36;

        if not u30 and FreeLook ~= Enums.CameraState.ShiftLock then
            u28 = true;
            u31();
        end;
    elseif u28 and v36 - u29 > 1 then
        u28 = false;
        u32();
    end;

    u30 = v35;
end;

local function TweenOnce(p37: userdata, p38: table) -- Line: 221
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    local u39 = TweenService:Create(p37, TweenInfo_new_ret, p38);
    u39:Play();
    u39.Completed:Once(function(p40) -- Line: 224
        -- upvalues: u39 (copy)
        u39:Destroy();
    end);
end;

local function OnPreRender(p41: number) -- Line: 227
    -- upvalues: workspace_CurrentCamera (copy), u5 (ref), u6 (ref), u7 (ref), u10 (ref), u11 (ref), u12 (ref), u3 (ref), u24 (copy), HandleAutoShiftLock (copy), script_Offset (copy), u1 (ref), u2 (ref), u4 (ref), FreeLook (ref), Enums (copy), u22 (ref), Knit (copy), LocalPlayer (copy), u13 (ref)
    if workspace_CurrentCamera.CameraType ~= Enum.CameraType.Custom then
        if u5 and (u6 and u7) then
            u5.C0 = u6;
        end;

        u10 = 0;
        u11 = Vector3.new(0, 0, 0);
        u12 = 0;

        if not u3 then
            return;
        end;

        local LookVector = u3.CFrame.LookVector;
        u24:Reset((math.atan2(-LookVector.X, -LookVector.Z)));

        return;
    end;

    HandleAutoShiftLock();
    local v42 = workspace_CurrentCamera;
    v42.CFrame = v42.CFrame * script_Offset.Value;
    local v43 = u1 and u1:GetAttribute("IsTheft");
    local v44 = u1 and u1:GetAttribute("Blocking");

    if not u3 or (not u2 or (not u4 or (not u5 or (FreeLook ~= Enums.CameraState.ShiftLock or v43)))) then
        if u5 and (u6 and u7) then
            u5.C0 = u6;
        end;

        u10 = 0;
        u11 = Vector3.new(0, 0, 0);
        u12 = 0;

        if not u3 then
            return;
        end;

        local LookVector = u3.CFrame.LookVector;
        u24:Reset((math.atan2(-LookVector.X, -LookVector.Z)));

        return;
    end;

    local v45 = u1 and u1:GetAttribute("Skill_Camera_Stabilize");

    if v44 or v45 then
        if u3 then
            local LookVector = u3.CFrame.LookVector;
            u24:Reset((math.atan2(-LookVector.X, -LookVector.Z)));
        end;
    else
        local LookVector = workspace_CurrentCamera.CFrame.LookVector;
        local math_atan2_ret = math.atan2(-LookVector.X, -LookVector.Z);
        local Position = u24.Position;
        local v46 = math_atan2_ret - Position;

        while v46 > 3.141592653589793 do
            math_atan2_ret = math_atan2_ret - 6.283185307179586;
            v46 = math_atan2_ret - Position;
        end;

        while v46 < -3.141592653589793 do
            math_atan2_ret = math_atan2_ret + 6.283185307179586;
            v46 = math_atan2_ret - Position;
        end;

        u24.Target = math_atan2_ret;
        local Position2 = u24.Position;
        local v47 = -math.sin(Position2);
        local v48 = -math.cos(Position2);
        local Vector3_new_ret = Vector3.new(v47, 0, v48);
        u3.CFrame = CFrame.new(u3.Position, u3.Position + Vector3_new_ret);
    end;

    local v49;

    if u22 then
        v49 = u22;
    else
        local success, result = pcall(function() -- Line: 113
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u22 = result;
        end;

        v49 = u22;
    end;

    local v50;

    if v49 then
        v50 = v49:ShouldReduceMotion();
    else
        v50 = false;
    end;

    local v51 = 0;

    if not v50 then
        local MoveDirection = u2.MoveDirection;

        if MoveDirection.Magnitude > 0.1 then
            local RightVector = workspace_CurrentCamera.CFrame.RightVector;
            v51 = -MoveDirection:Dot(Vector3.new(RightVector.X, 0, RightVector.Z).Unit) * 25;
        end;
    end;

    local v52 = v51 - u10;

    if math.abs(v52) < 0.5 then
        u10 = v51;
    else
        u10 = u10 + v52 * math.min(1, p41 * 10);
    end;

    if u7 then
        u5.C0 = u6 * CFrame.Angles(0, 0, (math.rad(u10)));
    end;

    local v53;

    if v50 then
        v53 = Vector3.new(0, 0, 0);
    else
        local AssemblyLinearVelocity = u3.AssemblyLinearVelocity;
        v53 = -Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z) * 0.025;

        if v53.Magnitude > 4 then
            v53 = v53.Unit * 4;
        end;
    end;

    u11 = u11 + (v53 - u11) * math.min(1, p41 * 14);
    local v54 = Vector3.new(0, 0, 0);

    if v50 or v45 then
        u12 = u12 + (0 - u12) * math.min(1, p41 * 5);
    else
        local Attribute = u1:GetAttribute("Combat_Facing");
        local Attribute2 = LocalPlayer:GetAttribute("Sprint_Active");
        local v55 = tick();

        if Attribute then
            u13 = v55;
        end;

        u12 = u12 + (((not Attribute and (not Attribute2 and v55 - u13 >= 0.8) and true or false) and (u2.MoveDirection.Magnitude > 0.1 and 0.12 or 0) or (Attribute2 and 0.55 or 0.5)) - u12) * math.min(1, p41 * 5);
        v54 = (u4.Position - (u3.Position + Vector3.new(0, 1.5, 0))) * u12;
    end;

    workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame + (u11 + v54);
end;

local u56 = false;

u32 = function() -- Line: 422, Name: ForceFreeLook
    -- upvalues: FreeLook (ref), Enums (copy), UserInputService (copy), script_Offset (copy), u9 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    FreeLook = Enums.CameraState.FreeLook;
    UserInputService.MouseIcon = "";
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
    local u57 = TweenService:Create(script_Offset, TweenInfo_new_ret, u9[Enums.CameraState.FreeLook]);
    u57:Play();
    u57.Completed:Once(function(p58) -- Line: 224
        -- upvalues: u57 (copy)
        u57:Destroy();
    end);
end;

u31 = function() -- Line: 429, Name: ForceShiftLock
    -- upvalues: FreeLook (ref), Enums (copy), UserInputService (copy), script_Offset (copy), u9 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    FreeLook = Enums.CameraState.ShiftLock;
    UserInputService.MouseIcon = "rbxassetid://103527662950355";
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
    local u59 = TweenService:Create(script_Offset, TweenInfo_new_ret, u9[Enums.CameraState.ShiftLock]);
    u59:Play();
    u59.Completed:Once(function(p60) -- Line: 224
        -- upvalues: u59 (copy)
        u59:Destroy();
    end);
end;

LocalPlayer:GetAttributeChangedSignal("Disable_ShiftLock"):Connect(function() -- Line: 436
    -- upvalues: LocalPlayer (copy), u56 (ref), FreeLook (ref), Enums (copy), u32 (ref), u31 (ref)
    if LocalPlayer:GetAttribute("Disable_ShiftLock") then
        u56 = FreeLook == Enums.CameraState.ShiftLock;

        if u56 then
            u32();
        end;
    elseif u56 then
        u31();
        u56 = false;
    end;
end);

local function OnPressed() -- Line: 453
    -- upvalues: LocalPlayer (copy), u28 (ref), FreeLook (ref), Enums (copy), UserInputService (copy), script_Offset (copy), u9 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    if LocalPlayer:GetAttribute("Disable_ShiftLock") then
        return;
    end;

    u28 = false;
    local v61 = FreeLook == Enums.CameraState.ShiftLock;
    FreeLook = v61 and Enums.CameraState.FreeLook or Enums.CameraState.ShiftLock;
    UserInputService.MouseIcon = v61 and "" or "rbxassetid://103527662950355";
    UserInputService.MouseBehavior = not v61 and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default;
    local u62 = TweenService:Create(script_Offset, TweenInfo_new_ret, u9[FreeLook]);
    u62:Play();
    u62.Completed:Once(function(p63) -- Line: 224
        -- upvalues: u62 (copy)
        u62:Destroy();
    end);
end;

local function cleanupZoomTween() -- Line: 474
    -- upvalues: u15 (ref), u17 (ref), u16 (ref)
    if u15 then
        u15:Cancel();
        u15 = nil;
    end;

    if u17 then
        u17:Disconnect();
        u17 = nil;
    end;

    if u16 then
        u16:Destroy();
        u16 = nil;
    end;
end;

local function IsSprintZoomDisabled() -- Line: 489
    -- upvalues: u22 (ref), Knit (copy)
    local v64;

    if u22 then
        v64 = u22;
    else
        local success, result = pcall(function() -- Line: 113
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u22 = result;
        end;

        v64 = u22;
    end;

    return v64 and v64:IsEnabled("DisableSprintZoom") or false;
end;

local function StartSprintCamera() -- Line: 494
    -- upvalues: u14 (ref), u15 (ref), u17 (ref), u16 (ref), TweenService (copy), workspace_CurrentCamera (copy), u22 (ref), Knit (copy), u18 (ref), LocalPlayer (copy), u19 (ref), u20 (ref)
    if u14 then
        u14:Cancel();
    end;

    if u15 then
        u15:Cancel();
        u15 = nil;
    end;

    if u17 then
        u17:Disconnect();
        u17 = nil;
    end;

    if u16 then
        u16:Destroy();
        u16 = nil;
    end;

    local TweenInfo_new_ret2 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u14 = TweenService:Create(workspace_CurrentCamera, TweenInfo_new_ret2, {
        FieldOfView = 80
    });
    u14:Play();
    local v65;

    if u22 then
        v65 = u22;
    else
        local success, result = pcall(function() -- Line: 113
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u22 = result;
        end;

        v65 = u22;
    end;

    if v65 and v65:IsEnabled("DisableSprintZoom") or false then
        return;
    end;

    u18 = u18 or LocalPlayer.CameraMaxZoomDistance;
    u19 = u19 or LocalPlayer.CameraMinZoomDistance;
    u20 = u20 or (workspace_CurrentCamera.CFrame.Position - workspace_CurrentCamera.Focus.Position).Magnitude;
    local Magnitude = (workspace_CurrentCamera.CFrame.Position - workspace_CurrentCamera.Focus.Position).Magnitude;

    if Magnitude <= 12 then
        LocalPlayer.CameraMaxZoomDistance = 12;
        LocalPlayer.CameraMinZoomDistance = 12;

        return;
    end;

    u16 = Instance.new("NumberValue");
    u16.Value = Magnitude;
    u15 = TweenService:Create(u16, TweenInfo_new_ret2, {
        Value = 12
    });
    u17 = u16.Changed:Connect(function(p66) -- Line: 525
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.CameraMaxZoomDistance = p66;
        LocalPlayer.CameraMinZoomDistance = p66;
    end);
    u15.Completed:Once(function(p67) -- Line: 531
        -- upvalues: u15 (ref), u17 (ref), u16 (ref), LocalPlayer (ref)
        if p67 == Enum.PlaybackState.Cancelled then
            return;
        end;

        if u15 then
            u15:Cancel();
            u15 = nil;
        end;

        if u17 then
            u17:Disconnect();
            u17 = nil;
        end;

        if u16 then
            u16:Destroy();
            u16 = nil;
        end;

        LocalPlayer.CameraMaxZoomDistance = 12;
        LocalPlayer.CameraMinZoomDistance = 12;
    end);
    u15:Play();
end;

local function StopSprintCamera() -- Line: 545
    -- upvalues: u14 (ref), u15 (ref), u17 (ref), u16 (ref), TweenService (copy), workspace_CurrentCamera (copy), u18 (ref), u19 (ref), u20 (ref), LocalPlayer (copy)
    if u14 then
        u14:Cancel();
    end;

    if u15 then
        u15:Cancel();
        u15 = nil;
    end;

    if u17 then
        u17:Disconnect();
        u17 = nil;
    end;

    if u16 then
        u16:Destroy();
        u16 = nil;
    end;

    local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
    u14 = TweenService:Create(workspace_CurrentCamera, TweenInfo_new_ret2, {
        FieldOfView = 70
    });
    u14:Play();

    if not u18 then
        return;
    end;

    local v68 = u18 or 128;
    local u69 = u19 or 0.5;
    local v70 = u20 or v68;
    LocalPlayer.CameraMaxZoomDistance = v68;
    LocalPlayer.CameraMinZoomDistance = u69;
    u18 = nil;
    u19 = nil;
    u20 = nil;
    local Magnitude = (workspace_CurrentCamera.CFrame.Position - workspace_CurrentCamera.Focus.Position).Magnitude;

    if v70 - Magnitude > 0.5 then
        u16 = Instance.new("NumberValue");
        u16.Value = Magnitude;
        u15 = TweenService:Create(u16, TweenInfo_new_ret2, {
            Value = v70
        });
        u17 = u16.Changed:Connect(function(p71) -- Line: 585
            -- upvalues: LocalPlayer (ref)
            LocalPlayer.CameraMinZoomDistance = p71;
        end);
        u15.Completed:Once(function(p72) -- Line: 592
            -- upvalues: u15 (ref), u17 (ref), u16 (ref), LocalPlayer (ref), u69 (copy)
            if u15 then
                u15:Cancel();
                u15 = nil;
            end;

            if u17 then
                u17:Disconnect();
                u17 = nil;
            end;

            if u16 then
                u16:Destroy();
                u16 = nil;
            end;

            LocalPlayer.CameraMinZoomDistance = u69;
        end);
        u15:Play();
    end;
end;

local function OnCharacterAdded(p73: userdata) -- Line: 601
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u24 (copy), u15 (ref), u17 (ref), u16 (ref), u14 (ref), workspace_CurrentCamera (copy), u18 (ref), LocalPlayer (copy), u19 (ref), u20 (ref), u21 (ref), StartSprintCamera (copy), StopSprintCamera (copy)
    u1 = p73;
    u2 = u1:WaitForChild("Humanoid");
    u3 = u1:WaitForChild("HumanoidRootPart");
    u4 = u1:WaitForChild("Head");

    if u1:FindFirstChild("Torso") then
        u5 = u3:WaitForChild("RootJoint");
    else
        u5 = u1:WaitForChild("UpperTorso"):WaitForChild("Waist");
    end;

    u6 = u5.C0;
    u7 = pcall(function() -- Line: 622
        -- upvalues: u5 (ref), u6 (ref)
        u5.C0 = u6;
    end);
    u10 = 0;
    u11 = Vector3.new(0, 0, 0);
    u12 = 0;
    u13 = 0;

    if u3 then
        local LookVector = u3.CFrame.LookVector;
        u24:Reset((math.atan2(-LookVector.X, -LookVector.Z)));
    end;

    if u15 then
        u15:Cancel();
        u15 = nil;
    end;

    if u17 then
        u17:Disconnect();
        u17 = nil;
    end;

    if u16 then
        u16:Destroy();
        u16 = nil;
    end;

    if u14 then
        u14:Cancel();
        u14 = nil;
    end;

    workspace_CurrentCamera.FieldOfView = 70;

    if u18 then
        LocalPlayer.CameraMaxZoomDistance = u18;
        u18 = nil;
    end;

    if u19 then
        LocalPlayer.CameraMinZoomDistance = u19;
        u19 = nil;
    end;

    u20 = nil;

    if u21 then
        u21:Disconnect();
        u21 = nil;
    end;

    u21 = LocalPlayer:GetAttributeChangedSignal("Sprint_Active"):Connect(function() -- Line: 653
        -- upvalues: LocalPlayer (ref), StartSprintCamera (ref), StopSprintCamera (ref)
        if LocalPlayer:GetAttribute("Sprint_Active") then
            StartSprintCamera();

            return;
        end;

        StopSprintCamera();
    end);
    workspace_CurrentCamera.CameraSubject = u2;
end;

OnCharacterAdded(u1);
workspace_CurrentCamera.CameraSubject = u2;
workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
RunService:BindToRenderStep("CameraClient", Enum.RenderPriority.Camera.Value + 1, OnPreRender);
Camera:AddConnection("Character", LocalPlayer.CharacterAdded:Connect(OnCharacterAdded));
Camera:AddConnection("OnLeaving", Players.PlayerRemoving:Connect(function(p74: userdata) -- Line: 665, Name: OnPlayerRemoving
    -- upvalues: LocalPlayer (copy), Camera (copy), u9 (copy), Enums (copy), RunService (copy)
    if p74.UserId ~= LocalPlayer.UserId then
        return;
    end;

    Camera:ReleaseAll();
    table.clear(u9[Enums.CameraState.FreeLook]);
    table.clear(u9[Enums.CameraState.ShiftLock]);
    table.clear(u9);
    RunService:UnbindFromRenderStep("CameraClient");
end));
Camera:AddConnection("MobileToggle", LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main"):WaitForChild("HUD"):WaitForChild("MobileActions"):WaitForChild("Camera").Activated:Connect(OnPressed));
Camera:AddConnection("ShiftLock", UserInputService.InputBegan:Connect(function(p75, p76) -- Line: 701
    -- upvalues: u8 (ref), Knit (copy), UserInputService (copy), OnPressed (copy)
    if p76 then
        return;
    end;

    local v77;

    if u8 then
        v77 = u8;
    else
        local success, result = pcall(function() -- Line: 42
            -- upvalues: Knit (ref)
            return Knit.GetController("InputBindingController");
        end);

        if success then
            u8 = result;
        end;

        v77 = u8;
    end;

    if not v77 then
        return;
    end;

    if (p75.UserInputType == Enum.UserInputType.Gamepad1 or (p75.UserInputType == Enum.UserInputType.Gamepad2 or p75.UserInputType == Enum.UserInputType.Gamepad3)) and true or p75.UserInputType == Enum.UserInputType.Gamepad4 then
        local v78 = v77:GetKey("ShiftLock", "Gamepad") or "";

        if string.find(v78, "+", 1, true) then
            local string_split_ret = string.split(v78, "+");
            local Name = p75.KeyCode.Name;
            local v79 = false;

            for _, v in string_split_ret do
                if v == Name then
                    v79 = true;
                    break;
                end;
            end;

            if not v79 then
                return;
            end;

            for _, v in string_split_ret do
                local v80 = Enum.KeyCode[v];

                if not v80 then
                    return;
                end;

                if not UserInputService:IsGamepadButtonDown(p75.UserInputType, v80) then
                    return;
                end;
            end;

            OnPressed();

            return;
        end;
    end;

    if v77:GetActionForInput(p75) == "ShiftLock" then
        OnPressed();
    end;
end));