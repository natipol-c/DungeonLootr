--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DebugBridgeController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.DebugBridgeController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "DebugBridgeController"
});

local function BuildCommands() -- Line: 21
    -- upvalues: Knit (copy)
    local Service = Knit.GetService("PlayerActionService");

    return {
        money = function(p2) -- Line: 24, Name: money
            -- upvalues: Service (copy)
            Service.SetMoney:Fire(tonumber(p2) or 0);
        end,

        level = function(p3) -- Line: 25, Name: level
            -- upvalues: Service (copy)
            Service.ApplyLevel:Fire(tonumber(p3) or 1);
        end,

        class = function(p4) -- Line: 26, Name: class
            -- upvalues: Service (copy)
            Service.ChangeClass:Fire(p4);
        end,

        fly = function() -- Line: 27, Name: fly
            -- upvalues: Service (copy)
            Service.ActivateAdminFly:Fire();
        end
    };
end;

local function Dispatch(p5: any, p6: string) -- Line: 32
    local string_match_ret, v7 = string.match(p6, "^(%S+)%s*(.*)$");

    if string_match_ret then
        string_match_ret = p5[string.lower(string_match_ret)];
    end;

    if string_match_ret then
        string_match_ret(v7);
    end;
end;

function v1.KnitStart(p8) -- Line: 40
    -- upvalues: ReplicatedStorage (copy), BuildCommands (copy)
    if not ReplicatedStorage:GetAttribute("DevBridgeEnabled") then
        return;
    end;

    local u9 = BuildCommands();
    local DevConsoleInput = ReplicatedStorage:FindFirstChild("DevConsoleInput");

    if DevConsoleInput and DevConsoleInput:IsA("RemoteEvent") then
        DevConsoleInput.OnClientEvent:Connect(function(p10) -- Line: 49
            -- upvalues: u9 (copy)
            local v11 = u9;
            local string_match_ret, v12 = string.match(p10, "^(%S+)%s*(.*)$");

            if string_match_ret then
                string_match_ret = v11[string.lower(string_match_ret)];
            end;

            if string_match_ret then
                string_match_ret(v12);
            end;
        end);
    end;
end;

return v1;