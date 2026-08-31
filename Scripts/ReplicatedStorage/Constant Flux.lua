--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Constant Flux
  Path:     game.ReplicatedStorage.Classes.Streamline.Skills.Constant Flux
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:44 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    DamageMultiplier = 0.62,
    AnimationName = "Ability_4",
    EffectModule = "Constant_Flux",
    Skill_SFX = nil,
    VariantEffect = "Constant_Flux_VAR",
    VariantChance = 0.35,
    VariantDamageBonus = 0.4,
    DashSpeed = 55,
    DashDuration = 0.12,
    ParryDuration = 2.5,
    HitboxSize = Vector3.new(22, 18, 28),
    HitboxRange = 22,
    FinalParam = "Ability_4_Final",
    FinalSFX_1 = "Tiger_Roar",
    FinalSFX_2 = "Fire_Woosh",
    FinalVolume = 1,
    TotalHits = 8,
    MaxDuration = 4
};

function u1._EnsureAnimation(p2) -- Line: 80
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

local function findWeaponTrail(p7) -- Line: 109
    if not p7 then
        return nil;
    end;

    local HumanoidRootPart = p7:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        HumanoidRootPart = HumanoidRootPart:FindFirstChild("Holder");
    end;

    if not HumanoidRootPart then
        return nil;
    end;

    for _, descendant in HumanoidRootPart:GetDescendants() do
        if descendant:IsA("Trail") then
            return descendant;
        end;
    end;

    return nil;
end;

local function setWeaponTrail(p8, p9) -- Line: 120
    -- upvalues: findWeaponTrail (copy)
    local v10 = findWeaponTrail(p8);

    if v10 then
        v10.Enabled = p9;
    end;
end;

function u1._PerformHit(p11, p12) -- Line: 125
    -- upvalues: u1 (copy)
    local HitboxSize = p11.ClassData.HitboxSize;
    local Range = p11.ClassData.Range;
    p11.ClassData.HitboxSize = u1.HitboxSize;
    p11.ClassData.Range = u1.HitboxRange;
    local v13 = p11:Hitbox();
    p11.ClassData.HitboxSize = HitboxSize;
    p11.ClassData.Range = Range;
    local v14 = 0;

    for _, v in v13 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p11:ApplyDamage(v, (p11:ResolveSkillDamage(p12, v)));
            v14 = v14 + 1;
        end;
    end;

    return v14;
end;

function u1.CanActivate(p15) -- Line: 152
    if p15.Is_Attacking then
        return false, "Attacking";
    end;

    if p15.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p15.Is_Dodging then
        return false, "Dodging";
    end;

    if p15.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u16, p17) -- Line: 160
    -- upvalues: u1 (copy), findWeaponTrail (copy), Debris (copy), SharedUtils (copy)
    local v18 = math.random() < u1.VariantChance;
    local u19 = v18 and u1.VariantEffect or u1.EffectModule;
    local u20 = v18 and u1.DamageMultiplier * (1 + u1.VariantDamageBonus) or u1.DamageMultiplier;
    local v21 = u1._EnsureAnimation(u16);

    if not v21 then
        warn("[Constant Flux] Animation not found");

        return;
    end;

    local Character = u16.Character;
    local v22;

    if Character then
        v22 = Character:FindFirstChild("HumanoidRootPart");
    else
        v22 = Character;
    end;

    if not v22 then
        return;
    end;

    u16.Is_Using_Skill = true;
    u16.Is_Attacking = true;

    for i, v in u16.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    Character:SetAttribute("Parry", true);
    task.delay(u1.ParryDuration, function() -- Line: 191
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    v21:Play(0, 1, 1);
    local u23 = {};

    local function disconnectAll() -- Line: 202
        -- upvalues: u23 (copy)
        for _, v in u23 do
            v:Disconnect();
        end;

        table.clear(u23);
    end;

    u23[#u23 + 1] = v21:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 208
        -- upvalues: u16 (copy), findWeaponTrail (ref)
        local v24 = findWeaponTrail(u16.Character);

        if v24 then
            v24.Enabled = true;
        end;
    end);
    u23[#u23 + 1] = v21:GetMarkerReachedSignal("VFX"):Connect(function(p25) -- Line: 213
        -- upvalues: u16 (copy), u19 (copy)
        if not p25 or p25 == "" then
            return;
        end;

        local v26 = u16.Character and u16.Character:FindFirstChild("HumanoidRootPart");

        if not v26 then
            return;
        end;

        u16:PlayEffectModule(u19, "Emit", v26.CFrame, p25);
    end);
    local u27 = 0;
    u23[#u23 + 1] = v21:GetMarkerReachedSignal("hit"):Connect(function(p28) -- Line: 222
        -- upvalues: u27 (ref), u1 (ref), u16 (copy), Debris (ref), SharedUtils (ref), u20 (copy)
        u27 = u27 + 1;
        local v29 = p28 == u1.FinalParam and true or u27 >= u1.TotalHits;
        local v30 = u16.Character and u16.Character:FindFirstChild("HumanoidRootPart");

        if not v30 then
            return;
        end;

        local Humanoid = u16.Humanoid;
        local v31;

        if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
            v31 = Humanoid.MoveDirection.Unit;
        else
            v31 = v30.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v31 * u1.DashSpeed;
        BodyVelocity.Parent = v30;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
        u16:PlayCombatSound(u1.Skill_SFX or (u16.ClassData.SwingSoundFolder or "Water_Swings"), nil, u16.ClassData.SwingVolume or 0.5);

        if v29 then
            SharedUtils.PlaySoundAt(v30, u1.FinalSFX_1, u1.FinalVolume);
            SharedUtils.PlaySoundAt(v30, u1.FinalSFX_2, u1.FinalVolume);
        end;

        u1._PerformHit(u16, u20);
        u16:ShakeCamera("Hit");
    end);
    local u32 = false;

    local function releaseState() -- Line: 266
        -- upvalues: u32 (ref), u16 (copy), findWeaponTrail (ref), Character (copy)
        if u32 then
            return;
        end;

        u32 = true;
        u16.Is_Using_Skill = false;
        u16.Is_Attacking = false;
        local v33 = findWeaponTrail(u16.Character);

        if v33 then
            v33.Enabled = false;
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end;

    u23[#u23 + 1] = v21:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v21.Stopped:Once(function() -- Line: 284
        -- upvalues: u32 (ref), u16 (copy), findWeaponTrail (ref), Character (copy), u23 (copy)
        if not u32 then
            u32 = true;
            u16.Is_Using_Skill = false;
            u16.Is_Attacking = false;
            local v34 = findWeaponTrail(u16.Character);

            if v34 then
                v34.Enabled = false;
            end;

            if Character then
                Character:SetAttribute("Parry", false);
            end;
        end;

        for _, v in u23 do
            v:Disconnect();
        end;

        table.clear(u23);
    end);
    task.delay(u1.MaxDuration, function() -- Line: 288
        -- upvalues: u32 (ref), u16 (copy), findWeaponTrail (ref), Character (copy), u23 (copy)
        if not u32 then
            u32 = true;
            u16.Is_Using_Skill = false;
            u16.Is_Attacking = false;
            local v35 = findWeaponTrail(u16.Character);

            if v35 then
                v35.Enabled = false;
            end;

            if Character then
                Character:SetAttribute("Parry", false);
            end;
        end;

        for _, v in u23 do
            v:Disconnect();
        end;

        table.clear(u23);
    end);
end;

return u1;