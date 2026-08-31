--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Supreme Cell Blades
  Path:     game.ReplicatedStorage.Classes.Forge Archon.Skills.Supreme Cell Blades
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:58 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 12,
    AnimationName = "Ability_4",
    EffectModule = "Supreme_Cell_Blades",
    DamageMultiplier = 1.67,
    HitboxSize = Vector3.new(40, 20, 40),
    HitboxRange = 30,
    ParryDuration = 0.4,
    StepDashSpeed = 35,
    StepDashDuration = 0.15,
    SlashSFX = "Fire_Woosh",
    SlashVolume = 0.85,
    SwingVolume = 0.5,
    MaxDuration = 3
};

function u1._EnsureAnimation(p2) -- Line: 60
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

function u1._PerformHit(p7) -- Line: 86
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

function u1._DoStepDash(p9) -- Line: 108
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
    BodyVelocity.Name = "SkillStepDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v11 * u1.StepDashSpeed;
    BodyVelocity.Parent = v10;
    Debris:AddItem(BodyVelocity, u1.StepDashDuration);
end;

function u1.CanActivate(p12) -- Line: 130
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

function u1.Activate(u13, p14) -- Line: 138
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v15 = u1._EnsureAnimation(u13);

    if not v15 then
        warn("[Supreme Cell Blades] Animation not found");

        return;
    end;

    if not u13.Character then
        return;
    end;

    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;

    if u13.ClassData and u13.ClassData.EnterMeleeMode then
        u13.ClassData.EnterMeleeMode(u13);
    end;

    for i, v in u13.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v15:Play(0, 1, 1);
    local u16 = {};

    local function disconnectAll() -- Line: 170
        -- upvalues: u16 (copy)
        for _, v in u16 do
            v:Disconnect();
        end;

        table.clear(u16);
    end;

    local u17 = 0;

    local function grantHitParry() -- Line: 178
        -- upvalues: u17 (ref), u13 (copy), u1 (ref)
        u17 = u17 + 1;
        local u18 = u17;

        if u13.Character then
            u13.Character:SetAttribute("Parry", true);
        end;

        task.delay(u1.ParryDuration, function() -- Line: 182
            -- upvalues: u18 (copy), u17 (ref), u13 (ref)
            if u18 ~= u17 then
                return;
            end;

            if u13.Character then
                u13.Character:SetAttribute("Parry", false);
            end;
        end);
    end;

    local u19 = false;

    local function releaseState() -- Line: 189
        -- upvalues: u19 (ref), u13 (copy)
        if u19 then
            return;
        end;

        u19 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    local function cleanup() -- Line: 197
        -- upvalues: u19 (ref), u13 (copy), u16 (copy)
        if not u19 then
            u19 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        for _, v in u16 do
            v:Disconnect();
        end;

        table.clear(u16);

        if u13.Character then
            u13.Character:SetAttribute("Parry", false);
        end;
    end;

    local function emitVFX(p20) -- Line: 206
        -- upvalues: u13 (copy), u1 (ref)
        if not p20 or p20 == "" then
            return;
        end;

        local v21 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if not v21 then
            return;
        end;

        u13:PlayEffectModule(u1.EffectModule, "Emit", v21.CFrame, p20);
    end;

    u16[#u16 + 1] = v15:GetMarkerReachedSignal("VFX"):Connect(emitVFX);
    u16[#u16 + 1] = v15:GetMarkerReachedSignal("VFX_2"):Connect(emitVFX);
    u16[#u16 + 1] = v15:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 216
        -- upvalues: u13 (copy), u1 (ref), SharedUtils (ref), u17 (ref)
        local v22 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");
        u13:PlayCombatSound(u13.ClassData.SwingSoundFolder or "Ninja", nil, u13.ClassData.SwingVolume or u1.SwingVolume);

        if v22 then
            SharedUtils.PlaySoundAt(v22, u1.SlashSFX, u1.SlashVolume);
        end;

        u13:ShakeCamera("SkillMedium");
        u17 = u17 + 1;
        local u23 = u17;

        if u13.Character then
            u13.Character:SetAttribute("Parry", true);
        end;

        task.delay(u1.ParryDuration, function() -- Line: 182
            -- upvalues: u23 (copy), u17 (ref), u13 (ref)
            if u23 ~= u17 then
                return;
            end;

            if u13.Character then
                u13.Character:SetAttribute("Parry", false);
            end;
        end);
        u1._DoStepDash(u13);
        u1._PerformHit(u13);
    end);
    u16[#u16 + 1] = v15:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v15.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, cleanup);
end;

return u1;