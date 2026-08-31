--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     knit
  Path:     game.ReplicatedStorage.Packages._Index.sleitnick_knit@1.7.0.knit
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");

if RunService:IsServer() then
    return require(script.KnitServer);
end;

local KnitServer = script:FindFirstChild("KnitServer");

if KnitServer and RunService:IsRunning() then
    KnitServer:Destroy();
end;

return require(script.KnitClient);