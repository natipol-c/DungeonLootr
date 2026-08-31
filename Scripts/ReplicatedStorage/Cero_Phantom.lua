--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cero_Phantom
  Path:     game.ReplicatedStorage.Classes.Coyote.Skill_Modules.Cero_Phantom
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local u1 = nil;
local u2 = {
    CFrame.new(
        -0.0000610351562,
        1.97058201,
        -21.1873856,
        0.999999523,
        -1.49009537e-7,
        8.38190317e-9,
        -1.49009537e-7,
        1.00000012,
        -2.02355466e-9,
        8.38190317e-9,
        -2.02355466e-9,
        0.999998927
    ),
    CFrame.new(
        5.75680542,
        1.97058201,
        -5.0271759,
        -0.707105458,
        1.06796371e-7,
        -0.70710361,
        -1.49009537e-7,
        1.00000012,
        -2.02355466e-9,
        0.707105339,
        -1.03934632e-7,
        -0.707103729
    ),
    CFrame.new(
        -2.24276733,
        1.9478569,
        -2.78242493,
        -0.736855686,
        1.08430555e-7,
        0.676047921,
        -1.49009537e-7,
        1.00000012,
        -2.02355466e-9,
        -0.676048577,
        1.02228796e-7,
        -0.736854911
    ),
    CFrame.new(
        -0.170959473,
        1.25013351,
        -21.9357529,
        0.999999523,
        -1.49009537e-7,
        8.38190317e-9,
        -1.49009537e-7,
        1.00000012,
        -2.02355466e-9,
        8.38190317e-9,
        -2.02355466e-9,
        0.999998927
    )
};
local u3 = { CFrame.new(0, 0, 0), CFrame.new(
        -7.61830139,
        1.20281553,
        -20.3497314,
        -0.0828077868,
        0.789804757,
        0.607742786,
        -0.875879109,
        0.233218968,
        -0.422427177,
        -0.475372136,
        -0.567289472,
        0.672461152
    ), CFrame.new(
        10.7416382,
        0.59601903,
        -17.6540909,
        -0.450177252,
        -0.880752563,
        -0.147021711,
        -0.844016314,
        0.473456562,
        -0.251943231,
        0.291508019,
        0.0106696086,
        -0.956508875
    ) };
local u4 = { 0.317, 0.6, 0.867, 1.417 };
local u5 = { 0.467, 0.8, 1.1 };

