--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     respawn
  Path:     game.ReplicatedStorage.CmdrClient.Commands.respawn
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:21 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "respawn",
    Description = "Respawns a player or a group of players.",
    Group = "Admin",
    AutoExec = { "alias \"refresh|Respawns the player and returns them to their previous location.\" var= .refresh_pos ${position $1{player|Player}} && respawn $1 && tp $1 @${{var .refresh_pos}}" },
    Args = { {
            Type = "players",
            Name = "targets",
            Description = "The players to respawn."
        } }
};