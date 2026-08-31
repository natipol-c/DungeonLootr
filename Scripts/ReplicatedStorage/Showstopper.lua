--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Showstopper
  Path:     game.ReplicatedStorage.Classes.Sinister Trigger.Skills.Showstopper
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u1 = {
    Cooldown = 8,
    AnimationName = "Ability_2",
    LoopFX = "Breakdance",
    TickMultiplier = 0.35,
    TickInterval = 0.09,
    MaxHits = 30,
    TickHitboxSize = Vector3.new(35, 16, 35),
    TickHitboxRange = 0,
    SlideSpeed = 26,
    ResetSlot = 3,
    ResetChance = 0.1,
    TickSFX = "Revolver_1",
    TickVolume = 0.4,
    MaxDuration = 3,
    MinLifetime = 1,
    HoldAnimationName = "Ability_2_Hold",
    HoldDamageMultiplier = 1.67,
    HoldHitboxSize = Vector3.new(24, 26, 28),
    HoldHitboxRange = 25,
    HoldLiftSpeed = 90,
    HoldLiftDuration = 0.1,
    HoldFX = "Rising_Slash",
    HoldHitSFX = "hit_sword_L",
    HoldHitVolume = 0.7,
    HoldMaxDuration = 2.5
};

function u1._RollReset(p2) -- Line: 95
    -- upvalues: u1 (copy)
    if math.random() < u1.ResetChance and p2:IsSkillOnCooldown(u1.ResetSlot) then
        p2:RefreshSkillCooldown(u1.ResetSlot);
    end;
end;

function u1._SetSlashWeapons(p3, p4) -- Line: 107
    if not p3 then
        return;
    end;

    local Left_Arm = p3:FindFirstChild("Left_Arm", true);
    local Right_Arm = p3:FindFirstChild("Right_Arm", true);

    if Left_Arm then
        Left_Arm = Left_Arm:FindFirstChild("Left_Gun");
    end;

    local v5;

    if Right_Arm then
        v5 = Right_Arm:FindFirstChild("Right_Gun");
    else
        v5 = Right_Arm;
    end;

    if Right_Arm then
        Right_Arm = Right_Arm:FindFirstChild("Sword");
    end;

    if Left_Arm then
        Left_Arm.Transparency = p4 and 1 or 0;
    end;

    if v5 then
        v5.Transparency = p4 and 1 or 0;
    end;

    if Right_Arm then
        Right_Arm.Transparency = p4 and 0 or 1;
    end;
end;

function u1._PerformHoldHit(p6) -- Line: 120
    -- upvalues: u1 (copy)
    local HitboxSize = p6.ClassData.HitboxSize;
    local Range = p6.ClassData.Range;
    p6.ClassData.HitboxSize = u1.HoldHitboxSize;
    p6.ClassData.Range = u1.HoldHitboxRange;
    local v7 = p6:Hitbox();
    p6.ClassData.HitboxSize = HitboxSize;
    p6.ClassData.Range = Range;

    for _, v in v7 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p6:ApplyDamage(v, (p6:ResolveSkillDamage(u1.HoldDamageMultiplier, v)));
        end;
    end;
end;

