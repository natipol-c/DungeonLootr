--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     announce
  Path:     game.ReplicatedStorage.CmdrClient.Commands.announce
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:21 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "announce",
    Description = "Makes a server-wide announcement.",
    Group = "Admin",
    Aliases = { "m" },
    Args = { {
            Type = "string",
            Name = "text",
            Description = "The announcement text."
        } }
};