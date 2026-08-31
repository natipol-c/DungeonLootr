--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Destruction_Type
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Chaotic Fist.Destruction_Type
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:34 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_4",
    MaxDuration = 6,
    HitboxSize = Vector3.new(17, 22, 17),
    HitboxRange = 17,
    FinalHitboxSize = Vector3.new(22, 22, 32),
    FinalHitboxRange = 32
};

function u1._PerformHit(p2, p3) -- Line: 39
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

function u1._PerformFinalHit(p6, p7) -- Line: 59
    -- upvalues: u1 (copy)
    local HitboxSize = p6.ClassData.HitboxSize;
    local Range = p6.ClassData.Range;
    p6.ClassData.HitboxSize = p7.FinalHitboxSize or u1.FinalHitboxSize;
    p6.ClassData.Range = p7.FinalHitboxRange or u1.FinalHitboxRange;
    local v8 = p6:QueryHitbox();
    p6.ClassData.HitboxSize = HitboxSize;
    p6.ClassData.Range = Range;
    local v9 = p6:ResolveSkillDamage(p7.FinalDamageMult or 5);

    for _, v in v8 do
        p6:ApplyDamage(v.Character, v9);
    end;
end;

function u1.Activate(u10, u11) -- Line: 82
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v12 = u10.Animations[u1.AnimationName];

    if not v12 then
        warn("[Boss Kieru Destruction_Type] Animation not found:", u1.AnimationName);

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
    local u14 = false;
    v12:Play(0, 1, u11.AnimSpeed or 1);
    local v16 = v12:GetMarkerReachedSignal("start"):Connect(function() -- Line: 105
        -- upvalues: u14 (ref), u10 (copy)
        u14 = true;
        local v15 = u10.FX and u10.FX.Charge;

        if v15 then
            v15:SetAttribute("FX_Activate", true);
        end;
    end);
    local v20 = v12:GetMarkerReachedSignal("end"):Connect(function() -- Line: 115
        -- upvalues: u14 (ref), u10 (copy), u11 (copy), SharedUtils (ref), u1 (ref)
        if u14 then
            local v17 = u10.FX and u10.FX.Charge;

            if v17 then
                v17:SetAttribute("FX_Activate", false);
            end;

            u14 = false;
        end;

        local u18 = u10.FX and u10.FX.Ability_4;

        if u18 then
            u18:SetAttribute("FX_Activate", true);
            task.delay(u11.FinalFXDuration or 0.5, function() -- Line: 130
                -- upvalues: u18 (copy)
                if u18 and u18.Parent then
                    u18:SetAttribute("FX_Activate", false);
                end;
            end);
        end;

        local v19 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if v19 then
            SharedUtils.PlaySoundAt(v19, "lightningcrash", 1);
        end;

        u1._PerformFinalHit(u10, u11);
    end);
    local v22 = v12:GetMarkerReachedSignal("hit"):Connect(function(p21) -- Line: 149
        -- upvalues: u10 (copy), u1 (ref), u11 (copy)
        u10:PlayCombatSound(u10.ClassData.SwingSoundFolder or "Naoya_Punches", nil, u10.ClassData.SwingVolume or 1);
        u10:PlayTurnFX("Front_Hit");
        u1._PerformHit(u10, u11);
    end);
    v12.Stopped:Once(function() -- Line: 162
        -- upvalues: u13 (ref)
        u13 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 167
        -- upvalues: u13 (ref)
        u13 = true;
    end);

    while not u13 do
        task.wait();
    end;

    if v22 then
        v22:Disconnect();
    end;

    if v16 then
        v16:Disconnect();
    end;

    if v20 then
        v20:Disconnect();
    end;

    if u14 then
        local v23 = u10.FX and u10.FX.Charge;

        if v23 then
            v23:SetAttribute("FX_Activate", false);
        end;

        u14 = false;
    end;

    u10.Is_Using_Skill = false;
    u10.Is_Attacking = false;
end;

return u1;