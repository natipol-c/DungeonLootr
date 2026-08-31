--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Infinite_Void
  Path:     game.ReplicatedStorage.Classes.Honored One.Skill_Modules.Infinite_Void
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:54 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local ForgeChoreographer = require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer);
local u1 = Enum.RenderPriority.Camera.Value + 2;
local v2 = ForgeChoreographer.markerEmit(script, {
    root = "Cutscene",
    models = { "transition", "DomainSphere" },
    limbAttachments = {
        gleam = "Head"
    }
});

local function getCutsceneFolder() -- Line: 74
    local v3 = script.Parent and script.Parent.Parent;

    if v3 then
        v3 = v3:FindFirstChild("Cutscene");
    end;

    return v3;
end;

local function getVFXFolder() -- Line: 82
    local VFX = workspace:FindFirstChild("VFX");

    if VFX and VFX:IsA("Folder") then
        return VFX;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "VFX";
    Folder.Parent = workspace;

    return Folder;
end;

local u4 = setmetatable({}, {
    __mode = "k"
});

local function spawnInfiniteVoid(u5: userdata, p6: any) -- Line: 100
    -- upvalues: u4 (copy), Debris (copy)
    local v7 = script.Parent and script.Parent.Parent;

    if v7 then
        v7 = v7:FindFirstChild("Cutscene");
    end;

    if v7 then
        v7 = v7:FindFirstChild("InfiniteVoid");
    end;

    if not v7 then
        warn("[Infinite_Void] Cutscene/InfiniteVoid model missing");

        return;
    end;

    local v8 = u4[u5];

    if v8 then
        v8:Destroy();
    end;

    local u9 = v7:Clone();

    if typeof(p6) ~= "CFrame" then
        p6 = u5:GetPivot();
    end;

    u9:PivotTo(p6);

    for _, descendant in u9:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
        elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant.Enabled = true;
        end;
    end;

    local VFX = workspace:FindFirstChild("VFX");

    if not (VFX and VFX:IsA("Folder")) then
        VFX = Instance.new("Folder");
        VFX.Name = "VFX";
        VFX.Parent = workspace;
    end;

    u9.Parent = VFX;
    u4[u5] = u9;
    Debris:AddItem(u9, 16);
    u5.Destroying:Once(function() -- Line: 126
        -- upvalues: u4 (ref), u5 (copy), u9 (copy)
        if u4[u5] == u9 then
            u4[u5] = nil;
        end;

        if u9.Parent then
            u9:Destroy();
        end;
    end);
end;

local Emit = v2.Emit;

function v2.Emit(p10, p11, p12) -- Line: 135
    -- upvalues: spawnInfiniteVoid (copy), Emit (copy)
    if not p10 or tostring(p12):lower() ~= "infinitevoid" then
        return Emit(p10, p11, p12);
    end;

    spawnInfiniteVoid(p10, p11);
end;

local function getFootCFrame(p13: userdata, p14) -- Line: 150
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { p13 };
    local v15 = workspace:Raycast(p14.Position, Vector3.new(0, -60, 0), RaycastParams_new_ret);
    local v16;

    if v15 then
        v16 = v15.Position.Y;
    else
        local BoundingBox, v17 = p13:GetBoundingBox();
        v16 = BoundingBox.Position.Y - v17.Y / 2;
    end;

    local Vector3_new_ret = Vector3.new(p14.Position.X, v16, p14.Position.Z);
    local LookVector = p14.LookVector;
    local Vector3_new_ret2 = Vector3.new(LookVector.X, 0, LookVector.Z);

    return CFrame.lookAt(Vector3_new_ret, Vector3_new_ret + (Vector3_new_ret2.Magnitude < 0.001 and Vector3.new(0, 0, -1) or Vector3_new_ret2).Unit);
end;

