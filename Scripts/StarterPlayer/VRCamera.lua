--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VRCamera
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VRCamera
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:20 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local VRService = game:GetService("VRService");
UserSettings():GetService("UserGameSettings");
require(script.Parent:WaitForChild("CameraInput"));
require(script.Parent:WaitForChild("CameraUtils"));
local VRCameraTeleportDetector = require(script.Parent:WaitForChild("VRCameraTeleportDetector"));
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local UserFlag = FlagUtil.getUserFlag("UserVRRemoveLuaEdgeBlur");
local UserFlag2 = FlagUtil.getUserFlag("UserVRRecenterOnExternalTeleport");
local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"));
local u1 = setmetatable({}, VRBaseCamera);
u1.__index = u1;

function u1.new() -- Line: 34
    -- upvalues: VRBaseCamera (copy), u1 (copy), Players (copy)
    local v2 = VRBaseCamera.new();
    local v3 = setmetatable(v2, u1);
    v3.lastUpdate = tick();
    v3.focusOffset = CFrame.new();
    v3:Reset();
    v3.controlModule = require(Players.LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"));
    v3.savedAutoRotate = true;

    return v3;
end;

function u1.Reset(p4) -- Line: 47
    -- upvalues: VRBaseCamera (copy)
    p4.needsReset = true;
    p4.needsBlackout = true;
    p4.motionDetTime = 0;
    p4.blackOutTimer = 0;
    p4.lastCameraResetPosition = nil;
    VRBaseCamera.Reset(p4);
end;

function u1.Update(p5, p6) -- Line: 56
    -- upvalues: Players (copy), UserFlag (copy), VRService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local Focus = workspace_CurrentCamera.Focus;
    local LocalPlayer = Players.LocalPlayer;
    p5:GetHumanoid();
    local _ = workspace_CurrentCamera.CameraSubject;

    if p5.lastUpdate == nil or p6 > 1 then
        p5.lastCameraTransform = nil;
    end;

    p5:UpdateFadeFromBlack(p6);

    if not UserFlag then
        p5:UpdateEdgeBlur(LocalPlayer, p6);
    end;

    local lastSubjectPosition = p5.lastSubjectPosition;
    local SubjectPosition = p5:GetSubjectPosition();

    if p5.needsBlackout then
        p5:StartFadeFromBlack();
        local math_clamp_ret = math.clamp(p6, 0.0001, 0.1);
        p5.blackOutTimer = p5.blackOutTimer + math_clamp_ret;

        if p5.blackOutTimer > 0.1 and game:IsLoaded() then
            p5.needsBlackout = false;
            p5.needsReset = true;
        end;
    end;

    if SubjectPosition and (LocalPlayer and workspace_CurrentCamera) then
        local VRFocus = p5:GetVRFocus(SubjectPosition, p6);

        if p5:IsInFirstPerson() then
            if VRService.AvatarGestures then
                CFrame2, Focus = p5:UpdateImmersionCamera(p6, CFrame2, VRFocus, lastSubjectPosition, SubjectPosition);
            else
                CFrame2, Focus = p5:UpdateFirstPersonTransform(p6, CFrame2, VRFocus, lastSubjectPosition, SubjectPosition);
            end;
        elseif VRService.ThirdPersonFollowCamEnabled then
            CFrame2, Focus = p5:UpdateThirdPersonFollowTransform(p6, CFrame2, VRFocus, lastSubjectPosition, SubjectPosition);
        else
            CFrame2, Focus = p5:UpdateThirdPersonComfortTransform(p6, CFrame2, VRFocus, lastSubjectPosition, SubjectPosition);
        end;

        p5.lastCameraTransform = CFrame2;
        p5.lastCameraFocus = Focus;
    end;

    p5.lastUpdate = tick();

    return CFrame2, Focus;
end;

function u1.GetAvatarFeetWorldYValue(p7) -- Line: 120
    local CameraSubject = workspace.CurrentCamera.CameraSubject;

    if not CameraSubject then
        return nil;
    end;

    if not (CameraSubject:IsA("Humanoid") and CameraSubject.RootPart) then
        return nil;
    end;

    local RootPart = CameraSubject.RootPart;

    return RootPart.Position.Y - RootPart.Size.Y / 2 - CameraSubject.HipHeight;
end;

function u1.UpdateFirstPersonTransform(p8, p9, p10, p11, p12, p13) -- Line: 135
    -- upvalues: Players (copy), UserFlag (copy)
    if p8.needsReset then
        p8:StartFadeFromBlack();
        p8.needsReset = false;
    end;

    local LocalPlayer = Players.LocalPlayer;

    if not UserFlag and (p12 - p13).magnitude > 0.01 then
        p8:StartVREdgeBlur(LocalPlayer);
    end;

    local p = p11.p;
    local CameraLookVector = p8:GetCameraLookVector();
    local Unit = Vector3.new(CameraLookVector.X, 0, CameraLookVector.Z).Unit;
    local Rotation = p8:getRotation(p9);
    local v14 = p8:CalculateNewLookVectorFromArg(Unit, Vector2.new(Rotation, 0));

    return CFrame.new(p - 0.5 * v14, p), p11;
end;

function u1.UpdateImmersionCamera(p15, p16, p17, p18, p19, p20) -- Line: 163
    -- upvalues: Players (copy), UserFlag2 (copy), VRService (copy), UserFlag (copy), VRCameraTeleportDetector (copy)
    local SubjectCFrame = p15:GetSubjectCFrame();
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Character = Players.LocalPlayer.Character;
    local Humanoid = p15:GetHumanoid();

    if not Humanoid then
        return workspace_CurrentCamera.CFrame, workspace_CurrentCamera.Focus;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return workspace_CurrentCamera.CFrame, workspace_CurrentCamera.Focus;
    end;

    local v21;

    if UserFlag2 then
        v21 = not p19 and 0 or Vector3.new(p20.X - p19.X, 0, p20.Z - p19.Z).Magnitude;
    else
        v21 = nil;
    end;

    p15.characterOrientation = HumanoidRootPart:FindFirstChild("CharacterAlignOrientation");

    if not p15.characterOrientation then
        local RootAttachment = HumanoidRootPart:FindFirstChild("RootAttachment");

        if not RootAttachment then
            return;
        end;

        p15.characterOrientation = Instance.new("AlignOrientation");
        p15.characterOrientation.Name = "CharacterAlignOrientation";
        p15.characterOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        p15.characterOrientation.Attachment0 = RootAttachment;
        p15.characterOrientation.RigidityEnabled = true;
        p15.characterOrientation.Parent = HumanoidRootPart;
    end;

    if p15.characterOrientation.Enabled == false then
        p15.characterOrientation.Enabled = true;
    end;

    if p15.needsReset then
        p15.needsReset = false;
        p15.savedAutoRotate = Humanoid.AutoRotate;
        Humanoid.AutoRotate = false;

        if UserFlag2 then
            VRService:RecenterUserHeadCFrame();
            p15.lastTeleportRecenter = tick();
        end;

        p15:StartFadeFromBlack();
    elseif Humanoid.Sit then
        if not UserFlag and (SubjectCFrame.Position - workspace_CurrentCamera.CFrame.Position).Magnitude > 0.01 then
            p15:StartVREdgeBlur(Players.LocalPlayer);
        end;
    else
        local EstimatedVRTorsoFrame = p15.controlModule:GetEstimatedVRTorsoFrame();
        p15.characterOrientation.CFrame = workspace_CurrentCamera.CFrame * EstimatedVRTorsoFrame;

        if p15.controlModule.inputMoveVector.Magnitude > 0 then
            p15.motionDetTime = 0.1;
        end;

        if p15.controlModule.inputMoveVector.Magnitude > 0 or p15.motionDetTime > 0 then
            p15.motionDetTime = p15.motionDetTime - p16;

            if not UserFlag then
                p15:StartVREdgeBlur(Players.LocalPlayer);
            end;

            local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local HumanoidRootPart2 = Character.HumanoidRootPart;
            local v22 = workspace_CurrentCamera.CFrame * (UserCFrame.Rotation + UserCFrame.Position * workspace_CurrentCamera.HeadScale) * CFrame.new(0, -0.7 * HumanoidRootPart2.Size.Y / 2, 0);
            local LookVector = HumanoidRootPart2.CFrame.LookVector;
            local v23 = p20 - (v22 - Vector3.new(LookVector.X, 0, LookVector.Z).Unit * HumanoidRootPart2.Size.Y * 0.125).Position + workspace_CurrentCamera.CFrame.Position;
            local Vector3_new_ret = Vector3.new(v23.X, p20.Y, v23.Z);
            SubjectCFrame = workspace_CurrentCamera.CFrame.Rotation + Vector3_new_ret;
        elseif UserFlag2 and VRCameraTeleportDetector.shouldRecenter(p15.prevSubjStep, v21, p15.lastTeleportRecenter, tick()) then
            local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local HumanoidRootPart2 = Character.HumanoidRootPart;
            local v24 = workspace_CurrentCamera.CFrame * (UserCFrame.Rotation + UserCFrame.Position * workspace_CurrentCamera.HeadScale) * CFrame.new(0, -0.7 * HumanoidRootPart2.Size.Y / 2, 0);
            local LookVector = HumanoidRootPart2.CFrame.LookVector;
            local v25 = p20 - (v24 - Vector3.new(LookVector.X, 0, LookVector.Z).Unit * HumanoidRootPart2.Size.Y * 0.125).Position + workspace_CurrentCamera.CFrame.Position;
            local Vector3_new_ret = Vector3.new(v25.X, p20.Y, v25.Z);
            SubjectCFrame = workspace_CurrentCamera.CFrame.Rotation + Vector3_new_ret;
            VRService:RecenterUserHeadCFrame();
            p15:StartFadeFromBlack();
            p15.lastTeleportRecenter = tick();
        else
            SubjectCFrame = workspace_CurrentCamera.CFrame.Rotation + Vector3.new(workspace_CurrentCamera.CFrame.Position.X, p20.Y, workspace_CurrentCamera.CFrame.Position.Z);
        end;

        local Rotation = p15:getRotation(p16);

        if math.abs(Rotation) > 0 then
            local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local v26 = UserCFrame.Rotation + UserCFrame.Position * workspace_CurrentCamera.HeadScale;
            local v27 = SubjectCFrame * v26;
            SubjectCFrame = CFrame.new(v27.Position) * CFrame.Angles(0, -math.rad(Rotation * 90), 0) * v27.Rotation * v26:Inverse();
        end;
    end;

    if UserFlag2 then
        p15.prevSubjStep = v21;
    end;

    return SubjectCFrame, SubjectCFrame * CFrame.new(0, 0, -0.5);
end;

function u1.UpdateThirdPersonComfortTransform(p28, p29, p30, p31, p32, p33) -- Line: 320
    -- upvalues: Players (copy), VRService (copy)
    local CameraToSubjectDistance = p28:GetCameraToSubjectDistance();
    local v34 = CameraToSubjectDistance < 0.5 and 0.5 or CameraToSubjectDistance;

    if p32 ~= nil and p28.lastCameraFocus ~= nil then
        local _ = Players.LocalPlayer;
        local MoveVector = p28.controlModule:GetMoveVector();
        local v35 = (p32 - p33).magnitude > 0.01 and true or MoveVector.magnitude > 0.01;

        if v35 then
            p28.motionDetTime = 0.1;
        end;

        p28.motionDetTime = p28.motionDetTime - p29;

        if (p28.motionDetTime > 0 and true or v35) and not p28.needsReset then
            local lastCameraFocus = p28.lastCameraFocus;
            p28.VRCameraFocusFrozen = true;

            return p30, lastCameraFocus;
        end;

        local v36 = p28.lastCameraResetPosition == nil and true or (p33 - p28.lastCameraResetPosition).Magnitude > 1;
        local Rotation = p28:getRotation(p29);

        if math.abs(Rotation) > 0 then
            local v37 = p31:ToObjectSpace(p30);
            p30 = p31 * CFrame.Angles(0, -Rotation, 0) * v37;
        end;

        if p28.VRCameraFocusFrozen and v36 or p28.needsReset then
            VRService:RecenterUserHeadCFrame();
            p28.VRCameraFocusFrozen = false;
            p28.needsReset = false;
            p28.lastCameraResetPosition = p33;
            p28:ResetZoom();
            p28:StartFadeFromBlack();
            local Humanoid = p28:GetHumanoid();
            local v38 = Humanoid.Torso and Humanoid.Torso.CFrame.lookVector or Vector3.new(1, 0, 0);
            local Vector3_new_ret = Vector3.new(v38.X, 0, v38.Z);
            local v39 = p31.Position - Vector3_new_ret * v34;
            local Vector3_new_ret2 = Vector3.new(p31.Position.X, v39.Y, p31.Position.Z);
            p30 = CFrame.new(v39, Vector3_new_ret2);
        end;
    end;

    return p30, p31;
end;

function u1.UpdateThirdPersonFollowTransform(p40, p41, p42, p43, p44, p45) -- Line: 387
    -- upvalues: VRService (copy), Players (copy), UserFlag (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CameraToSubjectDistance = p40:GetCameraToSubjectDistance();
    local VRFocus = p40:GetVRFocus(p45, p41);

    if p40.needsReset then
        p40.needsReset = false;
        VRService:RecenterUserHeadCFrame();
        p40:ResetZoom();
        p40:StartFadeFromBlack();
    end;

    if p40.recentered then
        local SubjectCFrame = p40:GetSubjectCFrame();

        if not SubjectCFrame then
            return workspace_CurrentCamera.CFrame, workspace_CurrentCamera.Focus;
        end;

        local v46 = VRFocus * SubjectCFrame.Rotation * CFrame.new(0, 0, CameraToSubjectDistance);
        p40.focusOffset = VRFocus:ToObjectSpace(v46);
        p40.recentered = false;

        return v46, VRFocus;
    end;

    local v47 = VRFocus:ToWorldSpace(p40.focusOffset);
    local _ = Players.LocalPlayer;
    local controlModule = p40.controlModule;
    local MoveVector = controlModule:GetMoveVector();

    if (p44 - p45).magnitude > 0.01 or MoveVector.magnitude > 0 then
        local EstimatedVRTorsoFrame = controlModule:GetEstimatedVRTorsoFrame();
        local v48 = workspace_CurrentCamera.CFrame * (EstimatedVRTorsoFrame.Rotation + EstimatedVRTorsoFrame.Position * workspace_CurrentCamera.HeadScale);
        local LookVector = v48.LookVector;
        local v49 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit * CameraToSubjectDistance;
        v47 = v47:Lerp(CFrame.new(workspace_CurrentCamera.CFrame.Position + (VRFocus.Position - v49) - v48.Position) * v47.Rotation, 0.01);
    end;

    local Rotation = p40:getRotation(p41);

    if math.abs(Rotation) > 0 then
        local v50 = VRFocus:ToObjectSpace(v47);
        v47 = VRFocus * CFrame.Angles(0, -Rotation, 0) * v50;
    end;

    p40.focusOffset = VRFocus:ToObjectSpace(v47);
    local v51 = v47 * CFrame.new(0, 0, -CameraToSubjectDistance);

    if not UserFlag and (v51.Position - workspace_CurrentCamera.Focus.Position).Magnitude > 0.01 then
        p40:StartVREdgeBlur(Players.LocalPlayer);
    end;

    return v47, v51;
end;

function u1.LeaveFirstPerson(p52) -- Line: 467
    -- upvalues: VRBaseCamera (copy)
    VRBaseCamera.LeaveFirstPerson(p52);
    p52.needsReset = true;

    if p52.VRBlur then
        p52.VRBlur.Visible = false;
    end;

    if p52.characterOrientation then
        p52.characterOrientation.Enabled = false;
    end;

    local Humanoid = p52:GetHumanoid();

    if Humanoid then
        Humanoid.AutoRotate = p52.savedAutoRotate;
    end;
end;

return u1;