--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Quickdraw
  Path:     game.ReplicatedStorage.Classes.Hitman.Skills.Quickdraw
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = {
    Cooldown = 4,
    MaxCharges = 3,
    DamageMultiplier = 1.55,
    AnimationName = "Ability_1",
    Skill_SFX = "Gun_Shots",
    DashSpeed = 65,
    DashDuration = 0.15,
    IFrameDuration = 0.5,
    CloneCount = 3,
    CloneInterval = 0.06,
    CloneFadeDuration = 1,
    CloneColor = Color3.fromRGB(60, 60, 80),
    HitboxSize = Vector3.new(10, 10, 20),
    HitboxRange = 20,
    MaxDuration = 1.5
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._EnsureAnimation(p3) -- Line: 55
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

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

    local v5 = Skill_Animations:FindFirstChild(u1.AnimationName);

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

function u1._PerformHit(p8) -- Line: 81
    -- upvalues: u1 (copy)
    local HitboxSize = p8.ClassData.HitboxSize;
    local Range = p8.ClassData.Range;
    p8.ClassData.HitboxSize = u1.HitboxSize;
    p8.ClassData.Range = u1.HitboxRange;
    local v9 = p8:Hitbox();
    p8.ClassData.HitboxSize = HitboxSize;
    p8.ClassData.Range = Range;
    local v10 = 0;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, (p8:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v10 = v10 + 1;
        end;
    end;

    return v10;
end;

function u1._SpawnClones(u11) -- Line: 107
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    task.spawn(function() -- Line: 110
        -- upvalues: u1 (ref), u11 (copy), u2 (ref)
        for i = 1, u1.CloneCount do
            if not u11.Is_Using_Skill then
                break;
            end;

            u2:FireAllClients(u11.Player, {
                Action = "Clone",
                FadeDuration = u1.CloneFadeDuration,
                Color = u1.CloneColor
            });
            local v12;

            if i < u1.CloneCount then
                task.wait(u1.CloneInterval);
                v12 = i;
            else
                v12 = i;
            end;
        end;
    end);
end;

function u1.CanActivate(p13) -- Line: 129
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

function u1.Activate(u14, p15) -- Line: 137
    -- upvalues: u1 (copy), Debris (copy)
    local v16 = u1._EnsureAnimation(u14);

    if not v16 then
        warn("[Quickdraw] Animation not found");

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
    u14.Player:SetAttribute("iFrame", true);
    u14.Character:SetAttribute("iFrame", true);

    for i, v in u14.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v16:Play(0, 1, 1);
    local u20 = v16:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 168
        -- upvalues: u14 (copy), u1 (ref), Debris (ref)
        local v18 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

        if not v18 then
            return;
        end;

        local Humanoid = u14.Humanoid;
        local v19;

        if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
            v19 = Humanoid.MoveDirection.Unit;
        else
            v19 = v18.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v19 * u1.DashSpeed;
        BodyVelocity.Parent = v18;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
        u1._SpawnClones(u14);
        u14:PlayCombatSound(u1.Skill_SFX, nil, u14.ClassData.SwingVolume or 0.5);
        u14:PlayTurnFX("Left_Shot");
        u14:ShakeCamera("SkillLight");
        u1._PerformHit(u14);
    end);
    local u21 = false;

    local function releaseState() -- Line: 200
        -- upvalues: u21 (ref), u14 (copy)
        if u21 then
            return;
        end;

        u21 = true;
        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;
    end;

    local u22 = v16:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v16.Stopped:Once(function() -- Line: 211
        -- upvalues: u21 (ref), u14 (copy), u20 (ref), u22 (copy)
        if not u21 then
            u21 = true;
            u14.Is_Using_Skill = false;
            u14.Is_Attacking = false;
        end;

        if u20 then
            u20:Disconnect();
        end;

        if u22 then
            u22:Disconnect();
        end;
    end);
    task.delay(u1.IFrameDuration, function() -- Line: 218
        -- upvalues: u14 (copy)
        if u14.Player then
            u14.Player:SetAttribute("iFrame", false);
        end;

        if u14.Character then
            u14.Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 228
        -- upvalues: u21 (ref), u14 (copy), u20 (ref), u22 (copy)
        if not u21 then
            u21 = true;
            u14.Is_Using_Skill = false;
            u14.Is_Attacking = false;
        end;

        if u20 then
            u20:Disconnect();
        end;

        if u22 then
            u22:Disconnect();
        end;
    end);
end;

return u1;