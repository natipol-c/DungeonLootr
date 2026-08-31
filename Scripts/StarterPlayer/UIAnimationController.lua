--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UIAnimationController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.UIAnimationController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local UIAnimationConfig = require(ReplicatedStorage.GameInfo.UIAnimationConfig);
local Registry = require(script.Parent.Registry);
local Color3_new_ret = Color3.new(1, 1, 1);
local u1 = nil;
local v2 = Knit.CreateController({
    Name = "UIAnimationController"
});

local function isEffectivelyVisible(p3: userdata) -- Line: 87
    while p3 do
        if p3:IsA("GuiObject") then
            if not p3.Visible then
                return false;
            end;
        elseif p3:IsA("LayerCollector") then
            return p3.Enabled;
        end;

        p3 = p3.Parent;
    end;

    return false;
end;

local function gradientSpinEnabled() -- Line: 105
    -- upvalues: Registry (copy)
    local v4 = Registry:Get("PlayerData");

    return not (v4 and (v4.Data and v4.Data.Settings)) and true or v4.Data.Settings.GradientSpinOn ~= false;
end;

local function buildShineSequence(p5: number, p6, p7: number, p8: number) -- Line: 120
    -- upvalues: Color3_new_ret (copy)
    local v9 = { ColorSequenceKeypoint.new(0, p6) };
    local v10 = 0;

    for _, v in {
        { p5 - p8, p6 },
        { p5 - p7, Color3_new_ret },
        { p5 + p7, Color3_new_ret },
        { p5 + p8, p6 }
    } do
        local v11 = v[1];

        if v11 > 0.001 and (v11 < 0.999 and v10 + 0.001 < v11) then
            table.insert(v9, ColorSequenceKeypoint.new(v11, v[2]));
            v10 = v11;
        end;
    end;

    table.insert(v9, ColorSequenceKeypoint.new(1, p6));

    return ColorSequence.new(v9);
end;

function v2.KnitStart(u12) -- Line: 140
    -- upvalues: ReplicatedStorage (copy), u1 (ref), UIAnimationConfig (copy), RunService (copy)
    u12._entries = {};
    local Assets = ReplicatedStorage:WaitForChild("Assets", 10);

    if Assets then
        Assets = Assets:WaitForChild("UI", 10);
    end;

    if Assets then
        Assets = Assets:FindFirstChild("ShineFrame");
    end;

    u1 = Assets;

    if not u1 then
        warn("[UIAnimationController] ReplicatedStorage.Assets.UI.ShineFrame not found -- \'shine_frame\' tags will be skipped.");
    end;

    for i, v in UIAnimationConfig.Tags do
        u12:_bindTag(i, v);
    end;

    RunService.RenderStepped:Connect(function(p13: number) -- Line: 157
        -- upvalues: u12 (copy)
        u12:_step(p13);
    end);
end;

local TweenInfo_new_ret = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

local function resolveHoverStroke(p14: userdata) -- Line: 180
    local Background = p14:FindFirstChild("Background");

    if Background then
        local Stroke = Background:FindFirstChild("Stroke");

        if Stroke and Stroke:IsA("UIStroke") then
            return Stroke;
        end;

        local v15 = Background:FindFirstChildOfClass("UIStroke");

        if v15 then
            return v15;
        end;
    end;

    return p14:FindFirstChildOfClass("UIStroke");
end;

