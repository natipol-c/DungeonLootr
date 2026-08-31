--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Apex Predator
  Path:     game.ReplicatedStorage.Classes.Coyote.Skills.Apex Predator
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 12,
    DamageMultiplier = 3.3,
    AnimationName = "Ability_4",
    ChargeFX = "Right_Arm",
    FieldFX = "Ability_4",
    StartSFX = "Sieghart_Spell_Ava_13",
    TickInterval = 0.15,
    HitboxSize = Vector3.new(20, 20, 55),
    HitboxRange = 55,
    MaxDuration = 4
};

function u1._EnsureAnimation(p2) -- Line: 53
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

function u1._PerformTick(p7) -- Line: 80
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

function u1.CanActivate(p9) -- Line: 102
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

function u1.Activate(u10, p11) -- Line: 110
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v12 = u1._EnsureAnimation(u10);

    if not v12 then
        warn("[Apex Predator] Animation not found");

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
    local u13 = {};

    local function disconnectAll() -- Line: 132
        -- upvalues: u13 (copy)
        for _, v in u13 do
            v:Disconnect();
        end;

        table.clear(u13);
    end;

    local u14 = false;
    local u15 = nil;

    local function stopField() -- Line: 140
        -- upvalues: u14 (ref), u15 (ref), u10 (copy), u1 (ref)
        u14 = false;

        if u15 then
            pcall(task.cancel, u15);
            u15 = nil;
        end;

        u10:SetLoopFX(u1.FieldFX, false);
        u10:SetLoopFX(u1.ChargeFX, false);
    end;

    local u16 = false;

    local function releaseState() -- Line: 151
        -- upvalues: u16 (ref), u10 (copy)
        if u16 then
            return;
        end;

        u16 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;
    end;

    local function cleanup() -- Line: 159
        -- upvalues: u14 (ref), u15 (ref), u10 (copy), u1 (ref), u13 (copy), u16 (ref)
        u14 = false;

        if u15 then
            pcall(task.cancel, u15);
            u15 = nil;
        end;

        u10:SetLoopFX(u1.FieldFX, false);
        u10:SetLoopFX(u1.ChargeFX, false);

        for _, v in u13 do
            v:Disconnect();
        end;

        table.clear(u13);

        if u16 then
            return;
        end;

        u16 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;
    end;

    u13[#u13 + 1] = v12:GetMarkerReachedSignal("charge"):Connect(function() -- Line: 166
        -- upvalues: u10 (copy), u1 (ref)
        u10:SetLoopFX(u1.ChargeFX, true);
    end);
    local u17 = false;
    u13[#u13 + 1] = v12:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 172
        -- upvalues: u17 (ref), u10 (copy), SharedUtils (ref), u1 (ref), u14 (ref), u15 (ref)
        if u17 then
            return;
        end;

        u17 = true;
        local v18 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if v18 then
            SharedUtils.PlaySoundAt(v18, u1.StartSFX, 1);
        end;

        u10:SetLoopFX(u1.FieldFX, true);
        u14 = true;
        u15 = task.spawn(function() -- Line: 184
            -- upvalues: u14 (ref), u10 (ref), u1 (ref)
            while u14 and (u10.Character and u10.Character.Parent) do
                u1._PerformTick(u10);
                u10:ShakeCamera("SkillMedium");
                task.wait(u1.TickInterval);
            end;
        end);
    end);
    u13[#u13 + 1] = v12:GetMarkerReachedSignal("End"):Connect(stopField);
    u13[#u13 + 1] = v12:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v12.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, cleanup);
end;

return u1;