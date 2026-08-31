--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Stormfire
  Path:     game.ReplicatedStorage.Classes.Artemis.Skills.Stormfire
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u2 = {
    Cooldown = 12,
    DamageMultiplier = 0.62,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(25, 15, 30),
    HitboxRange = 28,
    DashSpeed = 55,
    DashDuration = 0.12,
    CloneCount = 2,
    CloneInterval = 0.04,
    CloneFadeDuration = 0.6,
    CloneColor = Color3.fromRGB(180, 220, 255),
    CloneSpread = 4,
    MaxDuration = 3.5
};

function u2._EnsureAnimation(p3) -- Line: 50
    -- upvalues: u2 (copy), ReplicatedStorage (copy)
    local AnimationName = u2.AnimationName;

    if p3.Animations[AnimationName] then
        return p3.Animations[AnimationName];
    end;

    local v4 = ReplicatedStorage.Classes:FindFirstChild(p3.ClassName);

    if not v4 then
        return nil;
    end;

    local Skill_Animations = v4:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v5 = Skill_Animations:FindFirstChild(u2.AnimationName);

    if not v5 then
        return nil;
    end;

    local v6 = p3.Humanoid and p3.Humanoid:FindFirstChildOfClass("Animator");

    if not v6 then
        return nil;
    end;

    local v7 = v6:LoadAnimation(v5);
    v7.Priority = Enum.AnimationPriority.Action3;
    v7:Play(0, 0, 0);
    v7:Stop(0);
    p3.Animations[AnimationName] = v7;

    return v7;
end;

function u2._PerformHit(p8) -- Line: 76
    -- upvalues: u2 (copy)
    local HitboxSize = p8.ClassData.HitboxSize;
    local Range = p8.ClassData.Range;
    p8.ClassData.HitboxSize = u2.HitboxSize;
    p8.ClassData.Range = u2.HitboxRange;
    local v9 = p8:Hitbox();
    p8.ClassData.HitboxSize = HitboxSize;
    p8.ClassData.Range = Range;
    local v10 = 0;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, (p8:ResolveSkillDamage(u2.DamageMultiplier, v)));
            v10 = v10 + 1;
        end;
    end;

    return v10;
end;

local function RandomOffset(p11) -- Line: 100
    local v12 = (math.random() * 2 - 1) * p11;
    local v13 = (math.random() * 2 - 1) * p11;

    return Vector3.new(v12, 0, v13);
end;

function u2._SpawnClones(u14) -- Line: 108
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return;
    end;

    task.spawn(function() -- Line: 111
        -- upvalues: u2 (ref), u14 (copy), u1 (ref)
        for i = 1, u2.CloneCount do
            if not u14.Is_Using_Skill then
                break;
            end;

            local Player = u14.Player;
            local v15 = {
                Action = "Clone",
                FadeDuration = u2.CloneFadeDuration,
                Color = u2.CloneColor
            };
            local CloneSpread = u2.CloneSpread;
            local v16 = (math.random() * 2 - 1) * CloneSpread;
            local v17 = (math.random() * 2 - 1) * CloneSpread;
            v15.Offset = Vector3.new(v16, 0, v17);
            u1:FireAllClients(Player, v15);
            local v18;

            if i < u2.CloneCount then
                task.wait(u2.CloneInterval);
                v18 = i;
            else
                v18 = i;
            end;
        end;
    end);
end;

function u2.CanActivate(p19) -- Line: 131
    if p19.Is_Attacking then
        return false, "Attacking";
    end;

    if p19.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p19.Is_Dodging then
        return false, "Dodging";
    end;

    if p19.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u2.Activate(u20, p21) -- Line: 139
    -- upvalues: u2 (copy), Debris (copy)
    local v22 = u2._EnsureAnimation(u20);

    if not v22 then
        warn("[Stormfire] Animation not found");

        return;
    end;

    local Character = u20.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u20.Is_Using_Skill = true;
    u20.Is_Attacking = true;

    for i, v in u20.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v22:Play(0, 1, 1);
    local u26 = v22:GetMarkerReachedSignal("hit"):Connect(function(p23) -- Line: 166
        -- upvalues: u20 (copy), u2 (ref), Debris (ref)
        local v24 = u20.Character and u20.Character:FindFirstChild("HumanoidRootPart");

        if not v24 then
            return;
        end;

        u20:PlayFX("Ability_1");
        u20:PlayFX("Explosion_Center");
        u20:ShakeCamera("Hit");
        u2._SpawnClones(u20);
        local Humanoid = u20.Humanoid;
        local v25;

        if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
            v25 = Humanoid.MoveDirection.Unit;
        else
            v25 = v24.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v25 * u2.DashSpeed;
        BodyVelocity.Parent = v24;
        Debris:AddItem(BodyVelocity, u2.DashDuration);
        u20:PlayCombatSound(u2.Skill_SFX or u20.ClassData.SwingSoundFolder or "Bow_Shot2", nil, u20.ClassData.SwingVolume or 0.5);
        u2._PerformHit(u20);
    end);
    local u27 = false;

    local function releaseState() -- Line: 202
        -- upvalues: u27 (ref), u20 (copy)
        if u27 then
            return;
        end;

        u27 = true;
        u20.Is_Using_Skill = false;
        u20.Is_Attacking = false;
    end;

    local u28 = v22:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v22.Stopped:Once(function() -- Line: 213
        -- upvalues: u27 (ref), u20 (copy), u26 (ref), u28 (copy)
        if not u27 then
            u27 = true;
            u20.Is_Using_Skill = false;
            u20.Is_Attacking = false;
        end;

        if u26 then
            u26:Disconnect();
        end;

        if u28 then
            u28:Disconnect();
        end;
    end);
    task.delay(u2.MaxDuration, function() -- Line: 220
        -- upvalues: u27 (ref), u20 (copy), u26 (ref), u28 (copy)
        if not u27 then
            u27 = true;
            u20.Is_Using_Skill = false;
            u20.Is_Attacking = false;
        end;

        if u26 then
            u26:Disconnect();
        end;

        if u28 then
            u28:Disconnect();
        end;
    end);
end;

return u2;