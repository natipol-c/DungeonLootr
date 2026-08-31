--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ink Severance
  Path:     game.ReplicatedStorage.Classes.Wanderer.Skills.Ink Severance
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 8,
    DamageMultiplier = 1.67,
    AnimationName = "Ability_3",
    HitboxSize = Vector3.new(20, 10, 40),
    HitboxRange = 40,
    FollowupDelays = { 0.1, 0.15 },
    SwingSFX = "hit_sword_L",
    SwingVolume = 1,
    MaxDuration = 2
};

function u1._EnsureAnimation(p2) -- Line: 51
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

function u1._PerformHit(p7) -- Line: 78
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

function u1._DoDamageTick(p10) -- Line: 103
    -- upvalues: u1 (copy)
    if not (p10.Character and p10.Character.Parent) then
        return;
    end;

    p10:ShakeCamera("SkillLight");
    u1._PerformHit(p10);
end;

function u1.CanActivate(p11) -- Line: 111
    if p11.Is_Attacking then
        return false, "Attacking";
    end;

    if p11.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p11.Is_Dodging then
        return false, "Dodging";
    end;

    if p11.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u12, p13) -- Line: 119
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v14 = u1._EnsureAnimation(u12);

    if not v14 then
        warn("[Ink Severance] Animation not found");

        return;
    end;

    u12.Is_Using_Skill = true;
    u12.Is_Attacking = true;

    for i, v in u12.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v14:Play(0, 1, 1);
    local u15 = {};

    local function disconnectAll() -- Line: 142
        -- upvalues: u15 (copy)
        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end;

    local u16 = false;

    local function releaseState() -- Line: 150
        -- upvalues: u16 (ref), u12 (copy)
        if u16 then
            return;
        end;

        u16 = true;
        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;
    end;

    u15[#u15 + 1] = v14:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 161
        -- upvalues: u12 (copy), SharedUtils (ref), u1 (ref)
        local v18 = u12.Character and u12.Character:FindFirstChild("HumanoidRootPart");

        if v18 then
            SharedUtils.PlaySoundAt(v18, u1.SwingSFX, u1.SwingVolume);
        end;

        if p17 == "" or not p17 then
            p17 = nil;
        end;

        u12:PlayTurnFX(p17);
        u1._DoDamageTick(u12);

        for _, v in u1.FollowupDelays do
            task.delay(v, function() -- Line: 175
                -- upvalues: u1 (ref), u12 (ref)
                u1._DoDamageTick(u12);
            end);
        end;
    end);
    u15[#u15 + 1] = v14:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v14.Stopped:Once(function() -- Line: 185
        -- upvalues: u16 (ref), u12 (copy), u15 (copy)
        if not u16 then
            u16 = true;
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end);
    task.delay(u1.MaxDuration, function() -- Line: 190
        -- upvalues: u16 (ref), u12 (copy), u15 (copy)
        if not u16 then
            u16 = true;
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end);
end;

return u1;