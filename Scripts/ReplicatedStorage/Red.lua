--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Red
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Honored One.Red
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_2",
    EffectModule = "Red",
    VFXMethod = "Tap",
    MaxDuration = 2,
    DamageMultiplier = 3.5,
    HitboxSize = Vector3.new(25, 20, 35),
    HitboxRange = 20,
    SFX = "Red_Fast",
    SFXVolume = 2
};

function u1._PerformHit(p2, p3) -- Line: 54
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 68
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u7._animKey or u1.AnimationName;
    local v9 = u6.Animations[v8];

    if not v9 then
        warn("[Boss Red] Animation not found:", v8);

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
    local u10 = false;
    local u11 = false;
    v9:Play(0, 1, u7.AnimSpeed or 1);
    local v13 = v9:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 91
        -- upvalues: u11 (ref), u6 (copy), u1 (ref), SharedUtils (ref), u7 (copy)
        if u11 then
            return;
        end;

        u11 = true;
        local v12 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v12 then
            return;
        end;

        u6:PlayEffectModule(u1.EffectModule, u1.VFXMethod, v12.CFrame);
        SharedUtils.PlaySoundAt(v12, u7.SFX or u1.SFX, u7.SFXVolume or u1.SFXVolume);
        u1._PerformHit(u6, u7);
    end);
    v9.Stopped:Once(function() -- Line: 106
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u7.MaxDuration or u1.MaxDuration, function() -- Line: 107
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v13 then
        v13:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;