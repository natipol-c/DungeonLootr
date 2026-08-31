--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Util
  Path:     game.ReplicatedStorage.Packages._Index.sleitnick_comm@1.0.1.comm.Util
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Option = require(script.Parent.Parent.Option);
local u1 = {
    IsServer = RunService:IsServer(),
    WaitForChildTimeout = 60,
    DefaultCommFolderName = "__comm__",
    None = newproxy()
};

function u1.GetCommSubFolder(p2: userdata, p3: string) -- Line: 12
    -- upvalues: u1 (copy), Option (copy)
    local v4;

    if u1.IsServer then
        v4 = p2:FindFirstChild(p3);

        if not v4 then
            v4 = Instance.new("Folder");
            v4.Name = p3;
            v4.Parent = p2;
        end;
    else
        v4 = p2:WaitForChild(p3, u1.WaitForChildTimeout);
    end;

    return Option.Wrap(v4);
end;

return u1;