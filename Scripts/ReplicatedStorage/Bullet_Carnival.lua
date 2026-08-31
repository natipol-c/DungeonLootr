--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Bullet_Carnival
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Witch Gunner.Bullet_Carnival
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.SharedUtils);
local u5 = {
    AnimationName = "Ability_2",
    MaxDuration = 2.5,
    HitboxSize = Vector3.new(35, 17, 35),
    HitboxRange = 0,
    FX_Name = "Carnival",

    _SetLoopFX = function(p1, p2, p3) -- Line: 34, Name: _SetLoopFX
        local v4 = p1.FX and p1.FX[p2];

        if v4 then
            v4:SetAttribute("Fire", p3);
        end;
    end
};

function u5._PerformHit(p6, p7) -- Line: 41
    -- upvalues: u5 (copy)
    local HitboxSize = p6.ClassData.HitboxSize;
    local Range = p6.ClassData.Range;
    p6.ClassData.HitboxSize = p7.HitboxSize or u5.HitboxSize;
    p6.ClassData.Range = p7.HitboxRange or u5.HitboxRange;
    local v8 = p6:QueryHitbox(nil, nil, 0);
    p6.ClassData.HitboxSize = HitboxSize;
    p6.ClassData.Range = Range;
    local v9 = p6:ResolveSkillDamage(p7.DamageMultiplier);

    for _, v in v8 do
        p6:ApplyDamage(v.Character, v9);
    end;
end;

function u5.Activate(u10, u11) -- Line: 61
    -- upvalues: u5 (copy)
    local v12 = u10.Animations[u5.AnimationName];

    if not v12 then
        warn("[Boss Bullet_Carnival] Animation not found:", u5.AnimationName);

        return;
    end;

    local Character = u10.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u10.Is_Using_Skill = true;
    u10.Is_Attacking = true;
    local u13 = false;
    v12:Play(0, 1, u11.AnimSpeed or 1);
    local v14 = v12:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 81
        -- upvalues: u5 (ref), u10 (copy)
        u5._SetLoopFX(u10, u5.FX_Name, true);
    end);
    local v15 = v12:GetMarkerReachedSignal("End"):Connect(function() -- Line: 86
        -- upvalues: u5 (ref), u10 (copy)
        u5._SetLoopFX(u10, u5.FX_Name, false);
    end);
    local v17 = v12:GetMarkerReachedSignal("hit"):Connect(function(p16) -- Line: 94
        -- upvalues: u11 (copy), u10 (copy), u5 (ref)
        u10:PlayCombatSound(u11.SwingSoundFolder or (u10.ClassData.SwingSoundFolder or "Gun_Shots"), nil, u10.ClassData.SwingVolume or 1);

        if p16 ~= "" then
            u10:PlayTurnFX(p16);
        end;

        u5._PerformHit(u10, u11);
    end);
    v12.Stopped:Once(function() -- Line: 105
        -- upvalues: u13 (ref)
        u13 = true;
    end);
    task.delay(u5.MaxDuration, function() -- Line: 109
        -- upvalues: u13 (ref)
        u13 = true;
    end);

    while not u13 do
        task.wait();
    end;

    if v17 then
        v17:Disconnect();
    end;

    if v14 then
        v14:Disconnect();
    end;

    if v15 then
        v15:Disconnect();
    end;

    u5._SetLoopFX(u10, u5.FX_Name, false);
    u10.Is_Using_Skill = false;
    u10.Is_Attacking = false;
end;

return u5;