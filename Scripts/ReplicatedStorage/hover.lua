--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     hover
  Path:     game.ReplicatedStorage.CmdrClient.Commands.hover
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");

return {
    Name = "hover",
    Description = "Returns the name of the player you are hovering over.",
    Group = "DefaultUtil",
    Args = {},

    ClientRun = function() -- Line: 9, Name: ClientRun
        -- upvalues: Players (copy)
        local Target = Players.LocalPlayer:GetMouse().Target;

        if not Target then
            return "";
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Target:FindFirstAncestorOfClass("Model"));

        return PlayerFromCharacter and PlayerFromCharacter.Name or "";
    end
};