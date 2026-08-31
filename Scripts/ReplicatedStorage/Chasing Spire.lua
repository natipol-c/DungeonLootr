--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Chasing Spire
  Path:     game.ReplicatedStorage.Classes.Assassin.Skills.Chasing Spire
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = {
    Cooldown = 7,
    DamageMultiplier = 0.83,
    AnimationName = "Ability_1",
    Skill_SFX = nil,
    DashSpeed = 90,
    DashDuration = 0.18,
    CloneColor = Color3.fromRGB(60, 200, 90),
    CloneCount = 3,
    CloneStagger = 0.05,
    CloneFadeDuration = 0.7,
    ParryAfterHit = 4,
    ParryDuration = 0.6,
    HitboxSize = Vector3.new(20, 10, 20),
    MaxDuration = 2.5
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

local function resolveDashDirection(p3) -- Line: 61
    local Humanoid = p3.Humanoid;
    local v4 = p3.Character and p3.Character:FindFirstChild("HumanoidRootPart");

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0.1 then
        local MoveDirection = Humanoid.MoveDirection;

        return Vector3.new(MoveDirection.X, 0, MoveDirection.Z).Unit;
    end;

    if not v4 then
        return Vector3.new(0, 0, -1);
    end;

    local LookVector = v4.CFrame.LookVector;

    return Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
end;

function u1._EnsureAnimation(p5) -- Line: 78
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p5.Animations[AnimationName] then
        return p5.Animations[AnimationName];
    end;

    local v6 = ReplicatedStorage.Classes:FindFirstChild(p5.ClassName);

    if not v6 then
        return nil;
    end;

    local Skill_Animations = v6:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v7 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v7 then
        return nil;
    end;

    local v8 = p5.Humanoid and p5.Humanoid:FindFirstChildOfClass("Animator");

    if not v8 then
        return nil;
    end;

    local v9 = v8:LoadAnimation(v7);
    v9.Priority = Enum.AnimationPriority.Action3;
    v9:Play(0, 0, 0);
    v9:Stop(0);
    p5.Animations[AnimationName] = v9;

    return v9;
end;

function u1._SpawnClones(u10) -- Line: 106
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    if not u10.Player then
        return;
    end;

    for i = 1, u1.CloneCount do
        task.delay((i - 1) * u1.CloneStagger, function() -- Line: 112
            -- upvalues: u10 (copy), u2 (ref), u1 (ref)
            if not (u10.Player and u10.Character) then
                return;
            end;

            u2:FireAllClients(u10.Player, {
                Action = "Clone",
                FadeDuration = u1.CloneFadeDuration,
                Color = u1.CloneColor
            });
        end);
        local _ = i;
    end;
end;

function u1._PerformHit(p11) -- Line: 124
    -- upvalues: u1 (copy)
    local HitboxSize = p11.ClassData.HitboxSize;
    p11.ClassData.HitboxSize = u1.HitboxSize;
    local v12 = p11:Hitbox();
    p11.ClassData.HitboxSize = HitboxSize;
    local v13 = 0;

    for _, v in v12 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p11:ApplyDamage(v, (p11:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v13 = v13 + 1;
        end;
    end;

    return v13;
end;

function u1.CanActivate(p14) -- Line: 147
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

function u1.Activate(u15, p16) -- Line: 155
    -- upvalues: u1 (copy), resolveDashDirection (copy), Debris (copy)
    local v17 = u1._EnsureAnimation(u15);

    if not v17 then
        warn("[Chasing Spire] Animation not found");

        return;
    end;

    local Character = u15.Character;
    local v18;

    if Character then
        v18 = Character:FindFirstChild("HumanoidRootPart");
    else
        v18 = Character;
    end;

    if not v18 then
        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;

    for i, v in u15.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    local v19 = resolveDashDirection(u15);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v19 * u1.DashSpeed;
    BodyVelocity.Parent = v18;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
    u1._SpawnClones(u15);
    v17:Play(0, 1, 1);
    local u20 = 0;
    local u22 = v17:GetMarkerReachedSignal("hit"):Connect(function(p21) -- Line: 195
        -- upvalues: u20 (ref), u1 (ref), u15 (copy), Character (copy)
        u20 = u20 + 1;
        u15:PlayCombatSound(u1.Skill_SFX or (u15.ClassData.SwingSoundFolder or "Ninja"), nil, u15.ClassData.SwingVolume or 0.5);

        if p21 == "" or not p21 then
            p21 = nil;
        end;

        u15:PlayTurnFX(p21);
        u15:ShakeCamera("Hit");
        u1._PerformHit(u15);

        if u20 == u1.ParryAfterHit then
            Character:SetAttribute("Parry", true);
            task.delay(u1.ParryDuration, function() -- Line: 208
                -- upvalues: Character (ref)
                if Character then
                    Character:SetAttribute("Parry", false);
                end;
            end);
        end;
    end);
    v17.Stopped:Once(function() -- Line: 217
        -- upvalues: u22 (ref), u15 (copy), Character (copy)
        if u22 then
            u22:Disconnect();
        end;

        u15.Is_Using_Skill = false;
        u15.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 229
        -- upvalues: u15 (copy), u22 (ref), Character (copy)
        if u15.Is_Using_Skill then
            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
        end;

        if u22 then
            u22:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;