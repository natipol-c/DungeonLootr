--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CameraShake
  Path:     game.ReplicatedStorage.Modules.CameraShake
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {};
u1.__index = u1;
local u2 = nil;
local u3 = nil;

local function GetSettingsController() -- Line: 29
    -- upvalues: u2 (ref), u3 (ref), ReplicatedStorage (copy)
    if u2 then
        return u2;
    end;

    if not u3 then
        local success, result = pcall(function() -- Line: 34
            -- upvalues: ReplicatedStorage (ref)
            return require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"));
        end);

        if not success then
            return nil;
        end;

        u3 = result;
    end;

    local success, result = pcall(function() -- Line: 45
        -- upvalues: u3 (ref)
        return u3.GetController("SettingsController");
    end);

    if success then
        u2 = result;
    end;

    return u2;
end;

local function ShouldReduceMotion() -- Line: 55
    -- upvalues: GetSettingsController (copy)
    local v4 = GetSettingsController();

    if v4 then
        return v4:ShouldReduceMotion();
    end;

    return false;
end;

local function ApplyMotionReduction(p5: table) -- Line: 62
    -- upvalues: GetSettingsController (copy)
    local v6 = GetSettingsController();
    local v7;

    if v6 then
        v7 = v6:ShouldReduceMotion();
    else
        v7 = false;
    end;

    if not v7 then
        return p5;
    end;

    local table_clone_ret = table.clone(p5);
    table_clone_ret.Intensity = p5.Intensity * 0.25;
    table_clone_ret.RotationIntensity = (p5.RotationIntensity or 0) * 0.1;
    table_clone_ret.Duration = p5.Duration * 0.7;

    return table_clone_ret;
end;

local u8 = {};
local u9 = {
    Hit = 0.15,
    CriticalHit = 0.2,
    Bump = 0.1,
    SkillLight = 0.04,
    SkillMedium = 0.1,
    SkillHeavy = 0.15,
    Parry = 0.1
};
u1.Presets = {
    Bump = {
        Intensity = 0.1,
        Duration = 0.15,
        Frequency = 25,
        RotationIntensity = 0.5
    },
    Hit = {
        Intensity = 0.1,
        Duration = 0.25,
        Frequency = 30,
        RotationIntensity = 1.5
    },
    CriticalHit = {
        Intensity = 0.15,
        Duration = 0.18,
        Frequency = 30,
        RotationIntensity = 1
    },
    SkillLight = {
        Intensity = 0.6,
        Duration = 0.2,
        Frequency = 20,
        RotationIntensity = 2,
        FadeOut = 0.25
    },
    SkillMedium = {
        Intensity = 0.7,
        Duration = 0.5,
        Frequency = 17,
        RotationIntensity = 3,
        FadeOut = 0.27
    },
    SkillHeavy = {
        Intensity = 0.82,
        Duration = 0.65,
        Frequency = 14,
        RotationIntensity = 3.5,
        FadeIn = 0.03,
        FadeOut = 0.32
    },
    Parry = {
        Intensity = 0.7,
        Duration = 0.5,
        Frequency = 17,
        RotationIntensity = 3,
        FadeOut = 0.27
    },
    ExplosionSmall = {
        Intensity = 0.5,
        Duration = 0.4,
        Frequency = 25,
        RotationIntensity = 2,
        FadeOut = 0.2
    },
    ExplosionMedium = {
        Intensity = 1,
        Duration = 0.6,
        Frequency = 20,
        RotationIntensity = 4,
        FadeOut = 0.3
    },
    ExplosionLarge = {
        Intensity = 2,
        Duration = 1,
        Frequency = 15,
        RotationIntensity = 6,
        FadeIn = 0.05,
        FadeOut = 0.5
    },
    Earthquake = {
        Intensity = 0.8,
        Duration = 3,
        Frequency = 12,
        RotationIntensity = 2,
        FadeIn = 0.5,
        FadeOut = 1
    },
    Rumble = {
        Intensity = 0.15,
        Duration = 2,
        Frequency = 20,
        RotationIntensity = 0.5,
        FadeIn = 0.3,
        FadeOut = 0.5
    },
    GroundSlam = {
        Intensity = 1.5,
        Duration = 0.8,
        Frequency = 18,
        RotationIntensity = 5,
        FadeOut = 0.4
    },
    Error = {
        Intensity = 0.05,
        Duration = 0.1,
        Frequency = 40,
        RotationIntensity = 0
    }
};
local u10 = {};
local u11 = nil;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u12 = 0;
local u13 = math.random() * 1000;
local u14 = math.random() * 1000;
local u15 = math.random() * 1000;

