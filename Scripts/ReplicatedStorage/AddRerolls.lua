--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AddRerolls
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AddRerolls
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AddRerolls",
    Description = "Add reroll crystals to a player",
    Group = "Admin",
    Aliases = { "addr" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player who\'ll receive the crystals"
        }, {
            Type = "string",
            Name = "Type",
            Description = "Crystal type: Basic or Hyper"
        }, {
            Type = "number",
            Name = "Amount",
            Description = "Amount to add"
        } }
};