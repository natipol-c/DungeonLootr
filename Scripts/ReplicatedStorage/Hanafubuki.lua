--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hanafubuki
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Zero.Hanafubuki
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_4",
    EffectModule = "Hanafubuki",
    MaxDuration = 2,
    DamageMultiplier = 1.2,
    HitboxSize = Vector3.new(24, 16, 26),
    HitboxRange = 14,
    HitSFX = "hit_ultema_s_1",
    HitVolume = 1
};

function u1._PerformHit(p2, p3) -- Line: 57
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 71
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u7._animKey or u1.AnimationName;
    local v9 = u6.Animations[v8];

    if not v9 then
        warn("[Boss Hanafubuki] Animation not found:", v8);

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
    v9:Play(0, 1, u7.AnimSpeed or 1);
    local v13 = v9:GetMarkerReachedSignal("VFX"):Connect(function(p11) -- Line: 92
        -- upvalues: u6 (copy), u1 (ref)
        if not p11 or p11 == "" then
            return;
        end;

        local v12 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v12 then
            return;
        end;

        u6:PlayEffectModule(u1.EffectModule, "Emit", v12.CFrame, p11);
    end);
    local v15 = v9:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 101
        -- upvalues: u6 (copy), SharedUtils (ref), u7 (copy), u1 (ref)
        local v14 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v14 then
            SharedUtils.PlaySoundAt(v14, u7.HitSFX or u1.HitSFX, u7.HitVolume or u1.HitVolume);
        end;

        u1._PerformHit(u6, u7);
    end);
    local v16 = v9:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 110
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    v9.Stopped:Once(function() -- Line: 113
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u7.MaxDuration or u1.MaxDuration, function() -- Line: 114
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v13 then
        v13:Disconnect();
    end;

    if v15 then
        v15:Disconnect();
    end;

    if v16 then
        v16:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;