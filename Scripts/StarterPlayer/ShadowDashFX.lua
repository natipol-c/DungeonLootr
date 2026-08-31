--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ShadowDashFX
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.ShadowDashFX
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
local ShadowDash = ReplicatedStorage.Player.Remotes:WaitForChild("ShadowDash");
local u1 = {};

for _, v in { "Script", "LocalScript", "ModuleScript", "ParticleEmitter", "Fire", "Smoke", "Sparkles", "Trail", "Beam", "Sound", "BodyVelocity", "BodyForce", "BodyGyro", "BodyPosition", "LinearVelocity", "AlignPosition", "AlignOrientation", "VectorForce", "Attachment", "BillboardGui", "SurfaceGui", "ProximityPrompt", "ClickDetector", "Highlight", "SelectionBox", "ForceField", "Humanoid", "Animator", "AnimationController", "WeldConstraint" } do
    u1[v] = true;
end;

local function CreateShadowClone(u2: userdata, p3: number, p4, p5: vector?) -- Line: 70
    -- upvalues: u1 (copy), TweenService (copy), Debris (copy)
    if not (u2 and u2.PrimaryPart) then
        return;
    end;

    local v6 = {};

    if not u2.Archivable then
        v6[u2] = false;
        u2.Archivable = true;
    end;

    for _, descendant in u2:GetDescendants() do
        if not descendant.Archivable then
            v6[descendant] = false;
            descendant.Archivable = true;
        end;
    end;

    local success, result = pcall(function() -- Line: 88
        -- upvalues: u2 (copy)
        return u2:Clone();
    end);

    for i, _ in v6 do
        if i and i.Parent then
            i.Archivable = false;
        end;
    end;

    if not (success and result) then
        warn("[ShadowDashFX] Clone failed:", result);

        return;
    end;

    result.Name = "ShadowClone";

    for _, descendant in result:GetDescendants() do
        if u1[descendant.ClassName] then
            descendant:Destroy();
        elseif descendant:IsA("Decal") or (descendant:IsA("Texture") or descendant:IsA("SurfaceAppearance")) then
            descendant:Destroy();
        end;
    end;

    local v7 = {};

    for _, descendant in result:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.CastShadow = false;
            descendant.Material = Enum.Material.SmoothPlastic;
            descendant.Color = p4 or Color3.new(0, 0, 0);

            if descendant.Transparency < 1 then
                descendant.Transparency = 0.5;
                table.insert(v7, descendant);
            end;

            local v8 = descendant:FindFirstChildWhichIsA("SpecialMesh") or descendant:FindFirstChildWhichIsA("FileMesh");

            if v8 then
                v8.TextureId = "";
            end;
        end;
    end;

    for _, descendant in result:GetDescendants() do
        if descendant:IsA("MeshPart") then
            descendant.TextureID = "";
        end;
    end;

    result.PrimaryPart = nil;
    result.Parent = workspace;

    if p5 and p5.Magnitude > 0 then
        for _, descendant in result:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CFrame = descendant.CFrame + p5;
            end;
        end;
    end;

    local TweenInfo_new_ret = TweenInfo.new(p3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);

    for _, v in v7 do
        TweenService:Create(v, TweenInfo_new_ret, {
            Transparency = 1
        }):Play();
    end;

    Debris:AddItem(result, p3 + 0.1);
end;

return function(p9, p10) -- Line: 186
    -- upvalues: ShadowDash (copy), LocalPlayer (copy), CreateShadowClone (copy)
    ShadowDash.OnClientEvent:Connect(function(p11: userdata, p12: any) -- Line: 187
        -- upvalues: LocalPlayer (ref), CreateShadowClone (ref)
        if not p12 or p12.Action ~= "Clone" then
            return;
        end;

        local v13;

        if p12.NPCModel and p12.NPCModel.Parent then
            v13 = p12.NPCModel;
        else
            if not (p11 and p11.Character) then
                return;
            end;

            v13 = p11.Character;
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        local HumanoidRootPart = v13:FindFirstChild("HumanoidRootPart");

        if Character and (HumanoidRootPart and (HumanoidRootPart.Position - Character.Position).Magnitude > 150) then
            return;
        end;

        CreateShadowClone(v13, p12.FadeDuration or 0.6, p12.Color, p12.Offset);
    end);
end;