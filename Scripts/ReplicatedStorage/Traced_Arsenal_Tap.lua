--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Traced_Arsenal_Tap
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Forge Archon.Traced_Arsenal_Tap
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");
local u7 = {
    AnimationName = "Ability_1_Tap",
    MaxDuration = 3,
    SwordHitboxSize = Vector3.new(22, 20, 26),
    SwordHitboxRange = 26,
    BowHitboxSize = Vector3.new(16, 20, 36),
    BowHitboxRange = 36,

    _PerformHit = function(p1, p2, p3, p4) -- Line: 45, Name: _PerformHit
        local v5 = p1:QueryHitbox(p3, p4);
        local v6 = p1:ResolveSkillDamage(p2);

        for _, v in v5 do
            p1:ApplyDamage(v.Character, v6);
        end;
    end
};

function u7.Activate(u8, u9) -- Line: 57
    -- upvalues: u7 (copy), Debris (copy)
    local v10 = u8.Animations[u7.AnimationName];

    if not v10 then
        warn("[Boss Traced_Arsenal_Tap] Animation not found:", u7.AnimationName);

        return;
    end;

    local Character = u8.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u8.Is_Using_Skill = true;
    u8.Is_Attacking = true;
    local u11 = false;
    v10:Play(0, 1, u9.AnimSpeed or 1);
    local u12 = u9.SwordDamageMult or (u9.DamageMultiplier or 2.2);
    local u13 = u9.BowDamageMult or (u9.DamageMultiplier or 2.2);
    local u14 = u9.SwordHitboxSize or u7.SwordHitboxSize;
    local u15 = u9.SwordHitboxRange or u7.SwordHitboxRange;
    local u16 = u9.BowHitboxSize or u7.BowHitboxSize;
    local u17 = u9.BowHitboxRange or u7.BowHitboxRange;
    local u18 = u9.DashSpeed or 75;
    local u19 = u9.DashDuration or 0.15;
    local u20 = u9.BowDashSpeeds or { 55, 60, 65 };
    local u21 = u9.BowDashDuration or 0.12;
    local v25 = v10:GetMarkerReachedSignal("dash"):Connect(function(p22) -- Line: 92
        -- upvalues: u8 (copy), u18 (copy), Debris (ref), u19 (copy)
        local v23 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");

        if not v23 then
            return;
        end;

        local v24;

        if p22 == "Back" then
            v24 = -v23.CFrame.LookVector;
        else
            v24 = v23.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v24 * u18;
        BodyVelocity.Parent = v23;
        Debris:AddItem(BodyVelocity, u19);
    end);
    local u26 = 0;
    local v32 = v10:GetMarkerReachedSignal("hit"):Connect(function(p27) -- Line: 114
        -- upvalues: u26 (ref), u8 (copy), u9 (copy), u7 (ref), u12 (copy), u14 (copy), u15 (copy), u20 (copy), Debris (ref), u21 (copy), u13 (copy), u16 (copy), u17 (copy)
        u26 = u26 + 1;
        local v28 = u26;
        local v29 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");

        if not v29 then
            return;
        end;

        if v28 == 1 then
            u8:PlayCombatSound(u9.SwordSFX or "Magic_Swings", nil, u8.ClassData.SwingVolume or 1);

            if p27 == "" or not p27 then
                p27 = nil;
            end;

            u8:PlayTurnFX(p27);
            u7._PerformHit(u8, u12, u14, u15);

            return;
        end;

        local v30 = u20[v28 - 1] or u20[#u20];
        local v31 = v29.CFrame.RightVector * (math.random() < 0.5 and -1 or 1);
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v31 * v30;
        BodyVelocity.Parent = v29;
        Debris:AddItem(BodyVelocity, u21);
        u8:PlayCombatSound(u9.BowSFX or "Bow_Shot3", nil, u8.ClassData.SwingVolume or 1);

        if p27 == "" or not p27 then
            p27 = nil;
        end;

        u8:PlayTurnFX(p27);
        u7._PerformHit(u8, u13, u16, u17);
    end);
    v10.Stopped:Once(function() -- Line: 154
        -- upvalues: u11 (ref)
        u11 = true;
    end);
    task.delay(u7.MaxDuration, function() -- Line: 159
        -- upvalues: u11 (ref)
        u11 = true;
    end);

    while not u11 do
        task.wait();
    end;

    if v25 then
        v25:Disconnect();
    end;

    if v32 then
        v32:Disconnect();
    end;

    u8.Is_Using_Skill = false;
    u8.Is_Attacking = false;
end;

return u7;