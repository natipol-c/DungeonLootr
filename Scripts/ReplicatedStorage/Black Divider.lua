--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Black Divider
  Path:     game.ReplicatedStorage.Classes.Anti Magic.Skills.Black Divider
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:47 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local RigUtil = require(ReplicatedStorage.Modules.RigUtil);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_3",
    MainMultiplier = 1.2,
    FinisherMultiplier = 2.6,
    HitboxSize = Vector3.new(28, 28, 38),
    HitboxRange = 38,
    ParryWindow = 0.4,
    StunDuration = 3,
    PhantomForwardDistance = 25,
    PhantomColor = Color3.fromRGB(25, 25, 25),
    PhantomFadeDuration = 1,
    PhantomPauseAtEnd = 0.4,
    PhantomFXNames = { "Right_Slash", "Left_Slash", "Right_Slash" },
    MaxDuration = 2.5
};

function u1._EnsureAnimation(p2) -- Line: 71
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

function u1._ApplyStun(u7) -- Line: 101
    -- upvalues: u1 (copy)
    local HumanoidRootPart = u7:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    u7:SetAttribute("Is_Stunned", true);
    local Anchored = HumanoidRootPart.Anchored;
    HumanoidRootPart.Anchored = true;
    task.delay(u1.StunDuration, function() -- Line: 120
        -- upvalues: u7 (copy), HumanoidRootPart (copy), Anchored (copy)
        if u7 and u7.Parent then
            u7:SetAttribute("Is_Stunned", false);
        end;

        if HumanoidRootPart and HumanoidRootPart.Parent then
            HumanoidRootPart.Anchored = Anchored;
        end;
    end);
end;

function u1._GetPhantomRemote() -- Line: 131
    -- upvalues: ReplicatedStorage (copy)
    local v8 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes");

    if not v8 then
        return nil;
    end;

    local PhantomAttack = v8:FindFirstChild("PhantomAttack");

    if not PhantomAttack then
        PhantomAttack = Instance.new("RemoteEvent");
        PhantomAttack.Name = "PhantomAttack";
        PhantomAttack.Parent = v8;
    end;

    return PhantomAttack;
end;

function u1._PerformPhantomHit(p9, p10, p11, p12) -- Line: 145
    -- upvalues: u1 (copy), RigUtil (copy), Players (copy)
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { p9.Character };
    local v13 = p10 * CFrame.new(0, 0, -u1.HitboxRange / 2);
    local v14 = {};

    for _, v in workspace:GetPartBoundsInBox(v13, u1.HitboxSize, OverlapParams_new_ret) do
        local v15 = v:FindFirstAncestorOfClass("Model");

        if v15 and (not v14[v15] and (RigUtil.IsHittableTarget(v15) and not Players:GetPlayerFromCharacter(v15))) then
            v14[v15] = true;
        end;
    end;

    for i in v14 do
        if not i:HasTag("Ignore_Damage") and (not i:GetAttribute("Dead") or i:GetAttribute("Can_Finish")) then
            p9:ApplyDamage(i, (p9:ResolveSkillDamage(p11, i)));

            if p12 and (not i:GetAttribute("IsBoss") and p9:CanApplyStatusTo(i)) then
                u1._ApplyStun(i);
            end;
        end;
    end;
end;

function u1._PerformHit(p16, p17, p18) -- Line: 183
    -- upvalues: u1 (copy)
    local HitboxSize = p16.ClassData.HitboxSize;
    local Range = p16.ClassData.Range;
    p16.ClassData.HitboxSize = u1.HitboxSize;
    p16.ClassData.Range = u1.HitboxRange;
    local v19 = p16:Hitbox();
    p16.ClassData.HitboxSize = HitboxSize;
    p16.ClassData.Range = Range;
    local v20 = 0;

    for _, v in v19 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p16:ApplyDamage(v, (p16:ResolveSkillDamage(p17, v)));
            v20 = v20 + 1;

            if p18 and (not v:GetAttribute("IsBoss") and p16:CanApplyStatusTo(v)) then
                u1._ApplyStun(v);
            end;
        end;
    end;

    return v20;