local function Cero(p6, p7) -- Line: 32
    -- upvalues: u1 (ref), TweenService (copy)
    local v8 = script.ShotRelease:Clone();
    v8.CFrame = p7 * CFrame.new(0, 0, -1);
    v8.Parent = workspace.Effects[p6.Name];
    u1.Effects:FireOnce(v8);
    local u9 = script.starrk_m1_cero:Clone();
    u9:PivotTo(p7);
    local Size = u9.Beam.Size;
    local Size2 = u9.Cero.Size;

    for _, child in ipairs(u9:GetChildren()) do
        child.Size = Vector3.new(0, 0, 0);
    end;

    u9.Parent = workspace.Effects[p6.Name];
    local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out, 0, false);
    TweenService:Create(u9.Beam, TweenInfo_new_ret, {
        Size = Size
    }):Play();
    TweenService:Create(u9.Cero, TweenInfo_new_ret, {
        Size = Size2
    }):Play();
    task.delay(0.1, function() -- Line: 56
        -- upvalues: TweenService (ref), u9 (ref), Size (copy), Size2 (copy)
        local TweenInfo_new_ret2 = TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false);
        TweenService:Create(u9.Beam, TweenInfo_new_ret2, {
            Size = Size + Vector3.new(1, 1, 1)
        }):Play();
        TweenService:Create(u9.Cero, TweenInfo_new_ret2, {
            Size = Size2 + Vector3.new(1, 1, 1)
        }):Play();
    end);
    task.delay(0.15, function() -- Line: 62
        -- upvalues: TweenService (ref), u9 (ref), Size (copy), Size2 (copy)
        local TweenInfo_new_ret2 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false);
        TweenService:Create(u9.Beam, TweenInfo_new_ret2, {
            Transparency = 1,
            Size = Vector3.new(0, 0, Size.Z + 1)
        }):Play();
        TweenService:Create(u9.Cero, TweenInfo_new_ret2, {
            Transparency = 1,
            Size = Vector3.new(0, 0, Size2.Z + 1)
        }):Play();
        task.wait(TweenInfo_new_ret2.Time);
        u9:Destroy();
        u9 = nil;
    end);
    task.spawn(function() -- Line: 73
        -- upvalues: u9 (ref)
        while true do
            task.wait(0.016666666666666666);

            if not u9 then
                break;
            end;

            u9.PrimaryPart.CFrame = u9.PrimaryPart.CFrame * CFrame.fromEulerAnglesXYZ(0, 0, 1);
        end;
    end);
    local v10 = script.CeroParticles:Clone();
    v10.Size = Size2 + Vector3.new(2, 2, 0);
    v10.CFrame = u9.PrimaryPart.CFrame;
    v10.Parent = workspace.Effects[p6.Name];
    u1.Effects:FireOnce(v10);

    if not p6.HumanoidRootPart:FindFirstChild("SFX_Cero_Phantom") then
        local v11 = game.SoundService.SFX.A_New.Cero_Phantom:Clone();
        v11.Name = "SFX_Cero_Phantom";
        v11.Parent = p6.HumanoidRootPart;
    end;

    p6.HumanoidRootPart.SFX_Cero_Phantom:Play();
end;

local function DoFlashstep(p12, p13) -- Line: 98
    -- upvalues: u1 (ref)
    u1.EffectsList.StarrkFlashstep.Flash(p12, p13);
    local v14 = script["GroundAir emit on each tp"]:Clone();
    v14.CFrame = p13;
    v14.Parent = workspace.Effects[p12.Name];
    u1.Effects:FireOnce(v14);
end;

local u30 = {
    init = function(p15) -- Line: 113, Name: init
        -- upvalues: u1 (ref)
        u1 = p15;
    end,

    Hit = function(p16) -- Line: 117, Name: Hit
    end,

    Begin = function(p17, p18) -- Line: 122, Name: Begin
        -- upvalues: u1 (ref)
        local v19 = script.Windup:Clone();
        v19.CFrame = p18;
        v19.Parent = workspace.Effects[p17.Name];
        u1.Effects:FireOnce(v19);
    end,

    Shot = function(p20, p21, p22) -- Line: 131, Name: Shot
        -- upvalues: u2 (copy), Cero (copy), u1 (ref)
        local v23 = u2[p22 or 1];

        if not v23 then
            return;
        end;

        Cero(p20, p21 * u1.Util.ScaleCFrame(v23));
    end,

    Flashstep = function(p24, p25, p26) -- Line: 138, Name: Flashstep
        -- upvalues: u3 (copy), u1 (ref)
        local v27 = u3[p26 or 1];

        if not v27 then
            return;
        end;

        local v28 = p25 * u1.Util.ScaleCFrame(v27);
        u1.EffectsList.StarrkFlashstep.Flash(p24, v28);
        local v29 = script["GroundAir emit on each tp"]:Clone();
        v29.CFrame = v28;
        v29.Parent = workspace.Effects[p24.Name];
        u1.Effects:FireOnce(v29);
    end
};

function u30.Windup(p31, p32) -- Line: 146
    -- upvalues: u30 (copy), u4 (copy), u5 (copy)
    u30.Begin(p31, p32);

    for i, v in ipairs(u4) do
        task.delay(v, u30.Shot, p31, p32, i);
    end;

    for i, v in ipairs(u5) do
        task.delay(v, u30.Flashstep, p31, p32, i);
    end;
end;

return u30;