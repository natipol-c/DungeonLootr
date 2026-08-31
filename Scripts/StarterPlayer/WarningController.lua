--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     WarningController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.WarningController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "WarningController"
});
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;

local function DismissCurrent() -- Line: 54
    -- upvalues: u10 (ref), u2 (ref)
    if u10 then
        local v11 = u10;
        u10 = nil;
        task.spawn(v11, false);
    end;

    if u2 then
        u2.Visible = false;
    end;
end;

function v1.KnitInit(p12) -- Line: 67
    -- upvalues: Knit (copy), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref)
    u2 = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):WaitForChild("Warning");
    u3 = u2:WaitForChild("Warning_Message");
    u4 = u2:WaitForChild("Confirm");
    u5 = u4:WaitForChild("TextLabel");
    u6 = u2:WaitForChild("Deny");
    u7 = u6:WaitForChild("TextLabel");
    u2.Visible = false;
end;

function v1.KnitStart(p13) -- Line: 86
    -- upvalues: u8 (ref), u4 (ref), u10 (ref), u2 (ref), u9 (ref), u6 (ref)
    u8 = u4.MouseButton1Click:Connect(function() -- Line: 88
        -- upvalues: u10 (ref), u2 (ref)
        if u10 then
            local v14 = u10;
            u10 = nil;
            u2.Visible = false;
            task.spawn(v14, true);
        end;
    end);
    u9 = u6.MouseButton1Click:Connect(function() -- Line: 97
        -- upvalues: u10 (ref), u2 (ref)
        if u10 then
            local v15 = u10;
            u10 = nil;
            task.spawn(v15, false);
        end;

        if u2 then
            u2.Visible = false;
        end;
    end);
end;

function v1.Prompt(p16: table, p17: table) -- Line: 107
    -- upvalues: u10 (ref), u2 (ref), u3 (ref), u5 (ref), u7 (ref), Knit (copy)
    if u10 then
        local v18 = u10;
        u10 = nil;
        task.spawn(v18, false);
    end;

    if u2 then
        u2.Visible = false;
    end;

    u3.Text = p17.Message or "";
    u5.Text = p17.ConfirmText or "Yes";
    u7.Text = p17.DenyText or "No";
    u2.Visible = true;
    pcall(function() -- Line: 120
        -- upvalues: Knit (ref)
        Knit.GetController("SoundController"):Play("Ting");
    end);
    u10 = coroutine.running();

    return coroutine.yield();
end;

function v1.Dismiss(p19) -- Line: 130
    -- upvalues: u10 (ref), u2 (ref)
    if u10 then
        local v20 = u10;
        u10 = nil;
        task.spawn(v20, false);
    end;

    if u2 then
        u2.Visible = false;
    end;
end;

function v1.IsActive(p21) -- Line: 135
    -- upvalues: u10 (ref)
    return u10 ~= nil;
end;

return v1;