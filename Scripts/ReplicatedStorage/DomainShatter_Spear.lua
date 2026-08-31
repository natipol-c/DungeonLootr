--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DomainShatter_Spear
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Unrestricted EX.DomainShatter_Spear
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Special_Ability_3",
    EffectModule = "Domain_Shatter",
    Mode = "Spear",
    MaxDuration = 3.6,
    TickMultiplier = 0.35,
    TickInterval = 0.1,
    HitboxSize = Vector3.new(42, 42, 42),
    HitboxRange = 0
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
    local v12 = p9:ResolveSkillDamage(p10.TickMultiplier or u1.TickMultiplier);

    for _, v in v11 do
        p9:ApplyDamage(v.Character, v12);
    end;
end;

function u1.Activate(u13, u14) -- Line: 64
    -- upvalues: u1 (copy), forwardVFX (copy), RunService (copy), SharedUtils (copy)
    local v15 = u13.Animations[u14._animKey or u1.AnimationName];

    if not v15 then
        warn("[Boss DomainShatter_Spear] Animation not found:", u14._animKey or u1.AnimationName);

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
    local u19 = 0;
    local u20 = u14.TickInterval or u1.TickInterval;

    local function stopTicks() -- Line: 84
        -- upvalues: u18 (ref)
        if u18 then
            u18:Disconnect();
            u18 = nil;
        end;
    end;

    v15:Play(0, 1, u14.AnimSpeed or 1);
    forwardVFX(u13, v15, v17);
    local MarkerReachedSignal = v15:GetMarkerReachedSignal("Start");
    table.insert(v17, MarkerReachedSignal:Connect(function() -- Line: 91
        -- upvalues: u19 (ref), u18 (ref), RunService (ref), u20 (copy), u13 (copy), u14 (copy), u1 (ref)
        u19 = 0;
        u18 = RunService.Heartbeat:Connect(function(p21) -- Line: 93
            -- upvalues: u19 (ref), u20 (ref), u13 (ref), u14 (ref), u1 (ref)
            u19 = u19 + p21;

            while u20 <= u19 do
                u19 = u19 - u20;
                u13:PlayCombatSound(u14.SwingSoundFolder or (u13.ClassData.SwingSoundFolder or "Hard_Slash"), nil, (u13.ClassData.SwingVolume or 1) * 0.8);
                u1._PerformHit(u13, u14);
            end;
        end);
    end));
    local MarkerReachedSignal2 = v15:GetMarkerReachedSignal("End");
    table.insert(v17, MarkerReachedSignal2:Connect(function() -- Line: 102
        -- upvalues: u18 (ref), u13 (copy), SharedUtils (ref)
        if u18 then
            u18:Disconnect();
            u18 = nil;
        end;

        local v22 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v22 then
            SharedUtils.PlaySoundAt(v22, "claw_slam_01", 1);
        end;
    end));

    local function finish() -- Line: 108
        -- upvalues: u16 (ref)
        u16 = true;
    end;

    local MarkerReachedSignal3 = v15:GetMarkerReachedSignal("DBreset");
    table.insert(v17, MarkerReachedSignal3:Connect(finish));
    v15.Stopped:Once(finish);
    task.delay(u14.MaxDuration or u1.MaxDuration, finish);

    while not u16 do
        task.wait();
    end;

    if u18 then
        u18:Disconnect();
        u18 = nil;
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