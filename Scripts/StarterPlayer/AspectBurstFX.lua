--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AspectBurstFX
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.AspectBurstFX
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ForgeVFXUtil = require(ReplicatedStorage.Modules.ForgeVFXUtil);
local u1 = {};

local function getCleanTemplate(p2: string) -- Line: 39
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local v3 = u1[p2];

    if v3 then
        return v3;
    end;

    local v4 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Effects");

    if v4 then
        v4 = v4:FindFirstChild(p2);
    end;

    if not (v4 and v4:IsA("BasePart")) then
        return nil;
    end;

    local v5 = v4:Clone();
    v5:RemoveTag("ParticleObject");
    v5:SetAttribute("Fire", nil);
    v5:SetAttribute("FX_Activate", nil);

    for _, descendant in v5:GetDescendants() do
        if descendant:HasTag("ParticleObject") then
            descendant:RemoveTag("ParticleObject");
        end;
    end;

    u1[p2] = v5;

    return v5;
end;

return function(p6, p7) -- Line: 67
    -- upvalues: ReplicatedStorage (copy), ForgeVFXUtil (copy), getCleanTemplate (copy)
    local AspectBurst = ReplicatedStorage.Player.Remotes:WaitForChild("AspectBurst", 10);

    if not AspectBurst then
        warn("[AspectBurstFX] AspectBurst remote not found after 10s");

        return;
    end;

    ForgeVFXUtil.Init();
    AspectBurst.OnClientEvent:Connect(function(p8) -- Line: 77
        -- upvalues: getCleanTemplate (ref), ForgeVFXUtil (ref)
        if not (p8 and (p8.EffectName and p8.Position)) then
            return;
        end;

        local v9 = getCleanTemplate(p8.EffectName);

        if v9 then
            ForgeVFXUtil.Emit(v9, {
                CFrame = CFrame.new(p8.Position),
                MaxDistance = p8.MaxDistance or 250,
                Scale = p8.Scale
            });

            return;
        end;

        warn("[AspectBurstFX] Effect template not found / not a BasePart:", p8.EffectName);
    end);
end;