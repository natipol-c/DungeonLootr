--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     24-Frame Onslaught
  Path:     game.ReplicatedStorage.Classes.Framebreaker.Skills.24-Frame Onslaught
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Debris");
local u1 = {
    Cooldown = 10,
    DamageMultiplier = 1,
    AnimationName = "Ability_4",
    HitboxSize = Vector3.new(20, 10, 25),
    HitboxRange = 25,
    CloneCount = 3,
    CloneInterval = 0.04,
    CloneFadeDuration = 0.8,
    CloneColor = Color3.fromRGB(0, 200, 180),
    CloneSpread = 5,
    MaxDuration = 2.5
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._EnsureAnimation(p3) -- Line: 45
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

function u1._PerformHit(p8) -- Line: 71
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

local function RandomOffset(p11) -- Line: 96
    local v12 = (math.random() * 2 - 1) * p11;
    local v13 = (math.random() * 2 - 1) * p11;

    return Vector3.new(v12, 0, v13);
end;

function u1._SpawnClones(u14) -- Line: 105
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    task.spawn(function() -- Line: 108
        -- upvalues: u1 (ref), u14 (copy), u2 (ref)
        for i = 1, u1.CloneCount do
            if not u14.Is_Using_Skill then
                break;
            end;

            local Player = u14.Player;
            local v15 = {
                Action = "Clone",
                FadeDuration = u1.CloneFadeDuration,
                Color = u1.CloneColor
            };
            local CloneSpread = u1.CloneSpread;
            local v16 = (math.random() * 2 - 1) * CloneSpread;
            local v17 = (math.random() * 2 - 1) * CloneSpread;
            v15.Offset = Vector3.new(v16, 0, v17);
            u2:FireAllClients(Player, v15);
            local v18;

            if i < u1.CloneCount then
                task.wait(u1.CloneInterval);
                v18 = i;
            else
                v18 = i;
            end;
        end;
    end);
end;

function u1.CanActivate(p19) -- Line: 128
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

function u1.Activate(u20, p21) -- Line: 136
    -- upvalues: u1 (copy)
    local v22 = u1._EnsureAnimation(u20);

    if not v22 then
        warn("[24-Frame Onslaught] Animation not found");

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
    local u24 = v22:GetMarkerReachedSignal("hit"):Connect(function(p23) -- Line: 163
        -- upvalues: u20 (copy), u1 (ref)
        u20:PlayCombatSound(u20.ClassData.SwingSoundFolder or "Flame_Swing", nil, u20.ClassData.SwingVolume or 0.5);

        if p23 == "" or not p23 then
            p23 = nil;
        end;

        u20:PlayTurnFX(p23);
        u20:ShakeCamera("Hit");
        u1._PerformHit(u20);
        u1._SpawnClones(u20);
    end);
    local u25 = false;

    local function releaseState() -- Line: 176
        -- upvalues: u25 (ref), u20 (copy)
        if u25 then
            return;
        end;

        u25 = true;
        u20.Is_Using_Skill = false;
        u20.Is_Attacking = false;
    end;

    local u26 = v22:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v22.Stopped:Once(function() -- Line: 187
        -- upvalues: u25 (ref), u20 (copy), u24 (ref), u26 (copy)
        if not u25 then
            u25 = true;
            u20.Is_Using_Skill = false;
            u20.Is_Attacking = false;
        end;

        if u24 then
            u24:Disconnect();
        end;

        if u26 then
            u26:Disconnect();
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 193
        -- upvalues: u25 (ref), u20 (copy), u24 (ref), u26 (copy)
        if not u25 then
            u25 = true;
            u20.Is_Using_Skill = false;
            u20.Is_Attacking = false;
        end;

        if u24 then
            u24:Disconnect();
        end;

        if u26 then
            u26:Disconnect();
        end;
    end);
end;

return u1;