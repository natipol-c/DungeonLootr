--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ink Volley
  Path:     game.ReplicatedStorage.Classes.Wanderer.Skills.Ink Volley
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProjectileUtil = require(ReplicatedStorage.Globals.Modules.ProjectileUtil);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 10,
    MaxCharges = 2,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    MaxProjectiles = 4,
    ProjectileName = "Jade_Projectile",
    ProjectileSpeed = 65,
    ProjectileLifetime = 1.5,
    ProjectileDmgMult = 1.25,
    ProjectileHitbox = Vector3.new(20, 10, 20),
    SpawnOffset = 5,
    HitOncePerTarget = true,
    ProjectileSFX = { "claw_crosscut_01", "claw_crosscut_04", "claw_crosscut_01", "claw_crosscut_03" },
    SFXVolume = 1,
    MaxDuration = 3
};

function u1._EnsureAnimation(p2) -- Line: 55
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

function u1.CanActivate(p7) -- Line: 83
    if p7.Is_Attacking then
        return false, "Attacking";
    end;

    if p7.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p7.Is_Dodging then
        return false, "Dodging";
    end;

    if p7.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u8, p9) -- Line: 91
    -- upvalues: u1 (copy), SharedUtils (copy), ProjectileUtil (copy)
    local v10 = u1._EnsureAnimation(u8);

    if not v10 then
        warn("[Ink Volley] Animation not found");

        return;
    end;

    local Character = u8.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u8.Is_Using_Skill = true;
    u8.Is_Attacking = true;

    for i, v in u8.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v10:Play(0, 2, 2);
    local u11 = 0;
    local u12 = {};
    local u20 = v10:GetMarkerReachedSignal("hit"):Connect(function(p13) -- Line: 122
        -- upvalues: u11 (ref), u1 (ref), u8 (copy), SharedUtils (ref), ProjectileUtil (ref), u12 (copy)
        u11 = u11 + 1;

        if u11 > u1.MaxProjectiles then
            return;
        end;

        local v14 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");
        local v15 = u1.ProjectileSFX[u11];

        if v14 and v15 then
            SharedUtils.PlaySoundAt(v14, v15, u1.SFXVolume);
        end;

        u8:ShakeCamera("Hit");
        local FXTemplate = u8:GetFXTemplate(u1.ProjectileName);

        if not FXTemplate then
            warn("[Ink Volley] FX part not found: " .. u1.ProjectileName);

            return;
        end;

        local v16 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");

        if not v16 then
            return;
        end;

        local v17 = math.random() * 3.141592653589793 * 2;
        local v18 = v16.CFrame * CFrame.new(0, 0, -u1.SpawnOffset) * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.Angles(0, 0, v17);
        local v19 = ProjectileUtil.Launch({
            damageInterval = 0.05,
            activateFX = true,
            sourcePart = FXTemplate,
            origin = v18,
            direction = v16.CFrame.LookVector,
            speed = u1.ProjectileSpeed,
            lifetime = u1.ProjectileLifetime,
            hitboxSize = u1.ProjectileHitbox,
            damageMultiplier = u1.ProjectileDmgMult,
            classState = u8,
            hitOncePerTarget = u1.HitOncePerTarget
        });
        table.insert(u12, v19);
    end);
    local u21 = false;

    local function releaseState() -- Line: 173
        -- upvalues: u21 (ref), u8 (copy)
        if u21 then
            return;
        end;

        u21 = true;
        u8.Is_Using_Skill = false;
        u8.Is_Attacking = false;
    end;

    local u22 = v10:GetMarkerReachedSignal("DBreset"):Connect(releaseState);

    local function cleanup() -- Line: 184
        -- upvalues: u20 (ref), u22 (ref), u21 (ref), u8 (copy)
        if u20 then
            u20:Disconnect();
            u20 = nil;
        end;

        if u22 then
            u22:Disconnect();
            u22 = nil;
        end;

        if u21 then
            return;
        end;

        u21 = true;
        u8.Is_Using_Skill = false;
        u8.Is_Attacking = false;
    end;

    v10.Stopped:Once(function() -- Line: 192
        -- upvalues: u20 (ref), u22 (ref), u21 (ref), u8 (copy)
        if u20 then
            u20:Disconnect();
            u20 = nil;
        end;

        if u22 then
            u22:Disconnect();
            u22 = nil;
        end;

        if u21 then
            return;
        end;

        u21 = true;
        u8.Is_Using_Skill = false;
        u8.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 197
        -- upvalues: u20 (ref), u22 (ref), u21 (ref), u8 (copy)
        if u20 then
            u20:Disconnect();
            u20 = nil;
        end;

        if u22 then
            u22:Disconnect();
            u22 = nil;
        end;

        if u21 then
            return;
        end;

        u21 = true;
        u8.Is_Using_Skill = false;
        u8.Is_Attacking = false;
    end);
end;

return u1;