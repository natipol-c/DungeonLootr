--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PlacedEffectFX
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.PlacedEffectFX
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local LocalPlayer = Players.LocalPlayer;

local function resolveTemplate(p1: string) -- Line: 40
    -- upvalues: ReplicatedStorage (copy)
    local v2 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Effects");

    if v2 then
        v2 = v2:FindFirstChild(p1);
    end;

    if v2 and v2:IsA("BasePart") then
        return v2;
    end;

    return nil;
end;

return function(p3, p4) -- Line: 49
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), TweenService (copy), Debris (copy)
    local PlacedEffect = ReplicatedStorage.Player.Remotes:WaitForChild("PlacedEffect", 10);

    if PlacedEffect then
        PlacedEffect.OnClientEvent:Connect(function(p5) -- Line: 56
            -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), TweenService (ref), Debris (ref)
            if not (p5 and (p5.EffectName and p5.Position)) then
                return;
            end;

            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            if Character and (p5.Position - Character.Position).Magnitude > 250 then
                return;
            end;

            local EffectName = p5.EffectName;
            local v6 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Effects");

            if v6 then
                v6 = v6:FindFirstChild(EffectName);
            end;

            if not (v6 and v6:IsA("BasePart")) then
                v6 = nil;
            end;

            if not v6 then
                warn("[PlacedEffectFX] Effect template not found / not a BasePart:", p5.EffectName);

                return;
            end;

            local u7 = v6:Clone();
            u7.Anchored = true;
            u7.CanCollide = false;
            u7.CanQuery = false;
            u7.CanTouch = false;
            u7.Position = p5.Position;
            u7:SetAttribute("FX_Activate", true);
            u7.Parent = workspace;
            local u8 = p5.ShrinkDuration or 1;
            local v9 = p5.ShrinkStart or (p5.Lifetime or 5) - u8;
            local u10 = p5.FadeOutDelay or 2;
            task.delay(v9, function() -- Line: 90
                -- upvalues: u7 (copy), TweenService (ref), u8 (copy), Debris (ref), u10 (copy)
                if not (u7 and u7.Parent) then
                    return;
                end;

                local v11 = TweenService:Create(u7, TweenInfo.new(u8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Size = Vector3.new(0, 0, 0)
                });
                v11.Completed:Once(function() -- Line: 97
                    -- upvalues: u7 (ref), Debris (ref), u10 (ref)
                    if not (u7 and u7.Parent) then
                        return;
                    end;

                    u7:SetAttribute("FX_Activate", false);
                    Debris:AddItem(u7, u10);
                end);
                v11:Play();
            end);
            Debris:AddItem(u7, v9 + u8 + u10 + 1);
        end);

        return;
    end;

    warn("[PlacedEffectFX] PlacedEffect remote not found after 10s");
end;