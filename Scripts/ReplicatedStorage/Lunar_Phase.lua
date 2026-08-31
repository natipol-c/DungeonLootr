--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Lunar_Phase
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Awakened Devil EX.Lunar_Phase
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_4",
    EffectModule = "Lunar_Phase",
    MaxDuration = 3,
    DamageMultiplier = 1.1,
    TotalHits = 6,
    HitboxSize = Vector3.new(26, 12, 32),
    HitboxRange = 28,
    FirstHitsSFX = "hit_ultema_s_1",
    FinalHitSFX = "claw_slam_01"
};

function u1._PerformHit(p2, p3) -- Line: 44
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 54
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local u8 = u6.Animations[u1.AnimationName];

    if not u8 then
        warn("[Boss Lunar_Phase] Animation not found:", u1.AnimationName);

        return;
    end;

    local v9 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

    if not v9 then
        return;
    end;

    u6.Is_Using_Skill = true;
    u6.Is_Attacking = true;
    local u10 = false;
    u8:Play(0, 1, u7.AnimSpeed or 1);
    local u11 = {};

    local function bindVFX(p12) -- Line: 72
        -- upvalues: u11 (copy), u8 (copy), u6 (copy), u1 (ref)
        u11[#u11 + 1] = u8:GetMarkerReachedSignal(p12):Connect(function(p13) -- Line: 73
            -- upvalues: u6 (ref), u1 (ref)
            if not p13 or p13 == "" then
                return;
            end;

            local v14 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

            if not v14 then
                return;
            end;

            u6:PlayEffectModule(u1.EffectModule, "Emit", v14.CFrame, p13);
        end);
    end;

    u11[#u11 + 1] = u8:GetMarkerReachedSignal("VFX"):Connect(function(p15) -- Line: 73
        -- upvalues: u6 (copy), u1 (ref)
        if not p15 or p15 == "" then
            return;
        end;

        local v16 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v16 then
            return;
        end;

        u6:PlayEffectModule(u1.EffectModule, "Emit", v16.CFrame, p15);
    end);
    u11[#u11 + 1] = u8:GetMarkerReachedSignal("VFX_2"):Connect(function(p17) -- Line: 73
        -- upvalues: u6 (copy), u1 (ref)
        if not p17 or p17 == "" then
            return;
        end;

        local v18 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v18 then
            return;
        end;

        u6:PlayEffectModule(u1.EffectModule, "Emit", v18.CFrame, p17);
    end);
    u11[#u11 + 1] = u8:GetMarkerReachedSignal("dash"):Connect(function() -- Line: 83
        -- upvalues: u6 (copy), u7 (copy), Debris (ref)
        local v19 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v19 then
            return;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v19.CFrame.LookVector * (u7.DashSpeed or 60);
        BodyVelocity.Parent = v19;
        Debris:AddItem(BodyVelocity, u7.DashDuration or 0.2);
    end);
    local u20 = u7.TotalHits or u1.TotalHits;
    local u21 = 0;
    u11[#u11 + 1] = u8:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 97
        -- upvalues: u21 (ref), u6 (copy), u20 (copy), u1 (ref), SharedUtils (ref), u7 (copy)
        u21 = u21 + 1;
        local v22 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v22 then
            local v23;

            if u20 <= u21 then
                v23 = u1.FinalHitSFX;
            else
                v23 = u1.FirstHitsSFX;
            end;

            SharedUtils.PlaySoundAt(v22, v23, 1);
        end;

        u1._PerformHit(u6, u7);
    end);
    u8.Stopped:Once(function() -- Line: 107
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u7.MaxDuration or u1.MaxDuration, function() -- Line: 108
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    for _, v in u11 do
        v:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;