function v2.BindHoverHighlight(p16: table, p17: userdata, p18: any) -- Line: 204
    -- upvalues: resolveHoverStroke (copy), Color3_new_ret (copy), TweenService (copy), TweenInfo_new_ret (copy)
    local v19 = p18 or {};
    local u20 = resolveHoverStroke(p17);

    if not u20 then
        return nil;
    end;

    local u21 = v19.HoverColor or Color3_new_ret;
    local IsLocked = v19.IsLocked;
    local u22 = nil;

    local function tweenTo(p23: boolean) -- Line: 219
        -- upvalues: u22 (ref), u20 (copy), TweenService (ref), TweenInfo_new_ret (ref), u21 (copy)
        if u22 then
            u22:Cancel();
        end;

        local Attribute = u20:GetAttribute("_OrigColor");

        if not Attribute then
            Attribute = u20.Color;
            u20:SetAttribute("_OrigColor", Attribute);
        end;

        local v24 = {};

        if p23 then
            Attribute = u21 or Attribute;
        end;

        v24.Color = Attribute;
        u22 = TweenService:Create(u20, TweenInfo_new_ret, v24);
        u22:Play();
    end;

    local u25 = p17.MouseEnter:Connect(function() -- Line: 234
        -- upvalues: IsLocked (copy), tweenTo (copy)
        if IsLocked and IsLocked() then
            return;
        end;

        tweenTo(true);
    end);
    local u26 = p17.MouseLeave:Connect(function() -- Line: 238
        -- upvalues: IsLocked (copy), tweenTo (copy)
        if IsLocked and IsLocked() then
            return;
        end;

        tweenTo(false);
    end);

    return {
        Disconnect = function() -- Line: 244, Name: Disconnect
            -- upvalues: u25 (copy), u26 (copy), u22 (ref)
            u25:Disconnect();
            u26:Disconnect();

            if u22 then
                u22:Cancel();
                u22 = nil;
            end;
        end
    };
end;

local TweenInfo_new_ret2 = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out);

function v2.BindHoverScale(p27: table, p28: userdata, p29: userdata, p30: any) -- Line: 274
    -- upvalues: TweenInfo_new_ret2 (copy), TweenService (copy)
    local v31 = p30 or {};
    local u32 = v31.ShownScale or 1;
    local u33 = v31.HiddenScale or 0;
    local u34 = v31.TweenInfo or TweenInfo_new_ret2;
    local IsLocked = v31.IsLocked;
    local u35 = p29:FindFirstChildOfClass("UIScale");

    if not u35 then
        u35 = Instance.new("UIScale");
        u35.Name = "_HoverScale";
        u35.Parent = p29;
    end;

    u35.Scale = u33;
    local u36 = nil;

    local function u38(p37: boolean) -- Line: 292
        -- upvalues: u36 (ref), TweenService (ref), u35 (ref), u34 (copy), u32 (copy), u33 (copy)
        if u36 then
            u36:Cancel();
        end;

        u36 = TweenService:Create(u35, u34, {
            Scale = p37 and u32 or u33
        });
        u36:Play();
    end;

    local u39 = p28.MouseEnter:Connect(function() -- Line: 302
        -- upvalues: IsLocked (copy), u38 (copy)
        if IsLocked and IsLocked() then
            return;
        end;

        u38(true);
    end);
    local u40 = p28.MouseLeave:Connect(function() -- Line: 306
        -- upvalues: IsLocked (copy), u36 (ref), TweenService (ref), u35 (ref), u34 (copy), u33 (copy)
        if IsLocked and IsLocked() then
            return;
        end;

        if u36 then
            u36:Cancel();
        end;

        u36 = TweenService:Create(u35, u34, {
            Scale = u33
        });
        u36:Play();
    end);

    return {
        Disconnect = function() -- Line: 312, Name: Disconnect
            -- upvalues: u39 (copy), u40 (copy), u36 (ref)
            u39:Disconnect();
            u40:Disconnect();

            if u36 then
                u36:Cancel();
                u36 = nil;
            end;
        end
    };
end;

function v2._bindTag(u41: table, p42: string, u43: any) -- Line: 323
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal(p42):Connect(function(p44) -- Line: 324
        -- upvalues: u41 (copy), u43 (copy)
        u41:_register(p44, u43);
    end);
    CollectionService:GetInstanceRemovedSignal(p42):Connect(function(p45) -- Line: 327
        -- upvalues: u41 (copy)
        u41:_unregister(p45);
    end);

    for _, v in CollectionService:GetTagged(p42) do
        u41:_register(v, u43);
    end;
end;

