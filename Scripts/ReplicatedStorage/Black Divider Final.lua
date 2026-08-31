--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Black Divider Final
  Path:     game.ReplicatedStorage.Classes.Anti Magic.Skills.Black Divider Final
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:47 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local ProjectileUtil = require(ReplicatedStorage.Globals.Modules.ProjectileUtil);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_4",
    ProjectileName = "Final_Projectile",
    ProjectileSpeed = 10,
    ProjectileLifetime = 4,
    DamageInterval = 0.25,
    DamageMultiplier = 0.31,
    ProjectileHitbox = Vector3.new(20, 30, 40),
    SpawnOffset = 5,
    FanSpreadAngleDeg = 15,
    MaxDuration = 2
};

function u1._EnsureAnimation(p2) -- Line: 57
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

function u1.CanActivate(p7) -- Line: 85
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

function u1.Activate(u8, p9) -- Line: 93
    -- upvalues: u1 (copy), SharedUtils (copy), ProjectileUtil (copy)
    local v10 = u1._EnsureAnimation(u8);

    if not v10 then
        warn("[Black Divider Final] Animation not found");

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

    v10:Play(0, 1, 1);
    local u18 = v10:GetMarkerReachedSignal("hit"):Connect(function(p11) -- Line: 123
        -- upvalues: u8 (copy), SharedUtils (ref), u1 (ref), ProjectileUtil (ref)
        local v12 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");

        if v12 then
            SharedUtils.PlaySoundAt(v12, "power_spin_04", 1);
            SharedUtils.PlaySoundAt(v12, "explosion_punch", 1);
        end;

        u8:ShakeCamera("SkillHeavy");
        local FXTemplate = u8:GetFXTemplate(u1.ProjectileName);

        if not FXTemplate then
            warn("[Black Divider Final] FX part not found: " .. u1.ProjectileName);

            return;
        end;

        if not v12 then
            return;
        end;

        local v13;

        if FXTemplate:IsA("Model") then
            v13 = FXTemplate.PrimaryPart or FXTemplate;
        else
            v13 = FXTemplate;
        end;

        local _, _, v14 = v13.CFrame:ToEulerAnglesXYZ();

        local function launchProjectile(p15, p16) -- Line: 148
            -- upvalues: ProjectileUtil (ref), FXTemplate (copy), u1 (ref), u8 (ref)
            ProjectileUtil.Launch({
                activateFX = true,
                sourcePart = FXTemplate,
                origin = p15,
                direction = p16,
                speed = u1.ProjectileSpeed,
                lifetime = u1.ProjectileLifetime,
                hitboxSize = u1.ProjectileHitbox,
                damageInterval = u1.DamageInterval,
                damageMultiplier = u1.DamageMultiplier,
                classState = u8
            });
        end;

        if not u8.Player:GetAttribute("Heat_Active") then
            launchProjectile(v12.CFrame * CFrame.new(0, 0, -u1.SpawnOffset) * CFrame.Angles(0, 0, v14), v12.CFrame.LookVector);

            return;
        end;

        local math_rad_ret = math.rad(u1.FanSpreadAngleDeg);

        for _, v in { -math_rad_ret, 0, math_rad_ret } do
            local v17 = v12.CFrame * CFrame.Angles(0, v, 0);
            launchProjectile(v17 * CFrame.new(0, 0, -u1.SpawnOffset) * CFrame.Angles(0, 0, v14), v17.LookVector);
        end;
    end);

    local function cleanup() -- Line: 183
        -- upvalues: u18 (ref), u8 (copy)
        if u18 then
            u18:Disconnect();
            u18 = nil;
        end;

        u8.Is_Using_Skill = false;
        u8.Is_Attacking = false;
    end;

    v10.Stopped:Once(function() -- Line: 191
        -- upvalues: u18 (ref), u8 (copy)
        if u18 then
            u18:Disconnect();
            u18 = nil;
        end;

        u8.Is_Using_Skill = false;
        u8.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 196
        -- upvalues: u8 (copy), u18 (ref)
        if u8.Is_Using_Skill then
            if u18 then
                u18:Disconnect();
                u18 = nil;
            end;

            u8.Is_Using_Skill = false;
            u8.Is_Attacking = false;
        end;
    end);
end;

return u1;