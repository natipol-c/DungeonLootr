--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ToolClientComp
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.ToolClientComp
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ToolClient = require(ReplicatedStorage.ClientTools.ToolClient);
local u1 = {};

for _, child in ReplicatedStorage.Assets.Tools:GetChildren() do
    child:SetAttribute("ToolId", child.Name);
end;

for _, child in ipairs(ReplicatedStorage.ClientTools:GetChildren()) do
    if child:IsA("ModuleScript") and child.Name ~= "ToolClass" then
        u1[child.Name] = require(child);
    end;
end;

local function _init(p2) -- Line: 22
    -- upvalues: ReplicatedStorage (copy), u1 (copy), ToolClient (copy)
    if p2:IsDescendantOf(ReplicatedStorage) then
        return;
    end;

    local v3 = u1[(p2:GetAttribute("CompId") or p2:GetAttribute("ToolId")) .. "Client"];

    if v3 then
        v3.new(p2);

        return;
    end;

    ToolClient.new(p2);
end;

return function() -- Line: 35
    -- upvalues: CollectionService (copy), _init (copy)
    CollectionService:GetInstanceAddedSignal("Tool"):Connect(function(p4) -- Line: 36
        -- upvalues: _init (ref)
        _init(p4);
    end);

    for _, v in ipairs(CollectionService:GetTagged("Tool")) do
        _init(v);
    end;
end;