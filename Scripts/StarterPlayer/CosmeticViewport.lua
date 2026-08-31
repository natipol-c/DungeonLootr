--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CosmeticViewport
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.CosmeticViewport
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticData = require(ReplicatedStorage.GameInfo.CosmeticData);
local v1 = {};

local function GetSetFolder(p2: string) -- Line: 23
    -- upvalues: ReplicatedStorage (copy)
    local Assets = ReplicatedStorage:FindFirstChild("Assets");

    if Assets then
        Assets = Assets:FindFirstChild("Cosmetics");
    end;

    if Assets then
        return Assets:FindFirstChild(p2);
    end;

    return nil;
end;

function v1.GetSetSlots(p3: string) -- Line: 33
    -- upvalues: ReplicatedStorage (copy), CosmeticData (copy)
    local Assets = ReplicatedStorage:FindFirstChild("Assets");

    if Assets then
        Assets = Assets:FindFirstChild("Cosmetics");
    end;

    local v4;

    if Assets then
        v4 = Assets:FindFirstChild(p3);
    else
        v4 = nil;
    end;

    if not v4 then
        return {};
    end;

    local v5 = {};

    for _, child in v4:GetChildren() do
        if child:HasTag("Cosmetic") then
            local Attribute = child:GetAttribute("Location");

            if Attribute then
                local v6 = CosmeticData.LOCATION_TO_SLOT[Attribute];

                if v6 then
                    v5[v6] = true;
                end;
            end;
        end;
    end;

    local v7 = {};

    for _, v in CosmeticData.Slots do
        if v5[v] then
            table.insert(v7, v);
        end;
    end;

    return v7;
end;

function v1.GetPieceName(p8: string, p9: string) -- Line: 55
    -- upvalues: ReplicatedStorage (copy), CosmeticData (copy)
    local Assets = ReplicatedStorage:FindFirstChild("Assets");

    if Assets then
        Assets = Assets:FindFirstChild("Cosmetics");
    end;

    local v10;

    if Assets then
        v10 = Assets:FindFirstChild(p8);
    else
        v10 = nil;
    end;

    if not v10 then
        return nil;
    end;

    local v11 = CosmeticData.SLOT_TO_LOCATIONS[p9];

    if not v11 then
        return nil;
    end;

    local v12 = {};

    for _, v in v11 do
        v12[v] = true;
    end;

    for _, child in v10:GetChildren() do
        if child:HasTag("Cosmetic") then
            local Attribute = child:GetAttribute("Location");

            if Attribute and v12[Attribute] then
                return child.Name;
            end;
        end;
    end;

    return nil;
end;

function v1.Load(p13: userdata, p14: string, p15: string) -- Line: 80
    -- upvalues: ReplicatedStorage (copy), CosmeticData (copy)
    p13:ClearAllChildren();
    local Assets = ReplicatedStorage:FindFirstChild("Assets");

    if Assets then
        Assets = Assets:FindFirstChild("Cosmetics");
    end;

    if not Assets then
        return false;
    end;

    local v16 = Assets:FindFirstChild(p14);

    if not v16 then
        return false;
    end;

    local v17 = CosmeticData.SLOT_TO_LOCATIONS[p15];

    if not v17 then
        return false;
    end;

    local v18 = {};

    for _, v in v17 do
        v18[v] = true;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "CosmeticWorld";
    WorldModel.Parent = p13;
    local v19 = false;

    for _, child in v16:GetChildren() do
        if child:HasTag("Cosmetic") then
            local Attribute = child:GetAttribute("Location");

            if Attribute and v18[Attribute] then
                child:Clone().Parent = WorldModel;
                v19 = true;
            end;
        end;
    end;

    if not v19 then
        return false;
    end;

    local v20 = nil;
    local v21 = nil;

    for _, descendant in WorldModel:GetDescendants() do
        if descendant:IsA("BasePart") then
            local Position = descendant.Position;
            local v22 = descendant.Size / 2;
            local v23 = Position - v22;
            local v24 = Position + v22;

            if v20 then
                local math_min_ret = math.min(v20.X, v23.X);
                local math_min_ret2 = math.min(v20.Y, v23.Y);
                local math_min_ret3 = math.min(v20.Z, v23.Z);
                v20 = Vector3.new(math_min_ret, math_min_ret2, math_min_ret3);
                local math_max_ret = math.max(v21.X, v24.X);
                local math_max_ret2 = math.max(v21.Y, v24.Y);
                local math_max_ret3 = math.max(v21.Z, v24.Z);
                v21 = Vector3.new(math_max_ret, math_max_ret2, math_max_ret3);
            else
                v21 = v24;
                v20 = v23;
            end;
        end;
    end;

    if not v20 then
        return false;
    end;

    local v25 = (v20 + v21) / 2;
    local v26 = v21 - v20;
    local v27 = math.max(v26.X, v26.Y, v26.Z) * 1.5 + 0.5;
    local Camera = Instance.new("Camera");
    Camera.CFrame = CFrame.new(v25 + Vector3.new(0, 0, v27), v25);
    Camera.Parent = p13;
    p13.CurrentCamera = Camera;

    return true;
end;

return v1;