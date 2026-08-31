--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     gotoPlace
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Admin.gotoPlace
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "goto-place",
    Description = "Teleport to a Roblox place",
    Group = "DefaultAdmin",
    Aliases = {},
    AutoExec = { "alias \"follow-player|Join a player in another server\" goto-place $1{players|Players} ${{get-player-place-instance $2{playerId|Target}}}", "alias \"rejoin|Rejoin this place. You might end up in a different server.\" goto-place $1{players|Players} ${get-player-place-instance ${me} PlaceId}" },
    Args = { {
            Type = "players",
            Name = "Players",
            Description = "The players you want to teleport"
        }, {
            Type = "integer",
            Name = "Place ID",
            Description = "The Place ID you want to teleport to"
        }, {
            Type = "string",
            Name = "JobId",
            Description = "The specific JobId you want to teleport to",
            Optional = true
        } }
};