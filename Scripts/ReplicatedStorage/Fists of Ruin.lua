--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Fists of Ruin
  Path:     game.ReplicatedStorage.Classes.Kage.Skills.Fists of Ruin
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u2 = {
    Cooldown = 15,
    DamageMultiplier = 0.17,
    FinalDamageMultiplier = 1.1,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(15, 15, 17),
    HitboxRange = 17,
    ParryDuration = 4,
    CloneFadeDuration = 0.5,
    CloneColor = Color3.fromRGB(60, 20, 80),
    MaxDuration = 5
};

function u2._EnsureAnimation(p3) -- Line: 47
    -- upvalues: u2 (copy), ReplicatedStorage (copy)
    local AnimationName = u2.AnimationName;

    if p3.Animations[AnimationName] then
        return p3.Animations[AnimationName];
    end;

    local v4 = ReplicatedStorage.Classes:FindFirstChild(p3.ClassName);

    if not v4 then
        return nil;
    end;

    local Skill_Animations = v4:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v5 = Skill_Animations:FindFirstChild(u2.AnimationName);

    if not v5 then
        return nil;
    end;

    local v6 = p3.Humanoid and p3.Humanoid:FindFirstChildOfClass("Animator");

    if not v6 then
        return nil;
    end;

    local v7 = v6:LoadAnimation(v5);
    v7.Priority = Enum.AnimationPriority.Action3;
    v7:Play(0, 0, 0);
    v7:Stop(0);
    p3.Animations[AnimationName] = v7;

    return v7;
end;

function u2._PerformHit(p8, p9) -- Line: 73
    -- upvalues: u2 (copy)
    local HitboxSize = p8.ClassData.HitboxSize;
    local Range = p8.ClassData.Range;
    p8.ClassData.HitboxSize = u2.HitboxSize;
    p8.ClassData.Range = u2.HitboxRange;
    local v10 = p8:Hitbox();
    p8.ClassData.HitboxSize = HitboxSize;
    p8.ClassData.Range = Range;
    local v11 = 0;

    for _, v in v10 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, (p8:ResolveSkillDamage(p9, v)));
            v11 = v11 + 1;
        end;
    end;

    return v11;
end;

function u2._SpawnClone(p12) -- Line: 97
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return;
    end;

    u1:FireAllClients(p12.Player, {
        Action = "Clone",
        FadeDuration = u2.CloneFadeDuration,
        Color = u2.CloneColor
    });
end;

function u2.CanActivate(p13) -- Line: 109
    if p13.Is_Attacking then
        return false, "Attacking";
    end;

    if p13.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p13.Is_Dodging then
        return false, "Dodging";
    end;

    if p13.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u2.Activate(u14, p15) -- Line: 117
    -- upvalues: u2 (copy)
    local v16 = u2._EnsureAnimation(u14);

    if not v16 then
        warn("[Fists of Ruin] Animation not found");

        return;
    end;

    local Character = u14.Character;
    local v17;

    if Character then
        v17 = Character:FindFirstChild("HumanoidRootPart");
    else
        v17 = Character;
    end;

    if not v17 then
        return;
    end;

    u14.Is_Using_Skill = true;
    u14.Is_Attacking = true;
    Character:SetAttribute("Parry", true);
    task.delay(u2.ParryDuration, function() -- Line: 135
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);

    for i, v in u14.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v16:Play(0, 1, 1);
    local u18 = 0;
    local u20 = v16:GetMarkerReachedSignal("hit"):Connect(function(p19) -- Line: 154
        -- upvalues: u18 (ref), u2 (ref), u14 (copy)
        u18 = u18 + 1;

        if u18 % 2 == 0 then
            u2._SpawnClone(u14);
        end;

        u14:PlayCombatSound(u2.Skill_SFX or (u14.ClassData.SwingSoundFolder or "Magic_Swings"), nil, u14.ClassData.SwingVolume or 0.5);

        if p19 == "" or not p19 then
            p19 = nil;
        end;

        u14:PlayTurnFX(p19);
        u14:ShakeCamera("Hit");
        u2._PerformHit(u14, u2.DamageMultiplier);
    end);
    local u22 = v16:GetMarkerReachedSignal("final_hit"):Connect(function(p21) -- Line: 171
        -- upvalues: u2 (ref), u14 (copy)
        u14:PlayCombatSound(u2.Skill_SFX or (u14.ClassData.SwingSoundFolder or "Magic_Swings"), nil, u14.ClassData.SwingVolume or 0.5);

        if p21 == "" or not p21 then
            p21 = nil;
        end;

        u14:PlayTurnFX(p21);
        u14:ShakeCamera("SkillLight");
        u2._PerformHit(u14, u2.FinalDamageMultiplier);
    end);
    v16.Stopped:Once(function() -- Line: 180
        -- upvalues: u20 (ref), u22 (ref), u14 (copy), Character (copy)
        if u20 then
            u20:Disconnect();
        end;

        if u22 then
            u22:Disconnect();
        end;

        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(u2.MaxDuration, function() -- Line: 193
        -- upvalues: u14 (copy), u20 (ref), u22 (ref), Character (copy)
        if u14.Is_Using_Skill then
            u14.Is_Using_Skill = false;
            u14.Is_Attacking = false;
        end;

        if u20 then
            u20:Disconnect();
        end;

        if u22 then
            u22:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u2;