--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GlobalAnnouncement
  Path:     game.ReplicatedStorage.CmdrClient.Commands.GlobalAnnouncement
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "globalAnnouncement",
    Description = "Broadcast an announcement to ALL servers (lobby + dungeons).",
    Group = "Admin",
    Aliases = { "ga" },
    Args = { {
            Type = "string",
            Name = "text",
            Description = "The announcement text."
        } }
};