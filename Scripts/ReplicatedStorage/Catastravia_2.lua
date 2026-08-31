--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Catastravia
  Path:     game.ReplicatedStorage.Classes.Demonbane.Skills.Catastravia
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:47 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    DamageMultiplier = 0.38,
    AnimationName = "Ability_4",
    FieldFX = "Ability_4",
    FieldDuration = 2,
    TickInterval = 0.15,
    HitboxSize = Vector3.new(20, 20, 55),
    HitboxRange = 50,
    FieldSFX = "Zoltrak",
    MaxDuration = 2.5
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

function u1._PerformTick(p7) -- Line: 73
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

function u1.CanActivate(p9) -- Line: 95
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

function u1.Activate(u10, p11) -- Line: 103
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v12 = u1._EnsureAnimation(u10);

    if not v12 then
        warn("[Catastravia] Animation not found");

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

    local function disableField() -- Line: 124
        -- upvalues: u10 (copy), u1 (ref)
        u10:SetLoopFX(u1.FieldFX, false);
    end;

    local u13 = false;

    local function releaseState() -- Line: 129
        -- upvalues: u13 (ref), u10 (copy)
        if u13 then
            return;
        end;

        u13 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;
    end;

    local u14 = false;
    local u17 = v12:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 140
        -- upvalues: u14 (ref), u10 (copy), u1 (ref), SharedUtils (ref), u13 (ref)
        if u14 then
            return;
        end;

        u14 = true;
        u10:SetLoopFX(u1.FieldFX, true);
        local v15 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if v15 then
            SharedUtils.PlaySoundAt(v15, u1.FieldSFX, 1);
        end;

        u10:ShakeCamera("SkillHeavy");
        task.spawn(function() -- Line: 153
            -- upvalues: u1 (ref), u10 (ref), u13 (ref)
            local math_floor_ret = math.floor(u1.FieldDuration / u1.TickInterval);

            for i = 1, math_floor_ret do
                if not (u10.Character and u10.Character.Parent) then
                    break;
                end;

                u1._PerformTick(u10);
                local v16;

                if i < math_floor_ret then
                    task.wait(u1.TickInterval);
                    v16 = i;
                else
                    v16 = i;
                end;
            end;

            u10:SetLoopFX(u1.FieldFX, false);

            if u13 then
                return;
            end;

            u13 = true;
            u10.Is_Using_Skill = false;
            u10.Is_Attacking = false;
        end);
    end);
    v12.Stopped:Once(function() -- Line: 171
        -- upvalues: u17 (ref), u14 (ref), u13 (ref), u10 (copy)
        if u17 then
            u17:Disconnect();
            u17 = nil;
        end;

        if not u14 then
            if u13 then
                return;
            end;

            u13 = true;
            u10.Is_Using_Skill = false;
            u10.Is_Attacking = false;
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 179
        -- upvalues: u17 (ref), u10 (copy), u1 (ref), u13 (ref)
        if u17 then
            u17:Disconnect();
            u17 = nil;
        end;

        u10:SetLoopFX(u1.FieldFX, false);

        if u13 then
            return;
        end;

        u13 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;
    end);
end;

return u1;