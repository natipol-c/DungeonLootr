--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     kick
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Admin.kick
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "kick",
    Description = "Kicks a player or set of players.",
    Group = "DefaultAdmin",
    Aliases = { "boot" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players to kick."
        } }
};