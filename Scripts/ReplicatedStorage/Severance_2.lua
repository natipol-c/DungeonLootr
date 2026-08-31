--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Severance
  Path:     game.ReplicatedStorage.Classes.Cursed Child.Skills.Severance
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
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u2 = {
    MaxCharges = 3,
    Cooldown = 8,
    AnimationName = "Ability_2",
    EffectModule = "Severance",
    Skill_SFX = nil,
    DashSpeed = 95,
    DashDuration = 0.12,
    DamageMultiplier = 4,
    HitboxSize = Vector3.new(26, 10, 29),
    HitboxRange = 29,
    CastSFX = "Dark_Echo",
    CastVolume = 1,
    SwingFolder = "Magic_Swings",
    CloneCount = 3,
    CloneInterval = 0.06,
    CloneFadeDuration = 1,
    CloneColor = Color3.fromRGB(150, 50, 200),
    MaxDuration = 1.2
};

local function applyDash(p3) -- Line: 76
    -- upvalues: u2 (copy), Debris (copy)
    local v4 = p3.Character and p3.Character:FindFirstChild("HumanoidRootPart");

    if not v4 then
        return;
    end;

    local _lastSkillDir = p3._lastSkillDir;

    if not _lastSkillDir then
        local Humanoid = p3.Humanoid;

        if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
            _lastSkillDir = Humanoid.MoveDirection.Unit;
        end;
    end;

    local v5 = _lastSkillDir or v4.CFrame.LookVector;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v5 * u2.DashSpeed;
    BodyVelocity.Parent = v4;
    Debris:AddItem(BodyVelocity, u2.DashDuration);
end;

local function spawnClones(u6) -- Line: 98
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return;
    end;

    task.spawn(function() -- Line: 100
        -- upvalues: u2 (ref), u6 (copy), u1 (ref)
        for i = 1, u2.CloneCount do
            if not u6.Is_Using_Skill then
                break;
            end;

            u1:FireAllClients(u6.Player, {
                Action = "Clone",
                FadeDuration = u2.CloneFadeDuration,
                Color = u2.CloneColor
            });
            local v7;

            if i < u2.CloneCount then
                task.wait(u2.CloneInterval);
                v7 = i;
            else
                v7 = i;
            end;
        end;
    end);
end;

function u2.CanActivate(p8) -- Line: 117
    if p8.Is_Attacking then
        return false, "Attacking";
    end;

    if p8.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p8.Is_Dodging then
        return false, "Dodging";
    end;

    if p8.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u2.Activate(u9, p10) -- Line: 125
    -- upvalues: SkillRuntime (copy), u2 (copy), applyDash (copy), u1 (copy), SharedUtils (copy)
    local v11 = SkillRuntime.EnsureAnimation(u9, u2.AnimationName);

    if not v11 then
        warn("[Severance] Animation not found");

        return;
    end;

    local Character = u9.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u9.Is_Using_Skill = true;
    u9.Is_Attacking = true;
    SkillRuntime.StopAttackAnims(u9);
    applyDash(u9);

    if u1 then
        task.spawn(function() -- Line: 100
            -- upvalues: u2 (ref), u9 (copy), u1 (ref)
            for i = 1, u2.CloneCount do
                if not u9.Is_Using_Skill then
                    break;
                end;

                u1:FireAllClients(u9.Player, {
                    Action = "Clone",
                    FadeDuration = u2.CloneFadeDuration,
                    Color = u2.CloneColor
                });
                local v12;

                if i < u2.CloneCount then
                    task.wait(u2.CloneInterval);
                    v12 = i;
                else
                    v12 = i;
                end;
            end;
        end);
    end;

    SharedUtils.PlaySoundAt(Character, u2.CastSFX, u2.CastVolume);
    SharedUtils.BroadcastCombatSound(u2.SwingFolder, Character, 1);
    v11:Play(0, 1, 1);
    local v13 = SkillRuntime.MakeLifecycle(u9, v11, u2.MaxDuration, function() -- Line: 150
        -- upvalues: u9 (copy)
        u9.Is_Using_Skill = false;
        u9.Is_Attacking = false;
    end);

    for _, v in SkillRuntime.BindVFXMarkers(u9, v11, u2.EffectModule) do
        v13.conns[#v13.conns + 1] = v;
    end;

    v13.conns[#v13.conns + 1] = v11:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 161
        -- upvalues: u9 (copy), SkillRuntime (ref), u2 (ref)
        u9:ShakeCamera("SkillLight");
        SkillRuntime.HitboxSweep(u9, {
            Multiplier = u2.DamageMultiplier,
            Size = u2.HitboxSize,
            Range = u2.HitboxRange
        });
    end);
    v13.conns[#v13.conns + 1] = v11:GetMarkerReachedSignal("DBreset"):Connect(v13.cleanup);
end;

return u2;