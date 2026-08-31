--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Lunar_Eclipse
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Awakened Devil EX.Lunar_Eclipse
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {};

local function freezeHRP(p2) -- Line: 41
    local v3 = p2.Character and p2.Character:FindFirstChild("HumanoidRootPart");

    if v3 then
        v3.Anchored = true;
    end;
end;

local function unfreezeHRP(p4) -- Line: 45
    local v5 = p4.Character and p4.Character:FindFirstChild("HumanoidRootPart");

    if v5 then
        v5.Anchored = false;
    end;
end;

u1.AnimationName = "Ability_Ultimate";
u1.EffectModule = "Lunar_Eclipse";
u1.MaxDuration = 6;
u1.JudgementMultiplier = 4;
u1.SheatheMultiplier = 12;
u1.HitboxSize = Vector3.new(38, 24, 68);
u1.HitboxRange = 0;

function u1._PerformHit(p6, p7, p8) -- Line: 58
    -- upvalues: u1 (copy)
    local v9 = p6:QueryHitbox(p7.HitboxSize or u1.HitboxSize, p7.HitboxRange or u1.HitboxRange, 0);
    local v10 = p6:ResolveSkillDamage(p8);

    for _, v in v9 do
        p6:ApplyDamage(v.Character, v10);
    end;
end;

function u1.Activate(u11, u12) -- Line: 68
    -- upvalues: u1 (copy), SharedUtils (copy)
    local u13 = u11.Animations[u1.AnimationName];

    if not u13 then
        warn("[Boss Lunar_Eclipse] Animation not found:", u1.AnimationName);

        return;
    end;

    local v14 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

    if not v14 then
        return;
    end;

    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;
    local v15 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

    if v15 then
        v15.Anchored = true;
    end;

    local u16 = false;
    u13:Play(0, 1, u12.AnimSpeed or 1);
    local u17 = {};

    local function bindVFX(p18) -- Line: 89
        -- upvalues: u17 (copy), u13 (copy), u11 (copy), u1 (ref)
        u17[#u17 + 1] = u13:GetMarkerReachedSignal(p18):Connect(function(p19) -- Line: 90
            -- upvalues: u11 (ref), u1 (ref)
            if not p19 or p19 == "" then
                return;
            end;

            local v20 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

            if not v20 then
                return;
            end;

            u11:PlayEffectModule(u1.EffectModule, "Emit", v20.CFrame, p19);
        end);
    end;

    u17[#u17 + 1] = u13:GetMarkerReachedSignal("VFX"):Connect(function(p21) -- Line: 90
        -- upvalues: u11 (copy), u1 (ref)
        if not p21 or p21 == "" then
            return;
        end;

        local v22 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v22 then
            return;
        end;

        u11:PlayEffectModule(u1.EffectModule, "Emit", v22.CFrame, p21);
    end);
    u17[#u17 + 1] = u13:GetMarkerReachedSignal("VFX_2"):Connect(function(p23) -- Line: 90
        -- upvalues: u11 (copy), u1 (ref)
        if not p23 or p23 == "" then
            return;
        end;

        local v24 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v24 then
            return;
        end;

        u11:PlayEffectModule(u1.EffectModule, "Emit", v24.CFrame, p23);
    end);
    local u25 = 0;
    u17[#u17 + 1] = u13:GetMarkerReachedSignal("Flicker"):Connect(function() -- Line: 101
        -- upvalues: u25 (ref), u11 (copy), SharedUtils (ref)
        u25 = u25 + 1;

        if u25 == 2 then
            local v26 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

            if v26 then
                SharedUtils.PlaySoundAt(v26, "Sonido", 1);
            end;
        end;
    end);
    u17[#u17 + 1] = u13:GetMarkerReachedSignal("Judgement_Start"):Connect(function() -- Line: 110
        -- upvalues: u11 (copy), SharedUtils (ref), u1 (ref), u12 (copy)
        local v27 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v27 then
            SharedUtils.PlaySoundAt(v27, "claw3", 1);
        end;

        u1._PerformHit(u11, u12, u12.JudgementMultiplier or u1.JudgementMultiplier);
    end);
    u17[#u17 + 1] = u13:GetMarkerReachedSignal("Sheathe"):Connect(function() -- Line: 118
        -- upvalues: u11 (copy), SharedUtils (ref), u1 (ref), u12 (copy)
        local v28 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v28 then
            SharedUtils.PlaySoundAt(v28, "Sheathe_1", 1);
            SharedUtils.PlaySoundAt(v28, "claw_combo", 1);
        end;

        u1._PerformHit(u11, u12, u12.SheatheMultiplier or u1.SheatheMultiplier);
    end);
    u13.Stopped:Once(function() -- Line: 128
        -- upvalues: u16 (ref)
        u16 = true;
    end);
    task.delay(u12.MaxDuration or u1.MaxDuration, function() -- Line: 129
        -- upvalues: u16 (ref)
        u16 = true;
    end);

    while not u16 do
        task.wait();
    end;

    local v29 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

    if v29 then
        v29.Anchored = false;
    end;

    for _, v in u17 do
        v:Disconnect();
    end;

    u11.Is_Using_Skill = false;
    u11.Is_Attacking = false;
end;

return u1;