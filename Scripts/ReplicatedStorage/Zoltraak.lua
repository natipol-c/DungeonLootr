--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Zoltraak
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Demonbane.Zoltraak
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    AnimationName = "Ability_1",
    MaxDuration = 1.5,
    HitboxSize = Vector3.new(22, 18, 40),
    HitboxRange = 35,
    BlastFX = "Ability_1"
};

function u1._PerformHit(p2, p3) -- Line: 40
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 56
    -- upvalues: u1 (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Zoltraak] Animation not found:", u1.AnimationName);

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
    local v10 = v8:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 78
        -- upvalues: u7 (copy), u6 (copy), u1 (ref)
        u6:PlayCombatSound(u7.SwingSoundFolder or u6.ClassData.SwingSoundFolder or "Magic_Shoot", nil, u6.ClassData.SwingVolume or 1);
        u6:PlayTurnFX(u1.BlastFX);
        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 87
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 91
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v10 then
        v10:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;