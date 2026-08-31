--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RaidSpectateController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.RaidSpectateController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = false;
local u11 = {};
local u12 = 0;
local u13 = nil;
local u14 = nil;

local function ResolveTargetPlayer(p15: number) -- Line: 47
    -- upvalues: Players (copy)
    for _, v in Players:GetPlayers() do
        if v.UserId == p15 then
            return v;
        end;
    end;

    return nil;
end;

local function UpdateLabels(p16: userdata?) -- Line: 54
    -- upvalues: u7 (ref), u8 (ref)
    if u7 then
        u7.Text = p16 and (p16.DisplayName or "—") or "—";
    end;

    if u8 then
        u8.Text = p16 and "@" .. p16.Name or "";
    end;
end;

local function SetCameraToPlayer(p17: userdata?) -- Line: 64
    if not p17 then
        return;
    end;

    local Character = p17.Character;

    if not Character then
        return;
    end;

    local v18 = Character:FindFirstChildOfClass("Humanoid");

    if not v18 then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera.CameraSubject = v18;
    end;
end;

local function StartCameraEnforcement() -- Line: 79
    -- upvalues: u14 (ref), RunService (copy), u10 (ref), u11 (ref), u12 (ref), Players (copy)
    if u14 then
        return;
    end;

    u14 = RunService.RenderStepped:Connect(function() -- Line: 81
        -- upvalues: u10 (ref), u11 (ref), u12 (ref), Players (ref)
        if not u10 then
            return;
        end;

        local v19 = u11[u12];

        if not v19 then
            return;
        end;

        local v20 = nil;

        for _, v in Players:GetPlayers() do
            if v.UserId == v19 then
                v20 = v;
                break;
            end;
        end;

        if not v20 then
            return;
        end;

        local Character = v20.Character;

        if not Character then
            return;
        end;

        local v21 = Character:FindFirstChildOfClass("Humanoid");

        if not v21 or v21.Health <= 0 then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera and workspace_CurrentCamera.CameraSubject ~= v21 then
            workspace_CurrentCamera.CameraSubject = v21;
        end;
    end);
end;

local function StopCameraEnforcement() -- Line: 100
    -- upvalues: u14 (ref)
    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;
end;

local function AttachCameraTracking(u22: userdata?) -- Line: 108
    -- upvalues: u13 (ref), u10 (ref), u11 (ref), u12 (ref)
    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    if not u22 then
        return;
    end;

    local v23 = u22 and u22.Character;

    if v23 then
        local v24 = v23:FindFirstChildOfClass("Humanoid");
        local v25 = v24 and workspace.CurrentCamera;

        if v25 then
            v25.CameraSubject = v24;
        end;
    end;

    u13 = u22.CharacterAdded:Connect(function(p26) -- Line: 117
        -- upvalues: u10 (ref), u11 (ref), u12 (ref), u22 (copy)
        local Humanoid = p26:WaitForChild("Humanoid", 5);

        if not Humanoid then
            return;
        end;

        if not u10 then
            return;
        end;

        if u11[u12] ~= u22.UserId then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            workspace_CurrentCamera.CameraSubject = Humanoid;
        end;
    end);
end;

local function Cycle(p27: number) -- Line: 131
    -- upvalues: u11 (ref), u12 (ref), Players (copy), u7 (ref), u8 (ref), u13 (ref), u10 (ref)
    if #u11 == 0 then
        return;
    end;

    u12 = (u12 - 1 + p27) % #u11 + 1;
    local v28 = u11[u12];
    local u29 = nil;

    for _, v in Players:GetPlayers() do
        if v.UserId == v28 then
            u29 = v;
            break;
        end;
    end;

    if u7 then
        u7.Text = u29 and (u29.DisplayName or "—") or "—";
    end;

    if u8 then
        u8.Text = u29 and ("@" .. u29.Name or "") or "";
    end;

    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    if not u29 then
        return;
    end;

    local v30 = u29 and u29.Character;

    if v30 then
        local v31 = v30:FindFirstChildOfClass("Humanoid");
        local v32 = v31 and workspace.CurrentCamera;

        if v32 then
            v32.CameraSubject = v31;
        end;
    end;

    u13 = u29.CharacterAdded:Connect(function(p33) -- Line: 117
        -- upvalues: u10 (ref), u11 (ref), u12 (ref), u29 (copy)
        local Humanoid = p33:WaitForChild("Humanoid", 5);

        if not Humanoid then
            return;
        end;

        if not u10 then
            return;
        end;

        if u11[u12] ~= u29.UserId then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            workspace_CurrentCamera.CameraSubject = Humanoid;
        end;
    end);
