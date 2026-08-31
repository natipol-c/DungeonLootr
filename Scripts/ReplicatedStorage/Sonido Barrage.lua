--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Sonido Barrage
  Path:     game.ReplicatedStorage.Classes.Vacio.Skills.Sonido Barrage
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:47 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u1 = {
    Cooldown = 14,
    DamageMultiplier = 0.29,
    AnimationName = "Ability_3",
    EffectModule = "Sonido_Barrage",
    StartSFX = "Sonido",
    StartVolume = 1,
    TickSFX = "Sonido",
    TickVolume = 0.7,
    SlashSFX = "sword_slash_1",
    SlashVolume = 0.8,
    TickInterval = 0.08,
    BarrageMaxDuration = 1.5,
    HitboxSize = Vector3.new(20, 15, 32),
    HitboxRange = 30,
    MaxDuration = 4
};

function u1._EnsureAnimation(p2) -- Line: 67
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

function u1._PerformHit(p7) -- Line: 93
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
        end;
    end;
end;

function u1.CanActivate(p9) -- Line: 115
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

function u1.Activate(u10, p11) -- Line: 123
    -- upvalues: u1 (copy), SkillRuntime (copy), SharedUtils (copy)
    local v12 = u1._EnsureAnimation(u10);

    if not v12 then
        warn("[Sonido Barrage] Animation not found");

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

    local function releaseFreeze() -- Line: 152
        -- upvalues: u10 (copy), u13 (ref)
        local Character2 = u10.Character;

        if Character2 then
            Character2:SetAttribute("Skill_Camera_Stabilize", false);
        end;

        if u13 then
            u13:Destroy();
            u13 = nil;
        end;
    end;

    local u14 = false;
    local u15 = {};

    local function disconnectAll() -- Line: 167
        -- upvalues: u15 (copy)
        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end;

    local u16 = false;

    local function releaseState() -- Line: 173
        -- upvalues: u16 (ref), u10 (copy)
        if u16 then
            return;
        end;

        u16 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;
    end;

    for _, v in SkillRuntime.BindVFXMarkers(u10, v12, u1.EffectModule, 3) do
        u15[#u15 + 1] = v;
    end;

    u15[#u15 + 1] = v12:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 186
        -- upvalues: u14 (ref), u10 (copy), SharedUtils (ref), u1 (ref), u13 (ref)
        if u14 then
            return;
        end;

        local v17 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if not v17 then
            return;
        end;

        SharedUtils.PlaySoundAt(v17, u1.StartSFX, u1.StartVolume);
        u10.Character:SetAttribute("Skill_Camera_Stabilize", true);
        u13 = Instance.new("BodyVelocity");
        u13.Name = "SonidoFreeze";
        u13.MaxForce = Vector3.new(100000, 100000, 100000);
        u13.Velocity = Vector3.new(0, 0, 0);
        u13.Parent = v17;
        u14 = true;
        local u18 = os.clock() + u1.BarrageMaxDuration;
        task.spawn(function() -- Line: 206
            -- upvalues: u14 (ref), u10 (ref), u18 (copy), u1 (ref), SharedUtils (ref), u13 (ref)
            local v19 = 0;

            while u14 and (u10.Is_Using_Skill and os.clock() < u18) do
                local v20 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

                if not v20 then
                    break;
                end;

                v19 = v19 + 1;
                u1._PerformHit(u10);
                SharedUtils.PlaySoundAt(v20, u1.TickSFX, u1.TickVolume);

                if v19 % 2 == 0 then
                    SharedUtils.PlaySoundAt(v20, u1.SlashSFX, u1.SlashVolume);
                end;

                u10:ShakeCamera("SkillLight");
                task.wait(u1.TickInterval);
            end;

            u14 = false;
            local Character2 = u10.Character;

            if Character2 then
                Character2:SetAttribute("Skill_Camera_Stabilize", false);
            end;

            if u13 then
                u13:Destroy();
                u13 = nil;
            end;
        end);
    end);
    u15[#u15 + 1] = v12:GetMarkerReachedSignal("End"):Connect(function() -- Line: 229
        -- upvalues: u14 (ref), u10 (copy), u13 (ref)
        u14 = false;
        local Character2 = u10.Character;

        if Character2 then
            Character2:SetAttribute("Skill_Camera_Stabilize", false);
        end;

        if u13 then
            u13:Destroy();
            u13 = nil;
        end;
    end);
    v12.Stopped:Once(function() -- Line: 235
        -- upvalues: u14 (ref), u15 (copy), u10 (copy), u13 (ref), u16 (ref)
        u14 = false;

        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
        local Character2 = u10.Character;

        if Character2 then
            Character2:SetAttribute("Skill_Camera_Stabilize", false);
        end;

        if u13 then
            u13:Destroy();
            u13 = nil;
        end;

        if u16 then
            return;
        end;

        u16 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 243
        -- upvalues: u14 (ref), u15 (copy), u10 (copy), u13 (ref), u16 (ref)
        u14 = false;

        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
        local Character2 = u10.Character;

        if Character2 then
            Character2:SetAttribute("Skill_Camera_Stabilize", false);
        end;

        if u13 then
            u13:Destroy();
            u13 = nil;
        end;

        if u16 then
            return;
        end;

        u16 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;
    end);
end;

return u1;