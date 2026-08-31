--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Playful_Cloud_Heat
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Unrestricted.Playful_Cloud_Heat
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_3_Special",
    MaxDuration = 3.5,
    HitboxSize = Vector3.new(22, 22, 48),
    HitboxRange = 48,
    HitSFX = { "claw_crosscut_01", "claw_crosscut_03", "claw_crosscut_04", "claw_slam_01" }
};

function u1._PerformHit(p2, p3) -- Line: 61
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 76
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Playful_Cloud_Heat] Animation not found:", u1.AnimationName);

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
    local u9 = false;
    v8:Play(0, 1, u7.AnimSpeed or 1);
    local u10 = 0;
    local v14 = v8:GetMarkerReachedSignal("hit"):Connect(function(p11) -- Line: 99
        -- upvalues: u10 (ref), u1 (ref), u6 (copy), SharedUtils (ref), u7 (copy)
        u10 = u10 + 1;
        local v12 = u1.HitSFX[u10];
        local v13 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v12 and v13 then
            SharedUtils.PlaySoundAt(v13, v12, u6.ClassData.SwingVolume or 1);
        end;

        if p11 == "" or not p11 then
            p11 = nil;
        end;

        u6:PlayTurnFX(p11);
        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 121
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 126
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v14 then
        v14:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;