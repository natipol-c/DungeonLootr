--[[
  Type:     ModuleScript
  Method:   cached
  Name:     JSON
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.JSON
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");

return function(p1) -- Line: 3
    -- upvalues: HttpService (copy)
    p1:RegisterType("json", {
        Validate = function(p2) -- Line: 5, Name: Validate
            -- upvalues: HttpService (ref)
            return pcall(HttpService.JSONDecode, HttpService, p2);
        end,

        Parse = function(p3) -- Line: 9, Name: Parse
            -- upvalues: HttpService (ref)
            return HttpService:JSONDecode(p3);
        end
    });
end;