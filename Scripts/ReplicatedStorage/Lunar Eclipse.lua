--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Lunar Eclipse
  Path:     game.ReplicatedStorage.Classes.Awakened Devil EX.Skills.Lunar Eclipse
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:52 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_Ultimate",
    EffectModule = "Lunar_Eclipse",
    JudgementMultiplier = 8,
    SheatheMultiplier = 20,
    HitboxSize = Vector3.new(35, 22, 65),
    HitboxRange = 0,
    FlickerFX = "Flicker",
    SheatheFX = "Sheathe",
    JudgementSFX = "claw3",
    Flicker2SFX = "Sonido",
    SheatheSFX = "Sheathe_1",
    ComboSFX = "claw_combo",
    Volume = 1,
    MaxDuration = 6
};

function u1._EnsureAnimation(p2) -- Line: 75
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

function u1._PerformHit(p7, p8) -- Line: 102
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v9 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
        end;
    end;
end;

function u1.CanActivate(p10) -- Line: 124
    if p10.Is_Attacking then
        return false, "Attacking";
    end;

    if p10.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p10.Is_Dodging then
        return false, "Dodging";
    end;

    if p10.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u11, p12) -- Line: 132
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Lunar Eclipse] Animation not found");

        return;
    end;

    local v14 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

    if not v14 then
        return;
    end;

    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;

    for i, v in u11.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v13:Play(0, 1, 1);
    local u15 = nil;

    local function anchorHRP() -- Line: 162
        -- upvalues: u11 (copy), u15 (ref)
        local v16 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v16 and not u15 then
            v16.Anchored = true;
            u15 = v16;
        end;
    end;

    local function releaseHRP() -- Line: 169
        -- upvalues: u15 (ref)
        if u15 then
            u15.Anchored = false;
            u15 = nil;
        end;
    end;

    local function setCameraStabilize(p17) -- Line: 178
        -- upvalues: u11 (copy)
        if u11.Character then
            u11.Character:SetAttribute("Skill_Camera_Stabilize", p17);
        end;
    end;

    local v18 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

    if v18 and not u15 then
        v18.Anchored = true;
        u15 = v18;
    end;

    local u19 = {};

    local function disconnectAll() -- Line: 189
        -- upvalues: u19 (copy)
        for _, v in u19 do
            v:Disconnect();
        end;

        table.clear(u19);
    end;

    local u20 = false;

    local function releaseState() -- Line: 195
        -- upvalues: u20 (ref), u11 (copy)
        if u20 then
            return;
        end;

        u20 = true;
        local ClassData = u11.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u11, nil);
        end;

        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    local function emitVFX(p21) -- Line: 208
        -- upvalues: u11 (copy), u1 (ref)
        if not p21 or p21 == "" then
            return;
        end;

        local v22 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v22 then
            return;
        end;

        u11:PlayEffectModule(u1.EffectModule, "Emit", v22.CFrame, p21);
    end;

    u19[#u19 + 1] = v13:GetMarkerReachedSignal("VFX"):Connect(emitVFX);
    u19[#u19 + 1] = v13:GetMarkerReachedSignal("VFX_2"):Connect(emitVFX);
    local u23 = 0;
    u19[#u19 + 1] = v13:GetMarkerReachedSignal("Flicker"):Connect(function() -- Line: 219
        -- upvalues: u23 (ref), u11 (copy), SharedUtils (ref), u1 (ref)
        u23 = u23 + 1;
        u11:ShakeCamera("SkillLight");

        if u23 == 2 then
            local v24 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

            if v24 then
                SharedUtils.PlaySoundAt(v24, u1.Flicker2SFX, u1.Volume);
            end;
        end;
    end);
    u19[#u19 + 1] = v13:GetMarkerReachedSignal("Judgement_Start"):Connect(function() -- Line: 232
        -- upvalues: u11 (copy), SharedUtils (ref), u1 (ref)
        if u11.Character then
            u11.Character:SetAttribute("Skill_Camera_Stabilize", true);
        end;

        local v25 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v25 then
            SharedUtils.PlaySoundAt(v25, u1.JudgementSFX, u1.Volume);
        end;

        u11:ShakeCamera("SkillMedium");
        u1._PerformHit(u11, u1.JudgementMultiplier);
    end);
    u19[#u19 + 1] = v13:GetMarkerReachedSignal("Sheathe"):Connect(function() -- Line: 247
        -- upvalues: u11 (copy), SharedUtils (ref), u1 (ref)
        if u11.Character then
            u11.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;

        local v26 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v26 then
            SharedUtils.PlaySoundAt(v26, u1.SheatheSFX, u1.Volume);
            SharedUtils.PlaySoundAt(v26, u1.ComboSFX, u1.Volume);
        end;

        u11:ShakeCamera("SkillHeavy");
        u1._PerformHit(u11, u1.SheatheMultiplier);
    end);
    u19[#u19 + 1] = v13:GetMarkerReachedSignal("Judgement_End"):Connect(releaseHRP);
    u19[#u19 + 1] = v13:GetMarkerReachedSignal("DBreset"):Connect(releaseState);

    local function fullCleanup() -- Line: 267
        -- upvalues: u20 (ref), u11 (copy), u19 (copy), u15 (ref)
        if not u20 then
            u20 = true;
            local ClassData = u11.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u11, nil);
            end;

            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        for _, v in u19 do
            v:Disconnect();
        end;

        table.clear(u19);

        if u15 then
            u15.Anchored = false;
            u15 = nil;
        end;

        if u11.Character then
            u11.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;
    end;

    v13.Stopped:Once(fullCleanup);
    task.delay(u1.MaxDuration, fullCleanup);
end;

return u1;