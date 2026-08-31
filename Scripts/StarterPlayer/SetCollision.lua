--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SetCollision
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.SetCollision
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function() -- Line: 4
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.SetCollission.OnClientEvent:Connect(function(p1: table, p2: boolean) -- Line: 5
        for _, v in p1 do
            v.CanCollide = p2;
        end;
    end);
end;