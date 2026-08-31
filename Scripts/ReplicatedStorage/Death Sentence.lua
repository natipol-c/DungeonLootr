--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Death Sentence
  Path:     game.ReplicatedStorage.Classes.Hitman.Skills.Death Sentence
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {};
local u2 = { "Right_Slash", "Left_Slash", "Center_Slash" };
local u3 = { "power_spin_02", "power_spin_01" };
u1.Cooldown = 15;
u1.AnimationName = "Ability_2";
u1.TickInterval = 0.15;
u1.TickMultiplier = 0.45;
u1.TickHitboxSize = Vector3.new(24, 12, 24);
u1.TickHitboxRange = 22;
u1.FinisherMultiplier = 0.85;
u1.FinisherHitCount = 2;
u1.FinalHitMultiplier = 1.7;
u1.FinalHitSFX = "claw_slam_01";
u1.FinalHitVolume = 1;
u1.SheatheVolume = 0.8;
u1.MaxDuration = 6;

function u1._EnsureAnimation(p4) -- Line: 63
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p4.Animations[AnimationName] then
        return p4.Animations[AnimationName];
    end;

    local v5 = ReplicatedStorage.Classes:FindFirstChild(p4.ClassName);

    if not v5 then
        return nil;
    end;

    local Skill_Animations = v5:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v6 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v6 then
        return nil;
    end;

    local v7 = p4.Humanoid and p4.Humanoid:FindFirstChildOfClass("Animator");

    if not v7 then
        return nil;
    end;

    local v8 = v7:LoadAnimation(v6);
    v8.Priority = Enum.AnimationPriority.Action3;
    v8:Play(0, 0, 0);
    v8:Stop(0);
    p4.Animations[AnimationName] = v8;

    return v8;
end;

function u1._PerformTick(p9) -- Line: 90
    -- upvalues: u1 (copy)
    local HitboxSize = p9.ClassData.HitboxSize;
    local Range = p9.ClassData.Range;
    p9.ClassData.HitboxSize = u1.TickHitboxSize;
    p9.ClassData.Range = u1.TickHitboxRange;
    local v10 = p9:Hitbox();
    p9.ClassData.HitboxSize = HitboxSize;
    p9.ClassData.Range = Range;

    for _, v in v10 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p9:ApplyDamage(v, (p9:ResolveSkillDamage(u1.TickMultiplier, v)));
        end;
    end;
end;

function u1._PerformFinisher(p11, p12) -- Line: 111
    local v13 = 0;

    for _, v in p11:Hitbox() do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p11:ApplyDamage(v, (p11:ResolveSkillDamage(p12, v)));
            v13 = v13 + 1;
        end;
    end;

    return v13;
end;

