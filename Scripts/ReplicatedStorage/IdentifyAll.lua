--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     IdentifyAll
  Path:     game.ReplicatedStorage.CmdrClient.Commands.IdentifyAll
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "identifyAll",
    Description = "Collect all Loot Storage items into EquipmentInventory (until inventory full)",
    Group = "Admin",
    Aliases = { "ia", "collectAll", "ca" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player whose Loot Storage to collect"
        } }
};