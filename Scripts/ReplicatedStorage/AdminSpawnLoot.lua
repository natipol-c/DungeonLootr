--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AdminSpawnLoot
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AdminSpawnLoot
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AdminSpawnLoot",
    Description = "Spawn loot (EXP Tomes, Chests) at the arena across ALL servers (Admin Event)",
    Group = "Admin",
    Aliases = { "asl" },
    Args = { {
            Type = "number",
            Name = "Amount",
            Description = "Total number of loot items to spawn (max 50)"
        }, {
            Type = "string",
            Name = "LootType",
            Description = "What to spawn: \'EXPTome\', \'Chest\', or \'Mixed\' (default Mixed)",
            Optional = true,
            Default = "Mixed"
        }, {
            Type = "number",
            Name = "Duration",
            Description = "Event banner duration in seconds (default 120, max 600). Loot despawns when event ends.",
            Optional = true
        } }
};