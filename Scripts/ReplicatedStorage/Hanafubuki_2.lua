--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hanafubuki
  Path:     game.ReplicatedStorage.Classes.Zero.Skills.Hanafubuki
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u14 = {
    Cooldown = 13,
    AnimationName = "Ability_4",
    HoldAnimationName = "Ability_4_Hold",
    EffectModule = "Hanafubuki",
    HoldEffectModule = "Hanafubuki_Vortex",
    Skill_SFX = nil,
    DamageMultiplier = 1.2,
    HitboxSize = Vector3.new(24, 16, 26),
    HitboxRange = 14,
    HitSFX = "hit_ultema_s_1",
    HitVolume = 1,
    MaxDuration = 2,
    TickDamage = 1.2,
    TickInterval = 0.15,
    StartSFX = "claw_combo",
    StartVolume = 1,
    HoldSwingSFXFolder = "Ninja",
    FinalDamage = 3.5,
    FinalSFX = "claw_slam_01",
    FinalVolume = 1,
    DashSpeed = 70,
    DashDuration = 0.18,
    IFrameDuration = 0.6,
    HoldHitboxSize = Vector3.new(22, 20, 30),
    HoldHitboxRange = 28,
    HoldMaxDuration = 5,

    _EnsureAnimation = function(p1, p2) -- Line: 117, Name: _EnsureAnimation
        -- upvalues: ReplicatedStorage (copy)
        if p1.Animations[p2] then
            return p1.Animations[p2];
        end;

        local v3 = ReplicatedStorage.Classes:FindFirstChild(p1.ClassName);

        if not v3 then
            return nil;
        end;

        local Skill_Animations = v3:FindFirstChild("Skill_Animations");

        if not Skill_Animations then
            return nil;
        end;

        local v4 = Skill_Animations:FindFirstChild(p2);

        if not v4 then
            return nil;
        end;

        local v5 = p1.Humanoid and p1.Humanoid:FindFirstChildOfClass("Animator");

        if not v5 then
            return nil;
        end;

        local v6 = v5:LoadAnimation(v4);
        v6.Priority = Enum.AnimationPriority.Action3;
        v6:Play(0, 0, 0);
        v6:Stop(0);
        p1.Animations[p2] = v6;

        return v6;
    end,

    _PerformHit = function(p7, p8, p9, p10) -- Line: 144, Name: _PerformHit
        local HitboxSize = p7.ClassData.HitboxSize;
        local Range = p7.ClassData.Range;
        p7.ClassData.HitboxSize = p9;
        p7.ClassData.Range = p10;
        local v11 = p7:Hitbox();
        p7.ClassData.HitboxSize = HitboxSize;
        p7.ClassData.Range = Range;
        local v12 = 0;

        for _, v in v11 do
            if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
                p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
                v12 = v12 + 1;
            end;
        end;

        return v12;
    end,

    CanActivate = function(p13) -- Line: 170, Name: CanActivate
        if p13.Is_Attacking then
            return false, "Attacking";
        end;

        if p13.Is_Using_Skill then
            return false, "Skill in progress";
        end;

        if p13.Is_Dodging then
            return false, "Dodging";
        end;

        if p13.Is_Stunned then
            return false, "Stunned";
        end;

        return true;
    end
};

