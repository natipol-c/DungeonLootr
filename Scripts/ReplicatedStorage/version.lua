--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     version
  Path:     game.ReplicatedStorage.CmdrClient.Commands.version
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:21 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "version",
    Description = "Shows the current version of Cmdr",
    Group = "DefaultDebug",
    Args = {},

    Run = function() -- Line: 9, Name: Run
        return ("Cmdr Version %s"):format("v1.12.0");
    end
};