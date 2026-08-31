--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SpellBurstFX
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.SpellBurstFX
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local LocalPlayer = Players.LocalPlayer;

local function resolveTemplate(p1: string) -- Line: 44
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

local function EmitBurst(p3: userdata) -- Line: 56
    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("ParticleEmitter") and not descendant:GetAttribute("Ignore") then
            local Attribute = descendant:GetAttribute("EmitDelay");
            local Attribute2 = descendant:GetAttribute("EmitDuration");
            local u4 = descendant:GetAttribute("EmitCount") or 1;

            if Attribute and Attribute > 0 or Attribute2 and Attribute2 > 0 then
                task.spawn(function() -- Line: 66
                    -- upvalues: Attribute (copy), descendant (copy), Attribute2 (copy), u4 (copy)
                    if Attribute and Attribute > 0 then
                        task.wait(Attribute);
                    end;

                    if not descendant.Parent then
                        return;
                    end;

                    if not Attribute2 or Attribute2 <= 0 then
                        descendant:Emit(u4);

                        return;
                    end;

                    descendant.Enabled = true;
                    task.wait(Attribute2);
                    descendant.Enabled = false;
                end);
            else
                descendant:Emit(u4);
            end;
        end;
    end;
end;

return function(p5, p6) -- Line: 83
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), EmitBurst (copy), SharedUtils (copy), Debris (copy)
    local SpellBurst = ReplicatedStorage.Player.Remotes:WaitForChild("SpellBurst", 10);

    if SpellBurst then
        SpellBurst.OnClientEvent:Connect(function(p7) -- Line: 90
            -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), EmitBurst (ref), SharedUtils (ref), Debris (ref)
            if not (p7 and (p7.EffectName and p7.Position)) then
                return;
            end;

            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            if Character and (p7.Position - Character.Position).Magnitude > 250 then
                return;
            end;

            local EffectName = p7.EffectName;
            local v8 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Effects");

            if v8 then
                v8 = v8:FindFirstChild(EffectName);
            end;

            if not (v8 and v8:IsA("BasePart")) then
                v8 = nil;
            end;

            if not v8 then
                warn("[SpellBurstFX] Effect template not found / not a BasePart:", p7.EffectName);

                return;
            end;

            local v9 = v8:Clone();
            v9.Name = "SpellBurst_" .. p7.EffectName;
            v9.Anchored = true;
            v9.CanCollide = false;
            v9.CanQuery = false;
            v9.CanTouch = false;
            v9.CFrame = CFrame.new(p7.Position);
            v9:RemoveTag("ParticleObject");
            v9:SetAttribute("Fire", nil);
            v9:SetAttribute("FX_Activate", nil);

            for _, descendant in v9:GetDescendants() do
                if descendant:HasTag("ParticleObject") then
                    descendant:RemoveTag("ParticleObject");
                end;
            end;

            for _, descendant in v9:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            v9.Parent = workspace;
            EmitBurst(v9);

            if p7.SoundName then
                SharedUtils.PlaySoundAt(v9, p7.SoundName, p7.SoundVolume or 1);
            end;

            Debris:AddItem(v9, p7.Lifetime or 3);
        end);

        return;
    end;

    warn("[SpellBurstFX] SpellBurst remote not found after 10s");
end;