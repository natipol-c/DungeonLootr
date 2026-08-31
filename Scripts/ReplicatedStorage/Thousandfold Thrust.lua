--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Thousandfold Thrust
  Path:     game.ReplicatedStorage.Classes.Founder.Skills.Thousandfold Thrust
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
    Cooldown = 8,
    DamageMultiplier = 0.85,
    AnimationName = "Ability_2",
    EffectModule = "Thousandfold_Thrust",
    HitboxSize = Vector3.new(28, 20, 30),
    HitboxRange = 25,
    StepSpeed = 35,
    StepDuration = 0.12,
    SwingVolume = 0.5,
    MaxDuration = 2.7,

    CanActivate = function(p1) -- Line: 56, Name: CanActivate
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

function u2.Activate(u3, p4) -- Line: 64
    -- upvalues: SkillRuntime (copy), u2 (copy), Debris (copy), SharedUtils (copy)
    local v5 = SkillRuntime.EnsureAnimation(u3, u2.AnimationName);

    if not v5 then
        warn("[Thousandfold Thrust] Animation not found");

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
    v5:Play(0, 1, 1);
    local v6 = SkillRuntime.MakeLifecycle(u3, v5, u2.MaxDuration, function() -- Line: 83
        -- upvalues: u3 (copy)
        u3.Is_Using_Skill = false;
        u3.Is_Attacking = false;
    end);

    for _, v in SkillRuntime.BindVFXMarkers(u3, v5, u2.EffectModule, 4) do
        table.insert(v6.conns, v);
    end;

    v6.conns[#v6.conns + 1] = v5:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 94
        -- upvalues: u3 (copy), u2 (ref), Debris (ref), SharedUtils (ref), SkillRuntime (ref)
        local v7 = u3.Character and u3.Character:FindFirstChild("HumanoidRootPart");

        if not v7 then
            return;
        end;

        local v8 = u3.Humanoid and u3.Humanoid.MoveDirection;
        local v9 = v8 and (v8.Magnitude > 0.1 and v8.Unit) or v7.CFrame.LookVector;
        local Vector3_new_ret = Vector3.new(v9.X, 0, v9.Z);
        local v10 = Vector3_new_ret.Magnitude > 0 and Vector3_new_ret.Unit or v7.CFrame.LookVector;
        local ThousandfoldStep = v7:FindFirstChild("ThousandfoldStep");

        if ThousandfoldStep then
            ThousandfoldStep:Destroy();
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "ThousandfoldStep";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v10 * u2.StepSpeed;
        BodyVelocity.Parent = v7;
        Debris:AddItem(BodyVelocity, u2.StepDuration);
        SharedUtils.BroadcastCombatSound(u3.ClassData.SwingSoundFolder or "Sword_Swings", v7, u2.SwingVolume);
        u3:ShakeCamera("SkillLight");
        SkillRuntime.HitboxSweep(u3, {
            Size = u2.HitboxSize,
            Range = u2.HitboxRange,
            Multiplier = u2.DamageMultiplier
        });
    end);
    v6.conns[#v6.conns + 1] = v5:GetMarkerReachedSignal("DBreset"):Connect(v6.cleanup);
end;

return u2;