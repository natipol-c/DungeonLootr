--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Judgement Rush
  Path:     game.ReplicatedStorage.Classes.Azure Devil.Skills.Judgement Rush
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_4",
    TickInterval = 0.15,
    TickMultiplier = 0.25,
    TickHitboxSize = Vector3.new(24, 12, 24),
    TickHitboxRange = 22,
    ChannelFX = "Charge",
    TickFX = "Random_Slash",
    FinisherMultiplier = 0.85,
    FinisherHitCount = 2,
    SheatheVolume = 0.8,
    FinisherVolume = 0.9,
    MaxDuration = 6
};

function u1._EnsureAnimation(p2) -- Line: 59
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
    v6.Priority = Enum.AnimationPriority.Action4;
    v6:Play(0, 0, 0);
    v6:Stop(0);
    p2.Animations[AnimationName] = v6;

    return v6;
end;

function u1._PerformTick(p7) -- Line: 86
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.TickHitboxSize;
    p7.ClassData.Range = u1.TickHitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.TickMultiplier, v)));
        end;
    end;
end;

function u1._PerformFinisher(p9) -- Line: 107
    -- upvalues: u1 (copy)
    local v10 = 0;

    for _, v in p9:Hitbox() do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p9:ApplyDamage(v, (p9:ResolveSkillDamage(u1.FinisherMultiplier, v)));
            v10 = v10 + 1;
        end;
    end;

    return v10;
end;

function u1.CanActivate(p11) -- Line: 125
    if p11.Is_Attacking then
        return false, "Attacking";
    end;

    if p11.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p11.Is_Dodging then
        return false, "Dodging";
    end;

    if p11.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u12, p13) -- Line: 133
    -- upvalues: u1 (copy), RunService (copy), SharedUtils (copy)
    local v14 = u1._EnsureAnimation(u12);

    if not v14 then
        warn("[Judgement Rush] Animation not found");

        return;
    end;

    u12.Is_Using_Skill = true;
    u12.Is_Attacking = true;

    for i, v in u12.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v14:Play(0, 1, 1);
    local u15 = nil;
    local u16 = 0;

    local function stopChannel() -- Line: 158
        -- upvalues: u15 (ref)
        if u15 then
            u15:Disconnect();
            u15 = nil;
        end;
    end;

    local u17 = {};

    local function disconnectAll() -- Line: 167
        -- upvalues: u15 (ref), u17 (copy), u1 (ref), u12 (copy)
        if u15 then
            u15:Disconnect();
            u15 = nil;
        end;

        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);

        if u1.ChannelFX then
            u12:SetLoopFX(u1.ChannelFX, false);
        end;
    end;

    local u18 = false;

    local function releaseState() -- Line: 181
        -- upvalues: u18 (ref), u15 (ref), u1 (ref), u12 (copy)
        if u18 then
            return;
        end;

        u18 = true;

        if u15 then
            u15:Disconnect();
            u15 = nil;
        end;

        if u1.ChannelFX then
            u12:SetLoopFX(u1.ChannelFX, false);
        end;

        local ClassData = u12.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u12, nil);
        end;

        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;
    end;

    u17[#u17 + 1] = v14:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 199
        -- upvalues: u1 (ref), u12 (copy), u15 (ref), u16 (ref), RunService (ref)
        if u1.ChannelFX then
            u12:SetLoopFX(u1.ChannelFX, true);
        end;

        if u15 then
            u15:Disconnect();
            u15 = nil;
        end;

        u16 = u1.TickInterval;
        u15 = RunService.Heartbeat:Connect(function(p19) -- Line: 206
            -- upvalues: u12 (ref), u15 (ref), u16 (ref), u1 (ref)
            local Character = u12.Character;

            if not (Character and Character.Parent) then
                if u15 then
                    u15:Disconnect();
                    u15 = nil;
                end;

                return;
            end;

            u16 = u16 + p19;

            if u16 >= u1.TickInterval then
                u16 = u16 - u1.TickInterval;
                u1._PerformTick(u12);

                if u1.TickFX then
                    u12:PlayFX(u1.TickFX);
                end;

                u12:ShakeCamera("SkillLight");
            end;
        end);
    end);
    u17[#u17 + 1] = v14:GetMarkerReachedSignal("End"):Connect(function() -- Line: 227
        -- upvalues: u15 (ref), u1 (ref), u12 (copy)
        if u15 then
            u15:Disconnect();
            u15 = nil;
        end;

        if u1.ChannelFX then
            u12:SetLoopFX(u1.ChannelFX, false);
        end;
    end);
    local u20 = 0;
    u17[#u17 + 1] = v14:GetMarkerReachedSignal("hit"):Connect(function(p21) -- Line: 237
        -- upvalues: u20 (ref), u12 (copy), SharedUtils (ref), u1 (ref)
        u20 = u20 + 1;

        if p21 == "" or not p21 then
            p21 = nil;
        end;

        u12:PlayTurnFX(p21);
        local v22 = u12.Character and u12.Character:FindFirstChild("HumanoidRootPart");

        if v22 then
            SharedUtils.PlaySoundAt(v22, "Judgement_Cut", u1.FinisherVolume);
        end;

        u12:ShakeCamera(u20 >= u1.FinisherHitCount and "SkillHeavy" or "SkillLight");
        u1._PerformFinisher(u12);
    end);
    u17[#u17 + 1] = v14:GetMarkerReachedSignal("sheathe"):Connect(function() -- Line: 252
        -- upvalues: u12 (copy), SharedUtils (ref), u1 (ref)
        local v23 = u12.Character and u12.Character:FindFirstChild("HumanoidRootPart");

        if v23 then
            SharedUtils.PlaySoundAt(v23, "Sheathe_1", u1.SheatheVolume);
        end;
    end);
    u17[#u17 + 1] = v14:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v14.Stopped:Once(function() -- Line: 264
        -- upvalues: u18 (ref), u15 (ref), u1 (ref), u12 (copy), disconnectAll (copy)
        if not u18 then
            u18 = true;

            if u15 then
                u15:Disconnect();
                u15 = nil;
            end;

            if u1.ChannelFX then
                u12:SetLoopFX(u1.ChannelFX, false);
            end;

            local ClassData = u12.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u12, nil);
            end;

            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        disconnectAll();
    end);
    task.delay(u1.MaxDuration, function() -- Line: 269
        -- upvalues: u18 (ref), u15 (ref), u1 (ref), u12 (copy), disconnectAll (copy)
        if not u18 then
            u18 = true;

            if u15 then
                u15:Disconnect();
                u15 = nil;
            end;

            if u1.ChannelFX then
                u12:SetLoopFX(u1.ChannelFX, false);
            end;

            local ClassData = u12.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u12, nil);
            end;

            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        disconnectAll();
    end);
end;

return u1;