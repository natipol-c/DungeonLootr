--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Mikazuki
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Master Ronin.Mikazuki
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_2",
    MaxDuration = 2.5,
    HitboxSize = Vector3.new(18, 12, 24),
    HitboxRange = 24,
    OpeningSFX = "anime_explosion"
};

function u1._PerformHit(p2, p3) -- Line: 45
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 60
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Mikazuki] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u6.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u6.Is_Using_Skill = true;
    u6.Is_Attacking = true;
    local u9 = false;
    v8:Play(0, 1, u7.AnimSpeed or 1);
    local LookVector = Character.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "BossMikazuki_ForwardDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = Unit * (u7.DashSpeed or 65);
    BodyVelocity.Parent = Character;
    Debris:AddItem(BodyVelocity, u7.DashDuration or 0.18);
    local u10 = 0;
    local v13 = v8:GetMarkerReachedSignal("hit"):Connect(function(p11) -- Line: 94
        -- upvalues: u10 (ref), u6 (copy), u7 (copy), SharedUtils (ref), u1 (ref)
        u10 = u10 + 1;
        local v12 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v12 then
            return;
        end;

        u6:PlayCombatSound(u7.SwingSoundFolder or (u6.ClassData.SwingSoundFolder or "Magic_Swings"), nil, u6.ClassData.SwingVolume or 1);

        if p11 == "" or not p11 then
            p11 = nil;
        end;

        u6:PlayTurnFX(p11);

        if u10 == 1 then
            SharedUtils.PlaySoundAt(v12, u1.OpeningSFX, 1);
        end;

        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 117
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 122
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v13 then
        v13:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;