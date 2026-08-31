--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Crossfire
  Path:     game.ReplicatedStorage.Classes.Sinister Trigger.Skills.Crossfire
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u2 = {
    Cooldown = 6,
    MaxCharges = 3,
    DamageMultiplier = 1.6,
    GroundHitCount = 4,
    AnimationName = "Ability_1",
    EnhanceChance = 0.1,
    EnhanceDamageMult = 1.3,
    EnhancedFX = "Demon_Shot",
    NormalFX = "Shot",
    HitboxSize = Vector3.new(20, 12, 27),
    HitboxRange = 27,
    DashSpeed = 45,
    DashDuration = 0.1,
    DodgeDuration = 1.1,
    CloneFadeDuration = 0.8,
    CloneColor = Color3.fromRGB(255, 240, 150),
    AirAnimationName = "Ability_1_Air",
    AirFX = "Center_Slash",
    AirHitSFX = "claw_slam_01",
    AirHitVolume = 0.9,
    AirHitboxSize = Vector3.new(22, 50, 30),
    AirHitboxRange = 30,
    AirFreezeTime = 0.15,
    AirSlamSpeed = 120,
    AirSlamDuration = 0.45,
    MaxDuration = 1.6
};

function u2._PerformHit(p3, p4, p5, p6) -- Line: 93
    -- upvalues: u2 (copy)
    local HitboxSize = p3.ClassData.HitboxSize;
    local Range = p3.ClassData.Range;
    p3.ClassData.HitboxSize = p5 or u2.HitboxSize;
    p3.ClassData.Range = p6 or u2.HitboxRange;
    local v7 = p3:Hitbox();
    p3.ClassData.HitboxSize = HitboxSize;
    p3.ClassData.Range = Range;
    local v8 = {};

    for _, v in v7 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p3:ApplyDamage(v, (p3:ResolveSkillDamage(p4, v)));
            table.insert(v8, v);
        end;
    end;

    return v8;
end;

function u2._SpawnClone(p9) -- Line: 116
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return;
    end;

    u1:FireAllClients(p9.Player, {
        Action = "Clone",
        FadeDuration = u2.CloneFadeDuration,
        Color = u2.CloneColor
    });
end;

function u2._AirLaunch(u10) -- Line: 129
    -- upvalues: u2 (copy), Debris (copy)
    local Character = u10.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "CrossfireAirFreeze";
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
    BodyVelocity.Parent = Character;
    task.delay(u2.AirFreezeTime, function() -- Line: 140
        -- upvalues: BodyVelocity (copy), u10 (copy), u2 (ref), Debris (ref)
        if BodyVelocity then
            BodyVelocity:Destroy();
        end;

        local v11 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if not v11 then
            return;
        end;

        local BodyVelocity2 = Instance.new("BodyVelocity");
        BodyVelocity2.Name = "CrossfireAirSlam";
        BodyVelocity2.MaxForce = Vector3.new(100000, 100000, 100000);
        BodyVelocity2.Velocity = Vector3.new(0, -u2.AirSlamSpeed, 0);
        BodyVelocity2.Parent = v11;
        Debris:AddItem(BodyVelocity2, u2.AirSlamDuration);
    end);
end;

function u2._SetSlashWeapons(p12, p13) -- Line: 159
    if not p12 then
        return;
    end;

    local Left_Arm = p12:FindFirstChild("Left_Arm", true);
    local Right_Arm = p12:FindFirstChild("Right_Arm", true);

    if Left_Arm then
        Left_Arm = Left_Arm:FindFirstChild("Left_Gun");
    end;

    local v14;

    if Right_Arm then
        v14 = Right_Arm:FindFirstChild("Right_Gun");
    else
        v14 = Right_Arm;
    end;

    if Right_Arm then
        Right_Arm = Right_Arm:FindFirstChild("Sword");
    end;

    if Left_Arm then
        Left_Arm.Transparency = p13 and 1 or 0;
    end;

    if v14 then
        v14.Transparency = p13 and 1 or 0;
    end;

    if Right_Arm then
        Right_Arm.Transparency = p13 and 0 or 1;
    end;
end;

function u2.CanActivate(p15) -- Line: 173
    if p15.Is_Attacking then
        return false, "Attacking";
    end;

    if p15.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p15.Is_Dodging then
        return false, "Dodging";
    end;

    if p15.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u2.Activate(p16, p17) -- Line: 184
    -- upvalues: u2 (copy)
    local v18 = math.random() < u2.EnhanceChance;

    if p16.IsInAir and p16:IsInAir() then
        u2._ActivateAir(p16, v18);

        return;
    end;

    u2._ActivateGround(p16, v18);
end;

