--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Frame Skip
  Path:     game.ReplicatedStorage.Classes.Framebreaker.Skills.Frame Skip
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = {
    Cooldown = 5,
    MaxCharges = 3,
    DamageMultiplier = 4,
    AnimationName = "Ability_1",
    DashSpeed = 200,
    DashDuration = 0.05,
    IFrameDuration = 0.5,
    HitboxSize = Vector3.new(20, 20, 20),
    HitboxRange = 5,
    CloneCount = 4,
    CloneInterval = 0.09,
    CloneFadeDuration = 0.8,
    CloneColor = Color3.fromRGB(0, 200, 180),
    CloneSpread = 4,
    MaxDuration = 1.2,
    SprintBurstInterval = 0.12,
    SprintDamageMultiplier = 1.67,
    SprintDashSpeed = 250,
    SprintMaxDuration = 1.8
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._EnsureAnimation(p3) -- Line: 65
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

function u1._PerformHit(p8) -- Line: 92
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

local function RandomOffset(p11) -- Line: 117
    local v12 = (math.random() * 2 - 1) * p11;
    local v13 = (math.random() * 2 - 1) * p11;

    return Vector3.new(v12, 0, v13);
end;

function u1._SpawnClones(u14) -- Line: 126
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    task.spawn(function() -- Line: 129
        -- upvalues: u1 (ref), u14 (copy), u2 (ref)
        for i = 1, u1.CloneCount do
            if not u14.Is_Using_Skill then
                break;
            end;

            local Player = u14.Player;
            local v15 = {
                Action = "Clone",
                FadeDuration = u1.CloneFadeDuration,
                Color = u1.CloneColor
            };
            local CloneSpread = u1.CloneSpread;
            local v16 = (math.random() * 2 - 1) * CloneSpread;
            local v17 = (math.random() * 2 - 1) * CloneSpread;
            v15.Offset = Vector3.new(v16, 0, v17);
            u2:FireAllClients(Player, v15);
            local v18;

            if i < u1.CloneCount then
                task.wait(u1.CloneInterval);
                v18 = i;
            else
                v18 = i;
            end;
        end;
    end);
end;

function u1._BurstStrike(p19, p20) -- Line: 150
    -- upvalues: u1 (copy), Debris (copy)
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = p20.CFrame.LookVector * u1.SprintDashSpeed;
    BodyVelocity.Parent = p20;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
    u1._SpawnClones(p19);
    p19:PlayCombatSound(p19.ClassData.SwingSoundFolder or "Flame_Swing", nil, p19.ClassData.SwingVolume or 0.5);
    p19:PlayTurnFX();
    p19:ShakeCamera("SkillLight");
    local HitboxSize = p19.ClassData.HitboxSize;
    local Range = p19.ClassData.Range;
    p19.ClassData.HitboxSize = u1.HitboxSize;
    p19.ClassData.Range = u1.HitboxRange;
    local v21 = p19:Hitbox();
    p19.ClassData.HitboxSize = HitboxSize;
    p19.ClassData.Range = Range;

    for _, v in v21 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p19:ApplyDamage(v, (p19:ResolveSkillDamage(u1.SprintDamageMultiplier, v)));
        end;
    end;
end;

function u1._ActivateSprintBurst(u22, p23, u24) -- Line: 188
    -- upvalues: u1 (copy)
    local u25 = u1._EnsureAnimation(u22);
    local Character = u22.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u22.Is_Using_Skill = true;
    u22.Is_Attacking = true;

    for i, v in u22.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    if u25 then
        u25:Play(0, 1, 1.6);
    end;

    u22.Player:SetAttribute("iFrame", true);
    u22.Character:SetAttribute("iFrame", true);
    u1.ManagesCooldown = true;
    u22:ConsumeAllCharges(p23);
    task.spawn(function() -- Line: 220
        -- upvalues: u24 (copy), u22 (copy), u1 (ref), Character (copy), u25 (copy)
        for i = 1, u24 do
            if not u22.Is_Using_Skill then
                break;
            end;

            u1._BurstStrike(u22, Character);
            local v26;

            if i < u24 then
                task.wait(u1.SprintBurstInterval);
                v26 = i;
            else
                v26 = i;
            end;
        end;

        task.wait(0.1);

        if u22.Player then
            u22.Player:SetAttribute("iFrame", false);
        end;

        if u22.Character then
            u22.Character:SetAttribute("iFrame", false);
        end;

        u22.Is_Using_Skill = false;
        u22.Is_Attacking = false;
        u1.ManagesCooldown = false;

        if u25 and u25.IsPlaying then
            u25:Stop(0.15);
        end;
    end);
    task.delay(u1.SprintMaxDuration, function() -- Line: 250
        -- upvalues: u22 (copy), u1 (ref)
        if u22.Is_Using_Skill then
            u22.Is_Using_Skill = false;
            u22.Is_Attacking = false;
        end;

        if u22.Player then
            u22.Player:SetAttribute("iFrame", false);
        end;

        if u22.Character then
            u22.Character:SetAttribute("iFrame", false);
        end;

        u1.ManagesCooldown = false;
    end);
end;

function u1.CanActivate(p27) -- Line: 263
    if p27.Is_Attacking then
        return false, "Attacking";
    end;

    if p27.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p27.Is_Dodging then
        return false, "Dodging";
    end;

    if p27.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u28, p29) -- Line: 271
    -- upvalues: u1 (copy), Debris (copy)
    if u28._wasSprinting then
        local v30 = u28.Skill_Charges[p29];
        local v31 = v30 and v30.current or 1;
        u1._ActivateSprintBurst(u28, p29, v31 < 1 and 1 or v31);

        return;
    end;

    local v32 = u1._EnsureAnimation(u28);

    if not v32 then
        warn("[Frame Skip] Animation not found");

        return;
    end;

    local Character = u28.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u28.Is_Using_Skill = true;
    u28.Is_Attacking = true;

    for i, v in u28.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v32:Play(0, 1, 1);
    local u34 = v32:GetMarkerReachedSignal("hit"):Connect(function(p33) -- Line: 308
        -- upvalues: Character (copy), u1 (ref), Debris (ref), u28 (copy)
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = Character.CFrame.LookVector * u1.DashSpeed;
        BodyVelocity.Parent = Character;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
        u1._SpawnClones(u28);
        u28.Player:SetAttribute("iFrame", true);
        u28.Character:SetAttribute("iFrame", true);
        task.delay(u1.IFrameDuration, function() -- Line: 323
            -- upvalues: u28 (ref)
            if u28.Player then
                u28.Player:SetAttribute("iFrame", false);
            end;

            if u28.Character then
                u28.Character:SetAttribute("iFrame", false);
            end;
        end);
        u28:PlayCombatSound(u28.ClassData.SwingSoundFolder or "Flame_Swing", nil, u28.ClassData.SwingVolume or 0.5);

        if p33 == "" or not p33 then
            p33 = nil;
        end;

        u28:PlayTurnFX(p33);
        u28:ShakeCamera("SkillLight");
        u1._PerformHit(u28);
    end);
    local u35 = false;

    local function releaseState() -- Line: 339
        -- upvalues: u35 (ref), u28 (copy)
        if u35 then
            return;
        end;

        u35 = true;
        u28.Is_Using_Skill = false;
        u28.Is_Attacking = false;
    end;

    local function clearIFrame() -- Line: 346
        -- upvalues: u28 (copy)
        if u28.Player then
            u28.Player:SetAttribute("iFrame", false);
        end;

        if u28.Character then
            u28.Character:SetAttribute("iFrame", false);
        end;
    end;

    local u36 = v32:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v32.Stopped:Once(function() -- Line: 355
        -- upvalues: u35 (ref), u28 (copy), u34 (ref), u36 (copy)
        if not u35 then
            u35 = true;
            u28.Is_Using_Skill = false;
            u28.Is_Attacking = false;
        end;

        if u34 then
            u34:Disconnect();
        end;

        if u36 then
            u36:Disconnect();
        end;

        if u28.Player then
            u28.Player:SetAttribute("iFrame", false);
        end;

        if u28.Character then
            u28.Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 362
        -- upvalues: u35 (ref), u28 (copy), u34 (ref), u36 (copy)
        if not u35 then
            u35 = true;
            u28.Is_Using_Skill = false;
            u28.Is_Attacking = false;
        end;

        if u34 then
            u34:Disconnect();
        end;

        if u36 then
            u36:Disconnect();
        end;

        if u28.Player then
            u28.Player:SetAttribute("iFrame", false);
        end;

        if u28.Character then
            u28.Character:SetAttribute("iFrame", false);
        end;
    end);
end;

return u1;