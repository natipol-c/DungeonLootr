--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Renewal Flurry
  Path:     game.ReplicatedStorage.Classes.Mori.Skills.Renewal Flurry
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:00 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 7,
    MaxCharges = 2,
    AnimationName = "Ability_2",
    DamageMultiplier = 1.4,
    FinalDamageMultiplier = 2.2,
    DashSpeed = 40,
    DashDuration = 0.18,
    CastSFX = "Sonido",
    CastVolume = 0.9,
    FinalHitSFX = "HardHit_1",
    FinalHitVolume = 1,
    HitVFX = { "Left_Slash", "Right_Slash" },
    ResetSlot = 1,
    ResetChance = 0.4,
    HitboxSize = Vector3.new(28, 18, 30),
    HitboxRange = 28,
    MaxDuration = 2
};

function u1._EnsureAnimation(p2) -- Line: 67
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

function u1._PerformHit(p7, p8) -- Line: 94
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v9 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
        end;
    end;
end;

function u1._DoDirectionalDash(p10) -- Line: 115
    -- upvalues: u1 (copy), Debris (copy)
    local v11 = p10.Character and p10.Character:FindFirstChild("HumanoidRootPart");

    if not v11 then
        return;
    end;

    local Humanoid = p10.Humanoid;
    local v12 = Humanoid and (Humanoid.MoveDirection.Magnitude > 0 and Humanoid.MoveDirection.Unit) or v11.CFrame.LookVector;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v12 * u1.DashSpeed;
    BodyVelocity.Parent = v11;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
end;

function u1._RollResetSkill1(p13) -- Line: 135
    -- upvalues: u1 (copy)
    if not p13:IsSkillOnCooldown(u1.ResetSlot) then
        return;
    end;

    if math.random() >= u1.ResetChance then
        return;
    end;

    p13:RefreshSkillCooldown(u1.ResetSlot);
end;

function u1.CanActivate(p14) -- Line: 143
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

function u1.Activate(u15, p16) -- Line: 151
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v17 = u1._EnsureAnimation(u15);

    if not v17 then
        warn("[Renewal Flurry] Animation not found");

        return;
    end;

    local Character = u15.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;

    for i, v in u15.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    SharedUtils.PlaySoundAt(Character, u1.CastSFX, u1.CastVolume);
    v17:Play(0, 1, 1);
    local u18 = {};

    local function disconnectAll() -- Line: 181
        -- upvalues: u18 (copy)
        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);
    end;

    local u19 = false;

    local function releaseState() -- Line: 187
        -- upvalues: u19 (ref), u15 (copy), u1 (ref)
        if u19 then
            return;
        end;

        u19 = true;
        u15.Is_Using_Skill = false;
        u15.Is_Attacking = false;
        u1._RollResetSkill1(u15);
    end;

    local u20 = 0;
    u18[#u18 + 1] = v17:GetMarkerReachedSignal("hit"):Connect(function(p21) -- Line: 200
        -- upvalues: u20 (ref), u1 (ref), u15 (copy), SharedUtils (ref)
        u20 = u20 + 1;
        local v22 = u20 >= 3;
        u1._DoDirectionalDash(u15);
        local v23 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if v23 then
            if v22 then
                SharedUtils.PlaySoundAt(v23, u1.FinalHitSFX, u1.FinalHitVolume);
            else
                u15:PlayCombatSound(u15.ClassData.SwingSoundFolder or "Short_Punches", nil, u15.ClassData.SwingVolume or 0.5);
            end;
        end;

        u15:PlayFX(u1.HitVFX[math.random(1, #u1.HitVFX)]);
        u15:ShakeCamera(v22 and "SkillHeavy" or "SkillLight");
        u1._PerformHit(u15, v22 and u1.FinalDamageMultiplier or u1.DamageMultiplier);
    end);
    u18[#u18 + 1] = v17:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v17.Stopped:Once(function() -- Line: 228
        -- upvalues: u19 (ref), u15 (copy), u1 (ref), u18 (copy)
        if not u19 then
            u19 = true;
            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
            u1._RollResetSkill1(u15);
        end;

        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);
    end);
    task.delay(u1.MaxDuration, function() -- Line: 233
        -- upvalues: u19 (ref), u15 (copy), u1 (ref), u18 (copy)
        if not u19 then
            u19 = true;
            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
            u1._RollResetSkill1(u15);
        end;

        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);
    end);
end;

return u1;