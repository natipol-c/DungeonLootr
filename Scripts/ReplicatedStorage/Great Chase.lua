--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Great Chase
  Path:     game.ReplicatedStorage.Classes.Greatsword.Skills.Great Chase
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:49 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 7,
    DamageMultiplier = 2.5,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    ParryDuration = 0.5,
    HitboxSize = Vector3.new(20, 10, 20),
    MaxDuration = 2.2
};

function u1._EnsureAnimation(p2) -- Line: 40
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

function u1._PerformHit(p7) -- Line: 66
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    local v9 = 0;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v9 = v9 + 1;
        end;
    end;

    return v9;
end;

function u1.CanActivate(p10) -- Line: 89
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

function u1.Activate(u11, p12) -- Line: 97
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Great Chase] Animation not found");

        return;
    end;

    local Character = u11.Character;
    local v14;

    if Character then
        v14 = Character:FindFirstChild("HumanoidRootPart");
    else
        v14 = Character;
    end;

    if not v14 then
        return;
    end;

    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;

    for i, v in u11.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    Character:SetAttribute("Parry", true);
    task.delay(u1.ParryDuration, function() -- Line: 121
        -- upvalues: u11 (copy)
        local Character2 = u11.Character;

        if Character2 then
            Character2:SetAttribute("Parry", false);
        end;
    end);

    local function clearParry() -- Line: 127
        -- upvalues: u11 (copy)
        if u11.Character then
            u11.Character:SetAttribute("Parry", false);
        end;
    end;

    v13:Play(0, 1, 1);
    local u15 = {};

    local function disconnectAll() -- Line: 136
        -- upvalues: u15 (copy)
        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end;

    local u16 = 0;
    u15[#u15 + 1] = v13:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 143
        -- upvalues: u16 (ref), u1 (ref), u11 (copy), SharedUtils (ref)
        u16 = u16 + 1;

        if u16 > 2 then
            return;
        end;

        u11:PlayCombatSound(u1.Skill_SFX or (u11.ClassData.SwingSoundFolder or "Power_Swing_2"), nil, u11.ClassData.SwingVolume or 0.5);

        if u16 == 2 then
            u11:PlayTurnFX("Eruption");
            local v18 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

            if v18 then
                SharedUtils.PlaySoundAt(v18, "Earth_Hammer_2", 2);
            end;
        else
            if p17 == "" or not p17 then
                p17 = nil;
            end;

            u11:PlayTurnFX(p17);
        end;

        u1._PerformHit(u11);
        u11:ShakeCamera("SkillLight");
    end);
    local u19 = false;

    local function releaseState() -- Line: 169
        -- upvalues: u19 (ref), u11 (copy)
        if u19 then
            return;
        end;

        u19 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    u15[#u15 + 1] = v13:GetMarkerReachedSignal("DBreset"):Connect(releaseState);

    local function fullCleanup() -- Line: 180
        -- upvalues: u19 (ref), u11 (copy), u15 (copy)
        if not u19 then
            u19 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        if u11.Character then
            u11.Character:SetAttribute("Parry", false);
        end;

        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end;

    v13.Stopped:Once(fullCleanup);
    task.delay(u1.MaxDuration, fullCleanup);
end;

return u1;