--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Eclipse Draw
  Path:     game.ReplicatedStorage.Classes.Sunless.Skills.Eclipse Draw
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:00 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 7,
    MaxCharges = 2,
    DamageMultiplier = 7,
    AnimationName = "Ability_1",
    EffectModule = "Eclipse_Draw",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(35, 15, 40),
    HitboxRange = 30,
    DodgeDuration = 1.15,
    DashSpeed = 80,
    DashDuration = 0.12,
    ImpactSFX = { "Sword_Clash_4", "explosion_punch" },
    MaxDuration = 1.6
};

function u1._EnsureAnimation(p2) -- Line: 57
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

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
        end;
    end;
end;

function u1.CanActivate(p9) -- Line: 105
    if p9.Is_Attacking then
        return false, "Attacking";
    end;

    if p9.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p9.Is_Dodging then
        return false, "Dodging";
    end;

    if p9.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u10, p11) -- Line: 113
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local v12 = u1._EnsureAnimation(u10);

    if not v12 then
        warn("[Eclipse Draw] Animation not found");

        return;
    end;

    local Character = u10.Character;
    local v13;

    if Character then
        v13 = Character:FindFirstChild("HumanoidRootPart");
    else
        v13 = Character;
    end;

    if not v13 then
        return;
    end;

    u10.Is_Using_Skill = true;
    u10.Is_Attacking = true;

    for i, v in u10.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    Character:SetAttribute("Dodge", true);
    task.delay(u1.DodgeDuration, function() -- Line: 137
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    local Humanoid = u10.Humanoid;
    local v14;

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
        v14 = Humanoid.MoveDirection.Unit;
    else
        v14 = v13.CFrame.LookVector;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v14 * u1.DashSpeed;
    BodyVelocity.Parent = v13;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
    v12:Play(0, 1, 1);
    local u15 = {};

    local function disconnectAll() -- Line: 163
        -- upvalues: u15 (copy)
        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end;

    local u16 = false;

    local function cleanup() -- Line: 169
        -- upvalues: u16 (ref), u10 (copy), Character (copy), u15 (copy)
        if u16 then
            return;
        end;

        u16 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;

        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end;

    u15[#u15 + 1] = v12:GetMarkerReachedSignal("VFX"):Connect(function(p17) -- Line: 181
        -- upvalues: u10 (copy), u1 (ref), SharedUtils (ref)
        if not p17 or p17 == "" then
            return;
        end;

        local v18 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if not v18 then
            return;
        end;

        for _, v in u1.ImpactSFX do
            SharedUtils.PlaySoundAt(v18, v, 0.85);
        end;

        u10:ShakeCamera("SkillHeavy");
        u10:PlayEffectModule(u1.EffectModule, "Emit", v18.CFrame, p17);
    end);
    u15[#u15 + 1] = v12:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 195
        -- upvalues: u1 (ref), u10 (copy)
        u10:PlayCombatSound(u1.Skill_SFX or u10.ClassData.SwingSoundFolder or "Electric_Swing", nil, u10.ClassData.SwingVolume or 1);
        u1._PerformHit(u10);
    end);
    u15[#u15 + 1] = v12:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v12.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, cleanup);
end;

return u1;