local function runCasterCutscene(u18, p19, p20) -- Line: 173
    -- upvalues: getFootCFrame (copy), Players (copy), RunService (copy), u1 (copy)
    local v21 = script.Parent and script.Parent.Parent;

    if v21 then
        v21 = v21:FindFirstChild("Cutscene");
    end;

    if v21 then
        v21 = v21:FindFirstChild("Cam");
    end;

    if not v21 then
        warn("[Infinite_Void] Cutscene/Cam rig missing — skipping camera cutscene");

        return;
    end;

    local v22 = script.Parent and script.Parent.Parent;

    if v22 then
        v22 = v22:FindFirstChild("Skill_Animations");
    end;

    if v22 then
        v22 = v22:FindFirstChild("GojoCutscene_Camera");
    end;

    if not v22 then
        warn("[Infinite_Void] Skill_Animations/GojoCutscene_Camera missing — skipping camera");

        return;
    end;

    local u23 = v21:Clone();
    u23:PivotTo((getFootCFrame(p19, p20)));
    local VFX = workspace:FindFirstChild("VFX");

    if not (VFX and VFX:IsA("Folder")) then
        VFX = Instance.new("Folder");
        VFX.Name = "VFX";
        VFX.Parent = workspace;
    end;

    u23.Parent = VFX;
    local CamPart = u23:FindFirstChild("CamPart");
    local FovPart = u23:FindFirstChild("FovPart");
    local v24 = u23:FindFirstChildOfClass("AnimationController");

    if v24 then
        v24 = v24:FindFirstChildOfClass("Animator");
    end;

    if not (CamPart and v24) then
        warn("[Infinite_Void] Cam rig missing CamPart/Animator — skipping camera");
        u23:Destroy();

        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local LocalPlayer = Players.LocalPlayer;
    local CameraType = workspace_CurrentCamera.CameraType;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    LocalPlayer:SetAttribute("Disable_ShiftLock", true);
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u25 = false;

    local function endCutscene() -- Line: 215
        -- upvalues: u25 (ref), RunService (ref), workspace_CurrentCamera (copy), CameraType (copy), FieldOfView (copy), LocalPlayer (copy), u23 (copy)
        if u25 then
            return;
        end;

        u25 = true;
        RunService:UnbindFromRenderStep("InfiniteVoid_Cutscene");

        if workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            workspace_CurrentCamera.CameraType = CameraType or Enum.CameraType.Custom;
        end;

        workspace_CurrentCamera.FieldOfView = FieldOfView;
        LocalPlayer:SetAttribute("Disable_ShiftLock", nil);

        if u23 and u23.Parent then
            u23:Destroy();
        end;
    end;

    u18.endCutscene = endCutscene;
    local u26 = v24:LoadAnimation(v22);
    u26.Priority = Enum.AnimationPriority.Action4;
    u26.Looped = false;
    u26:Play(0);
    u26.Stopped:Connect(endCutscene);
    local Length = u26.Length;
    task.spawn(function() -- Line: 236
        -- upvalues: Length (ref), u26 (copy)
        local os_clock_ret = os.clock();

        while Length <= 0 and os.clock() - os_clock_ret < 1.5 do
            task.wait();
            Length = u26.Length;
        end;
    end);
    local u27 = 0;
    RunService:UnbindFromRenderStep("InfiniteVoid_Cutscene");
    RunService:BindToRenderStep("InfiniteVoid_Cutscene", u1, function(p28) -- Line: 246
        -- upvalues: u18 (copy), CamPart (copy), endCutscene (copy), u27 (ref), workspace_CurrentCamera (copy), FovPart (copy), Length (ref)
        if u18.cancelled or not CamPart.Parent then
            endCutscene();

            return;
        end;

        u27 = u27 + p28;
        workspace_CurrentCamera.CFrame = CamPart.CFrame;

        if FovPart then
            local Magnitude = (CamPart.Position - FovPart.Position).Magnitude;
            workspace_CurrentCamera.FieldOfView = Magnitude > 0.05 and Magnitude and Magnitude or 70;
        end;

        if u27 > (Length > 0 and Length or 9.05) + 0.25 then
            endCutscene();
        end;
    end);
end;

function v2.Activate(p29, p30) -- Line: 271
    -- upvalues: Players (copy), runCasterCutscene (copy)
    if not (p29 and p29.Parent) then
        return;
    end;

    if p29 ~= Players.LocalPlayer.Character then
        return;
    end;

    if typeof(p30) ~= "CFrame" then
        p30 = p29:GetPivot();
    end;

    if Players.LocalPlayer:GetAttribute("DisableCutscenes") then
        return;
    end;

    local u31 = {
        cancelled = false
    };
    p29.Destroying:Once(function() -- Line: 280
        -- upvalues: u31 (copy)
        u31.cancelled = true;

        if u31.endCutscene then
            u31.endCutscene();
        end;
    end);
    runCasterCutscene(u31, p29, p30);
end;

return v2;