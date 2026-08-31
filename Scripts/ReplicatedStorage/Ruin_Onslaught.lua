--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ruin_Onslaught
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Oathbreaker.Ruin_Onslaught
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_2",
    MaxDuration = 3.5,
    HitboxSize = Vector3.new(15, 10, 17),
    HitboxRange = 10,
    BarrageTicks = 5,
    BarrageInterval = 0.12,
    BarrageMultiplier = 1.1,
    FXFallbackDuration = 3.5
};

function u1._PerformHit(p2, p3, p4) -- Line: 57
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

function u1.Activate(u7, u8) -- Line: 79
    -- upvalues: u1 (copy)
    local v9 = u7.Animations[u1.AnimationName];

    if not v9 then
        warn("[Boss Ruin_Onslaught] Animation not found:", u1.AnimationName);

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
    local u11 = false;
    local u12 = u7.FX and u7.FX.Front_Explosion;
    v9:Play(0, 1, u8.AnimSpeed or 1);
    local u13 = 0;
    local v18 = v9:GetMarkerReachedSignal("hit"):Connect(function(p14) -- Line: 106
        -- upvalues: u13 (ref), u8 (copy), u7 (copy), u1 (ref), u12 (copy), u11 (ref)
        u13 = u13 + 1;
        local v15 = u8.SwingSoundFolder or (u7.ClassData.SwingSoundFolder or "Flame_Swing");
        u7:PlayCombatSound(v15, nil, u7.ClassData.SwingVolume or 1);

        if p14 == "" or not p14 then
            p14 = nil;
        end;

        u7:PlayTurnFX(p14);

        if u13 <= 2 then
            u1._PerformHit(u7, u8, u8.DamageMultiplier);

            return;
        end;

        if u12 and not u11 then
            u12:SetAttribute("FX_Activate", true);
            u11 = true;
            task.delay(u1.FXFallbackDuration, function() -- Line: 126
                -- upvalues: u11 (ref), u12 (ref)
                if u11 then
                    u12:SetAttribute("FX_Activate", false);
                    u11 = false;
                end;
            end);
        end;

        local v16 = u8.BarrageInterval or u1.BarrageInterval;
        local v17 = u8.BarrageMultiplier or u1.BarrageMultiplier;

        for i = 1, u8.BarrageTicks or u1.BarrageTicks do
            if i > 1 then
                task.wait(v16);
            end;

            if not u7.Is_Using_Skill then
                break;
            end;

            u7:PlayCombatSound(v15, nil, u7.ClassData.SwingVolume or 1);
            u1._PerformHit(u7, u8, v17);
            local _ = i;
        end;
    end);
    local v19 = v9:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 153
        -- upvalues: u11 (ref), u12 (copy)
        if u11 and u12 then
            u12:SetAttribute("FX_Activate", false);
            u11 = false;
        end;
    end);
    v9.Stopped:Once(function() -- Line: 161
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 166
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v18 then
        v18:Disconnect();
    end;

    if v19 then
        v19:Disconnect();
    end;

    if u11 then
        if u12 then
            u12:SetAttribute("FX_Activate", false);
        end;

        u11 = false;
    end;

    u7.Is_Using_Skill = false;
    u7.Is_Attacking = false;
end;

return u1;