end;

local function EnterSpectate(p34: table) -- Line: 141
    -- upvalues: u10 (ref), u11 (ref), u12 (ref), u2 (ref), u4 (ref), u9 (ref), Players (copy), u7 (ref), u8 (ref), u13 (ref), u14 (ref), RunService (copy)
    u10 = true;
    u11 = p34 or {};
    u12 = 0;

    if u2 then
        u2.Visible = true;
        local Parent = u2.Parent;

        if Parent and Parent:IsA("GuiObject") then
            Parent.Visible = true;
        end;
    end;

    if u4 then
        u4.Visible = false;
    end;

    if u9 then
        u9.Visible = false;
    end;

    if #u11 > 0 then
        u12 = 1;
        local v35 = u11[1];
        local u36 = nil;

        for _, v in Players:GetPlayers() do
            if v.UserId == v35 then
                u36 = v;
                break;
            end;
        end;

        if u7 then
            u7.Text = u36 and (u36.DisplayName or "—") or "—";
        end;

        if u8 then
            u8.Text = u36 and ("@" .. u36.Name or "") or "";
        end;

        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;

        if u36 then
            local v37 = u36 and u36.Character;

            if v37 then
                local v38 = v37:FindFirstChildOfClass("Humanoid");
                local v39 = v38 and workspace.CurrentCamera;

                if v39 then
                    v39.CameraSubject = v38;
                end;
            end;

            u13 = u36.CharacterAdded:Connect(function(p40) -- Line: 117
                -- upvalues: u10 (ref), u11 (ref), u12 (ref), u36 (copy)
                local Humanoid = p40:WaitForChild("Humanoid", 5);

                if not Humanoid then
                    return;
                end;

                if not u10 then
                    return;
                end;

                if u11[u12] ~= u36.UserId then
                    return;
                end;

                local workspace_CurrentCamera = workspace.CurrentCamera;

                if workspace_CurrentCamera then
                    workspace_CurrentCamera.CameraSubject = Humanoid;
                end;
            end);
        end;
    else
        if u7 then
            u7.Text = "—";
        end;

        if u8 then
            u8.Text = "";
        end;
    end;

    if u14 then
        return;
    end;

    u14 = RunService.RenderStepped:Connect(function() -- Line: 81
        -- upvalues: u10 (ref), u11 (ref), u12 (ref), Players (ref)
        if not u10 then
            return;
        end;

        local v41 = u11[u12];

        if not v41 then
            return;
        end;

        local v42 = nil;

        for _, v in Players:GetPlayers() do
            if v.UserId == v41 then
                v42 = v;
                break;
            end;
        end;

        if not v42 then
            return;
        end;

        local Character = v42.Character;

        if not Character then
            return;
        end;

        local v43 = Character:FindFirstChildOfClass("Humanoid");

        if not v43 or v43.Health <= 0 then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera and workspace_CurrentCamera.CameraSubject ~= v43 then
            workspace_CurrentCamera.CameraSubject = v43;
        end;
    end);
end;

local function ExitSpectate() -- Line: 174
    -- upvalues: u10 (ref), u11 (ref), u12 (ref), u14 (ref), u13 (ref), u2 (ref), u4 (ref), LocalPlayer (copy)
    u10 = false;
    u11 = {};
    u12 = 0;

    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;

    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    if u2 then
        u2.Visible = false;
    end;

    if u4 then
        u4.Visible = true;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        local v44 = Character:FindFirstChildOfClass("Humanoid");
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if v44 and workspace_CurrentCamera then
            workspace_CurrentCamera.CameraSubject = v44;
        end;
    end;
end;

