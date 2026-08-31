--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiveEquipment
  Path:     game.ReplicatedStorage.CmdrClient.Commands.GiveEquipment
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "giveEquipment",
    Description = "Give a player a fully identified equipment piece (rolls stats immediately)",
    Group = "Admin",
    Aliases = { "ge" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to receive the equipment"
        }, {
            Type = "equipmentItemId",
            Name = "ItemId",
            Description = "Equipment template (autocomplete enabled)"
        }, {
            Type = "string",
            Name = "Rarity",
            Description = "Rarity override (Common/Uncommon/Rare/Epic/Legendary/Mythic/Celestial) — blank = random",
            Default = ""
        }, {
            Type = "integer",
            Name = "Level",
            Description = "Level override — blank = dungeon minimum",
            Default = 0
        } }
};