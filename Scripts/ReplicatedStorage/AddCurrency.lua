--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AddCurrency
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AddCurrency
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AddCurrency",
    Description = "Add currency to a player",
    Group = "Admin",
    Aliases = { "ac" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The Player who\'ll receive the currency"
        }, {
            Type = "number",
            Name = "Amount",
            Description = "Amount to send"
        } }
};