function u2._ActivateGround(u19, p20) -- Line: 195
    -- upvalues: SkillRuntime (copy), u2 (copy), Debris (copy), SharedUtils (copy)
    local v21 = SkillRuntime.EnsureAnimation(u19, u2.AnimationName);

    if not v21 then
        warn("[Crossfire] Animation not found");

        return;
    end;

    local Character = u19.Character;
    local v22;

    if Character then
        v22 = Character:FindFirstChild("HumanoidRootPart");
    else
        v22 = Character;
    end;

    if not v22 then
        return;
    end;

    local u23 = u2.DamageMultiplier * (p20 and u2.EnhanceDamageMult or 1);
    local u24 = p20 and u2.EnhancedFX or u2.NormalFX;
    u19.Is_Using_Skill = true;
    u19.Is_Attacking = true;
    Character:SetAttribute("Dodge", true);
    task.delay(u2.DodgeDuration, function() -- Line: 215
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);

    for i, v in u19.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v21:Play(0, 1, 1);
    local u28 = v21:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 230
        -- upvalues: u19 (copy), u24 (copy), u2 (ref), Debris (ref), SharedUtils (ref), u23 (copy)
        local v25 = u19.Character and u19.Character:FindFirstChild("HumanoidRootPart");

        if not v25 then
            return;
        end;

        u19:PlayFX(u24);
        u19:ShakeCamera("SkillLight");
        u2._SpawnClone(u19);
        local Humanoid = u19.Humanoid;
        local v26;

        if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
            v26 = Humanoid.MoveDirection.Unit;
        else
            v26 = v25.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v26 * u2.DashSpeed;
        BodyVelocity.Parent = v25;
        Debris:AddItem(BodyVelocity, u2.DashDuration);
        SharedUtils.PlaySoundAt(v25, "Revolver_1", 0.6, 0.06);
        local v27 = u2._PerformHit(u19, u23);

        if #v27 > 0 then
            u19:_FireMasteryPassive("OnSkillHit", {
                HitTargets = v27
            });
        end;
    end);
    local u30 = v21:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 267
        -- upvalues: u19 (copy), SharedUtils (ref)
        local v29 = u19.Character and u19.Character:FindFirstChild("HumanoidRootPart");

        if v29 then
            SharedUtils.PlaySoundAt(v29, "Revolver_Spin", 0.7);
        end;
    end);
    v21.Stopped:Once(function() -- Line: 273
        -- upvalues: u28 (ref), u30 (ref), u19 (copy), Character (copy)
        if u28 then
            u28:Disconnect();
        end;

        if u30 then
            u30:Disconnect();
        end;

        u19.Is_Using_Skill = false;
        u19.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    task.delay(u2.MaxDuration, function() -- Line: 284
        -- upvalues: u19 (copy), u28 (ref), u30 (ref), Character (copy)
        if u19.Is_Using_Skill then
            u19.Is_Using_Skill = false;
            u19.Is_Attacking = false;
        end;

        if u28 then
            u28:Disconnect();
        end;

        if u30 then
            u30:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
end;

function u2._ActivateAir(u31, p32) -- Line: 297
    -- upvalues: SkillRuntime (copy), u2 (copy), SharedUtils (copy)
    local v33 = SkillRuntime.EnsureAnimation(u31, u2.AirAnimationName);

    if not v33 then
        warn("[Crossfire] Air animation not found");

        return;
    end;

    local Character = u31.Character;
    local v34;

    if Character then
        v34 = Character:FindFirstChild("HumanoidRootPart");
    else
        v34 = Character;
    end;

    if not v34 then
        return;
    end;

    local u35 = u2.DamageMultiplier * u2.GroundHitCount * (p32 and u2.EnhanceDamageMult or 1);
    u31.Is_Using_Skill = true;
    u31.Is_Attacking = true;
    Character:SetAttribute("Dodge", true);
    task.delay(u2.DodgeDuration, function() -- Line: 318
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    SkillRuntime.StopAttackAnims(u31);
    v33:Play(0, 1, 1);
    u2._SetSlashWeapons(Character, true);
    u2._AirLaunch(u31);
    local u38 = v33:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 333
        -- upvalues: u31 (copy), u2 (ref), SharedUtils (ref), u35 (copy)
        local v36 = u31.Character and u31.Character:FindFirstChild("HumanoidRootPart");

        if not v36 then
            return;
        end;

        u31:PlayFX(u2.AirFX);
        u31:ShakeCamera("SkillMedium");
        SharedUtils.PlaySoundAt(v36, u2.AirHitSFX, u2.AirHitVolume);
        local v37 = u2._PerformHit(u31, u35, u2.AirHitboxSize, u2.AirHitboxRange);

        if #v37 > 0 then
            u31:_FireMasteryPassive("OnSkillHit", {
                HitTargets = v37
            });
        end;
    end);
    local u39 = v33:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 352
        -- upvalues: u2 (ref), Character (copy)
        u2._SetSlashWeapons(Character, false);
    end);
    v33.Stopped:Once(function() -- Line: 357
        -- upvalues: u38 (ref), u39 (ref), u2 (ref), Character (copy), u31 (copy)
        if u38 then
            u38:Disconnect();
        end;

        if u39 then
            u39:Disconnect();
        end;

        u2._SetSlashWeapons(Character, false);
        u31.Is_Using_Skill = false;
        u31.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    task.delay(u2.MaxDuration, function() -- Line: 367
        -- upvalues: u31 (copy), u38 (ref), u39 (ref), u2 (ref), Character (copy)
        if u31.Is_Using_Skill then
            u31.Is_Using_Skill = false;
            u31.Is_Attacking = false;
        end;

        if u38 then
            u38:Disconnect();
        end;

        if u39 then
            u39:Disconnect();
        end;

        u2._SetSlashWeapons(Character, false);

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
end;

return u2;