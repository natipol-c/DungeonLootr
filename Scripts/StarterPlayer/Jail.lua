--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Jail
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.Jail
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
require(ReplicatedStorage.Packages.Knit);

local function waitForDescendants(p1) -- Line: 7
    local function waitForParts(p2) -- Line: 9
        -- upvalues: waitForParts (copy)
        for _, child in ipairs(p2:GetChildren()) do
            if not child:IsA("BasePart") then
                waitForParts(child);
            end;
        end;
    end;

    waitForParts(p1);
end;

return function() -- Line: 21
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.SetJail.OnClientEvent:Connect(function(p3: userdata) -- Line: 22
        while not p3.Parent do
            task.wait();
        end;

        local function u5(p4) -- Line: 9
            -- upvalues: u5 (copy)
            for _, child in ipairs(p4:GetChildren()) do
                if not child:IsA("BasePart") then
                    u5(child);
                end;
            end;
        end;

        u5(p3);

        for _, descendant in ipairs(p3:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Color = Color3.fromRGB(21, 255, 0);
            end;
        end;
    end);
end;