function u1.CanActivate(p8) -- Line: 142
    if p8.Is_Attacking then
        return false, "Attacking";
    end;

    if p8.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p8.Is_Dodging then
        return false, "Dodging";
    end;

    if p8.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u9, p10) -- Line: 150
    -- upvalues: SkillRuntime (copy), u1 (copy), SharedUtils (copy)
    local v11 = SkillRuntime.EnsureAnimation(u9, u1.AnimationName);

    if not v11 then
        warn("[Showstopper] Animation not found");

        return;
    end;

    local Character = u9.Character;
    local u12;

    if Character then
        u12 = Character:FindFirstChild("HumanoidRootPart");
    else
        u12 = Character;
    end;

    if not u12 then
        return;
    end;

    u1._RollReset(u9);
    u9.Is_Using_Skill = true;
    u9.Is_Attacking = true;
    Character:SetAttribute("Parry", true);
    SkillRuntime.StopAttackAnims(u9);
    v11:Play(0, 1, 1);
    local u13 = nil;
    local u14 = nil;

    local function releaseSlide() -- Line: 177
        -- upvalues: u14 (ref)
        if u14 then
            u14:Destroy();
            u14 = nil;
        end;
    end;

    local v15 = SkillRuntime.MakeLifecycle(u9, v11, u1.MaxDuration, function() -- Line: 185
        -- upvalues: u13 (ref), u14 (ref), u9 (copy), u1 (ref)
        if u13 then
            u13();
        end;

        if u14 then
            u14:Destroy();
            u14 = nil;
        end;

        u9:SetLoopFX(u1.LoopFX, false);

        if u9.Character then
            u9.Character:SetAttribute("Parry", false);
        end;

        u9.Is_Using_Skill = false;
        u9.Is_Attacking = false;
    end, u1.MinLifetime);
    local conns = v15.conns;
    conns[#conns + 1] = v11:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 196
        -- upvalues: u13 (ref), u9 (copy), u1 (ref), SharedUtils (ref), u12 (copy), u14 (ref), SkillRuntime (ref)
        if u13 then
            return;
        end;

        if not u9.Is_Using_Skill then
            warn("[Showstopper] Start fired after cast release — re-asserting Is_Using_Skill (flurry would have no-op\'d)");
            u9.Is_Using_Skill = true;
        end;

        u9:SetLoopFX(u1.LoopFX, true);
        SharedUtils.PlaySoundAt(u12, "Revolver_Spin", 0.6);
        u14 = Instance.new("BodyVelocity");
        u14.Name = "ShowstopperSlide";
        u14.MaxForce = Vector3.new(100000, 0, 100000);
        u14.Velocity = u12.CFrame.LookVector * u1.SlideSpeed;
        u14.Parent = u12;
        u13 = SkillRuntime.TickFlurry(u9, {
            Interval = u1.TickInterval,
            MaxHits = u1.MaxHits,
            Hitbox = {
                Multiplier = u1.TickMultiplier,
                Size = u1.TickHitboxSize,
                Range = u1.TickHitboxRange
            },

            onTick = function() -- Line: 226, Name: onTick
                -- upvalues: SharedUtils (ref), u12 (ref), u1 (ref), u9 (ref)
                SharedUtils.PlaySoundAt(u12, u1.TickSFX, u1.TickVolume, 0.05);
                u9:ShakeCamera("SkillLight");
            end
        });
    end);
    conns[#conns + 1] = v11:GetMarkerReachedSignal("End"):Connect(function() -- Line: 234
        -- upvalues: u13 (ref), u14 (ref), u9 (copy), u1 (ref)
        if u13 then
            u13();
        end;

        if u14 then
            u14:Destroy();
            u14 = nil;
        end;

        u9:SetLoopFX(u1.LoopFX, false);
        u9:ShakeCamera("SkillMedium");
    end);
    conns[#conns + 1] = v11:GetMarkerReachedSignal("DBreset"):Connect(v15.cleanup);
end;

function u1.ActivateHold(u16, p17) -- Line: 248
    -- upvalues: SkillRuntime (copy), u1 (copy), SharedUtils (copy)
    local v18 = SkillRuntime.EnsureAnimation(u16, u1.HoldAnimationName);

    if not v18 then
        warn("[Showstopper] Hold animation not found");

        return;
    end;

    local Character = u16.Character;
    local v19;

    if Character then
        v19 = Character:FindFirstChild("HumanoidRootPart");
    else
        v19 = Character;
    end;

    if not v19 then
        return;
    end;

    u1._RollReset(u16);
    u16.Is_Using_Skill = true;
    u16.Is_Attacking = true;
    SkillRuntime.StopAttackAnims(u16);
    v18:Play(0, 1, 1);
    u1._SetSlashWeapons(Character, true);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "ShowstopperRise";
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3.new(0, u1.HoldLiftSpeed, 0);
    BodyVelocity.Parent = v19;
    task.delay(u1.HoldLiftDuration, function() -- Line: 280
        -- upvalues: BodyVelocity (ref)
        if BodyVelocity and BodyVelocity.Parent then
            BodyVelocity.Velocity = Vector3.new(0, 0, 0);
        end;
    end);

    local function releaseAirHold() -- Line: 285
        -- upvalues: BodyVelocity (ref)
        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;
    end;

    local v20 = SkillRuntime.MakeLifecycle(u16, v18, u1.HoldMaxDuration, function() -- Line: 294
        -- upvalues: BodyVelocity (ref), u1 (ref), Character (copy), u16 (copy)
        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;

        u1._SetSlashWeapons(Character, false);
        u16.Is_Using_Skill = false;
        u16.Is_Attacking = false;
    end, u1.MinLifetime);
    local conns = v20.conns;
    conns[#conns + 1] = v18:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 303
        -- upvalues: u16 (copy), SharedUtils (ref), u1 (ref)
        local v21 = u16.Character and u16.Character:FindFirstChild("HumanoidRootPart");

        if v21 then
            SharedUtils.PlaySoundAt(v21, u1.HoldHitSFX, u1.HoldHitVolume);
        end;

        u16:PlayFX(u1.HoldFX);
        u16:ShakeCamera("Hit");
        u1._PerformHoldHit(u16);
    end);
    conns[#conns + 1] = v18:GetMarkerReachedSignal("DBreset"):Connect(v20.cleanup);
end;

return u1;