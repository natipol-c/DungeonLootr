--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Flickering Shadows
  Path:     game.ReplicatedStorage.Classes.Assassin.Skills.Flickering Shadows
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local u1 = {
    Cooldown = 11,
    DamageMultiplier = 0.5,
    AnimationName = "Ability_2",
    Duration = 2.5,
    HitCount = 17,
    HitInterval = 0.14705882352941177,
    FX_Name = "Barrage",
    SFX_Name = "Dismantle_Barrage",
    SFX_FadeStart = 2,
    SFX_TotalRuntime = 2.6,
    HitboxSize = Vector3.new(22, 18, 22),
    HitboxRange = 0,
    MaxDuration = 3.5
};

function u1._EnsureAnimation(p2) -- Line: 57
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

function u1._PerformHit(p7) -- Line: 84
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

function u1._HideCharacter(p9) -- Line: 106
    local Character = p9.Character;

    if not Character then
        return {};
    end;

    local v10 = {};

    for _, descendant in Character:GetDescendants() do
        if (descendant:IsA("BasePart") or descendant:IsA("MeshPart")) and descendant.Transparency < 1 then
            v10[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;

    return v10;
end;

function u1._RestoreCharacter(p11: table) -- Line: 121
    for i, v in p11 do
        if i and i.Parent then
            i.Transparency = v;
        end;
    end;
end;

function u1._PlayFadedSFX(p12: userdata) -- Line: 133
    -- upvalues: SoundService (copy), u1 (copy)
    local SFX = SoundService:FindFirstChild("SFX");

    if SFX then
        SFX = SFX:FindFirstChild(u1.SFX_Name);
    end;

    if not SFX then
        warn("[Flickering Shadows] SFX not found: " .. u1.SFX_Name);

        return;
    end;

    local u13 = SFX:Clone();
    u13.Name = "FlickeringShadows_SFX";
    u13.Looped = false;
    u13.Parent = p12;
    u13:Play();
    local Volume = u13.Volume;
    task.spawn(function() -- Line: 148
        -- upvalues: u1 (ref), u13 (copy), Volume (copy)
        task.wait(u1.SFX_FadeStart);
        local math_max_ret = math.max(0.1, u1.SFX_TotalRuntime - u1.SFX_FadeStart);

        for i = 1, 16 do
            if not u13 or u13.Parent == nil then
                return;
            end;

            u13.Volume = Volume * (1 - i / 16);
            task.wait(math_max_ret / 16);
            local _ = i;
        end;

        if u13 and u13.Parent then
            u13:Destroy();
        end;
    end);
end;

function u1.CanActivate(p14) -- Line: 165
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

function u1.Activate(u15, p16) -- Line: 173
    -- upvalues: u1 (copy)
    local v17 = u1._EnsureAnimation(u15);

    if not v17 then
        warn("[Flickering Shadows] Animation not found");

        return;
    end;

    local Character = u15.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;

    for i, v in u15.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v17:Play(0, 1, 1);
    local u18 = false;
    local u19 = {};
    local u20 = false;

    local function EndPhase() -- Line: 204
        -- upvalues: u18 (ref), u1 (ref), u19 (ref), u20 (ref), u15 (copy)
        if not u18 then
            return;
        end;

        u18 = false;
        u1._RestoreCharacter(u19);
        u19 = {};

        if u20 then
            u15:SetLoopFX(u1.FX_Name, false);
            u20 = false;
        end;

        if u15.Player then
            u15.Player:SetAttribute("iFrame", false);
        end;

        if u15.Character then
            u15.Character:SetAttribute("iFrame", false);
        end;

        u15.Is_Using_Skill = false;
        u15.Is_Attacking = false;
    end;

    local u21 = nil;
    u21 = v17:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 225
        -- upvalues: u21 (ref), u18 (ref), u19 (ref), u1 (ref), u15 (copy), u20 (ref), EndPhase (copy)
        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;

        u18 = true;
        u19 = u1._HideCharacter(u15);
        u15:SetLoopFX(u1.FX_Name, true);
        u20 = true;
        u15.Player:SetAttribute("iFrame", true);
        u15.Character:SetAttribute("iFrame", true);
        local v22 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if v22 then
            u1._PlayFadedSFX(v22);
        end;

        task.spawn(function() -- Line: 247
            -- upvalues: u1 (ref), u18 (ref), u15 (ref), EndPhase (ref)
            for i = 1, u1.HitCount do
                if not u18 then
                    break;
                end;

                u15:ShakeCamera("Hit");
                u1._PerformHit(u15);
                local v23;

                if i < u1.HitCount then
                    task.wait(u1.HitInterval);
                    v23 = i;
                else
                    v23 = i;
                end;
            end;

            EndPhase();
        end);
    end);
    v17.Stopped:Once(function() -- Line: 264
        -- upvalues: u21 (ref)
        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 270
        -- upvalues: u21 (ref), EndPhase (copy)
        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;

        EndPhase();
    end);
end;

return u1;