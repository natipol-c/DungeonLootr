--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Thousandfold_Thrust
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Founder.Thousandfold_Thrust
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:34 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    AnimationName = "Ability_2",
    EffectModule = "Thousandfold_Thrust",
    MaxDuration = 2.7,
    DamageMultiplier = 1.2,
    HitboxSize = Vector3.new(28, 20, 30),
    HitboxRange = 25
};

function u1._PerformHit(p2, p3) -- Line: 24
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 34
    -- upvalues: u1 (copy)
    local u8 = u6.Animations[u1.AnimationName];

    if not u8 then
        warn("[Boss Thousandfold_Thrust] Animation not found:", u1.AnimationName);

        return;
    end;

    local v9 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

    if not v9 then
        return;
    end;

    u6.Is_Using_Skill = true;
    u6.Is_Attacking = true;
    local u10 = false;
    u8:Play(0, 1, u7.AnimSpeed or 1);
    local u11 = {};

    local function bindVFX(p12) -- Line: 51
        -- upvalues: u11 (copy), u8 (copy), u6 (copy), u1 (ref)
        u11[#u11 + 1] = u8:GetMarkerReachedSignal(p12):Connect(function(p13) -- Line: 52
            -- upvalues: u6 (ref), u1 (ref)
            if not p13 or p13 == "" then
                return;
            end;

            local v14 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

            if not v14 then
                return;
            end;

            u6:PlayEffectModule(u1.EffectModule, "Emit", v14.CFrame, p13);
        end);
    end;

    u11[#u11 + 1] = u8:GetMarkerReachedSignal("VFX"):Connect(function(p15) -- Line: 52
        -- upvalues: u6 (copy), u1 (ref)
        if not p15 or p15 == "" then
            return;
        end;

        local v16 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v16 then
            return;
        end;

        u6:PlayEffectModule(u1.EffectModule, "Emit", v16.CFrame, p15);
    end);
    u11[#u11 + 1] = u8:GetMarkerReachedSignal("VFX_2"):Connect(function(p17) -- Line: 52
        -- upvalues: u6 (copy), u1 (ref)
        if not p17 or p17 == "" then
            return;
        end;

        local v18 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v18 then
            return;
        end;

        u6:PlayEffectModule(u1.EffectModule, "Emit", v18.CFrame, p17);
    end);
    u11[#u11 + 1] = u8:GetMarkerReachedSignal("VFX_3"):Connect(function(p19) -- Line: 52
        -- upvalues: u6 (copy), u1 (ref)
        if not p19 or p19 == "" then
            return;
        end;

        local v20 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v20 then
            return;
        end;

        u6:PlayEffectModule(u1.EffectModule, "Emit", v20.CFrame, p19);
    end);
    u11[#u11 + 1] = u8:GetMarkerReachedSignal("VFX_4"):Connect(function(p21) -- Line: 52
        -- upvalues: u6 (copy), u1 (ref)
        if not p21 or p21 == "" then
            return;
        end;

        local v22 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v22 then
            return;
        end;

        u6:PlayEffectModule(u1.EffectModule, "Emit", v22.CFrame, p21);
    end);
    u11[#u11 + 1] = u8:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 61
        -- upvalues: u6 (copy), u7 (copy), u1 (ref)
        u6:PlayCombatSound(u7.SwingSoundFolder or (u6.ClassData.SwingSoundFolder or "Flame_Swing"), nil, u6.ClassData.SwingVolume or 1);
        u1._PerformHit(u6, u7);
    end);
    u8.Stopped:Once(function() -- Line: 70
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u7.MaxDuration or u1.MaxDuration, function() -- Line: 71
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    for _, v in u11 do
        v:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;