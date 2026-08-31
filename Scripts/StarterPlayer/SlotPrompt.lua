--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SlotPrompt
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.SlotPrompt
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = nil;

function _init(p2: userdata)
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    if not u1 then
        repeat
            u1 = ReplicatedStorage.Remotes.GetBase:InvokeServer();
            print("Waiting for PlayerBase to be set...");
            task.wait(3);
        until u1;
    end;

    if p2:IsDescendantOf(u1) then
        return;
    end;

    local v3 = p2:FindFirstAncestorWhichIsA("Model");

    if v3 then
        v3 = v3:FindFirstChild("Character");
    end;

    if not (v3 and v3:GetAttribute("Unstealable")) then
        p2.ActionText = "Steal";

        return;
    end;

    p2.ActionText = "Protected";
    p2.Enabled = false;
end;

return function() -- Line: 33
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("SlotPrompt"):Connect(function(p4) -- Line: 34
        _init(p4);
    end);

    for _, v in ipairs(CollectionService:GetTagged("SlotPrompt")) do
        _init(v);
    end;
end;