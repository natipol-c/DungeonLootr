--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rushing Edge
  Path:     game.ReplicatedStorage.Classes.Spell Breaker.Skills.Rushing Edge
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 6,
    MaxCharges = 3,
    AnimationName = "Ability_1",
    Skill_SFX = nil,
    HitMultipliers = { 0.57, 0.57, 0.57, 3.3 },
    HitboxSize = Vector3.new(20, 20, 30),
    Range = 30,
    DashSpeed = 70,
    DashDuration = 0.2,
    IFrameDuration = 0.4,
    HitSFX = {
        [1] = "Sword_Clash_4",
        [4] = "anime_explode"
    },
    DodgeSFX = "Dodge",
    MaxDuration = 2.5
};

function u1._EnsureAnimation(p2) -- Line: 56
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

function u1._PerformHit(p7, p8) -- Line: 83
    -- upvalues: u1 (copy)
    local ClassData = p7.ClassData;
    local HitboxSize = ClassData.HitboxSize;
    local Range = ClassData.Range;
    ClassData.HitboxSize = u1.HitboxSize;
    ClassData.Range = u1.Range;
    local v9 = p7:Hitbox();
    ClassData.HitboxSize = HitboxSize;
    ClassData.Range = Range;
    local v10 = 0;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
            v10 = v10 + 1;
        end;
    end;

    return v10;
end;

function u1._DoCastDash(p11) -- Line: 110
    -- upvalues: u1 (copy), Debris (copy)
    local v12 = p11.Character and p11.Character:FindFirstChild("HumanoidRootPart");

    if not v12 then
        return;
    end;

    local Humanoid = p11.Humanoid;
    local v13;

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
        v13 = Humanoid.MoveDirection.Unit;
    else
        v13 = v12.CFrame.LookVector;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v13 * u1.DashSpeed;
    BodyVelocity.Parent = v12;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
end;

function u1.CanActivate(p14) -- Line: 133
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

function u1.Activate(u15, p16) -- Line: 141
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v17 = u1._EnsureAnimation(u15);

    if not v17 then
        warn("[Rushing Edge] Animation not found");

        return;
    end;

    local Character = u15.Character;
    local u18;

    if Character then
        u18 = Character:FindFirstChild("HumanoidRootPart");
    else
        u18 = Character;
    end;

    if not u18 then
        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;

    for i, v in u15.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    u1._DoCastDash(u15);
    v17:Play(0, 1, 1);
    local u19 = 0;
    local u23 = v17:GetMarkerReachedSignal("hit"):Connect(function(p20) -- Line: 172
        -- upvalues: u19 (ref), u15 (copy), u1 (ref), SharedUtils (ref), u18 (copy)
        u19 = u19 + 1;
        local v21 = u15.ClassData.SwingVolume or 0.5;
        local v22 = u1.HitSFX[u19];

        if v22 then
            SharedUtils.PlaySoundAt(u18, v22, v21);
        else
            u15:PlayCombatSound(u1.Skill_SFX or (u15.ClassData.SwingSoundFolder or "Ninja"), nil, v21);
        end;

        if p20 == "" or not p20 then
            p20 = nil;
        end;

        u15:PlayTurnFX(p20);
        u15:ShakeCamera("SkillMedium");
        u1._PerformHit(u15, u1.HitMultipliers[u19] or u1.HitMultipliers[#u1.HitMultipliers]);
    end);
    local u25 = v17:GetMarkerReachedSignal("Dodge"):Connect(function(p24) -- Line: 201
        -- upvalues: SharedUtils (ref), u18 (copy), u1 (ref), u15 (copy), Character (copy)
        SharedUtils.PlaySoundAt(u18, u1.DodgeSFX, u15.ClassData.SwingVolume or 0.5);
        u15.Player:SetAttribute("Protected", true);
        u15.Player:SetAttribute("iFrame", true);
        Character:SetAttribute("Protected", true);
        Character:SetAttribute("iFrame", true);
        task.delay(u1.IFrameDuration, function() -- Line: 209
            -- upvalues: u15 (ref), Character (ref)
            if u15.Player then
                u15.Player:SetAttribute("Protected", false);
                u15.Player:SetAttribute("iFrame", false);
            end;

            if Character then
                Character:SetAttribute("Protected", false);
                Character:SetAttribute("iFrame", false);
            end;
        end);
    end);
    v17.Stopped:Once(function() -- Line: 222
        -- upvalues: u23 (ref), u25 (ref), u15 (copy)
        if u23 then
            u23:Disconnect();
        end;

        if u25 then
            u25:Disconnect();
        end;

        u15.Is_Using_Skill = false;
        u15.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 231
        -- upvalues: u15 (copy), u23 (ref), u25 (ref)
        if u15.Is_Using_Skill then
            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
        end;

        if u23 then
            u23:Disconnect();
        end;

        if u25 then
            u25:Disconnect();
        end;
    end);
end;

return u1;