--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Reference
  Path:     game.StarterPlayer.StarterPlayerScripts.Satchel.Satchel.Packages._Index.legitatx_topbarplus@3.0.5.topbarplus.Reference
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    objectName = "TopbarPlusReference"
};

function u1.addToReplicatedStorage() -- Line: 10
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    if ReplicatedStorage:FindFirstChild(u1.objectName) then
        return false;
    end;

    local ObjectValue = Instance.new("ObjectValue");
    ObjectValue.Name = u1.objectName;
    ObjectValue.Value = script.Parent;
    ObjectValue.Parent = ReplicatedStorage;

    return ObjectValue;
end;

function u1.getObject() -- Line: 22
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    return ReplicatedStorage:FindFirstChild(u1.objectName) or false;
end;

return u1;