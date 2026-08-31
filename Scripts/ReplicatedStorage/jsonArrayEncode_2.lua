--[[
  Type:     ModuleScript
  Method:   cached
  Name:     jsonArrayEncode
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.jsonArrayEncode
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");

return {
    Name = "json-array-encode",
    Description = "Encodes a comma-separated list into a JSON array",
    Group = "DefaultUtil",
    Aliases = {},
    Args = { {
            Type = "string",
            Name = "CSV",
            Description = "The comma-separated list"
        } },

    Run = function(p1, p2) -- Line: 16, Name: Run
        -- upvalues: HttpService (copy)
        return HttpService:JSONEncode(p2:split(","));
    end
};