--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PlaySound
  Path:     game.ReplicatedStorage.CmdrClient.Commands.PlaySound
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "PlaySound",
    Description = "Plays a sound for a player or all players",
    Group = "Admin",
    Aliases = { "ps" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to play the sound for (ignored for server/global scope)"
        }, {
            Type = "string",
            Name = "Sound ID",
            Description = "The ID of the sound to play."
        }, {
            Type = "number",
            Name = "Volume",
            Description = "The volume of the sound (1 is default).",
            Optional = true
        }, {
            Type = "number",
            Name = "Playback Speed",
            Description = "The playback speed of the sound (1 is default).",
            Optional = true
        }, {
            Type = "boolean",
            Name = "Looped",
            Description = "If the sound should loop indefinitely",
            Optional = true
        }, {
            Type = "string",
            Name = "Scope",
            Description = "player = one target, server = all in lobby, global = all servers",
            Optional = true
        } }
};