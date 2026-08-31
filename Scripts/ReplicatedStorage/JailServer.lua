--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     JailServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.JailServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Store = require(script.Parent.Parent).Registry:GetStore("JailedPlayers");
local Store2 = require(script.Parent.Parent).Registry:GetStore("JailConnections");

local function teleportToJail(p1: userdata, p2: userdata) -- Line: 15
    -- upvalues: ReplicatedStorage (copy)
    local Character = p1.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v3 = Character:FindFirstChild("Humanoid") and Character.Humanoid.HipHeight or 2;
    HumanoidRootPart.CFrame = CFrame.new(p2.PrimaryPart.Position + Vector3.new(0, v3 + 1, 0));
    local v4 = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("SetJail");

    if v4 then
        v4:FireClient(p1, p2);
    end;
end;

local function getDistanceFromJail(p5: userdata, p6: userdata) -- Line: 35
    local Character = p5.Character;

    if not Character then
        return nil;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        return (HumanoidRootPart.Position - p6.PrimaryPart.Position).Magnitude;
    end;

    return nil;
end;

return function(p7: any, u8: userdata) -- Line: 48
    -- upvalues: Store (copy), ReplicatedStorage (copy), teleportToJail (copy), RunService (copy), Players (copy), Store2 (copy)
    local Character = u8.Character;

    if not Character then
        return string.format("Failed to jail %s: No character found", u8.Name);
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return string.format("Failed to jail %s: No HumanoidRootPart found", u8.Name);
    end;

    if Store[u8.UserId] then
        return string.format("%s is already jailed", u8.Name);
    end;

    local Jail = ReplicatedStorage:FindFirstChild("Jail");

    if not Jail then
        return "Failed to jail: Jail model not found in ReplicatedStorage";
    end;

    local v9 = Jail:Clone();
    v9.Name = "Jail_" .. u8.UserId;
    local Position = HumanoidRootPart.Position;
    local v10 = Character:FindFirstChild("Humanoid") and Character.Humanoid.HipHeight or 2;
    local v11 = Position - Vector3.new(0, v10 + 0.5, 0);
    v9:SetPrimaryPartCFrame(CFrame.new(v11));
    v9.Parent = workspace;
    Store[u8.UserId] = v9;
    teleportToJail(u8, v9);
    local v13 = u8.CharacterAdded:Connect(function(p12) -- Line: 89
        -- upvalues: Store (ref), u8 (copy), teleportToJail (ref)
        if p12:WaitForChild("HumanoidRootPart", 5) and Store[u8.UserId] then
            task.wait(0.1);
            teleportToJail(u8, Store[u8.UserId]);
        end;
    end);
    local u14 = 0;
    local v18 = RunService.Heartbeat:Connect(function(p15) -- Line: 100
        -- upvalues: u14 (ref), Store (ref), u8 (copy), teleportToJail (ref)
        u14 = u14 + p15;

        if u14 < 0.5 then
            return;
        end;

        u14 = 0;
        local v16 = Store[u8.UserId];

        if not v16 then
            return;
        end;

        local Character2 = u8.Character;
        local v17;

        if Character2 then
            local HumanoidRootPart2 = Character2:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart2 then
                v17 = (HumanoidRootPart2.Position - v16.PrimaryPart.Position).Magnitude;
            else
                v17 = nil;
            end;
        else
            v17 = nil;
        end;

        if v17 and v17 > 10 then
            teleportToJail(u8, v16);
        end;
    end);
    local v20 = Players.PlayerRemoving:Connect(function(p19) -- Line: 117
        -- upvalues: u8 (copy), Store (ref), Store2 (ref)
        if p19.UserId == u8.UserId then
            if Store[u8.UserId] then
                Store[u8.UserId]:Destroy();
                Store[u8.UserId] = nil;
            end;

            if Store2[u8.UserId] then
                for _, v in pairs(Store2[u8.UserId]) do
                    v:Disconnect();
                end;

                Store2[u8.UserId] = nil;
            end;
        end;
    end);
    Store2[u8.UserId] = {
        characterAdded = v13,
        playerRemoving = v20,
        distanceCheck = v18
    };

    return string.format("Jailed %s", u8.Name);
end;