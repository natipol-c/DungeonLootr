--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rain_of_Swords_Tap
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Forge Archon.Rain_of_Swords_Tap
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");
local u1 = {
    AnimationName = "Ability_3_Tap",
    MaxDuration = 3,
    HitboxSize = Vector3.new(22, 22, 38),
    HitboxRange = 38
};

function u1._PerformHit(p2, p3) -- Line: 39
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 54
    -- upvalues: u1 (copy), Debris (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Rain_of_Swords_Tap] Animation not found:", u1.AnimationName);

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
    local v13 = v8:GetMarkerReachedSignal("dash"):Connect(function(p10) -- Line: 76
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
        BodyVelocity.Velocity = v12 * (u7.DashSpeed or 65);
        BodyVelocity.Parent = v11;
        Debris:AddItem(BodyVelocity, u7.DashDuration or 0.15);
    end);
    local v15 = v8:GetMarkerReachedSignal("hit"):Connect(function(p14) -- Line: 97
        -- upvalues: u7 (copy), u6 (copy), u1 (ref)
        u6:PlayCombatSound(u7.Skill_SFX or "Bow_Shot3", nil, u6.ClassData.SwingVolume or 1);

        if p14 == "" or not p14 then
            p14 = nil;
        end;

        u6:PlayTurnFX(p14);
        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 110
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 115
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v13 then
        v13:Disconnect();
    end;

    if v15 then
        v15:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;