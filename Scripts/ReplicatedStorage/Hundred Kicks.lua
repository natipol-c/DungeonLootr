--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hundred Kicks
  Path:     game.ReplicatedStorage.Classes.Mori.Skills.Hundred Kicks
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:00 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 13,
    AnimationName = "Ability_4",
    TickMultiplier = 0.4,
    TickInterval = 0.08,
    MaxTicks = 60,
    FinalMultiplier = 2,
    FinalHitSFX = "HardHit_1",
    FinalHitVolume = 1,
    HitboxSize = Vector3.new(28, 20, 28),
    HitboxRange = 26,
    HitVFX = { "Left_Slash", "Right_Slash" },
    MaxDuration = 4
};

function u1._EnsureAnimation(p2) -- Line: 63
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

function u1._PerformHit(p7, p8) -- Line: 90
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

function u1._PlayHitVFX(p10) -- Line: 111
    -- upvalues: u1 (copy)
    p10:PlayFX(u1.HitVFX[math.random(1, #u1.HitVFX)]);
end;

function u1.CanActivate(p11) -- Line: 117
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

function u1.Activate(u12, p13) -- Line: 125
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v14 = u1._EnsureAnimation(u12);

    if not v14 then
        warn("[Hundred Kicks] Animation not found");

        return;
    end;

    local Character = u12.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
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
    local u15 = {};

    local function disconnectAll() -- Line: 152
        -- upvalues: u15 (copy)
        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end;

    local u16 = false;

    local function stopFlurry() -- Line: 159
        -- upvalues: u16 (ref)
        u16 = false;
    end;

    local function startFlurry() -- Line: 162
        -- upvalues: u16 (ref), u1 (ref), u12 (copy)
        if u16 then
            return;
        end;

        u16 = true;
        task.spawn(function() -- Line: 166
            -- upvalues: u16 (ref), u1 (ref), u12 (ref)
            local v17 = 0;

            while u16 and (v17 < u1.MaxTicks and u12.Is_Using_Skill) do
                u1._PerformHit(u12, u1.TickMultiplier);
                u12:PlayCombatSound(u12.ClassData.SwingSoundFolder or "Short_Punches", nil, u12.ClassData.SwingVolume or 0.5);
                u1._PlayHitVFX(u12);
                u12:ShakeCamera("SkillLight");
                v17 = v17 + 1;
                task.wait(u1.TickInterval);
            end;

            u16 = false;
        end);
    end;

    local u18 = false;

    local function releaseState() -- Line: 188
        -- upvalues: u18 (ref), u16 (ref), u12 (copy)
        if u18 then
            return;
        end;

        u18 = true;
        u16 = false;
        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;
    end;

    u15[#u15 + 1] = v14:GetMarkerReachedSignal("Start"):Connect(startFlurry);
    u15[#u15 + 1] = v14:GetMarkerReachedSignal("End"):Connect(stopFlurry);
    u15[#u15 + 1] = v14:GetMarkerReachedSignal("hit"):Connect(function(p19) -- Line: 200
        -- upvalues: u16 (ref), u12 (copy), SharedUtils (ref), u1 (ref)
        u16 = false;
        local v20 = u12.Character and u12.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            SharedUtils.PlaySoundAt(v20, u1.FinalHitSFX, u1.FinalHitVolume);
        end;

        u1._PlayHitVFX(u12);
        u12:ShakeCamera("SkillHeavy");
        u1._PerformHit(u12, u1.FinalMultiplier);
    end);
    u15[#u15 + 1] = v14:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v14.Stopped:Once(function() -- Line: 217
        -- upvalues: u18 (ref), u16 (ref), u12 (copy), u15 (copy)
        if not u18 then
            u18 = true;
            u16 = false;
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end);
    task.delay(u1.MaxDuration, function() -- Line: 222
        -- upvalues: u18 (ref), u16 (ref), u12 (copy), u15 (copy)
        if not u18 then
            u18 = true;
            u16 = false;
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end);
end;

return u1;