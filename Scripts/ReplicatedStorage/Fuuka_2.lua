--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Fuuka
  Path:     game.ReplicatedStorage.Classes.Zero.Skills.Fuuka
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u2 = {
    Cooldown = 5,
    MaxCharges = 3,
    DamageMultiplier = 1.3,
    AnimationName = "Ability_1",
    DashSpeed = 90,
    DashDuration = 0.29,
    IFrameDuration = 0.5,
    HitboxSize = Vector3.new(24, 40, 30),
    HitboxRange = 28,
    SlashesFX = "Slashes",
    SlashesHits = 3,
    SwingSFXFolder = "Power_Swing_Fast",
    CloneCount = 5,
    CloneInterval = 0.05,
    CloneFadeDuration = 2,
    CloneColor = Color3.fromRGB(0, 200, 255),
    SheatheVolume = 0.8,
    JudgementVolume = 0.6,
    MaxDuration = 2.5
};

function u2._EnsureAnimation(p3) -- Line: 78
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

function u2._PerformHit(p8) -- Line: 105
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

function u2._Dash(p11, p12) -- Line: 131
    -- upvalues: u2 (copy), Debris (copy)
    local Character = p11.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local LookVector = Character.CFrame.LookVector;
    local v13 = 0;

    if p12 == "Back" then
        LookVector = -LookVector;
    elseif p12 == "Up" then
        LookVector = (LookVector + Vector3.new(0, 1, 0)).Unit;
        v13 = 100000;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, v13, 100000);
    BodyVelocity.Velocity = LookVector * u2.DashSpeed;
    BodyVelocity.Parent = Character;
    Debris:AddItem(BodyVelocity, u2.DashDuration);
end;

function u2._AirDash(p14, u15, p16) -- Line: 161
    -- upvalues: u2 (copy)
    if not (u15 and u15.Parent) then
        return;
    end;

    local v17 = p14.Character and p14.Character:FindFirstChild("HumanoidRootPart");

    if not v17 then
        return;
    end;

    local LookVector = v17.CFrame.LookVector;

    if p16 == "Back" then
        LookVector = -LookVector or LookVector;
    end;

    u15.Velocity = Vector3.new(LookVector.X * u2.DashSpeed, 0, LookVector.Z * u2.DashSpeed);
    task.delay(u2.DashDuration, function() -- Line: 172
        -- upvalues: u15 (copy)
        if u15 and u15.Parent then
            u15.Velocity = Vector3.new(0, 0, 0);
        end;
    end);
end;

function u2._SpawnClones(u18) -- Line: 180
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return;
    end;

    task.spawn(function() -- Line: 183
        -- upvalues: u2 (ref), u18 (copy), u1 (ref)
        for i = 1, u2.CloneCount do
            if not (u18.Player and u18.Is_Using_Skill) then
                break;
            end;

            u1:FireAllClients(u18.Player, {
                Action = "Clone",
                FadeDuration = u2.CloneFadeDuration,
                Color = u2.CloneColor
            });
            local v19;

            if i < u2.CloneCount then
                task.wait(u2.CloneInterval);
                v19 = i;
            else
                v19 = i;
            end;
        end;
    end);
end;

function u2.CanActivate(p20) -- Line: 202
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

