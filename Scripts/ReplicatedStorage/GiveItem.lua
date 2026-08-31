--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiveItem
  Path:     game.ReplicatedStorage.CmdrClient.Commands.GiveItem
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "giveItem",
    Description = "Give item to a player, all in server, or all servers (currency, spins, potions, packages, cosmetics, titles, stones, battlepass XP)",
    Group = "Admin",
    Aliases = { "gi" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to receive the item (ignored for server/global scope)"
        }, {
            Type = "giveableItem",
            Name = "ItemId",
            Description = "Item to give (autocomplete enabled)"
        }, {
            Type = "integer",
            Name = "Amount",
            Description = "Quantity to give",
            Default = 1
        }, {
            Type = "giveScope",
            Name = "Scope",
            Description = "player = one target, server = all in lobby, global = all servers",
            Default = "player"
        } }
};