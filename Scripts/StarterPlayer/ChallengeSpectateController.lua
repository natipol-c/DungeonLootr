--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ChallengeSpectateController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.ChallengeSpectateController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local MonetizationList = require(ReplicatedStorage.GameInfo.MonetizationList);
local LocalPlayer = Players.LocalPlayer;
local u1 = MonetizationList.BossRushRevive and MonetizationList.BossRushRevive.Id or 3579160067;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = false;
local u12 = {};
local u13 = 0;
local u14 = nil;
local u15 = nil;
local u16 = false;

local function ResolveTargetPlayer(p17: number) -- Line: 53
    -- upvalues: Players (copy)
    for _, v in Players:GetPlayers() do
        if v.UserId == p17 then
            return v;
        end;
    end;

    return nil;
end;

local function UpdateLabels(p18: userdata?) -- Line: 60
    -- upvalues: u8 (ref), u9 (ref)
    if u8 then
        u8.Text = p18 and (p18.DisplayName or "—") or "—";
    end;

    if u9 then
        u9.Text = p18 and "@" .. p18.Name or "";
    end;
end;

local function SetCameraToPlayer(p19: userdata?) -- Line: 71
    if not p19 then
        return;
    end;

    local Character = p19.Character;

    if not Character then
        return;
    end;

    local v20 = Character:FindFirstChildOfClass("Humanoid");

    if not v20 then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera.CameraSubject = v20;
    end;
end;

local function StartCameraEnforcement() -- Line: 86
    -- upvalues: u15 (ref), RunService (copy), u11 (ref), u12 (ref), u13 (ref), Players (copy)
    if u15 then
        return;
    end;

    u15 = RunService.RenderStepped:Connect(function() -- Line: 88
        -- upvalues: u11 (ref), u12 (ref), u13 (ref), Players (ref)
        if not u11 then
            return;
        end;

        local v21 = u12[u13];

        if not v21 then
            return;
        end;

        local v22 = nil;

        for _, v in Players:GetPlayers() do
            if v.UserId == v21 then
                v22 = v;
                break;
            end;
        end;

        if not v22 then
            return;
        end;

        local Character = v22.Character;

        if not Character then
            return;
        end;

        local v23 = Character:FindFirstChildOfClass("Humanoid");

        if not v23 or v23.Health <= 0 then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera and workspace_CurrentCamera.CameraSubject ~= v23 then
            workspace_CurrentCamera.CameraSubject = v23;
        end;
    end);
end;

local function StopCameraEnforcement() -- Line: 107
    -- upvalues: u15 (ref)
    if u15 then
        u15:Disconnect();
        u15 = nil;
    end;
end;

local function AttachCameraTracking(u24: userdata?) -- Line: 115
    -- upvalues: u14 (ref), u11 (ref), u12 (ref), u13 (ref)
    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;

    if not u24 then
        return;
    end;

    local v25 = u24 and u24.Character;

    if v25 then
        local v26 = v25:FindFirstChildOfClass("Humanoid");
        local v27 = v26 and workspace.CurrentCamera;

        if v27 then
            v27.CameraSubject = v26;
        end;
    end;

    u14 = u24.CharacterAdded:Connect(function(p28) -- Line: 124
        -- upvalues: u11 (ref), u12 (ref), u13 (ref), u24 (copy)
        local Humanoid = p28:WaitForChild("Humanoid", 5);

        if not Humanoid then
            return;
        end;

        if not u11 then
            return;
        end;

        if u12[u13] ~= u24.UserId then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            workspace_CurrentCamera.CameraSubject = Humanoid;
        end;
    end);
end;

local function Cycle(p29: number) -- Line: 138
    -- upvalues: u12 (ref), u13 (ref), Players (copy), u8 (ref), u9 (ref), u14 (ref), u11 (ref)
    if #u12 == 0 then
        return;
    end;

    u13 = (u13 - 1 + p29) % #u12 + 1;
    local v30 = u12[u13];
    local u31 = nil;

    for _, v in Players:GetPlayers() do
        if v.UserId == v30 then
            u31 = v;
            break;
        end;
    end;

    if u8 then
        u8.Text = u31 and (u31.DisplayName or "—") or "—";
    end;

    if u9 then
        u9.Text = u31 and ("@" .. u31.Name or "") or "";
    end;

    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;

    if not u31 then
        return;
    end;

    local v32 = u31 and u31.Character;

    if v32 then
        local v33 = v32:FindFirstChildOfClass("Humanoid");
        local v34 = v33 and workspace.CurrentCamera;

        if v34 then
            v34.CameraSubject = v33;
        end;
    end;

    u14 = u31.CharacterAdded:Connect(function(p35) -- Line: 124
        -- upvalues: u11 (ref), u12 (ref), u13 (ref), u31 (copy)
        local Humanoid = p35:WaitForChild("Humanoid", 5);

        if not Humanoid then
            return;
        end;

        if not u11 then
            return;
        end;

        if u12[u13] ~= u31.UserId then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            workspace_CurrentCamera.CameraSubject = Humanoid;
        end;
    end);
