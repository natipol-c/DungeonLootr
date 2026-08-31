--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rainstorm
  Path:     game.ReplicatedStorage.Classes.Sinister Trigger.Skills.Rainstorm
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u2 = {
    Cooldown = 8,
    AnimationName = "Ability_3",
    LoopFX = "Rain",
    LiftSpeed = 80,
    LiftDuration = 0.55,
    FreezeDelay = 0.09,
    TickMultiplier = 0.4,
    TickInterval = 0.1,
    MaxHits = 26,
    TickHitboxSize = Vector3.new(50, 40, 50),
    TickHitboxRange = 0,
    IFrameDuration = 2.6,
    ResetSlot = 2,
    ResetChance = 0.15,
    TickSFX = "Revolver_1",
    TickVolume = 0.4,
    MaxDuration = 3.2,
    MinLifetime = 1,

    CanActivate = function(p1) -- Line: 83, Name: CanActivate
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

function u2.Activate(u3, p4) -- Line: 91
    -- upvalues: SkillRuntime (copy), u2 (copy), SharedUtils (copy)
    local v5 = SkillRuntime.EnsureAnimation(u3, u2.AnimationName);

    if not v5 then
        warn("[Rainstorm] Animation not found");

        return;
    end;

    local Character = u3.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    if math.random() < u2.ResetChance and u3:IsSkillOnCooldown(u2.ResetSlot) then
        u3:RefreshSkillCooldown(u2.ResetSlot);
    end;

    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    local u6 = SkillRuntime.GrantIFrame(u3, u2.IFrameDuration);
    SkillRuntime.StopAttackAnims(u3);
    v5:Play(0, 1, 1);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "RainstormLift";
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3.new(0, u2.LiftSpeed, 0);
    BodyVelocity.Parent = Character;
    task.delay(u2.LiftDuration, function() -- Line: 125
        -- upvalues: BodyVelocity (ref)
        if BodyVelocity and BodyVelocity.Parent then
            BodyVelocity.Velocity = Vector3.new(0, 0, 0);
        end;
    end);

    local function releaseLift() -- Line: 130
        -- upvalues: BodyVelocity (ref)
        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;
    end;

    local u7 = SkillRuntime.AnchorHRP(u3);
    local u8 = nil;
    local u9 = false;
    local v10 = SkillRuntime.MakeLifecycle(u3, v5, u2.MaxDuration, function() -- Line: 142
        -- upvalues: u9 (ref), u8 (ref), u7 (copy), BodyVelocity (ref), u3 (copy), u2 (ref), u6 (copy)
        u9 = true;

        if u8 then
            u8();
        end;

        u7(false);

        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;

        u3:SetLoopFX(u2.LoopFX, false);
        u6();
        u3.Is_Using_Skill = false;
        u3.Is_Attacking = false;
    end, u2.MinLifetime);
    local conns = v10.conns;
    conns[#conns + 1] = v5:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 155
        -- upvalues: u8 (ref), u3 (copy), u2 (ref), u9 (ref), BodyVelocity (ref), u7 (copy), SharedUtils (ref), Character (copy), SkillRuntime (ref)
        if u8 then
            return;
        end;

        if not u3.Is_Using_Skill then
            warn("[Rainstorm] Start fired after cast release — re-asserting Is_Using_Skill (flurry would have no-op\'d)");
            u3.Is_Using_Skill = true;
        end;

        task.delay(u2.FreezeDelay, function() -- Line: 169
            -- upvalues: u9 (ref), BodyVelocity (ref), u7 (ref), u3 (ref)
            if u9 then
                return;
            end;

            if BodyVelocity then
                BodyVelocity:Destroy();
                BodyVelocity = nil;
            end;

            u7(true);
            local v11 = u3.Character and u3.Character:FindFirstChild("HumanoidRootPart");

            if v11 then
                v11.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            end;
        end);
        u3:SetLoopFX(u2.LoopFX, true);
        SharedUtils.PlaySoundAt(Character, "Revolver_Spin", 0.6);
        u8 = SkillRuntime.TickFlurry(u3, {
            Interval = u2.TickInterval,
            MaxHits = u2.MaxHits,
            Hitbox = {
                Multiplier = u2.TickMultiplier,
                Size = u2.TickHitboxSize,
                Range = u2.TickHitboxRange
            },

            onTick = function() -- Line: 190, Name: onTick
                -- upvalues: SharedUtils (ref), Character (ref), u2 (ref), u3 (ref)
                SharedUtils.PlaySoundAt(Character, u2.TickSFX, u2.TickVolume, 0.05);
                u3:ShakeCamera("SkillLight");
            end
        });
    end);
    conns[#conns + 1] = v5:GetMarkerReachedSignal("End"):Connect(function() -- Line: 198
        -- upvalues: u9 (ref), u8 (ref), u7 (copy), u3 (copy), u2 (ref)
        u9 = true;

        if u8 then
            u8();
        end;

        u7(false);
        u3:SetLoopFX(u2.LoopFX, false);
        u3:ShakeCamera("SkillMedium");
    end);
    conns[#conns + 1] = v5:GetMarkerReachedSignal("DBreset"):Connect(v10.cleanup);
end;

return u2;