--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Blessed Rain
  Path:     game.ReplicatedStorage.Classes.Streamline.Skills.Blessed Rain
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:44 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 30,
    MaxCharges = 1,
    DamageMultiplier = 15,
    AnimationName = "Ultimate",
    EffectModule = "Blessed_Rain",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(60, 20, 60),
    HitboxRange = 0,
    DashSpeed = 40,
    DashDuration = 0.4,
    HitSFX = "Water_Bass",
    HitVolume = 1,
    MaxDuration = 2.6
};

function u1._EnsureAnimation(p2) -- Line: 64
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

function u1._PerformHit(p7) -- Line: 90
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

function u1.CanActivate(p9) -- Line: 112
    if p9.Is_Attacking then
        return false, "Attacking";
    end;

    if p9.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p9.Is_Dodging then
        return false, "Dodging";
    end;

    if p9.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u10, p11) -- Line: 120
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local v12 = u1._EnsureAnimation(u10);

    if not v12 then
        warn("[Blessed Rain] Animation not found");

        return;
    end;

    local Character = u10.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u10.Is_Using_Skill = true;
    u10.Is_Attacking = true;

    for i, v in u10.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v12:Play(0, 1, 1);
    local u13 = {};

    local function disconnectAll() -- Line: 146
        -- upvalues: u13 (copy)
        for _, v in u13 do
            v:Disconnect();
        end;

        table.clear(u13);
    end;

    local u14 = false;

    local function cleanup() -- Line: 152
        -- upvalues: u14 (ref), u10 (copy), u13 (copy)
        if u14 then
            return;
        end;

        u14 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;

        for _, v in u13 do
            v:Disconnect();
        end;

        table.clear(u13);
    end;

    local function onVFX(p15) -- Line: 165
        -- upvalues: u10 (copy), u1 (ref)
        if not p15 or p15 == "" then
            return;
        end;

        if p15 == "Trail" then
            return;
        end;

        local v16 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if not v16 then
            return;
        end;

        u10:PlayEffectModule(u1.EffectModule, "Emit", v16.CFrame, p15);
    end;

    u13[#u13 + 1] = v12:GetMarkerReachedSignal("VFX"):Connect(onVFX);
    u13[#u13 + 1] = v12:GetMarkerReachedSignal("VFX_2"):Connect(onVFX);
    u13[#u13 + 1] = v12:GetMarkerReachedSignal("VFX_3"):Connect(onVFX);
    u13[#u13 + 1] = v12:GetMarkerReachedSignal("dash"):Connect(function(p17) -- Line: 177
        -- upvalues: u10 (copy), u1 (ref), Debris (ref)
        local v18 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if not v18 then
            return;
        end;

        local v19 = p17 == "Back" and -v18.CFrame.LookVector or v18.CFrame.LookVector;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v19 * u1.DashSpeed;
        BodyVelocity.Parent = v18;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
    end);
    u13[#u13 + 1] = v12:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 191
        -- upvalues: u10 (copy), SharedUtils (ref), u1 (ref)
        local v20 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            SharedUtils.PlaySoundAt(v20, u1.HitSFX, u1.HitVolume);
        end;

        u10:ShakeCamera("SkillHeavy");
        u1._PerformHit(u10);
    end);
    u13[#u13 + 1] = v12:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v12.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, cleanup);
end;

return u1;