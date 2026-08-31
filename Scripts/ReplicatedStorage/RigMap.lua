--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RigMap
  Path:     game.ReplicatedStorage.Globals.Modules.RigMap
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {
    ["Right Arm"] = {
        Part = "RightUpperArm",
        Attachment = "RightElbowRigAttachment"
    },
    ["Left Arm"] = {
        Part = "LeftUpperArm",
        Attachment = "LeftElbowRigAttachment"
    },
    ["Right Leg"] = {
        Part = "RightUpperLeg",
        Attachment = "RightKneeRigAttachment"
    },
    ["Left Leg"] = {
        Part = "LeftUpperLeg",
        Attachment = "LeftKneeRigAttachment"
    },
    Torso = {
        Part = "UpperTorso"
    },
    Head = {
        Part = "Head"
    },
    HumanoidRootPart = {
        Part = "HumanoidRootPart"
    },
    RightHand = {
        Part = "RightHand"
    },
    LeftHand = {
        Part = "LeftHand"
    }
};
local u3 = {
    ["Right Arm"] = "RightHand",
    ["Left Arm"] = "LeftHand",
    ["Right Leg"] = "RightFoot",
    ["Left Leg"] = "LeftFoot",
    Torso = "UpperTorso",
    Head = "Head",
    HumanoidRootPart = "HumanoidRootPart",
    RightHand = "RightHand",
    LeftHand = "LeftHand"
};
local u4 = {
    ["Right Arm"] = { "RightUpperArm", "RightLowerArm", "RightHand" },
    ["Left Arm"] = { "LeftUpperArm", "LeftLowerArm", "LeftHand" },
    ["Right Leg"] = { "RightUpperLeg", "RightLowerLeg", "RightFoot" },
    ["Left Leg"] = { "LeftUpperLeg", "LeftLowerLeg", "LeftFoot" },
    Torso = { "UpperTorso", "LowerTorso" },
    Head = { "Head" },
    HumanoidRootPart = { "HumanoidRootPart" },
    RightHand = { "RightHand" },
    LeftHand = { "LeftHand" }
};

function u1.IsR15(p5: userdata) -- Line: 62
    local v6 = p5:FindFirstChildOfClass("Humanoid");

    if v6 then
        return v6.RigType == Enum.HumanoidRigType.R15;
    end;

    return p5:FindFirstChild("UpperTorso") ~= nil;
end;

function u1.GetWeldTarget(p7: userdata, p8: string) -- Line: 73
    -- upvalues: u1 (copy), u2 (copy)
    if not u1.IsR15(p7) then
        return p7:FindFirstChild(p8), nil;
    end;

    local v9 = u2[p8];

    if not v9 then
        return p7:FindFirstChild(p8), nil;
    end;

    local v10 = p7:FindFirstChild(v9.Part);

    if not v10 then
        return nil, nil;
    end;

    local v11;

    if v9.Attachment then
        v11 = v10:FindFirstChild(v9.Attachment) or nil;
    else
        v11 = nil;
    end;

    return v10, v11;
end;

function u1.GetMotorPart(p12: userdata, p13: string) -- Line: 88
    -- upvalues: u1 (copy), u3 (copy)
    local v14 = u1.IsR15(p12) and u3[p13];

    if v14 then
        return p12:FindFirstChild(v14);
    end;

    return p12:FindFirstChild(p13);
end;

function u1.GetLimbParts(p15: userdata, p16: string) -- Line: 100
    -- upvalues: u1 (copy), u4 (copy)
    local v17 = {};
    local v18 = u1.IsR15(p15) and u4[p16];

    if v18 then
        for _, v in v18 do
            local v19 = p15:FindFirstChild(v);

            if v19 and v19:IsA("BasePart") then
                table.insert(v17, v19);
            end;
        end;

        return v17;
    end;

    local v20 = p15:FindFirstChild(p16);

    if v20 and v20:IsA("BasePart") then
        table.insert(v17, v20);
    end;

    return v17;
end;

return u1;