--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Dread_Vortex
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Dreadlord.Dread_Vortex
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local u1 = {
    AnimationName = "Ability_2",
    MaxDuration = 4,
    TotalHits = 5,
    HitboxSize = Vector3.new(30, 30, 30),
    HitboxRange = 0
};

function u1._PerformHit(p2, p3) -- Line: 45
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

function u1.Activate(u6, u7) -- Line: 67
    -- upvalues: u1 (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Dread_Vortex] Animation not found:", u1.AnimationName);

        return;
    end;

    if not u6.Character then
        return;
    end;

    u6.Is_Using_Skill = true;
    u6.Is_Attacking = true;
    local u9 = false;
    local u10 = false;

    local function deactivateVortex() -- Line: 86
        -- upvalues: u10 (ref), u6 (copy)
        if not u10 then
            return;
        end;

        u10 = false;
        local v11 = u6.FX and u6.FX.Death_Vortex;

        if v11 then
            v11:SetAttribute("FX_Activate", false);
        end;
    end;

    v8:Play(0, 1, u7.AnimSpeed or 1);
    local u12 = 0;
    local v16 = v8:GetMarkerReachedSignal("hit"):Connect(function(p13) -- Line: 101
        -- upvalues: u12 (ref), u10 (ref), u6 (copy), u7 (copy), u1 (ref)
        u12 = u12 + 1;

        if p13 == "Start" then
            u10 = true;
            local v14 = u6.FX and u6.FX.Death_Vortex;

            if v14 then
                v14:SetAttribute("FX_Activate", true);
            end;
        end;

        u6:PlayCombatSound(u7.SwingSoundFolder or u6.ClassData.SwingSoundFolder or "Flame_Swing", nil, u6.ClassData.SwingVolume or 1);
        u1._PerformHit(u6, u7);

        if u12 >= u1.TotalHits then
            if not u10 then
                return;
            end;

            u10 = false;
            local v15 = u6.FX and u6.FX.Death_Vortex;

            if v15 then
                v15:SetAttribute("FX_Activate", false);
            end;
        end;
    end);
    local v17 = v8:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 128
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    v8.Stopped:Once(function() -- Line: 133
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 137
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v16 then
        v16:Disconnect();
    end;

    if v17 then
        v17:Disconnect();
    end;

    if u10 then
        u10 = false;
        local v18 = u6.FX and u6.FX.Death_Vortex;

        if v18 then
            v18:SetAttribute("FX_Activate", false);
        end;
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;