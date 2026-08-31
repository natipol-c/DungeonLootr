--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ButtonHover
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.ButtonHover
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local TweenInfo_new_ret = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

local function getOriginalSize(p1) -- Line: 11
    local Attribute = p1:GetAttribute("_OrigSize");

    if Attribute then
        return Attribute;
    end;

    local Size = p1.Size;
    p1:SetAttribute("_OrigSize", Size);

    return Size;
end;

function _init(u2)
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), Knit (copy)
    local v3;

    if u2:IsA("Frame") or (u2:IsA("ImageLabel") or u2:IsA("TextLabel")) then
        v3 = u2:FindFirstChildWhichIsA("GuiButton") or u2;
    else
        v3 = u2;
    end;

    v3.MouseEnter:Connect(function() -- Line: 33
        -- upvalues: u2 (copy), TweenService (ref), TweenInfo_new_ret (ref), Knit (ref)
        local v4 = u2;
        local Attribute = v4:GetAttribute("_OrigSize");

        if not Attribute then
            Attribute = v4.Size;
            v4:SetAttribute("_OrigSize", Attribute);
        end;

        TweenService:Create(u2, TweenInfo_new_ret, {
            Size = UDim2.new(Attribute.X.Scale * 1.05, Attribute.X.Offset * 1.05, Attribute.Y.Scale * 1.05, Attribute.Y.Offset * 1.05)
        }):Play();
        Knit.GetController("SoundController"):Play("ButtonHover");
    end);
    v3.MouseLeave:Connect(function() -- Line: 44
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
    end);
end;

return function() -- Line: 50
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("BUTTON_HOVER"):Connect(function(p6) -- Line: 51
        task.defer(_init, p6);
    end);

    for _, v in ipairs(CollectionService:GetTagged("BUTTON_HOVER")) do
        task.defer(_init, v);
    end;
end;