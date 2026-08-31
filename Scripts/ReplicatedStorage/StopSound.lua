--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     StopSound
  Path:     game.ReplicatedStorage.CmdrClient.Commands.StopSound
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "StopSound",
    Description = "Stops an admin sound. With no ID given, stops the most recently played sound.",
    Group = "Admin",
    Aliases = { "ss" },
    Args = { {
            Type = "string",
            Name = "Sound ID",
            Description = "The ID of the sound to stop. Leave blank to stop the most recently played sound.",
            Optional = true
        } }
};