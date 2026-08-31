--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AdminLowGravity
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AdminLowGravity
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AdminLowGravity",
    Description = "Change gravity across ALL servers for a duration (Admin Event)",
    Group = "Admin",
    Aliases = { "alg" },
    Args = { {
            Type = "number",
            Name = "GravityAmount",
            Description = "Target gravity value (default Roblox = 196.2, lower = floatier, e.g. 50)"
        }, {
            Type = "number",
            Name = "Duration",
            Description = "Duration in seconds before gravity reverts (max 600)"
        } }
};