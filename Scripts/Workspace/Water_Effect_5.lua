--[[
  Type:     LocalScript
  Method:   cached
  Name:     Water_Effect
  Path:     game.Workspace.PlayerModels.Kennn_2007.Water_Effect
  Service:  Workspace
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Sun Aug 30 01:48:32 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local Water_Effect = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Effects"):WaitForChild("Water_Effect");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local u2 = nil;
local u3 = 0;
local u4 = {};

local function attachEffect() -- Line: 41
    -- upvalues: u2 (ref), Water_Effect (copy), HumanoidRootPart (copy), u1 (copy)
    if u2 then
        return;
    end;

    local v5 = Water_Effect:Clone();
    v5.Anchored = false;
    v5.CanCollide = false;
    v5.CanQuery = false;
    v5.CanTouch = false;
    v5.Massless = true;
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1, 0);
    v5.Parent = u1;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = v5;
    WeldConstraint.Parent = v5;
    u2 = v5;
end;

local function removeEffect() -- Line: 64
    -- upvalues: u2 (ref)
    if u2 then
        u2:Destroy();
        u2 = nil;
    end;
end;

local function connectWaterPart(u6: userdata) -- Line: 73
    -- upvalues: u4 (copy), HumanoidRootPart (copy), u3 (ref), attachEffect (copy), u2 (ref)
    if u4[u6] then
        return;
    end;

    local u7 = {};
    u4[u6] = u7;
    u7[1] = u6.Touched:Connect(function(p8) -- Line: 79
        -- upvalues: HumanoidRootPart (ref), u3 (ref), attachEffect (ref)
        if p8 ~= HumanoidRootPart then
            return;
        end;

        u3 = u3 + 1;

        if u3 == 1 then
            attachEffect();
        end;
    end);
    u7[2] = u6.TouchEnded:Connect(function(p9) -- Line: 87
        -- upvalues: HumanoidRootPart (ref), u3 (ref), u2 (ref)
        if p9 ~= HumanoidRootPart then
            return;
        end;

        u3 = math.max(u3 - 1, 0);

        if u3 == 0 and u2 then
            u2:Destroy();
            u2 = nil;
        end;
    end);
    u7[3] = u6.Destroying:Once(function() -- Line: 95
        -- upvalues: u4 (ref), u6 (copy), u7 (copy), u3 (ref), u2 (ref)
        if u4[u6] then
            for _, v in u7 do
                v:Disconnect();
            end;

            u4[u6] = nil;
        end;

        u3 = math.max(u3 - 1, 0);

        if u3 == 0 and u2 then
            u2:Destroy();
            u2 = nil;
        end;
    end);
end;

local function disconnectWaterPart(p10: userdata) -- Line: 109
    -- upvalues: u4 (copy)
    local v11 = u4[p10];

    if not v11 then
        return;
    end;

    for _, v in v11 do
        v:Disconnect();
    end;

    u4[p10] = nil;
end;

for _, v in CollectionService:GetTagged("Water_Object") do
    if v:IsA("BasePart") and v:IsDescendantOf(workspace) then
        connectWaterPart(v);
    end;
end;

CollectionService:GetInstanceAddedSignal("Water_Object"):Connect(function(p12) -- Line: 126
    -- upvalues: connectWaterPart (copy)
    if p12:IsA("BasePart") and p12:IsDescendantOf(workspace) then
        connectWaterPart(p12);
    end;
end);
CollectionService:GetInstanceRemovedSignal("Water_Object"):Connect(function(p13) -- Line: 133
    -- upvalues: u4 (copy)
    local v14 = u4[p13];

    if not v14 then
        return;
    end;

    for _, v in v14 do
        v:Disconnect();
    end;

    u4[p13] = nil;
end);