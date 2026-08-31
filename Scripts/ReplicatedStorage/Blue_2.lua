--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Blue
  Path:     game.ReplicatedStorage.Classes.Honored One.Skills.Blue
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:53 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u1 = {
    Cooldown = 12,
    AnimationName = "Ability_1",
    EffectModule = "Blue",
    TickMultiplier = 0.25,
    TickInterval = 0.08,
    MaxHits = 26,
    TickHitboxSize = Vector3.new(30, 30, 30),
    TickHitboxRange = 30,
    FinisherMultiplier = 0.8,
    FinisherHitboxSize = Vector3.new(30, 30, 30),
    FinisherHitboxRange = 30,
    PullCenterDistance = 15,
    PullRadius = 24,
    PullStrength = 55,
    PullInterval = 0.12,
    PullBVLifetime = 0.15,
    IFrameDuration = 2,
    StartSFX = "Blue_Spell_Fast",
    StartVolume = 1,
    EndSFX = "explosion_punch",
    EndVolume = 3,
    MaxDuration = 3
};

local function startPull(u2) -- Line: 89
    -- upvalues: u1 (copy), Debris (copy)
    local Character = u2.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local u3 = true;
    task.spawn(function() -- Line: 94
        -- upvalues: u3 (ref), u2 (copy), Character (copy), u1 (ref), Debris (ref)
        while u3 and (u2.Is_Using_Skill and (Character and Character.Parent)) do
            local v4 = Character.Position + Character.CFrame.LookVector * u1.PullCenterDistance;

            for _, v in u2:FindEnemiesNearPosition(v4, u1.PullRadius) do
                local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart then
                    local v5 = v4 - HumanoidRootPart.Position;

                    if v5.Magnitude >= 2 then
                        local BodyVelocity = Instance.new("BodyVelocity");
                        BodyVelocity.Name = "GravityPull";
                        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                        BodyVelocity.Velocity = v5.Unit * u1.PullStrength;
                        BodyVelocity.Parent = HumanoidRootPart;
                        Debris:AddItem(BodyVelocity, u1.PullBVLifetime);
                    end;
                end;
            end;

            task.wait(u1.PullInterval);
        end;
    end);

    return function() -- Line: 118
        -- upvalues: u3 (ref)
        u3 = false;
    end;
end;

function u1.CanActivate(p6) -- Line: 123
    if p6.Is_Attacking then
        return false, "Attacking";
    end;

    if p6.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p6.Is_Dodging then
        return false, "Dodging";
    end;

    if p6.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u7, p8) -- Line: 131
    -- upvalues: SkillRuntime (copy), u1 (copy), SharedUtils (copy), startPull (copy)
    local v9 = SkillRuntime.EnsureAnimation(u7, u1.AnimationName);

    if not v9 then
        warn("[Blue] Animation not found");

        return;
    end;

    local Character = u7.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u7.Is_Using_Skill = true;
    u7.Is_Attacking = true;
    local u10 = SkillRuntime.GrantIFrame(u7, u1.IFrameDuration);
    SkillRuntime.StopAttackAnims(u7);
    v9:Play(0, 1, 1);
    local u11 = nil;
    local u12 = nil;
    local v13 = SkillRuntime.MakeLifecycle(u7, v9, u1.MaxDuration, function() -- Line: 161
        -- upvalues: u11 (ref), u12 (ref), u7 (copy), u10 (copy), u1 (ref), Character (copy)
        if u11 then
            u11();
        end;

        if u12 then
            u12();
        end;

        u7.Is_Using_Skill = false;
        u7.Is_Attacking = false;
        u10();
        u7:PlayEffectModule(u1.EffectModule, "DBreset", Character.CFrame);
    end);
    local conns = v13.conns;
    conns[#conns + 1] = v9:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 174
        -- upvalues: u11 (ref), u7 (copy), u1 (ref), Character (copy), SharedUtils (ref), u12 (ref), startPull (ref), SkillRuntime (ref)
        if u11 then
            return;
        end;

        u7:PlayEffectModule(u1.EffectModule, "Start", Character.CFrame);
        SharedUtils.PlaySoundAt(Character, u1.StartSFX, u1.StartVolume);
        u12 = startPull(u7);
        u11 = SkillRuntime.TickFlurry(u7, {
            Interval = u1.TickInterval,
            MaxHits = u1.MaxHits,
            Hitbox = {
                Multiplier = u1.TickMultiplier,
                Size = u1.TickHitboxSize,
                Range = u1.TickHitboxRange
            },

            onTick = function() -- Line: 194, Name: onTick
                -- upvalues: u7 (ref)
                u7:ShakeCamera("SkillLight");
            end
        });
    end);
    conns[#conns + 1] = v9:GetMarkerReachedSignal("End"):Connect(function() -- Line: 201
        -- upvalues: u11 (ref), u12 (ref), u7 (copy), u1 (ref), Character (copy), SkillRuntime (ref), SharedUtils (ref)
        if u11 then
            u11();
        end;

        if u12 then
            u12();
        end;

        u7:PlayEffectModule(u1.EffectModule, "Detach", Character.CFrame);
        SkillRuntime.HitboxSweep(u7, {
            Multiplier = u1.FinisherMultiplier,
            Size = u1.FinisherHitboxSize,
            Range = u1.FinisherHitboxRange
        });
        SharedUtils.PlaySoundAt(Character, u1.EndSFX, u1.EndVolume);
        u7:ShakeCamera("SkillHeavy");
    end);
    conns[#conns + 1] = v9:GetMarkerReachedSignal("DBreset"):Connect(v13.cleanup);
end;

return u1;