local function UpdateTargets(p45: table) -- Line: 203
    -- upvalues: u10 (ref), u11 (ref), u12 (ref), u7 (ref), u8 (ref), Players (copy), u13 (ref)
    if not u10 then
        return;
    end;

    local v46 = u11[u12];
    u11 = p45 or {};

    if #u11 == 0 then
        if u7 then
            u7.Text = "—";
        end;

        if u8 then
            u8.Text = "";
        end;

        return;
    end;

    local v47 = 0;

    for i, v in u11 do
        if v == v46 then
            v47 = i;
            break;
        end;
    end;

    if v47 > 0 then
        u12 = v47;

        return;
    end;

    u12 = math.clamp(u12, 1, #u11);
    local v48 = u11[u12];
    local u49 = nil;

    for _, v in Players:GetPlayers() do
        if v.UserId == v48 then
            u49 = v;
            break;
        end;
    end;

    if u7 then
        u7.Text = u49 and (u49.DisplayName or "—") or "—";
    end;

    if u8 then
        u8.Text = u49 and ("@" .. u49.Name or "") or "";
    end;

    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    if not u49 then
        return;
    end;

    local v50 = u49 and u49.Character;

    if v50 then
        local v51 = v50:FindFirstChildOfClass("Humanoid");
        local v52 = v51 and workspace.CurrentCamera;

        if v52 then
            v52.CameraSubject = v51;
        end;
    end;

    u13 = u49.CharacterAdded:Connect(function(p53) -- Line: 117
        -- upvalues: u10 (ref), u11 (ref), u12 (ref), u49 (copy)
        local Humanoid = p53:WaitForChild("Humanoid", 5);

        if not Humanoid then
            return;
        end;

        if not u10 then
            return;
        end;

        if u11[u12] ~= u49.UserId then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            workspace_CurrentCamera.CameraSubject = Humanoid;
        end;
    end);
end;

local v54 = Knit.CreateController({
    Name = "RaidSpectateController"
});

function v54.IsSpectating(p55) -- Line: 238
    -- upvalues: u10 (ref)
    return u10;
end;

function v54.KnitInit(p56) -- Line: 244
    -- upvalues: Knit (copy), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref)
    local Dungeon_Container = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("Dungeon_Container");

    if not Dungeon_Container then
        return;
    end;

    u2 = Dungeon_Container:FindFirstChild("Spectate_Info");

    if not u2 then
        warn("[RaidSpectateController] Spectate_Info frame not found under Dungeon_Container");

        return;
    end;

    u3 = u2:FindFirstChild("Return");
    u4 = u2:FindFirstChild("Revive");
    u5 = u2:FindFirstChild("Next");
    u6 = u2:FindFirstChild("Previous");
    u7 = u2:FindFirstChild("PlayerName");
    u8 = u2:FindFirstChild("Username");
    u9 = u2:FindFirstChild("HighestFloor");
end;

