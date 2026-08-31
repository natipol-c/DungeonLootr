--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rolling_Crescent_Hold
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Shadow Vagrant.Rolling_Crescent_Hold
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_2_Hold",
    EffectModule = "Rolling_Crescent",
    MaxDuration = 3,
    DamageMultiplier = 4,
    HitboxSize = Vector3.new(25, 40, 40),
    HitboxRange = 10,
    HitSFX = "hit_ultema_s_1",
    HitVolume = 1
};

function u1._PerformHit(p2, p3) -- Line: 56
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 69
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u7._animKey or u1.AnimationName;
    local v9 = u6.Animations[v8];

    if not v9 then
        warn("[Boss Rolling_Crescent_Hold] Animation not found:", v8);

        return;
    end;

    local Character = u6.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u6.Is_Using_Skill = true;
    u6.Is_Attacking = true;
    local u10 = false;
    local u11 = false;
    v9:Play(0, 1, u7.AnimSpeed or 1);
    local v14 = v9:GetMarkerReachedSignal("VFX"):Connect(function(p12) -- Line: 91
        -- upvalues: u6 (copy), u1 (ref)
        if not p12 or p12 == "" then
            return;
        end;

        local v13 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v13 then
            return;
        end;

        u6:PlayEffectModule(u1.EffectModule, "Emit", v13.CFrame, p12);
    end);
    local v16 = v9:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 100
        -- upvalues: u11 (ref), u6 (copy), SharedUtils (ref), u7 (copy), u1 (ref)
        if u11 then
            return;
        end;

        u11 = true;
        local v15 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v15 then
            SharedUtils.PlaySoundAt(v15, u7.HitSFX or u1.HitSFX, u7.HitVolume or u1.HitVolume);
        end;

        u1._PerformHit(u6, u7);
    end);
    v9.Stopped:Once(function() -- Line: 112
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u7.MaxDuration or u1.MaxDuration, function() -- Line: 113
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v14 then
        v14:Disconnect();
    end;

    if v16 then
        v16:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;