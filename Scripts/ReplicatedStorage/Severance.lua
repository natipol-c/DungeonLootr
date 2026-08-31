--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Severance
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Azure Devil.Severance
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:34 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_2",
    MaxDuration = 2,
    HitboxSize = Vector3.new(26, 10, 29),
    HitboxRange = 29
};

function u1._PerformHit(p2, p3) -- Line: 36
    -- upvalues: u1 (copy)
    local HitboxSize = p2.ClassData.HitboxSize;
    local Range = p2.ClassData.Range;
    p2.ClassData.HitboxSize = p3.HitboxSize or u1.HitboxSize;
    p2.ClassData.Range = p3.HitboxRange or u1.HitboxRange;
    local v4 = p2:QueryHitbox();
    p2.ClassData.HitboxSize = HitboxSize;
    p2.ClassData.Range = Range;
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 55
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u7._animKey or u1.AnimationName;
    local v9 = u6.Animations[v8];

    if not v9 then
        warn("[Boss Severance] Animation not found:", v8);

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
    SharedUtils.PlaySoundAt(Character, "Dark_Echo", 1);
    u6:PlayCombatSound("Magic_Swings", nil, 1);
    local v11 = v9:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 80
        -- upvalues: u6 (copy), u1 (ref), u7 (copy)
        u6:PlayTurnFX("Explosion");
        u1._PerformHit(u6, u7);
    end);
    v9.Stopped:Once(function() -- Line: 85
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 89
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v11 then
        v11:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;