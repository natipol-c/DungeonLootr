--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ButtonClick
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.ButtonClick
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

local function getOriginalSize(p1) -- Line: 8
    local Attribute = p1:GetAttribute("_OrigSize");

    if Attribute then
        return Attribute;
    end;

    local Size = p1.Size;
    p1:SetAttribute("_OrigSize", Size);

    return Size;
end;

function _init(u2)
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    local v3;

    if u2:IsA("Frame") or (u2:IsA("ImageLabel") or u2:IsA("TextLabel")) then
        v3 = u2:FindFirstChildWhichIsA("GuiButton") or u2;
    else
        v3 = u2;
    end;

    local function onDown() -- Line: 31
        -- upvalues: u2 (copy), TweenService (ref), TweenInfo_new_ret (ref)
        local v4 = u2;
        local Attribute = v4:GetAttribute("_OrigSize");

        if not Attribute then
            Attribute = v4.Size;
            v4:SetAttribute("_OrigSize", Attribute);
        end;

        TweenService:Create(u2, TweenInfo_new_ret, {
            Size = UDim2.new(Attribute.X.Scale * 0.95, Attribute.X.Offset * 0.95, Attribute.Y.Scale * 0.95, Attribute.Y.Offset * 0.95)
        }):Play();
    end;

    local function onUp() -- Line: 41
        -- upvalues: u2 (copy), TweenService (ref), TweenInfo_new_ret (ref)
        local v5 = u2;
        local Attribute = v5:GetAttribute("_OrigSize");

        if not Attribute then
            Attribute = v5.Size;
            v5:SetAttribute("_OrigSize", Attribute);
        end;

        TweenService:Create(u2, TweenInfo_new_ret, {
            Size = Attribute
        }):Play();
    end;

    if v3:IsA("GuiButton") then
        v3.MouseButton1Down:Connect(onDown);
        v3.MouseButton1Up:Connect(onUp);

        return;
    end;

    v3.InputBegan:Connect(function(p6) -- Line: 50
        -- upvalues: onDown (copy)
        if p6.UserInputType == Enum.UserInputType.MouseButton1 or p6.UserInputType == Enum.UserInputType.Touch then
            onDown();
        end;
    end);
    v3.InputEnded:Connect(function(p7) -- Line: 56
        -- upvalues: u2 (copy), TweenService (ref), TweenInfo_new_ret (ref)
        if p7.UserInputType == Enum.UserInputType.MouseButton1 or p7.UserInputType == Enum.UserInputType.Touch then
            local v8 = u2;
            local Attribute = v8:GetAttribute("_OrigSize");

            if not Attribute then
                Attribute = v8.Size;
                v8:SetAttribute("_OrigSize", Attribute);
            end;

            TweenService:Create(u2, TweenInfo_new_ret, {
                Size = Attribute
            }):Play();
        end;
    end);
end;

return function() -- Line: 66
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("BUTTON_CLICK"):Connect(function(p9) -- Line: 67
        task.defer(_init, p9);
    end);

    for _, v in ipairs(CollectionService:GetTagged("BUTTON_CLICK")) do
        task.defer(_init, v);
    end;
end;