--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Vollzanbel
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Demonbane.Vollzanbel
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    AnimationName = "Ability_2",
    MaxDuration = 3,
    HitboxSize = Vector3.new(25, 20, 30),
    HitboxRange = 30,
    StartFX = "Ability_2_Start",
    PillarFX = "Ability_2"
};

function u1._PerformHit(p2, p3) -- Line: 45
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

local function setPillar(p6, p7) -- Line: 58
    -- upvalues: u1 (copy)
    local v8 = p6.FX and p6.FX[u1.PillarFX];

    if v8 then
        v8:SetAttribute("FX_Activate", p7);
    end;
end;

function u1.Activate(u9, u10) -- Line: 68
    -- upvalues: u1 (copy)
    local v11 = u9.Animations[u1.AnimationName];

    if not v11 then
        warn("[Boss Vollzanbel] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u9.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u9.Is_Using_Skill = true;
    u9.Is_Attacking = true;
    local u12 = false;
    v11:Play(0, 1, u10.AnimSpeed or 1);
    local v13 = {
        [#v13 + 1] = v11:GetMarkerReachedSignal("start"):Connect(function() -- Line: 91
            -- upvalues: u10 (copy), u9 (copy), u1 (ref)
            u9:PlayCombatSound(u10.SwingSoundFolder or u9.ClassData.SwingSoundFolder or "Magic_Shoot", nil, u9.ClassData.SwingVolume or 1);
            u9:PlayTurnFX(u1.StartFX);
        end)
    };
    local u14 = 0;
    v13[#v13 + 1] = v11:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 99
        -- upvalues: u14 (ref), u9 (copy), u1 (ref), u10 (copy)
        u14 = u14 + 1;

        if u14 == 1 then
            local v15 = u9;
            local v16 = v15.FX and v15.FX[u1.PillarFX];

            if v16 then
                v16:SetAttribute("FX_Activate", true);
            end;
        end;

        u1._PerformHit(u9, u10);
    end);
    v13[#v13 + 1] = v11:GetMarkerReachedSignal("end"):Connect(function() -- Line: 108
        -- upvalues: u9 (copy), u1 (ref)
        local v17 = u9;
        local v18 = v17.FX and v17.FX[u1.PillarFX];

        if v18 then
            v18:SetAttribute("FX_Activate", false);
        end;
    end);
    v11.Stopped:Once(function() -- Line: 113
        -- upvalues: u12 (ref)
        u12 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 117
        -- upvalues: u12 (ref)
        u12 = true;
    end);

    while not u12 do
        task.wait();
    end;

    for _, v in v13 do
        v:Disconnect();
    end;

    local v19 = u9.FX and u9.FX[u1.PillarFX];

    if v19 then
        v19:SetAttribute("FX_Activate", false);
    end;

    u9.Is_Using_Skill = false;
    u9.Is_Attacking = false;
end;

return u1;