function v2._register(p46: table, p47: userdata, p48: any) -- Line: 335
    -- upvalues: Color3_new_ret (copy), u1 (ref), isEffectivelyVisible (copy)
    if p46._entries[p47] then
        return;
    end;

    local Kind = p48.Kind;
    local v49 = {
        elapsed = 0,
        sinceCheck = 0,
        instance = p47,
        kind = Kind
    };

    if Kind == "Rotate" or Kind == "Breathe" then
        if not p47:IsA("GuiObject") then
            warn((`[UIAnimationController] Ignoring {p47:GetFullName()} -- {tostring(Kind)} tag needs a GuiObject (has .Rotation), got {p47.ClassName}.`));

            return;
        end;

        v49.visSubject = p47;
        v49.baseRotation = p47.Rotation;

        if Kind == "Rotate" then
            v49.degPerSec = p48.DegreesPerSecond or 15;
        else
            local v50 = p47:FindFirstChildOfClass("UIScale");

            if v50 then
                v49.createdScale = false;
            else
                v50 = Instance.new("UIScale");
                v50.Name = "_BreatheScale";
                v50.Parent = p47;
                v49.createdScale = true;
            end;

            v49.uiScale = v50;
            v49.baseScale = v50.Scale;
            v49.scaleAmp = p48.ScaleAmplitude or 0.04;
            v49.scaleFreqRad = (p48.ScaleFrequency or 0.35) * 6.283185307179586;
            v49.rotAmpDeg = p48.RotationAmplitudeDeg or 2;
            v49.rotFreqRad = (p48.RotationFrequency or 0.35) * 6.283185307179586;
            v49.rotPhase = p48.RotationPhaseOffset or 1.5707963267948966;
        end;
    elseif Kind == "GradientSlide" or (Kind == "GradientSpin" or (Kind == "GradientRotate" or Kind == "GradientBreathe")) then
        if not p47:IsA("UIGradient") then
            warn((`[UIAnimationController] Ignoring {p47:GetFullName()} -- {tostring(Kind)} tag needs a UIGradient, got {p47.ClassName}.`));

            return;
        end;

        local v51 = p47:FindFirstAncestorWhichIsA("GuiObject");

        if not v51 then
            warn((`[UIAnimationController] Ignoring {p47:GetFullName()} -- UIGradient has no GuiObject ancestor to gate visibility on.`));

            return;
        end;

        v49.visSubject = v51;

        if Kind == "GradientSlide" then
            v49.baseOffset = p47.Offset;
            v49.offsetAmp = p48.OffsetAmplitude or 0.5;
            v49.offsetFreqRad = (p48.Frequency or 0.25) * 6.283185307179586;
            v49.offsetAxis = p48.Axis or "X";
        elseif Kind == "GradientSpin" or Kind == "GradientRotate" then
            v49.baseRotation = p47.Rotation;
            v49.degPerSec = p48.DegreesPerSecond or 15;
        else
            v49.baseTransparency = p47.Transparency;
            local Keypoints = p47.Transparency.Keypoints;
            v49.startValue = Keypoints[1].Value;
            v49.endValue = Keypoints[#Keypoints].Value;
            v49.centerValue = math.clamp(p48.Value or 0.975, 0, 1);
            v49.breatheFreqRad = (p48.Frequency or 0.25) * 6.283185307179586;
        end;
    elseif Kind == "Shine" then
        if not p47:IsA("GuiObject") then
            warn((`[UIAnimationController] Ignoring {p47:GetFullName()} -- Shine tag needs a GuiObject, got {p47.ClassName}.`));

            return;
        end;

        v49.visSubject = p47;
        local v52 = p47:IsA("TextLabel") or (p47:IsA("TextButton") or p47:IsA("TextBox"));
        v49.isText = v52;

        if v52 then
            v49.storedColor = p47.TextColor3;
            p47.TextColor3 = Color3_new_ret;
        else
            v49.storedColor = p47.BackgroundColor3;
            p47.BackgroundColor3 = Color3_new_ret;
        end;

        local ShineGradient = p47:FindFirstChild("ShineGradient");

        if ShineGradient and ShineGradient:IsA("UIGradient") then
            v49.createdGradient = false;
            v49.baseGradientColor = ShineGradient.Color;
            v49.baseGradientRotation = ShineGradient.Rotation;
        else
            ShineGradient = Instance.new("UIGradient");
            ShineGradient.Name = "ShineGradient";
            ShineGradient.Parent = p47;
            v49.createdGradient = true;
        end;

        ShineGradient.Rotation = p48.Rotation or 20;
        v49.gradient = ShineGradient;
        v49.shinePeriod = p48.Period or 2;
        v49.shineWipe = math.min(p48.WipeDuration or 0.8, v49.shinePeriod);
        v49.shineHalf = p48.PlateauHalfWidth or 0.02;
        v49.shineShoulder = v49.shineHalf + (p48.ShoulderWidth or 0.05);
        v49.shineStart = -v49.shineShoulder;
        v49.shineEnd = 1 + v49.shineShoulder;
        v49.shineEaseStyle = p48.EasingStyle or Enum.EasingStyle.Quint;
        v49.shineEaseDir = p48.EasingDirection or Enum.EasingDirection.Out;
        v49.shineParked = false;
        ShineGradient.Color = ColorSequence.new(v49.storedColor);
        v49.shineParked = true;
    else
        if Kind ~= "ShineFrame" then
            warn((`[UIAnimationController] Unknown Kind '{tostring(Kind)}' on {p47:GetFullName()} -- not registered.`));

            return;
        end;

        if not p47:IsA("GuiObject") then
            warn((`[UIAnimationController] Ignoring {p47:GetFullName()} -- ShineFrame tag needs a GuiObject, got {p47.ClassName}.`));

            return;
        end;

        if not u1 then
            warn((`[UIAnimationController] Ignoring {p47:GetFullName()} -- ShineFrame template (ReplicatedStorage.Assets.UI.ShineFrame) unavailable.`));

            return;
        end;

        v49.visSubject = p47;
        local v53 = u1:Clone();
        local v54 = v53:FindFirstChildWhichIsA("UIGradient");

        if not v54 then
            warn((`[UIAnimationController] Ignoring {p47:GetFullName()} -- ShineFrame template has no UIGradient.`));
            v53:Destroy();

            return;
        end;

        v53.Parent = p47;
        v49.shineFrame = v53;
        v49.gradient = v54;
        v49.baseOffsetY = v54.Offset.Y;
        v49.shinePeriod = p48.Period or 4;
        v49.shineWipe = math.min(p48.WipeDuration or 1, v49.shinePeriod);
        v49.frameOffsetStart = p48.OffsetStart or -0.3;
        v49.frameOffsetEnd = p48.OffsetEnd or 1.05;
        v49.shineEaseStyle = p48.EasingStyle or Enum.EasingStyle.Linear;
        v49.shineEaseDir = p48.EasingDirection or Enum.EasingDirection.Out;
        v54.Offset = Vector2.new(v49.frameOffsetStart, v49.baseOffsetY);
        v49.shineParked = true;
    end;

    v49.visible = isEffectivelyVisible(v49.visSubject);
    p46._entries[p47] = v49;
end;

function v2._unregister(p55: table, p56: userdata) -- Line: 520
    local v57 = p55._entries[p56];

    if not v57 then
        return;
    end;

    p55._entries[p56] = nil;

    if v57.uiScale then
        if v57.createdScale then
            v57.uiScale:Destroy();
        else
            v57.uiScale.Scale = v57.baseScale;
        end;
    end;

    if v57.kind == "Shine" then
        if p56:IsA("GuiObject") then
            if v57.isText then
                p56.TextColor3 = v57.storedColor;
            else
                p56.BackgroundColor3 = v57.storedColor;
            end;
        end;

        if v57.gradient then
            if v57.createdGradient then
                v57.gradient:Destroy();

                return;
            end;

            v57.gradient.Color = v57.baseGradientColor;
            v57.gradient.Rotation = v57.baseGradientRotation;
        end;

        return;
    end;

    if v57.kind == "ShineFrame" then
        if v57.shineFrame then
            v57.shineFrame:Destroy();
        end;

        return;
    end;

    if p56:IsA("GuiObject") then
        if v57.baseRotation ~= nil then
            p56.Rotation = v57.baseRotation;
        end;
    elseif p56:IsA("UIGradient") then
        if v57.baseOffset ~= nil then
            p56.Offset = v57.baseOffset;
        end;

        if v57.baseRotation ~= nil then
            p56.Rotation = v57.baseRotation;
        end;

        if v57.baseTransparency ~= nil then
            p56.Transparency = v57.baseTransparency;
        end;
    end;
end;

function v2._step(p58: table, p59: number) -- Line: 578
    -- upvalues: UIAnimationConfig (copy), Registry (copy), isEffectivelyVisible (copy), TweenService (copy), buildShineSequence (copy)
    local VISIBILITY_RECHECK_INTERVAL = UIAnimationConfig.VISIBILITY_RECHECK_INTERVAL;
    local v60 = Registry:Get("PlayerData");
    local v61 = not (v60 and (v60.Data and v60.Data.Settings)) and true or v60.Data.Settings.GradientSpinOn ~= false;

    for _, v in p58._entries do
        v.sinceCheck = v.sinceCheck + p59;

        if VISIBILITY_RECHECK_INTERVAL <= v.sinceCheck then
            v.sinceCheck = 0;
            local v62 = isEffectivelyVisible(v.visSubject);

            if v.kind == "GradientSpin" and not v61 then
                v.instance.Rotation = v.baseRotation;
                v.elapsed = 0;
                v62 = false;
            end;

            v.visible = v62;
        end;

        if v.visible then
            v.elapsed = v.elapsed + p59;
            local elapsed = v.elapsed;
            local instance = v.instance;

            if v.kind == "Rotate" then
                instance.Rotation = (v.baseRotation + elapsed * v.degPerSec) % 360;
            elseif v.kind == "Breathe" then
                v.uiScale.Scale = v.baseScale * (1 + v.scaleAmp * math.sin(elapsed * v.scaleFreqRad));
                instance.Rotation = v.baseRotation + v.rotAmpDeg * math.sin(elapsed * v.rotFreqRad + v.rotPhase);
            elseif v.kind == "GradientSlide" then
                local v63 = v.offsetAmp * math.sin(elapsed * v.offsetFreqRad);
                local baseOffset = v.baseOffset;

                if v.offsetAxis == "Y" then
                    instance.Offset = Vector2.new(baseOffset.X, baseOffset.Y + v63);
                else
                    instance.Offset = Vector2.new(baseOffset.X + v63, baseOffset.Y);
                end;
            elseif v.kind == "GradientSpin" or v.kind == "GradientRotate" then
                instance.Rotation = (v.baseRotation + elapsed * v.degPerSec) % 360;
            elseif v.kind == "GradientBreathe" then
                local v64 = 0.5 - math.sin(elapsed * v.breatheFreqRad) * 0.5;
                local math_clamp_ret = math.clamp(v64, 0.001, 0.999);
                instance.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, v.startValue), NumberSequenceKeypoint.new(math_clamp_ret, v.centerValue), NumberSequenceKeypoint.new(1, v.endValue) });
            elseif v.kind == "Shine" then
                local v65 = elapsed % v.shinePeriod;

                if v65 < v.shineWipe then
                    local Value = TweenService:GetValue(v65 / v.shineWipe, v.shineEaseStyle, v.shineEaseDir);
                    v.gradient.Color = buildShineSequence(v.shineStart + (v.shineEnd - v.shineStart) * Value, v.storedColor, v.shineHalf, v.shineShoulder);
                    v.shineParked = false;
                elseif not v.shineParked then
                    v.gradient.Color = ColorSequence.new(v.storedColor);
                    v.shineParked = true;
                end;
            elseif v.kind == "ShineFrame" then
                local v66 = elapsed % v.shinePeriod;

                if v66 < v.shineWipe then
                    local Value = TweenService:GetValue(v66 / v.shineWipe, v.shineEaseStyle, v.shineEaseDir);
                    v.gradient.Offset = Vector2.new(v.frameOffsetStart + (v.frameOffsetEnd - v.frameOffsetStart) * Value, v.baseOffsetY);
                    v.shineParked = false;
                elseif not v.shineParked then
                    v.gradient.Offset = Vector2.new(v.frameOffsetStart, v.baseOffsetY);
                    v.shineParked = true;
                end;
            end;
        end;
    end;
end;

return v2;