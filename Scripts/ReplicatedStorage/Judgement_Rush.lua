--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Judgement_Rush
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Azure Devil.Judgement_Rush
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
    AnimationName = "Ability_4",
    MaxDuration = 7,
    FinalHitboxSize = Vector3.new(20, 12, 20),
    FinalHitboxRange = 20,

    _PerformHit = function(p1, p2) -- Line: 37, Name: _PerformHit
        local v3 = p1:QueryHitbox();
        local v4 = p1:ResolveSkillDamage(p2.DamageMultiplier);

        for _, v in v3 do
            p1:ApplyDamage(v.Character, v4);
        end;
    end
};

function u5._PerformFinalHit(p6, p7) -- Line: 47
    -- upvalues: u5 (copy)
    local HitboxSize = p6.ClassData.HitboxSize;
    local Range = p6.ClassData.Range;
    p6.ClassData.HitboxSize = p7.FinalHitboxSize or u5.FinalHitboxSize;
    p6.ClassData.Range = p7.FinalHitboxRange or u5.FinalHitboxRange;
    local v8 = p6:QueryHitbox();
    p6.ClassData.HitboxSize = HitboxSize;
    p6.ClassData.Range = Range;
    local v9 = p6:ResolveSkillDamage(p7.FinalMultiplier or p7.DamageMultiplier);

    for _, v in v8 do
        p6:ApplyDamage(v.Character, v9);
    end;
end;

function u5.Activate(u10, u11) -- Line: 66
    -- upvalues: u5 (copy), SharedUtils (copy)
    local v12 = u10.Animations[u5.AnimationName];

    if not v12 then
        warn("[Boss Judgement_Rush] Animation not found:", u5.AnimationName);

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
    local v14 = {};
    v12:Play(0, 1, u11.AnimSpeed or 1);
    v14[#v14 + 1] = v12:GetMarkerReachedSignal("hit"):Connect(function(p15) -- Line: 86
        -- upvalues: u11 (copy), u10 (copy), u5 (ref)
        u10:PlayCombatSound(u11.SwingSoundFolder or (u10.ClassData.SwingSoundFolder or "Sword_Swings"), nil, u10.ClassData.SwingVolume or 1);

        if p15 == "" or not p15 then
            p15 = nil;
        end;

        u10:PlayTurnFX(p15);
        u5._PerformHit(u10, u11);
    end);
    v14[#v14 + 1] = v12:GetMarkerReachedSignal("charging"):Connect(function() -- Line: 94
        -- upvalues: u10 (copy), SharedUtils (ref)
        local v16 = u10.FX and u10.FX.Charge;

        if v16 then
            v16:SetAttribute("FX_Activate", true);
        end;

        local v17 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if v17 then
            SharedUtils.PlaySoundAt(v17, "magic_black_spell_39", 2);
        end;
    end);
    v14[#v14 + 1] = v12:GetMarkerReachedSignal("release"):Connect(function() -- Line: 107
        -- upvalues: u10 (copy), SharedUtils (ref), u5 (ref), u11 (copy)
        local v18 = u10.FX and u10.FX.Charge;

        if v18 then
            v18:SetAttribute("FX_Activate", false);
        end;

        local v19 = u10.FX and u10.FX.Final_Slash;

        if v19 then
            v19:SetAttribute("Fire", not v19:GetAttribute("Fire"));
        end;

        local v20 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            SharedUtils.PlaySoundAt(v20, "Dark_Echo", 5);
        end;

        u5._PerformFinalHit(u10, u11);
    end);
    v12.Stopped:Once(function() -- Line: 131
        -- upvalues: u13 (ref)
        u13 = true;
    end);
    task.delay(u5.MaxDuration, function() -- Line: 135
        -- upvalues: u13 (ref)
        u13 = true;
    end);

    while not u13 do
        task.wait();
    end;

    for _, v in v14 do
        v:Disconnect();
    end;

    local v21 = u10.FX and u10.FX.Charge;

    if v21 then
        v21:SetAttribute("FX_Activate", false);
    end;

    u10.Is_Using_Skill = false;
    u10.Is_Attacking = false;
end;

return u5;