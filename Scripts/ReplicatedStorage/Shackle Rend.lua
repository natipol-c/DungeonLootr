--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Shackle Rend
  Path:     game.ReplicatedStorage.Classes.Prisma.Skills.Shackle Rend
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Chains = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Effects"):WaitForChild("Chains");
local u1 = {
    Cooldown = 10,
    DamageMultiplier = 3.75,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(20, 20, 35),
    HitboxRange = 17,
    StunDuration = 3,
    MaxDuration = 2
};

function u1._EnsureAnimation(p2) -- Line: 47
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p2.Animations[AnimationName] then
        return p2.Animations[AnimationName];
    end;

    local v3 = ReplicatedStorage.Classes:FindFirstChild(p2.ClassName);

    if not v3 then
        return nil;
    end;

    local Skill_Animations = v3:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v4 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v4 then
        return nil;
    end;

    local v5 = p2.Humanoid and p2.Humanoid:FindFirstChildOfClass("Animator");

    if not v5 then
        return nil;
    end;

    local v6 = v5:LoadAnimation(v4);
    v6.Priority = Enum.AnimationPriority.Action3;
    v6:Play(0, 0, 0);
    v6:Stop(0);
    p2.Animations[AnimationName] = v6;

    return v6;
end;

function u1._GetPoolFolder() -- Line: 75
    -- upvalues: Chains (copy)
    local Prisma_Chains_Pool = workspace:FindFirstChild("Prisma_Chains_Pool");

    if not Prisma_Chains_Pool then
        Prisma_Chains_Pool = Instance.new("Folder");
        Prisma_Chains_Pool.Name = "Prisma_Chains_Pool";
        Prisma_Chains_Pool.Parent = workspace;

        for i = 1, 8 do
            local v7 = Chains:Clone();
            v7.Name = "Chains_" .. i;
            v7.Anchored = true;
            v7.CFrame = CFrame.new(0, -500, 0);
            v7.Parent = Prisma_Chains_Pool;
            local _ = i;
        end;
    end;

    return Prisma_Chains_Pool;
end;

function u1._AcquireFX() -- Line: 93
    -- upvalues: u1 (copy)
    for _, child in u1._GetPoolFolder():GetChildren() do
        if not child:GetAttribute("InUse") then
            child:SetAttribute("InUse", true);

            return child;
        end;
    end;

    return nil;
end;

function u1._ReleaseFX(p8) -- Line: 104
    local ChainAnchorWeld = p8:FindFirstChild("ChainAnchorWeld");

    if ChainAnchorWeld then
        ChainAnchorWeld:Destroy();
    end;

    p8.Anchored = true;
    p8.CFrame = CFrame.new(0, -500, 0);
    p8:SetAttribute("InUse", false);
end;

function u1._ApplyChainStun(p9, u10) -- Line: 120
    -- upvalues: u1 (copy)
    local HumanoidRootPart = u10:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    u10:SetAttribute("Is_Stunned", true);
    local Anchored = HumanoidRootPart.Anchored;
    HumanoidRootPart.Anchored = true;
    local u11 = u1._AcquireFX();

    if u11 then
        u11.Anchored = false;
        u11.CFrame = HumanoidRootPart.CFrame;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Name = "ChainAnchorWeld";
        WeldConstraint.Part0 = HumanoidRootPart;
        WeldConstraint.Part1 = u11;
        WeldConstraint.Parent = u11;
    end;

    task.delay(u1.StunDuration, function() -- Line: 145
        -- upvalues: u10 (copy), HumanoidRootPart (copy), Anchored (copy), u11 (copy), u1 (ref)
        if u10 and u10.Parent then
            u10:SetAttribute("Is_Stunned", false);
        end;

        if HumanoidRootPart and HumanoidRootPart.Parent then
            HumanoidRootPart.Anchored = Anchored;
        end;

        if u11 then
            u1._ReleaseFX(u11);
        end;
    end);
end;

function u1.CanActivate(p12) -- Line: 162
    if p12.Is_Attacking then
        return false, "Attacking";
    end;

    if p12.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p12.Is_Dodging then
        return false, "Dodging";
    end;

    if p12.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u13, p14) -- Line: 170
    -- upvalues: u1 (copy)
    local v15 = u1._EnsureAnimation(u13);

    if not v15 then
        warn("[Shackle Rend] Animation not found");

        return;
    end;

    local Character = u13.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;

    for i, v in u13.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v15:Play(0, 1, 1);
    local u18 = v15:GetMarkerReachedSignal("hit"):Connect(function(p16) -- Line: 197
        -- upvalues: u13 (copy), u1 (ref)
        u13:PlayFX("Ability_2");

        if p16 == "" or not p16 then
            p16 = nil;
        end;

        u13:PlayTurnFX(p16);
        u13:ShakeCamera("SkillLight");
        u13:PlayCombatSound(u13.ClassData.HitSoundFolder or "Hit", nil, u13.ClassData.HitVolume or 1);
        local HitboxSize = u13.ClassData.HitboxSize;
        local Range = u13.ClassData.Range;
        u13.ClassData.HitboxSize = u1.HitboxSize;
        u13.ClassData.Range = u1.HitboxRange;
        local v17 = u13:Hitbox();
        u13.ClassData.HitboxSize = HitboxSize;
        u13.ClassData.Range = Range;

        for _, v in v17 do
            if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
                u13:ApplyDamage(v, (u13:ResolveSkillDamage(u1.DamageMultiplier, v)));

                if not v:GetAttribute("IsBoss") and u13:CanApplyStatusTo(v) then
                    u1._ApplyChainStun(u13, v);
                end;
            end;
        end;
    end);
    local u19 = nil;
    u19 = v15:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 242
        -- upvalues: u18 (ref), u13 (copy), u19 (ref)
        if u18 then
            u18:Disconnect();
        end;

        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;

        if u19 then
            u19:Disconnect();
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 252
        -- upvalues: u13 (copy), u18 (ref)
        if u13.Is_Using_Skill then
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        if u18 then
            u18:Disconnect();
        end;
    end);
end;

return u1;