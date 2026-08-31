--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PopAndFall
  Path:     game.ReplicatedStorage.GameInfo.DamageNumberData.PopAndFall
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
local UDim2_new_ret3 = UDim2.new(10, 0, 0, 0);

return {
    Name = "PopAndFall",
    DisplayName = "Pop & Fall",
    Description = "Number pops in, arcs up-and-out on a physics impulse, collapses to nothing and fades.",

    Render = function(u1) -- Line: 43, Name: Render
        -- upvalues: UDim2_new_ret (copy), UDim2_new_ret2 (copy), UDim2_new_ret3 (copy), TweenService (copy)
        local Part = u1.Part;
        local Billboard = u1.Billboard;
        local Label = u1.Label;
        local Stroke = u1.Stroke;
        local v2 = u1.ScaleSize(UDim2_new_ret, u1.SizeScale);
        local v3 = u1.ScaleSize(UDim2_new_ret2, u1.SizeScale);
        local u4 = u1.ScaleSize(UDim2_new_ret3, u1.SizeScale);
        Label.TextColor3 = Color3.fromRGB(255, 255, 255);
        Billboard.Size = v2;
        Part.Anchored = false;
        Part.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        local LookVector = (CFrame.new(Part.Position) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.Angles(u1.RNG:NextNumber(-0.2243994752564138, 0.2243994752564138), u1.RNG:NextNumber(-0.2243994752564138, 0.2243994752564138), 0)).LookVector;
        Part:ApplyImpulse(Part.AssemblyMass * LookVector * math.random(30, 40) * u1.VelocityScale);
        TweenService:Create(Billboard, TweenInfo.new(0.1), {
            Size = v3
        }):Play();
        task.delay(0.1, function() -- Line: 66
            -- upvalues: TweenService (ref), Label (copy), u1 (copy), Billboard (copy), u4 (copy), Stroke (copy)
            TweenService:Create(Label, TweenInfo.new(0.15), {
                TextColor3 = u1.Color
            }):Play();
            TweenService:Create(Billboard, TweenInfo.new(0.5), {
                Size = u4
            }):Play();
            task.wait(0.2);
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