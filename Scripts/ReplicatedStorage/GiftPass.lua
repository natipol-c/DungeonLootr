--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiftPass
  Path:     game.ReplicatedStorage.CmdrClient.Commands.GiftPass
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "GiftPass",
    Description = "Grant a dev product to a player (without charging Robux)",
    Group = "Admin",
    Aliases = { "gp", "giveproduct" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to receive the product"
        }, {
            Type = "devProduct",
            Name = "Product",
            Description = "The dev product to grant"
        }, {
            Type = "integer",
            Name = "Amount",
            Description = "How many times to grant (default: 1)",
            Optional = true,
            Default = 1
        } }
};