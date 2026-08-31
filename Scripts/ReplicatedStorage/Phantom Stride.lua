--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Phantom Stride
  Path:     game.ReplicatedStorage.Classes.Bowman.Skills.Phantom Stride
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
    Cooldown = 5,
    DamageMultiplier = 1,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(25, 25, 25),
    HitboxRange = 0,
    DashSpeed = 70,
    DashDuration = 0.2,
    IFrameDuration = 0.8,
    CloneCount = 5,
    CloneInterval = 0.06,
    CloneFadeDuration = 1.2,
    CloneColor = Color3.fromRGB(144, 238, 144),
    MaxDuration = 1.5
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._EnsureAnimation(p3) -- Line: 53
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

function u1._SpawnClones(u8) -- Line: 80
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    task.spawn(function() -- Line: 83
        -- upvalues: u1 (ref), u8 (copy), u2 (ref)
        for i = 1, u1.CloneCount do
            if not u8.Is_Using_Skill then
                break;
            end;

            u2:FireAllClients(u8.Player, {
                Action = "Clone",
                FadeDuration = u1.CloneFadeDuration,
                Color = u1.CloneColor
            });
            local v9;

            if i < u1.CloneCount then
                task.wait(u1.CloneInterval);
                v9 = i;
            else
                v9 = i;
            end;
        end;
    end);
end;

function u1._PerformHit(p10) -- Line: 101
    -- upvalues: u1 (copy)
    local HitboxSize = p10.ClassData.HitboxSize;
    local Range = p10.ClassData.Range;
    p10.ClassData.HitboxSize = u1.HitboxSize;
    p10.ClassData.Range = u1.HitboxRange;
    local v11 = p10:Hitbox();
    p10.ClassData.HitboxSize = HitboxSize;
    p10.ClassData.Range = Range;
    local v12 = 0;

    for _, v in v11 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p10:ApplyDamage(v, (p10:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v12 = v12 + 1;
        end;
    end;

    return v12;
end;

function u1.CanActivate(p13) -- Line: 127
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

function u1.Activate(u14, p15) -- Line: 135
    -- upvalues: u1 (copy), Debris (copy)
    local v16 = u1._EnsureAnimation(u14);

    if not v16 then
        warn("[Phantom Stride] Animation not found");

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
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = Character.CFrame.LookVector * u1.DashSpeed;
    BodyVelocity.Parent = Character;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
    u1._SpawnClones(u14);
    local u18 = v16:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 177
        -- upvalues: u1 (ref), u14 (copy)
        u14:PlayCombatSound(u1.Skill_SFX or (u14.ClassData.SwingSoundFolder or "Bow_Shot"), nil, u14.ClassData.SwingVolume or 0.5);

        if p17 == "" or not p17 then
            p17 = nil;
        end;

        u14:PlayTurnFX(p17);
        u1._PerformHit(u14);
    end);
    local u19 = false;

    local function releaseState() -- Line: 186
        -- upvalues: u19 (ref), u14 (copy)
        if u19 then
            return;
        end;

        u19 = true;
        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;
    end;

    local u20 = v16:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v16.Stopped:Once(function() -- Line: 197
        -- upvalues: u19 (ref), u14 (copy), u18 (ref), u20 (copy)
        if not u19 then
            u19 = true;
            u14.Is_Using_Skill = false;
            u14.Is_Attacking = false;
        end;

        if u18 then
            u18:Disconnect();
        end;

        if u20 then
            u20:Disconnect();
        end;
    end);
    task.delay(u1.IFrameDuration, function() -- Line: 204
        -- upvalues: u14 (copy)
        if u14.Player then
            u14.Player:SetAttribute("iFrame", false);
        end;

        if u14.Character then
            u14.Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 214
        -- upvalues: u19 (ref), u14 (copy), u18 (ref), u20 (copy)
        if not u19 then
            u19 = true;
            u14.Is_Using_Skill = false;
            u14.Is_Attacking = false;
        end;

        if u18 then
            u18:Disconnect();
        end;

        if u20 then
            u20:Disconnect();
        end;
    end);
end;

return u1;