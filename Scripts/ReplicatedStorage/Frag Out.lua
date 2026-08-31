--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Frag Out
  Path:     game.ReplicatedStorage.Classes.Hitman.Skills.Frag Out
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local RigUtil = require(ReplicatedStorage.Modules.RigUtil);
local u1 = {
    Cooldown = 12,
    DamageMultiplier = 6.5,
    AnimationName = "Ability_3",
    Skill_SFX = nil,
    DashSpeed = 70,
    DashDuration = 0.25,
    IFrameDuration = 0.8,
    HitboxSize = Vector3.new(25, 20, 20),
    ExtraGrenades = 2,
    RandomRadius = 15,
    StaggerDelay = 0.2,
    MaxDuration = 4.5
};

function u1._EnsureAnimation(p2) -- Line: 64
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

function u1._PerformGrenadeHit(p7, p8) -- Line: 91
    -- upvalues: u1 (copy), RigUtil (copy)
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { p7.Character };
    local v9 = {};

    for _, v in workspace:GetPartBoundsInBox(CFrame.new(p8), u1.HitboxSize, OverlapParams_new_ret) do
        local v10 = v:FindFirstAncestorOfClass("Model");

        if v10 and (not v9[v10] and RigUtil.IsHittableTarget(v10)) then
            v9[v10] = true;
        end;
    end;

    local v11 = 0;

    for i in v9 do
        if not i:HasTag("Ignore_Damage") and (not i:GetAttribute("Dead") or i:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(i, (p7:ResolveSkillDamage(u1.DamageMultiplier, i)));
            v11 = v11 + 1;
        end;
    end;

    return v11;
end;

function u1.CanActivate(p12) -- Line: 125
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

function u1.Activate(u13, p14) -- Line: 133
    -- upvalues: u1 (copy), ReplicatedStorage (copy), Debris (copy), SharedUtils (copy)
    local v15 = u1._EnsureAnimation(u13);

    if not v15 then
        warn("[Frag Out] Animation not found");

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
    local u16 = {};

    local function spawnGrenade(p17: vector) -- Line: 163
        -- upvalues: ReplicatedStorage (ref), Debris (ref), u16 (copy)
        local v18 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Effects") and ReplicatedStorage.Assets.Effects:FindFirstChild("Grenade");

        if not v18 then
            return;
        end;

        local v19 = v18:Clone();

        if v19:IsA("BasePart") then
            v19.Position = p17;
            v19.Anchored = true;
        elseif v19:IsA("Model") then
            v19:PivotTo(CFrame.new(p17));
        end;

        v19.Parent = workspace;
        Debris:AddItem(v19, 5);
        table.insert(u16, {
            Instance = v19,
            Position = p17
        });
    end;

    local function resolveGrenadePos(p20) -- Line: 184
        local Instance2 = p20.Instance;

        if not (Instance2 and Instance2.Parent) then
            return p20.Position;
        end;

        if Instance2:IsA("BasePart") then
            return Instance2.Position;
        end;

        local v21 = Instance2:IsA("Model") and (Instance2.PrimaryPart or Instance2:FindFirstChildWhichIsA("BasePart"));

        if v21 then
            return v21.Position;
        end;

        return p20.Position;
    end;

    local function detonate(p22) -- Line: 198
        -- upvalues: resolveGrenadePos (copy), SharedUtils (ref), u13 (copy), u1 (ref)
        local Instance2 = p22.Instance;

        if not (Instance2 and Instance2.Parent) then
            return;
        end;

        Instance2:SetAttribute("Fire", true);
        local v23 = resolveGrenadePos(p22);
        local v24 = Instance2:IsA("BasePart") and Instance2 and Instance2 or Instance2:FindFirstChildWhichIsA("BasePart");

        if v24 then
            SharedUtils.PlaySoundAt(v24, "Earth_Hammer", 2);
        end;

        u13:ShakeCamera("SkillMedium");
        u1._PerformGrenadeHit(u13, v23);
    end;

    local u31 = v15:GetMarkerReachedSignal("dash"):Connect(function(p25) -- Line: 218
        -- upvalues: u13 (copy), u1 (ref), Debris (ref), spawnGrenade (copy)
        local v26 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if not v26 then
            return;
        end;

        u13.Player:SetAttribute("iFrame", true);
        u13.Character:SetAttribute("iFrame", true);
        task.delay(u1.IFrameDuration, function() -- Line: 226
            -- upvalues: u13 (ref)
            if u13.Player then
                u13.Player:SetAttribute("iFrame", false);
            end;

            if u13.Character then
                u13.Character:SetAttribute("iFrame", false);
            end;
        end);
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
        local v28 = v26.Position - Vector3.new(0, 3, 0);
        spawnGrenade(v28);

        for i = 1, u1.ExtraGrenades do
            local v29 = (math.random() * 2 - 1) * u1.RandomRadius;
            local v30 = (math.random() * 2 - 1) * u1.RandomRadius;
            spawnGrenade(v28 + Vector3.new(v29, 0, v30));
            local _ = i;
        end;
    end);
    local u33 = v15:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 265
        -- upvalues: u16 (copy), u1 (ref), detonate (copy)
        for i, v in u16 do
            local v32 = (i - 1) * u1.StaggerDelay;

            if v32 <= 0 then
                detonate(v);
            else
                task.delay(v32, function() -- Line: 271
                    -- upvalues: detonate (ref), v (copy)
                    detonate(v);
                end);
            end;
        end;
    end);
    local u34 = false;

    local function releaseState() -- Line: 280
        -- upvalues: u34 (ref), u13 (copy)
        if u34 then
            return;
        end;

        u34 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    local u35 = v15:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v15.Stopped:Once(function() -- Line: 291
        -- upvalues: u34 (ref), u13 (copy), u33 (ref), u31 (ref), u35 (copy)
        if not u34 then
            u34 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        if u33 then
            u33:Disconnect();
        end;

        if u31 then
            u31:Disconnect();
        end;

        if u35 then
            u35:Disconnect();
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 299
        -- upvalues: u34 (ref), u13 (copy), u33 (ref), u31 (ref), u35 (copy)
        if not u34 then
            u34 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        if u33 then
            u33:Disconnect();
        end;

        if u31 then
            u31:Disconnect();
        end;

        if u35 then
            u35:Disconnect();
        end;
    end);
end;

return u1;