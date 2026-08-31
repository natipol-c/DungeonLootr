--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Catastravia
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Demonbane.Catastravia
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    AnimationName = "Ability_4",
    MaxDuration = 3,
    FieldFX = "Ability_4",
    FieldDuration = 2,
    TickInterval = 0.15,
    HitboxSize = Vector3.new(24, 22, 60),
    HitboxRange = 55
};

function u1._PerformTick(p2, p3, p4) -- Line: 44
    -- upvalues: u1 (copy)
    for _, v in p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange) do
        p2:ApplyDamage(v.Character, p4);
    end;
end;

local function setField(p5, p6) -- Line: 55
    -- upvalues: u1 (copy)
    local v7 = p5.FX and p5.FX[u1.FieldFX];

    if v7 then
        v7:SetAttribute("FX_Activate", p6);
    end;
end;

function u1.Activate(u8, u9) -- Line: 65
    -- upvalues: u1 (copy)
    local v10 = u8.Animations[u1.AnimationName];

    if not v10 then
        warn("[Boss Catastravia] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u8.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u8.Is_Using_Skill = true;
    u8.Is_Attacking = true;
    local u11 = false;
    v10:Play(0, 1, u9.AnimSpeed or 1);
    local u12 = false;
    local v21 = v10:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 88
        -- upvalues: u12 (ref), u8 (copy), u1 (ref), u9 (copy), u11 (ref)
        if u12 then
            return;
        end;

        u12 = true;
        local v13 = u8;
        local v14 = v13.FX and v13.FX[u1.FieldFX];

        if v14 then
            v14:SetAttribute("FX_Activate", true);
        end;

        u8:PlayCombatSound(u9.SwingSoundFolder or u8.ClassData.SwingSoundFolder or "Magic_Shoot", nil, u8.ClassData.SwingVolume or 1);
        local u15 = u9.FieldDuration or u1.FieldDuration;
        local u16 = u9.TickInterval or u1.TickInterval;
        local u17 = u8:ResolveSkillDamage(u9.DamageMultiplier);
        task.spawn(function() -- Line: 101
            -- upvalues: u15 (copy), u16 (copy), u8 (ref), u1 (ref), u9 (ref), u17 (copy), u11 (ref)
            local math_floor_ret = math.floor(u15 / u16);

            for i = 1, math_floor_ret do
                if not (u8.Character and u8.Character.Parent) then
                    break;
                end;

                u1._PerformTick(u8, u9, u17);
                local v18;

                if i < math_floor_ret then
                    task.wait(u16);
                    v18 = i;
                else
                    v18 = i;
                end;
            end;

            local v19 = u8;
            local v20 = v19.FX and v19.FX[u1.FieldFX];

            if v20 then
                v20:SetAttribute("FX_Activate", false);
            end;

            u11 = true;
        end);
    end);
    v10.Stopped:Once(function() -- Line: 117
        -- upvalues: u12 (ref), u11 (ref)
        if not u12 then
            u11 = true;
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 124
        -- upvalues: u11 (ref)
        u11 = true;
    end);

    while not u11 do
        task.wait();
    end;

    if v21 then
        v21:Disconnect();
    end;

    local v22 = u8.FX and u8.FX[u1.FieldFX];

    if v22 then
        v22:SetAttribute("FX_Activate", false);
    end;

    u8.Is_Using_Skill = false;
    u8.Is_Attacking = false;
end;

return u1;