function u1.CanActivate(p14) -- Line: 129
    if p14.Is_Attacking then
        return false, "Attacking";
    end;

    if p14.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p14.Is_Dodging then
        return false, "Dodging";
    end;

    if p14.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u15, p16) -- Line: 137
    -- upvalues: u1 (copy), u2 (copy), SharedUtils (copy), u3 (copy), RunService (copy)
    local v17 = u1._EnsureAnimation(u15);

    if not v17 then
        warn("[Death Sentence] Animation not found");

        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;

    for i, v in u15.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v17:Play(0, 1.15, 1);
    local u18 = 0;

    local function fireSlashVFX() -- Line: 160
        -- upvalues: u18 (ref), u15 (copy), u2 (ref)
        u18 = u18 + 1;
        u15:PlayTurnFX(u2[(u18 - 1) % #u2 + 1]);
    end;

    local u19 = 0;

    local function fireSpinSFX() -- Line: 167
        -- upvalues: u19 (ref), u15 (copy), SharedUtils (ref), u3 (ref)
        u19 = u19 + 1;
        local v20 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            SharedUtils.PlaySoundAt(v20, u3[(u19 - 1) % #u3 + 1], 0.7);
        end;
    end;

    local u21 = nil;
    local u22 = 0;

    local function stopChannel() -- Line: 179
        -- upvalues: u21 (ref)
        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;
    end;

    local u23 = {};

    local function disconnectAll() -- Line: 187
        -- upvalues: u21 (ref), u23 (copy)
        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;

        for _, v in u23 do
            v:Disconnect();
        end;

        table.clear(u23);
    end;

    local u24 = false;

    local function releaseState() -- Line: 194
        -- upvalues: u24 (ref), u21 (ref), u15 (copy)
        if u24 then
            return;
        end;

        u24 = true;

        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;

        u15.Is_Using_Skill = false;
        u15.Is_Attacking = false;
    end;

    u23[#u23 + 1] = v17:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 205
        -- upvalues: u21 (ref), u22 (ref), u1 (ref), RunService (ref), u15 (copy), u18 (ref), u2 (ref), u19 (ref), SharedUtils (ref), u3 (ref)
        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;

        u22 = u1.TickInterval;
        u21 = RunService.Heartbeat:Connect(function(p25) -- Line: 208
            -- upvalues: u15 (ref), u21 (ref), u22 (ref), u1 (ref), u18 (ref), u2 (ref), u19 (ref), SharedUtils (ref), u3 (ref)
            local Character = u15.Character;

            if not (Character and Character.Parent) then
                if u21 then
                    u21:Disconnect();
                    u21 = nil;
                end;

                return;
            end;

            u22 = u22 + p25;

            if u22 >= u1.TickInterval then
                u22 = u22 - u1.TickInterval;
                u1._PerformTick(u15);
                u18 = u18 + 1;
                u15:PlayTurnFX(u2[(u18 - 1) % #u2 + 1]);
                u19 = u19 + 1;
                local v26 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

                if v26 then
                    SharedUtils.PlaySoundAt(v26, u3[(u19 - 1) % #u3 + 1], 0.7);
                end;

                u15:ShakeCamera("SkillLight");
            end;
        end);
    end);
    u23[#u23 + 1] = v17:GetMarkerReachedSignal("End"):Connect(function() -- Line: 227
        -- upvalues: u21 (ref)
        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;
    end);
    local u27 = 0;
    u23[#u23 + 1] = v17:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 233
        -- upvalues: u27 (ref), u18 (ref), u15 (copy), u2 (ref), u1 (ref), SharedUtils (ref), u19 (ref), u3 (ref)
        u27 = u27 + 1;
        u18 = u18 + 1;
        u15:PlayTurnFX(u2[(u18 - 1) % #u2 + 1]);

        if u27 >= u1.FinisherHitCount then
            local v28 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

            if v28 then
                SharedUtils.PlaySoundAt(v28, u1.FinalHitSFX, u1.FinalHitVolume);
            end;

            u15:ShakeCamera("SkillHeavy");
            u1._PerformFinisher(u15, u1.FinalHitMultiplier);

            return;
        end;

        u19 = u19 + 1;
        local v29 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if v29 then
            SharedUtils.PlaySoundAt(v29, u3[(u19 - 1) % #u3 + 1], 0.7);
        end;

        u15:ShakeCamera("SkillLight");
        u1._PerformFinisher(u15, u1.FinisherMultiplier);
    end);
    u23[#u23 + 1] = v17:GetMarkerReachedSignal("sheathe"):Connect(function() -- Line: 253
        -- upvalues: u15 (copy), SharedUtils (ref), u1 (ref)
        local v30 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if v30 then
            SharedUtils.PlaySoundAt(v30, "Sheathe_1", u1.SheatheVolume);
        end;
    end);
    u23[#u23 + 1] = v17:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v17.Stopped:Once(function() -- Line: 264
        -- upvalues: u24 (ref), u21 (ref), u15 (copy), u23 (copy)
        if not u24 then
            u24 = true;

            if u21 then
                u21:Disconnect();
                u21 = nil;
            end;

            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
        end;

        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;

        for _, v in u23 do
            v:Disconnect();
        end;

        table.clear(u23);
    end);
    task.delay(u1.MaxDuration, function() -- Line: 269
        -- upvalues: u24 (ref), u21 (ref), u15 (copy), u23 (copy)
        if not u24 then
            u24 = true;

            if u21 then
                u21:Disconnect();
                u21 = nil;
            end;

            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
        end;

        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;

        for _, v in u23 do
            v:Disconnect();
        end;

        table.clear(u23);
    end);
end;

return u1;