--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rose Cataclysm
  Path:     game.ReplicatedStorage.Classes.Dreadlord.Skills.Rose Cataclysm
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:55 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    OpenerDamageMult = 0.4,
    OpenerHitboxSize = Vector3.new(20, 20, 30),
    OpenerHitboxRange = 20,
    ExplosionDamageMult = 0.92,
    MaxDuration = 5
};

function u1._EnsureAnimation(p2) -- Line: 57
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

function u1._PerformOpenerHit(p7) -- Line: 84
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.OpenerHitboxSize;
    p7.ClassData.Range = u1.OpenerHitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.OpenerDamageMult, v)));
        end;
    end;
end;

function u1._PerformExplosionHit(p9) -- Line: 107
    -- upvalues: u1 (copy)
    local HitboxSize = p9.ClassData.HitboxSize;
    p9.ClassData.HitboxSize = HitboxSize * 3;
    local v10 = p9:Hitbox();
    p9.ClassData.HitboxSize = HitboxSize;
    local v11 = 0;

    for _, v in v10 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p9:ApplyDamage(v, (p9:ResolveSkillDamage(u1.ExplosionDamageMult, v)));
            v11 = v11 + 1;
        end;
    end;

    return v11;
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
        warn("[Rose Cataclysm] Animation not found");

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
    local u16 = false;

    local function disableRoseCharge() -- Line: 166
        -- upvalues: u16 (ref), u13 (copy)
        if not u16 then
            return;
        end;

        u16 = false;
        u13:SetLoopFX("Rose_Charge", false);
    end;

    local u18 = v15:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 174
        -- upvalues: u16 (ref), u13 (copy), SharedUtils (ref)
        u16 = true;
        u13:SetLoopFX("Rose_Charge", true);
        local v17 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v17 then
            SharedUtils.PlaySoundAt(v17, "spark_impact", 1);
        end;
    end);
    local u20 = v15:GetMarkerReachedSignal("End"):Connect(function() -- Line: 186
        -- upvalues: u16 (ref), u13 (copy), SharedUtils (ref)
        if u16 then
            u16 = false;
            u13:SetLoopFX("Rose_Charge", false);
        end;

        local v19 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v19 then
            SharedUtils.PlaySoundAt(v19, "Water_Bass", 1);
        end;
    end);
    local u21 = 0;
    local u24 = v15:GetMarkerReachedSignal("hit"):Connect(function(p22) -- Line: 198
        -- upvalues: u21 (ref), u1 (ref), u13 (copy), SharedUtils (ref)
        u21 = u21 + 1;

        if u21 == 1 then
            u13:PlayCombatSound(u1.Skill_SFX or u13.ClassData.SwingSoundFolder or "Flame_Swing", nil, u13.ClassData.SwingVolume or 1);
            u1._PerformOpenerHit(u13);
            u13:ShakeCamera("Hit");

            return;
        end;

        if type(p22) ~= "string" or p22 == "" then
            warn("[Rose Cataclysm] Hit " .. u21 .. " missing Explosion param");

            return;
        end;

        u13:PlayFX(p22);
        local v23 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v23 then
            SharedUtils.PlaySoundAt(v23, "anime_explode", 1);
        end;

        u1._PerformExplosionHit(u13);
        u13:ShakeCamera("Hit");
    end);
    v15.Stopped:Once(function() -- Line: 230
        -- upvalues: u24 (ref), u18 (ref), u20 (ref), u16 (ref), u13 (copy)
        if u24 then
            u24:Disconnect();
        end;

        if u18 then
            u18:Disconnect();
        end;

        if u20 then
            u20:Disconnect();
        end;

        if u16 then
            u16 = false;
            u13:SetLoopFX("Rose_Charge", false);
        end;

        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 242
        -- upvalues: u24 (ref), u18 (ref), u20 (ref), u16 (ref), u13 (copy)
        if u24 then
            u24:Disconnect();
        end;

        if u18 then
            u18:Disconnect();
        end;

        if u20 then
            u20:Disconnect();
        end;

        if u16 then
            u16 = false;
            u13:SetLoopFX("Rose_Charge", false);
        end;

        if u13.Is_Using_Skill then
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;
    end);
end;

return u1;