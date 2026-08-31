--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     screen
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.screen
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = require("../mod/attributes");
require("../types");
local u2 = require("../mod/utility");

return {
    emit = function(u3: userdata, p4: any) -- Line: 9, Name: emit
        -- upvalues: u1 (copy), u2 (copy), RunService (copy)
        if u3:GetAttribute("Enabled") then
            local u5 = u1.get(u3, "PartScale", Vector3.new(1, 1, 1));
            local u6 = u1.get(u3, "PartDistance", 1.5);
            local u7 = u1.get(u3, "OffsetPosition", Vector3.new(0, 0, 0));
            local u8 = u1.get(u3, "OffsetRotation", Vector3.new(0, 0, 0)) * u2.DEG_TO_RAD;
            local CFrame2 = u3.CFrame;
            local Size = u3.Size;
            local CollisionGroup = u3.CollisionGroup;
            u3.CollisionGroup = "ForgeMouseIgnore";
            table.insert(p4, function() -- Line: 26
                -- upvalues: u3 (copy), Size (copy), CFrame2 (copy), CollisionGroup (copy)
                u3.Size = Size;
                u3.CFrame = CFrame2;
                u3.CollisionGroup = CollisionGroup == "" and "Default" or (CollisionGroup or "Default");
            end);

            local function frame() -- Line: 33
                -- upvalues: u6 (copy), u3 (copy), u5 (copy), u7 (copy), u8 (copy)
                local workspace_CurrentCamera = workspace.CurrentCamera;
                local math_rad_ret = math.rad(workspace_CurrentCamera.FieldOfView / 2);
                local v9 = math.tan(math_rad_ret) * u6 * 2;
                local v10 = workspace_CurrentCamera.ViewportSize.X / workspace_CurrentCamera.ViewportSize.Y * v9;
                local v11 = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -u6);
                u3.Size = Vector3.new(v10, v9, u3.Size.Z) * u5;
                u3.CFrame = v11 * CFrame.new(u7) * CFrame.fromOrientation(u8.x, u8.y, u8.z);
            end;

            if RunService:IsRunning() then
                local RandomId = u2.getRandomId();
                RunService:BindToRenderStep(RandomId, Enum.RenderPriority.Last.Value + 2 + p4.depth, frame);
                table.insert(p4, function() -- Line: 53
                    -- upvalues: RunService (ref), RandomId (copy)
                    RunService:UnbindFromRenderStep(RandomId);
                end);
            else
                table.insert(p4, RunService.RenderStepped:Connect(frame));
            end;

            return true;
        end;
    end
};