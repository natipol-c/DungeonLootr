--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Fuuga
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Cursed King.Fuuga
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
    EffectModule = "Fuuga",
    DetonateDelay = 3.4,
    RigLifetime = 11.5,
    MaxDuration = 8,
    CastSFX = "Ronan_Spell_01",
    DetonateSFX = { "explosion_2", "Sieghart_Spell_15" },
    SFXVolume = 1,
    CubeDistance = 20,
    DamageRadius = 25,
    FieldHeight = 40,
    FieldMultiplier = 1,
    TickInterval = 0.4,
    DamageDuration = 5
};

function u1._StartField(u2, p3, p4) -- Line: 62
    -- upvalues: u1 (copy)
    local _npc = u2._npc;
    local v5 = p4.DamageRadius or u1.DamageRadius;
    local v6 = p4.FieldHeight or u1.FieldHeight;
    local u7 = p4.FieldMultiplier or u1.FieldMultiplier;
    local u8 = p4.TickInterval or u1.TickInterval;
    local u9 = p4.DamageDuration or u1.DamageDuration;
    local u10 = p3 * CFrame.new(0, 0, -(p4.CubeDistance or u1.CubeDistance));
    local Vector3_new_ret = Vector3.new(v5 * 2, v6, v5 * 2);
    task.spawn(function() -- Line: 75
        -- upvalues: u9 (copy), _npc (copy), u2 (copy), u10 (copy), Vector3_new_ret (copy), u7 (copy), u8 (copy)
        local v11 = 0;

        while v11 < u9 and (_npc.Body and _npc.State ~= "Dead") do
            local v12 = u2:QueryHitboxAt(u10, Vector3_new_ret);
            local v13 = u2:ResolveSkillDamage(u7);

            for _, v in v12 do
                u2:ApplyDamage(v.Character, v13);
            end;

            task.wait(u8);
            v11 = v11 + u8;
        end;
    end);
end;

function u1.Activate(u14, u15) -- Line: 94
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v16 = u15._animKey or u1.AnimationName;
    local v17 = u14.Animations[v16];

    if not v17 then
        warn("[Boss Fuuga] Animation not found:", v16);

        return;
    end;

    local Character = u14.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u14.Is_Using_Skill = true;
    u14.Is_Attacking = true;
    local u18 = false;
    local u19 = false;
    v17:Play(0, 1, u15.AnimSpeed or 1);
    SharedUtils.PlaySoundAt(Character, u15.CastSFX or u1.CastSFX, u15.SFXVolume or u1.SFXVolume);
    local u20 = u15.DetonateDelay or u1.DetonateDelay;
    local v23 = v17:GetMarkerReachedSignal("VFX"):Connect(function() -- Line: 119
        -- upvalues: u19 (ref), u14 (copy), u1 (ref), u20 (copy), u18 (ref), u15 (copy), SharedUtils (ref)
        if u19 then
            return;
        end;

        u19 = true;
        local v21 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

        if not v21 then
            return;
        end;

        local CFrame2 = v21.CFrame;
        u14:PlayEffectModule(u1.EffectModule, "Start", CFrame2);
        task.delay(u20, function() -- Line: 131
            -- upvalues: u18 (ref), u14 (ref), u15 (ref), u1 (ref), SharedUtils (ref), CFrame2 (copy)
            u18 = true;
            local v22 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

            for _, v in u15.DetonateSFX or u1.DetonateSFX do
                if v22 then
                    SharedUtils.PlaySoundAt(v22, v, u15.SFXVolume or u1.SFXVolume);
                end;
            end;

            u1._StartField(u14, CFrame2, u15);
        end);
        task.delay(u15.RigLifetime or u1.RigLifetime, function() -- Line: 141
            -- upvalues: u14 (ref), u1 (ref), CFrame2 (copy)
            u14:PlayEffectModule(u1.EffectModule, "DBreset", CFrame2);
        end);
    end);
    v17.Stopped:Once(function() -- Line: 148
        -- upvalues: u19 (ref), u18 (ref)
        if not u19 then
            u18 = true;
        end;
    end);
    task.delay(u15.MaxDuration or u1.MaxDuration, function() -- Line: 151
        -- upvalues: u18 (ref)
        u18 = true;
    end);

    while not u18 do
        task.wait();
    end;

    if v23 then
        v23:Disconnect();
    end;

    if v17.IsPlaying then
        v17:Stop(0.2);
    end;

    u14.Is_Using_Skill = false;
    u14.Is_Attacking = false;
end;

return u1;