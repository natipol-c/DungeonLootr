--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Twin_Bolt
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Artemis.Twin_Bolt
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
    HitboxSize = Vector3.new(22, 15, 28),
    HitboxRange = 28
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._SpawnClones(u3, p4) -- Line: 46
    -- upvalues: u2 (copy)
    if not u2 then
        return;
    end;

    local u5 = p4.CloneCount or 2;
    local u6 = p4.CloneInterval or 0.04;
    local u7 = p4.CloneFadeDuration or 0.6;
    local u8 = p4.CloneColor or Color3.fromRGB(180, 220, 255);
    task.spawn(function() -- Line: 54
        -- upvalues: u5 (copy), u3 (copy), u2 (ref), u7 (copy), u8 (copy), u6 (copy)
        for i = 1, u5 do
            if not u3.Is_Using_Skill then
                break;
            end;

            u2:FireAllClients(nil, {
                Action = "Clone",
                FadeDuration = u7,
                Color = u8,
                NPCModel = u3.Character
            });
            local v9;

            if i < u5 then
                task.wait(u6);
                v9 = i;
            else
                v9 = i;
            end;
        end;
    end);
end;

function u1._PerformHit(p10, p11) -- Line: 73
    -- upvalues: u1 (copy)
    local v12 = p10:QueryHitbox(p11.HitboxSize or u1.HitboxSize, p11.HitboxRange or u1.HitboxRange);
    local v13 = p10:ResolveSkillDamage(p11.DamageMultiplier);

    for _, v in v12 do
        p10:ApplyDamage(v.Character, v13);
    end;
end;

function u1.Activate(u14, u15) -- Line: 88
    -- upvalues: u1 (copy), Debris (copy)
    local v16 = u14.Animations[u1.AnimationName];

    if not v16 then
        warn("[Boss Twin_Bolt] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u14.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u14.Is_Using_Skill = true;
    u14.Is_Attacking = true;
    local u17 = false;
    v16:Play(0, 1, u15.AnimSpeed or 1);
    local u18 = 0;
    local u19 = u15.DashSpeeds or { 60, 70 };
    local u20 = u15.DashDuration or 0.15;
    local v26 = v16:GetMarkerReachedSignal("hit"):Connect(function(p21) -- Line: 114
        -- upvalues: u18 (ref), u14 (copy), u1 (ref), u15 (copy), u19 (copy), Debris (ref), u20 (copy)
        u18 = u18 + 1;
        local v22 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

        if not v22 then
            return;
        end;

        local v23 = u14.FX and u14.FX.Ability_1;

        if v23 then
            v23:SetAttribute("Fire", not v23:GetAttribute("Fire"));
        end;

        u1._SpawnClones(u14, u15);
        local v24 = u19[u18] or u19[#u19];
        local v25 = v22.CFrame.RightVector * (math.random() < 0.5 and -1 or 1);
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v25 * v24;
        BodyVelocity.Parent = v22;
        Debris:AddItem(BodyVelocity, u20);
        u14:PlayCombatSound(u15.SwingSoundFolder or u14.ClassData.SwingSoundFolder or "Bow_Shot", nil, u14.ClassData.SwingVolume or 0.8);
        u1._PerformHit(u14, u15);
    end);
    v16.Stopped:Once(function() -- Line: 150
        -- upvalues: u17 (ref)
        u17 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 155
        -- upvalues: u17 (ref)
        u17 = true;
    end);

    while not u17 do
        task.wait();
    end;

    if v26 then
        v26:Disconnect();
    end;

    u14.Is_Using_Skill = false;
    u14.Is_Attacking = false;
end;

return u1;