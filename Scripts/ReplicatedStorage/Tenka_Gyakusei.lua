--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Tenka_Gyakusei
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Master Ronin.Tenka_Gyakusei
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = {
    AnimationName = "Ability_1",
    MaxDuration = 2.5,
    HitboxSize = Vector3.new(16, 12, 20),
    HitboxRange = 20
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._SpawnClone(p3, p4) -- Line: 46
    -- upvalues: u2 (copy)
    if not u2 then
        return;
    end;

    u2:FireAllClients(nil, {
        Action = "Clone",
        FadeDuration = p4.CloneFadeDuration or 0.5,
        Color = p4.CloneColor or Color3.fromRGB(255, 215, 0),
        NPCModel = p3.Character
    });
end;

function u1._PerformHit(p5, p6) -- Line: 61
    -- upvalues: u1 (copy)
    local v7 = p5:QueryHitbox(p6.HitboxSize or u1.HitboxSize, p6.HitboxRange or u1.HitboxRange);
    local v8 = p5:ResolveSkillDamage(p6.DamageMultiplier);

    for _, v in v7 do
        p5:ApplyDamage(v.Character, v8);
    end;
end;

function u1.Activate(u9, u10) -- Line: 76
    -- upvalues: u1 (copy), Debris (copy)
    local v11 = u9.Animations[u1.AnimationName];

    if not v11 then
        warn("[Boss Tenka_Gyakusei] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u9.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u9.Is_Using_Skill = true;
    u9.Is_Attacking = true;
    local u12 = false;
    v11:Play(0, 1, u10.AnimSpeed or 1);
    local u13 = u10.DashSpeed or 55;
    local u14 = u10.DashDuration or 0.15;
    local v18 = v11:GetMarkerReachedSignal("hit"):Connect(function(p15) -- Line: 101
        -- upvalues: u9 (copy), u10 (copy), u13 (copy), Debris (ref), u14 (copy), u1 (ref)
        local v16 = u9.Character and u9.Character:FindFirstChild("HumanoidRootPart");

        if not v16 then
            return;
        end;

        u9:PlayCombatSound(u10.SwingSoundFolder or (u9.ClassData.SwingSoundFolder or "Magic_Swings"), nil, u9.ClassData.SwingVolume or 1);

        if p15 == "" or not p15 then
            p15 = nil;
        end;

        u9:PlayTurnFX(p15);
        local v17 = v16.CFrame.RightVector * (math.random() < 0.5 and -1 or 1);
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v17 * u13;
        BodyVelocity.Parent = v16;
        Debris:AddItem(BodyVelocity, u14);
        u1._SpawnClone(u9, u10);
        u1._PerformHit(u9, u10);
    end);
    v11.Stopped:Once(function() -- Line: 132
        -- upvalues: u12 (ref)
        u12 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 137
        -- upvalues: u12 (ref)
        u12 = true;
    end);

    while not u12 do
        task.wait();
    end;

    if v18 then
        v18:Disconnect();
    end;

    u9.Is_Using_Skill = false;
    u9.Is_Attacking = false;
end;

return u1;