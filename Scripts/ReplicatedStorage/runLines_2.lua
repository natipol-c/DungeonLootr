--[[
  Type:     ModuleScript
  Method:   cached
  Name:     runLines
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.runLines
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "run-lines",
    Description = "Splits input by newlines and runs each line as its own command. This is used by the init-run command.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = { {
            Type = "string",
            Name = "Script",
            Description = "The script to parse.",
            Default = ""
        } },

    ClientRun = function(p1, p2) -- Line: 15, Name: ClientRun
        if #p2 == 0 then
            return "";
        end;

        local v3 = p1.Dispatcher:Run("var", "INIT_PRINT_OUTPUT") ~= "";
        local v4 = p2:gsub("\n+", "\n"):split("\n");

        for _, v in ipairs(v4) do
            if v:sub(1, 1) ~= "#" then
                local v5 = p1.Dispatcher:EvaluateAndRun(v);

                if v3 then
                    p1:Reply(v5);
                end;
            end;
        end;

        return "";
    end
};