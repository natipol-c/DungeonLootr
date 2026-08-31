--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Spatial_Divide
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Awakened Devil EX.Spatial_Divide
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
    AnimationName = "Ability_2",
    EffectModule = "Spatial_Divide_Tap",
    MaxDuration = 1.8,
    DamageMultiplier = 1,
    HitboxSize = Vector3.new(27, 12, 38),
    HitboxRange = 36
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
    -- upvalues: u1 (copy), SharedUtils (copy), Debris (copy)
    local u8 = u6.Animations[u1.AnimationName];

    if not u8 then
        warn("[Boss Spatial_Divide] Animation not found:", u1.AnimationName);

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
    local u19 = false;
    u11[#u11 + 1] = u8:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 85
        -- upvalues: u6 (copy), u19 (ref), SharedUtils (ref), u7 (copy), Debris (ref), u1 (ref)
        local v20 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not u19 then
            u19 = true;

            if v20 then
                SharedUtils.PlaySoundAt(v20, "Judgement_Cut", 0.8);
                local LookVector = v20.CFrame.LookVector;
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.Name = "BossSkillDash";
                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                BodyVelocity.Velocity = LookVector * (u7.DashSpeed or 70);
                BodyVelocity.Parent = v20;
                Debris:AddItem(BodyVelocity, u7.DashDuration or 0.15);
            end;
        end;

        u1._PerformHit(u6, u7);
    end);
    u11[#u11 + 1] = u8:GetMarkerReachedSignal("sheathe"):Connect(function() -- Line: 104
        -- upvalues: u6 (copy), SharedUtils (ref)
        local v21 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v21 then
            SharedUtils.PlaySoundAt(v21, "Sheathe_1", 0.8);
        end;
    end);
    u8.Stopped:Once(function() -- Line: 109
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u7.MaxDuration or u1.MaxDuration, function() -- Line: 110
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