--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AddItem
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AddItem
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AddItem",
    Description = "Add npc to player base",
    Group = "Admin",
    Aliases = { "an" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The Player who\'ll receive the npc"
        }, {
            Type = "string",
            Name = "ItemId",
            Description = "The ID of the item"
        } }
};