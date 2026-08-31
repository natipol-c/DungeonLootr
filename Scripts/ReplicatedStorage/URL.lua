--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     URL
  Path:     game.ReplicatedStorage.CmdrClient.Types.URL
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

local Util = require(script.Parent.Parent.Shared.Util);
local u3 = {
    Validate = function(p1) -- Line: 4, Name: Validate
        if p1:match("^https?://.+$") then
            return true;
        end;

        return false, "URLs must begin with http:// or https://";
    end,

    Parse = function(p2) -- Line: 12, Name: Parse
        return p2;
    end
};

return function(p4) -- Line: 17
    -- upvalues: u3 (copy), Util (copy)
    p4:RegisterType("url", u3);
    p4:RegisterType("urls", Util.MakeListableType(u3));
end;