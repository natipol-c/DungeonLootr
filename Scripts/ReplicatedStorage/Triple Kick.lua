--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Triple Kick
  Path:     game.ReplicatedStorage.Classes.Divergent.Skills.Triple Kick
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:46 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 6,
    DamageMultiplier = 1.67,
    AnimationName = "Ability_2",
    EffectModule = "Triple_Kick",
    DashSpeed = 40,
    DashDuration = 0.18,
    HitboxSize = Vector3.new(22, 18, 28),
    HitboxRange = 28,
    HitSFX = "jojo punch",
    FinalHitSFX = "HardHit_2",
    HitVolume = 1,
    FlashRefreshSlot = 3,
    FlashRefreshChance = 0.35,
    FlashEffectModule = "Triple_Kick",
    MaxDuration = 2
};

function u1._EnsureAnimation(p2) -- Line: 61
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

function u1._PerformHit(p7) -- Line: 88
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
        end;
    end;
end;

function u1._DoCastDash(p9) -- Line: 109
    -- upvalues: u1 (copy), Debris (copy)
    local v10 = p9.Character and p9.Character:FindFirstChild("HumanoidRootPart");

    if not v10 then
        return;
    end;

    local Humanoid = p9.Humanoid;
    local v11;

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
        v11 = Humanoid.MoveDirection.Unit;
    else
        v11 = v10.CFrame.LookVector;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v11 * u1.DashSpeed;
    BodyVelocity.Parent = v10;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
end;

function u1._RollFlashRefresh(p12) -- Line: 132
    -- upvalues: u1 (copy)
    if not p12:IsSkillOnCooldown(u1.FlashRefreshSlot) then
        return;
    end;

    if math.random() >= u1.FlashRefreshChance then
        return;
    end;

    p12:RefreshSkillCooldown(u1.FlashRefreshSlot);
    local v13 = p12.Character and p12.Character:FindFirstChild("HumanoidRootPart");
    p12:PlayEffectModule(u1.FlashEffectModule, "Emit", v13 and v13.CFrame or nil, "HighlightEmit");
end;

function u1.CanActivate(p14) -- Line: 145
    if p14.Is_Attacking then
        return false, "Attacking";
    end;

    if p14.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p14.Is_Dodging then
        return false, "Dodging";
    end;

    if p14.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u15, p16) -- Line: 153
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v17 = u1._EnsureAnimation(u15);

    if not v17 then
        warn("[Triple Kick] Animation not found");

        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;

    for i, v in u15.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    u1._DoCastDash(u15);
    v17:Play(0, 1, 1);
    local u18 = {};

    local function disconnectAll() -- Line: 179
        -- upvalues: u18 (copy)
        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);
    end;

    local u19 = false;

    local function releaseState() -- Line: 185
        -- upvalues: u19 (ref), u15 (copy), u1 (ref)
        if u19 then
            return;
        end;

        u19 = true;
        local ClassData = u15.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u15, nil);
        end;

        u15.Is_Using_Skill = false;
        u15.Is_Attacking = false;
        u1._RollFlashRefresh(u15);
    end;

    local function emitVFX(p20) -- Line: 201
        -- upvalues: u15 (copy), u1 (ref)
        if not p20 or p20 == "" then
            return;
        end;

        local v21 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if not v21 then
            return;
        end;

        u15:PlayEffectModule(u1.EffectModule, "Emit", v21.CFrame, p20);
    end;

    u18[#u18 + 1] = v17:GetMarkerReachedSignal("VFX"):Connect(emitVFX);
    u18[#u18 + 1] = v17:GetMarkerReachedSignal("VFX_2"):Connect(emitVFX);
    local u22 = 0;
    u18[#u18 + 1] = v17:GetMarkerReachedSignal("hit"):Connect(function(p23) -- Line: 213
        -- upvalues: u22 (ref), u15 (copy), u1 (ref), SharedUtils (ref)
        u22 = u22 + 1;
        local v24 = u22 >= 3;
        local v25 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if v25 then
            SharedUtils.PlaySoundAt(v25, v24 and u1.FinalHitSFX or u1.HitSFX, u1.HitVolume);
        end;

        u15:ShakeCamera(v24 and "SkillHeavy" or "SkillLight");
        u1._PerformHit(u15);
    end);
    u18[#u18 + 1] = v17:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v17.Stopped:Once(function() -- Line: 231
        -- upvalues: u19 (ref), u15 (copy), u1 (ref), u18 (copy)
        if not u19 then
            u19 = true;
            local ClassData = u15.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u15, nil);
            end;

            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
            u1._RollFlashRefresh(u15);
        end;

        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);
    end);
    task.delay(u1.MaxDuration, function() -- Line: 236
        -- upvalues: u19 (ref), u15 (copy), u1 (ref), u18 (copy)
        if not u19 then
            u19 = true;
            local ClassData = u15.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u15, nil);
            end;

            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
            u1._RollFlashRefresh(u15);
        end;

        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);
    end);
end;

return u1;