--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Mirage_Chase
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Awakened Devil EX.Mirage_Chase
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
    AnimationName = "Ability_1",
    EffectModule = "Mirage_Chase",
    MaxDuration = 2.5,
    DamageMultiplier = 1.6,
    HitboxSize = Vector3.new(26, 40, 32),
    HitboxRange = 30
};

function u1._PerformHit(p2, p3) -- Line: 41
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 51
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local u8 = u6.Animations[u1.AnimationName];

    if not u8 then
        warn("[Boss Mirage_Chase] Animation not found:", u1.AnimationName);

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

    local function bindVFX(p12) -- Line: 70
        -- upvalues: u11 (copy), u8 (copy), u6 (copy), u1 (ref)
        u11[#u11 + 1] = u8:GetMarkerReachedSignal(p12):Connect(function(p13) -- Line: 71
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

    u11[#u11 + 1] = u8:GetMarkerReachedSignal("VFX"):Connect(function(p15) -- Line: 71
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
    u11[#u11 + 1] = u8:GetMarkerReachedSignal("VFX_2"):Connect(function(p17) -- Line: 71
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
    u11[#u11 + 1] = u8:GetMarkerReachedSignal("dash"):Connect(function(p19) -- Line: 81
        -- upvalues: u6 (copy), u7 (copy), Debris (ref), SharedUtils (ref)
        local v20 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v20 then
            return;
        end;

        local v21;

        if p19 == "Back" then
            v21 = -v20.CFrame.LookVector;
        else
            v21 = v20.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v21 * (u7.DashSpeed or 90);
        BodyVelocity.Parent = v20;
        Debris:AddItem(BodyVelocity, u7.DashDuration or 0.29);
        SharedUtils.PlaySoundAt(v20, "Judgement_Cut", 0.6);
    end);
    u11[#u11 + 1] = u8:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 95
        -- upvalues: u6 (copy), u7 (copy), u1 (ref)
        u6:PlayCombatSound(u7.SwingSoundFolder or (u6.ClassData.SwingSoundFolder or "Sword_Swings"), nil, u6.ClassData.SwingVolume or 0.5);
        u1._PerformHit(u6, u7);
    end);
    u8.Stopped:Once(function() -- Line: 104
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u7.MaxDuration or u1.MaxDuration, function() -- Line: 105
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