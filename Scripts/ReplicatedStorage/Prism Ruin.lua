--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Prism Ruin
  Path:     game.ReplicatedStorage.Classes.Prisma.Skills.Prism Ruin
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    DamageMultiplier = 0.36,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    TickInterval = 0.15,
    HitboxSize = Vector3.new(30, 30, 30),
    HitboxRange = 10,
    MaxDuration = 2.5
};

function u1._EnsureAnimation(p2) -- Line: 45
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

function u1._PerformTick(p7) -- Line: 71
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    p7:ShakeCamera("Hit");

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
        end;
    end;
end;

function u1.CanActivate(p9) -- Line: 96
    if p9.Is_Attacking then
        return false, "Attacking";
    end;

    if p9.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p9.Is_Dodging then
        return false, "Dodging";
    end;

    if p9.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u10, p11) -- Line: 104
    -- upvalues: u1 (copy), RunService (copy), SharedUtils (copy)
    local v12 = u1._EnsureAnimation(u10);

    if not v12 then
        warn("[Prism Ruin] Animation not found");

        return;
    end;

    local Character = u10.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u10.Is_Using_Skill = true;
    u10.Is_Attacking = true;

    for i, v in u10.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v12:Play(0, 1, 1);
    local u13 = nil;
    local u14 = 0;

    local function stopBarrage() -- Line: 133
        -- upvalues: u13 (ref)
        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;
    end;

    local u18 = v12:GetMarkerReachedSignal("hit"):Connect(function(p15) -- Line: 142
        -- upvalues: u10 (copy), u14 (ref), u1 (ref), u13 (ref), RunService (ref), SharedUtils (ref)
        if p15 ~= "Start" then
            if p15 == "End" then
                if u13 then
                    u13:Disconnect();
                    u13 = nil;
                end;

                u10:SetLoopFX("Slash_Barrage", false);
                u10:PlayFX("Rose_Dash");
                local v16 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

                if v16 then
                    SharedUtils.PlaySoundAt(v16, "claw_slam_01", 0.8);
                end;
            end;

            return;
        end;

        u10:SetLoopFX("Slash_Barrage", true);
        u14 = u1.TickInterval;
        u13 = RunService.Heartbeat:Connect(function(p17) -- Line: 149
            -- upvalues: u10 (ref), u13 (ref), u14 (ref), u1 (ref)
            if not (u10.Character and u10.Character.Parent) then
                if u13 then
                    u13:Disconnect();
                    u13 = nil;
                end;

                return;
            end;

            u14 = u14 + p17;

            if u14 >= u1.TickInterval then
                u14 = u14 - u1.TickInterval;
                u1._PerformTick(u10);
            end;
        end);
    end);
    local u19 = nil;
    u19 = v12:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 182
        -- upvalues: u13 (ref), u18 (ref), u10 (copy), u19 (ref)
        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;

        if u18 then
            u18:Disconnect();
        end;

        u10:SetLoopFX("Slash_Barrage", false);
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;

        if u19 then
            u19:Disconnect();
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 195
        -- upvalues: u13 (ref), u10 (copy), u18 (ref)
        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;

        u10:SetLoopFX("Slash_Barrage", false);

        if u10.Is_Using_Skill then
            u10.Is_Using_Skill = false;
            u10.Is_Attacking = false;
        end;

        if u18 then
            u18:Disconnect();
        end;
    end);
end;

return u1;