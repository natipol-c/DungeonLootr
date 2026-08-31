--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Shimotsuki
  Path:     game.ReplicatedStorage.Classes.Zero.Mastery_Passives.Shimotsuki
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local v4 = {
    Name = "Shimotsuki",
    Trigger = "OnSwing",
    Cooldown = 0,
    Level = 13,

    Init = function(p1) -- Line: 43, Name: Init
        if not p1.MasteryPassives.OnDodge then
            p1.MasteryPassives.OnDodge = {};
        end;

        table.insert(p1.MasteryPassives.OnDodge, {
            Name = "Shimotsuki_Flag",
            Cooldown = 0,

            Execute = function(p2, p3) -- Line: 51, Name: Execute
                p2._shimotsukiReady = tick();
            end
        });
    end
};

local function _EnsureAnimation(p5) -- Line: 57
    -- upvalues: ReplicatedStorage (copy)
    if p5.Animations.Shimotsuki_Ability_4_Passive then
        return p5.Animations.Shimotsuki_Ability_4_Passive;
    end;

    local v6 = ReplicatedStorage.Classes:FindFirstChild(p5.ClassName);

    if not v6 then
        return nil;
    end;

    local Skill_Animations = v6:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local Ability_4_Passive = Skill_Animations:FindFirstChild("Ability_4_Passive");

    if not Ability_4_Passive then
        return nil;
    end;

    local v7 = p5.Humanoid and p5.Humanoid:FindFirstChildOfClass("Animator");

    if not v7 then
        return nil;
    end;

    local v8 = v7:LoadAnimation(Ability_4_Passive);
    v8.Priority = Enum.AnimationPriority.Action3;
    v8:Play(0, 0, 0);
    v8:Stop(0);
    p5.Animations.Shimotsuki_Ability_4_Passive = v8;

    return v8;
end;

local function _PerformHit(p9) -- Line: 83
    local HitboxSize = p9.ClassData.HitboxSize;
    p9.ClassData.HitboxSize = Vector3.new(20, 10, 20);
    local v10 = p9:Hitbox();
    p9.ClassData.HitboxSize = HitboxSize;
    local v11 = 0;

    for _, v in v10 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p9:ApplyDamage(v, (p9:ResolveSkillDamage(1.2, v)));
            v11 = v11 + 1;
        end;
    end;

    return v11;
end;

function v4.Execute(u12, p13) -- Line: 104
    -- upvalues: _EnsureAnimation (copy), Debris (copy), _PerformHit (copy)
    local _shimotsukiReady = u12._shimotsukiReady;

    if not _shimotsukiReady then
        return;
    end;

    if tick() - _shimotsukiReady > 3 then
        u12._shimotsukiReady = nil;

        return;
    end;

    u12._shimotsukiReady = nil;

    if u12.Is_Using_Skill then
        return;
    end;

    local u14 = _EnsureAnimation(u12);

    if not u14 then
        return;
    end;

    local Character = u12.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u12.Is_Using_Skill = true;
    u12.Is_Attacking = true;

    for i, v in u12.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = Character.CFrame.LookVector * 45;
    BodyVelocity.Parent = Character;
    Debris:AddItem(BodyVelocity, 0.2);
    u14:Play(0, 1, 1);
    local u15 = 0;
    local u17 = u14:GetMarkerReachedSignal("hit"):Connect(function(p16) -- Line: 155
        -- upvalues: u15 (ref), u12 (copy), _PerformHit (ref), u14 (copy)
        u15 = u15 + 1;

        if u15 > 3 then
            return;
        end;

        u12:PlayCombatSound(u12.ClassData.SwingSoundFolder or "Sword_Swings", nil, u12.ClassData.SwingVolume or 0.5);

        if p16 == "" or not p16 then
            p16 = nil;
        end;

        u12:PlayTurnFX(p16);
        _PerformHit(u12);

        if u15 == 3 then
            u14:Stop(0.2);
        end;
    end);
    u14.Stopped:Once(function() -- Line: 171
        -- upvalues: u17 (ref), u12 (copy)
        if u17 then
            u17:Disconnect();
        end;

        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;
    end);
    task.delay(2, function() -- Line: 178
        -- upvalues: u12 (copy), u17 (ref)
        if u12.Is_Using_Skill then
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        if u17 then
            u17:Disconnect();
        end;
    end);
end;

return v4;