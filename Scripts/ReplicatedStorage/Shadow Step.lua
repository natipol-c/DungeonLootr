--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Shadow Step
  Path:     game.ReplicatedStorage.Classes.Kage.Skills.Shadow Step
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u2 = {
    Cooldown = 8,
    MaxCharges = 3,
    DamageMultiplier = 3.5,
    AnimationName = "Ability_1",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(20, 20, 28),
    HitboxRange = 28,
    WarpSearchRange = 60,
    WarpBehindOffset = 5,
    CloneFadeDuration = 0.6,
    CloneColor = Color3.fromRGB(60, 20, 80),
    MaxDuration = 2
};

function u2._EnsureAnimation(p3) -- Line: 53
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

function u2._PerformHit(p8) -- Line: 79
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

function u2._FindNearestEnemy(p11) -- Line: 104
    -- upvalues: u2 (copy), CollectionService (copy)
    local v12 = p11.Character and p11.Character:FindFirstChild("HumanoidRootPart");

    if not v12 then
        return nil;
    end;

    local Position = v12.Position;
    local v13 = u2.WarpSearchRange + 1;
    local v14 = nil;

    for _, v in CollectionService:GetTagged("Enemy") do
        if v.Parent and not v:GetAttribute("Dead") then
            local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                local Magnitude = (HumanoidRootPart.Position - Position).Magnitude;

                if Magnitude <= u2.WarpSearchRange and Magnitude < v13 then
                    v13 = Magnitude;
                    v14 = {
                        model = v,
                        hrp = HumanoidRootPart
                    };
                end;
            end;
        end;
    end;

    return v14;
end;

function u2._WarpBehind(p15, p16) -- Line: 130
    -- upvalues: u2 (copy)
    local v17 = p15.Character and p15.Character:FindFirstChild("HumanoidRootPart");

    if not (v17 and p16.hrp) then
        return;
    end;

    local v18 = p16.hrp.CFrame * CFrame.new(0, 0, u2.WarpBehindOffset);
    v17.CFrame = CFrame.new(v18.Position, p16.hrp.Position);
end;

function u2._SpawnClone(p19) -- Line: 138
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return;
    end;

    u1:FireAllClients(p19.Player, {
        Action = "Clone",
        FadeDuration = u2.CloneFadeDuration,
        Color = u2.CloneColor
    });
end;

function u2.CanActivate(p20) -- Line: 150
    if p20.Is_Attacking then
        return false, "Attacking";
    end;

    if p20.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p20.Is_Dodging then
        return false, "Dodging";
    end;

    if p20.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u2.Activate(u21, p22) -- Line: 158
    -- upvalues: u2 (copy), SharedUtils (copy)
    local v23 = u2._EnsureAnimation(u21);

    if not v23 then
        warn("[Shadow Step] Animation not found");

        return;
    end;

    local Character = u21.Character;
    local v24;

    if Character then
        v24 = Character:FindFirstChild("HumanoidRootPart");
    else
        v24 = Character;
    end;

    if not v24 then
        return;
    end;

    u21.Is_Using_Skill = true;
    u21.Is_Attacking = true;
    Character:SetAttribute("Dodge", true);

    for i, v in u21.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    u2._SpawnClone(u21);
    SharedUtils.PlaySoundAt(v24, "Dark_Chase", 1);
    local v25 = u2._FindNearestEnemy(u21);

    if v25 then
        u2._WarpBehind(u21, v25);
    end;

    v23:Play(0, 1, 1);
    local u28 = v23:GetMarkerReachedSignal("hit"):Connect(function(p26) -- Line: 200
        -- upvalues: u21 (copy), SharedUtils (ref), u2 (ref)
        local v27 = u21.Character and u21.Character:FindFirstChild("HumanoidRootPart");

        if not v27 then
            return;
        end;

        SharedUtils.PlaySoundAt(v27, "Earth_Hammer", 1);

        if p26 == "" or not p26 then
            p26 = nil;
        end;

        u21:PlayTurnFX(p26);
        u21:ShakeCamera("SkillHeavy");
        u2._PerformHit(u21);
    end);
    local u29 = nil;
    u29 = v23:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 215
        -- upvalues: u2 (ref), u21 (copy), u28 (ref), u29 (ref), Character (copy)
        u2._SpawnClone(u21);
        u21:PlayFX("Smoke");

        if u28 then
            u28:Disconnect();
        end;

        if u29 then
            u29:Disconnect();
        end;

        u21.Is_Using_Skill = false;
        u21.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    v23.Stopped:Once(function() -- Line: 234
        -- upvalues: u28 (ref), u29 (ref), u21 (copy), Character (copy)
        if u28 then
            u28:Disconnect();
        end;

        if u29 then
            u29:Disconnect();
        end;

        u21.Is_Using_Skill = false;
        u21.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    task.delay(u2.MaxDuration, function() -- Line: 247
        -- upvalues: u21 (copy), u28 (ref), u29 (ref), Character (copy)
        if u21.Is_Using_Skill then
            u21.Is_Using_Skill = false;
            u21.Is_Attacking = false;
        end;

        if u28 then
            u28:Disconnect();
        end;

        if u29 then
            u29:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
end;

return u2;