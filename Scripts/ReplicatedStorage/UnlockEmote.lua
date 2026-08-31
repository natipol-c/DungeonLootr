--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UnlockEmote
  Path:     game.ReplicatedStorage.CmdrClient.Commands.UnlockEmote
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "unlockEmote",
    Description = "Unlock a specific emote for player(s)",
    Group = "Admin",
    Aliases = { "ue", "giveEmote" },
    Args = { {
            Type = "players",
            Name = "Players",
            Description = "The player(s) to receive the emote"
        }, {
            Type = "emote",
            Name = "Emote",
            Description = "The emote to unlock (autocomplete enabled)"
        } }
};