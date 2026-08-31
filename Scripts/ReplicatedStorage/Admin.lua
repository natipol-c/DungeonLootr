--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Admin
  Path:     game.ReplicatedStorage.CmdrClient.Commands.Admin
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Admin",
    Description = "Toggle admin effects on a player (Invisible, Mute)",
    Group = "Admin",
    Aliases = { "adm" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "Target player"
        }, {
            Type = "adminAction",
            Name = "Action",
            Description = "Effect to toggle: Invisible or Mute"
        }, {
            Type = "toggleState",
            Name = "Enabled",
            Description = "true to apply, false to revert"
        } }
};