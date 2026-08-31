--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Fuyubachi
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Zero.Fuyubachi
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = {
    AnimationName = "Ability_3",
    MaxDuration = 2,
    HitboxSize = Vector3.new(24, 12, 26),
    HitboxRange = 22,
    DashSpeed = 40,
    DashDuration = 0.2,
    ParryDuration = 0.5,
    SwingSFXFolder = nil
};

function u1._PerformHit(p2, p3) -- Line: 55
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 70
    -- upvalues: u1 (copy), Debris (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Fuyubachi] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u6.Character;
    local v9;

    if Character then
        v9 = Character:FindFirstChild("HumanoidRootPart");
    else
        v9 = Character;
    end;

    if not v9 then
        return;
    end;

    u6.Is_Using_Skill = true;
    u6.Is_Attacking = true;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "BossSkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = -v9.CFrame.LookVector * (u7.DashSpeed or u1.DashSpeed);
    BodyVelocity.Parent = v9;
    Debris:AddItem(BodyVelocity, u7.DashDuration or u1.DashDuration);
    Character:SetAttribute("Parry", true);
    task.delay(u7.ParryDuration or u1.ParryDuration, function() -- Line: 95
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    v8:Play(0, 1, u7.AnimSpeed or 1);
    local v11 = v8:GetMarkerReachedSignal("hit"):Connect(function(p10) -- Line: 104
        -- upvalues: u7 (copy), u1 (ref), u6 (copy)
        u6:PlayCombatSound(u7.SwingSoundFolder or u1.SwingSFXFolder or (u6.ClassData.SwingSoundFolder or "Sword_Swings"), nil, u6.ClassData.SwingVolume or 0.5);

        if p10 == "" or not p10 then
            p10 = nil;
        end;

        u6:PlayTurnFX(p10);
        u1._PerformHit(u6, u7);
    end);
    local u12 = false;
    local v13 = v8:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 114
        -- upvalues: u12 (ref)
        u12 = true;
    end);
    v8.Stopped:Once(function() -- Line: 117
        -- upvalues: u12 (ref)
        u12 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 120
        -- upvalues: u12 (ref)
        u12 = true;
    end);

    while not u12 do
        task.wait();
    end;

    if v11 then
        v11:Disconnect();
    end;

    if v13 then
        v13:Disconnect();
    end;

    if Character then
        Character:SetAttribute("Parry", false);
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;