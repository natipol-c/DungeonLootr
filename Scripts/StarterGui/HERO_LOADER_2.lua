--[[
  Type:     LocalScript
  Method:   decompile
  Name:     HERO_LOADER
  Path:     game.StarterGui.Main.Frames.Notes_OLD.Body.ScrollingFrame.OLD.VIP.List.CharacterTemplate.ViewportFrame.HERO_LOADER
  Service:  StarterGui
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:11 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local script_Parent = script.Parent;
local Attribute = script:GetAttribute("ModelName");

if Attribute then
    task.defer(function() -- Line: 17
        -- upvalues: SharedUtils (copy), script_Parent (copy), Attribute (copy)
        SharedUtils.LoadItemViewport(script_Parent, Attribute);
    end);

    return;
end;

warn("ViewportLoader: No \'ModelName\' attribute set on script");