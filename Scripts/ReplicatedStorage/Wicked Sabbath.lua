--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Wicked Sabbath
  Path:     game.ReplicatedStorage.Classes.Witch Gunner.Skills.Wicked Sabbath
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:53 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    Cooldown = 15,
    DamageMultiplier = 0.32,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    FX_Name = "Savage",
    SavageDamageMultiplier = 0.56,
    SavageHitboxSize = Vector3.new(25, 20, 35),
    HitboxSize = Vector3.new(20, 10, 20),
    MaxDuration = 3.5
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

function u1._PerformHit(p7, p8) -- Line: 72
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    p7.ClassData.HitboxSize = p8 and u1.SavageHitboxSize or u1.HitboxSize;
    local v9 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    local v10 = p8 and u1.SavageDamageMultiplier or u1.DamageMultiplier;
    local v11 = 0;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(v10, v)));
            v11 = v11 + 1;
        end;
    end;

    return v11;
end;

function u1.CanActivate(p12) -- Line: 102
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

function u1.Activate(u13, p14) -- Line: 110
    -- upvalues: u1 (copy)
    local v15 = u1._EnsureAnimation(u13);

    if not v15 then
        warn("[Wicked Sabbath] Animation not found");

        return;
    end;

    local Character = u13.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
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

    local function setFX(p16) -- Line: 136
        -- upvalues: u13 (copy), u1 (ref)
        u13:SetLoopFX(u1.FX_Name, p16);
    end;

    local function setAnchored(p17) -- Line: 141
        -- upvalues: u13 (copy)
        local v18 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v18 then
            v18.Anchored = p17;
        end;
    end;

    local u19 = false;
    local u21 = v15:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 153
        -- upvalues: u19 (ref), u13 (copy), u1 (ref)
        u19 = true;
        u13:SetLoopFX(u1.FX_Name, true);
        local v20 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            v20.Anchored = true;
        end;
    end);
    local u23 = v15:GetMarkerReachedSignal("End"):Connect(function() -- Line: 161
        -- upvalues: u19 (ref), u13 (copy), u1 (ref)
        u19 = false;
        u13:SetLoopFX(u1.FX_Name, false);
        local v22 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v22 then
            v22.Anchored = false;
        end;
    end);
    local u25 = v15:GetMarkerReachedSignal("hit"):Connect(function(p24) -- Line: 169
        -- upvalues: u1 (ref), u13 (copy), u19 (ref)
        u13:PlayCombatSound(u1.Skill_SFX or (u13.ClassData.SwingSoundFolder or "Gun_Shots"), nil, u13.ClassData.SwingVolume or 0.5);

        if p24 ~= "" then
            u13:PlayTurnFX(p24);
        end;

        u13:ShakeCamera("Hit");
        u1._PerformHit(u13, u19);
    end);
    local u26 = false;

    local function releaseState() -- Line: 186
        -- upvalues: u26 (ref), u13 (copy)
        if u26 then
            return;
        end;

        u26 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    local u27 = v15:GetMarkerReachedSignal("DBreset"):Connect(releaseState);

    local function cleanupAll() -- Line: 197
        -- upvalues: u25 (ref), u21 (ref), u23 (ref), u27 (ref), u19 (ref), u13 (copy), u1 (ref), u26 (ref)
        if u25 then
            u25:Disconnect();
            u25 = nil;
        end;

        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;

        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;

        if u27 then
            u27:Disconnect();
            u27 = nil;
        end;

        u19 = false;
        u13:SetLoopFX(u1.FX_Name, false);
        local v28 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v28 then
            v28.Anchored = false;
        end;

        if u26 then
            return;
        end;

        u26 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    v15.Stopped:Once(function() -- Line: 211
        -- upvalues: cleanupAll (copy)
        cleanupAll();
    end);
    task.delay(u1.MaxDuration, function() -- Line: 216
        -- upvalues: cleanupAll (copy)
        cleanupAll();
    end);
end;

return u1;