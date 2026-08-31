--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CombatFeedbackHandler
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.CombatFeedbackHandler
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CameraShake = require(ReplicatedStorage.Modules.CameraShake);
local DamageDisplay = require(ReplicatedStorage.Modules.DamageDisplay);
local CombatFeedback = ReplicatedStorage:WaitForChild("Player").Remotes:WaitForChild("CombatFeedback");
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret = Color3.fromRGB(255, 70, 70);
local u1 = {
    SizeScale = 0.5,
    VelocityScale = 0.65
};

return function(p2, p3) -- Line: 15
    -- upvalues: CombatFeedback (copy), CameraShake (copy), LocalPlayer (copy), DamageDisplay (copy), Color3_fromRGB_ret (copy), u1 (copy)
    CombatFeedback.OnClientEvent:Connect(function(p4, p5) -- Line: 16
        -- upvalues: CameraShake (ref), LocalPlayer (ref), DamageDisplay (ref), Color3_fromRGB_ret (ref), u1 (ref)
        if p4 ~= "Hit" then
            if p4 == "TakeDamage" then
                CameraShake.Shake("Hit");

                if typeof(p5) == "number" and p5 > 0 then
                    local Character = LocalPlayer.Character;

                    if Character then
                        Character = Character:FindFirstChild("HumanoidRootPart");
                    end;

                    if Character then
                        DamageDisplay.DisplayDamage(Character.Position + Vector3.new(0, 3, 0), p5, Color3_fromRGB_ret, u1);

                        return;
                    end;
                end;
            elseif p4 == "Shake" then
                if typeof(p5) == "string" then
                    CameraShake.Shake(p5);

                    return;
                end;
            elseif p4 == "FaceDirection" and (typeof(p5) == "Vector3" and p5.Magnitude > 0.001) then
                local workspace_CurrentCamera = workspace.CurrentCamera;

                if workspace_CurrentCamera and workspace_CurrentCamera.CameraType == Enum.CameraType.Custom then
                    local Unit = p5.Unit;
                    local math_clamp_ret = math.clamp(workspace_CurrentCamera.CFrame.LookVector.Y, -0.9, 0.9);
                    local math_sqrt_ret = math.sqrt(1 - math_clamp_ret * math_clamp_ret);
                    local Vector3_new_ret = Vector3.new(Unit.X * math_sqrt_ret, math_clamp_ret, Unit.Z * math_sqrt_ret);
                    local Position = workspace_CurrentCamera.CFrame.Position;
                    workspace_CurrentCamera.CFrame = CFrame.new(Position, Position + Vector3_new_ret);
                end;
            end;

            return;
        end;

        if p5 >= 3 then
            CameraShake.Shake("CriticalHit");

            return;
        end;

        CameraShake.Shake("Hit");
    end);
end;