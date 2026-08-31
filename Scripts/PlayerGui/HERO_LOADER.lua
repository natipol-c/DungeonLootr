--[[
  Type:     LocalScript
  Method:   cached
  Name:     HERO_LOADER
  Path:     game.Players.Natipol123.PlayerGui.Main.Frames.Chest_RNG.Chests.Template_Scroller.ItemContainer.Hero.HERO_LOADER
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:21 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local ViewportFrame = script.Parent.ViewportFrame;

local function LoadModel(p1) -- Line: 7
    -- upvalues: ViewportFrame (copy), SharedUtils (copy)
    if not p1 then
        return;
    end;

    for _, child in ViewportFrame:GetChildren() do
        if child:IsA("WorldModel") or (child:IsA("Model") or child:IsA("Camera")) then
            child:Destroy();
        end;
    end;

    SharedUtils.LoadItemViewport(ViewportFrame, p1);
end;

task.defer(function() -- Line: 19
    -- upvalues: LoadModel (copy)
    LoadModel(script:GetAttribute("ModelName"));
end);
script:GetAttributeChangedSignal("ModelName"):Connect(function() -- Line: 24
    -- upvalues: LoadModel (copy)
    LoadModel(script:GetAttribute("ModelName"));
end);