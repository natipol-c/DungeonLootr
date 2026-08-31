--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ClickSound
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.ClickSound
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
local Knit = require(ReplicatedStorage.Packages.Knit);

function _init(p1: userdata)
    -- upvalues: Knit (copy)
    local u2 = p1:GetAttribute("ClickSound") or "ButtonClick";
    p1.InputBegan:Connect(function(p3) -- Line: 13
        -- upvalues: Knit (ref), u2 (copy)
        if p3.UserInputType == Enum.UserInputType.MouseButton1 or p3.UserInputType == Enum.UserInputType.Touch then
            Knit.GetController("SoundController"):Play(u2);
        end;
    end);
end;

return function() -- Line: 23
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("CLICK_SOUND"):Connect(function(p4) -- Line: 24
        _init(p4);
    end);

    for _, v in ipairs(CollectionService:GetTagged("CLICK_SOUND")) do
        _init(v);
    end;
end;