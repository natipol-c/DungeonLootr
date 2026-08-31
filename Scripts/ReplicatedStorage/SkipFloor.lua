--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SkipFloor
  Path:     game.ReplicatedStorage.CmdrClient.Commands.SkipFloor
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "SkipFloor",
    Description = "Skip forward in the active Boss Rush or Endless session. If the executor is in an Endless run, skips that session\'s wave. Otherwise falls back to the active Boss Rush session.",
    Group = "Admin",
    Aliases = { "sf" },
    Args = { {
            Type = "integer",
            Name = "floor",
            Description = "Target floor/wave number. Boss Rush: 1-100. Endless: must be greater than current wave."
        } }
};