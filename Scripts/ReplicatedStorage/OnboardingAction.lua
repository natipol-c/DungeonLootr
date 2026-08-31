--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     OnboardingAction
  Path:     game.ReplicatedStorage.CmdrClient.Types.OnboardingAction
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local Util = require(script.Parent.Parent.Shared.Util);
local u1 = { "Start", "Dungeon", "OutOfDungeon", "End" };

return function(p2) -- Line: 19
    -- upvalues: Util (copy), u1 (copy)
    p2:RegisterType("onboardingAction", Util.MakeEnumType("Onboarding phase", u1));
end;