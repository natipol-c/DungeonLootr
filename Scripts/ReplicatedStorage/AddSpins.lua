--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AddSpins
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AddSpins
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AddSpins",
    Description = "Add Normal or Lucky spins to a player",
    Group = "Admin",
    Aliases = { "as" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player who\'ll receive the spins"
        }, {
            Type = "string",
            Name = "Type",
            Description = "Spin type: Normal or Lucky"
        }, {
            Type = "number",
            Name = "Amount",
            Description = "Number of spins to add"
        } }
};