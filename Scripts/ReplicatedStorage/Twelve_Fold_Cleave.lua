--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Twelve_Fold_Cleave
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Anti Magic.Twelve_Fold_Cleave
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u6 = {
    AnimationName = "Ability_2",
    MaxDuration = 4,
    MainMultiplier = 1.8,
    FinisherMultiplier = 1.6,

    _PerformHit = function(p1, p2, p3) -- Line: 46, Name: _PerformHit
        local v4 = p1:QueryHitbox(p2.HitboxSize, p2.HitboxRange);
        local v5 = p1:ResolveSkillDamage(p3);

        for _, v in v4 do
            p1:ApplyDamage(v.Character, v5);
        end;
    end
};

function u6.Activate(u7, u8) -- Line: 61
    -- upvalues: u6 (copy), SharedUtils (copy)
    local v9 = u7.Animations[u6.AnimationName];

    if not v9 then
        warn("[Boss Twelve_Fold_Cleave] Animation not found:", u6.AnimationName);

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
    local u11 = u8.DamageMultiplier or u6.MainMultiplier;
    local u12 = u8.FinisherMultiplier or u6.FinisherMultiplier;
    v9:Play(0, 1, u8.AnimSpeed or 1);
    local u13 = 0;
    local v17 = v9:GetMarkerReachedSignal("hit"):Connect(function(p14) -- Line: 88
        -- upvalues: u13 (ref), u8 (copy), u7 (copy), SharedUtils (ref), u11 (copy), u12 (copy), u6 (ref)
        u13 = u13 + 1;
        u7:PlayCombatSound(u8.SwingSoundFolder or (u7.ClassData.SwingSoundFolder or "Power_Swing"), nil, u7.ClassData.SwingVolume or 1);

        if u13 == 10 then
            local v15 = u7.Character and u7.Character:FindFirstChild("HumanoidRootPart");

            if v15 then
                SharedUtils.PlaySoundAt(v15, "Electric Explosion 2", 1);
            end;
        end;

        if p14 == "" or not p14 then
            p14 = nil;
        end;

        u7:PlayTurnFX(p14);
        local v16;

        if u13 <= 9 then
            v16 = u11;
        else
            v16 = u12;
        end;

        u6._PerformHit(u7, u8, v16);
    end);
    v9.Stopped:Once(function() -- Line: 112
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u6.MaxDuration, function() -- Line: 117
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v17 then
        v17:Disconnect();
    end;

    u7.Is_Using_Skill = false;
    u7.Is_Attacking = false;
end;

return u6;