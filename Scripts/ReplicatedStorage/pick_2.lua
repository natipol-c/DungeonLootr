--[[
  Type:     ModuleScript
  Method:   cached
  Name:     pick
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.pick
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "pick",
    Description = "Picks a value out of a comma-separated list.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = { {
            Type = "integer",
            Name = "Index to pick",
            Description = "The index of the item you want to pick"
        }, {
            Type = "string",
            Name = "CSV",
            Description = "The comma-separated list"
        } },

    Run = function(p1, p2, p3) -- Line: 19, Name: Run
        return p3:split(",")[p2] or "";
    end
};