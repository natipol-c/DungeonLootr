--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Fists_of_Ruin
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Kage.Fists_of_Ruin
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local u1 = {
    AnimationName = "Ability_4",
    MaxDuration = 6,
    HitboxSize = Vector3.new(15, 15, 17),
    HitboxRange = 17
};

function u1._PerformHit(p2, p3, p4) -- Line: 42
    -- upvalues: u1 (copy)
    local HitboxSize = p2.ClassData.HitboxSize;
    local Range = p2.ClassData.Range;
    p2.ClassData.HitboxSize = p3.HitboxSize or u1.HitboxSize;
    p2.ClassData.Range = p3.HitboxRange or u1.HitboxRange;
    local v5 = p2:QueryHitbox();
    p2.ClassData.HitboxSize = HitboxSize;
    p2.ClassData.Range = Range;
    local v6 = p2:ResolveSkillDamage(p4);

    for _, v in v5 do
        p2:ApplyDamage(v.Character, v6);
    end;
end;

function u1.Activate(u7, u8) -- Line: 64
    -- upvalues: u1 (copy)
    local v9 = u7.Animations[u1.AnimationName];

    if not v9 then
        warn("[Boss Fists_of_Ruin] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u7.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u7.Is_Using_Skill = true;
    u7.Is_Attacking = true;
    local u10 = false;
    local u11 = u8.FinalDamageMultiplier or u8.DamageMultiplier;
    v9:Play(0, 1, u8.AnimSpeed or 1);
    local v13 = v9:GetMarkerReachedSignal("hit"):Connect(function(p12) -- Line: 88
        -- upvalues: u8 (copy), u7 (copy), u1 (ref)
        u7:PlayCombatSound(u8.SwingSoundFolder or (u7.ClassData.SwingSoundFolder or "Magic_Swings"), nil, u7.ClassData.SwingVolume or 1);

        if p12 == "" or not p12 then
            p12 = nil;
        end;

        u7:PlayTurnFX(p12);
        u1._PerformHit(u7, u8, u8.DamageMultiplier);
    end);
    local v15 = v9:GetMarkerReachedSignal("final_hit"):Connect(function(p14) -- Line: 97
        -- upvalues: u8 (copy), u7 (copy), u1 (ref), u11 (copy)
        u7:PlayCombatSound(u8.SwingSoundFolder or (u7.ClassData.SwingSoundFolder or "Magic_Swings"), nil, u7.ClassData.SwingVolume or 1);

        if p14 == "" or not p14 then
            p14 = nil;
        end;

        u7:PlayTurnFX(p14);
        u1._PerformHit(u7, u8, u11);
    end);
    v9.Stopped:Once(function() -- Line: 105
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 109
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

    u7.Is_Using_Skill = false;
    u7.Is_Attacking = false;
end;

return u1;