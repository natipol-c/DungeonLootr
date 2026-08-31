--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Weapon_Weld
  Path:     game.ReplicatedStorage.Globals.Modules.Weapon_Weld
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Weapon_Data = require(ReplicatedStorage.Weapons.Weapon_Data);
local RigMap = require(ReplicatedStorage.Globals.Modules.RigMap);
local u2 = {
    Right_Arm = "Right Arm",
    Left_Arm = "Left Arm",
    Right_Leg = "Right Leg",
    Left_Leg = "Left Leg",
    Head = "Head",
    Torso = "Torso"
};
local CollectionService = game:GetService("CollectionService");
local u3 = {
    Right_Arm = "Right Arm",
    Left_Arm = "Left Arm",
    Left_Leg = "Left Leg",
    Right_Leg = "Right Leg",
    Head = "Head",
    Torso = "Torso"
};

local function Delete_Previous_Weapon(p4) -- Line: 27
    -- upvalues: CollectionService (copy), u3 (copy), RigMap (copy)
    for _, v in CollectionService:GetTagged("Weapon_Prefab") do
        if v:IsDescendantOf(p4) then
            v:Destroy();
        end;
    end;

    for i, v in u3 do
        local v5 = i;

        for _, v2 in RigMap.GetLimbParts(p4, v) do
            local v6 = v2:FindFirstChild(v5);

            if v6 then
                v6:Destroy();
            end;
        end;
    end;
end;

function v1.Weld(p7, p8, p9, p10) -- Line: 48
    -- upvalues: Delete_Previous_Weapon (copy), Weapon_Data (copy), u2 (copy), RigMap (copy)
    if p9:GetAttribute("Weapon_Equipped") then
        Delete_Previous_Weapon(p8);
    end;

    local HumanoidRootPart = p8:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        warn("Weapon_Weld: No Torso found on character");

        return nil;
    end;

    local v11 = Weapon_Data[p10];
    local v12 = p7:Clone();
    v12.Parent = HumanoidRootPart;
    local Weld = Instance.new("Weld");
    Weld.Name = "Main_Weld";
    Weld.Part0 = HumanoidRootPart;
    Weld.Part1 = v12;
    Weld.Parent = v12;
    v12.CFrame = HumanoidRootPart.CFrame;

    if v11 and v11.WeldOverrides then
        for i, v in v11.WeldOverrides do
            local v13 = v12:FindFirstChild(i, true);
            local v14 = p8:FindFirstChild(v.Parent);
            local v15 = p8:FindFirstChild(v.WeldTo);

            if v13 and (v14 and v15) then
                v13.Parent = v14;
                local Weld2 = Instance.new("Weld");
                Weld2.Name = i .. "_Weld";
                Weld2.Part0 = v15;
                Weld2.Part1 = v13;
                Weld2.Parent = v13;
                v13.CFrame = v15.CFrame;
            else
                warn("WeldOverride failed for: " .. i);
            end;
        end;
    end;

    if not (v11 and v11.SkipDefaultWelds) then
        for i, v in u2 do
            local v16 = v12:FindFirstChild(i);
            local WeldTarget, v17 = RigMap.GetWeldTarget(p8, v);

            if v16 and WeldTarget then
                local Weld2 = Instance.new("Weld");
                Weld2.Name = i .. "_Weld";
                Weld2.Part0 = WeldTarget;
                Weld2.Part1 = v16;

                if v17 then
                    Weld2.C0 = v17.CFrame;
                    v16.CFrame = WeldTarget.CFrame * v17.CFrame;
                else
                    v16.CFrame = WeldTarget.CFrame;
                end;

                Weld2.Parent = v12;
            end;
        end;
    end;

    if v11 and v11.Motor6D_Overrides then
        for i, v in v11.Motor6D_Overrides do
            local v18 = v12:FindFirstChild(i, true);

            if v18 and v18:IsA("Motor6D") then
                local MotorPart = RigMap.GetMotorPart(p8, v.Part0);

                if MotorPart then
                    v18.Part0 = MotorPart;

                    if v.C1 then
                        v18.C1 = v.C1;
                    end;

                    if v.C0 then
                        v18.C0 = v.C0;
                    end;
                else
                    warn("Motor6D Override: couldn\'t find " .. v.Part0);
                end;
            else
                warn("Motor6D Override: couldn\'t find motor " .. i);
            end;
        end;
    end;

    local Empty = v12:FindFirstChild("Empty");

    if Empty then
        Empty:Destroy();
    end;

    return v12;
end;

return v1;