--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BeforeRun
  Path:     game.ReplicatedStorage.CmdrClient.Types.BeforeRun
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");

return function(p1) -- Line: 12
    -- upvalues: RunService (copy), Players (copy)
    if not RunService:IsServer() then
        p1:RegisterHook("BeforeRun", function(p2) -- Line: 43
            -- upvalues: Players (ref)
            local v3 = p2.Executor or Players.LocalPlayer;

            if v3 and not v3:GetAttribute("CmdrEnabled") then
                return "You don\'t have permission to run commands.";
            end;
        end);

        return;
    end;

    local ServerScriptService = game:GetService("ServerScriptService");
    local CmdrAdmin = require(ServerScriptService.Cmdr.CmdrAdmin);
    p1:RegisterHook("BeforeRun", function(p4) -- Line: 18
        -- upvalues: CmdrAdmin (copy)
        local Executor = p4.Executor;

        if not (Executor and Executor:IsA("Player")) then
            return;
        end;

        local v5, v6 = CmdrAdmin.CanRunCommand(Executor, p4.Group);

        if not v5 then
            return v6;
        end;
    end);
end;