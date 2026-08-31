--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     teleport
  Path:     game.ReplicatedStorage.CmdrClient.Commands.teleport
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:21 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "teleport",
    Description = "Teleports a player or set of players to one target.",
    Group = "Admin",
    Aliases = { "tp" },
    AutoExec = { "alias \"bring|Brings a player or set of players to you.\" teleport $1{players|players|The players to bring} ${me}", "alias \"to|Teleports you to another player or location.\" teleport ${me} $1{player @ vector3|Destination|The player or location to teleport to}" },
    Args = { {
            Type = "players",
            Name = "From",
            Description = "The players to teleport"
        }, {
            Type = "player @ vector3",
            Name = "Destination",
            Description = "The player to teleport to"
        } }
};