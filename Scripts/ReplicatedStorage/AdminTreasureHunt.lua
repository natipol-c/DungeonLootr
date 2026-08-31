--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AdminTreasureHunt
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AdminTreasureHunt
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AdminTreasureHunt",
    Description = "Scatter Treasure Chests around the map across ALL servers (Admin Event). Each chest grants a Mystery Box.",
    Group = "Admin",
    Aliases = { "ath" },
    Args = { {
            Type = "number",
            Name = "Amount",
            Description = "Number of chests to scatter (max 50, clamped to available spawn points). Default 10.",
            Optional = true
        }, {
            Type = "number",
            Name = "Duration",
            Description = "Event duration in seconds (default 180, max 600). Unclaimed chests despawn when time runs out.",
            Optional = true
        } }
};