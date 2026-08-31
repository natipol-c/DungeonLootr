--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiveTitle
  Path:     game.ReplicatedStorage.CmdrClient.Commands.GiveTitle
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "giveTitle",
    Description = "Unlock a title for a player",
    Group = "Admin",
    Aliases = { "gt" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to receive the title"
        }, {
            Type = "titleId",
            Name = "TitleId",
            Description = "Title to grant (autocomplete enabled; quote multi-word titles)"
        } }
};