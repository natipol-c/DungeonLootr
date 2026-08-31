--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiveRandomEmote
  Path:     game.ReplicatedStorage.CmdrClient.Commands.GiveRandomEmote
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "giveRandomEmote",
    Description = "Grant random unowned emote(s) to player(s)",
    Group = "Admin",
    Aliases = { "gre" },
    Args = { {
            Type = "players",
            Name = "Players",
            Description = "The player(s) to receive random emote(s)"
        }, {
            Type = "integer",
            Name = "Count",
            Description = "How many random emotes to grant each player",
            Default = 1
        } }
};