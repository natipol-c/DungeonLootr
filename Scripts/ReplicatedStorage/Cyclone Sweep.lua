--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cyclone Sweep
  Path:     game.ReplicatedStorage.Classes.Founder.Skills.Cyclone Sweep
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(game:GetService("ServerScriptService").Management.Modules.SkillRuntime);
local u2 = {
    Cooldown = 7,
    MaxCharges = 2,
    DamageMultiplier = 1.65,
    AnimationName = "Ability_4",
    EffectModule = "Cyclone_Sweep",
    HitboxSize = Vector3.new(30, 30, 30),
    HitboxRange = 25,
    DashSpeed = 60,
    DashDuration = 0.2,
    IFrameDuration = 0.5,
    StepSpeed = 45,
    StepDuration = 0.12,
    DashSFX = "Sonido",
    DashVolume = 1,
    CastSFX = "Wukong_Cast1",
    CastVolume = 1,
    Hit1SFX = "Wukong_Swing1",
    Hit2SFX = "Wukong_Swing3",
    Hit3SFX = "Wukong_Smash3",
    HitVolume = 0.8,
    MaxDuration = 2.4,

    CanActivate = function(p1) -- Line: 68, Name: CanActivate
        if p1.Is_Attacking then
            return false, "Attacking";
        end;

        if p1.Is_Using_Skill then
            return false, "Skill in progress";
        end;

        if p1.Is_Dodging then
            return false, "Dodging";
        end;

        if p1.Is_Stunned then
            return false, "Stunned";
        end;

        return true;
    end
};

function u2.Activate(u3, p4) -- Line: 76
    -- upvalues: SkillRuntime (copy), u2 (copy), SharedUtils (copy), Debris (copy)
    local v5 = SkillRuntime.EnsureAnimation(u3, u2.AnimationName);

    if not v5 then
        warn("[Cyclone Sweep] Animation not found");

        return;
    end;

    local Character = u3.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    SkillRuntime.StopAttackAnims(u3);
    SkillRuntime.GrantIFrame(u3, u2.IFrameDuration);
    local _lastSkillDir = u3._lastSkillDir;

    if not _lastSkillDir then
        local v6 = u3.Humanoid and u3.Humanoid.MoveDirection;
        _lastSkillDir = v6 and (v6.Magnitude > 0.1 and v6.Unit) or Character.CFrame.LookVector;
    end;

    local Vector3_new_ret = Vector3.new(_lastSkillDir.X, 0, _lastSkillDir.Z);
    local v7 = Vector3_new_ret.Magnitude > 0 and Vector3_new_ret.Unit or Character.CFrame.LookVector;
    SharedUtils.PlaySoundAt(Character, u2.DashSFX, u2.DashVolume);
    SharedUtils.PlaySoundAt(Character, u2.CastSFX, u2.CastVolume);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "CycloneDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v7 * u2.DashSpeed;
    BodyVelocity.Parent = Character;
    Debris:AddItem(BodyVelocity, u2.DashDuration);
    v5:Play(0, 1, 1);
    local v8 = SkillRuntime.MakeLifecycle(u3, v5, u2.MaxDuration, function() -- Line: 118
        -- upvalues: u3 (copy)
        u3.Is_Using_Skill = false;
        u3.Is_Attacking = false;

        if u3.Player then
            u3.Player:SetAttribute("iFrame", false);
        end;

        if u3.Character then
            u3.Character:SetAttribute("iFrame", false);
        end;
    end);

    for _, v in SkillRuntime.BindVFXMarkers(u3, v5, u2.EffectModule, 4) do
        table.insert(v8.conns, v);
    end;

    local u9 = 0;
    v8.conns[#v8.conns + 1] = v5:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 132
        -- upvalues: u3 (copy), u9 (ref), u2 (ref), Debris (ref), SharedUtils (ref), SkillRuntime (ref)
        local v10 = u3.Character and u3.Character:FindFirstChild("HumanoidRootPart");

        if not v10 then
            return;
        end;

        u9 = u9 + 1;
        local v11 = u3.Humanoid and u3.Humanoid.MoveDirection;
        local v12 = v11 and (v11.Magnitude > 0.1 and v11.Unit) or v10.CFrame.LookVector;
        local Vector3_new_ret2 = Vector3.new(v12.X, 0, v12.Z);
        local v13 = Vector3_new_ret2.Magnitude > 0 and Vector3_new_ret2.Unit or v10.CFrame.LookVector;
        local CycloneStep = v10:FindFirstChild("CycloneStep");

        if CycloneStep then
            CycloneStep:Destroy();
        end;

        local BodyVelocity2 = Instance.new("BodyVelocity");
        BodyVelocity2.Name = "CycloneStep";
        BodyVelocity2.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity2.Velocity = v13 * u2.StepSpeed;
        BodyVelocity2.Parent = v10;
        Debris:AddItem(BodyVelocity2, u2.StepDuration);
        SharedUtils.PlaySoundAt(v10, u9 == 1 and u2.Hit1SFX or (u9 == 2 and u2.Hit2SFX or u2.Hit3SFX), u2.HitVolume);
        u3:ShakeCamera("SkillMedium");
        SkillRuntime.HitboxSweep(u3, {
            Size = u2.HitboxSize,
            Range = u2.HitboxRange,
            Multiplier = u2.DamageMultiplier
        });
    end);
    v8.conns[#v8.conns + 1] = v5:GetMarkerReachedSignal("DBreset"):Connect(v8.cleanup);
end;

return u2;