--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Top
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Top
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:12 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("GuiService");
local RunService = game:GetService("RunService");
ReplicatedStorage:WaitForChild("GameInfo");
require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Registry = require(script.Parent.Parent.Controllers.Registry);
require(ReplicatedStorage.Packages.Knit);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local _ = game.Players.LocalPlayer;
local ServerState = ReplicatedStorage:WaitForChild("ServerState");
local u3 = {};

local function UpdateServerLuck() -- Line: 61
    -- upvalues: u3 (copy), ReplicatedStorage (copy)
    u3.LuckFrame.CurrentLuck.Text = `Server Luck x{ReplicatedStorage.ServerState.Luck.Value}`;
end;

local function UpdateServerTime() -- Line: 65
    -- upvalues: u3 (copy), SharedUtils (copy), ReplicatedStorage (copy)
    u3.LuckFrame.Time.Text = SharedUtils.FormatToHHMMSS(ReplicatedStorage.ServerState.LuckTimeLeft.Value);
end;

function u3._Init(p4) -- Line: 69
    -- upvalues: u1 (ref), u2 (ref), Registry (copy), u3 (copy), ServerState (copy), RunService (copy), SharedUtils (copy), ReplicatedStorage (copy), UpdateServerLuck (copy), UpdateServerTime (copy)
    u1 = p4;
    u2 = Registry:Get("PlayerData");
    local Top = u1.HUD.Top;
    u3.LuckFrame = Top.Luck;
    local Server_Event = Top.Server_Event;
    local Time = Server_Event.Time;
    local Current_Event = Server_Event.Current_Event;
    Server_Event.Visible = false;

    local function UpdateEventBanner() -- Line: 83
        -- upvalues: ServerState (ref), Server_Event (copy), Current_Event (copy)
        local v5 = ServerState:GetAttribute("ActiveEventDisplay") or "";
        local v6 = ServerState:GetAttribute("ActiveEventEndTime") or 0;

        if v5 == "" or v6 <= 0 then
            Server_Event.Visible = false;

            return;
        end;

        Current_Event.Text = v5;
        Server_Event.Visible = true;
    end;

    ServerState:GetAttributeChangedSignal("ActiveEventDisplay"):Connect(UpdateEventBanner);
    ServerState:GetAttributeChangedSignal("ActiveEventEndTime"):Connect(UpdateEventBanner);
    local v7 = ServerState:GetAttribute("ActiveEventDisplay") or "";
    local v8 = ServerState:GetAttribute("ActiveEventEndTime") or 0;

    if v7 == "" or v8 <= 0 then
        Server_Event.Visible = false;
    else
        Current_Event.Text = v7;
        Server_Event.Visible = true;
    end;

    RunService.RenderStepped:Connect(function() -- Line: 101
        -- upvalues: Server_Event (copy), ServerState (ref), Time (copy), SharedUtils (ref)
        if not Server_Event.Visible then
            return;
        end;

        local v9 = (ServerState:GetAttribute("ActiveEventEndTime") or 0) - workspace:GetServerTimeNow();
        local math_max_ret = math.max(0, v9);

        if math_max_ret <= 0 then
            Server_Event.Visible = false;

            return;
        end;

        Time.Text = SharedUtils.FormatToHHMMSS(math_max_ret);
    end);
    ReplicatedStorage.ServerState.Luck:GetPropertyChangedSignal("Value"):Connect(UpdateServerLuck);
    ReplicatedStorage.ServerState.LuckTimeLeft:GetPropertyChangedSignal("Value"):Connect(UpdateServerTime);
    RunService.RenderStepped:Connect(function() -- Line: 119
        -- upvalues: u3 (ref), ReplicatedStorage (ref)
        u3.LuckFrame.Visible = ReplicatedStorage.ServerState.Luck.Value > 1;
    end);
end;

return u3;