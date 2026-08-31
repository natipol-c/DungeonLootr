--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Template
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Gameplay.Interface.Template
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = Players.LocalPlayer.PlayerGui;
local Janitor = require(ReplicatedStorage.Packages.Janitor);
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 20
    -- upvalues: Janitor (copy), u1 (copy)
    local v2 = {
        _Janitor = Janitor.new(),
        _Playing = {}
    };

    return setmetatable(v2, u1);
end;

function u1.Cleanup(p3) -- Line: 29
    p3._Janitor:Cleanup();
end;

return u1;