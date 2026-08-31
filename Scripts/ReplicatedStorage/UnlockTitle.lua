--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UnlockTitle
  Path:     game.ReplicatedStorage.CmdrClient.Commands.UnlockTitle
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "UnlockTitle",
    Description = "Unlock a title for a player",
    Group = "Admin",
    Aliases = { "ut" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player who will receive the title"
        }, {
            Type = "string",
            Name = "TitleId",
            Description = "The ID of the title to unlock"
        } }
};