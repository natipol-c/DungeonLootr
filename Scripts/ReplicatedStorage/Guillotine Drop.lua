--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Guillotine Drop
  Path:     game.ReplicatedStorage.Classes.Shinobi.Skills.Guillotine Drop
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
local u1 = {
    Cooldown = 9,
    DamageMultiplier = 1.67,
    AnimationName = "Ability_3",
    Skill_SFX = nil,
    DashSpeed = 70,
    DashDuration = 0.25,
    IFrameDuration = 0.8,
    AoEHitboxSize = Vector3.new(28, 20, 28),
    AoEHitboxRange = 15,
    MaxDuration = 2.5
};

function u1._EnsureAnimation(p2) -- Line: 45
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

function u1._PerformAoEHit(p7) -- Line: 72
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.AoEHitboxSize;
    p7.ClassData.Range = u1.AoEHitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    local v9 = 0;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v9 = v9 + 1;
        end;
    end;

    return v9;
end;

function u1.CanActivate(p10) -- Line: 99
    if p10.Is_Attacking then
        return false, "Attacking";
    end;

    if p10.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p10.Is_Dodging then
        return false, "Dodging";
    end;

    if p10.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u11, p12) -- Line: 107
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Guillotine Drop] Animation not found");

        return;
    end;

    local Character = u11.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;

    for i, v in u11.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v13:Play(0, 1, 1);
    local u15 = v13:GetMarkerReachedSignal("dash"):Connect(function() -- Line: 134
        -- upvalues: u11 (copy), u1 (ref), Debris (ref), SharedUtils (ref)
        local v14 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v14 then
            return;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v14.CFrame.LookVector * u1.DashSpeed;
        BodyVelocity.Parent = v14;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
        SharedUtils.PlaySoundAt(v14, "Fire_Woosh", 1);
        task.delay(u1.DashDuration, function() -- Line: 150
            -- upvalues: u11 (ref), u1 (ref)
            if u11.Player then
                u11.Player:SetAttribute("iFrame", true);
            end;

            if u11.Character then
                u11.Character:SetAttribute("iFrame", true);
            end;

            task.delay(u1.IFrameDuration, function() -- Line: 154
                -- upvalues: u11 (ref)
                if u11.Player then
                    u11.Player:SetAttribute("iFrame", false);
                end;

                if u11.Character then
                    u11.Character:SetAttribute("iFrame", false);
                end;
            end);
        end);
    end);
    local u16 = 0;
    local u20 = v13:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 164
        -- upvalues: u16 (ref), u1 (ref), u11 (copy), SharedUtils (ref)
        u16 = u16 + 1;
        local v18 = u1.Skill_SFX or (u11.ClassData.SwingSoundFolder or "Sword_Swings");

        if u16 == 2 then
            local v19 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

            if v19 then
                SharedUtils.PlaySoundAt(v19, "Ground_Crush", 1);
            end;
        else
            u11:PlayCombatSound(v18, nil, u11.ClassData.SwingVolume or 0.5);
        end;

        if p17 == "" or not p17 then
            p17 = nil;
        end;

        u11:PlayTurnFX(p17);
        u11:ShakeCamera("SkillLight");
        u1._PerformAoEHit(u11);
    end);
    v13.Stopped:Once(function() -- Line: 185
        -- upvalues: u20 (ref), u15 (ref), u11 (copy)
        if u20 then
            u20:Disconnect();
        end;

        if u15 then
            u15:Disconnect();
        end;

        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 194
        -- upvalues: u11 (copy), u20 (ref), u15 (ref)
        if u11.Is_Using_Skill then
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        if u20 then
            u20:Disconnect();
        end;

        if u15 then
            u15:Disconnect();
        end;

        if u11.Player then
            u11.Player:SetAttribute("iFrame", false);
        end;

        if u11.Character then
            u11.Character:SetAttribute("iFrame", false);
        end;
    end);
end;

return u1;