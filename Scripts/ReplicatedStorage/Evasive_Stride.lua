--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Evasive_Stride
  Path:     game.ReplicatedStorage.Classes.Shadow Vagrant.Mastery_Passives.Evasive_Stride
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:49 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v4 = {
    Name = "Evasive_Stride",
    Trigger = "OnSwing",
    Cooldown = 0,
    Level = 13,

    Init = function(p1) -- Line: 37, Name: Init
        if not p1.MasteryPassives.OnDodge then
            p1.MasteryPassives.OnDodge = {};
        end;

        table.insert(p1.MasteryPassives.OnDodge, {
            Name = "Evasive_Stride_Flag",
            Cooldown = 0,

            Execute = function(p2, p3) -- Line: 44, Name: Execute
                p2._evasiveStrideReady = tick();
            end
        });
    end
};

local function _EnsureAnimation(p5) -- Line: 50
    -- upvalues: ReplicatedStorage (copy)
    if p5.Animations.EvasiveStride_Passive then
        return p5.Animations.EvasiveStride_Passive;
    end;

    local v6 = ReplicatedStorage.Classes:FindFirstChild(p5.ClassName);

    if not v6 then
        return nil;
    end;

    local Skill_Animations = v6:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local Passive = Skill_Animations:FindFirstChild("Passive");

    if not Passive then
        return nil;
    end;

    local v7 = p5.Humanoid and p5.Humanoid:FindFirstChildOfClass("Animator");

    if not v7 then
        return nil;
    end;

    local v8 = v7:LoadAnimation(Passive);
    v8.Priority = Enum.AnimationPriority.Action3;
    v8:Play(0, 0, 0);
    v8:Stop(0);
    p5.Animations.EvasiveStride_Passive = v8;

    return v8;
end;

local function _PerformHit(p9) -- Line: 76
    local HitboxSize = p9.ClassData.HitboxSize;
    local Range = p9.ClassData.Range;
    p9.ClassData.HitboxSize = Vector3.new(20, 20, 25);
    p9.ClassData.Range = 25;
    local v10 = p9:Hitbox();
    p9.ClassData.HitboxSize = HitboxSize;
    p9.ClassData.Range = Range;
    local v11 = 0;

    for _, v in v10 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p9:ApplyDamage(v, (p9:ResolveSkillDamage(0.8, v)));
            v11 = v11 + 1;
        end;
    end;

    return v11;
end;

function v4.Execute(u12, p13) -- Line: 100
    -- upvalues: _EnsureAnimation (copy), _PerformHit (copy)
    local _evasiveStrideReady = u12._evasiveStrideReady;

    if not _evasiveStrideReady then
        return;
    end;

    if tick() - _evasiveStrideReady > 3 then
        u12._evasiveStrideReady = nil;

        return;
    end;

    u12._evasiveStrideReady = nil;

    if u12.Is_Using_Skill then
        return;
    end;

    local v14 = _EnsureAnimation(u12);

    if not v14 then
        return;
    end;

    local Character = u12.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local u15 = u12.ClassData.SwingSoundFolder or "Ninja";
    local u16 = u12.ClassData.SwingVolume or 1;
    u12.Is_Using_Skill = true;
    u12.Is_Attacking = true;

    for i, v in u12.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v14:Play(0, 1, 1);
    local u17 = {};

    local function disconnectAll() -- Line: 141
        -- upvalues: u17 (copy)
        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);
    end;

    local u18 = false;

    local function releaseState() -- Line: 148
        -- upvalues: u18 (ref), u12 (copy)
        if u18 then
            return;
        end;

        u18 = true;
        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;
    end;

    u17[#u17 + 1] = v14:GetMarkerReachedSignal("hit"):Connect(function(p19) -- Line: 157
        -- upvalues: u12 (copy), u15 (copy), u16 (copy), _PerformHit (ref)
        if p19 == "" or not p19 then
            p19 = nil;
        end;

        u12:PlayTurnFX(p19);
        u12:PlayCombatSound(u15, nil, u16);
        _PerformHit(u12);
    end);
    v14.Stopped:Once(function() -- Line: 164
        -- upvalues: u18 (ref), u12 (copy), u17 (copy)
        if not u18 then
            u18 = true;
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);
    end);
    task.delay(2, function() -- Line: 170
        -- upvalues: u18 (ref), u12 (copy), u17 (copy)
        if not u18 then
            u18 = true;
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);
    end);
end;

return v4;