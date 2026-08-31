--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Crescent Ember
  Path:     game.ReplicatedStorage.Classes.Hollow.Skills.Crescent Ember
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:00 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 7,
    MaxCharges = 2,
    DamageMultiplier = 6.5,
    AnimationName = "Ability_2",
    EffectModule = "Crescent_Ember",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(24, 14, 26),
    HitboxRange = 22,
    DodgeDuration = 0.9,
    WindupParam = "Spin",
    WindupSFX = "Fire_Woosh",
    HitSFX = "HardHit_1",
    MaxDuration = 1.6
};

function u1._EnsureAnimation(p2) -- Line: 52
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

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
        end;
    end;
end;

function u1.CanActivate(p9) -- Line: 100
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

function u1.Activate(u10, p11) -- Line: 108
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v12 = u1._EnsureAnimation(u10);

    if not v12 then
        warn("[Crescent Ember] Animation not found");

        return;
    end;

    local Character = u10.Character;
    local v13;

    if Character then
        v13 = Character:FindFirstChild("HumanoidRootPart");
    else
        v13 = Character;
    end;

    if not v13 then
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
    local u14 = {};

    local function disconnectAll() -- Line: 134
        -- upvalues: u14 (copy)
        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end;

    local u15 = false;

    local function cleanup() -- Line: 140
        -- upvalues: u15 (ref), u10 (copy), Character (copy), u14 (copy)
        if u15 then
            return;
        end;

        u15 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;

        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end;

    u14[#u14 + 1] = v12:GetMarkerReachedSignal("VFX"):Connect(function(p16) -- Line: 152
        -- upvalues: u10 (copy), u1 (ref), Character (copy), SharedUtils (ref)
        if not p16 or p16 == "" then
            return;
        end;

        local v17 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if not v17 then
            return;
        end;

        if p16 == u1.WindupParam then
            Character:SetAttribute("Dodge", true);
            task.delay(u1.DodgeDuration, function() -- Line: 160
                -- upvalues: Character (ref)
                if Character then
                    Character:SetAttribute("Dodge", false);
                end;
            end);
            SharedUtils.PlaySoundAt(v17, u1.WindupSFX, 0.85);
            u10:ShakeCamera("SkillMedium");
        end;

        u10:PlayEffectModule(u1.EffectModule, "Emit", v17.CFrame, p16);
    end);
    u14[#u14 + 1] = v12:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 172
        -- upvalues: u10 (copy), SharedUtils (ref), u1 (ref)
        local v18 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if v18 then
            SharedUtils.PlaySoundAt(v18, u1.HitSFX, 0.9);
        end;

        u10:ShakeCamera("SkillHeavy");
        u1._PerformHit(u10);
    end);
    u14[#u14 + 1] = v12:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v12.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, cleanup);
end;

return u1;