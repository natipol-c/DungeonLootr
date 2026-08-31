--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SpawnChest
  Path:     game.ReplicatedStorage.CmdrClient.Commands.SpawnChest
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "spawnchest",
    Description = "Spawns a loot chest at a player\'s position for testing",
    Group = "Admin",
    Aliases = { "lootchest" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to spawn the chest on"
        }, {
            Type = "string",
            Name = "Rarity",
            Description = "Chest rarity (Common, Uncommon, Rare, Epic, Legendary, Mythic, Celestial)",
            Default = "Common"
        }, {
            Type = "integer",
            Name = "Count",
            Description = "Number of chests to spawn (1-5)",
            Default = 1
        } }
};