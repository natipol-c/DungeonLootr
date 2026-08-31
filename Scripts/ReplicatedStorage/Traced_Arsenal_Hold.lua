--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Traced_Arsenal_Hold
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Broken Reality.Traced_Arsenal_Hold
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");
local u1 = {
    AnimationName = "Ability_1_Hold",
    MaxDuration = 4,
    HitboxSize = Vector3.new(20, 22, 28),
    HitboxRange = 28,
    DashSpeeds = { 30, 32, 35, 30, 32, 38 },
    DashDuration = 0.15
};

function u1._PerformHit(p2, p3) -- Line: 49
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 64
    -- upvalues: u1 (copy), Debris (copy)
    local v8 = u7._animKey or u1.AnimationName;
    local v9 = u6.Animations[v8];

    if not v9 then
        warn("[Boss Traced_Arsenal_Hold] Animation not found:", v8);

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
    local u10 = false;
    v9:Play(0, 1, u7.AnimSpeed or 1);
    local u11 = 0;
    local u12 = u7.DashSpeeds or u1.DashSpeeds;
    local u13 = u7.DashDuration or u1.DashDuration;
    local v17 = v9:GetMarkerReachedSignal("hit"):Connect(function(p14) -- Line: 92
        -- upvalues: u11 (ref), u6 (copy), u12 (copy), Debris (ref), u13 (copy), u7 (copy), u1 (ref)
        u11 = u11 + 1;
        local v15 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v15 then
            return;
        end;

        local v16 = u12[u11] or u12[#u12];
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v15.CFrame.LookVector * v16;
        BodyVelocity.Parent = v15;
        Debris:AddItem(BodyVelocity, u13);
        u6:PlayCombatSound(u7.SwingSoundFolder or (u6.ClassData.SwingSoundFolder or "Magic_Swings"), nil, u6.ClassData.SwingVolume or 1);

        if p14 == "" or not p14 then
            p14 = nil;
        end;

        u6:PlayTurnFX(p14);
        u1._PerformHit(u6, u7);
    end);
    v9.Stopped:Once(function() -- Line: 119
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 124
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v17 then
        v17:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;