end;

function u1.CanActivate(p21) -- Line: 215
    if p21.Is_Attacking then
        return false, "Attacking";
    end;

    if p21.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p21.Is_Dodging then
        return false, "Dodging";
    end;

    if p21.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u22, p23) -- Line: 223
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v24 = u1._EnsureAnimation(u22);

    if not v24 then
        warn("[Black Divider] Animation not found");

        return;
    end;

    local Character = u22.Character;

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

    v24:Play(0, 1, 1);
    local u25 = nil;

    if u22.Player and u22.Player:GetAttribute("Heat_Active") then
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            u25 = CFrame.lookAt(HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * u1.PhantomForwardDistance, HumanoidRootPart.Position);
            local v26 = u1._GetPhantomRemote();

            if v26 then
                local v27 = u22.Player:GetAttribute("Active_Class") or (u22.ClassName or "");
                v26:FireAllClients(u22.Player, {
                    ClassName = v27,
                    AnimationName = u1.AnimationName,
                    FXNames = u1.PhantomFXNames,
                    Color = u1.PhantomColor,
                    FadeDuration = u1.PhantomFadeDuration,
                    PauseAtEnd = u1.PhantomPauseAtEnd,
                    AttackSpeed = u22:GetEffectiveStat("AttackSpeed") or 1,
                    SwingSoundFolder = u22.ClassData.SwingSoundFolder,
                    Position = u25
                });
            end;
        end;
    end;

    local u28 = 0;
    local u32 = v24:GetMarkerReachedSignal("hit"):Connect(function(p29) -- Line: 277
        -- upvalues: u28 (ref), Character (copy), u1 (ref), SharedUtils (ref), u22 (copy), u25 (ref)
        u28 = u28 + 1;
        Character:SetAttribute("Parry", true);
        task.delay(u1.ParryWindow, function() -- Line: 282
            -- upvalues: Character (ref)
            if Character then
                Character:SetAttribute("Parry", false);
            end;
        end);
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            if u28 == 1 then
                SharedUtils.PlaySoundAt(HumanoidRootPart, "anime_explode", 1);
                SharedUtils.PlaySoundAt(HumanoidRootPart, "power_spin_01", 1);
            elseif u28 == 2 then
                SharedUtils.PlaySoundAt(HumanoidRootPart, "anime_explode", 1);
                SharedUtils.PlaySoundAt(HumanoidRootPart, "power_spin_02", 1);
            elseif u28 == 3 then
                SharedUtils.PlaySoundAt(HumanoidRootPart, "explosion_punch", 1);
                SharedUtils.PlaySoundAt(HumanoidRootPart, "power_spin_04", 1);
            end;
        end;

        if p29 == "" or not p29 then
            p29 = nil;
        end;

        u22:PlayTurnFX(p29);
        u22:ShakeCamera("SkillLight");
        local v30;

        if u28 <= 2 then
            v30 = u1.MainMultiplier;
        else
            v30 = u1.FinisherMultiplier;
        end;

        local v31 = u28 == 3;
        u1._PerformHit(u22, v30, v31);

        if u25 then
            u1._PerformPhantomHit(u22, u25, v30, v31);
        end;
    end);
    v24.Stopped:Once(function() -- Line: 319
        -- upvalues: u32 (ref), Character (copy), u22 (copy)
        if u32 then
            u32:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;

        u22.Is_Using_Skill = false;
        u22.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 328
        -- upvalues: u22 (copy), u32 (ref), Character (copy)
        if u22.Is_Using_Skill then
            u22.Is_Using_Skill = false;
            u22.Is_Attacking = false;
        end;

        if u32 then
            u32:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;