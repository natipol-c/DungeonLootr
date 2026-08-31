--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ToggleState
  Path:     game.ReplicatedStorage.CmdrClient.Types.ToggleState
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local Util = require(script.Parent.Parent.Shared.Util);
local u1 = Util.MakeDictionary({ "true", "t", "yes", "y", "on", "enable", "enabled", "1", "+" });
local u2 = Util.MakeDictionary({ "false", "f", "no", "n", "off", "disable", "disabled", "0", "-" });
local u3 = { "true", "false" };

return function(p4) -- Line: 19
    -- upvalues: u1 (copy), u2 (copy), u3 (copy)
    p4:RegisterType("toggleState", {
        Transform = function(p5) -- Line: 21, Name: Transform
            return p5:lower();
        end,

        Validate = function(p6) -- Line: 25, Name: Validate
            -- upvalues: u1 (ref), u2 (ref)
            return u1[p6] ~= nil and true or u2[p6] ~= nil, "Please use true or false.";
        end,

        Autocomplete = function(p7) -- Line: 29, Name: Autocomplete
            -- upvalues: u3 (ref)
            local v8 = p7:lower();
            local v9 = {};

            for _, v in ipairs(u3) do
                if v:sub(1, #v8) == v8 then
                    table.insert(v9, v);
                end;
            end;

            return v9;
        end,

        Parse = function(p10) -- Line: 40, Name: Parse
            -- upvalues: u1 (ref)
            return u1[p10] == true;
        end
    });
end;