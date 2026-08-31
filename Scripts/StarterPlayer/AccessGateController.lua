--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AccessGateController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.AccessGateController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "AccessGateController"
});

function v1.KnitStart(p2) -- Line: 22
    -- upvalues: Knit (copy)
    Knit.GetService("AccessGateService").RewardReveal:Connect(function(p3, p4) -- Line: 25
        -- upvalues: Knit (ref)
        local Controller = Knit.GetController("RewardRevealController");

        if Controller then
            Controller:PlayEntries(p3, p4);
        end;
    end);
end;

return v1;