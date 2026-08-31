--[[
  Type:     ModuleScript
  Method:   cached
  Name:     resolve
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.resolve
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "resolve",
    Description = "Resolves Argument Value Operators into lists. E.g., resolve players * gives you a list of all players.",
    Group = "DefaultUtil",
    Aliases = {},
    AutoExec = { "alias \"me|Displays your username\" resolve players ." },
    Args = {
        {
            Type = "type",
            Name = "Type",
            Description = "The type for which to resolve"
        },

        function(p1) -- Line: 15
            if p1:GetArgument(1):Validate() ~= false then
                return {
                    Name = "Argument Value Operator",
                    Description = "The value operator to resolve. One of: * ** . ? ?N",
                    Optional = true,
                    Type = p1:GetArgument(1):GetValue()
                };
            end;
        end
    },

    Run = function(p2) -- Line: 29, Name: Run
        return table.concat(p2:GetArgument(2).RawSegments, ",");
    end
};