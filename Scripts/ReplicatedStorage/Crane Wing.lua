--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Crane Wing
  Path:     game.ReplicatedStorage.Classes.Forge Archon.Skills.Crane Wing
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:58 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    Cooldown = 13,
    AnimationName = "Ability_2",
    EffectModule = "Crane_Wing",
    OpenerMultiplier = 1.5,
    OpenerHitbox = Vector3.new(35, 30, 35),
    OpenerRange = 20,
    TornadoMultiplier = 0.5,
    TornadoHitbox = Vector3.new(40, 40, 40),
    TornadoRange = 0,
    LiftSpeed = 75,
    LiftDuration = 0.12,
    SwingVolume = 0.5,
    MaxDuration = 3
};

function u1._EnsureAnimation(p2) -- Line: 60
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

function u1._PerformHit(p7, p8, p9, p10) -- Line: 87
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = p9;
    p7.ClassData.Range = p10;
    local v11 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;

    for _, v in v11 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
        end;
    end;
end;

function u1.CanActivate(p12) -- Line: 109
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

function u1.Activate(u13, p14) -- Line: 117
    -- upvalues: u1 (copy)
    local v15 = u1._EnsureAnimation(u13);

    if not v15 then
        warn("[Crane Wing] Animation not found");

        return;
    end;

    local Character = u13.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;

    for i, v in u13.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v15:Play(0, 1, 1);
    local u16 = nil;

    local function releaseAirHold() -- Line: 147
        -- upvalues: u16 (ref)
        if u16 then
            u16:Destroy();
            u16 = nil;
        end;
    end;

    local u17 = {};

    local function disconnectAll() -- Line: 156
        -- upvalues: u17 (copy)
        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);
    end;

    local function clearParry() -- Line: 161
        -- upvalues: u13 (copy)
        if u13.Character then
            u13.Character:SetAttribute("Parry", false);
        end;
    end;

    local u18 = false;

    local function releaseState() -- Line: 166
        -- upvalues: u18 (ref), u13 (copy)
        if u18 then
            return;
        end;

        u18 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    local function cleanup() -- Line: 174
        -- upvalues: u16 (ref), u18 (ref), u13 (copy), u17 (copy)
        if u16 then
            u16:Destroy();
            u16 = nil;
        end;

        if not u18 then
            u18 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        if u13.Character then
            u13.Character:SetAttribute("Parry", false);
        end;

        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);
    end;

    u17[#u17 + 1] = v15:GetMarkerReachedSignal("jump"):Connect(function() -- Line: 182
        -- upvalues: u16 (ref), u18 (ref), u13 (copy), u1 (ref)
        if u16 or u18 then
            return;
        end;

        local v19 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if not v19 then
            return;
        end;

        u16 = Instance.new("BodyVelocity");
        u16.Name = "CraneWingLift";
        u16.MaxForce = Vector3.new(100000, 100000, 100000);
        u16.Velocity = Vector3.new(0, u1.LiftSpeed, 0);
        u16.Parent = v19;
        u13:ShakeCamera("SkillLight");
        task.delay(u1.LiftDuration, function() -- Line: 193
            -- upvalues: u16 (ref)
            if u16 and u16.Parent then
                u16.Velocity = Vector3.new(0, 0, 0);
            end;
        end);
    end);

    local function emitVFX(p20) -- Line: 203
        -- upvalues: u13 (copy), u1 (ref)
        if not p20 or p20 == "" then
            return;
        end;

        local v21 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if not v21 then
            return;
        end;

        u13:PlayEffectModule(u1.EffectModule, "Emit", v21.CFrame, p20);
    end;

    u17[#u17 + 1] = v15:GetMarkerReachedSignal("VFX"):Connect(emitVFX);
    u17[#u17 + 1] = v15:GetMarkerReachedSignal("VFX_2"):Connect(emitVFX);
    local u22 = 0;
    u17[#u17 + 1] = v15:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 215
        -- upvalues: u22 (ref), u13 (copy), u1 (ref)
        u22 = u22 + 1;
        u13:PlayCombatSound(u13.ClassData.SwingSoundFolder or "Ninja", nil, u13.ClassData.SwingVolume or u1.SwingVolume);

        if u22 == 1 then
            u13:ShakeCamera("SkillMedium");
            u1._PerformHit(u13, u1.OpenerMultiplier, u1.OpenerHitbox, u1.OpenerRange);

            return;
        end;

        if u22 == 2 and u13.Character then
            u13.Character:SetAttribute("Parry", true);
        end;

        u13:ShakeCamera("Hit");
        u1._PerformHit(u13, u1.TornadoMultiplier, u1.TornadoHitbox, u1.TornadoRange);
    end);
    u17[#u17 + 1] = v15:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v15.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, cleanup);
end;

return u1;