local function generateId() -- Line: 243
    -- upvalues: u12 (ref)
    u12 = u12 + 1;

    return "shake_" .. u12;
end;

local function lerp(p16: number, p17: number, p18: number) -- Line: 248
    return p16 + (p17 - p16) * p18;
end;

local function calculateFadeMultiplier(p19: table, p20: number) -- Line: 252
    local v21 = p19.FadeIn or 0;
    local v22 = p19.FadeOut or 0;

    if v21 > 0 and p20 < v21 then
        return p20 / v21;
    end;

    local v23 = p19.Duration - v22;

    return (v22 <= 0 or v23 >= p20) and 1 or 1 - (p20 - v23) / v22;
end;

local function updateShakes() -- Line: 271
    -- upvalues: u10 (copy), u13 (copy), u14 (copy), u15 (copy), u11 (ref), RunService (copy)
    local v24 = tick();
    local v25 = {};
    local v26 = Vector3.new(0, 0, 0);

    for i, v in u10 do
        local v27 = v24 - v.startTime;
        local config = v.config;

        if config.Duration <= v27 then
            table.insert(v25, i);
        else
            local v28 = config.FadeIn or 0;
            local v29 = config.FadeOut or 0;
            local Duration = config.Duration;
            local v30;

            if v28 > 0 and v27 < v28 then
                v30 = v27 / v28;
            else
                local v31 = Duration - v29;
                v30 = (v29 <= 0 or v31 >= v27) and 1 or 1 - (v27 - v31) / v29;
            end;

            local v32 = config.Intensity * v30;
            local v33 = (config.RotationIntensity or 0) * v30 * 0.15;
            local v34 = v27 * config.Frequency;
            local math_noise_ret = math.noise(v34, u13);
            local math_noise_ret2 = math.noise(v34, u14);
            local math_noise_ret3 = math.noise(v34, u15);
            v26 = v26 + Vector3.new(math_noise_ret * (v32 + v33 * 0.5), math_noise_ret2 * (v32 + v33), math_noise_ret3 * v32 * 0.5);
        end;
    end;

    for _, v in v25 do
        u10[v] = nil;
    end;

    if not next(u10) then
        if u11 then
            RunService:UnbindFromRenderStep("CameraShake");
            u11 = nil;
        end;

        return;
    end;

    local workspace_CurrentCamera2 = workspace.CurrentCamera;

    if workspace_CurrentCamera2 then
        workspace_CurrentCamera2.CFrame = workspace_CurrentCamera2.CFrame * CFrame.new(v26);
    end;
end;

local u35 = Enum.RenderPriority.Camera.Value + 2;

local function ensureShakeLoop() -- Line: 332
    -- upvalues: u11 (ref), RunService (copy), u35 (copy), updateShakes (copy)
    if not u11 then
        RunService:BindToRenderStep("CameraShake", u35, updateShakes);
        u11 = true;
    end;
end;

function u1.Shake(p36: string) -- Line: 343
    -- upvalues: u1 (copy), u9 (copy), u8 (copy)
    local v37 = u1.Presets[p36];

    if not v37 then
        warn("CameraShake: Unknown preset \'" .. p36 .. "\'");

        return nil;
    end;

    local v38 = tick();

    if (u9[p36] or 0.05) > v38 - (u8[p36] or 0) then
        return nil;
    end;

    u8[p36] = v38;

    return u1.ShakeCustom(v37);
end;

