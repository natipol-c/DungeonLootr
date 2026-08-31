--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     WipeLoot
  Path:     game.ReplicatedStorage.CmdrClient.Commands.WipeLoot
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "wipeLoot",
    Description = "Clear a player\'s LootBag (simulates death/failure — items are lost)",
    Group = "Admin",
    Aliases = { "wl" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player whose LootBag to wipe"
        } }
};