--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Twin_Strike
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Founder.Twin_Strike
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:34 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local u1 = {
    AnimationName = "Ability_3",
    MaxDuration = 2.5,
    HitboxSize = Vector3.new(30, 20, 30),
    HitboxRange = 25
};

function u1._PerformHit(p2, p3) -- Line: 35
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

function u1.Activate(u6, u7) -- Line: 57
    -- upvalues: u1 (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Twin_Strike] Animation not found:", u1.AnimationName);

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
    local v12 = v8:GetMarkerReachedSignal("hit"):Connect(function(p11) -- Line: 80
        -- upvalues: u10 (ref), u7 (copy), u6 (copy), u1 (ref)
        u10 = u10 + 1;
        u6:PlayCombatSound(u7.SwingSoundFolder or u6.ClassData.SwingSoundFolder or "Flame_Swing", nil, u6.ClassData.SwingVolume or 1);

        if u10 == 1 then
            u6:PlayTurnFX("Mega_Reverse_Slash");
        elseif u10 == 2 then
            u6:PlayTurnFX("Mega_Side_Slash");
        end;

        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 98
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 102
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v12 then
        v12:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;