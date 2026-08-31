--[[
  Type:     ModuleScript
  Method:   cached
  Name:     len
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.len
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "len",
    Description = "Returns the length of a comma-separated list",
    Group = "DefaultUtil",
    Aliases = {},
    Args = { {
            Type = "string",
            Name = "CSV",
            Description = "The comma-separated list"
        } },

    Run = function(p1, p2) -- Line: 14, Name: Run
        return #p2:split(",");
    end
};