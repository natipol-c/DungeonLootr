--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Air Type
  Path:     game.ReplicatedStorage.Classes.Chaotic Fist.Skills.Air Type
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:58 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 7,
    DamageMultiplier = 0.5,
    AnimationName = "Ability_1",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(20, 30, 30),
    HitboxRange = 10,
    FloatUpSpeed = 40,
    FloatBackSpeed = 20,
    FloatLaunchDur = 0.35,
    ProjectilesPerHit = 4,
    ProjectileId = "M",
    ProjectileSpeed = 90,
    ProjectileSpread = 12,
    ProjectileTrack = 12,
    ProjectileFan = 10,
    IFrameDuration = 0.7,
    MaxDuration = 2.5
};

function u1._EnsureAnimation(p2) -- Line: 63
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

function u1._PerformHit(p7) -- Line: 89
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    local v9 = 0;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v9 = v9 + 1;
        end;
    end;

    return v9;
end;

function u1._FireProjectiles(p10) -- Line: 114
    -- upvalues: u1 (copy)
    local v11 = p10.Character and p10.Character:FindFirstChild("HumanoidRootPart");

    if not v11 then
        return;
    end;

    local v12 = p10.FX and p10.FX.Air_Type;
    local v13 = p10.FX and p10.FX.Air_Type_2;
    local v14 = v12 and v12.Position or v11.Position + Vector3.new(0, 3, 0);
    local v15 = v13 and v13.Position or v11.Position + Vector3.new(0, 3, 0);
    local v16 = {
        ProjectileId = u1.ProjectileId,
        SpreadAngle = u1.ProjectileSpread,
        TrackSpeed = u1.ProjectileTrack,
        FanAngle = u1.ProjectileFan
    };

    for i = 1, 2 do
        p10:FireProjectile(u1.DamageMultiplier, {
            Origin = v14,
            ProjectileId = v16.ProjectileId,
            SpreadAngle = v16.SpreadAngle,
            TrackSpeed = v16.TrackSpeed,
            FanAngle = v16.FanAngle
        });
        local _ = i;
    end;

    for i = 1, 2 do
        p10:FireProjectile(u1.DamageMultiplier, {
            Origin = v15,
            ProjectileId = v16.ProjectileId,
            SpreadAngle = v16.SpreadAngle,
            TrackSpeed = v16.TrackSpeed,
            FanAngle = v16.FanAngle
        });
        local _ = i;
    end;
end;

function u1.CanActivate(p17) -- Line: 156
    if p17.Is_Attacking then
        return false, "Attacking";
    end;

    if p17.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p17.Is_Dodging then
        return false, "Dodging";
    end;

    if p17.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u18, p19) -- Line: 164
    -- upvalues: u1 (copy), SharedUtils (copy), Debris (copy)
    local v20 = u1._EnsureAnimation(u18);

    if not v20 then
        warn("[Air Type] Animation not found");

        return;
    end;

    local Character = u18.Character;
    local v21;

    if Character then
        v21 = Character:FindFirstChild("HumanoidRootPart");
    else
        v21 = Character;
    end;

    if not v21 then
        return;
    end;

    u18.Is_Using_Skill = true;
    u18.Is_Attacking = true;

    for i, v in u18.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v20:Play(0, 1, 1);
    SharedUtils.PlaySoundAt(v21, "Dark_Dash", 1);
    Character:SetAttribute("Dodge", true);
    task.delay(u1.IFrameDuration, function() -- Line: 194
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    local u22 = nil;

    local function unanchorHrp() -- Line: 204
        -- upvalues: u22 (ref)
        if u22 and u22.Parent then
            u22.Anchored = false;
        end;

        u22 = nil;
    end;

    local u26 = v20:GetMarkerReachedSignal("float"):Connect(function(p23) -- Line: 213
        -- upvalues: u18 (copy), u1 (ref), Debris (ref)
        local v24 = u18.Character and u18.Character:FindFirstChild("HumanoidRootPart");

        if not v24 then
            return;
        end;

        if p23 == "Start" then
            local v25 = -v24.CFrame.LookVector;
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Name = "AirTypeLaunch";
            BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
            BodyVelocity.Velocity = Vector3.new(0, 1, 0) * u1.FloatUpSpeed + v25 * u1.FloatBackSpeed;
            BodyVelocity.Parent = v24;
            Debris:AddItem(BodyVelocity, u1.FloatLaunchDur);
        end;
    end);
    local u27 = 0;
    local u30 = v20:GetMarkerReachedSignal("hit"):Connect(function(u28) -- Line: 234
        -- upvalues: u27 (ref), u18 (copy), u22 (ref), u1 (ref)
        u27 = u27 + 1;

        if u27 == 1 then
            local v29 = u18.Character and u18.Character:FindFirstChild("HumanoidRootPart");

            if v29 then
                v29.Anchored = true;
                u22 = v29;
            end;
        elseif u27 == 2 then
            if u22 and u22.Parent then
                u22.Anchored = false;
            end;

            u22 = nil;
        end;

        u18:PlayCombatSound(u18.ClassData.SwingSoundFolder or "Naoya_Punches", nil, u18.ClassData.SwingVolume or 0.5);

        if u28 and u28 ~= "" then
            u18:SetLoopFX(u28, true);
            task.delay(0.5, function() -- Line: 255
                -- upvalues: u18 (ref), u28 (copy)
                u18:SetLoopFX(u28, false);
            end);
        end;

        u18:PlayTurnFX(nil);
        u18:ShakeCamera("SkillLight");
        u1._PerformHit(u18);
        u1._FireProjectiles(u18);
    end);
    local u31 = false;

    local function releaseState() -- Line: 273
        -- upvalues: u31 (ref), u18 (copy)
        if u31 then
            return;
        end;

        u31 = true;
        u18.Is_Using_Skill = false;
        u18.Is_Attacking = false;
    end;

    local u32 = v20:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v20.Stopped:Once(function() -- Line: 284
        -- upvalues: u31 (ref), u18 (copy), u30 (ref), u26 (ref), u32 (copy), u22 (ref), Character (copy)
        if not u31 then
            u31 = true;
            u18.Is_Using_Skill = false;
            u18.Is_Attacking = false;
        end;

        if u30 then
            u30:Disconnect();
        end;

        if u26 then
            u26:Disconnect();
        end;

        if u32 then
            u32:Disconnect();
        end;

        if u22 and u22.Parent then
            u22.Anchored = false;
        end;

        u22 = nil;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 299
        -- upvalues: u31 (ref), u18 (copy), u30 (ref), u26 (ref), u32 (copy), u22 (ref), Character (copy)
        if not u31 then
            u31 = true;
            u18.Is_Using_Skill = false;
            u18.Is_Attacking = false;
        end;

        if u30 then
            u30:Disconnect();
        end;

        if u26 then
            u26:Disconnect();
        end;

        if u32 then
            u32:Disconnect();
        end;

        if u22 and u22.Parent then
            u22.Anchored = false;
        end;

        u22 = nil;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
end;

return u1;