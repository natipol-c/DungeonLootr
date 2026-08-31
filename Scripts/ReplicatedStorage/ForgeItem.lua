--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ForgeItem
  Path:     game.ReplicatedStorage.CmdrClient.Commands.ForgeItem
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "forgeItem",
    Description = "Forge (upgrade) an equipment item by GUID. Optionally repeat N times.",
    Group = "Admin",
    Aliases = { "fi" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player who owns the item"
        }, {
            Type = "string",
            Name = "GUID",
            Description = "Equipment GUID to forge"
        }, {
            Type = "integer",
            Name = "Count",
            Description = "Number of forge attempts (default 1)",
            Default = 1
        } }
};