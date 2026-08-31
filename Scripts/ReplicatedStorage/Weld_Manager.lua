--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Weld_Manager
  Path:     game.ReplicatedStorage.Globals.Modules.Weld_Manager
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local RigMap = require(script.Parent.RigMap);
local v1 = {};
local u2 = {
    Right_Arm = "Right Arm",
    Left_Arm = "Left Arm",
    Right_Leg = "Right Leg",
    Left_Leg = "Left Leg",
    Head = "Head",
    Torso = "Torso",
    RightHand = "RightHand",
    LeftHand = "LeftHand"
};

local function ClearTaggedPrefabs(p3: userdata, p4: string) -- Line: 35
    -- upvalues: CollectionService (copy), u2 (copy), RigMap (copy)
    for _, v in CollectionService:GetTagged(p4) do
        if v:IsDescendantOf(p3) then
            v:Destroy();
        end;
    end;

    for i, v in u2 do
        local v5 = i;

        for _, v2 in RigMap.GetLimbParts(p3, v) do
            local v6 = v2:FindFirstChild(v5);

            if v6 then
                v6:Destroy();
            end;
        end;
    end;
end;

function v1.Weld(p7: any, p8: userdata, p9: string, p10: any) -- Line: 70
    -- upvalues: ClearTaggedPrefabs (copy), RigMap (copy), u2 (copy)
    local v11 = p10 or {};
    ClearTaggedPrefabs(p8, p9);
    local HumanoidRootPart = p8:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        warn("[Weld_Manager] No HumanoidRootPart found on character");

        return nil;
    end;

    local v12 = p7:Clone();
    v12:AddTag(p9);
    v12.Parent = HumanoidRootPart;
    local Weld = Instance.new("Weld");
    Weld.Name = "Main_Weld";
    Weld.Part0 = HumanoidRootPart;
    Weld.Part1 = v12;
    Weld.Parent = v12;
    v12.CFrame = HumanoidRootPart.CFrame;

    if v11.WeldOverrides then
        for i, v in v11.WeldOverrides do
            local v13 = v12:FindFirstChild(i, true);
            local WeldTarget = RigMap.GetWeldTarget(p8, v.Parent);
            local WeldTarget2, v14 = RigMap.GetWeldTarget(p8, v.WeldTo);

            if v13 and (WeldTarget and WeldTarget2) then
                v13.Parent = WeldTarget;
                local Weld2 = Instance.new("Weld");
                Weld2.Name = i .. "_Weld";
                Weld2.Part0 = WeldTarget2;
                Weld2.Part1 = v13;

                if v14 then
                    Weld2.C0 = v14.CFrame;
                    v13.CFrame = WeldTarget2.CFrame * v14.CFrame;
                else
                    v13.CFrame = WeldTarget2.CFrame;
                end;

                Weld2.Parent = v13;
            else
                warn("[Weld_Manager] WeldOverride failed for:", i);
            end;
        end;
    end;

    if not v11.SkipDefaultWelds then
        for i, v in u2 do
            local v15 = v12:FindFirstChild(i);
            local WeldTarget, v16 = RigMap.GetWeldTarget(p8, v);

            if v15 and WeldTarget then
                local Weld2 = Instance.new("Weld");
                Weld2.Name = i .. "_Weld";
                Weld2.Part0 = WeldTarget;
                Weld2.Part1 = v15;

                if v16 then
                    Weld2.C0 = v16.CFrame;
                    v15.CFrame = WeldTarget.CFrame * v16.CFrame;
                else
                    v15.CFrame = WeldTarget.CFrame;
                end;

                Weld2.Parent = v12;
            end;
        end;
    end;

    if v11.Motor6D_Overrides then
        for i, v in v11.Motor6D_Overrides do
            local v17 = v12:FindFirstChild(i, true);

            if v17 and v17:IsA("Motor6D") then
                local MotorPart = RigMap.GetMotorPart(p8, v.Part0);

                if MotorPart then
                    v17.Part0 = MotorPart;

                    if v.C0 then
                        v17.C0 = v.C0;
                    end;

                    if v.C1 then
                        v17.C1 = v.C1;
                    end;
                else
                    warn("[Weld_Manager] Motor6D override: couldn\'t find", v.Part0);
                end;
            else
                warn("[Weld_Manager] Motor6D override: couldn\'t find motor", i);
            end;
        end;
    end;

    local Empty = v12:FindFirstChild("Empty");

    if Empty then
        Empty:Destroy();
    end;

    return v12;
end;

function v1.Clear(p18: userdata, p19: string) -- Line: 170
    -- upvalues: ClearTaggedPrefabs (copy)
    ClearTaggedPrefabs(p18, p19);
end;

return v1;