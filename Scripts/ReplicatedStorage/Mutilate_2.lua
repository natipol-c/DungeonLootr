--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Mutilate
  Path:     game.ReplicatedStorage.Classes.Shadow Vagrant.Skills.Mutilate
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:48 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_4",
    EffectModule = "Mutilate",
    Skill_SFX = nil,
    TickDamage = 0.46,
    TickInterval = 0.15,
    StartSFX = "claw_combo",
    StartVolume = 1,
    FinalDamage = 1.3,
    FinalSFX = "claw_slam_01",
    FinalVolume = 1,
    FXPart = "Mutilate",
    DashSpeed = 70,
    DashDuration = 0.18,
    IFrameDuration = 0.6,
    HitboxSize = Vector3.new(22, 20, 30),
    HitboxRange = 28,
    MaxDuration = 2
};

function u1._EnsureAnimation(p2) -- Line: 83
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p2.Animations[AnimationName] then
        return p2.Animations[AnimationName];
    end;

    local v3 = ReplicatedStorage.Classes:FindFirstChild(p2.ClassName);

    if not v3 then
        return nil;
    end;

    local Skill_Animations = v3:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v4 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v4 then
        return nil;
    end;

    local v5 = p2.Humanoid and p2.Humanoid:FindFirstChildOfClass("Animator");

    if not v5 then
        return nil;
    end;

    local v6 = v5:LoadAnimation(v4);
    v6.Priority = Enum.AnimationPriority.Action3;
    v6:Play(0, 0, 0);
    v6:Stop(0);
    p2.Animations[AnimationName] = v6;

    return v6;
end;

function u1._PerformHit(p7, p8) -- Line: 110
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v9 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
        end;
    end;
end;

