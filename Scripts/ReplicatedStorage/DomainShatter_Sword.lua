--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DomainShatter_Sword
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Unrestricted EX.DomainShatter_Sword
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
    AnimationName = "Ability_3",
    EffectModule = "Domain_Shatter",
    Mode = "Sword",
    MaxDuration = 2.4,
    TickMultiplier = 0.55,
    TickInterval = 0.1,
    HitboxSize = Vector3.new(30, 22, 32),
    HitboxRange = 22
};

local function setMode(p2, p3) -- Line: 37
    local Character = p2.Character;

    if Character then
        Character:SetAttribute("M1Mode", p3);
    end;
end;

local function freezeHRP(p4) -- Line: 46
    local v5 = p4.Character and p4.Character:FindFirstChild("HumanoidRootPart");

    if v5 then
        v5.Anchored = true;
    end;
end;

local function unfreezeHRP(p6) -- Line: 50
    local v7 = p6.Character and p6.Character:FindFirstChild("HumanoidRootPart");

    if v7 then
        v7.Anchored = false;
    end;
end;

local function forwardVFX(u8, p9, p10) -- Line: 55
    -- upvalues: u1 (copy)
    local function emit(p11) -- Line: 56
        -- upvalues: u8 (copy), u1 (ref)
        if not p11 or p11 == "" then
            return;
        end;

        local v12 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");

        if v12 then
            u8:PlayEffectModule(u1.EffectModule, "Emit", v12.CFrame, p11);
        end;
    end;

    local MarkerReachedSignal = p9:GetMarkerReachedSignal("VFX");
    table.insert(p10, MarkerReachedSignal:Connect(emit));
    local MarkerReachedSignal2 = p9:GetMarkerReachedSignal("VFX_2");
    table.insert(p10, MarkerReachedSignal2:Connect(emit));
    local MarkerReachedSignal3 = p9:GetMarkerReachedSignal("VFX_3");
    table.insert(p10, MarkerReachedSignal3:Connect(emit));
end;

function u1._PerformHit(p13, p14) -- Line: 66
    -- upvalues: u1 (copy)
    local v15 = p13:QueryHitbox(p14.HitboxSize or u1.HitboxSize, p14.HitboxRange or u1.HitboxRange);
    local v16 = p13:ResolveSkillDamage(p14.TickMultiplier or u1.TickMultiplier);

    for _, v in v15 do
        p13:ApplyDamage(v.Character, v16);
    end;
end;

function u1.Activate(u17, u18) -- Line: 74
    -- upvalues: u1 (copy), forwardVFX (copy), SharedUtils (copy), RunService (copy)
    local v19 = u17.Animations[u18._animKey or u1.AnimationName];

    if not v19 then
        warn("[Boss DomainShatter_Sword] Animation not found:", u18._animKey or u1.AnimationName);

        return;
    end;

    local Character = u17.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u17.Is_Using_Skill = true;
    u17.Is_Attacking = true;
    local Mode = u1.Mode;
    local Character2 = u17.Character;

    if Character2 then
        Character2:SetAttribute("M1Mode", Mode);
    end;

    local v20 = u17.Character and u17.Character:FindFirstChild("HumanoidRootPart");

    if v20 then
        v20.Anchored = true;
    end;

    local u21 = false;
    local v22 = {};
    local u23 = nil;
    local u24 = 0;
    local u25 = u18.TickInterval or u1.TickInterval;

    local function stopTicks() -- Line: 97
        -- upvalues: u23 (ref)
        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;
    end;

    v19:Play(0, 1, u18.AnimSpeed or 1);
    forwardVFX(u17, v19, v22);
    local MarkerReachedSignal = v19:GetMarkerReachedSignal("Start");
    table.insert(v22, MarkerReachedSignal:Connect(function() -- Line: 104
        -- upvalues: u17 (copy), SharedUtils (ref), u24 (ref), u23 (ref), RunService (ref), u25 (copy), u1 (ref), u18 (copy)
        local v26 = u17.Character and u17.Character:FindFirstChild("HumanoidRootPart");

        if v26 then
            SharedUtils.PlaySoundAt(v26, "Sieghart_Spell_15", 1);
            SharedUtils.PlaySoundAt(v26, "claw_combo", 1);
        end;

        u24 = 0;
        u23 = RunService.Heartbeat:Connect(function(p27) -- Line: 111
            -- upvalues: u24 (ref), u25 (ref), u1 (ref), u17 (ref), u18 (ref)
            u24 = u24 + p27;

            while u25 <= u24 do
                u24 = u24 - u25;
                u1._PerformHit(u17, u18);
            end;
        end);
    end));
    local MarkerReachedSignal2 = v19:GetMarkerReachedSignal("End");
    table.insert(v22, MarkerReachedSignal2:Connect(function() -- Line: 119
        -- upvalues: u23 (ref), u17 (copy), SharedUtils (ref)
        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;

        local v28 = u17.Character and u17.Character:FindFirstChild("HumanoidRootPart");

        if v28 then
            SharedUtils.PlaySoundAt(v28, "anime_explode", 1);
        end;
    end));

    local function finish() -- Line: 125
        -- upvalues: u21 (ref)
        u21 = true;
    end;

    local MarkerReachedSignal3 = v19:GetMarkerReachedSignal("DBreset");
    table.insert(v22, MarkerReachedSignal3:Connect(finish));
    v19.Stopped:Once(finish);
    task.delay(u18.MaxDuration or u1.MaxDuration, finish);

    while not u21 do
        task.wait();
    end;

    if u23 then
        u23:Disconnect();
        u23 = nil;
    end;

    local v29 = u17.Character and u17.Character:FindFirstChild("HumanoidRootPart");

    if v29 then
        v29.Anchored = false;
    end;

    for _, v in v22 do
        if v.Connected then
            v:Disconnect();
        end;
    end;

    u17.Is_Using_Skill = false;
    u17.Is_Attacking = false;
end;

return u1;