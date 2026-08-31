--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ashen_Onslaught
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Flame Bastion.Ashen_Onslaught
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
    AnimationName = "Ability_4",
    MaxDuration = 3.5,
    HitboxSize = Vector3.new(22, 10, 22),
    HitboxRange = 18,
    BarrageTicks = 5,
    BarrageInterval = 0.12,
    BarrageMultiplier = 0.9
};

function u1._PerformHit(p2, p3, p4) -- Line: 50
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

function u1.Activate(u7, u8) -- Line: 74
    -- upvalues: u1 (copy)
    local v9 = u7.Animations[u1.AnimationName];

    if not v9 then
        warn("[Boss Ashen_Onslaught] Animation not found:", u1.AnimationName);

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
    v9:Play(0, 1, u8.AnimSpeed or 1);
    local u11 = 0;
    local v16 = v9:GetMarkerReachedSignal("hit"):Connect(function(p12) -- Line: 97
        -- upvalues: u11 (ref), u8 (copy), u7 (copy), u1 (ref)
        u11 = u11 + 1;
        local v13 = u8.SwingSoundFolder or (u7.ClassData.SwingSoundFolder or "Flame_Swing");
        u7:PlayCombatSound(v13, nil, u7.ClassData.SwingVolume or 0.5);

        if p12 == "" or not p12 then
            p12 = nil;
        end;

        u7:PlayTurnFX(p12);

        if u11 <= 2 then
            u1._PerformHit(u7, u8, u8.DamageMultiplier);

            return;
        end;

        local v14 = u8.BarrageInterval or u1.BarrageInterval;
        local v15 = u8.BarrageMultiplier or u1.BarrageMultiplier;

        for i = 1, u8.BarrageTicks or u1.BarrageTicks do
            if i > 1 then
                task.wait(v14);
            end;

            if not u7.Is_Using_Skill then
                break;
            end;

            u7:PlayCombatSound(v13, nil, u7.ClassData.SwingVolume or 0.5);
            u1._PerformHit(u7, u8, v15);
            local _ = i;
        end;
    end);
    v9.Stopped:Once(function() -- Line: 129
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 134
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v16 then
        v16:Disconnect();
    end;

    u7.Is_Using_Skill = false;
    u7.Is_Attacking = false;
end;

return u1;