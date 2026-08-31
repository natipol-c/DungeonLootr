--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SetLooped
  Path:     game.ReplicatedStorage.CmdrClient.Commands.SetLooped
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "SetLooped",
    Description = "Toggles Looping for a sound for a player or all players",
    Group = "Admin",
    Aliases = { "setloop" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to play the sound for (ignored for server/global scope)"
        }, {
            Type = "string",
            Name = "Sound ID",
            Description = "The ID of the sound to play."
        }, {
            Type = "boolean",
            Name = "Looped",
            Description = "To Loop or not a sound (false is default)."
        } }
};