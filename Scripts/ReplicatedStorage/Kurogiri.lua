--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Kurogiri
  Path:     game.ReplicatedStorage.Classes.Shinobi.Skills.Kurogiri
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
    Cooldown = 7,
    DamageMultiplier = 2.7,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    DashSpeed = 80,
    DashDuration = 0.18,
    IFrameDuration = 0.45,
    SmokeBurstCount = 3,
    SmokeBurstOnDelay = 0.1,
    SmokeBurstOffDelay = 0.05,
    SmokeSFX = "Fire_Woosh",
    HitboxSize = Vector3.new(22, 10, 20),
    HitboxRange = 18,
    HitSFX = "hit_sword_L",
    HitVolume = 0.9,
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

function u1._PerformHit(p7) -- Line: 83
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
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

function u1._Dash(p10) -- Line: 108
    -- upvalues: u1 (copy), Debris (copy)
    local Character = p10.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local Humanoid = p10.Humanoid;
    local v11 = Humanoid and (Humanoid.MoveDirection.Magnitude > 0 and Humanoid.MoveDirection.Unit) or Character.CFrame.LookVector;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v11 * u1.DashSpeed;
    BodyVelocity.Parent = Character;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
end;

function u1._FireSmokeFX(u12) -- Line: 128
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 129
        -- upvalues: u1 (ref), u12 (copy)
        for i = 1, u1.SmokeBurstCount do
            u12:SetLoopFX("Smoke", true);
            task.wait(u1.SmokeBurstOnDelay);
            u12:SetLoopFX("Smoke", false);
            local v13;

            if i < u1.SmokeBurstCount then
                task.wait(u1.SmokeBurstOffDelay);
                v13 = i;
            else
                v13 = i;
            end;
        end;
    end);
end;

function u1.CanActivate(p14) -- Line: 144
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

function u1.Activate(u15, p16) -- Line: 152
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v17 = u1._EnsureAnimation(u15);

    if not v17 then
        warn("[Kurogiri] Animation not found");

        return;
    end;

    local Character = u15.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;

    for i, v in u15.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v17:Play(0, 1, 1);
    local u18 = {};

    local function disconnectAll() -- Line: 179
        -- upvalues: u18 (copy)
        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);
    end;

    local function clearIFrame() -- Line: 184
        -- upvalues: u15 (copy)
        if u15.Player then
            u15.Player:SetAttribute("iFrame", false);
        end;

        if u15.Character then
            u15.Character:SetAttribute("iFrame", false);
        end;
    end;

    local u19 = 0;

    local function grantDashIFrame() -- Line: 192
        -- upvalues: u19 (ref), u15 (copy), u1 (ref)
        u19 = u19 + 1;
        local u20 = u19;

        if u15.Player then
            u15.Player:SetAttribute("iFrame", true);
        end;

        u15.Character:SetAttribute("iFrame", true);
        task.delay(u1.IFrameDuration, function() -- Line: 197
            -- upvalues: u20 (copy), u19 (ref), u15 (ref)
            if u20 ~= u19 then
                return;
            end;

            if u15.Player then
                u15.Player:SetAttribute("iFrame", false);
            end;

            if u15.Character then
                u15.Character:SetAttribute("iFrame", false);
            end;
        end);
    end;

    local u21 = false;

    local function releaseState() -- Line: 205
        -- upvalues: u21 (ref), u15 (copy)
        if u21 then
            return;
        end;

        u21 = true;
        u15.Is_Using_Skill = false;
        u15.Is_Attacking = false;
    end;

    local u22 = 0;
    u18[#u18 + 1] = v17:GetMarkerReachedSignal("dash"):Connect(function() -- Line: 215
        -- upvalues: u22 (ref), grantDashIFrame (copy), u1 (ref), u15 (copy), SharedUtils (ref)
        u22 = u22 + 1;
        grantDashIFrame();
        u1._Dash(u15);
        u15:ShakeCamera("SkillLight");

        if u22 == 1 then
            local v23 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

            if v23 then
                SharedUtils.PlaySoundAt(v23, u1.SmokeSFX, 1);
            end;

            u1._FireSmokeFX(u15);
        end;
    end);
    u18[#u18 + 1] = v17:GetMarkerReachedSignal("hit"):Connect(function(p24) -- Line: 235
        -- upvalues: u15 (copy), SharedUtils (ref), u1 (ref)
        local v25 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if v25 then
            SharedUtils.PlaySoundAt(v25, u1.HitSFX, u1.HitVolume);
        end;

        if p24 == "" or not p24 then
            p24 = nil;
        end;

        u15:PlayTurnFX(p24);
        u15:ShakeCamera("Hit");
        u1._PerformHit(u15);
    end);
    u18[#u18 + 1] = v17:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v17.Stopped:Once(function() -- Line: 250
        -- upvalues: u21 (ref), u15 (copy), u18 (copy)
        if not u21 then
            u21 = true;
            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
        end;

        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);

        if u15.Player then
            u15.Player:SetAttribute("iFrame", false);
        end;

        if u15.Character then
            u15.Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 256
        -- upvalues: u21 (ref), u15 (copy), u18 (copy)
        if not u21 then
            u21 = true;
            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
        end;

        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);

        if u15.Player then
            u15.Player:SetAttribute("iFrame", false);
        end;

        if u15.Character then
            u15.Character:SetAttribute("iFrame", false);
        end;
    end);
end;

return u1;