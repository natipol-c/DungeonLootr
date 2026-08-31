--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Pillar of Heaven
  Path:     game.ReplicatedStorage.Classes.Founder.Skills.Pillar of Heaven
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
    Cooldown = 15,
    DamageMultiplier = 5,
    AnimationName = "Ability_3",
    EffectModule = "Pillar_of_Heaven",
    HitboxSize = Vector3.new(30, 40, 30),
    HitboxRange = 25,
    ClimbUpSpeed = 52,
    ClimbFwdSpeed = 12,
    ClimbDuration = 0.25,
    ParryDuration = 0.6,
    IFrameDuration = 1.1,
    CastSFX = "Wukong_Cast2",
    CastVolume = 1,
    SlamSFX = "Wukong_Smash4",
    SlamVolume = 0.9,
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
        warn("[Pillar of Heaven] Animation not found");

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
    Character:SetAttribute("Skill_Camera_Stabilize", true);
    local u7 = SkillRuntime.AnchorHRP(u3);
    u7(true);
    SharedUtils.PlaySoundAt(v6, u2.CastSFX, u2.CastVolume);
    SkillRuntime.StopAttackAnims(u3);
    v5:Play(0, 1, 1);
    local v8 = SkillRuntime.MakeLifecycle(u3, v5, u2.MaxDuration, function() -- Line: 103
        -- upvalues: u7 (copy), u3 (copy)
        u7(false);
        u3.Is_Using_Skill = false;
        u3.Is_Attacking = false;

        if u3.Player then
            u3.Player:SetAttribute("iFrame", false);
        end;

        if u3.Character then
            u3.Character:SetAttribute("iFrame", false);
            u3.Character:SetAttribute("Parry", false);
            u3.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;
    end);

    for _, v in SkillRuntime.BindVFXMarkers(u3, v5, u2.EffectModule, 4) do
        table.insert(v8.conns, v);
    end;

    local u9 = false;
    v8.conns[#v8.conns + 1] = v5:GetMarkerReachedSignal("VFX"):Connect(function(p10) -- Line: 122
        -- upvalues: u3 (copy), u2 (ref), u9 (ref), u7 (copy), SkillRuntime (ref), Debris (ref)
        if p10 ~= "Parry" then
            if p10 == "Spin" then
                if u9 then
                    return;
                end;

                local v11 = u3.Character and u3.Character:FindFirstChild("HumanoidRootPart");

                if not v11 then
                    return;
                end;

                u9 = true;
                u7(false);
                SkillRuntime.GrantIFrame(u3, u2.IFrameDuration);
                local v12 = u3.Humanoid and u3.Humanoid.MoveDirection;
                local v13 = v12 and (v12.Magnitude > 0.1 and v12.Unit) or v11.CFrame.LookVector;
                local Vector3_new_ret = Vector3.new(v13.X, 0, v13.Z);
                local v14 = Vector3_new_ret.Magnitude > 0 and Vector3_new_ret.Unit or v11.CFrame.LookVector;
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.Name = "PillarClimb";
                BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
                BodyVelocity.Velocity = v14 * u2.ClimbFwdSpeed + Vector3.new(0, u2.ClimbUpSpeed, 0);
                BodyVelocity.Parent = v11;
                Debris:AddItem(BodyVelocity, u2.ClimbDuration);
                u3:ShakeCamera("SkillLight");
            end;

            return;
        end;

        if u3.Character then
            u3.Character:SetAttribute("Parry", true);
        end;

        task.delay(u2.ParryDuration, function() -- Line: 126
            -- upvalues: u3 (ref)
            if u3.Character then
                u3.Character:SetAttribute("Parry", false);
            end;
        end);
    end);
    v8.conns[#v8.conns + 1] = v5:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 163
        -- upvalues: u3 (copy), SharedUtils (ref), u2 (ref), SkillRuntime (ref)
        local v15 = u3.Character and u3.Character:FindFirstChild("HumanoidRootPart");

        if v15 then
            SharedUtils.PlaySoundAt(v15, u2.SlamSFX, u2.SlamVolume);
        end;

        u3:ShakeCamera("SkillHeavy");
        SkillRuntime.HitboxSweep(u3, {
            Size = u2.HitboxSize,
            Range = u2.HitboxRange,
            Multiplier = u2.DamageMultiplier
        });
    end);
    v8.conns[#v8.conns + 1] = v5:GetMarkerReachedSignal("DBreset"):Connect(v8.cleanup);
end;

return u2;