function u2.Activate(u21, p22) -- Line: 210
    -- upvalues: u2 (copy), SharedUtils (copy)
    local v23 = u2._EnsureAnimation(u21);

    if not v23 then
        warn("[Fuuka] Animation not found");

        return;
    end;

    local Character = u21.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u21.Is_Using_Skill = true;
    u21.Is_Attacking = true;

    for i, v in u21.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    if u21.Player then
        u21.Player:SetAttribute("iFrame", true);
    end;

    u21.Character:SetAttribute("iFrame", true);
    task.delay(u2.IFrameDuration, function() -- Line: 235
        -- upvalues: u21 (copy)
        local Player = u21.Player;
        local Character2 = u21.Character;

        if Player then
            Player:SetAttribute("iFrame", false);
        end;

        if Character2 then
            Character2:SetAttribute("iFrame", false);
        end;
    end);
    v23:Play(0, 1, 1);
    local v24 = u21.IsInAir and u21:IsInAir();
    local u25;

    if v24 then
        u25 = Instance.new("BodyVelocity");
        u25.Name = "FuukaAirHold";
        u25.MaxForce = Vector3.new(100000, 100000, 100000);
        u25.Velocity = Vector3.new(0, 0, 0);
        u25.Parent = Character;
    else
        u25 = nil;
    end;

    local u26 = {};

    local function disconnectAll() -- Line: 263
        -- upvalues: u26 (copy)
        for _, v in u26 do
            v:Disconnect();
        end;

        table.clear(u26);
    end;

    local u27 = false;

    local function releaseState() -- Line: 273
        -- upvalues: u27 (ref), u25 (ref), u21 (copy)
        if u27 then
            return;
        end;

        u27 = true;

        if u25 then
            u25:Destroy();
            u25 = nil;
        end;

        u21.Is_Using_Skill = false;
        u21.Is_Attacking = false;
    end;

    u26[#u26 + 1] = v23:GetMarkerReachedSignal("dash"):Connect(function(p28) -- Line: 288
        -- upvalues: u25 (ref), u2 (ref), u21 (copy), SharedUtils (ref), Character (copy)
        if u25 then
            u2._AirDash(u21, u25, p28);
        else
            u2._Dash(u21, p28);
        end;

        u2._SpawnClones(u21);
        u21:ShakeCamera("SkillLight");
        SharedUtils.PlaySoundAt(Character, "Judgement_Cut", u2.JudgementVolume);
    end);
    local u29 = 0;
    u26[#u26 + 1] = v23:GetMarkerReachedSignal("hit"):Connect(function(p30) -- Line: 302
        -- upvalues: u29 (ref), u2 (ref), u21 (copy)
        u29 = u29 + 1;

        if u29 <= u2.SlashesHits then
            u21:PlayFX(u2.SlashesFX);
        else
            if p30 == "" or not p30 then
                p30 = nil;
            end;

            u21:PlayTurnFX(p30);
        end;

        u21:PlayCombatSound(u2.SwingSFXFolder, nil, u21.ClassData.SwingVolume or 0.5);
        u21:ShakeCamera("Hit");
        u2._PerformHit(u21);
    end);
    u26[#u26 + 1] = v23:GetMarkerReachedSignal("sheathe"):Connect(function() -- Line: 317
        -- upvalues: u21 (copy), SharedUtils (ref), u2 (ref)
        local v31 = u21.Character and u21.Character:FindFirstChild("HumanoidRootPart");

        if v31 then
            SharedUtils.PlaySoundAt(v31, "Sheathe_1", u2.SheatheVolume);
        end;
    end);
    u26[#u26 + 1] = v23:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v23.Stopped:Once(function() -- Line: 330
        -- upvalues: u27 (ref), u25 (ref), u21 (copy), u26 (copy)
        if not u27 then
            u27 = true;

            if u25 then
                u25:Destroy();
                u25 = nil;
            end;

            u21.Is_Using_Skill = false;
            u21.Is_Attacking = false;
        end;

        for _, v in u26 do
            v:Disconnect();
        end;

        table.clear(u26);

        if u21.Player then
            u21.Player:SetAttribute("iFrame", false);
        end;

        if u21.Character then
            u21.Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay(u2.MaxDuration, function() -- Line: 337
        -- upvalues: u27 (ref), u25 (ref), u21 (copy), u26 (copy)
        if not u27 then
            u27 = true;

            if u25 then
                u25:Destroy();
                u25 = nil;
            end;

            u21.Is_Using_Skill = false;
            u21.Is_Attacking = false;
        end;

        for _, v in u26 do
            v:Disconnect();
        end;

        table.clear(u26);

        if u21.Player then
            u21.Player:SetAttribute("iFrame", false);
        end;

        if u21.Character then
            u21.Character:SetAttribute("iFrame", false);
        end;
    end);
end;

return u2;