function u14.Activate(u15, p16) -- Line: 179
    -- upvalues: u14 (copy), SharedUtils (copy)
    local v17 = u14._EnsureAnimation(u15, u14.AnimationName);

    if not v17 then
        warn("[Hanafubuki] Ground animation not found");

        return;
    end;

    local Character = u15.Character;

    if not Character then
        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;
    Character:SetAttribute("Parry", true);

    for i, v in u15.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v17:Play(0, 1, 1);
    local u18 = {};

    local function disconnectAll() -- Line: 208
        -- upvalues: u18 (copy)
        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);
    end;

    local function clearParry() -- Line: 213
        -- upvalues: u15 (copy)
        if u15.Character then
            u15.Character:SetAttribute("Parry", false);
        end;
    end;

    local u19 = false;

    local function releaseState() -- Line: 218
        -- upvalues: u19 (ref), u15 (copy)
        if u19 then
            return;
        end;

        u19 = true;
        u15.Is_Using_Skill = false;
        u15.Is_Attacking = false;
    end;

    local function cleanup() -- Line: 226
        -- upvalues: u19 (ref), u15 (copy), u18 (copy)
        if not u19 then
            u19 = true;
            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
        end;

        if u15.Character then
            u15.Character:SetAttribute("Parry", false);
        end;

        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);
    end;

    u18[#u18 + 1] = v17:GetMarkerReachedSignal("VFX"):Connect(function(p20) -- Line: 234
        -- upvalues: u15 (copy), u14 (ref)
        if not p20 or p20 == "" then
            return;
        end;

        local v21 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if not v21 then
            return;
        end;

        u15:PlayEffectModule(u14.EffectModule, "Emit", v21.CFrame, p20);
    end);
    u18[#u18 + 1] = v17:GetMarkerReachedSignal("hit"):Connect(function(p22) -- Line: 242
        -- upvalues: u15 (copy), SharedUtils (ref), u14 (ref)
        local v23 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if v23 then
            SharedUtils.PlaySoundAt(v23, u14.HitSFX, u14.HitVolume);
        end;

        u15:ShakeCamera("Hit");
        u14._PerformHit(u15, u14.DamageMultiplier, u14.HitboxSize, u14.HitboxRange);
    end);
    u18[#u18 + 1] = v17:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v17.Stopped:Once(cleanup);
    task.delay(u14.MaxDuration, cleanup);
end;

function u14.ActivateHold(u24, p25) -- Line: 264
    -- upvalues: u14 (copy), Debris (copy), SharedUtils (copy)
    local v26 = u14._EnsureAnimation(u24, u14.HoldAnimationName);

    if not v26 then
        warn("[Hanafubuki] Hold animation not found");

        return;
    end;

    local Character = u24.Character;
    local v27;

    if Character then
        v27 = Character:FindFirstChild("HumanoidRootPart");
    else
        v27 = Character;
    end;

    if not v27 then
        return;
    end;

    u24.Is_Using_Skill = true;
    u24.Is_Attacking = true;
    Character:SetAttribute("NoKnockback", true);
    Character:SetAttribute("Skill_Camera_Stabilize", true);

    for i, v in u24.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v26:Play(0, 1, 1);
    local u28 = {};

    local function _() -- Line: 297
        -- upvalues: u28 (copy)
        for _, v in u28 do
            v:Disconnect();
        end;

        table.clear(u28);
    end;

    local u29 = 0;

    local function grantDodge() -- Line: 305
        -- upvalues: u29 (ref), u24 (copy), u14 (ref)
        u29 = u29 + 1;
        local u30 = u29;

        if u24.Player then
            u24.Player:SetAttribute("iFrame", true);
        end;

        if u24.Character then
            u24.Character:SetAttribute("iFrame", true);
        end;

        task.delay(u14.IFrameDuration, function() -- Line: 310
            -- upvalues: u30 (copy), u29 (ref), u24 (ref)
            if u30 ~= u29 then
                return;
            end;

            local Player = u24.Player;
            local Character2 = u24.Character;

            if Player then
                Player:SetAttribute("iFrame", false);
            end;

            if Character2 then
                Character2:SetAttribute("iFrame", false);
            end;
        end);
    end;

    local function clearIFrame() -- Line: 318
        -- upvalues: u24 (copy)
        if u24.Player then
            u24.Player:SetAttribute("iFrame", false);
        end;

        if u24.Character then
            u24.Character:SetAttribute("iFrame", false);
        end;
    end;

    local function freezeHRP() -- Line: 326
        -- upvalues: u24 (copy)
        local v31 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if v31 then
            v31.Anchored = true;
        end;
    end;

    local function unfreezeHRP() -- Line: 330
        -- upvalues: u24 (copy)
        local v32 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if v32 then
            v32.Anchored = false;
        end;
    end;

    local u33 = false;
    local u34 = nil;

    local function stopField() -- Line: 338
        -- upvalues: u33 (ref), u34 (ref)
        u33 = false;

        if u34 then
            pcall(task.cancel, u34);
            u34 = nil;
        end;
    end;

    local u35 = false;

    local function _() -- Line: 348
        -- upvalues: u35 (ref), u24 (copy)
        if u35 then
            return;
        end;

        u35 = true;
        u24.Is_Using_Skill = false;
        u24.Is_Attacking = false;
    end;

    local function v37() -- Line: 356
        -- upvalues: u33 (ref), u34 (ref), u24 (copy), u28 (copy), u35 (ref)
        u33 = false;

        if u34 then
            pcall(task.cancel, u34);
            u34 = nil;
        end;

        local v36 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if v36 then
            v36.Anchored = false;
        end;

        for _, v in u28 do
            v:Disconnect();
        end;

        table.clear(u28);

        if not u35 then
            u35 = true;
            u24.Is_Using_Skill = false;
            u24.Is_Attacking = false;
        end;

        if u24.Player then
            u24.Player:SetAttribute("iFrame", false);
        end;

        if u24.Character then
            u24.Character:SetAttribute("iFrame", false);
        end;

        if u24.Character then
            u24.Character:SetAttribute("Skill_Camera_Stabilize", false);
            u24.Character:SetAttribute("NoKnockback", false);
        end;
    end;

    u28[#u28 + 1] = v26:GetMarkerReachedSignal("dash"):Connect(function() -- Line: 369
        -- upvalues: u24 (copy), u14 (ref), Debris (ref)
        local v38 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if not v38 then
            return;
        end;

        local Humanoid = u24.Humanoid;
        local v39 = Humanoid and (Humanoid.MoveDirection.Magnitude > 0 and Humanoid.MoveDirection.Unit) or v38.CFrame.LookVector;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v39 * u14.DashSpeed;
        BodyVelocity.Parent = v38;
        Debris:AddItem(BodyVelocity, u14.DashDuration);
    end);
    local u40 = false;
    u28[#u28 + 1] = v26:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 389
        -- upvalues: u40 (ref), u24 (copy), SharedUtils (ref), u14 (ref), grantDodge (copy), u33 (ref), u34 (ref)
        if u40 then
            return;
        end;

        u40 = true;
        local v41 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if v41 then
            SharedUtils.PlaySoundAt(v41, u14.StartSFX, u14.StartVolume);
        end;

        local v42 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if v42 then
            v42.Anchored = true;
        end;

        grantDodge();
        u33 = true;
        u34 = task.spawn(function() -- Line: 403
            -- upvalues: u33 (ref), u24 (ref), u14 (ref)
            while u33 and (u24.Character and u24.Character.Parent) do
                u14._PerformHit(u24, u14.TickDamage, u14.HoldHitboxSize, u14.HoldHitboxRange);
                u24:PlayCombatSound(u14.HoldSwingSFXFolder, nil, u24.ClassData.SwingVolume or 1);
                u24:ShakeCamera("SkillMedium");
                task.wait(u14.TickInterval);
            end;
        end);
    end);
    u28[#u28 + 1] = v26:GetMarkerReachedSignal("End"):Connect(function() -- Line: 416
        -- upvalues: u33 (ref), u34 (ref), u24 (copy), grantDodge (copy)
        u33 = false;

        if u34 then
            pcall(task.cancel, u34);
            u34 = nil;
        end;

        local v43 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if v43 then
            v43.Anchored = false;
        end;

        grantDodge();
    end);
    u28[#u28 + 1] = v26:GetMarkerReachedSignal("VFX"):Connect(function(p44) -- Line: 424
        -- upvalues: u24 (copy), u14 (ref)
        if not p44 or p44 == "" then
            return;
        end;

        local v45 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if not v45 then
            return;
        end;

        u24:PlayEffectModule(u14.HoldEffectModule, "Emit", v45.CFrame, p44);
    end);
    u28[#u28 + 1] = v26:GetMarkerReachedSignal("hit"):Connect(function(p46) -- Line: 432
        -- upvalues: u24 (copy), SharedUtils (ref), u14 (ref)
        local v47 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if v47 then
            SharedUtils.PlaySoundAt(v47, u14.FinalSFX, u14.FinalVolume);
        end;

        u24:ShakeCamera("SkillHeavy");
        u14._PerformHit(u24, u14.FinalDamage, u14.HoldHitboxSize, u14.HoldHitboxRange);
    end);
    u28[#u28 + 1] = v26:GetMarkerReachedSignal("DBreset"):Connect(v37);
    v26.Stopped:Once(v37);
    task.delay(u14.HoldMaxDuration, v37);
end;

return u14;