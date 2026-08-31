--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     replica
  Path:     game.ReplicatedStorage.Packages._Index.aykut92_replica@0.1.7.replica
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:39 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");

if RunService:IsServer() then
    return require(script.server);
end;

local server = script.Parent:FindFirstChild("server");

if server and RunService:IsRunning() then
    server:Destroy();
end;

return require(script.client);