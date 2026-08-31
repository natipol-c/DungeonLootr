--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     rand
  Path:     game.ReplicatedStorage.CmdrClient.Commands.rand
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:21 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "rand",
    Description = "Returns a random number between min and max",
    Group = "DefaultUtil",
    Aliases = {},
    Args = { {
            Type = "integer",
            Name = "First number",
            Description = "If second number is nil, random number is between 1 and this value. If second number is provided, number is between this number and the second number."
        }, {
            Type = "integer",
            Name = "Second number",
            Description = "The upper bound.",
            Optional = true
        } },

    Run = function(p1, p2, p3) -- Line: 20, Name: Run
        local v4 = p3 and math.random(p2, p3) or math.random(p2);

        return tostring(v4);
    end
};