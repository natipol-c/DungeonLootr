--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     jsonArrayDecode
  Path:     game.ReplicatedStorage.CmdrClient.Commands.jsonArrayDecode
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:21 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "json-array-decode",
    Description = "Decodes a JSON Array into a comma-separated list",
    Group = "DefaultUtil",
    Aliases = {},
    Args = { {
            Type = "json",
            Name = "JSON",
            Description = "The JSON array."
        } },

    ClientRun = function(p1, p2) -- Line: 14, Name: ClientRun
        local v3 = type(p2) ~= "table" and { p2 } or p2;

        return table.concat(v3, ",");
    end
};