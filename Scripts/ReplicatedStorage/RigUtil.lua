--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RigUtil
  Path:     game.ReplicatedStorage.Modules.RigUtil
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local u5 = {
    GetAnimator = function(p1: userdata) -- Line: 43, Name: GetAnimator
        return p1:FindFirstChildWhichIsA("Animator", true);
    end,

    EnsureAnimator = function(p2: userdata) -- Line: 52, Name: EnsureAnimator
        local v3 = p2:FindFirstChildWhichIsA("Humanoid") or p2:FindFirstChildWhichIsA("AnimationController");

        if not v3 then
            v3 = Instance.new("AnimationController");
            v3.Parent = p2;
        end;

        local v4 = v3:FindFirstChildOfClass("Animator");

        if not v4 then
            v4 = Instance.new("Animator");
            v4.Parent = v3;
        end;

        return v4;
    end,

    HUMANOID_ONLY_ARTIFACTS = { "BodyColors", "Shirt", "Pants", "AnimSaves", "AbilityDescription" }
};

function u5.EnsureAnimationController(p6: userdata) -- Line: 90
    -- upvalues: u5 (copy)
    local v7 = {};

    for _, v in u5.HUMANOID_ONLY_ARTIFACTS do
        v7[v] = true;
    end;

    for _, descendant in p6:GetDescendants() do
        if v7[descendant.ClassName] or v7[descendant.Name] then
            descendant:Destroy();
        end;
    end;

    local v8 = p6:FindFirstChildOfClass("Humanoid");

    if v8 then
        v8:Destroy();
    end;

    local v9 = p6:FindFirstChildOfClass("AnimationController");

    if not v9 then
        v9 = Instance.new("AnimationController");
        v9.Parent = p6;
    end;

    local v10 = v9:FindFirstChildOfClass("Animator");

    if not v10 then
        v10 = Instance.new("Animator");
        v10.Parent = v9;
    end;

    return v10;
end;

function u5.HasHumanoid(p11: userdata) -- Line: 123
    return p11:FindFirstChildOfClass("Humanoid") ~= nil;
end;

function u5.IsHittableTarget(p12: userdata) -- Line: 131
    return p12:FindFirstChildOfClass("Humanoid") and true or (p12:HasTag("Enemy") or p12:HasTag("NPC"));
end;

function u5.IsAlive(p13: userdata) -- Line: 143
    if not (p13 and p13.Parent) then
        return false;
    end;

    if p13:GetAttribute("Dead") then
        return false;
    end;

    local v14 = p13:FindFirstChildOfClass("Humanoid");

    return not v14 and true or v14.Health > 0;
end;

return u5;