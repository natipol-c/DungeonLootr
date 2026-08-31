--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PopAndHold
  Path:     game.ReplicatedStorage.GameInfo.DamageNumberData.PopAndHold
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local UDim2_new_ret = UDim2.new(10, 0, 0, 0);
local UDim2_new_ret2 = UDim2.new(10, 0, 3, 0);
local UDim2_new_ret3 = UDim2.new(10, 0, 2, 0);

return {
    Name = "PopAndHold",
    DisplayName = "Pop & Hold",
    Description = "Number pops in and holds in place at a readable size, then fades after ~1s. No physics.",

    Render = function(u1) -- Line: 25, Name: Render
        -- upvalues: UDim2_new_ret (copy), UDim2_new_ret2 (copy), UDim2_new_ret3 (copy), TweenService (copy)
        local Billboard = u1.Billboard;
        local Label = u1.Label;
        local Stroke = u1.Stroke;
        local v2 = u1.ScaleSize(UDim2_new_ret, u1.SizeScale);
        local v3 = u1.ScaleSize(UDim2_new_ret2, u1.SizeScale);
        local u4 = u1.ScaleSize(UDim2_new_ret3, u1.SizeScale);
        Label.TextColor3 = Color3.fromRGB(255, 255, 255);
        Billboard.Size = v2;
        TweenService:Create(Billboard, TweenInfo.new(0.1), {
            Size = v3
        }):Play();
        task.delay(0.1, function() -- Line: 38
            -- upvalues: TweenService (ref), Label (copy), u1 (copy), Billboard (copy), u4 (copy)
            TweenService:Create(Label, TweenInfo.new(0.15), {
                TextColor3 = u1.Color
            }):Play();
            TweenService:Create(Billboard, TweenInfo.new(0.5), {
                Size = u4
            }):Play();
        end);
        task.delay(1, function() -- Line: 44
            -- upvalues: TweenService (ref), Label (copy), Stroke (copy), u1 (copy)
            TweenService:Create(Label, TweenInfo.new(0.3), {
                TextTransparency = 1
            }):Play();
            TweenService:Create(Stroke, TweenInfo.new(0.3), {
                Transparency = 1
            }):Play();
            task.wait(0.3);
            u1.Release();
        end);
    end
};