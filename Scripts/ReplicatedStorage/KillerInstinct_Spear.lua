--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     KillerInstinct_Spear
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Unrestricted EX.KillerInstinct_Spear
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Special_Ability_2",
    EffectModule = "Killer_Instinct",
    Mode = "Spear",
    MaxDuration = 1.7,
    DamageMultiplier = 7,
    HitboxSize = Vector3.new(28, 24, 32),
    HitboxRange = 26,
    LiftSpeed = 90,
    LiftDuration = 0.1
};

local function setMode(p2, p3) -- Line: 41
    local Character = p2.Character;

    if Character then
        Character:SetAttribute("M1Mode", p3);
    end;
end;

local function forwardVFX(u4, p5, p6) -- Line: 46
    -- upvalues: u1 (copy)
    local function emit(p7) -- Line: 47
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

function u1._PerformHit(p9, p10) -- Line: 57
    -- upvalues: u1 (copy)
    local v11 = p9:QueryHitbox(p10.HitboxSize or u1.HitboxSize, p10.HitboxRange or u1.HitboxRange);
    local v12 = p9:ResolveSkillDamage(p10.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v11 do
        p9:ApplyDamage(v.Character, v12);
    end;
end;

function u1.Activate(u13, u14) -- Line: 65
    -- upvalues: u1 (copy), forwardVFX (copy), SharedUtils (copy)
    local v15 = u13.Animations[u14._animKey or u1.AnimationName];

    if not v15 then
        warn("[Boss KillerInstinct_Spear] Animation not found:", u14._animKey or u1.AnimationName);

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
    local u18 = nil;

    local function killLift() -- Line: 84
        -- upvalues: u18 (ref)
        if u18 and u18.Parent then
            u18:Destroy();
        end;

        u18 = nil;
    end;

    v15:Play(0, 1, u14.AnimSpeed or 1);
    forwardVFX(u13, v15, v17);
    local MarkerReachedSignal = v15:GetMarkerReachedSignal("Jump");
    table.insert(v17, MarkerReachedSignal:Connect(function() -- Line: 92
        -- upvalues: u13 (copy), SharedUtils (ref), u18 (ref), u14 (copy), u1 (ref)
        local v19 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if not v19 then
            return;
        end;

        SharedUtils.PlaySoundAt(v19, "Sonido", 1);

        if u18 and u18.Parent then
            u18:Destroy();
        end;

        u18 = nil;
        u18 = Instance.new("BodyVelocity");
        u18.Name = "KillerInstinctLift";
        u18.MaxForce = Vector3.new(100000, 100000, 100000);
        u18.Velocity = Vector3.new(0, u14.LiftSpeed or u1.LiftSpeed, 0);
        u18.Parent = v19;
        task.delay(u14.LiftDuration or u1.LiftDuration, function() -- Line: 102
            -- upvalues: u18 (ref)
            if u18 and u18.Parent then
                u18.Velocity = Vector3.new(0, 0, 0);
            end;
        end);
    end));
    local MarkerReachedSignal2 = v15:GetMarkerReachedSignal("Warp");
    table.insert(v17, MarkerReachedSignal2:Connect(function() -- Line: 107
        -- upvalues: u13 (copy), SharedUtils (ref), u18 (ref)
        local v20 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if not v20 then
            return;
        end;

        SharedUtils.PlaySoundAt(v20, "Sonido", 1);

        if u18 and u18.Parent then
            u18:Destroy();
        end;

        u18 = nil;
    end));
    local MarkerReachedSignal3 = v15:GetMarkerReachedSignal("hit");
    table.insert(v17, MarkerReachedSignal3:Connect(function() -- Line: 116
        -- upvalues: u13 (copy), Character (copy), SharedUtils (ref), u1 (ref), u14 (copy)
        local v21 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart") or Character;
        SharedUtils.PlaySoundAt(v21, "claw4", 1);
        SharedUtils.PlaySoundAt(v21, "claw_slam_01", 1);
        u1._PerformHit(u13, u14);
    end));

    local function finish() -- Line: 123
        -- upvalues: u16 (ref)
        u16 = true;
    end;

    local MarkerReachedSignal4 = v15:GetMarkerReachedSignal("DBreset");
    table.insert(v17, MarkerReachedSignal4:Connect(finish));
    v15.Stopped:Once(finish);
    task.delay(u14.MaxDuration or u1.MaxDuration, finish);

    while not u16 do
        task.wait();
    end;

    if u18 and u18.Parent then
        u18:Destroy();
    end;

    u18 = nil;

    for _, v in v17 do
        if v.Connected then
            v:Disconnect();
        end;
    end;

    u13.Is_Using_Skill = false;
    u13.Is_Attacking = false;
end;

return u1;