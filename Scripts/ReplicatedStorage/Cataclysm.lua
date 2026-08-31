--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cataclysm
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Greatsword.Cataclysm
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
    AnimationName = "Ability_4",
    MaxDuration = 3,
    HitboxSize = Vector3.new(20, 10, 20),
    HitboxRange = 20
};

function u1._PerformHit(p2, p3) -- Line: 41
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

function u1.Activate(u6, u7) -- Line: 66
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Cataclysm] Animation not found:", u1.AnimationName);

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
    v8:Play(0, 1, u7.AnimSpeed or 0.85);
    local v11 = v8:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 88
        -- upvalues: u6 (copy), SharedUtils (ref), u1 (ref), u7 (copy)
        u6:PlayTurnFX("Slam");
        local v10 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v10 then
            SharedUtils.PlaySoundAt(v10, "Earth_Hammer_2", 2);
        end;

        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 103
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 108
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v11 then
        v11:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;