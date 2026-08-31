--[[
  Type:     ModuleScript
  Method:   cached
  Name:     run
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.run
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "run",
    Description = "Runs a given command string (replacing embedded commands).",
    Group = "DefaultUtil",
    Aliases = { ">" },
    AutoExec = { "alias \"discard|Run a command and discard the output.\" replace ${run $1} .* \\\"\\\"" },
    Args = { {
            Type = "string",
            Name = "Command",
            Description = "The command string to run"
        } },

    Run = function(p1, p2) -- Line: 17, Name: Run
        return p1.Cmdr.Util.RunCommandString(p1.Dispatcher, p2);
    end
};