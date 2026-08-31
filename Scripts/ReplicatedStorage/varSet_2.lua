--[[
  Type:     ModuleScript
  Method:   cached
  Name:     varSet
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.varSet
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "var=",
    Description = "Sets a stored value.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = { {
            Type = "storedKey",
            Name = "Key",
            Description = "The key to set, saved in your user data store. Keys prefixed with . are not saved. Keys prefixed with $ are game-wide. Keys prefixed with $. are game-wide and non-saved."
        }, {
            Type = "string",
            Name = "Value",
            Description = "Value or values to set.",
            Default = ""
        } },

    ClientRun = function(p1, p2) -- Line: 20, Name: ClientRun
        p1:GetStore("vars_used")[p2] = true;
    end
};