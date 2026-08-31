--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cross_Cut
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Azure Devil.Cross_Cut
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

    _PerformHit = function(p1, p2) -- Line: 30, Name: _PerformHit
        local v3 = p1:QueryHitbox();
        local v4 = p1:ResolveSkillDamage(p2.DamageMultiplier);

        for _, v in v3 do
            p1:ApplyDamage(v.Character, v4);
        end;
    end
};

function u5.Activate(u6, u7) -- Line: 39
    -- upvalues: u5 (copy), SharedUtils (copy)
    local v8 = u6.Animations[u5.AnimationName];

    if not v8 then
        warn("[Boss Cross_Cut] Animation not found:", u5.AnimationName);

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
    local v12 = v8:GetMarkerReachedSignal("hit"):Connect(function(p10) -- Line: 58
        -- upvalues: u7 (copy), u6 (copy), SharedUtils (ref), u5 (ref)
        u6:PlayCombatSound(u7.SwingSoundFolder or (u6.ClassData.SwingSoundFolder or "Sword_Swings"), nil, u6.ClassData.SwingVolume or 1);
        local v11 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v11 then
            SharedUtils.PlaySoundAt(v11, "Judgement_Cut", 0.6);
        end;

        if p10 == "" or not p10 then
            p10 = nil;
        end;

        u6:PlayTurnFX(p10);
        u5._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 73
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u5.MaxDuration, function() -- Line: 77
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v12 then
        v12:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u5;