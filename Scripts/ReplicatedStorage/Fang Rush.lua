--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Fang Rush
  Path:     game.ReplicatedStorage.Classes.Prisma.Skills.Fang Rush
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u2 = {
    Cooldown = 6,
    MaxCharges = 3,
    DamageMultiplier = 2.5,
    AnimationName = "Ability_1",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(25, 15, 30),
    HitboxRange = 20,
    DashSpeeds = { 60, 70 },
    DashDuration = 0.15,
    DodgeDuration = 1,
    CloneCount = 2,
    CloneInterval = 0.04,
    CloneFadeDuration = 0.6,
    CloneColor = Color3.fromRGB(255, 200, 120),
    CloneSpread = 3,
    MaxDuration = 1
};

function u2._EnsureAnimation(p3) -- Line: 57
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

function u2._PerformHit(p8) -- Line: 83
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

local function RandomOffset(p11) -- Line: 107
    local v12 = (math.random() * 2 - 1) * p11;
    local v13 = (math.random() * 2 - 1) * p11;

    return Vector3.new(v12, 0, v13);
end;

function u2._SpawnClones(u14) -- Line: 115
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return;
    end;

    task.spawn(function() -- Line: 118
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

function u2.CanActivate(p19) -- Line: 138
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

function u2.Activate(u20, p21) -- Line: 146
    -- upvalues: u2 (copy), SharedUtils (copy), Debris (copy)
    local v22 = u2._EnsureAnimation(u20);

    if not v22 then
        warn("[Fang Rush] Animation not found");

        return;
    end;

    local Character = u20.Character;
    local v23;

    if Character then
        v23 = Character:FindFirstChild("HumanoidRootPart");
    else
        v23 = Character;
    end;

    if not v23 then
        return;
    end;

    u20.Is_Using_Skill = true;
    u20.Is_Attacking = true;
    Character:SetAttribute("Dodge", true);
    task.delay(u2.DodgeDuration, function() -- Line: 164
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);

    for i, v in u20.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v22:Play(0, 1, 1);
    u20:PlayFX("Rose_Dash");
    SharedUtils.PlaySoundAt(v23, "anime_explode", 0.8);
    local u24 = 0;
    local u30 = v22:GetMarkerReachedSignal("hit"):Connect(function(p25) -- Line: 187
        -- upvalues: u24 (ref), u20 (copy), u2 (ref), Debris (ref), SharedUtils (ref)
        u24 = u24 + 1;
        local v26 = u24;
        local v27 = u20.Character and u20.Character:FindFirstChild("HumanoidRootPart");

        if not v27 then
            return;
        end;

        u20:PlayFX(v26 == 1 and "Right_Slash" or "Left_Slash");
        u2._SpawnClones(u20);
        local v28 = u2.DashSpeeds[v26] or u2.DashSpeeds[#u2.DashSpeeds];
        local Humanoid = u20.Humanoid;
        local v29;

        if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
            v29 = Humanoid.MoveDirection.Unit;
        else
            v29 = v27.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v29 * v28;
        BodyVelocity.Parent = v27;
        Debris:AddItem(BodyVelocity, u2.DashDuration);
        u20:PlayCombatSound(u20.ClassData.HitSoundFolder or "Hit", nil, u20.ClassData.HitVolume or 1);

        if v26 == 1 then
            SharedUtils.PlaySoundAt(v27, "claw_crosscut_03", 0.8);
        end;

        u20:ShakeCamera("SkillLight");
        u2._PerformHit(u20);
    end);
    local u31 = nil;
    u31 = v22:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 237
        -- upvalues: u30 (ref), u20 (copy), Character (copy), u31 (ref)
        if u30 then
            u30:Disconnect();
        end;

        u20.Is_Using_Skill = false;
        u20.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;

        if u31 then
            u31:Disconnect();
        end;
    end);
    task.delay(u2.MaxDuration, function() -- Line: 250
        -- upvalues: u20 (copy), u30 (ref), Character (copy)
        if u20.Is_Using_Skill then
            u20.Is_Using_Skill = false;
            u20.Is_Attacking = false;
        end;

        if u30 then
            u30:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
end;

return u2;