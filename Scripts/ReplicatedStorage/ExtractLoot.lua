--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ExtractLoot
  Path:     game.ReplicatedStorage.CmdrClient.Commands.ExtractLoot
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "extractLoot",
    Description = "Extract all LootBag items (routes to inventory / Loot Storage; simulates dungeon extraction)",
    Group = "Admin",
    Aliases = { "el" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player whose LootBag to extract"
        } }
};