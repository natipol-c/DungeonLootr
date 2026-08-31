--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PartConstants
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.PartConstants
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    DirectionVectors = {
        [Enum.NormalId.Top] = {
            vector = "UpVector",
            multiplier = 1
        },
        [Enum.NormalId.Bottom] = {
            vector = "UpVector",
            multiplier = -1
        },
        [Enum.NormalId.Front] = {
            vector = "LookVector",
            multiplier = 1
        },
        [Enum.NormalId.Back] = {
            vector = "LookVector",
            multiplier = -1
        },
        [Enum.NormalId.Left] = {
            vector = "RightVector",
            multiplier = -1
        },
        [Enum.NormalId.Right] = {
            vector = "RightVector",
            multiplier = 1
        }
    },
    shapeFunctions = {
        [Enum.ParticleEmitterShape.Box] = function(p1, p2) -- Line: 18
            local v3 = (math.random() * 2 - 1) * p1.Size.X / 2;
            local v4 = (math.random() * 2 - 1) * p1.Size.Y / 2;
            local v5 = (math.random() * 2 - 1) * p1.Size.Z / 2;

            return Vector3.new(v3, v4, v5), CFrame.new();
        end,

        [Enum.ParticleEmitterShape.Sphere] = function(p6, p7) -- Line: 24
            local v8 = p6.Size.X / 2;
            local v9 = v8 * p7.ShapePartial;
            local v10 = (math.random() * (v8 ^ 3 - v9 ^ 3) + v9 ^ 3) ^ 0.3333333333333333;
            local v11 = math.random() * 2 * 3.141592653589793;
            local v12 = math.random() * 2 - 1;
            local math_acos_ret = math.acos(v12);
            local v13 = math.sin(math_acos_ret) * math.cos(v11);
            local v14 = math.sin(math_acos_ret) * math.sin(v11);
            local math_cos_ret = math.cos(math_acos_ret);
            local Vector3_new_ret = Vector3.new(v13, v14, math_cos_ret);

            return Vector3_new_ret * v10, CFrame.lookAt(Vector3.new(), -Vector3_new_ret);
        end,

        [Enum.ParticleEmitterShape.Cylinder] = function(p15, p16) -- Line: 37
            local v17 = p15.Size.X / 2;
            local Y = p15.Size.Y;
            local ShapePartial = p16.ShapePartial;
            local math_random_ret = math.random();
            local v18 = math.sqrt(math_random_ret) * (1 - ShapePartial) + ShapePartial;
            local v19 = math.random() * 2 * 3.141592653589793;
            local v20 = v18 * v17 * math.cos(v19);
            local v21 = (math.random() * 2 - 1) * (Y / 2);
            local v22 = v18 * v17 * math.sin(v19);
            local Vector3_new_ret = Vector3.new(v20, v21, v22);
            local v23;

            if math.abs(v21) > Y / 2 - 0.01 then
                local math_sign_ret = math.sign(v21);
                v23 = Vector3.new(0, math_sign_ret, 0);
            else
                local Vector3_new_ret2 = Vector3.new(v20, 0, v22);
                v23 = Vector3_new_ret2.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or Vector3_new_ret2.Unit;
            end;

            return Vector3_new_ret, CFrame.lookAt(Vector3.new(), -v23);
        end,

        [Enum.ParticleEmitterShape.Disc] = function(p24, p25) -- Line: 60
            local v26 = p24.Size.X / 2;
            local ShapePartial = p25.ShapePartial;
            local math_random_ret = math.random();
            local v27 = math.sqrt(math_random_ret) * (1 - ShapePartial) + ShapePartial;
            local v28 = math.random() * 2 * 3.141592653589793;
            local v29 = v27 * v26 * math.cos(v28);
            local v30 = v27 * v26 * math.sin(v28);
            local Vector3_new_ret = Vector3.new(v29, 0, v30);

            if Vector3_new_ret.Magnitude < 0.0001 then
                return Vector3_new_ret, CFrame.new();
            end;

            local Unit = Vector3_new_ret.Unit;

            return Vector3_new_ret, CFrame.lookAt(Vector3.new(), -Unit);
        end
    }
};