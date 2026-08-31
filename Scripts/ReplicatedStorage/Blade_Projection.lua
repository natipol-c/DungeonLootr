--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Blade_Projection
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Forge Archon.Blade_Projection
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");
local u7 = {
    AnimationName = "Ability_2",
    MaxDuration = 3,
    SlashHitboxSize = Vector3.new(18, 20, 42),
    SlashHitboxRange = 42,
    FinalHitboxSize = Vector3.new(22, 22, 28),
    FinalHitboxRange = 28,

    _PerformHit = function(p1, p2, p3, p4) -- Line: 47, Name: _PerformHit
        local v5 = p1:QueryHitbox(p3, p4);
        local v6 = p1:ResolveSkillDamage(p2);

        for _, v in v5 do
            p1:ApplyDamage(v.Character, v6);
        end;
    end
};

function u7.Activate(u8, u9) -- Line: 59
    -- upvalues: u7 (copy), Debris (copy)
    local v10 = u8.Animations[u7.AnimationName];

    if not v10 then
        warn("[Boss Blade_Projection] Animation not found:", u7.AnimationName);

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
    local u12 = u9.SlashDamageMult or (u9.DamageMultiplier or 5);
    local u13 = u9.FinalDamageMult or 3;
    local u14 = u9.SlashHitboxSize or u7.SlashHitboxSize;
    local u15 = u9.SlashHitboxRange or u7.SlashHitboxRange;
    local u16 = u9.FinalHitboxSize or u7.FinalHitboxSize;
    local u17 = u9.FinalHitboxRange or u7.FinalHitboxRange;
    local u18 = { "Right_Slash_Projectile", "Left_Slash_Projectile" };
    local v22 = v10:GetMarkerReachedSignal("dash"):Connect(function(p19) -- Line: 96
        -- upvalues: u8 (copy), u9 (copy), Debris (ref)
        local v20 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");

        if not v20 then
            return;
        end;

        u8:PlayCombatSound("Bow_Shot3", nil, u8.ClassData.SwingVolume or 1);
        local v21;

        if p19 == "Back" then
            v21 = -v20.CFrame.LookVector;
        else
            v21 = v20.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v21 * (u9.DashSpeed or 80);
        BodyVelocity.Parent = v20;
        Debris:AddItem(BodyVelocity, u9.DashDuration or 0.1);
    end);
    local u23 = 0;
    local v27 = v10:GetMarkerReachedSignal("hit"):Connect(function(p24) -- Line: 121
        -- upvalues: u23 (ref), u9 (copy), u8 (copy), u18 (copy), u7 (ref), u12 (copy), u14 (copy), u15 (copy), u13 (copy), u16 (copy), u17 (copy)
        u23 = u23 + 1;
        local v25 = u23;
        u8:PlayCombatSound(u9.SwingSoundFolder or (u8.ClassData.SwingSoundFolder or "Magic_Swings"), nil, u8.ClassData.SwingVolume or 1);

        if v25 > 2 then
            if p24 == "" or not p24 then
                p24 = nil;
            end;

            u8:PlayTurnFX(p24);
            u7._PerformHit(u8, u13, u16, u17);

            return;
        end;

        local v26 = u8.FX and u8.FX[u18[v25]];

        if v26 then
            v26:SetAttribute("Fire", not v26:GetAttribute("Fire"));
        end;

        u7._PerformHit(u8, u12, u14, u15);
    end);
    v10.Stopped:Once(function() -- Line: 150
        -- upvalues: u11 (ref)
        u11 = true;
    end);
    task.delay(u7.MaxDuration, function() -- Line: 155
        -- upvalues: u11 (ref)
        u11 = true;
    end);

    while not u11 do
        task.wait();
    end;

    if v22 then
        v22:Disconnect();
    end;

    if v27 then
        v27:Disconnect();
    end;

    u8.Is_Using_Skill = false;
    u8.Is_Attacking = false;
end;

return u7;