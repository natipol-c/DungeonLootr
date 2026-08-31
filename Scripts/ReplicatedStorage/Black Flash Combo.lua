--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Black Flash Combo
  Path:     game.ReplicatedStorage.Classes.Divergent.Skills.Black Flash Combo
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:46 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 13,
    DamageMultiplier = 0.5,
    FinalMultiplier = 2,
    TotalHits = 7,
    AnimationName = "Ability_4",
    EffectModule = "Black_Flash_Combo",
    HitboxSize = Vector3.new(22, 22, 32),
    HitboxRange = 32,
    ElectricSFX = { "Electric_Punch_3", "Electric_Punch_4", "Electric_Punch_5" },
    FinalSFX = "BlackFlash",
    MaxDuration = 3
};

function u1._EnsureAnimation(p2) -- Line: 52
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

function u1._PerformHit(p7, p8) -- Line: 79
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

function u1.CanActivate(p10) -- Line: 101
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

function u1.Activate(u11, p12) -- Line: 109
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Black Flash Combo] Animation not found");

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
    local u14 = {};

    local function disconnectAll() -- Line: 132
        -- upvalues: u14 (copy)
        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end;

    local u15 = false;

    local function releaseState() -- Line: 138
        -- upvalues: u15 (ref), u11 (copy)
        if u15 then
            return;
        end;

        u15 = true;
        local ClassData = u11.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u11, nil);
        end;

        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    local function emitVFX(p16) -- Line: 151
        -- upvalues: u11 (copy), u1 (ref)
        if not p16 or p16 == "" then
            return;
        end;

        local v17 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v17 then
            return;
        end;

        u11:PlayEffectModule(u1.EffectModule, "Emit", v17.CFrame, p16);
    end;

    u14[#u14 + 1] = v13:GetMarkerReachedSignal("VFX"):Connect(emitVFX);
    u14[#u14 + 1] = v13:GetMarkerReachedSignal("VFX_2"):Connect(emitVFX);
    local u18 = 0;
    u14[#u14 + 1] = v13:GetMarkerReachedSignal("hit"):Connect(function(p19) -- Line: 164
        -- upvalues: u18 (ref), u1 (ref), u11 (copy), SharedUtils (ref)
        u18 = u18 + 1;
        local v20 = u18 >= u1.TotalHits;
        local v21 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            if v21 then
                SharedUtils.PlaySoundAt(v21, u1.FinalSFX, 1);
            end;

            u11:ShakeCamera("SkillHeavy");
        else
            local v22 = u1.ElectricSFX[u18];

            if v22 then
                if v21 then
                    SharedUtils.PlaySoundAt(v21, v22, 1);
                end;
            else
                u11:PlayCombatSound(u11.ClassData.SwingSoundFolder or "Naoya_Punches", nil, u11.ClassData.SwingVolume or 0.5);
            end;

            u11:ShakeCamera("Hit");
        end;

        u1._PerformHit(u11, v20 and u1.FinalMultiplier or u1.DamageMultiplier);
    end);
    u14[#u14 + 1] = v13:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v13.Stopped:Once(function() -- Line: 195
        -- upvalues: u15 (ref), u11 (copy), u14 (copy)
        if not u15 then
            u15 = true;
            local ClassData = u11.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u11, nil);
            end;

            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end);
    task.delay(u1.MaxDuration, function() -- Line: 200
        -- upvalues: u15 (ref), u11 (copy), u14 (copy)
        if not u15 then
            u15 = true;
            local ClassData = u11.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u11, nil);
            end;

            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end);
end;

return u1;