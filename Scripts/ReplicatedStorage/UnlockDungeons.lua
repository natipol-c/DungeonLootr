--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UnlockDungeons
  Path:     game.ReplicatedStorage.CmdrClient.Commands.UnlockDungeons
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "unlockDungeons",
    Description = "Unlock all dungeons and difficulty modes for a player",
    Group = "Admin",
    Aliases = { "ud" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player whose dungeon progression will be unlocked"
        } }
};