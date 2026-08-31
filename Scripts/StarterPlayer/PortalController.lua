--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PortalController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.PortalController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LoadingOverlay = require(ReplicatedStorage.ClientTools.LoadingOverlay);
local v1 = Knit.CreateController({
    Name = "PortalController"
});
local u2 = nil;

local function wirePortal(u3: userdata) -- Line: 25
    -- upvalues: LoadingOverlay (copy), u2 (ref)
    local Warp_Part = u3:FindFirstChild("Warp_Part");

    if not Warp_Part then
        warn("[PortalController] Portal model missing Warp_Part:", u3.Name);

        return;
    end;

    local v4 = Warp_Part:FindFirstChildOfClass("ProximityPrompt");

    if v4 then
        v4.PromptShown:Connect(function() -- Line: 38
            -- upvalues: LoadingOverlay (ref), u2 (ref), u3 (copy)
            LoadingOverlay.Run({
                StatusText = "Warping",

                Action = function() -- Line: 44, Name: Action
                    -- upvalues: u2 (ref), u3 (ref)
                    u2:UsePortal(u3.Name):await();
                end
            });
        end);

        return;
    end;

    warn("[PortalController] Warp_Part missing ProximityPrompt:", u3.Name);
end;

function v1.KnitInit(p5) -- Line: 53
end;

function v1.KnitStart(p6) -- Line: 55
    -- upvalues: u2 (ref), Knit (copy), CollectionService (copy), wirePortal (copy)
    u2 = Knit.GetService("PortalService");

    for _, v in CollectionService:GetTagged("Portal") do
        wirePortal(v);
    end;

    CollectionService:GetInstanceAddedSignal("Portal"):Connect(wirePortal);
end;

return v1;