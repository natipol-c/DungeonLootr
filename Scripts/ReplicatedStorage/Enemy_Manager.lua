--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Enemy_Manager
  Path:     game.ReplicatedStorage.Enemies.Modules.Enemy_Manager
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:06 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Enemy_Data = require(ReplicatedStorage.Enemies.Modules.Enemy_Data);
u1.__index = u1;
u1.ActiveEnemies = {};

function u1.GetByModel(p2) -- Line: 9
    -- upvalues: u1 (copy)
    return u1.ActiveEnemies[p2];
end;

function u1.new(p3, p4, p5) -- Line: 13
    -- upvalues: u1 (copy), Enemy_Data (copy)
    local v6 = setmetatable({}, u1);
    v6.Name = p4;
    v6.Level = p5;
    local v7 = Enemy_Data[p4];

    if not v7 then
        warn("No enemy data for " .. p4);

        return nil;
    end;

    v6.Max_Health = v7.BaseHealth + v7.HealthPerLevel * p5;
    v6.Current_Health = v6.Max_Health;
    v6.Is_Alive = true;
    v6.Connections = {};
    v6:Spawn(p3);

    if not v6.Model then
        return nil;
    end;

    v6:SetupConnections();
    u1.ActiveEnemies[v6.Model] = v6;
    print("Registered enemy:", v6.Model, v6.Model.Name);

    return v6;
end;

function u1.Spawn(p8, p9) -- Line: 45
    -- upvalues: Enemy_Data (copy), ReplicatedStorage (copy)
    local _ = Enemy_Data[p8.Name];
    local v10 = ReplicatedStorage.Enemies:FindFirstChild(p8.Name):FindFirstChild("Prefab"):FindFirstChildOfClass("Model");

    if not v10 then
        warn("No model template for " .. p8.Name);

        return;
    end;

    local v11 = v10:Clone();
    v11:PivotTo(p9);
    v11.Parent = workspace;
    p8.Model = v11;
    p8.Humanoid = v11:FindFirstChildOfClass("Humanoid");
    p8.HRP = v11:FindFirstChild("HumanoidRootPart");
    p8.Humanoid.MaxHealth = p8.Max_Health;
    p8.Humanoid.Health = p8.Max_Health;
end;

function u1.SetupConnections(u12) -- Line: 68
    u12.Connections["Health Changed"] = u12.Humanoid.HealthChanged:Connect(function(p13) -- Line: 69
        -- upvalues: u12 (copy)
        u12.Current_Health = p13;

        if p13 <= 0 and u12.Is_Alive then
            u12.Is_Alive = false;
            u12:OnDeath();
        end;
    end);
    u12.Connections["Ancestry Changed"] = u12.Model.AncestryChanged:Connect(function(p14, p15) -- Line: 78
        -- upvalues: u12 (copy)
        if not p15 then
            u12:Destroy();
        end;
    end);
end;

function u1.OnDeath(u16) -- Line: 86
    task.delay(2, function() -- Line: 94
        -- upvalues: u16 (copy)
        u16:Destroy();
    end);
end;

function u1.Destroy(p17) -- Line: 99
    -- upvalues: u1 (copy)
    for _, v in p17.Connections do
        v:Disconnect();
    end;

    table.clear(p17.Connections);

    if p17.Model then
        u1.ActiveEnemies[p17.Model] = nil;
    end;

    if p17.Model and p17.Model.Parent then
        p17.Model:Destroy();
    end;

    p17.Model = nil;
    p17.Humanoid = nil;
    p17.HRP = nil;
    p17.Is_Alive = false;
end;

return u1;