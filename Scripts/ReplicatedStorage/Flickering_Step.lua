--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Flickering_Step
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Shadow Vagrant.Flickering_Step
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_1",
    EffectModule = "Flickering_Step",
    MaxDuration = 1.6,
    DamageMultiplier = 1.6,
    HitboxSize = Vector3.new(30, 24, 30),
    HitboxRange = 12,
    DashSpeed = 70,
    DashDuration = 0.16,
    CastSFX = "anime_explode",
    CastVolume = 0.8,
    HitSFX = "claw_slam_01",
    HitVolume = 0.9
};

function u1._PerformHit(p2, p3) -- Line: 55
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 68
    -- upvalues: u1 (copy), SharedUtils (copy), Debris (copy)
    local v8 = u7._animKey or u1.AnimationName;
    local v9 = u6.Animations[v8];

    if not v9 then
        warn("[Boss Flickering_Step] Animation not found:", v8);

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
    SharedUtils.PlaySoundAt(Character, u7.CastSFX or u1.CastSFX, u7.CastVolume or u1.CastVolume);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "BossSkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = Character.CFrame.LookVector * (u7.DashSpeed or u1.DashSpeed);
    BodyVelocity.Parent = Character;
    Debris:AddItem(BodyVelocity, u7.DashDuration or u1.DashDuration);
    local u10 = false;
    v9:Play(0, 1, u7.AnimSpeed or 1);
    local v13 = v9:GetMarkerReachedSignal("VFX"):Connect(function(p11) -- Line: 100
        -- upvalues: u6 (copy), u1 (ref)
        if not p11 or p11 == "" then
            return;
        end;

        local v12 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v12 then
            return;
        end;

        u6:PlayEffectModule(u1.EffectModule, "Emit", v12.CFrame, p11);
    end);
    local v15 = v9:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 109
        -- upvalues: u6 (copy), SharedUtils (ref), u7 (copy), u1 (ref)
        local v14 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v14 then
            SharedUtils.PlaySoundAt(v14, u7.HitSFX or u1.HitSFX, u7.HitVolume or u1.HitVolume);
        end;

        u1._PerformHit(u6, u7);
    end);
    v9.Stopped:Once(function() -- Line: 118
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u7.MaxDuration or u1.MaxDuration, function() -- Line: 119
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v13 then
        v13:Disconnect();
    end;

    if v15 then
        v15:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;