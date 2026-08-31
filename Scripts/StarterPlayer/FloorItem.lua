--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     FloorItem
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.FloorItem
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Packages.Knit);
local Highlight = Instance.new("Highlight");
Highlight.FillTransparency = 1;
Highlight.OutlineTransparency = 0;
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
Highlight.Parent = workspace.Highlights;

function _init(p1: userdata)
    -- upvalues: Highlight (copy)
    local u2 = p1:FindFirstAncestorOfClass("Model");
    local CFrame2 = u2.PrimaryPart.CFrame;
    task.spawn(function() -- Line: 20
        -- upvalues: u2 (copy), CFrame2 (copy)
        local v3 = 0;

        while u2 and u2.PrimaryPart do
            local v4 = time() * 5;
            local v5 = math.sin(v4) / 5;
            local math_max_ret = math.max(v5, -0.3);
            u2:PivotTo(CFrame2 * CFrame.Angles(0, math.rad(v3), 0) * CFrame.new(0, math_max_ret, 0));
            v3 = (v3 + 0.5) % 360;
            task.wait(0.01);
        end;
    end);
    p1.PromptShown:Connect(function() -- Line: 32
        -- upvalues: Highlight (ref), u2 (copy)
        Highlight.Adornee = u2;
        Highlight.Enabled = true;
    end);
    p1.PromptHidden:Connect(function() -- Line: 37
        -- upvalues: Highlight (ref)
        Highlight.Adornee = nil;
        Highlight.Enabled = false;
    end);
end;

return function() -- Line: 43
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("FLOOR_ITEM"):Connect(function(p6) -- Line: 44
        _init(p6);
    end);

    for _, v in ipairs(CollectionService:GetTagged("FLOOR_ITEM")) do
        _init(v);
    end;
end;