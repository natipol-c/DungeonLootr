--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     KillerCadence_Spear
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Unrestricted EX.KillerCadence_Spear
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = {
    AnimationName = "Special_Ability_1",
    EffectModule = "Killer_Cadence",
    Mode = "Spear",
    MaxDuration = 2.8,
    DamageMultiplier = 0.9,
    HitboxSize = Vector3.new(36, 24, 36),
    HitboxRange = 0,
    DashSpeed = 40,
    DashDuration = 0.12
};

local function setMode(p2, p3) -- Line: 39
    local Character = p2.Character;

    if Character then
        Character:SetAttribute("M1Mode", p3);
    end;
end;

local function forwardVFX(u4, p5, p6) -- Line: 44
    -- upvalues: u1 (copy)
    local function emit(p7) -- Line: 45
        -- upvalues: u4 (copy), u1 (ref)
        if not p7 or p7 == "" then
            return;
        end;

        local v8 = u4.Character and u4.Character:FindFirstChild("HumanoidRootPart");

        if v8 then
            u4:PlayEffectModule(u1.EffectModule, "Emit", v8.CFrame, p7);
        end;
    end;

    local MarkerReachedSignal = p5:GetMarkerReachedSignal("VFX");
    table.insert(p6, MarkerReachedSignal:Connect(emit));
    local MarkerReachedSignal2 = p5:GetMarkerReachedSignal("VFX_2");
    table.insert(p6, MarkerReachedSignal2:Connect(emit));
    local MarkerReachedSignal3 = p5:GetMarkerReachedSignal("VFX_3");
    table.insert(p6, MarkerReachedSignal3:Connect(emit));
end;

function u1._PerformHit(p9, p10) -- Line: 55
    -- upvalues: u1 (copy)
    local v11 = p9:QueryHitbox(p10.HitboxSize or u1.HitboxSize, p10.HitboxRange or u1.HitboxRange, 0);
    local v12 = p9:ResolveSkillDamage(p10.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v11 do
        p9:ApplyDamage(v.Character, v12);
    end;
end;

function u1.Activate(u13, u14) -- Line: 64
    -- upvalues: u1 (copy), forwardVFX (copy), Debris (copy)
    local v15 = u13.Animations[u14._animKey or u1.AnimationName];

    if not v15 then
        warn("[Boss KillerCadence_Spear] Animation not found:", u14._animKey or u1.AnimationName);

        return;
    end;

    local Character = u13.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;
    local Mode = u1.Mode;
    local Character2 = u13.Character;

    if Character2 then
        Character2:SetAttribute("M1Mode", Mode);
    end;

    local u16 = false;
    local v17 = {};
    local u18 = 0;
    v15:Play(0, 1, u14.AnimSpeed or 1);
    forwardVFX(u13, v15, v17);
    local MarkerReachedSignal = v15:GetMarkerReachedSignal("hit");
    table.insert(v17, MarkerReachedSignal:Connect(function() -- Line: 86
        -- upvalues: u18 (ref), u13 (copy), u14 (copy), u1 (ref), Debris (ref)
        u18 = u18 + 1;
        u13:PlayCombatSound(u14.SwingSoundFolder or (u13.ClassData.SwingSoundFolder or "Hard_Slash"), nil, u13.ClassData.SwingVolume or 1);
        u1._PerformHit(u13, u14);

        if u18 % 2 == 1 then
            local v19 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

            if v19 then
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.Name = "KillerCadenceDash";
                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                BodyVelocity.Velocity = v19.CFrame.LookVector * (u14.DashSpeed or u1.DashSpeed);
                BodyVelocity.Parent = v19;
                Debris:AddItem(BodyVelocity, u14.DashDuration or u1.DashDuration);
            end;
        end;
    end));

    local function finish() -- Line: 105
        -- upvalues: u16 (ref)
        u16 = true;
    end;

    local MarkerReachedSignal2 = v15:GetMarkerReachedSignal("DBreset");
    table.insert(v17, MarkerReachedSignal2:Connect(finish));
    v15.Stopped:Once(finish);
    task.delay(u14.MaxDuration or u1.MaxDuration, finish);

    while not u16 do
        task.wait();
    end;

    for _, v in v17 do
        if v.Connected then
            v:Disconnect();
        end;
    end;

    u13.Is_Using_Skill = false;
    u13.Is_Attacking = false;
end;

return u1;