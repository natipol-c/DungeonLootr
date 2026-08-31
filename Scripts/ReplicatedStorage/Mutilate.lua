--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Mutilate
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Shadow Vagrant.Mutilate
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
    AnimationName = "Ability_4",
    EffectModule = "Mutilate",
    MaxDuration = 5,
    TickDamage = 1.2,
    TickInterval = 0.35,
    FinalDamage = 3.5,
    HitboxSize = Vector3.new(22, 20, 30),
    HitboxRange = 28,
    DashSpeed = 70,
    DashDuration = 0.18,
    StartSFX = "claw_combo",
    StartVolume = 1,
    FinalSFX = "claw_slam_01",
    FinalVolume = 1
};

local function freezeHRP(p2) -- Line: 70
    local v3 = p2.Character and p2.Character:FindFirstChild("HumanoidRootPart");

    if v3 then
        v3.Anchored = true;
    end;
end;

local function unfreezeHRP(p4) -- Line: 74
    local v5 = p4.Character and p4.Character:FindFirstChild("HumanoidRootPart");

    if v5 then
        v5.Anchored = false;
    end;
end;

function u1._PerformHit(p6, p7, p8) -- Line: 80
    -- upvalues: u1 (copy)
    local v9 = p6:QueryHitbox(p7.HitboxSize or u1.HitboxSize, p7.HitboxRange or u1.HitboxRange);
    local v10 = p6:ResolveSkillDamage(p8);

    for _, v in v9 do
        p6:ApplyDamage(v.Character, v10);
    end;
end;

function u1.Activate(u11, u12) -- Line: 93
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local v13 = u12._animKey or u1.AnimationName;
    local v14 = u11.Animations[v13];

    if not v14 then
        warn("[Boss Mutilate] Animation not found:", v13);

        return;
    end;

    local Character = u11.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local u15 = u11.ClassData.SwingSoundFolder or "Ninja";
    local u16 = u11.ClassData.SwingVolume or 1;
    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;
    local u17 = false;
    local u18 = false;
    local u19 = false;
    local u20 = false;
    v14:Play(0, 1, u12.AnimSpeed or 1);
    local v22 = v14:GetMarkerReachedSignal("dash"):Connect(function() -- Line: 120
        -- upvalues: u11 (copy), u12 (copy), u1 (ref), Debris (ref)
        local v21 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v21 then
            return;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v21.CFrame.LookVector * (u12.DashSpeed or u1.DashSpeed);
        BodyVelocity.Parent = v21;
        Debris:AddItem(BodyVelocity, u12.DashDuration or u1.DashDuration);
    end);
    local v25 = v14:GetMarkerReachedSignal("VFX"):Connect(function(p23) -- Line: 134
        -- upvalues: u11 (copy), u1 (ref)
        if not p23 or p23 == "" then
            return;
        end;

        local v24 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v24 then
            return;
        end;

        u11:PlayEffectModule(u1.EffectModule, "Emit", v24.CFrame, p23);
    end);
    local v29 = v14:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 143
        -- upvalues: u19 (ref), u11 (copy), SharedUtils (ref), u12 (copy), u1 (ref), u18 (ref), u15 (copy), u16 (copy)
        if u19 then
            return;
        end;

        u19 = true;
        local v26 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v26 then
            SharedUtils.PlaySoundAt(v26, u12.StartSFX or u1.StartSFX, u12.StartVolume or u1.StartVolume);
        end;

        local v27 = u11;
        local v28 = v27.Character and v27.Character:FindFirstChild("HumanoidRootPart");

        if v28 then
            v28.Anchored = true;
        end;

        u18 = true;
        task.spawn(function() -- Line: 156
            -- upvalues: u18 (ref), u11 (ref), u1 (ref), u12 (ref), u15 (ref), u16 (ref)
            while u18 and u11.Is_Using_Skill do
                u1._PerformHit(u11, u12, u12.TickDamage or u1.TickDamage);
                u11:PlayCombatSound(u15, nil, u16);
                task.wait(u12.TickInterval or u1.TickInterval);
            end;
        end);
    end);
    local v32 = v14:GetMarkerReachedSignal("End"):Connect(function() -- Line: 167
        -- upvalues: u18 (ref), u11 (copy)
        u18 = false;
        local v30 = u11;
        local v31 = v30.Character and v30.Character:FindFirstChild("HumanoidRootPart");

        if v31 then
            v31.Anchored = false;
        end;
    end);
    local v34 = v14:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 174
        -- upvalues: u20 (ref), u11 (copy), SharedUtils (ref), u12 (copy), u1 (ref)
        if u20 then
            return;
        end;

        u20 = true;
        local v33 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v33 then
            SharedUtils.PlaySoundAt(v33, u12.FinalSFX or u1.FinalSFX, u12.FinalVolume or u1.FinalVolume);
        end;

        u1._PerformHit(u11, u12, u12.FinalDamage or u1.FinalDamage);
    end);
    v14.Stopped:Once(function() -- Line: 186
        -- upvalues: u17 (ref)
        u17 = true;
    end);
    task.delay(u12.MaxDuration or u1.MaxDuration, function() -- Line: 187
        -- upvalues: u17 (ref)
        u17 = true;
    end);

    while not u17 do
        task.wait();
    end;

    u18 = false;
    local v35 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

    if v35 then
        v35.Anchored = false;
    end;

    if v22 then
        v22:Disconnect();
    end;

    if v25 then
        v25:Disconnect();
    end;

    if v29 then
        v29:Disconnect();
    end;

    if v32 then
        v32:Disconnect();
    end;

    if v34 then
        v34:Disconnect();
    end;

    u11.Is_Using_Skill = false;
    u11.Is_Attacking = false;
end;

return u1;