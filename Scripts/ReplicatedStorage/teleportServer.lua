--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     teleportServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.Admin.teleportServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    local v4 = nil;

    if typeof(p3) == "Instance" then
        if not (p3.Character and p3.Character:FindFirstChild("HumanoidRootPart")) then
            return "Target player has no character.";
        end;

        v4 = p3.Character.HumanoidRootPart.CFrame;
    elseif typeof(p3) == "Vector3" then
        v4 = CFrame.new(p3);
    end;

    for _, v in ipairs(p2) do
        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            v.Character.HumanoidRootPart.CFrame = v4;
        end;
    end;

    return ("Teleported %d players."):format(#p2);
end;