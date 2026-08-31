--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hypersonic Rush
  Path:     game.ReplicatedStorage.Classes.Spell Breaker.Skills.Hypersonic Rush
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_4",
    DamagePerTick = 0.25,
    TickInterval = 0.1,
    HitboxSize = Vector3.new(28, 22, 30),
    HitboxRange = 22,
    SmokeFX = "Smoke",
    StartSFX_1 = "Sieghart_Spell_15",
    StartSFX_2 = "claw_combo",
    EndSFX = "anime_explode",
    Volume = 1,
    MaxDuration = 2.5
};

function u1._EnsureAnimation(p2) -- Line: 62
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

function u1._SetRightArmFX(p7, p8) -- Line: 91
    local v9 = p7.Character and p7.Character:FindFirstChild("HumanoidRootPart");

    if v9 then
        v9 = v9:FindFirstChild("Holder");
    end;

    if not v9 then
        return;
    end;

    local v10 = v9:FindFirstChild("Right Arm") or v9:FindFirstChild("Right_Arm");

    if v10 then
        v10:SetAttribute("FX_Activate", p8);
    end;
end;

function u1._PerformTick(p11) -- Line: 102
    -- upvalues: u1 (copy)
    local HitboxSize = p11.ClassData.HitboxSize;
    local Range = p11.ClassData.Range;
    p11.ClassData.HitboxSize = u1.HitboxSize;
    p11.ClassData.Range = u1.HitboxRange;
    local v12 = p11:Hitbox();
    p11.ClassData.HitboxSize = HitboxSize;
    p11.ClassData.Range = Range;

    for _, v in v12 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p11:ApplyDamage(v, (p11:ResolveSkillDamage(u1.DamagePerTick, v)));
        end;
    end;
end;

function u1.CanActivate(p13) -- Line: 124
    if p13.Is_Attacking then
        return false, "Attacking";
    end;

    if p13.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p13.Is_Dodging then
        return false, "Dodging";
    end;

    if p13.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u14, p15) -- Line: 132
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v16 = u1._EnsureAnimation(u14);

    if not v16 then
        warn("[Hypersonic Rush] Animation not found");

        return;
    end;

    local Character = u14.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u14.Is_Using_Skill = true;
    u14.Is_Attacking = true;

    for i, v in u14.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v16:Play(0, 1, 1);
    local u17 = false;

    local function startTicks() -- Line: 159
        -- upvalues: u17 (ref), u14 (copy), u1 (ref)
        if u17 then
            return;
        end;

        u17 = true;
        task.spawn(function() -- Line: 162
            -- upvalues: u17 (ref), u14 (ref), u1 (ref)
            local v18 = 0;

            while u17 and (u14.Character and u14.Character.Parent) do
                u1._PerformTick(u14);
                v18 = v18 + 1;

                if v18 % 3 == 0 then
                    u14:ShakeCamera("Hit");
                end;

                task.wait(u1.TickInterval);
            end;
        end);
    end;

    local function stopTicks() -- Line: 173
        -- upvalues: u17 (ref)
        u17 = false;
    end;

    local u19 = {};

    local function disconnectAll() -- Line: 179
        -- upvalues: u19 (copy)
        for _, v in u19 do
            v:Disconnect();
        end;

        table.clear(u19);
    end;

    local u20 = false;

    local function releaseState() -- Line: 185
        -- upvalues: u20 (ref), u14 (copy)
        if u20 then
            return;
        end;

        u20 = true;
        local ClassData = u14.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u14, nil);
        end;

        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;
    end;

    u19[#u19 + 1] = v16:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 197
        -- upvalues: u1 (ref), u14 (copy), SharedUtils (ref), u17 (ref)
        u1._SetRightArmFX(u14, true);

        if u14.Character then
            u14.Character:SetAttribute("Skill_Camera_Stabilize", true);
        end;

        local v21 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

        if v21 then
            SharedUtils.PlaySoundAt(v21, u1.StartSFX_1, u1.Volume);
            SharedUtils.PlaySoundAt(v21, u1.StartSFX_2, u1.Volume);
        end;

        u14:ShakeCamera("SkillHeavy");

        if u17 then
            return;
        end;

        u17 = true;
        task.spawn(function() -- Line: 162
            -- upvalues: u17 (ref), u14 (ref), u1 (ref)
            local v22 = 0;

            while u17 and (u14.Character and u14.Character.Parent) do
                u1._PerformTick(u14);
                v22 = v22 + 1;

                if v22 % 3 == 0 then
                    u14:ShakeCamera("Hit");
                end;

                task.wait(u1.TickInterval);
            end;
        end);
    end);
    u19[#u19 + 1] = v16:GetMarkerReachedSignal("Smoke"):Connect(function() -- Line: 216
        -- upvalues: u14 (copy), u1 (ref)
        u14:PlayFX(u1.SmokeFX);
        u14:ShakeCamera("SkillMedium");
    end);
    u19[#u19 + 1] = v16:GetMarkerReachedSignal("End"):Connect(function() -- Line: 222
        -- upvalues: u17 (ref), u1 (ref), u14 (copy), SharedUtils (ref), u20 (ref)
        u17 = false;
        u1._SetRightArmFX(u14, false);

        if u14.Character then
            u14.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;

        local v23 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

        if v23 then
            SharedUtils.PlaySoundAt(v23, u1.EndSFX, u1.Volume);
        end;

        u14:ShakeCamera("SkillHeavy");

        if u20 then
            return;
        end;

        u20 = true;
        local ClassData = u14.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u14, nil);
        end;

        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;
    end);

    local function fullCleanup() -- Line: 239
        -- upvalues: u17 (ref), u1 (ref), u14 (copy), u20 (ref), u19 (copy)
        u17 = false;
        u1._SetRightArmFX(u14, false);

        if u14.Character then
            u14.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;

        if not u20 then
            u20 = true;
            local ClassData = u14.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u14, nil);
            end;

            u14.Is_Using_Skill = false;
            u14.Is_Attacking = false;
        end;

        for _, v in u19 do
            v:Disconnect();
        end;

        table.clear(u19);
    end;

    v16.Stopped:Once(fullCleanup);
    task.delay(u1.MaxDuration, fullCleanup);
end;

return u1;