end;

local function EnterSpectate(p36: table, p37: number?) -- Line: 148
    -- upvalues: u11 (ref), u12 (ref), u13 (ref), u3 (ref), u10 (ref), Players (copy), u8 (ref), u9 (ref), u14 (ref), u15 (ref), RunService (copy)
    u11 = true;
    u12 = p36 or {};
    u13 = 0;

    if u3 then
        u3.Visible = true;
        local Parent = u3.Parent;

        if Parent and Parent:IsA("GuiObject") then
            Parent.Visible = true;
        end;
    end;

    if u10 then
        u10.Text = ("FINISHED ON WAVE: %d"):format(p37 or 0);
        u10.Visible = true;
    end;

    if #u12 > 0 then
        u13 = 1;
        local v38 = u12[1];
        local u39 = nil;

        for _, v in Players:GetPlayers() do
            if v.UserId == v38 then
                u39 = v;
                break;
            end;
        end;

        if u8 then
            u8.Text = u39 and (u39.DisplayName or "—") or "—";
        end;

        if u9 then
            u9.Text = u39 and ("@" .. u39.Name or "") or "";
        end;

        if u14 then
            u14:Disconnect();
            u14 = nil;
        end;

        if u39 then
            local v40 = u39 and u39.Character;

            if v40 then
                local v41 = v40:FindFirstChildOfClass("Humanoid");
                local v42 = v41 and workspace.CurrentCamera;

                if v42 then
                    v42.CameraSubject = v41;
                end;
            end;

            u14 = u39.CharacterAdded:Connect(function(p43) -- Line: 124
                -- upvalues: u11 (ref), u12 (ref), u13 (ref), u39 (copy)
                local Humanoid = p43:WaitForChild("Humanoid", 5);

                if not Humanoid then
                    return;
                end;

                if not u11 then
                    return;
                end;

                if u12[u13] ~= u39.UserId then
                    return;
                end;

                local workspace_CurrentCamera = workspace.CurrentCamera;

                if workspace_CurrentCamera then
                    workspace_CurrentCamera.CameraSubject = Humanoid;
                end;
            end);
        end;
    else
        if u8 then
            u8.Text = "—";
        end;

        if u9 then
            u9.Text = "";
        end;
    end;

    if u15 then
        return;
    end;

    u15 = RunService.RenderStepped:Connect(function() -- Line: 88
        -- upvalues: u11 (ref), u12 (ref), u13 (ref), Players (ref)
        if not u11 then
            return;
        end;

        local v44 = u12[u13];

        if not v44 then
            return;
        end;

        local v45 = nil;

        for _, v in Players:GetPlayers() do
            if v.UserId == v44 then
                v45 = v;
                break;
            end;
        end;

        if not v45 then
            return;
        end;

        local Character = v45.Character;

        if not Character then
            return;
        end;

        local v46 = Character:FindFirstChildOfClass("Humanoid");

        if not v46 or v46.Health <= 0 then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera and workspace_CurrentCamera.CameraSubject ~= v46 then
            workspace_CurrentCamera.CameraSubject = v46;
        end;
    end);
end;

local function ExitSpectate() -- Line: 181
    -- upvalues: u11 (ref), u12 (ref), u13 (ref), u15 (ref), u14 (ref), u3 (ref), LocalPlayer (copy)
    u11 = false;
    u12 = {};
    u13 = 0;

    if u15 then
        u15:Disconnect();
        u15 = nil;
    end;

    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;

    if u3 then
        u3.Visible = false;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        local v47 = Character:FindFirstChildOfClass("Humanoid");
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if v47 and workspace_CurrentCamera then
            workspace_CurrentCamera.CameraSubject = v47;
        end;
    end;
end;

