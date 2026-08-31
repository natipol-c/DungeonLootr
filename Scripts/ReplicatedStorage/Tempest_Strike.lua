--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Tempest_Strike
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Artemis.Tempest_Strike
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_3",
    MaxDuration = 3,
    ExplosionSequence = { "Explosion_Right", "Explosion_Center", "Explosion_Left" },
    HitboxSize = Vector3.new(34, 30, 34),
    HitboxRange = 12
};

function u1._DetonateAtPart(p2, p3, p4) -- Line: 46
    -- upvalues: SharedUtils (copy), u1 (copy)
    if not p3 then
        return;
    end;

    p3:SetAttribute("Fire", not p3:GetAttribute("Fire"));
    SharedUtils.PlaySoundAt(p3, "lightningcrash", 1);
    local v5 = p2:QueryHitbox(p4.HitboxSize or u1.HitboxSize, p4.HitboxRange or u1.HitboxRange);
    local v6 = p2:ResolveSkillDamage(p4.DamageMultiplier);

    for _, v in v5 do
        p2:ApplyDamage(v.Character, v6);
    end;
end;

function u1.Activate(u7, u8) -- Line: 70
    -- upvalues: u1 (copy), Debris (copy)
    local v9 = u7.Animations[u1.AnimationName];

    if not v9 then
        warn("[Boss Tempest_Strike] Animation not found:", u1.AnimationName);

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
    v9:Play(0, 1, u8.AnimSpeed or 1);
    local v13 = v9:GetMarkerReachedSignal("dash"):Connect(function(p11) -- Line: 92
        -- upvalues: u7 (copy), u8 (copy), Debris (ref)
        local v12 = u7.Character and u7.Character:FindFirstChild("HumanoidRootPart");

        if not v12 then
            return;
        end;

        local LookVector = v12.CFrame.LookVector;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = LookVector * (u8.DashSpeed or 70);
        BodyVelocity.Parent = v12;
        Debris:AddItem(BodyVelocity, u8.DashDuration or 0.3);
    end);
    local u14 = 0;
    local v18 = v9:GetMarkerReachedSignal("hit"):Connect(function(p15) -- Line: 109
        -- upvalues: u14 (ref), u1 (ref), u7 (copy), u8 (copy)
        u14 = u14 + 1;
        local v16 = u1.ExplosionSequence[u14];

        if not v16 then
            return;
        end;

        local v17 = u7.FX and u7.FX[v16];

        if v17 then
            u1._DetonateAtPart(u7, v17, u8);

            return;
        end;

        warn((`[Boss Tempest_Strike] FX part "{v16}" not found in bossState.FX`));
    end);
    v9.Stopped:Once(function() -- Line: 124
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 129
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v13 then
        v13:Disconnect();
    end;

    if v18 then
        v18:Disconnect();
    end;

    u7.Is_Using_Skill = false;
    u7.Is_Attacking = false;
end;

return u1;