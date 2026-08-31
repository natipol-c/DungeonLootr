--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Moonfall
  Path:     game.ReplicatedStorage.Classes.Artemis.Skills.Moonfall
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local RigUtil = require(ReplicatedStorage.Modules.RigUtil);
local u1 = {
    Cooldown = 12,
    DamageMultiplier = 0.42,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    RainDuration = 3,
    TickInterval = 0.25,
    HitboxSize = Vector3.new(28, 20, 28),
    ForwardDistance = 15,
    EffectName = "Arrow_Rain",
    FadeDelay = 3,
    MaxDuration = 3
};

function u1._EnsureAnimation(p2) -- Line: 58
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

function u1._ResolveGroundPos(p7, p8) -- Line: 86
    -- upvalues: u1 (copy)
    local LookVector = p8.CFrame.LookVector;
    local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

    if Vector3_new_ret.Magnitude > 0 then
        LookVector = Vector3_new_ret.Unit or LookVector;
    end;

    local v9 = p8.Position + LookVector * u1.ForwardDistance;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { p7.Character };
    local v10 = workspace:Raycast(v9 + Vector3.new(0, 12, 0), Vector3.new(0, -250, 0), RaycastParams_new_ret);

    if v10 then
        return v10.Position;
    end;

    return Vector3.new(v9.X, p8.Position.Y - 3, v9.Z);
end;

function u1._SpawnEffect(p11) -- Line: 106
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    local v12 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Effects") and ReplicatedStorage.Assets.Effects:FindFirstChild(u1.EffectName);

    if not v12 then
        return nil;
    end;

    local v13 = v12:Clone();
    v13:PivotTo(CFrame.new(p11));
    v13.Parent = workspace;
    v13:SetAttribute("FX_Activate", true);

    return v13;
end;

local function runRain(p14, p15, p16) -- Line: 122
    -- upvalues: u1 (copy), RigUtil (copy), Debris (copy)
    local CFrame_new_ret = CFrame.new(p15 + Vector3.new(0, u1.HitboxSize.Y / 2, 0));
    local math_floor_ret = math.floor(u1.RainDuration / u1.TickInterval);

    for i = 1, math_floor_ret do
        if not (p14.Character and (p14.Character.Parent and (p14.Player and p14.Player.Parent))) then
            break;
        end;

        local OverlapParams_new_ret = OverlapParams.new();
        OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        OverlapParams_new_ret.FilterDescendantsInstances = { p14.Character };
        local v17 = {};

        for _, v in workspace:GetPartBoundsInBox(CFrame_new_ret, u1.HitboxSize, OverlapParams_new_ret) do
            local v18 = v:FindFirstAncestorOfClass("Model");

            if v18 and (not v17[v18] and RigUtil.IsHittableTarget(v18)) then
                v17[v18] = true;
            end;
        end;

        for i2 in v17 do
            if not i2:HasTag("Ignore_Damage") and (not i2:GetAttribute("Dead") or i2:GetAttribute("Can_Finish")) then
                p14:ApplyDamage(i2, (p14:ResolveSkillDamage(u1.DamageMultiplier, i2)));
            end;
        end;

        if i < math_floor_ret then
            task.wait(u1.TickInterval);
        end;
    end;

    if p16 and p16.Parent then
        p16:SetAttribute("FX_Activate", false);
        Debris:AddItem(p16, u1.FadeDelay);
    end;
end;

function u1.CanActivate(p19) -- Line: 168
    if p19.Is_Attacking then
        return false, "Attacking";
    end;

    if p19.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p19.Is_Dodging then
        return false, "Dodging";
    end;

    if p19.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u20, p21) -- Line: 176
    -- upvalues: u1 (copy), runRain (copy)
    local v22 = u1._EnsureAnimation(u20);

    if not v22 then
        warn("[Moonfall] Animation not found");

        return;
    end;

    local Character = u20.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u20.Is_Using_Skill = true;
    u20.Is_Attacking = true;

    for i, v in u20.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v22:Play(0, 1, 1);
    local u27 = v22:GetMarkerReachedSignal("hit"):Connect(function(p23) -- Line: 203
        -- upvalues: u20 (copy), u1 (ref), runRain (ref)
        local v24 = u20.Character and u20.Character:FindFirstChild("HumanoidRootPart");

        if not v24 then
            return;
        end;

        u20:PlayCombatSound(u1.Skill_SFX or (u20.ClassData.SwingSoundFolder or "Bow_Shot2"), nil, u20.ClassData.SwingVolume or 0.5);
        u20:ShakeCamera("SkillLight");
        local v25 = u1._ResolveGroundPos(u20, v24);
        local v26 = u1._SpawnEffect(v25);
        task.spawn(runRain, u20, v25, v26);
    end);
    v22.Stopped:Once(function() -- Line: 221
        -- upvalues: u27 (ref), u20 (copy)
        if u27 then
            u27:Disconnect();
        end;

        u20.Is_Using_Skill = false;
        u20.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 229
        -- upvalues: u20 (copy), u27 (ref)
        if u20.Is_Using_Skill then
            u20.Is_Using_Skill = false;
            u20.Is_Attacking = false;
        end;

        if u27 then
            u27:Disconnect();
        end;
    end);
end;

return u1;