local function UpdateTargets(p48: table) -- Line: 209
    -- upvalues: u11 (ref), u12 (ref), u13 (ref), u8 (ref), u9 (ref), Players (copy), u14 (ref)
    if not u11 then
        return;
    end;

    local v49 = u12[u13];
    u12 = p48 or {};

    if #u12 == 0 then
        if u8 then
            u8.Text = "—";
        end;

        if u9 then
            u9.Text = "";
        end;

        return;
    end;

    local v50 = 0;

    for i, v in u12 do
        if v == v49 then
            v50 = i;
            break;
        end;
    end;

    if v50 > 0 then
        u13 = v50;

        return;
    end;

    u13 = math.clamp(u13, 1, #u12);
    local v51 = u12[u13];
    local u52 = nil;

    for _, v in Players:GetPlayers() do
        if v.UserId == v51 then
            u52 = v;
            break;
        end;
    end;

    if u8 then
        u8.Text = u52 and (u52.DisplayName or "—") or "—";
    end;

    if u9 then
        u9.Text = u52 and ("@" .. u52.Name or "") or "";
    end;

    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;

    if not u52 then
        return;
    end;

    local v53 = u52 and u52.Character;

    if v53 then
        local v54 = v53:FindFirstChildOfClass("Humanoid");
        local v55 = v54 and workspace.CurrentCamera;

        if v55 then
            v55.CameraSubject = v54;
        end;
    end;

    u14 = u52.CharacterAdded:Connect(function(p56) -- Line: 124
        -- upvalues: u11 (ref), u12 (ref), u13 (ref), u52 (copy)
        local Humanoid = p56:WaitForChild("Humanoid", 5);

        if not Humanoid then
            return;
        end;

        if not u11 then
            return;
        end;

        if u12[u13] ~= u52.UserId then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            workspace_CurrentCamera.CameraSubject = Humanoid;
        end;
    end);
end;

local v57 = Knit.CreateController({
    Name = "ChallengeSpectateController"
});

function v57.IsSpectating(p58) -- Line: 244
    -- upvalues: u11 (ref)
    return u11;
end;

function v57.KnitInit(p59) -- Line: 250
    -- upvalues: Knit (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref)
    local Dungeon_Container = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("Dungeon_Container");

    if not Dungeon_Container then
        return;
    end;

    u3 = Dungeon_Container:FindFirstChild("Spectate_Info");

    if not u3 then
        warn("[ChallengeSpectateController] Spectate_Info frame not found under Dungeon_Container");

        return;
    end;

    u4 = u3:FindFirstChild("Return");
    u5 = u3:FindFirstChild("Revive");
    u6 = u3:FindFirstChild("Next");
    u7 = u3:FindFirstChild("Previous");
    u8 = u3:FindFirstChild("PlayerName");
    u9 = u3:FindFirstChild("Username");
    u10 = u3:FindFirstChild("HighestFloor");
end;

function v57.KnitStart(p60) -- Line: 270
    -- upvalues: u3 (ref), Knit (copy), u2 (ref), u4 (ref), u11 (ref), u5 (ref), u16 (ref), MarketplaceService (copy), LocalPlayer (copy), u1 (copy), u6 (ref), u12 (ref), u13 (ref), Players (copy), u8 (ref), u9 (ref), u14 (ref), u7 (ref), EnterSpectate (copy), ExitSpectate (copy), UpdateTargets (copy)
    if not u3 then
        return;
    end;

    local success, result = pcall(function() -- Line: 274
        -- upvalues: Knit (ref)
        return Knit.GetService("ChallengeRunService");
    end);

    if not (success and result) then
        return;
    end;

    u2 = result;

    if u4 and u4:IsA("GuiButton") then
        u4.Activated:Connect(function() -- Line: 282
            -- upvalues: u11 (ref), u2 (ref)
            if not u11 then
                return;
            end;

            u2:LeaveSpectate();
        end);
    end;

    if u5 and u5:IsA("GuiButton") then
        u5.Activated:Connect(function() -- Line: 289
            -- upvalues: u11 (ref), u16 (ref), Knit (ref), MarketplaceService (ref), LocalPlayer (ref), u1 (ref)
            if not u11 then
                return;
            end;

            if not u16 then
                local v61 = Knit.GetController("WarningController"):Prompt({
                    Message = "<font color=\"rgb(255,60,60)\"><b>WARNING: REVIVING FORFEITS THIS RUN\'S LEADERBOARD PLACEMENT. YOUR RESULT WILL NOT BE RANKED.</b></font>",
                    ConfirmText = "Revive",
                    DenyText = "Cancel"
                });

                if not u11 then
                    return;
                end;

                if not v61 then
                    return;
                end;

                u16 = true;
            end;

            MarketplaceService:PromptProductPurchase(LocalPlayer, u1);
        end);
    end;

    if u6 and u6:IsA("GuiButton") then
        u6.Activated:Connect(function() -- Line: 316
            -- upvalues: u12 (ref), u13 (ref), Players (ref), u8 (ref), u9 (ref), u14 (ref), u11 (ref)
            if #u12 == 0 then
                return;
            end;

            u13 = (u13 - 1 + 1) % #u12 + 1;
            local v62 = u12[u13];
            local u63 = nil;

            for _, v in Players:GetPlayers() do
                if v.UserId == v62 then
                    u63 = v;
                    break;
                end;
            end;

            if u8 then
                u8.Text = u63 and (u63.DisplayName or "—") or "—";
            end;

            if u9 then
                u9.Text = u63 and ("@" .. u63.Name or "") or "";
            end;

            if u14 then
                u14:Disconnect();
                u14 = nil;
            end;

            if not u63 then
                return;
            end;

            local v64 = u63 and u63.Character;

            if v64 then
                local v65 = v64:FindFirstChildOfClass("Humanoid");
                local v66 = v65 and workspace.CurrentCamera;

                if v66 then
                    v66.CameraSubject = v65;
                end;
            end;

            u14 = u63.CharacterAdded:Connect(function(p67) -- Line: 124
                -- upvalues: u11 (ref), u12 (ref), u13 (ref), u63 (copy)
                local Humanoid = p67:WaitForChild("Humanoid", 5);

                if not Humanoid then
                    return;
                end;

                if not u11 then
                    return;
                end;

                if u12[u13] ~= u63.UserId then
                    return;
                end;

                local workspace_CurrentCamera = workspace.CurrentCamera;

                if workspace_CurrentCamera then
                    workspace_CurrentCamera.CameraSubject = Humanoid;
                end;
            end);
        end);
    end;

    if u7 and u7:IsA("GuiButton") then
        u7.Activated:Connect(function() -- Line: 322
            -- upvalues: u12 (ref), u13 (ref), Players (ref), u8 (ref), u9 (ref), u14 (ref), u11 (ref)
            if #u12 == 0 then
                return;
            end;

            u13 = (u13 - 1 + -1) % #u12 + 1;
            local v68 = u12[u13];
            local u69 = nil;

            for _, v in Players:GetPlayers() do
                if v.UserId == v68 then
                    u69 = v;
                    break;
                end;
            end;

            if u8 then
                u8.Text = u69 and (u69.DisplayName or "—") or "—";
            end;

            if u9 then
                u9.Text = u69 and ("@" .. u69.Name or "") or "";
            end;

            if u14 then
                u14:Disconnect();
                u14 = nil;
            end;

            if not u69 then
                return;
            end;

            local v70 = u69 and u69.Character;

            if v70 then
                local v71 = v70:FindFirstChildOfClass("Humanoid");
                local v72 = v71 and workspace.CurrentCamera;

                if v72 then
                    v72.CameraSubject = v71;
                end;
            end;

            u14 = u69.CharacterAdded:Connect(function(p73) -- Line: 124
                -- upvalues: u11 (ref), u12 (ref), u13 (ref), u69 (copy)
                local Humanoid = p73:WaitForChild("Humanoid", 5);

                if not Humanoid then
                    return;
                end;

                if not u11 then
                    return;
                end;

                if u12[u13] ~= u69.UserId then
                    return;
                end;

                local workspace_CurrentCamera = workspace.CurrentCamera;

                if workspace_CurrentCamera then
                    workspace_CurrentCamera.CameraSubject = Humanoid;
                end;
            end);
        end);
    end;

    u2.EnterSpectate:Connect(EnterSpectate);
    u2.ExitSpectate:Connect(ExitSpectate);
    u2.SpectateTargetsUpdate:Connect(UpdateTargets);
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 334
        -- upvalues: u11 (ref), u3 (ref), u12 (ref), u13 (ref), Players (ref), u14 (ref)
        if not u11 then
            return;
        end;

        task.wait(0.1);

        if not u11 then
            return;
        end;

        if u3 then
            u3.Visible = true;
            local Parent = u3.Parent;

            if Parent and Parent:IsA("GuiObject") then
                Parent.Visible = true;
            end;
        end;

        local v74 = u12[u13];

        if v74 then
            local u75 = nil;

            for _, v in Players:GetPlayers() do
                if v.UserId == v74 then
                    u75 = v;
                    break;
                end;
            end;

            if u14 then
                u14:Disconnect();
                u14 = nil;
            end;

            if not u75 then
                return;
            end;

            local v76 = u75 and u75.Character;

            if v76 then
                local v77 = v76:FindFirstChildOfClass("Humanoid");
                local v78 = v77 and workspace.CurrentCamera;

                if v78 then
                    v78.CameraSubject = v77;
                end;
            end;

            u14 = u75.CharacterAdded:Connect(function(p79) -- Line: 124
                -- upvalues: u11 (ref), u12 (ref), u13 (ref), u75 (copy)
                local Humanoid = p79:WaitForChild("Humanoid", 5);

                if not Humanoid then
                    return;
                end;

                if not u11 then
                    return;
                end;

                if u12[u13] ~= u75.UserId then
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

return v57;