--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Command
  Path:     game.ReplicatedStorage.CmdrClient.Types.Command
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

local Util = require(script.Parent.Parent.Shared.Util);

return function(u1) -- Line: 3
    -- upvalues: Util (copy)
    local v6 = {
        Transform = function(p2) -- Line: 5, Name: Transform
            -- upvalues: Util (ref), u1 (copy)
            return Util.MakeFuzzyFinder(u1:GetCommandNames())(p2);
        end,

        Validate = function(p3) -- Line: 11, Name: Validate
            return #p3 > 0, "No command with that name could be found.";
        end,

        Autocomplete = function(p4) -- Line: 15, Name: Autocomplete
            return p4;
        end,

        Parse = function(p5) -- Line: 19, Name: Parse
            return p5[1];
        end
    };
    u1:RegisterType("command", v6);
    u1:RegisterType("commands", Util.MakeListableType(v6));
end;