--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Prompts
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.Prompts
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local SetPromptVisibility = ReplicatedStorage.Remotes:WaitForChild("SetPromptVisibility");
local SetPromptAction = ReplicatedStorage.Remotes:WaitForChild("SetPromptAction");
require(ReplicatedStorage.Packages.Knit);

return function() -- Line: 10
    -- upvalues: SetPromptVisibility (copy), SetPromptAction (copy)
    SetPromptVisibility.OnClientEvent:Connect(function(p1, p2) -- Line: 11
        if p1 and p1:IsA("ProximityPrompt") then
            p1.Enabled = p2;

            return;
        end;

        warn("Invalid prompt provided to SetPromptVisibility.");
    end);
    SetPromptAction.OnClientEvent:Connect(function(p3: any, p4: string) -- Line: 19
        if not p3 then
            return;
        end;

        p3.ActionText = p4;
    end);
end;