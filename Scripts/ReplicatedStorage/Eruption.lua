--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Eruption
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Greatsword.Eruption
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:34 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u5 = {
    AnimationName = "Ability_2",
    MaxDuration = 2.5,

    _PerformHit = function(p1, p2) -- Line: 36, Name: _PerformHit
        local v3 = p1:QueryHitbox();
        local v4 = p1:ResolveSkillDamage(p2.DamageMultiplier);

        for _, v in v3 do
            p1:ApplyDamage(v.Character, v4);
        end;
    end
};

function u5.Activate(u6, u7) -- Line: 48
    -- upvalues: u5 (copy), SharedUtils (copy)
    local v8 = u6.Animations[u5.AnimationName];

    if not v8 then
        warn("[Boss Eruption] Animation not found:", u5.AnimationName);

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
    local u10 = 0;
    local v13 = v8:GetMarkerReachedSignal("hit"):Connect(function(p11) -- Line: 71
        -- upvalues: u10 (ref), u7 (copy), u6 (copy), SharedUtils (ref), u5 (ref)
        u10 = u10 + 1;
        u6:PlayCombatSound(u7.SwingSoundFolder or (u6.ClassData.SwingSoundFolder or "Sword_Swing"), nil, u6.ClassData.SwingVolume or 1);

        if u10 == 2 then
            u6:PlayTurnFX("Eruption");
            local v12 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

            if v12 then
                SharedUtils.PlaySoundAt(v12, "Earth_Hammer_2", 2);
            end;
        else
            if p11 == "" or not p11 then
                p11 = nil;
            end;

            u6:PlayTurnFX(p11);
        end;

        if u10 == 2 then
            u5._PerformHit(u6, u7);
        end;
    end);
    v8.Stopped:Once(function() -- Line: 97
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u5.MaxDuration, function() -- Line: 102
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v13 then
        v13:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u5;