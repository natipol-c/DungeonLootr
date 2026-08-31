--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     convertTimestamp
  Path:     game.ReplicatedStorage.CmdrClient.Commands.convertTimestamp
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "convertTimestamp",
    Description = "Convert a timestamp to a human-readable format.",
    Group = "DefaultUtil",
    Aliases = { "date" },
    Args = { {
            Type = "number",
            Name = "timestamp",
            Description = "A numerical representation of a specific moment in time.",
            Optional = true
        } },

    ClientRun = function(p1, p2) -- Line: 14, Name: ClientRun
        local v3 = p2 or os.time();

        return `{os.date("%x", v3)} {os.date("%X", v3)}`;
    end
};