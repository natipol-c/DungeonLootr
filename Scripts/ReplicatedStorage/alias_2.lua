--[[
  Type:     ModuleScript
  Method:   cached
  Name:     alias
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.alias
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "alias",
    Description = "Creates a new, single command out of a command and given arguments.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = { {
            Type = "string",
            Name = "Alias name",
            Description = "The key or input type you\'d like to bind the command to."
        }, {
            Type = "string",
            Name = "Command string",
            Description = "The command text you want to run. Separate multiple commands with \"&&\". Accept arguments with $1, $2, $3, etc."
        } },

    ClientRun = function(p1, p2, p3) -- Line: 19, Name: ClientRun
        p1.Cmdr.Registry:RegisterCommandObject(p1.Cmdr.Util.MakeAliasCommand(p2, p3), true);

        return ("Created alias %q"):format(p2);
    end
};