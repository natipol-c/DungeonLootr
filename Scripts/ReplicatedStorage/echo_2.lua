--[[
  Type:     ModuleScript
  Method:   cached
  Name:     echo
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.echo
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "echo",
    Description = "Echoes your text back to you.",
    Group = "DefaultUtil",
    Aliases = { "=" },
    Args = { {
            Type = "string",
            Name = "Text",
            Description = "The text."
        } },

    Run = function(p1, p2) -- Line: 14, Name: Run
        return p2;
    end
};