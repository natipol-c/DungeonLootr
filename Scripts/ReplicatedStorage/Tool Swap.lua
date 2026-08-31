--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Tool Swap
  Path:     game.ReplicatedStorage.Classes.Unrestricted.Skills.Tool Swap
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = {
    Cooldown = 5,
    AnimationName = "Ability_4",
    EffectModule = "Tool_Swap",
    HitMultiplier = 1.5,
    HitboxSize = Vector3.new(20, 18, 26),
    HitboxRange = 24,
    DashSpeed = 60,
    DashDuration = 0.18,
    ParryDuration = 0.4,
    MaxDuration = 1.5
};

local function _EnsureAnimation(p2, p3) -- Line: 34
    -- upvalues: ReplicatedStorage (copy)
    local v4 = p2.Animations[p3];

    if v4 then
        return v4;
    end;

    local v5 = p2.Humanoid and p2.Humanoid:FindFirstChild("Animator");

    if not v5 then
        return nil;
    end;

    local Skill_Animations = ReplicatedStorage.Classes[p2.ClassName]:FindFirstChild("Skill_Animations");

    if Skill_Animations then
        Skill_Animations = Skill_Animations:FindFirstChild(p3);
    end;

    if not Skill_Animations then
        return nil;
    end;

    local v6 = v5:LoadAnimation(Skill_Animations);
    v6.Priority = Enum.AnimationPriority.Action3;
    v6:Play(0, 0, 0);
    v6:Stop(0);
    p2.Animations[p3] = v6;

    return v6;
end;

local function _PerformHit(p7) -- Line: 50
    -- upvalues: u1 (copy)
    local ClassData = p7.ClassData;
    local HitboxSize = ClassData.HitboxSize;
    local Range = ClassData.Range;
    local HitboxRange = u1.HitboxRange;
    ClassData.HitboxSize = u1.HitboxSize;
    ClassData.Range = HitboxRange;
    local v8 = p7:Hitbox();
    ClassData.HitboxSize = HitboxSize;
    ClassData.Range = Range;

    for _, v in ipairs(v8) do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.HitMultiplier, v)));
        end;
    end;
end;

function u1.CanActivate(p9) -- Line: 64
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

function u1.Activate(u10, p11) -- Line: 72
    -- upvalues: _EnsureAnimation (copy), u1 (copy), Debris (copy), _PerformHit (copy)
    local Character = u10.Character;
    local v12;

    if Character then
        v12 = Character:FindFirstChild("HumanoidRootPart");
    else
        v12 = Character;
    end;

    if not v12 then
        return;
    end;

    local v13 = _EnsureAnimation(u10, u1.AnimationName);

    if not v13 then
        return;
    end;

    u10.Is_Using_Skill = true;
    u10.Is_Attacking = true;

    for i, v in pairs(u10.Animations) do
        if type(i) == "string" and (i:match("^Attack_") and v.IsPlaying) then
            v:Stop();
        end;
    end;

    Character:SetAttribute("Parry", true);
    task.delay(u1.ParryDuration, function() -- Line: 92
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    local Humanoid = u10.Humanoid;
    local v14 = Humanoid and (Humanoid.MoveDirection.Magnitude > 0 and Humanoid.MoveDirection.Unit) or v12.CFrame.LookVector;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "ToolSwapDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v14 * u1.DashSpeed;
    BodyVelocity.Parent = v12;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
    v13:Play();
    local u15 = {};
    local u16 = false;

    local function cleanup() -- Line: 112
        -- upvalues: u15 (copy), u10 (copy)
        for _, v in pairs(u15) do
            if v.Connected then
                v:Disconnect();
            end;
        end;

        table.clear(u15);
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;
    end;

    u15.vfx = v13:GetMarkerReachedSignal("VFX"):Connect(function(p17) -- Line: 122
        -- upvalues: u16 (ref), u10 (copy), Character (copy), u1 (ref)
        if not p17 or p17 == "" then
            return;
        end;

        if p17 == "weaponswitch" and not u16 then
            u16 = true;

            if u10.ClassData.ToggleWeaponMode then
                u10.ClassData.ToggleWeaponMode(u10);
            end;

            u10:ShakeCamera("SkillMedium");
        end;

        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            u10:PlayEffectModule(u1.EffectModule, "Emit", HumanoidRootPart.CFrame, p17);
        end;
    end);
    u15.hit = v13:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 138
        -- upvalues: u10 (copy), _PerformHit (ref)
        u10:PlayCombatSound(u10.ClassData.SwingSoundFolder or "Hard_Slash", nil, 1);
        _PerformHit(u10);
        u10:ShakeCamera("Hit");
    end);
    u15.reset = v13:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v13.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, function() -- Line: 147
        -- upvalues: u10 (copy), cleanup (copy)
        if u10.Is_Using_Skill then
            cleanup();
        end;
    end);
end;

return u1;