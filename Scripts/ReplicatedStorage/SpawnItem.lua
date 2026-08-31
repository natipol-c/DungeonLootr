--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SpawnItem
  Path:     game.ReplicatedStorage.CmdrClient.Commands.SpawnItem
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "SpawnItem",
    Description = "spawn npc to close to player",
    Group = "Admin",
    Aliases = { "si" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The Player the Item will spawn close to"
        }, {
            Type = "string",
            Name = "ItemId",
            Description = "The ID of the item"
        } }
};