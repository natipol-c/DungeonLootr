--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PauseSound
  Path:     game.ReplicatedStorage.CmdrClient.Commands.PauseSound
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "PauseSound",
    Description = "Pauses a sound for a player or all players",
    Group = "Admin",
    Aliases = { "paus" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to play the sound for (ignored for server/global scope)"
        }, {
            Type = "string",
            Name = "Sound ID",
            Description = "The ID of the sound to play."
        } }
};