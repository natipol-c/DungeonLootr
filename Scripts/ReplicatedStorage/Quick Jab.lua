--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Quick Jab
  Path:     game.ReplicatedStorage.Classes.Boxer.Skills.Quick Jab
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:53 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 4,
    MaxCharges = 4,
    DamageMultiplier = 4,
    AnimationName = "Ability_1",
    HitboxSize = Vector3.new(20, 10, 20),
    HitboxRange = 18,
    DashSpeed = 85,
    DashDuration = 0.05,
    ClashVolume = 0.8,
    MaxDuration = 1.2
};

function u1._EnsureAnimation(p2) -- Line: 49
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

function u1._PerformHit(p7) -- Line: 76
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
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

function u1._Dash(p10) -- Line: 101
    -- upvalues: u1 (copy), Debris (copy)
    local Character = p10.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local Humanoid = p10.Humanoid;
    local v11;

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
        v11 = Humanoid.MoveDirection.Unit;
    else
        v11 = Character.CFrame.LookVector;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v11 * u1.DashSpeed;
    BodyVelocity.Parent = Character;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
end;

function u1.CanActivate(p12) -- Line: 125
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

function u1.Activate(u13, p14) -- Line: 133
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v15 = u1._EnsureAnimation(u13);

    if not v15 then
        warn("[Quick Jab] Animation not found");

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
    local u16 = {};

    local function disconnectAll() -- Line: 156
        -- upvalues: u16 (copy)
        for _, v in u16 do
            v:Disconnect();
        end;

        table.clear(u16);
    end;

    local u17 = false;

    local function releaseState() -- Line: 164
        -- upvalues: u17 (ref), u13 (copy)
        if u17 then
            return;
        end;

        u17 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    u16[#u16 + 1] = v15:GetMarkerReachedSignal("hit"):Connect(function(p18) -- Line: 173
        -- upvalues: u13 (copy), SharedUtils (ref), u1 (ref)
        local v19 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v19 then
            SharedUtils.PlaySoundAt(v19, "Clash", u1.ClashVolume);
        end;

        if p18 == "" or not p18 then
            p18 = nil;
        end;

        u13:PlayTurnFX(p18);
        u13:ShakeCamera("Hit");
        u1._Dash(u13);
        u1._PerformHit(u13);
    end);
    u16[#u16 + 1] = v15:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v15.Stopped:Once(function() -- Line: 189
        -- upvalues: u17 (ref), u13 (copy), u16 (copy)
        if not u17 then
            u17 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        for _, v in u16 do
            v:Disconnect();
        end;

        table.clear(u16);
    end);
    task.delay(u1.MaxDuration, function() -- Line: 194
        -- upvalues: u17 (ref), u13 (copy), u16 (copy)
        if not u17 then
            u17 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        for _, v in u16 do
            v:Disconnect();
        end;

        table.clear(u16);
    end);
end;

return u1;