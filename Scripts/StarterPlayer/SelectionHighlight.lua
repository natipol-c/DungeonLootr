--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SelectionHighlight
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.SelectionHighlight
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local Color3_fromRGB_ret = Color3.fromRGB(255, 224, 120);
local v1 = {};

local function getOriginalSize(p2: userdata) -- Line: 35
    local Attribute = p2:GetAttribute("_OrigSize");

    if Attribute then
        return Attribute;
    end;

    local Size = p2.Size;
    p2:SetAttribute("_OrigSize", Size);

    return Size;
end;

local function findStroke(p3: userdata) -- Line: 46
    local Background = p3:FindFirstChild("Background");

    if Background then
        local Stroke = Background:FindFirstChild("Stroke");

        if Stroke and Stroke:IsA("UIStroke") then
            return Stroke;
        end;

        local v4 = Background:FindFirstChildOfClass("UIStroke");

        if v4 then
            return v4;
        end;
    end;

    return p3:FindFirstChildOfClass("UIStroke");
end;

function v1.Set(p5: userdata?, p6: boolean, p7) -- Line: 63
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), findStroke (copy), Color3_fromRGB_ret (copy)
    if not (p5 and p5.Parent) then
        return;
    end;

    local Attribute = p5:GetAttribute("_OrigSize");

    if not Attribute then
        Attribute = p5.Size;
        p5:SetAttribute("_OrigSize", Attribute);
    end;

    if p6 then
        Attribute = UDim2.new(Attribute.X.Scale * 1.06, Attribute.X.Offset * 1.06, Attribute.Y.Scale * 1.06, Attribute.Y.Offset * 1.06);
    end;

    TweenService:Create(p5, TweenInfo_new_ret, {
        Size = Attribute
    }):Play();
    local v8 = findStroke(p5);

    if v8 then
        local Attribute2 = v8:GetAttribute("_OrigColor");

        if not Attribute2 then
            Attribute2 = v8.Color;
            v8:SetAttribute("_OrigColor", Attribute2);
        end;

        local v9 = {};

        if p6 then
            Attribute2 = p7 or (Color3_fromRGB_ret or Attribute2);
        end;

        v9.Color = Attribute2;
        TweenService:Create(v8, TweenInfo_new_ret, v9):Play();
    end;
end;

return v1;