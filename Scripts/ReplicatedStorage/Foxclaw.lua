--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Foxclaw
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Shadow Vagrant.Foxclaw
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
    AnimationName = "Ability_3",
    EffectModule = "Foxclaw",
    MaxDuration = 2.5,
    DamageMultiplier = 0.83,
    HitboxSize = Vector3.new(20, 12, 22),
    HitboxRange = 20,
    FinalHit = 6,
    FinalSFX = "claw_slam_01",
    FinalVolume = 1
};

function u1._PerformHit(p2, p3) -- Line: 47
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 60
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u7._animKey or u1.AnimationName;
    local v9 = u6.Animations[v8];

    if not v9 then
        warn("[Boss Foxclaw] Animation not found:", v8);

        return;
    end;

    local Character = u6.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local u10 = u6.ClassData.SwingSoundFolder or "Ninja";
    local u11 = u6.ClassData.SwingVolume or 1;
    u6.Is_Using_Skill = true;
    u6.Is_Attacking = true;
    local u12 = false;
    local u13 = 0;
    v9:Play(0, 1, u7.AnimSpeed or 1);
    local v16 = v9:GetMarkerReachedSignal("VFX"):Connect(function(p14) -- Line: 85
        -- upvalues: u6 (copy), u1 (ref)
        if not p14 or p14 == "" then
            return;
        end;

        local v15 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v15 then
            return;
        end;

        u6:PlayEffectModule(u1.EffectModule, "Emit", v15.CFrame, p14);
    end);
    local v18 = v9:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 94
        -- upvalues: u13 (ref), u7 (copy), u1 (ref), u6 (copy), SharedUtils (ref), u10 (copy), u11 (copy)
        u13 = u13 + 1;

        if u13 >= (u7.FinalHit or u1.FinalHit) then
            local v17 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

            if v17 then
                SharedUtils.PlaySoundAt(v17, u7.FinalSFX or u1.FinalSFX, u7.FinalVolume or u1.FinalVolume);
            end;
        else
            u6:PlayCombatSound(u10, nil, u11);
        end;

        u1._PerformHit(u6, u7);
    end);
    v9.Stopped:Once(function() -- Line: 111
        -- upvalues: u12 (ref)
        u12 = true;
    end);
    task.delay(u7.MaxDuration or u1.MaxDuration, function() -- Line: 112
        -- upvalues: u12 (ref)
        u12 = true;
    end);

    while not u12 do
        task.wait();
    end;

    if v16 then
        v16:Disconnect();
    end;

    if v18 then
        v18:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;