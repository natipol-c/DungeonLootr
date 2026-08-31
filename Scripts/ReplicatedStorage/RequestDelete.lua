--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RequestDelete
  Path:     game.ReplicatedStorage.CmdrClient.Commands.RequestDelete
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "RequestDelete",
    Description = "Request a full data reset for YOUR account. You will be kicked and your data wiped on rejoin.",
    Group = "Member",
    Aliases = { "resetdata", "deletedata" },
    Args = { {
            Type = "string",
            Name = "Username",
            Description = "Your exact username (must match your own name for safety)"
        } }
};