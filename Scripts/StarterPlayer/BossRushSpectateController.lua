--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BossRushSpectateController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.BossRushSpectateController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
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

local function ResolveTargetPlayer(p17: number) -- Line: 48
    -- upvalues: Players (copy)
    for _, v in Players:GetPlayers() do
        if v.UserId == p17 then
            return v;
        end;
    end;

    return nil;
end;

local function UpdateLabels(p18: userdata?) -- Line: 55
    -- upvalues: u8 (ref), u9 (ref)
    if u8 then
        u8.Text = p18 and (p18.DisplayName or "—") or "—";
    end;

    if u9 then
        u9.Text = p18 and "@" .. p18.Name or "";
    end;
end;

local function SetCameraToPlayer(p19: userdata?) -- Line: 66
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

local function StartCameraEnforcement() -- Line: 83
    -- upvalues: u15 (ref), RunService (copy), u11 (ref), u12 (ref), u13 (ref), Players (copy)
    if u15 then
        return;
    end;

    u15 = RunService.RenderStepped:Connect(function() -- Line: 85
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

local function StopCameraEnforcement() -- Line: 104
    -- upvalues: u15 (ref)
    if u15 then
        u15:Disconnect();
        u15 = nil;
    end;
end;

local function AttachCameraTracking(u24: userdata?) -- Line: 113
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

    u14 = u24.CharacterAdded:Connect(function(p28) -- Line: 122
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

    u14 = u31.CharacterAdded:Connect(function(p35) -- Line: 122
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

local function EnterSpectate(p36: table) -- Line: 148
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
        u10.Visible = false;
    end;

    if #u12 > 0 then
        u13 = 1;
        local v37 = u12[1];
        local u38 = nil;

        for _, v in Players:GetPlayers() do
            if v.UserId == v37 then
                u38 = v;
                break;
            end;
        end;

        if u8 then
            u8.Text = u38 and (u38.DisplayName or "—") or "—";
        end;

        if u9 then
            u9.Text = u38 and ("@" .. u38.Name or "") or "";
        end;

        if u14 then
            u14:Disconnect();
            u14 = nil;
        end;

        if u38 then
            local v39 = u38 and u38.Character;

            if v39 then
                local v40 = v39:FindFirstChildOfClass("Humanoid");
                local v41 = v40 and workspace.CurrentCamera;

                if v41 then
                    v41.CameraSubject = v40;
                end;
            end;

            u14 = u38.CharacterAdded:Connect(function(p42) -- Line: 122
                -- upvalues: u11 (ref), u12 (ref), u13 (ref), u38 (copy)
                local Humanoid = p42:WaitForChild("Humanoid", 5);

                if not Humanoid then
                    return;
                end;

                if not u11 then
                    return;
                end;

                if u12[u13] ~= u38.UserId then
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

    u15 = RunService.RenderStepped:Connect(function() -- Line: 85
        -- upvalues: u11 (ref), u12 (ref), u13 (ref), Players (ref)
        if not u11 then
            return;
        end;

        local v43 = u12[u13];

        if not v43 then
            return;
        end;

        local v44 = nil;

        for _, v in Players:GetPlayers() do
            if v.UserId == v43 then
                v44 = v;
                break;
            end;
        end;

        if not v44 then
            return;
        end;

        local Character = v44.Character;

        if not Character then
            return;
        end;

        local v45 = Character:FindFirstChildOfClass("Humanoid");

        if not v45 or v45.Health <= 0 then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera and workspace_CurrentCamera.CameraSubject ~= v45 then
            workspace_CurrentCamera.CameraSubject = v45;
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
        local v46 = Character:FindFirstChildOfClass("Humanoid");
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if v46 and workspace_CurrentCamera then
            workspace_CurrentCamera.CameraSubject = v46;
        end;
    end;
end;

local function UpdateTargets(p47: table) -- Line: 211
    -- upvalues: u11 (ref), u12 (ref), u13 (ref), u8 (ref), u9 (ref), Players (copy), u14 (ref)
    if not u11 then
        return;
    end;

    local v48 = u12[u13];
    u12 = p47 or {};

    if #u12 == 0 then
        if u8 then
            u8.Text = "—";
        end;

        if u9 then
            u9.Text = "";
        end;

        return;
    end;

    local v49 = 0;

    for i, v in u12 do
        if v == v48 then
            v49 = i;
            break;
        end;
    end;

    if v49 > 0 then
        u13 = v49;

        return;
    end;

    u13 = math.clamp(u13, 1, #u12);
    local v50 = u12[u13];
    local u51 = nil;

    for _, v in Players:GetPlayers() do
        if v.UserId == v50 then
            u51 = v;
            break;
        end;
    end;

    if u8 then
        u8.Text = u51 and (u51.DisplayName or "—") or "—";
    end;

    if u9 then
        u9.Text = u51 and ("@" .. u51.Name or "") or "";
    end;

    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;

    if not u51 then
        return;
    end;

    local v52 = u51 and u51.Character;

    if v52 then
        local v53 = v52:FindFirstChildOfClass("Humanoid");
        local v54 = v53 and workspace.CurrentCamera;

        if v54 then
            v54.CameraSubject = v53;
        end;
    end;

    u14 = u51.CharacterAdded:Connect(function(p55) -- Line: 122
        -- upvalues: u11 (ref), u12 (ref), u13 (ref), u51 (copy)
        local Humanoid = p55:WaitForChild("Humanoid", 5);

        if not Humanoid then
            return;
        end;

        if not u11 then
            return;
        end;

        if u12[u13] ~= u51.UserId then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            workspace_CurrentCamera.CameraSubject = Humanoid;
        end;
    end);
end;

local v56 = Knit.CreateController({
    Name = "BossRushSpectateController"
});

function v56.IsSpectating(p57) -- Line: 247
    -- upvalues: u11 (ref)
    return u11;
end;

function v56.KnitInit(p58) -- Line: 253
    -- upvalues: Knit (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref)
    local Dungeon_Container = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("Dungeon_Container");

    if not Dungeon_Container then
        return;
    end;

    u3 = Dungeon_Container:FindFirstChild("Spectate_Info");

    if not u3 then
        warn("[BossRushSpectateController] Spectate_Info frame not found under Dungeon_Container");

        return;
    end;

    u4 = u3:FindFirstChild("Return");
    u5 = u3:FindFirstChild("Revive");
    u6 = u3:FindFirstChild("Next");
    u7 = u3:FindFirstChild("Previous");
    u8 = u3:FindFirstChild("PlayerName");
    u9 = u3:FindFirstChild("Username");
    u10 = u3:FindFirstChild("HighestFloor");
    u3.Visible = false;
end;

function v56.KnitStart(p59) -- Line: 275
    -- upvalues: u3 (ref), u2 (ref), Knit (copy), u4 (ref), u11 (ref), u5 (ref), u16 (ref), MarketplaceService (copy), LocalPlayer (copy), u1 (copy), u6 (ref), u12 (ref), u13 (ref), Players (copy), u8 (ref), u9 (ref), u14 (ref), u7 (ref), EnterSpectate (copy), ExitSpectate (copy), UpdateTargets (copy)
    if not u3 then
        return;
    end;

    u2 = Knit.GetService("BossRushService");

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
                local v60 = Knit.GetController("WarningController"):Prompt({
                    Message = "<font color=\"rgb(255,60,60)\"><b>WARNING: REVIVING FORFEITS THIS RUN\'S LEADERBOARD PLACEMENT. YOUR RESULT WILL NOT BE RANKED.</b></font>",
                    ConfirmText = "Revive",
                    DenyText = "Cancel"
                });

                if not u11 then
                    return;
                end;

                if not v60 then
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
            local v61 = u12[u13];
            local u62 = nil;

            for _, v in Players:GetPlayers() do
                if v.UserId == v61 then
                    u62 = v;
                    break;
                end;
            end;

            if u8 then
                u8.Text = u62 and (u62.DisplayName or "—") or "—";
            end;

            if u9 then
                u9.Text = u62 and ("@" .. u62.Name or "") or "";
            end;

            if u14 then
                u14:Disconnect();
                u14 = nil;
            end;

            if not u62 then
                return;
            end;

            local v63 = u62 and u62.Character;

            if v63 then
                local v64 = v63:FindFirstChildOfClass("Humanoid");
                local v65 = v64 and workspace.CurrentCamera;

                if v65 then
                    v65.CameraSubject = v64;
                end;
            end;

            u14 = u62.CharacterAdded:Connect(function(p66) -- Line: 122
                -- upvalues: u11 (ref), u12 (ref), u13 (ref), u62 (copy)
                local Humanoid = p66:WaitForChild("Humanoid", 5);

                if not Humanoid then
                    return;
                end;

                if not u11 then
                    return;
                end;

                if u12[u13] ~= u62.UserId then
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
            local v67 = u12[u13];
            local u68 = nil;

            for _, v in Players:GetPlayers() do
                if v.UserId == v67 then
                    u68 = v;
                    break;
                end;
            end;

            if u8 then
                u8.Text = u68 and (u68.DisplayName or "—") or "—";
            end;

            if u9 then
                u9.Text = u68 and ("@" .. u68.Name or "") or "";
            end;

            if u14 then
                u14:Disconnect();
                u14 = nil;
            end;

            if not u68 then
                return;
            end;

            local v69 = u68 and u68.Character;

            if v69 then
                local v70 = v69:FindFirstChildOfClass("Humanoid");
                local v71 = v70 and workspace.CurrentCamera;

                if v71 then
                    v71.CameraSubject = v70;
                end;
            end;

            u14 = u68.CharacterAdded:Connect(function(p72) -- Line: 122
                -- upvalues: u11 (ref), u12 (ref), u13 (ref), u68 (copy)
                local Humanoid = p72:WaitForChild("Humanoid", 5);

                if not Humanoid then
                    return;
                end;

                if not u11 then
                    return;
                end;

                if u12[u13] ~= u68.UserId then
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
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 339
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

        local v73 = u12[u13];

        if v73 then
            local u74 = nil;

            for _, v in Players:GetPlayers() do
                if v.UserId == v73 then
                    u74 = v;
                    break;
                end;
            end;

            if u14 then
                u14:Disconnect();
                u14 = nil;
            end;

            if not u74 then
                return;
            end;

            local v75 = u74 and u74.Character;

            if v75 then
                local v76 = v75:FindFirstChildOfClass("Humanoid");
                local v77 = v76 and workspace.CurrentCamera;

                if v77 then
                    v77.CameraSubject = v76;
                end;
            end;

            u14 = u74.CharacterAdded:Connect(function(p78) -- Line: 122
                -- upvalues: u11 (ref), u12 (ref), u13 (ref), u74 (copy)
                local Humanoid = p78:WaitForChild("Humanoid", 5);

                if not Humanoid then
                    return;
                end;

                if not u11 then
                    return;
                end;

                if u12[u13] ~= u74.UserId then
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

return v56;