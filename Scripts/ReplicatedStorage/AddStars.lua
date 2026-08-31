--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AddStars
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AddStars
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AddStars",
    Description = "Add stars to a player",
    Group = "Admin",
    Aliases = { "as" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "Target player"
        }, {
            Type = "number",
            Name = "Amount",
            Description = "Amount to add"
        } }
};