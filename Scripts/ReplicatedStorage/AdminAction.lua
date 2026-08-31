--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AdminAction
  Path:     game.ReplicatedStorage.CmdrClient.Types.AdminAction
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local Util = require(script.Parent.Parent.Shared.Util);
local u1 = { "Invisible", "Mute" };

return function(p2) -- Line: 11
    -- upvalues: Util (copy), u1 (copy)
    p2:RegisterType("adminAction", Util.MakeEnumType("Admin action", u1));
end;