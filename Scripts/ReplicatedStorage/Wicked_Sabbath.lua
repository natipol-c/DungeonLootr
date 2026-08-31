--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Wicked_Sabbath
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Witch Gunner.Wicked_Sabbath
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
    AnimationName = "Ability_4",
    MaxDuration = 4,
    HitboxSize = Vector3.new(20, 12, 24),
    HitboxRange = 20,
    SavageHitboxSize = Vector3.new(28, 20, 38),
    SavageDamageMultiplier = nil,
    FX_Name = "Savage",

    _SetLoopFX = function(p1, p2, p3) -- Line: 43, Name: _SetLoopFX
        local v4 = p1.FX and p1.FX[p2];

        if v4 then
            v4:SetAttribute("Fire", p3);
        end;
    end
};

function u5._PerformHit(p6, p7, p8) -- Line: 50
    -- upvalues: u5 (copy)
    local HitboxSize = p6.ClassData.HitboxSize;
    local Range = p6.ClassData.Range;
    p6.ClassData.HitboxSize = p8 and (p7.SavageHitboxSize or u5.SavageHitboxSize) or (p7.HitboxSize or u5.HitboxSize);
    p6.ClassData.Range = p7.HitboxRange or u5.HitboxRange;
    local v9 = p6:QueryHitbox();
    p6.ClassData.HitboxSize = HitboxSize;
    p6.ClassData.Range = Range;
    local v10 = p6:ResolveSkillDamage(p8 and (p7.SavageDamageMultiplier or p7.DamageMultiplier) or p7.DamageMultiplier);

    for _, v in v9 do
        p6:ApplyDamage(v.Character, v10);
    end;
end;

function u5.Activate(u11, u12) -- Line: 74
    -- upvalues: u5 (copy)
    local v13 = u11.Animations[u5.AnimationName];

    if not v13 then
        warn("[Boss Wicked_Sabbath] Animation not found:", u5.AnimationName);

        return;
    end;

    local Character = u11.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;
    local u14 = false;
    local u15 = false;
    v13:Play(0, 1, u12.AnimSpeed or 1);
    local v16 = v13:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 95
        -- upvalues: u15 (ref), u5 (ref), u11 (copy)
        u15 = true;
        u5._SetLoopFX(u11, u5.FX_Name, true);
    end);
    local v17 = v13:GetMarkerReachedSignal("End"):Connect(function() -- Line: 101
        -- upvalues: u15 (ref), u5 (ref), u11 (copy)
        u15 = false;
        u5._SetLoopFX(u11, u5.FX_Name, false);
    end);
    local v19 = v13:GetMarkerReachedSignal("hit"):Connect(function(p18) -- Line: 109
        -- upvalues: u12 (copy), u11 (copy), u5 (ref), u15 (ref)
        u11:PlayCombatSound(u12.SwingSoundFolder or (u11.ClassData.SwingSoundFolder or "Gun_Shots"), nil, u11.ClassData.SwingVolume or 1);

        if p18 ~= "" then
            u11:PlayTurnFX(p18);
        end;

        u5._PerformHit(u11, u12, u15);
    end);
    v13.Stopped:Once(function() -- Line: 120
        -- upvalues: u14 (ref)
        u14 = true;
    end);
    task.delay(u5.MaxDuration, function() -- Line: 124
        -- upvalues: u14 (ref)
        u14 = true;
    end);

    while not u14 do
        task.wait();
    end;

    if v19 then
        v19:Disconnect();
    end;

    if v16 then
        v16:Disconnect();
    end;

    if v17 then
        v17:Disconnect();
    end;

    u5._SetLoopFX(u11, u5.FX_Name, false);
    u11.Is_Using_Skill = false;
    u11.Is_Attacking = false;
end;

return u5;