function u1.CanActivate(p10) -- Line: 132
    if p10.Is_Attacking then
        return false, "Attacking";
    end;

    if p10.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p10.Is_Dodging then
        return false, "Dodging";
    end;

    if p10.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u11, p12) -- Line: 140
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Mutilate] Animation not found");

        return;
    end;

    local Character = u11.Character;
    local v14;

    if Character then
        v14 = Character:FindFirstChild("HumanoidRootPart");
    else
        v14 = Character;
    end;

    if not v14 then
        return;
    end;

    local u15 = u1.Skill_SFX or (u11.ClassData.SwingSoundFolder or "Ninja");
    local u16 = u11.ClassData.SwingVolume or 1;
    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;
    Character:SetAttribute("Skill_Camera_Stabilize", true);

    for i, v in u11.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v13:Play(0, 1, 1);
    local u17 = {};

    local function disconnectAll() -- Line: 173
        -- upvalues: u17 (copy)
        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);
    end;

    local u18 = 0;

    local function grantDodge() -- Line: 181
        -- upvalues: u18 (ref), u11 (copy), u1 (ref)
        u18 = u18 + 1;
        local u19 = u18;

        if u11.Player then
            u11.Player:SetAttribute("iFrame", true);
        end;

        if u11.Character then
            u11.Character:SetAttribute("iFrame", true);
        end;

        task.delay(u1.IFrameDuration, function() -- Line: 186
            -- upvalues: u19 (copy), u18 (ref), u11 (ref)
            if u19 ~= u18 then
                return;
            end;

            local Player = u11.Player;
            local Character2 = u11.Character;

            if Player then
                Player:SetAttribute("iFrame", false);
            end;

            if Character2 then
                Character2:SetAttribute("iFrame", false);
            end;
        end);
    end;

    local function clearIFrame() -- Line: 194
        -- upvalues: u11 (copy)
        if u11.Player then
            u11.Player:SetAttribute("iFrame", false);
        end;

        if u11.Character then
            u11.Character:SetAttribute("iFrame", false);
        end;
    end;

    local function freezeHRP() -- Line: 202
        -- upvalues: u11 (copy)
        local v20 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            v20.Anchored = true;
        end;
    end;

    local function unfreezeHRP() -- Line: 206
        -- upvalues: u11 (copy)
        local v21 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v21 then
            v21.Anchored = false;
        end;
    end;

    local u22 = false;
    local u23 = nil;

    local function stopField() -- Line: 214
        -- upvalues: u22 (ref), u23 (ref)
        u22 = false;

        if u23 then
            pcall(task.cancel, u23);
            u23 = nil;
        end;
    end;

    local u24 = false;

    local function releaseState() -- Line: 227
        -- upvalues: u24 (ref), u11 (copy)
        if u24 then
            return;
        end;

        u24 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    local function cleanup() -- Line: 235
        -- upvalues: u22 (ref), u23 (ref), u11 (copy), u17 (copy), u24 (ref)
        u22 = false;

        if u23 then
            pcall(task.cancel, u23);
            u23 = nil;
        end;

        local v25 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v25 then
            v25.Anchored = false;
        end;

        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);

        if not u24 then
            u24 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        if u11.Player then
            u11.Player:SetAttribute("iFrame", false);
        end;

        if u11.Character then
            u11.Character:SetAttribute("iFrame", false);
        end;

        if u11.Character then
            u11.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;
    end;

    u17[#u17 + 1] = v13:GetMarkerReachedSignal("dash"):Connect(function() -- Line: 247
        -- upvalues: u11 (copy), u1 (ref), Debris (ref)
        local v26 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v26 then
            return;
        end;

        local Humanoid = u11.Humanoid;
        local v27 = Humanoid and (Humanoid.MoveDirection.Magnitude > 0 and Humanoid.MoveDirection.Unit) or v26.CFrame.LookVector;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v27 * u1.DashSpeed;
        BodyVelocity.Parent = v26;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
    end);
    local u28 = false;
    u17[#u17 + 1] = v13:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 267
        -- upvalues: u28 (ref), u11 (copy), SharedUtils (ref), u1 (ref), grantDodge (copy), u22 (ref), u23 (ref), u15 (copy), u16 (copy)
        if u28 then
            return;
        end;

        u28 = true;
        local v29 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v29 then
            SharedUtils.PlaySoundAt(v29, u1.StartSFX, u1.StartVolume);
        end;

        local v30 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v30 then
            v30.Anchored = true;
        end;

        grantDodge();
        u22 = true;
        u23 = task.spawn(function() -- Line: 285
            -- upvalues: u22 (ref), u11 (ref), u1 (ref), u15 (ref), u16 (ref)
            while u22 and (u11.Character and u11.Character.Parent) do
                u1._PerformHit(u11, u1.TickDamage);
                u11:PlayCombatSound(u15, nil, u16);
                u11:ShakeCamera("SkillMedium");
                task.wait(u1.TickInterval);
            end;
        end);
    end);
    u17[#u17 + 1] = v13:GetMarkerReachedSignal("End"):Connect(function() -- Line: 297
        -- upvalues: u22 (ref), u23 (ref), u11 (copy), grantDodge (copy)
        u22 = false;

        if u23 then
            pcall(task.cancel, u23);
            u23 = nil;
        end;

        local v31 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v31 then
            v31.Anchored = false;
        end;

        grantDodge();
    end);
    u17[#u17 + 1] = v13:GetMarkerReachedSignal("VFX"):Connect(function(p32) -- Line: 305
        -- upvalues: u11 (copy), u1 (ref)
        if not p32 or p32 == "" then
            return;
        end;

        local v33 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v33 then
            return;
        end;

        u11:PlayEffectModule(u1.EffectModule, "Emit", v33.CFrame, p32);
    end);
    u17[#u17 + 1] = v13:GetMarkerReachedSignal("hit"):Connect(function(p34) -- Line: 313
        -- upvalues: u11 (copy), SharedUtils (ref), u1 (ref)
        local v35 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v35 then
            SharedUtils.PlaySoundAt(v35, u1.FinalSFX, u1.FinalVolume);
        end;

        u11:ShakeCamera("SkillHeavy");
        u1._PerformHit(u11, u1.FinalDamage);
    end);
    u17[#u17 + 1] = v13:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v13.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, cleanup);
end;

return u1;