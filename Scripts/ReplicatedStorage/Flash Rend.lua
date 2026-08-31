--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Flash Rend
  Path:     game.ReplicatedStorage.Classes.Shinobi.Skills.Flash Rend
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 8,
    MaxCharges = 2,
    DamageMultiplier = 1,
    AnimationName = "Ability_1",
    HitboxSize = Vector3.new(20, 10, 22),
    HitboxRange = 18,
    IFrameDuration = 1,
    CloneFadeDuration = 0.8,
    HitSFX = "sukuna_slash_single",
    HitVolume = 0.8,
    MaxDuration = 1.2
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._EnsureAnimation(p3) -- Line: 52
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

function u1._PerformHit(p8) -- Line: 79
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

function u1._SpawnClone(p11) -- Line: 104
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    u2:FireAllClients(p11.Player, {
        Action = "Clone",
        FadeDuration = u1.CloneFadeDuration
    });
end;

function u1.CanActivate(p12) -- Line: 115
    if p12.Is_Attacking then
        return false, "Attacking";
    end;

    if p12.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p12.Is_Dodging then
        return false, "Dodging";
    end;

    if p12.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u13, p14) -- Line: 123
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v15 = u1._EnsureAnimation(u13);

    if not v15 then
        warn("[Flash Rend] Animation not found");

        return;
    end;

    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;

    if u13.Player then
        u13.Player:SetAttribute("iFrame", true);
    end;

    u13.Character:SetAttribute("iFrame", true);
    task.delay(u1.IFrameDuration, function() -- Line: 137
        -- upvalues: u13 (copy)
        local Player = u13.Player;
        local Character = u13.Character;

        if Player then
            Player:SetAttribute("iFrame", false);
        end;

        if Character then
            Character:SetAttribute("iFrame", false);
        end;
    end);
    u13.Character:SetAttribute("Skill_Camera_Stabilize", true);

    for i, v in u13.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v15:Play(0, 1, 1);
    local u16 = {};

    local function disconnectAll() -- Line: 161
        -- upvalues: u16 (copy)
        for _, v in u16 do
            v:Disconnect();
        end;

        table.clear(u16);
    end;

    local u17 = false;

    local function releaseState() -- Line: 169
        -- upvalues: u17 (ref), u13 (copy)
        if u17 then
            return;
        end;

        u17 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    u16[#u16 + 1] = v15:GetMarkerReachedSignal("hit"):Connect(function(p18) -- Line: 178
        -- upvalues: u13 (copy), SharedUtils (ref), u1 (ref)
        local v19 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v19 then
            SharedUtils.PlaySoundAt(v19, u1.HitSFX, u1.HitVolume);
        end;

        if p18 == "" or not p18 then
            p18 = nil;
        end;

        u13:PlayTurnFX(p18);
        u13:ShakeCamera("SkillLight");
        u1._SpawnClone(u13);
        u1._PerformHit(u13);
    end);
    u16[#u16 + 1] = v15:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v15.Stopped:Once(function() -- Line: 195
        -- upvalues: u17 (ref), u13 (copy), u16 (copy)
        if not u17 then
            u17 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        for _, v in u16 do
            v:Disconnect();
        end;

        table.clear(u16);

        if u13.Player then
            u13.Player:SetAttribute("iFrame", false);
        end;

        if u13.Character then
            u13.Character:SetAttribute("iFrame", false);
            u13.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 205
        -- upvalues: u17 (ref), u13 (copy), u16 (copy)
        if not u17 then
            u17 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        for _, v in u16 do
            v:Disconnect();
        end;

        table.clear(u16);

        if u13.Player then
            u13.Player:SetAttribute("iFrame", false);
        end;

        if u13.Character then
            u13.Character:SetAttribute("iFrame", false);
            u13.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;
    end);
end;

return u1;