--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Dread Vortex
  Path:     game.ReplicatedStorage.Classes.Dreadlord.Skills.Dread Vortex
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:55 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    Cooldown = 12,
    DamageMultiplier = 1,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    TotalHits = 12,
    HitboxSize = Vector3.new(30, 30, 30),
    HitboxRange = 0,
    MaxDuration = 5
};

function u1._EnsureAnimation(p2) -- Line: 45
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

function u1._PerformHit(p7) -- Line: 71
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

function u1.CanActivate(p10) -- Line: 97
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

function u1.Activate(u11, p12) -- Line: 105
    -- upvalues: u1 (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Dread Vortex] Animation not found");

        return;
    end;

    local Character = u11.Character;

    if not Character then
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

    local function activateVortex() -- Line: 132
        -- upvalues: u14 (ref), u11 (copy), Character (copy)
        if u14 then
            return;
        end;

        u14 = true;
        u11:SetLoopFX("Death_Vortex", true);

        if Character then
            Character:SetAttribute("NoKnockback", true);
            Character:SetAttribute("Parry", true);
        end;
    end;

    local function deactivateVortex() -- Line: 146
        -- upvalues: u14 (ref), u11 (copy), Character (copy)
        if not u14 then
            return;
        end;

        u14 = false;
        u11:SetLoopFX("Death_Vortex", false);

        if Character then
            Character:SetAttribute("NoKnockback", false);
            Character:SetAttribute("Parry", false);
        end;
    end;

    local u15 = 0;
    local u17 = v13:GetMarkerReachedSignal("hit"):Connect(function(p16) -- Line: 163
        -- upvalues: u15 (ref), u14 (ref), u11 (copy), Character (copy), u1 (ref)
        u15 = u15 + 1;

        if p16 == "Start" and not u14 then
            u14 = true;
            u11:SetLoopFX("Death_Vortex", true);

            if Character then
                Character:SetAttribute("NoKnockback", true);
                Character:SetAttribute("Parry", true);
            end;
        end;

        u11:PlayCombatSound(u1.Skill_SFX or u11.ClassData.SwingSoundFolder or "Flame_Swing", nil, u11.ClassData.SwingVolume or 1);
        u1._PerformHit(u11);
        u11:ShakeCamera("Hit");

        if u15 >= u1.TotalHits then
            if not u14 then
                return;
            end;

            u14 = false;
            u11:SetLoopFX("Death_Vortex", false);

            if Character then
                Character:SetAttribute("NoKnockback", false);
                Character:SetAttribute("Parry", false);
            end;
        end;
    end);
    local u18 = nil;
    u18 = v13:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 187
        -- upvalues: u17 (ref), u14 (ref), u11 (copy), Character (copy), u18 (ref)
        if u17 then
            u17:Disconnect();
        end;

        if u14 then
            u14 = false;
            u11:SetLoopFX("Death_Vortex", false);

            if Character then
                Character:SetAttribute("NoKnockback", false);
                Character:SetAttribute("Parry", false);
            end;
        end;

        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;

        if u18 then
            u18:Disconnect();
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 200
        -- upvalues: u17 (ref), u14 (ref), u11 (copy), Character (copy)
        if u17 then
            u17:Disconnect();
        end;

        if u14 then
            u14 = false;
            u11:SetLoopFX("Death_Vortex", false);

            if Character then
                Character:SetAttribute("NoKnockback", false);
                Character:SetAttribute("Parry", false);
            end;
        end;

        if u11.Is_Using_Skill then
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;
    end);
end;

return u1;