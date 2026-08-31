--[[
  Type:     ModuleScript
  Method:   cached
  Name:     math
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.math
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "math",
    Description = "Perform a math operation on 2 values.",
    Group = "DefaultUtil",
    Aliases = {},
    AutoExec = { "alias \"+|Perform an addition.\" math + $1{number|Number} $2{number|Number}", "alias \"-|Perform a subtraction.\" math - $1{number|Number} $2{number|Number}", "alias \"*|Perform a multiplication.\" math * $1{number|Number} $2{number|Number}", "alias \"/|Perform a division.\" math / $1{number|Number} $2{number|Number}", "alias \"**|Perform an exponentiation.\" math ** $1{number|Number} $2{number|Number}", "alias \"%|Perform a modulus.\" math % $1{number|Number} $2{number|Number}" },
    Args = { {
            Type = "mathOperator",
            Name = "Operation",
            Description = "A math operation."
        }, {
            Type = "number",
            Name = "Value",
            Description = "A number value."
        }, {
            Type = "number",
            Name = "Value",
            Description = "A number value."
        } },

    ClientRun = function(p1, p2, p3, p4) -- Line: 32, Name: ClientRun
        return p2.Perform(p3, p4);
    end
};