function u1.ShakeCustom(p39: table) -- Line: 364
    -- upvalues: u12 (ref), GetSettingsController (copy), u10 (copy), u11 (ref), RunService (copy), u35 (copy), updateShakes (copy)
    u12 = u12 + 1;
    local v40 = "shake_" .. u12;
    local v41 = GetSettingsController();
    local v42;

    if v41 then
        v42 = v41:ShouldReduceMotion();
    else
        v42 = false;
    end;

    local v43;

    if v42 then
        v43 = table.clone(p39);
        v43.Intensity = p39.Intensity * 0.25;
        v43.RotationIntensity = (p39.RotationIntensity or 0) * 0.1;
        v43.Duration = p39.Duration * 0.7;
    else
        v43 = p39;
    end;

    u10[v40] = {
        config = v43,
        startTime = tick(),
        id = v40
    };

    if not u11 then
        RunService:BindToRenderStep("CameraShake", u35, updateShakes);
        u11 = true;
    end;

    return v40;
end;

function u1.ShakeCustomForced(p44: table) -- Line: 382
    -- upvalues: u12 (ref), u10 (copy), u11 (ref), RunService (copy), u35 (copy), updateShakes (copy)
    u12 = u12 + 1;
    local v45 = "shake_" .. u12;
    u10[v45] = {
        config = p44,
        startTime = tick(),
        id = v45
    };

    if not u11 then
        RunService:BindToRenderStep("CameraShake", u35, updateShakes);
        u11 = true;
    end;

    return v45;
end;

function u1.ShakeOnce(p46: number, p47: number, p48: number?) -- Line: 397
    -- upvalues: u1 (copy)
    return u1.ShakeCustom({
        Intensity = p46,
        Duration = p47,
        Frequency = p48 or 25,
        RotationIntensity = p46 * 5,
        FadeOut = p47 * 0.3
    });
end;

function u1.ShakeSustained(p49: table) -- Line: 408
    -- upvalues: u1 (copy)
    local table_clone_ret = table.clone(p49);
    table_clone_ret.Duration = 9999;
    table_clone_ret.FadeIn = p49.FadeIn or 0.3;

    return u1.ShakeCustom(table_clone_ret);
end;

function u1.Stop(p50: string, p51: number?) -- Line: 417
    -- upvalues: u10 (copy)
    local v52 = u10[p50];

    if not v52 then
        return;
    end;

    if not p51 or p51 <= 0 then
        u10[p50] = nil;

        return;
    end;

    local v53 = tick() - v52.startTime;
    v52.config = table.clone(v52.config);
    v52.config.Duration = v53 + p51;
    v52.config.FadeOut = p51;
end;

function u1.StopAll(p54: number?) -- Line: 433
    -- upvalues: u10 (copy), u1 (copy), u11 (ref), RunService (copy)
    if p54 and p54 > 0 then
        for i in u10 do
            u1.Stop(i, p54);
        end;

        return;
    end;

    table.clear(u10);

    if u11 then
        RunService:UnbindFromRenderStep("CameraShake");
        u11 = nil;
    end;
end;

function u1.AddPreset(p55: string, p56: table) -- Line: 448
    -- upvalues: u1 (copy)
    u1.Presets[p55] = p56;
end;

function u1.ShakeFromPosition(p57: vector, p58: number, p59: table) -- Line: 453
    -- upvalues: workspace_CurrentCamera (ref), u1 (copy)
    workspace_CurrentCamera = workspace_CurrentCamera or workspace.CurrentCamera;

    if workspace_CurrentCamera then
        local Magnitude = (workspace_CurrentCamera.CFrame.Position - p57).Magnitude;

        if p58 < Magnitude then
            return nil;
        end;

        local v60 = 1 - Magnitude / p58;
        local v61 = v60 * v60;
        local table_clone_ret = table.clone(p59);
        table_clone_ret.Intensity = p59.Intensity * v61;
        table_clone_ret.RotationIntensity = (p59.RotationIntensity or 0) * v61;

        return u1.ShakeCustom(table_clone_ret);
    end;
end;

function u1.ExplosionAt(p62: vector, p63: string?, p64: number?) -- Line: 474
    -- upvalues: u1 (copy)
    return u1.ShakeFromPosition(p62, p64 or 100, u1.Presets["Explosion" .. (p63 or "Medium")] or u1.Presets.ExplosionMedium);
end;

function u1.IsMotionReduced() -- Line: 485
    -- upvalues: ShouldReduceMotion (copy)
    return ShouldReduceMotion();
end;

return u1;