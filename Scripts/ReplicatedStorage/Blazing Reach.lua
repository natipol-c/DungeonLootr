--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Blazing Reach
  Path:     game.ReplicatedStorage.Classes.Flame Bastion.Skills.Blazing Reach
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = {
    Cooldown = 10,
    DamageMultiplier = 0.7,
    HitCount = 6,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    LoopFXName = "Ability_2",
    AoEHitboxSize = Vector3.new(25, 20, 28),
    HitboxRange = 25,
    DashSpeed = 90,
    DashDuration = 0.3,
    MaxDuration = 2
};

function u1._EnsureAnimation(p2) -- Line: 46
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

function u1._PerformHit(p7) -- Line: 72
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.AoEHitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    local v9 = 0;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v9 = v9 + 1;
        end;
    end;

    return v9;
end;

function u1.CanActivate(p10) -- Line: 100
    if p10.Is_Attacking then
        return false, "Attacking";
    end;

    if p10.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p10.Is_Dodging then
        return false, "Dodging";
    end;

    if p10.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u11, p12) -- Line: 108
    -- upvalues: u1 (copy), Debris (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Blazing Reach] Animation not found");

        return;
    end;

    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;

    for i, v in u11.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v13:Play(0, 1, 1);
    local u14 = false;

    local function setLoopFX(p15) -- Line: 131
        -- upvalues: u14 (ref), u11 (copy), u1 (ref)
        if u14 == p15 then
            return;
        end;

        u14 = p15;
        u11:SetLoopFX(u1.LoopFXName, p15);
    end;

    local u16 = nil;
    local u18 = v13:GetMarkerReachedSignal("dash"):Connect(function() -- Line: 139
        -- upvalues: u11 (copy), u16 (ref), u1 (ref), Debris (ref)
        local v17 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v17 then
            return;
        end;

        if u16 then
            u16:Destroy();
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v17.CFrame.LookVector * u1.DashSpeed;
        BodyVelocity.Parent = v17;
        u16 = BodyVelocity;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
    end);
    local u19 = v13:GetMarkerReachedSignal("end"):Connect(function() -- Line: 154
        -- upvalues: u14 (ref), u11 (copy), u1 (ref), u16 (ref)
        if u14 ~= false then
            u14 = false;
            u11:SetLoopFX(u1.LoopFXName, false);
        end;

        if u16 then
            u16:Destroy();
            u16 = nil;
        end;
    end);
    local u20 = 0;
    local u22 = v13:GetMarkerReachedSignal("hit"):Connect(function(p21) -- Line: 166
        -- upvalues: u20 (ref), u14 (ref), u11 (copy), u1 (ref)
        u20 = u20 + 1;

        if u20 == 1 and u14 ~= true then
            u14 = true;
            u11:SetLoopFX(u1.LoopFXName, true);
        end;

        u11:PlayCombatSound(u1.Skill_SFX or (u11.ClassData.SwingSoundFolder or "Flame_Swing"), nil, u11.ClassData.SwingVolume or 0.5);

        if p21 and p21 ~= "" then
            u11:PlayTurnFX(p21);
        end;

        u11:ShakeCamera("SkillLight");
        u1._PerformHit(u11);

        if u20 >= u1.HitCount then
            if u14 == false then
                return;
            end;

            u14 = false;
            u11:SetLoopFX(u1.LoopFXName, false);
        end;
    end);
    local u23 = false;

    local function releaseState() -- Line: 187
        -- upvalues: u23 (ref), u11 (copy), u14 (ref), u1 (ref), u16 (ref)
        if u23 then
            return;
        end;

        u23 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;

        if u14 ~= false then
            u14 = false;
            u11:SetLoopFX(u1.LoopFXName, false);
        end;

        if u16 then
            u16:Destroy();
            u16 = nil;
        end;
    end;

    local u24 = v13:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v13.Stopped:Once(function() -- Line: 203
        -- upvalues: u23 (ref), u11 (copy), u14 (ref), u1 (ref), u16 (ref), u22 (ref), u24 (copy), u18 (copy), u19 (copy)
        if not u23 then
            u23 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;

            if u14 ~= false then
                u14 = false;
                u11:SetLoopFX(u1.LoopFXName, false);
            end;

            if u16 then
                u16:Destroy();
                u16 = nil;
            end;
        end;

        if u22 then
            u22:Disconnect();
        end;

        if u24 then
            u24:Disconnect();
        end;

        if u18 then
            u18:Disconnect();
        end;

        if u19 then
            u19:Disconnect();
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 212
        -- upvalues: u23 (ref), u11 (copy), u14 (ref), u1 (ref), u16 (ref), u22 (ref), u24 (copy), u18 (copy), u19 (copy)
        if not u23 then
            u23 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;

            if u14 ~= false then
                u14 = false;
                u11:SetLoopFX(u1.LoopFXName, false);
            end;

            if u16 then
                u16:Destroy();
                u16 = nil;
            end;
        end;

        if u22 then
            u22:Disconnect();
        end;

        if u24 then
            u24:Disconnect();
        end;

        if u18 then
            u18:Disconnect();
        end;

        if u19 then
            u19:Disconnect();
        end;
    end);
end;

return u1;