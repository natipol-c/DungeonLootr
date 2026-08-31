--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Tri-Step
  Path:     game.ReplicatedStorage.Classes.Divergent.Skills.Tri-Step
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:46 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 4,
    MaxCharges = 3,
    DamageMultiplier = 1.67,
    AnimationName = "Ability_1",
    EffectModule = "Tri_Step",
    IFrameDuration = 0.5,
    HitboxSize = Vector3.new(22, 18, 28),
    HitboxRange = 28,
    HitSFX = "jojo punch",
    HitVolume = 1,
    StepDashSpeed = 24,
    StepDashDuration = 0.13,
    FlashRefreshSlot = 3,
    FlashRefreshChance = 0.25,
    FlashEffectModule = "Tri_Step",
    MaxDuration = 2
};

function u1._EnsureAnimation(p2) -- Line: 65
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

function u1._PerformHit(p7) -- Line: 92
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

function u1._DoStepDash(p9) -- Line: 115
    -- upvalues: u1 (copy), Debris (copy)
    local v10 = p9.Character and p9.Character:FindFirstChild("HumanoidRootPart");

    if not v10 then
        return;
    end;

    local Humanoid = p9.Humanoid;
    local v11;

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
        v11 = Humanoid.MoveDirection.Unit;
    else
        v11 = v10.CFrame.LookVector;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillStepDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v11 * u1.StepDashSpeed;
    BodyVelocity.Parent = v10;
    Debris:AddItem(BodyVelocity, u1.StepDashDuration);
end;

function u1._RollFlashRefresh(p12, p13, p14) -- Line: 137
    -- upvalues: u1 (copy)
    if not p12:IsSkillOnCooldown(u1.FlashRefreshSlot) then
        return;
    end;

    if p13 <= math.random() then
        return;
    end;

    p12:RefreshSkillCooldown(u1.FlashRefreshSlot);
    local v15 = p12.Character and p12.Character:FindFirstChild("HumanoidRootPart");
    p12:PlayEffectModule(p14, "Emit", v15 and v15.CFrame or nil, "HighlightEmit");
end;

function u1.CanActivate(p16) -- Line: 150
    if p16.Is_Attacking then
        return false, "Attacking";
    end;

    if p16.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p16.Is_Dodging then
        return false, "Dodging";
    end;

    if p16.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u17, p18) -- Line: 158
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v19 = u1._EnsureAnimation(u17);

    if not v19 then
        warn("[Tri-Step] Animation not found");

        return;
    end;

    local Character = u17.Character;
    local v20;

    if Character then
        v20 = Character:FindFirstChild("HumanoidRootPart");
    else
        v20 = Character;
    end;

    if not v20 then
        return;
    end;

    u17.Is_Using_Skill = true;
    u17.Is_Attacking = true;

    for i, v in u17.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    if u17.Player then
        u17.Player:SetAttribute("iFrame", true);
    end;

    Character:SetAttribute("iFrame", true);
    task.delay(u1.IFrameDuration, function() -- Line: 183
        -- upvalues: u17 (copy)
        local Player = u17.Player;
        local Character2 = u17.Character;

        if Player then
            Player:SetAttribute("iFrame", false);
        end;

        if Character2 then
            Character2:SetAttribute("iFrame", false);
        end;
    end);
    v19:Play(0, 1, 1);
    local u21 = {};

    local function disconnectAll() -- Line: 195
        -- upvalues: u21 (copy)
        for _, v in u21 do
            v:Disconnect();
        end;

        table.clear(u21);
    end;

    local u22 = false;

    local function releaseState() -- Line: 203
        -- upvalues: u22 (ref), u17 (copy), u1 (ref)
        if u22 then
            return;
        end;

        u22 = true;
        local ClassData = u17.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u17, nil);
        end;

        u17.Is_Using_Skill = false;
        u17.Is_Attacking = false;
        u1._RollFlashRefresh(u17, u1.FlashRefreshChance, u1.FlashEffectModule);
    end;

    local function emitVFX(p23) -- Line: 219
        -- upvalues: u17 (copy), u1 (ref)
        if not p23 or p23 == "" then
            return;
        end;

        local v24 = u17.Character and u17.Character:FindFirstChild("HumanoidRootPart");

        if not v24 then
            return;
        end;

        u17:PlayEffectModule(u1.EffectModule, "Emit", v24.CFrame, p23);
    end;

    u21[#u21 + 1] = v19:GetMarkerReachedSignal("VFX"):Connect(emitVFX);
    u21[#u21 + 1] = v19:GetMarkerReachedSignal("VFX_2"):Connect(emitVFX);
    local u25 = 0;
    u21[#u21 + 1] = v19:GetMarkerReachedSignal("hit"):Connect(function(p26) -- Line: 231
        -- upvalues: u25 (ref), u17 (copy), SharedUtils (ref), u1 (ref)
        u25 = u25 + 1;
        local v27 = u17.Character and u17.Character:FindFirstChild("HumanoidRootPart");

        if v27 then
            SharedUtils.PlaySoundAt(v27, u1.HitSFX, u1.HitVolume);
        end;

        u1._DoStepDash(u17);
        u17:ShakeCamera(u25 >= 3 and "SkillHeavy" or "SkillLight");
        u1._PerformHit(u17);
    end);
    u21[#u21 + 1] = v19:GetMarkerReachedSignal("DBreset"):Connect(releaseState);

    local function fullCleanup() -- Line: 249
        -- upvalues: u22 (ref), u17 (copy), u1 (ref), u21 (copy)
        if not u22 then
            u22 = true;
            local ClassData = u17.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u17, nil);
            end;

            u17.Is_Using_Skill = false;
            u17.Is_Attacking = false;
            u1._RollFlashRefresh(u17, u1.FlashRefreshChance, u1.FlashEffectModule);
        end;

        for _, v in u21 do
            v:Disconnect();
        end;

        table.clear(u21);

        if u17.Player then
            u17.Player:SetAttribute("iFrame", false);
        end;

        if u17.Character then
            u17.Character:SetAttribute("iFrame", false);
        end;
    end;

    v19.Stopped:Once(fullCleanup);
    task.delay(u1.MaxDuration, fullCleanup);
end;

return u1;