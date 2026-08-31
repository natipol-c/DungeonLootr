--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     FloatAndLinger
  Path:     game.ReplicatedStorage.GameInfo.DamageNumberData.FloatAndLinger
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local UDim2_new_ret = UDim2.new(10, 0, 0, 0);

return {
    Name = "FloatAndLinger",
    DisplayName = "Float & Linger",
    Description = "Springy grow-in, quick float that lingers at the apex, then a gentle exponential fall. Crits render larger.",

    Render = function(u1) -- Line: 62, Name: Render
        -- upvalues: UDim2_new_ret (copy), TweenService (copy)
        local Part = u1.Part;
        local Billboard = u1.Billboard;
        local Label = u1.Label;
        local Stroke = u1.Stroke;
        local v2 = (u1.IsCrit and 1 or 0.5) * 3;
        local v3 = u1.ScaleSize(UDim2_new_ret, u1.SizeScale);
        local u4 = u1.ScaleSize(UDim2.new(10, 0, v2, 0), u1.SizeScale);
        Label.TextColor3 = Color3.fromRGB(255, 255, 255);
        Billboard.Size = v3;
        Part.Anchored = true;
        Part.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        local v5 = u1.RNG:NextNumber(0, 6.283185307179586);
        local v6 = u1.RNG:NextNumber(0, 1.4);
        local v7 = math.cos(v5) * v6;
        local v8 = u1.RNG:NextNumber(-0.7, 0.7);
        local v9 = math.sin(v5) * v6;
        local Vector3_new_ret = Vector3.new(v7, v8, v9);
        Part.CFrame = u1.Spawn + Vector3_new_ret;
        local v10 = u1.Spawn.Position + Vector3_new_ret;
        local v11 = u1.RNG:NextNumber(1.6, 3);
        local v12 = u1.RNG:NextNumber(0, 6.283185307179586);
        local v13 = u1.RNG:NextNumber(0.6, 2.2);
        local v14 = math.cos(v12) * v13;
        local v15 = math.sin(v12) * v13;
        local v16 = v10 + Vector3.new(v14, v11, v15);
        local u17 = v16 + Vector3.new(v14 * 0.6, -2.6, v15 * 0.6);
        local v18 = u1.ScaleSize(UDim2.new(10, 0, v2 * 1.25, 0), u1.SizeScale);
        TweenService:Create(Billboard, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = v18
        }):Play();
        task.delay(0.1, function() -- Line: 104
            -- upvalues: TweenService (ref), Billboard (copy), u4 (copy)
            TweenService:Create(Billboard, TweenInfo.new(0.14, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = u4
            }):Play();
        end);
        task.delay(0.08, function() -- Line: 109
            -- upvalues: TweenService (ref), Label (copy), u1 (copy)
            TweenService:Create(Label, TweenInfo.new(0.15), {
                TextColor3 = u1.Color
            }):Play();
        end);
        TweenService:Create(Part, TweenInfo.new(0.17, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = v16
        }):Play();
        task.delay(0.2, function() -- Line: 118
            -- upvalues: TweenService (ref), Part (copy), u17 (copy)
            TweenService:Create(Part, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Position = u17
            }):Play();
        end);
        task.delay(0.6000000000000001, function() -- Line: 123
            -- upvalues: TweenService (ref), Label (copy), Stroke (copy), u1 (copy)
            TweenService:Create(Label, TweenInfo.new(0.2), {
                TextTransparency = 1
            }):Play();
            TweenService:Create(Stroke, TweenInfo.new(0.2), {
                Transparency = 1
            }):Play();
            task.wait(0.2);
            u1.Release();
        end);
    end
};