function v54.KnitStart(p57) -- Line: 264
    -- upvalues: u2 (ref), Knit (copy), u1 (ref), u3 (ref), u10 (ref), u5 (ref), u11 (ref), u12 (ref), Players (copy), u7 (ref), u8 (ref), u13 (ref), u6 (ref), EnterSpectate (copy), ExitSpectate (copy), UpdateTargets (copy), LocalPlayer (copy), u4 (ref), u9 (ref)
    if not u2 then
        return;
    end;

    local success, result = pcall(function() -- Line: 268
        -- upvalues: Knit (ref)
        return Knit.GetService("RaidRunService");
    end);

    if not (success and result) then
        return;
    end;

    u1 = result;

    if u3 and u3:IsA("GuiButton") then
        u3.Activated:Connect(function() -- Line: 276
            -- upvalues: u10 (ref), u1 (ref)
            if not u10 then
                return;
            end;

            u1:LeaveSpectate();
        end);
    end;

    if u5 and u5:IsA("GuiButton") then
        u5.Activated:Connect(function() -- Line: 283
            -- upvalues: u11 (ref), u12 (ref), Players (ref), u7 (ref), u8 (ref), u13 (ref), u10 (ref)
            if #u11 == 0 then
                return;
            end;

            u12 = (u12 - 1 + 1) % #u11 + 1;
            local v58 = u11[u12];
            local u59 = nil;

            for _, v in Players:GetPlayers() do
                if v.UserId == v58 then
                    u59 = v;
                    break;
                end;
            end;

            if u7 then
                u7.Text = u59 and (u59.DisplayName or "—") or "—";
            end;

            if u8 then
                u8.Text = u59 and ("@" .. u59.Name or "") or "";
            end;

            if u13 then
                u13:Disconnect();
                u13 = nil;
            end;

            if not u59 then
                return;
            end;

            local v60 = u59 and u59.Character;

            if v60 then
                local v61 = v60:FindFirstChildOfClass("Humanoid");
                local v62 = v61 and workspace.CurrentCamera;

                if v62 then
                    v62.CameraSubject = v61;
                end;
            end;

            u13 = u59.CharacterAdded:Connect(function(p63) -- Line: 117
                -- upvalues: u10 (ref), u11 (ref), u12 (ref), u59 (copy)
                local Humanoid = p63:WaitForChild("Humanoid", 5);

                if not Humanoid then
                    return;
                end;

                if not u10 then
                    return;
                end;

                if u11[u12] ~= u59.UserId then
                    return;
                end;

                local workspace_CurrentCamera = workspace.CurrentCamera;

                if workspace_CurrentCamera then
                    workspace_CurrentCamera.CameraSubject = Humanoid;
                end;
            end);
        end);
    end;

    if u6 and u6:IsA("GuiButton") then
        u6.Activated:Connect(function() -- Line: 289
            -- upvalues: u11 (ref), u12 (ref), Players (ref), u7 (ref), u8 (ref), u13 (ref), u10 (ref)
            if #u11 == 0 then
                return;
            end;

            u12 = (u12 - 1 + -1) % #u11 + 1;
            local v64 = u11[u12];
            local u65 = nil;

            for _, v in Players:GetPlayers() do
                if v.UserId == v64 then
                    u65 = v;
                    break;
                end;
            end;

            if u7 then
                u7.Text = u65 and (u65.DisplayName or "—") or "—";
            end;

            if u8 then
                u8.Text = u65 and ("@" .. u65.Name or "") or "";
            end;

            if u13 then
                u13:Disconnect();
                u13 = nil;
            end;

            if not u65 then
                return;
            end;

            local v66 = u65 and u65.Character;

            if v66 then
                local v67 = v66:FindFirstChildOfClass("Humanoid");
                local v68 = v67 and workspace.CurrentCamera;

                if v68 then
                    v68.CameraSubject = v67;
                end;
            end;

            u13 = u65.CharacterAdded:Connect(function(p69) -- Line: 117
                -- upvalues: u10 (ref), u11 (ref), u12 (ref), u65 (copy)
                local Humanoid = p69:WaitForChild("Humanoid", 5);

                if not Humanoid then
                    return;
                end;

                if not u10 then
                    return;
                end;

                if u11[u12] ~= u65.UserId then
                    return;
                end;

                local workspace_CurrentCamera = workspace.CurrentCamera;

                if workspace_CurrentCamera then
                    workspace_CurrentCamera.CameraSubject = Humanoid;
                end;
            end);
        end);
    end;

    u1.EnterSpectate:Connect(EnterSpectate);
    u1.ExitSpectate:Connect(ExitSpectate);
    u1.SpectateTargetsUpdate:Connect(UpdateTargets);
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 301
        -- upvalues: u10 (ref), u2 (ref), u4 (ref), u9 (ref), u11 (ref), u12 (ref), Players (ref), u13 (ref)
        if not u10 then
            return;
        end;

        task.wait(0.1);

        if not u10 then
            return;
        end;

        if u2 then
            u2.Visible = true;
            local Parent = u2.Parent;

            if Parent and Parent:IsA("GuiObject") then
                Parent.Visible = true;
            end;
        end;

        if u4 then
            u4.Visible = false;
        end;

        if u9 then
            u9.Visible = false;
        end;

        local v70 = u11[u12];

        if v70 then
            local u71 = nil;

            for _, v in Players:GetPlayers() do
                if v.UserId == v70 then
                    u71 = v;
                    break;
                end;
            end;

            if u13 then
                u13:Disconnect();
                u13 = nil;
            end;

            if not u71 then
                return;
            end;

            local v72 = u71 and u71.Character;

            if v72 then
                local v73 = v72:FindFirstChildOfClass("Humanoid");
                local v74 = v73 and workspace.CurrentCamera;

                if v74 then
                    v74.CameraSubject = v73;
                end;
            end;

            u13 = u71.CharacterAdded:Connect(function(p75) -- Line: 117
                -- upvalues: u10 (ref), u11 (ref), u12 (ref), u71 (copy)
                local Humanoid = p75:WaitForChild("Humanoid", 5);

                if not Humanoid then
                    return;
                end;

                if not u10 then
                    return;
                end;

                if u11[u12] ~= u71.UserId then
                    return;
                end;

                local workspace_CurrentCamera = workspace.CurrentCamera;

                if workspace_CurrentCamera then
                    workspace_CurrentCamera.CameraSubject = Humanoid;
                end;
            end);
        end;
    end);
end;

return v54;