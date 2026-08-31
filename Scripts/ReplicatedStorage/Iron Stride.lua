--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Iron Stride
  Path:     game.ReplicatedStorage.Classes.Oathbreaker.Skills.Iron Stride
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = {
    Cooldown = 12,
    DamageMultiplier = 2.1,
    AnimationName = "Ability_3",
    Skill_SFX = nil,
    DashSpeed = 75,
    DashDuration = 0.2,
    IFrameDuration = 0.5,
    CloneCount = 4,
    CloneInterval = 0.15,
    CloneFadeDuration = 1.2,
    CloneColor = Color3.fromRGB(220, 100, 30),
    HitboxSize = Vector3.new(20, 10, 20),
    MaxDuration = 1.5
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._EnsureAnimation(p3) -- Line: 58
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

function u1._PerformHit(p8) -- Line: 84
    -- upvalues: u1 (copy)
    local HitboxSize = p8.ClassData.HitboxSize;
    p8.ClassData.HitboxSize = u1.HitboxSize;
    local v9 = p8:Hitbox();
    p8.ClassData.HitboxSize = HitboxSize;
    local v10 = 0;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, (p8:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v10 = v10 + 1;
        end;
    end;

    return v10;
end;

function u1._SpawnClones(u11) -- Line: 106
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    task.spawn(function() -- Line: 109
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

function u1.CanActivate(p13) -- Line: 128
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

function u1.Activate(u14, p15) -- Line: 136
    -- upvalues: u1 (copy), Debris (copy)
    local v16 = u1._EnsureAnimation(u14);

    if not v16 then
        warn("[Iron Stride] Animation not found");

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

    u1._SpawnClones(u14);
    v16:Play(0, 1, 1);
    local u19 = v16:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 170
        -- upvalues: u14 (copy), u1 (ref), Debris (ref)
        local v18 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

        if v18 then
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Name = "SkillDash";
            BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
            BodyVelocity.Velocity = v18.CFrame.LookVector * u1.DashSpeed;
            BodyVelocity.Parent = v18;
            Debris:AddItem(BodyVelocity, u1.DashDuration);
        end;

        u14:PlayCombatSound(u1.Skill_SFX or (u14.ClassData.SwingSoundFolder or "Flame_Swing"), nil, u14.ClassData.SwingVolume or 0.5);

        if p17 == "" or not p17 then
            p17 = nil;
        end;

        u14:PlayTurnFX(p17);
        u14:ShakeCamera("SkillLight");
        u1._PerformHit(u14);
    end);
    v16.Stopped:Once(function() -- Line: 191
        -- upvalues: u19 (ref), u14 (copy)
        if u19 then
            u19:Disconnect();
        end;

        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;
    end);
    task.delay(u1.IFrameDuration, function() -- Line: 199
        -- upvalues: u14 (copy)
        if u14.Player then
            u14.Player:SetAttribute("iFrame", false);
        end;

        if u14.Character then
            u14.Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 209
        -- upvalues: u14 (copy), u19 (ref)
        if u14.Is_Using_Skill then
            u14.Is_Using_Skill = false;
            u14.Is_Attacking = false;
        end;

        if u19 then
            u19:Disconnect();
        end;

        if u14.Player then
            u14.Player:SetAttribute("iFrame", false);
        end;

        if u14.Character then
            u14.Character:SetAttribute("iFrame", false);
        end;
    end);
end;

return u1;