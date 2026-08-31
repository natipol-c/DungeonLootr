--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ruin Eruption
  Path:     game.ReplicatedStorage.Classes.Oathbreaker.Skills.Ruin Eruption
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:49 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local RigUtil = require(ReplicatedStorage.Modules.RigUtil);
local u1 = {
    Cooldown = 15,
    DamageMultiplier = 2.5,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    DashSpeed = 75,
    DashDuration = 0.2,
    HitboxSize = Vector3.new(20, 20, 20),
    MaxDuration = 3
};

function u1._EnsureAnimation(p2) -- Line: 51
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

function u1._SpawnAndDetonateGrenade(p7, p8) -- Line: 78
    -- upvalues: ReplicatedStorage (copy), Debris (copy), SharedUtils (copy), u1 (copy), RigUtil (copy)
    local v9 = p7.Character and p7.Character:FindFirstChild("HumanoidRootPart");

    if not v9 then
        return;
    end;

    local v10 = p7.ClassData.SwingVolume or 1;
    local v11 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Effects") and ReplicatedStorage.Assets.Effects:FindFirstChild("Grenade");
    local v12 = v9.Position - Vector3.new(0, 3, 0);

    if v11 then
        local u13 = v11:Clone();

        if u13:IsA("BasePart") then
            u13.Position = v12;
            u13.Anchored = true;
        elseif u13:IsA("Model") then
            u13:PivotTo(CFrame.new(v12));
        end;

        u13.Parent = workspace;
        task.delay(0.025, function() -- Line: 100
            -- upvalues: u13 (copy)
            u13:SetAttribute("Fire", true);
        end);
        Debris:AddItem(u13, 5);
        local v14 = u13:IsA("BasePart") and u13 and u13 or u13:FindFirstChildWhichIsA("BasePart");

        if v14 then
            SharedUtils.PlaySoundAt(v14, p8, v10);
        end;
    else
        SharedUtils.PlaySoundAt(v9, p8, v10);
    end;

    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { p7.Character };
    local v15 = {};

    for _, v in workspace:GetPartBoundsInBox(CFrame.new(v12), u1.HitboxSize, OverlapParams_new_ret) do
        local v16 = v:FindFirstAncestorOfClass("Model");

        if v16 and (not v15[v16] and RigUtil.IsHittableTarget(v16)) then
            v15[v16] = true;
        end;
    end;

    for i in v15 do
        if not i:HasTag("Ignore_Damage") and (not i:GetAttribute("Dead") or i:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(i, (p7:ResolveSkillDamage(u1.DamageMultiplier, i)));
        end;
    end;
end;

function u1.CanActivate(p17) -- Line: 149
    if p17.Is_Attacking then
        return false, "Attacking";
    end;

    if p17.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p17.Is_Dodging then
        return false, "Dodging";
    end;

    if p17.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u18, p19) -- Line: 157
    -- upvalues: u1 (copy), SharedUtils (copy), Debris (copy)
    local v20 = u1._EnsureAnimation(u18);

    if not v20 then
        warn("[Ruin Eruption] Animation not found");

        return;
    end;

    local Character = u18.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local u21 = u18.ClassData.SwingVolume or 1;
    u18.Is_Using_Skill = true;
    u18.Is_Attacking = true;

    for i, v in u18.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v20:Play(0, 1, 1);
    local u22 = 0;
    local u24 = v20:GetMarkerReachedSignal("hit"):Connect(function(p23) -- Line: 187
        -- upvalues: u22 (ref), u1 (ref), u18 (copy)
        u22 = u22 + 1;

        if u22 == 1 then
            u1._SpawnAndDetonateGrenade(u18, "Earth_Hammer");
        else
            task.delay(0.025, function() -- Line: 195
                -- upvalues: u1 (ref), u18 (ref)
                u1._SpawnAndDetonateGrenade(u18, "Earth_Hammer_2");
            end);
        end;

        if p23 == "" or not p23 then
            p23 = nil;
        end;

        u18:PlayTurnFX(p23);
        u18:ShakeCamera("SkillMedium");
    end);
    local u28 = v20:GetMarkerReachedSignal("dash"):Connect(function(p25) -- Line: 207
        -- upvalues: u18 (copy), SharedUtils (ref), u21 (copy), u1 (ref), Debris (ref)
        local v26 = u18.Character and u18.Character:FindFirstChild("HumanoidRootPart");

        if not v26 then
            return;
        end;

        SharedUtils.PlaySoundAt(v26, "Tiger_Roar", u21);
        local v27;

        if p25 == "Back" then
            v27 = -v26.CFrame.LookVector;
        else
            v27 = v26.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v27 * u1.DashSpeed;
        BodyVelocity.Parent = v26;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
    end);
    v20.Stopped:Once(function() -- Line: 228
        -- upvalues: u24 (ref), u28 (ref), u18 (copy)
        if u24 then
            u24:Disconnect();
        end;

        if u28 then
            u28:Disconnect();
        end;

        u18.Is_Using_Skill = false;
        u18.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 237
        -- upvalues: u18 (copy), u24 (ref), u28 (ref)
        if u18.Is_Using_Skill then
            u18.Is_Using_Skill = false;
            u18.Is_Attacking = false;
        end;

        if u24 then
            u24:Disconnect();
        end;

        if u28 then
            u28:Disconnect();
        end;
    end);
end;

return u1;