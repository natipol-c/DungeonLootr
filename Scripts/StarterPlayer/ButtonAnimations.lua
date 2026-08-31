--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ButtonAnimations
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.ButtonAnimations
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local script_Parent = script.Parent;
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Controllers = script_Parent.Parent:WaitForChild("Controllers");
local spr = require(script_Parent.spr);
local playSound = require(Modules.Utils.playSound);
require(Controllers.UIController);
local u1 = {
    hover = {}
};
local hover = u1.hover;
u1.hover.dampingRatio = 1;
hover.frequency = 15;
u1.click = {};
local click = u1.click;
u1.click.dampingRatio = 1;
click.frequency = 10;

return function(u2, p3) -- Line: 22
    -- upvalues: spr (copy), u1 (copy), playSound (copy)
    local v4 = p3 or {};

    if u2:HasTag("BlockAnimation") then
        return;
    end;

    local v5 = v4.clickScaleX or 1;
    local v6 = v4.clickScaleY or 1;
    local v7 = v4.clickOffsetX or -8;
    local v8 = v4.clickOffsetY or -8;
    local clickSound = v4.clickSound;
    local Size = u2.Size;
    local UDim2_new_ret = UDim2.new(Size.X.Scale * (v4.hoverInScaleX or 1), Size.X.Offset + (v4.hoverInOffsetX or 5), Size.Y.Scale * (v4.hoverInScaleY or 1), Size.Y.Offset + (v4.hoverInOffsetY or 5));
    local UDim2_new_ret2 = UDim2.new(Size.X.Scale * v5, Size.X.Offset + v7, Size.Y.Scale * v6, Size.Y.Offset + v8);

    local function onHover() -- Line: 57
        -- upvalues: spr (ref), u2 (copy), u1 (ref), UDim2_new_ret (copy)
        spr.target(u2, u1.hover.dampingRatio, u1.hover.frequency, {
            Size = UDim2_new_ret
        });
    end;

    local function onLeave() -- Line: 63
        -- upvalues: spr (ref), u2 (copy), u1 (ref), Size (copy)
        spr.target(u2, u1.hover.dampingRatio, u1.hover.frequency, {
            Size = Size
        });
    end;

    local function onClick() -- Line: 69
        -- upvalues: playSound (ref), clickSound (copy), spr (ref), u2 (copy), u1 (ref), UDim2_new_ret2 (copy), Size (copy)
        playSound("ButtonClick");

        if clickSound then
            playSound(clickSound);
        end;

        spr.target(u2, u1.click.dampingRatio, u1.click.frequency, {
            Size = UDim2_new_ret2
        });
        task.delay(0.1, function() -- Line: 77
            -- upvalues: spr (ref), u2 (ref), u1 (ref), Size (ref)
            spr.target(u2, u1.click.dampingRatio, u1.click.frequency, {
                Size = Size
            });
        end);
    end;

    u2.MouseButton1Click:Connect(function() -- Line: 84
        -- upvalues: onClick (copy)
        onClick();
    end);
    u2.MouseEnter:Connect(function() -- Line: 88
        -- upvalues: playSound (ref), spr (ref), u2 (copy), u1 (ref), UDim2_new_ret (copy)
        playSound("ButtonHover");
        spr.target(u2, u1.hover.dampingRatio, u1.hover.frequency, {
            Size = UDim2_new_ret
        });
    end);
    u2.MouseLeave:Connect(function() -- Line: 93
        -- upvalues: spr (ref), u2 (copy), u1 (ref), Size (copy)
        spr.target(u2, u1.hover.dampingRatio, u1.hover.frequency, {
            Size = Size
        });
    end);
end;