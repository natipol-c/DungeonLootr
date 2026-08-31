--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PromptEvent
  Path:     game.ReplicatedStorage.CmdrClient.Commands.PromptEvent
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "PromptEvent",
    Description = "Broadcast a Roblox Experience-Event RSVP prompt to every player on every server. Players already RSVP\'d \'Going\' are skipped. EventId is the experience event\'s ID from the Creator Dashboard.",
    Group = "Admin",
    Aliases = { "promptrsvp" },
    Args = { {
            Type = "string",
            Name = "EventId",
            Description = "The Experience Event ID to RSVP-prompt for (string; e.g. 1235)."
        } }
};