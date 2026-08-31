--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cataclysm
  Path:     game.ReplicatedStorage.Classes.Greatsword.Skills.Cataclysm
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
    Cooldown = 14,
    DamageMultiplier = 4,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    IFrameDuration = 0.5,
    HitSFX = "anime_explode",
    HitVolume = 1,
    HitboxSize = Vector3.new(20, 10, 20),
    HitboxRange = 20,
    MaxDuration = 2.5
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

function u1._PerformHit(p7) -- Line: 75
    -- upvalues: u1 (copy)
    local v8 = 1 - p7:GetEffectiveStat("CritChance");

    if v8 > 0 then
        p7:ModifyStat("CritChance", v8);
    end;

    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v9 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    local v10 = 0;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v10 = v10 + 1;
        end;
    end;

    if v8 > 0 then
        p7:ModifyStat("CritChance", -v8);
    end;

    return v10;
end;

function u1.CanActivate(p11) -- Line: 114
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

function u1.Activate(u12, p13) -- Line: 122
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v14 = u1._EnsureAnimation(u12);

    if not v14 then
        warn("[Cataclysm] Animation not found");

        return;
    end;

    local Character = u12.Character;
    local v15;

    if Character then
        v15 = Character:FindFirstChild("HumanoidRootPart");
    else
        v15 = Character;
    end;

    if not v15 then
        return;
    end;

    u12.Is_Using_Skill = true;
    u12.Is_Attacking = true;

    for i, v in u12.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    if u12.Player then
        u12.Player:SetAttribute("iFrame", true);
    end;

    Character:SetAttribute("iFrame", true);
    task.delay(u1.IFrameDuration, function() -- Line: 147
        -- upvalues: u12 (copy)
        local Player = u12.Player;
        local Character2 = u12.Character;

        if Player then
            Player:SetAttribute("iFrame", false);
        end;

        if Character2 then
            Character2:SetAttribute("iFrame", false);
        end;
    end);

    local function clearIFrame() -- Line: 154
        -- upvalues: u12 (copy)
        if u12.Player then
            u12.Player:SetAttribute("iFrame", false);
        end;

        if u12.Character then
            u12.Character:SetAttribute("iFrame", false);
        end;
    end;

    v14:Play(0, 1, 1);
    local u18 = v14:GetMarkerReachedSignal("hit"):Connect(function(p16) -- Line: 164
        -- upvalues: u12 (copy), SharedUtils (ref), u1 (ref)
        if p16 == "" or not p16 then
            p16 = nil;
        end;

        u12:PlayTurnFX(p16);
        u12:ShakeCamera("SkillMedium");
        local v17 = u12.Character and u12.Character:FindFirstChild("HumanoidRootPart");

        if v17 then
            SharedUtils.PlaySoundAt(v17, u1.HitSFX, u1.HitVolume);
        end;

        u12:PlayCombatSound(u1.Skill_SFX or u12.ClassData.SwingSoundFolder or "Power_Swing_2", nil, u12.ClassData.SwingVolume or 0.5);
        u1._PerformHit(u12);
    end);
    local u19 = false;

    local function releaseState() -- Line: 183
        -- upvalues: u19 (ref), u12 (copy)
        if u19 then
            return;
        end;

        u19 = true;
        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;
    end;

    local u20 = v14:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v14.Stopped:Once(function() -- Line: 194
        -- upvalues: u19 (ref), u12 (copy), u18 (ref), u20 (copy)
        if not u19 then
            u19 = true;
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        if u12.Player then
            u12.Player:SetAttribute("iFrame", false);
        end;

        if u12.Character then
            u12.Character:SetAttribute("iFrame", false);
        end;

        if u18 then
            u18:Disconnect();
        end;

        if u20 then
            u20:Disconnect();
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 202
        -- upvalues: u19 (ref), u12 (copy), u18 (ref), u20 (copy)
        if not u19 then
            u19 = true;
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        if u12.Player then
            u12.Player:SetAttribute("iFrame", false);
        end;

        if u12.Character then
            u12.Character:SetAttribute("iFrame", false);
        end;

        if u18 then
            u18:Disconnect();
        end;

        if u20 then
            u20:Disconnect();
        end;
    end);
end;

return u1;