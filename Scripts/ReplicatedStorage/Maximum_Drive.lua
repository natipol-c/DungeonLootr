--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Maximum_Drive
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Dark Rider.Maximum_Drive
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:34 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_2",
    MaxDuration = 3,
    HitboxSize = Vector3.new(10, 14, 20),
    HitboxRange = 20
};

function u1._PerformHit(p2, p3) -- Line: 29
    -- upvalues: u1 (copy)
    local HitboxSize = p2.ClassData.HitboxSize;
    local Range = p2.ClassData.Range;
    p2.ClassData.HitboxSize = p3.HitboxSize or u1.HitboxSize;
    p2.ClassData.Range = p3.HitboxRange or u1.HitboxRange;
    local v4 = p2:QueryHitbox();
    p2.ClassData.HitboxSize = HitboxSize;
    p2.ClassData.Range = Range;
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 48
    -- upvalues: u1 (copy), Debris (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Maximum_Drive] Animation not found:", u1.AnimationName);

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
    local v13 = v8:GetMarkerReachedSignal("dash"):Connect(function(p10) -- Line: 68
        -- upvalues: u6 (copy), u7 (copy), Debris (ref)
        local v11 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v11 then
            return;
        end;

        local v12;

        if p10 == "Back" then
            v12 = -v11.CFrame.LookVector;
        else
            v12 = v11.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v12 * (u7.DashSpeed or 70);
        BodyVelocity.Parent = v11;
        Debris:AddItem(BodyVelocity, u7.DashDuration or 0.2);
    end);
    local v15 = v8:GetMarkerReachedSignal("hit"):Connect(function(p14) -- Line: 86
        -- upvalues: u7 (copy), u6 (copy), u1 (ref)
        u6:PlayCombatSound(u7.SwingSoundFolder or (u6.ClassData.SwingSoundFolder or "Gun_Shots"), nil, u6.ClassData.SwingVolume or 1);

        if p14 == "" or not p14 then
            p14 = nil;
        end;

        u6:PlayTurnFX(p14);
        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 95
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 99
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v15 then
        v15:Disconnect();
    end;

    if v13 then
        v13:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;