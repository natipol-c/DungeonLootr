--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Blazing_Reach
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Flame Bastion.Blazing_Reach
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
    AnimationName = "Ability_2",
    MaxDuration = 2,
    HitboxSize = Vector3.new(20, 10, 30),
    HitboxRange = 25
};

function u1._PerformHit(p2, p3) -- Line: 40
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

function u1.Activate(u6, u7) -- Line: 64
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Blazing_Reach] Animation not found:", u1.AnimationName);

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
    local v11 = v8:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 86
        -- upvalues: u6 (copy), SharedUtils (ref), u1 (ref), u7 (copy)
        u6:PlayTurnFX("Reverse_Slash");
        local v10 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v10 then
            SharedUtils.PlaySoundAt(v10, "Flame_Swing", 1);
        end;

        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 101
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 106
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