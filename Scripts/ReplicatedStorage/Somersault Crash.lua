--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Somersault Crash
  Path:     game.ReplicatedStorage.Classes.Founder.Skills.Somersault Crash
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
    Cooldown = 10,
    DamageMultiplier = 4,
    AnimationName = "Ability_1",
    EffectModule = "Somersault_Crash",
    HitboxSize = Vector3.new(40, 40, 40),
    HitboxRange = 0,
    LeapSpeed = 49,
    LeapUpSpeed = 29,
    LeapDuration = 0.2,
    ParryDuration = 0.6,
    CDResetSlot = 3,
    CDResetChance = 0.35,
    CastSFX = "Wukong_Cast1",
    CastVolume = 1,
    HitSFX = "Wukong_Smash1",
    HitVolume = 0.9,
    MaxDuration = 2.6,

    CanActivate = function(p1) -- Line: 72, Name: CanActivate
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

function u2.Activate(u3, p4) -- Line: 80
    -- upvalues: SkillRuntime (copy), u2 (copy), SharedUtils (copy), Debris (copy)
    local v5 = SkillRuntime.EnsureAnimation(u3, u2.AnimationName);

    if not v5 then
        warn("[Somersault Crash] Animation not found");

        return;
    end;

    local Character = u3.Character;
    local v6;

    if Character then
        v6 = Character:FindFirstChild("HumanoidRootPart");
    else
        v6 = Character;
    end;

    if not v6 then
        return;
    end;

    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    local u7 = SkillRuntime.AnchorHRP(u3);
    u7(true);
    Character:SetAttribute("Skill_Camera_Stabilize", true);
    SharedUtils.PlaySoundAt(v6, u2.CastSFX, u2.CastVolume);
    SkillRuntime.StopAttackAnims(u3);
    v5:Play(0, 1, 1);
    local v8 = SkillRuntime.MakeLifecycle(u3, v5, u2.MaxDuration, function() -- Line: 109
        -- upvalues: u7 (copy), u3 (copy)
        u7(false);
        u3.Is_Using_Skill = false;
        u3.Is_Attacking = false;

        if u3.Character then
            u3.Character:SetAttribute("Parry", false);
            u3.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;
    end);

    for _, v in SkillRuntime.BindVFXMarkers(u3, v5, u2.EffectModule, 4) do
        table.insert(v8.conns, v);
    end;

    local u9 = false;
    v8.conns[#v8.conns + 1] = v5:GetMarkerReachedSignal("VFX_2"):Connect(function(p10) -- Line: 126
        -- upvalues: u3 (copy), u2 (ref), u9 (ref), u7 (copy), Debris (ref)
        if p10 ~= "Start" then
            if p10 == "BeforeHit" then
                if u9 then
                    return;
                end;

                local v11 = u3.Character and u3.Character:FindFirstChild("HumanoidRootPart");

                if not v11 then
                    return;
                end;

                u9 = true;
                u7(false);
                local _lastSkillDir = u3._lastSkillDir;

                if not _lastSkillDir then
                    local v12 = u3.Humanoid and u3.Humanoid.MoveDirection;
                    _lastSkillDir = v12 and (v12.Magnitude > 0.1 and v12.Unit) or v11.CFrame.LookVector;
                end;

                local Vector3_new_ret = Vector3.new(_lastSkillDir.X, 0, _lastSkillDir.Z);
                local v13 = Vector3_new_ret.Magnitude > 0 and Vector3_new_ret.Unit or v11.CFrame.LookVector;
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.Name = "SomersaultLeap";
                BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
                BodyVelocity.Velocity = v13 * u2.LeapSpeed + Vector3.new(0, u2.LeapUpSpeed, 0);
                BodyVelocity.Parent = v11;
                Debris:AddItem(BodyVelocity, u2.LeapDuration);
                u3:ShakeCamera("SkillLight");
            end;

            return;
        end;

        if u3.Character then
            u3.Character:SetAttribute("Parry", true);
        end;

        task.delay(u2.ParryDuration, function() -- Line: 130
            -- upvalues: u3 (ref)
            if u3.Character then
                u3.Character:SetAttribute("Parry", false);
            end;
        end);
    end);
    v8.conns[#v8.conns + 1] = v5:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 168
        -- upvalues: u3 (copy), SharedUtils (ref), u2 (ref), SkillRuntime (ref)
        local v14 = u3.Character and u3.Character:FindFirstChild("HumanoidRootPart");

        if v14 then
            SharedUtils.PlaySoundAt(v14, u2.HitSFX, u2.HitVolume);
        end;

        u3:ShakeCamera("SkillHeavy");
        SkillRuntime.HitboxSweep(u3, {
            Size = u2.HitboxSize,
            Range = u2.HitboxRange,
            Multiplier = u2.DamageMultiplier
        });

        if not u3._SkillCloneCast and math.random() < u2.CDResetChance then
            u3:RefreshSkillCooldown(u2.CDResetSlot);
        end;
    end);
    v8.conns[#v8.conns + 1] = v5:GetMarkerReachedSignal("DBreset"):Connect(v8.cleanup);
end;

return u2;