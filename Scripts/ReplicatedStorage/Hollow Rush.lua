--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hollow Rush
  Path:     game.ReplicatedStorage.Classes.Cursed Child.Skills.Hollow Rush
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:51 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u1 = {
    Cooldown = 7,
    AnimationName = "Ability_1",
    EffectModule = "Hollow_Rush",
    Skill_SFX = nil,
    DashSpeed = 80,
    DashDuration = 0.2,
    IFrameDuration = 0.7,
    HitboxSize = Vector3.new(20, 10, 20),
    HitboxRange = 16,
    HitMultiplier = 0.9,
    FinalMultiplier = 1.6,
    DashSFX = "Sonido",
    MidSFX = "hit_ultema_s_1",
    FinalSFX = "hit_sword_L",
    SFXVolume = 1,
    MaxDuration = 2
};

local function applyDash(p2) -- Line: 75
    -- upvalues: u1 (copy), Debris (copy)
    local v3 = p2.Character and p2.Character:FindFirstChild("HumanoidRootPart");

    if not v3 then
        return;
    end;

    local _lastSkillDir = p2._lastSkillDir;

    if not _lastSkillDir then
        local Humanoid = p2.Humanoid;

        if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
            _lastSkillDir = Humanoid.MoveDirection.Unit;
        end;
    end;

    local v4 = _lastSkillDir or v3.CFrame.LookVector;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v4 * u1.DashSpeed;
    BodyVelocity.Parent = v3;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
end;

local function performHit(p5, p6) -- Line: 97
    -- upvalues: SkillRuntime (copy), u1 (copy)
    SkillRuntime.HitboxSweep(p5, {
        Multiplier = p6,
        Size = u1.HitboxSize,
        Range = u1.HitboxRange
    });
end;

function u1.CanActivate(p7) -- Line: 107
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

function u1.Activate(u8, p9) -- Line: 115
    -- upvalues: SkillRuntime (copy), u1 (copy), applyDash (copy), SharedUtils (copy)
    local v10 = SkillRuntime.EnsureAnimation(u8, u1.AnimationName);

    if not v10 then
        warn("[Hollow Rush] Animation not found");

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
    SkillRuntime.StopAttackAnims(u8);
    v10:Play(0, 1, 1);
    local u11 = nil;
    local v12 = SkillRuntime.MakeLifecycle(u8, v10, u1.MaxDuration, function() -- Line: 137
        -- upvalues: u8 (copy), u11 (ref)
        u8.Is_Using_Skill = false;
        u8.Is_Attacking = false;

        if u11 then
            u11();
        end;
    end);

    for _, v in SkillRuntime.BindVFXMarkers(u8, v10, u1.EffectModule, 3) do
        v12.conns[#v12.conns + 1] = v;
    end;

    v12.conns[#v12.conns + 1] = v10:GetMarkerReachedSignal("dash"):Connect(function() -- Line: 149
        -- upvalues: applyDash (ref), u8 (copy), u11 (ref), SkillRuntime (ref), u1 (ref), SharedUtils (ref)
        applyDash(u8);
        u11 = SkillRuntime.GrantIFrame(u8, u1.IFrameDuration);
        local v13 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");

        if v13 then
            SharedUtils.PlaySoundAt(v13, u1.DashSFX, u1.SFXVolume);
            SharedUtils.BroadcastCombatSound(u8.ClassData.SwingSoundFolder, v13, u8.ClassData.SwingVolume or 1);
        end;

        u8:ShakeCamera("SkillLight");
        SkillRuntime.HitboxSweep(u8, {
            Multiplier = u1.HitMultiplier,
            Size = u1.HitboxSize,
            Range = u1.HitboxRange
        });
    end);
    local u14 = 0;
    v12.conns[#v12.conns + 1] = v10:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 165
        -- upvalues: u14 (ref), u8 (copy), SharedUtils (ref), u1 (ref), SkillRuntime (ref)
        u14 = u14 + 1;
        local v15 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");

        if u14 >= 3 then
            if v15 then
                SharedUtils.PlaySoundAt(v15, u1.FinalSFX, u1.SFXVolume);
            end;

            u8:ShakeCamera("SkillHeavy");
            SkillRuntime.HitboxSweep(u8, {
                Multiplier = u1.FinalMultiplier,
                Size = u1.HitboxSize,
                Range = u1.HitboxRange
            });

            return;
        end;

        if v15 then
            SharedUtils.PlaySoundAt(v15, u1.MidSFX, u1.SFXVolume);
        end;

        u8:ShakeCamera("SkillLight");
        SkillRuntime.HitboxSweep(u8, {
            Multiplier = u1.HitMultiplier,
            Size = u1.HitboxSize,
            Range = u1.HitboxRange
        });
    end);
    v12.conns[#v12.conns + 1] = v10:GetMarkerReachedSignal("DBreset"):Connect(v12.cleanup);
end;

return u1;