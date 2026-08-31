--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     respawn
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Admin.respawn
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "respawn",
    Description = "Respawns a player or a group of players.",
    Group = "DefaultAdmin",
    AutoExec = { "alias \"refresh|Respawns the player and returns them to their previous location.\" var= .refresh_pos ${position $1{player|Player}} && respawn $1 && tp $1 @${{var .refresh_pos}}" },
    Args = { {
            Type = "players",
            Name = "targets",
            Description = "The players to respawn."
        } }
};