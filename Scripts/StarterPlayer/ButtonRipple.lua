--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ButtonRipple
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.ButtonRipple
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In);

local function createOverlay(p1: userdata) -- Line: 30
    local Frame = Instance.new("Frame");
    Frame.Name = "_RippleOverlay";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.Position = UDim2.fromScale(0, 0);
    Frame.AnchorPoint = Vector2.new(0, 0);
    Frame.BackgroundColor3 = Color3.new(1, 1, 1);
    Frame.BackgroundTransparency = 0;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 100;
    Frame.Active = false;
    local v2 = p1:FindFirstChildOfClass("UICorner");

    if v2 then
        v2:Clone().Parent = Frame;
    end;

    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "_RippleGradient";
    UIGradient.Transparency = NumberSequence.new(1);
    UIGradient.Parent = Frame;
    Frame.Parent = p1;

    return Frame, UIGradient;
end;

local function playRipple(p3: userdata, u4: userdata, u5: table) -- Line: 60
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
    if u5.value then
        u5.value:Destroy();
        u5.value = nil;
    end;

    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 0;
    u5.value = NumberValue;

    local function lerp(p6: number, p7: number, p8: number) -- Line: 72
        return p6 + (p7 - p6) * p8;
    end;

    local u10 = NumberValue.Changed:Connect(function(p9) -- Line: 80
        -- upvalues: u4 (copy)
        u4.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, p9 * -0.75 + 1), NumberSequenceKeypoint.new(0.5, p9 * 0.75 + 0.25), NumberSequenceKeypoint.new(1, p9 * -0.75 + 1) });
    end);
    u4.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.25), NumberSequenceKeypoint.new(1, 1) });
    local v11 = TweenService:Create(NumberValue, TweenInfo_new_ret, {
        Value = 1
    });
    v11.Completed:Connect(function() -- Line: 97
        -- upvalues: u10 (ref), NumberValue (copy), u4 (copy), TweenService (ref), TweenInfo_new_ret2 (ref), u5 (copy)
        u10:Disconnect();
        NumberValue.Value = 0;
        u10 = NumberValue.Changed:Connect(function(p12) -- Line: 103
            -- upvalues: u4 (ref)
            u4.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, p12 * 0.75 + 0.25), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, p12 * 0.75 + 0.25) });
        end);
        local v13 = TweenService:Create(NumberValue, TweenInfo_new_ret2, {
            Value = 1
        });
        v13.Completed:Connect(function() -- Line: 113
            -- upvalues: u10 (ref), u5 (ref), NumberValue (ref), u4 (ref)
            u10:Disconnect();

            if u5.value == NumberValue then
                u5.value = nil;
            end;

            NumberValue:Destroy();
            u4.Transparency = NumberSequence.new(1);
        end);
        v13:Play();
    end);
    v11:Play();
end;

local function _init(p14) -- Line: 131
    -- upvalues: createOverlay (copy), playRipple (copy)
    local v15;

    if p14:IsA("Frame") or (p14:IsA("ImageLabel") or p14:IsA("TextLabel")) then
        v15 = p14:FindFirstChildWhichIsA("GuiButton") or p14;
    else
        if not p14:IsA("GuiButton") then
            warn(("[ButtonRipple] SKIP: %s is %s (unsupported)"):format(p14:GetFullName(), p14.ClassName));

            return;
        end;

        v15 = p14;
    end;

    local _RippleOverlay = p14:FindFirstChild("_RippleOverlay");
    local u16;

    if _RippleOverlay then
        u16 = _RippleOverlay:FindFirstChild("_RippleGradient");
    else
        u16 = nil;
    end;

    if not (_RippleOverlay and u16) then
        _RippleOverlay, u16 = createOverlay(p14);
    end;

    local u17 = {
        value = nil
    };

    if v15:IsA("GuiButton") then
        v15.MouseButton1Down:Connect(function() -- Line: 160
            -- upvalues: playRipple (ref), _RippleOverlay (ref), u16 (ref), u17 (copy)
            playRipple(_RippleOverlay, u16, u17);
        end);
    else
        v15.InputBegan:Connect(function(p18) -- Line: 164
            -- upvalues: playRipple (ref), _RippleOverlay (ref), u16 (ref), u17 (copy)
            if p18.UserInputType == Enum.UserInputType.MouseButton1 or p18.UserInputType == Enum.UserInputType.Touch then
                playRipple(_RippleOverlay, u16, u17);
            end;
        end);
    end;
end;

return function() -- Line: 175
    -- upvalues: CollectionService (copy), _init (copy)
    CollectionService:GetInstanceAddedSignal("BUTTON_RIPPLE"):Connect(function(p19) -- Line: 176
        -- upvalues: _init (ref)
        task.defer(_init, p19);
    end);

    for _, v in ipairs(CollectionService:GetTagged("BUTTON_RIPPLE")) do
        task.defer(_init, v);
    end;
end;