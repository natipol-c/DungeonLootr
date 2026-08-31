--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Slash Storm
  Path:     game.ReplicatedStorage.Classes.Hitman.Skills.Slash Storm
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
local u1 = {};
local u2 = { "HardHit_1", "Revolver_2", "HardHit_1" };
local u3 = { "Right_Slash", "Left_Shot", "Right_Slash" };
u1.Cooldown = 7;
u1.MaxCharges = 2;
u1.AnimationName = "Ability_3";
u1.DamageMultiplier = 1.4;
u1.FinalDamageMultiplier = 2.2;
u1.HitCount = 3;
u1.DashSpeed = 35;
u1.DashDuration = 0.18;
u1.CastSFX = "Sonido";
u1.CastVolume = 0.9;
u1.HitVolume = 1;
u1.HitboxSize = Vector3.new(28, 18, 30);
u1.HitboxRange = 28;
u1.MaxDuration = 2;

function u1._EnsureAnimation(p4) -- Line: 67
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p4.Animations[AnimationName] then
        return p4.Animations[AnimationName];
    end;

    local v5 = ReplicatedStorage.Classes:FindFirstChild(p4.ClassName);

    if not v5 then
        return nil;
    end;

    local Skill_Animations = v5:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v6 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v6 then
        return nil;
    end;

    local v7 = p4.Humanoid and p4.Humanoid:FindFirstChildOfClass("Animator");

    if not v7 then
        return nil;
    end;

    local v8 = v7:LoadAnimation(v6);
    v8.Priority = Enum.AnimationPriority.Action3;
    v8:Play(0, 0, 0);
    v8:Stop(0);
    p4.Animations[AnimationName] = v8;

    return v8;
end;

function u1._PerformHit(p9, p10) -- Line: 93
    -- upvalues: u1 (copy)
    local HitboxSize = p9.ClassData.HitboxSize;
    local Range = p9.ClassData.Range;
    p9.ClassData.HitboxSize = u1.HitboxSize;
    p9.ClassData.Range = u1.HitboxRange;
    local v11 = p9:Hitbox();
    p9.ClassData.HitboxSize = HitboxSize;
    p9.ClassData.Range = Range;

    for _, v in v11 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p9:ApplyDamage(v, (p9:ResolveSkillDamage(p10, v)));
        end;
    end;
end;

function u1._DoDirectionalDash(p12) -- Line: 114
    -- upvalues: u1 (copy), Debris (copy)
    local v13 = p12.Character and p12.Character:FindFirstChild("HumanoidRootPart");

    if not v13 then
        return;
    end;

    local Humanoid = p12.Humanoid;
    local v14 = Humanoid and (Humanoid.MoveDirection.Magnitude > 0 and Humanoid.MoveDirection.Unit) or v13.CFrame.LookVector;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v14 * u1.DashSpeed;
    BodyVelocity.Parent = v13;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
end;

function u1.CanActivate(p15) -- Line: 133
    if p15.Is_Attacking then
        return false, "Attacking";
    end;

    if p15.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p15.Is_Dodging then
        return false, "Dodging";
    end;

    if p15.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u16, p17) -- Line: 141
    -- upvalues: u1 (copy), SharedUtils (copy), u2 (copy), u3 (copy)
    local u18 = u1._EnsureAnimation(u16);

    if not u18 then
        warn("[Slash Storm] Animation not found");

        return;
    end;

    local Character = u16.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u16.Is_Using_Skill = true;
    u16.Is_Attacking = true;

    for i, v in u16.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    SharedUtils.PlaySoundAt(Character, u1.CastSFX, u1.CastVolume);
    u18:Play(0, 1, 1);
    local u19 = {};

    local function disconnectAll() -- Line: 170
        -- upvalues: u19 (copy)
        for _, v in u19 do
            v:Disconnect();
        end;

        table.clear(u19);
    end;

    local u20 = false;

    local function cleanup() -- Line: 176
        -- upvalues: u20 (ref), u16 (copy), u19 (copy)
        if u20 then
            return;
        end;

        u20 = true;
        u16.Is_Using_Skill = false;
        u16.Is_Attacking = false;

        for _, v in u19 do
            v:Disconnect();
        end;

        table.clear(u19);
    end;

    local u21 = 0;
    u19[#u19 + 1] = u18:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 188
        -- upvalues: u21 (ref), u1 (ref), u16 (copy), SharedUtils (ref), u2 (ref), u3 (ref), u18 (copy)
        if u21 >= u1.HitCount then
            return;
        end;

        u21 = u21 + 1;
        local v22 = u21 >= u1.HitCount;
        u1._DoDirectionalDash(u16);
        local v23 = u16.Character and u16.Character:FindFirstChild("HumanoidRootPart");

        if v23 then
            SharedUtils.PlaySoundAt(v23, u2[u21], u1.HitVolume);
        end;

        u16:PlayTurnFX(u3[u21]);
        u16:ShakeCamera(v22 and "SkillHeavy" or "SkillLight");
        u1._PerformHit(u16, v22 and u1.FinalDamageMultiplier or u1.DamageMultiplier);

        if v22 then
            u18:Stop(0.2);
        end;
    end);
    u19[#u19 + 1] = u18:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    u18.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, cleanup);
end;

return u1;