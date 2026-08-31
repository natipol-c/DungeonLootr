--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DungeonInviteController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.DungeonInviteController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = Knit.CreateController({
    Name = "DungeonInviteController"
});
local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = 0;

local function BuildMessage(p12) -- Line: 56
    local v13 = `<b>{p12.DisplayName or "Someone"}</b>`;

    if p12.Mode == "BossRush" then
        return `{v13} has invited you to {p12.BossName and `Boss Rush — <b>{p12.BossName}</b>` or "Boss Rush"}. Join them?`;
    end;

    if not p12.DungeonName then
        return `{v13} has invited you to their party. Join them?`;
    end;

    local v14 = `<b>{p12.DungeonName}</b>`;

    if p12.Difficulty then
        v14 = v14 .. ` ({p12.Difficulty})`;
    end;

    return `{v13} has invited you to {v14}. Join them?`;
end;

local function Hide() -- Line: 78
    -- upvalues: u2 (ref), u10 (ref), u11 (ref), u6 (ref), TweenService (copy), TweenInfo_new_ret2 (copy)
    if not u2 then
        return;
    end;

    u10 = nil;
    u11 = u11 + 1;

    if not u6 then
        u2.Visible = false;

        return;
    end;

    local v15 = TweenService:Create(u6, TweenInfo_new_ret2, {
        Scale = 0
    });
    v15.Completed:Once(function() -- Line: 85
        -- upvalues: u2 (ref), u10 (ref)
        if u2 and not u10 then
            u2.Visible = false;
        end;
    end);
    v15:Play();
end;

local function Show(p16) -- Line: 96
    -- upvalues: u2 (ref), u3 (ref), u10 (ref), BuildMessage (copy), u6 (ref), TweenService (copy), TweenInfo_new_ret (copy), Knit (copy), u11 (ref), u1 (copy)
    if not (u2 and u3) then
        return;
    end;

    u10 = p16.UserId;

    if u3 then
        u3.Text = BuildMessage(p16);
    end;

    u2.Visible = true;

    if u6 then
        u6.Scale = 0;
        TweenService:Create(u6, TweenInfo_new_ret, {
            Scale = 1
        }):Play();
    end;

    pcall(function() -- Line: 112
        -- upvalues: Knit (ref)
        Knit.GetController("SoundController"):Play("GiftReceived");
    end);
    u11 = u11 + 1;
    local u17 = u11;
    local UserId = p16.UserId;
    task.delay(30, function() -- Line: 121
        -- upvalues: u11 (ref), u17 (copy), u10 (ref), UserId (copy), u1 (ref)
        if u11 ~= u17 then
            return;
        end;

        if u10 ~= UserId then
            return;
        end;

        u1:Decline();
    end);
end;

function u1.Accept(p18) -- Line: 130
    -- upvalues: u10 (ref), Hide (copy), u7 (ref)
    local u19 = u10;

    if not u19 then
        return;
    end;

    Hide();

    if not u7 then
        return;
    end;

    task.spawn(function() -- Line: 136
        -- upvalues: u7 (ref), u19 (copy)
        pcall(function() -- Line: 137
            -- upvalues: u7 (ref), u19 (ref)
            u7:RequestAcceptInvite(u19):await();
        end);
    end);
end;

function u1.Decline(p20) -- Line: 143
    -- upvalues: u10 (ref), Hide (copy), u7 (ref)
    local u21 = u10;

    if not u21 then
        return;
    end;

    Hide();

    if not u7 then
        return;
    end;

    task.spawn(function() -- Line: 149
        -- upvalues: u7 (ref), u21 (copy)
        pcall(function() -- Line: 150
            -- upvalues: u7 (ref), u21 (ref)
            u7:RequestDeclineInvite(u21):await();
        end);
    end);
end;

local function OnInviteResult(p22: number, p23: boolean) -- Line: 159
    -- upvalues: u9 (ref), u8 (ref), Players (copy)
    if u9 then
        u9:ResetInvited(p22);
    end;

    if not u8 then
        return;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p22);
    local v24 = PlayerByUserId and PlayerByUserId.DisplayName or "User " .. tostring(p22);

    if p23 then
        u8:Show("Custom", `{v24} joined your party!`, 3, Color3.fromRGB(80, 220, 100), Color3.fromRGB(15, 50, 20), "Ting");

        return;
    end;

    u8:Show("Custom", `{v24} declined your invite.`, 3, Color3.fromRGB(255, 100, 80), Color3.fromRGB(60, 20, 15), "Error");
end;

function u1.KnitInit(p25) -- Line: 195
    -- upvalues: Knit (copy), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref)
    u2 = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):WaitForChild("Dungeon_Invite");

    if not u2 then
        warn("[DungeonInviteController] Dungeon_Invite frame not found");

        return;
    end;

    u3 = u2:FindFirstChild("Invite_Message");
    u4 = u2:FindFirstChild("Confirm");
    u5 = u2:FindFirstChild("Deny");
    u6 = u2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    u6.Parent = u2;
    u2.Visible = false;
end;

function u1.KnitStart(p26) -- Line: 218
    -- upvalues: u2 (ref), u8 (ref), Knit (copy), u9 (ref), u4 (ref), u1 (copy), u5 (ref), u7 (ref), Show (copy), OnInviteResult (copy)
    if not u2 then
        return;
    end;

    pcall(function() -- Line: 221
        -- upvalues: u8 (ref), Knit (ref)
        u8 = Knit.GetController("NotificationController");
    end);
    pcall(function() -- Line: 224
        -- upvalues: u9 (ref), Knit (ref)
        u9 = Knit.GetController("PlayerListController");
    end);

    if u4 then
        u4.Activated:Connect(function() -- Line: 230
            -- upvalues: u1 (ref)
            u1:Accept();
        end);
    end;

    if u5 then
        u5.Activated:Connect(function() -- Line: 235
            -- upvalues: u1 (ref)
            u1:Decline();
        end);
    end;

    local success, result = pcall(function() -- Line: 241
        -- upvalues: Knit (ref)
        return Knit.GetService("DungeonQueueService");
    end);

    if not (success and result) then
        warn("[DungeonInviteController] DungeonQueueService not available — invites disabled");

        return;
    end;

    u7 = result;
    u7.InviteReceived:Connect(function(p27) -- Line: 248
        -- upvalues: Show (ref)
        if not (p27 and p27.UserId) then
            return;
        end;

        Show(p27);
    end);
    u7.InviteResult:Connect(function(p28: number, p29: boolean) -- Line: 253
        -- upvalues: OnInviteResult (ref)
        OnInviteResult(p28, p29);
    end);
end;

return u1;