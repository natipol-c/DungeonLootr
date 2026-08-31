--[[
  Type:     LocalScript
  Method:   decompile
  Name:     FX_Listener
  Path:     game.StarterPlayer.StarterPlayerScripts.FX_Listener
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:19 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;
local u2 = nil;
LocalPlayer.CharacterAdded:Connect(function(u3: userdata) -- Line: 19, Name: BindCharacter
    -- upvalues: u1 (ref), u2 (ref)
    u1 = u3;
    u2 = u3:FindFirstChild("HumanoidRootPart");

    if not u2 then
        task.spawn(function() -- Line: 24
            -- upvalues: u3 (copy), u1 (ref), u2 (ref)
            local HumanoidRootPart = u3:WaitForChild("HumanoidRootPart", 30);

            if u1 == u3 then
                u2 = HumanoidRootPart;
            end;
        end);
    end;
end);

if LocalPlayer.Character then
    local Character = LocalPlayer.Character;
    u1 = Character;
    u2 = Character:FindFirstChild("HumanoidRootPart");

    if not u2 then
        task.spawn(function() -- Line: 24
            -- upvalues: Character (copy), u1 (ref), u2 (ref)
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 30);

            if u1 == Character then
                u2 = HumanoidRootPart;
            end;
        end);
    end;
end;

local FX = ReplicatedStorage:WaitForChild("Player"):WaitForChild("Remotes"):WaitForChild("FX");
local u4 = {};
local v5 = FX.OnClientEvent:Connect(function(...) -- Line: 46
    -- upvalues: u4 (ref)
    if u4 then
        table.insert(u4, table.pack(...));
    end;
end);
local Knit = require(ReplicatedStorage.Packages.Knit);
local Part_Icles = require(ReplicatedStorage:WaitForChild("Globals"):WaitForChild("Modules"):WaitForChild("Part_Icles"));
local SharedUtils = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("SharedUtils"));
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = nil;

local function GetSettingsController() -- Line: 64
    -- upvalues: u9 (ref), Knit (copy)
    if not u9 then
        local success, result = pcall(function() -- Line: 66
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u9 = result;
        end;
    end;

    return u9;
end;

local function ShouldShowVFX(p10: userdata) -- Line: 79
    -- upvalues: u9 (ref), Knit (copy), u1 (ref), LocalPlayer (copy)
    if p10:GetAttribute("Bypass_FX") then
        return true;
    end;

    if not u9 then
        local success, result = pcall(function() -- Line: 66
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u9 = result;
        end;
    end;

    local v11 = u9;

    if not v11 then
        return true;
    end;

    local v12 = v11:ShouldHideOtherVFX();
    local v13 = v11:ShouldHideSelfVFX();

    if not (v12 or v13) then
        return true;
    end;

    local v14 = u1 and p10:IsDescendantOf(u1) and true or false;
    local Attribute = p10:GetAttribute("OwnerUserId");

    if Attribute and Attribute == LocalPlayer.UserId and true or v14 then
        return not v13;
    end;

    return not v12;
end;

local function GetParticles(p15: userdata) -- Line: 112
    -- upvalues: u6 (copy)
    if u6[p15] then
        return u6[p15];
    end;

    local v16 = {};

    for _, descendant in p15:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            table.insert(v16, descendant);
        end;
    end;

    u6[p15] = v16;

    return v16;
end;

local function GetBeams(p17: userdata) -- Line: 128
    -- upvalues: u7 (copy)
    if u7[p17] then
        return u7[p17];
    end;

    local v18 = {};

    for _, descendant in p17:GetDescendants() do
        if descendant:IsA("Beam") then
            table.insert(v18, descendant);
        end;
    end;

    u7[p17] = v18;

    return v18;
end;

local function GetTrails(p19: userdata) -- Line: 144
    -- upvalues: u8 (copy)
    if u8[p19] then
        return u8[p19];
    end;

    local v20 = {};

    for _, descendant in p19:GetDescendants() do
        if descendant:IsA("Trail") then
            table.insert(v20, descendant);
        end;
    end;

    u8[p19] = v20;

    return v20;
end;

local function ClearCache(p21: userdata) -- Line: 160
    -- upvalues: u6 (copy), u7 (copy), u8 (copy)
    u6[p21] = nil;
    u7[p21] = nil;
    u8[p21] = nil;
end;

local function SuppressVFX(p22: userdata) -- Line: 169
    -- upvalues: GetParticles (copy), GetBeams (copy), GetTrails (copy)
    for _, v in GetParticles(p22) do
        if not v:GetAttribute("Ignore") then
            v.Enabled = false;
        end;
    end;

    for _, v in GetBeams(p22) do
        if not v:GetAttribute("Ignore") then
            v.Enabled = false;
        end;
    end;

    for _, v in GetTrails(p22) do
        if not v:GetAttribute("Ignore") then
            v.Enabled = false;
        end;
    end;
end;

local function GetObjectPosition(p23: userdata) -- Line: 191
    if p23:IsA("BasePart") then
        return p23.Position;
    end;

    if p23:IsA("PVInstance") then
        return p23:GetPivot().Position;
    end;

    return nil;
end;

local function Distance_Check(p24: userdata) -- Line: 200
    -- upvalues: u2 (ref), LocalPlayer (copy)
    if p24:GetAttribute("Bypass_FX") then
        return true;
    end;

    if not u2 then
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        u2 = Character;

        if not u2 then
            return true;
        end;
    end;

    local v25;

    if p24:IsA("BasePart") then
        v25 = p24.Position;
    elseif p24:IsA("PVInstance") then
        v25 = p24:GetPivot().Position;
    else
        v25 = nil;
    end;

    return not v25 and true or (u2.Position - v25).Magnitude <= 75;
end;

local function EmitParticles(p26: userdata) -- Line: 223
    -- upvalues: GetParticles (copy)
    for _, v in GetParticles(p26) do
        local Attribute = v:GetAttribute("EmitDelay");
        local Attribute2 = v:GetAttribute("EmitDuration");
        local u27 = v:GetAttribute("EmitCount") or 1;

        if Attribute and Attribute > 0 or Attribute2 and Attribute2 > 0 then
            task.spawn(function() -- Line: 230
                -- upvalues: Attribute (copy), Attribute2 (copy), v (copy), u27 (copy)
                if Attribute and Attribute > 0 then
                    task.wait(Attribute);
                end;

                if not Attribute2 or Attribute2 <= 0 then
                    v:Emit(u27);

                    return;
                end;

                v.Enabled = true;
                task.wait(Attribute2);
                v.Enabled = false;
            end);
        else
            v:Emit(u27);
        end;
    end;
end;

local function FireParticles(p28: userdata) -- Line: 246
    -- upvalues: u2 (ref), LocalPlayer (copy), ShouldShowVFX (copy), EmitParticles (copy), SharedUtils (copy)
    local v29;

    if p28:GetAttribute("Bypass_FX") then
        v29 = true;
    else
        local v30;

        if u2 then
            if p28:IsA("BasePart") then
                v30 = p28.Position;
            elseif p28:IsA("PVInstance") then
                v30 = p28:GetPivot().Position;
            else
                v30 = nil;
            end;

            v29 = not v30 and true or (u2.Position - v30).Magnitude <= 75;
        else
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            u2 = Character;

            if u2 then
                if p28:IsA("BasePart") then
                    v30 = p28.Position;
                elseif p28:IsA("PVInstance") then
                    v30 = p28:GetPivot().Position;
                else
                    v30 = nil;
                end;

                v29 = not v30 and true or (u2.Position - v30).Magnitude <= 75;
            else
                v29 = true;
            end;
        end;
    end;

    if not v29 then
        return;
    end;

    if not ShouldShowVFX(p28) then
        return;
    end;

    EmitParticles(p28);
    local Attribute = p28:GetAttribute("FireSound");

    if Attribute and p28:IsA("BasePart") then
        SharedUtils.PlaySoundAt(p28, Attribute, p28:GetAttribute("FireVolume") or 1);
    end;
end;

local function ActivateParticles(p31: userdata) -- Line: 263
    -- upvalues: u2 (ref), LocalPlayer (copy), ShouldShowVFX (copy), GetParticles (copy), GetBeams (copy), GetTrails (copy)
    local v32;

    if p31:GetAttribute("Bypass_FX") then
        v32 = true;
    else
        local v33;

        if u2 then
            if p31:IsA("BasePart") then
                v33 = p31.Position;
            elseif p31:IsA("PVInstance") then
                v33 = p31:GetPivot().Position;
            else
                v33 = nil;
            end;

            v32 = not v33 and true or (u2.Position - v33).Magnitude <= 75;
        else
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            u2 = Character;

            if u2 then
                if p31:IsA("BasePart") then
                    v33 = p31.Position;
                elseif p31:IsA("PVInstance") then
                    v33 = p31:GetPivot().Position;
                else
                    v33 = nil;
                end;

                v32 = not v33 and true or (u2.Position - v33).Magnitude <= 75;
            else
                v32 = true;
            end;
        end;
    end;

    if not v32 then
        return;
    end;

    if not ShouldShowVFX(p31) then
        return;
    end;

    for _, v in GetParticles(p31) do
        if not v:GetAttribute("Ignore") then
            v.Enabled = true;
        end;
    end;

    for _, v in GetBeams(p31) do
        if not v:GetAttribute("Ignore") then
            v.Enabled = true;
        end;
    end;

    for _, v in GetTrails(p31) do
        if not v:GetAttribute("Ignore") then
            v.Enabled = true;
        end;
    end;
end;

local function DeactivateParticles(p34: userdata) -- Line: 286
    -- upvalues: GetParticles (copy), GetBeams (copy), GetTrails (copy)
    for _, v in GetParticles(p34) do
        if not v:GetAttribute("Ignore") then
            v.Enabled = false;
        end;
    end;

    for _, v in GetBeams(p34) do
        if not v:GetAttribute("Ignore") then
            v.Enabled = false;
        end;
    end;

    for _, v in GetTrails(p34) do
        if not v:GetAttribute("Ignore") then
            v.Enabled = false;
        end;
    end;
end;

Part_Icles:Activate();
local Effects = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Effects");

local function GetOwnerHRP(p35: userdata) -- Line: 318
    local Parent = p35.Parent;

    while Parent do
        local v36 = Parent:IsA("Model") and Parent:FindFirstChild("HumanoidRootPart");

        if v36 then
            return v36;
        end;

        Parent = Parent.Parent;
    end;

    return nil;
end;

local function FirePartIcles(p37: userdata) -- Line: 330
    -- upvalues: ShouldShowVFX (copy), GetOwnerHRP (copy), u2 (ref), Effects (copy), Part_Icles (copy)
    if not ShouldShowVFX(p37) then
        return;
    end;

    local v38 = GetOwnerHRP(p37);

    if not v38 then
        return;
    end;

    if u2 and (u2.Position - v38.Position).Magnitude > 75 then
        return;
    end;

    local Attribute = p37:GetAttribute("PartIcle_EffectId");

    if not Attribute then
        return;
    end;

    local v39 = Effects:FindFirstChild(Attribute);

    if not v39 then
        return;
    end;

    local v40 = p37:GetAttribute("PartIcle_Lifetime") or 1;

    for _, child in v39:GetChildren() do
        local u41 = child:Clone();
        u41.Parent = workspace.Terrain;
        local v42 = v38.Position + Vector3.new(0, child.Name == "Compass Needle" and -3.2 or 0, 0);

        if u41:IsA("Model") then
            local Pivot = child:GetPivot();
            u41:PivotTo(CFrame.new(v42) * (Pivot - Pivot.Position));
        elseif u41:IsA("BasePart") then
            local CFrame2 = child.CFrame;
            u41.CFrame = CFrame.new(v42) * (CFrame2 - CFrame2.Position);
        end;

        Part_Icles:AbsoluteEmit(u41);
        task.delay(v40, function() -- Line: 362
            -- upvalues: u41 (copy)
            if u41 and u41.Parent then
                u41:Destroy();
            end;
        end);
    end;
end;

local u43 = {};
local u44 = {};

local function SetupListener(u45: userdata) -- Line: 374
    -- upvalues: u44 (copy), SetupListener (copy), u43 (copy), FireParticles (copy), ActivateParticles (copy), DeactivateParticles (copy), FirePartIcles (copy), ShouldShowVFX (copy), SuppressVFX (copy), u6 (copy), u7 (copy), u8 (copy)
    if not u45:IsDescendantOf(workspace) then
        if u44[u45] then
            return;
        end;

        local u46 = nil;
        u46 = u45.AncestryChanged:Connect(function() -- Line: 383
            -- upvalues: u45 (copy), u46 (ref), u44 (ref), SetupListener (ref)
            if u45:IsDescendantOf(workspace) then
                u46:Disconnect();
                u44[u45] = nil;
                SetupListener(u45);
            end;
        end);
        u44[u45] = u46;
        u45.Destroying:Once(function() -- Line: 391
            -- upvalues: u46 (ref), u44 (ref), u45 (copy)
            u46:Disconnect();
            u44[u45] = nil;
        end);

        return;
    end;

    if u43[u45] then
        return;
    end;

    local u47 = {};
    u43[u45] = u47;

    if u45:GetAttribute("Fire") ~= nil then
        u47.Triggered = u45:GetAttributeChangedSignal("Fire"):Connect(function() -- Line: 407
            -- upvalues: FireParticles (ref), u45 (copy)
            FireParticles(u45);
        end);
    else
        u47.Activated = u45:GetAttributeChangedSignal("FX_Activate"):Connect(function() -- Line: 412
            -- upvalues: u45 (copy), ActivateParticles (ref), DeactivateParticles (ref)
            if u45:GetAttribute("FX_Activate") then
                ActivateParticles(u45);

                return;
            end;

            DeactivateParticles(u45);
        end);
        u47.FireGuard = u45:GetAttributeChangedSignal("Fire"):Once(function() -- Line: 421
            -- upvalues: u47 (copy), u45 (copy), FireParticles (ref)
            if u47.Activated then
                u47.Activated:Disconnect();
                u47.Activated = nil;
            end;

            u47.Triggered = u45:GetAttributeChangedSignal("Fire"):Connect(function() -- Line: 427
                -- upvalues: FireParticles (ref), u45 (ref)
                FireParticles(u45);
            end);
        end);

        if u45:GetAttribute("FX_Activate") then
            task.defer(ActivateParticles, u45);
        end;
    end;

    if u45:GetAttribute("PartIcles_Fire") ~= nil then
        u47.PartIcle = u45:GetAttributeChangedSignal("PartIcles_Fire"):Connect(function() -- Line: 440
            -- upvalues: FirePartIcles (ref), u45 (copy)
            FirePartIcles(u45);
        end);
    end;

    if not ShouldShowVFX(u45) then
        SuppressVFX(u45);
        task.delay(0.2, function() -- Line: 450
            -- upvalues: u45 (copy), ShouldShowVFX (ref), SuppressVFX (ref)
            if u45 and (u45.Parent and not ShouldShowVFX(u45)) then
                SuppressVFX(u45);
            end;
        end);
    end;

    u47.Removed = u45.Destroying:Once(function() -- Line: 457
        -- upvalues: u47 (copy), u43 (ref), u45 (copy), u6 (ref), u7 (ref), u8 (ref)
        for _, v in u47 do
            v:Disconnect();
        end;

        u43[u45] = nil;
        local v48 = u45;
        u6[v48] = nil;
        u7[v48] = nil;
        u8[v48] = nil;
    end);
end;

CollectionService:GetInstanceAddedSignal("ParticleObject"):Connect(function(p49: userdata) -- Line: 467, Name: SetupListenerDeferred
    -- upvalues: SetupListener (copy)
    task.defer(SetupListener, p49);
end);

for _, v in CollectionService:GetTagged("ParticleObject") do
    if v:IsDescendantOf(workspace) then
        task.defer(SetupListener, v);
    end;
end;

LocalPlayer.CharacterAdded:Connect(function() -- Line: 483
    -- upvalues: Part_Icles (copy)
    Part_Icles:Deactivate();
    Part_Icles:Activate();
end);

local function OnVFXSettingsChanged() -- Line: 490
    -- upvalues: u43 (copy), ShouldShowVFX (copy), SuppressVFX (copy), ActivateParticles (copy)
    for i, _ in u43 do
        if i.Parent then
            if ShouldShowVFX(i) then
                if i:GetAttribute("FX_Activate") then
                    ActivateParticles(i);
                end;
            else
                SuppressVFX(i);
            end;
        end;
    end;
end;

task.defer(function() -- Line: 506
    -- upvalues: Knit (copy), OnVFXSettingsChanged (copy)
    local success, result = pcall(function() -- Line: 507
        -- upvalues: Knit (ref)
        return Knit.GetService("SettingsService");
    end);

    if not (success and result) then
        return;
    end;

    result.SettingChanged:Connect(function(p50, p51) -- Line: 512
        -- upvalues: OnVFXSettingsChanged (ref)
        if p50 == "HideOtherVFX" or p50 == "HideSelfVFX" then
            OnVFXSettingsChanged();
        end;
    end);
end);
local SFX = ReplicatedStorage:WaitForChild("Player"):WaitForChild("Remotes"):WaitForChild("SFX");
local Combat_Sounds = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Combat_Sounds");
local SFX2 = game:GetService("SoundService"):WaitForChild("SFX");
local u52 = {};
local table_create_ret = table.create(10);
local u53 = 0;
local u54 = 0;
RunService.Heartbeat:Connect(function() -- Line: 556
    -- upvalues: u54 (ref)
    u54 = 0;
end);

local function acquireCombatVoice() -- Line: 563
    -- upvalues: u53 (ref), table_create_ret (copy), SFX2 (copy)
    u53 = u53 + 1;

    if u53 > 10 then
        u53 = 1;
    end;

    local v55 = table_create_ret[u53];

    if not v55 or v55.Parent == nil then
        v55 = Instance.new("Sound");
        v55.Name = "CombatVoice";
        v55.SoundGroup = SFX2;
        table_create_ret[u53] = v55;
    end;

    return v55;
end;

SFX.OnClientEvent:Connect(function(p56, p57, p58) -- Line: 577
    -- upvalues: u2 (ref), u54 (ref), u52 (copy), Combat_Sounds (copy), u53 (ref), table_create_ret (copy), SFX2 (copy)
    if typeof(p57) ~= "Instance" or not p57:IsDescendantOf(workspace) then
        return;
    end;

    if u2 and (p57:IsA("BasePart") and (u2.Position - p57.Position).Magnitude > 100) then
        return;
    end;

    if u54 >= 3 then
        return;
    end;

    u54 = u54 + 1;
    local v59 = u52[p56];

    if not v59 then
        local v60 = Combat_Sounds:FindFirstChild(p56);
        v59 = v60 and v60:GetChildren() or {};
        u52[p56] = v59;
    end;

    if #v59 == 0 then
        return;
    end;

    local v61 = v59[math.random(1, #v59)];
    u53 = u53 + 1;

    if u53 > 10 then
        u53 = 1;
    end;

    local v62 = table_create_ret[u53];

    if not v62 or v62.Parent == nil then
        v62 = Instance.new("Sound");
        v62.Name = "CombatVoice";
        v62.SoundGroup = SFX2;
        table_create_ret[u53] = v62;
    end;

    v62.SoundId = v61.SoundId;
    v62.RollOffMode = v61.RollOffMode;
    v62.RollOffMinDistance = v61.RollOffMinDistance;
    v62.RollOffMaxDistance = v61.RollOffMaxDistance;
    v62.Volume = p58 or (v61.Volume or 1);
    v62.PlaybackSpeed = v61.PlaybackSpeed + (math.random() * 2 - 1) * 0.05;
    v62.Parent = p57;
    v62.TimePosition = 0;
    v62:Play();
end);
ReplicatedStorage:WaitForChild("Player"):WaitForChild("Remotes"):WaitForChild("SFX_Single").OnClientEvent:Connect(function(p63, p64, p65, p66) -- Line: 615
    -- upvalues: u2 (ref), SharedUtils (copy)
    if typeof(p63) ~= "Instance" or not p63:IsDescendantOf(workspace) then
        return;
    end;

    if u2 and (p63:IsA("BasePart") and (u2.Position - p63.Position).Magnitude > 100) then
        return;
    end;

    SharedUtils.PlaySoundAt(p63, p64, p65, p66);
end);
local u67 = {};
local u68 = {};
local u69 = {};

local function ReleaseOwner(p70: userdata) -- Line: 645
    -- upvalues: u67 (copy), u69 (copy), u68 (copy)
    local v71 = u67[p70];

    if v71 then
        for _, v in v71 do
            if v then
                v:Destroy();
            end;
        end;

        u67[p70] = nil;
    end;

    u69[p70] = nil;
    local v72 = u68[p70];

    if v72 then
        v72:Disconnect();
        u68[p70] = nil;
    end;
end;

local function ShouldShowForOwner(p73: userdata) -- Line: 663
    -- upvalues: u9 (ref), Knit (copy), u1 (ref), Players (copy), LocalPlayer (copy)
    if not u9 then
        local success, result = pcall(function() -- Line: 66
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u9 = result;
        end;
    end;

    local v74 = u9;

    if not v74 then
        return true;
    end;

    local v75 = v74:ShouldHideOtherVFX();
    local v76 = v74:ShouldHideSelfVFX();

    if not (v75 or v76) then
        return true;
    end;

    if p73 == u1 and true or Players:GetPlayerFromCharacter(p73) == LocalPlayer then
        return not v76;
    end;

    return not v75;
end;

local function FindWeaponPrefab(p77: userdata) -- Line: 676
    for _, child in p77:GetChildren() do
        if child:HasTag("Weapon_Prefab") then
            return child;
        end;
    end;

    for _, child in p77:GetChildren() do
        if child.Name ~= "Animations" and (child.Name ~= "Skill_Animations" and (child:IsA("BasePart") or child:IsA("Model"))) then
            return child;
        end;
    end;

    return nil;
end;

local function ResolveTemplate(p78: string, p79: string, p80: string) -- Line: 689
    -- upvalues: ReplicatedStorage (copy), FindWeaponPrefab (copy)
    if p78 == "Class" then
        local Classes = ReplicatedStorage:FindFirstChild("Classes");

        if Classes then
            Classes = Classes:FindFirstChild(p79);
        end;

        if Classes then
            Classes = Classes:FindFirstChild("Prefabs");
        end;

        if Classes then
            Classes = Classes:FindFirstChild("Holder");
        end;

        local v81;

        if Classes then
            v81 = Classes:FindFirstChild("FX");
        else
            v81 = Classes;
        end;

        if v81 then
            v81 = v81:FindFirstChild(p80);
        end;

        if Classes and (Classes:IsA("BasePart") and (v81 and v81:IsA("BasePart"))) then
            return Classes, v81;
        end;
    elseif p78 == "Asset" then
        local Assets = ReplicatedStorage:FindFirstChild("Assets");

        if Assets then
            Assets = Assets:FindFirstChild("Models");
        end;

        if Assets then
            Assets = Assets:FindFirstChild(p79);
        end;

        if Assets and Assets:IsA("BasePart") then
            return nil, Assets;
        end;
    elseif p78 == "Weapon" then
        local Weapons = ReplicatedStorage:FindFirstChild("Weapons");

        if Weapons then
            Weapons = Weapons:FindFirstChild(p79);
        end;

        if Weapons then
            Weapons = Weapons:FindFirstChild("Prefab");
        end;

        if Weapons then
            Weapons = FindWeaponPrefab(Weapons);
        end;

        if Weapons then
            local FX2 = Weapons:FindFirstChild("FX");

            if FX2 then
                FX2 = FX2:FindFirstChild(p80);
            end;

            local v82 = nil;

            if Weapons:IsA("BasePart") then
                v82 = Weapons;
            elseif Weapons:IsA("Model") then
                v82 = Weapons.PrimaryPart or Weapons:FindFirstChildWhichIsA("BasePart");
            end;

            if v82 and (v82:IsA("BasePart") and (FX2 and FX2:IsA("BasePart"))) then
                return v82, FX2;
            end;
        end;
    end;

    return nil, nil;
end;

local function GetRenderFXFolder(p83: userdata) -- Line: 737
    local FX2 = p83:FindFirstChild("FX");

    if not (FX2 and FX2:IsA("Folder")) then
        FX2 = Instance.new("Folder");
        FX2.Name = "FX";
        FX2.Parent = p83;
    end;

    return FX2;
end;

local function GetOrCreateClone(u84: userdata, p85: string, p86: string, p87: string) -- Line: 749
    -- upvalues: u69 (copy), ReleaseOwner (copy), u67 (copy), ResolveTemplate (copy), u68 (copy)
    if p85 == "Class" then
        local v88 = u69[u84];

        if v88 and v88 ~= p86 then
            ReleaseOwner(u84);
        end;
    end;

    local v89 = u67[u84];

    if v89 then
        local v90 = v89[p87];

        if v90 and v90.Parent then
            return v90;
        end;
    end;

    local HumanoidRootPart = u84:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return nil;
    end;

    local v91, v92 = ResolveTemplate(p85, p86, p87);

    if not v92 then
        return nil;
    end;

    local v93 = HumanoidRootPart.CFrame * (v91 and v91.CFrame or v92.CFrame):Inverse();
    local v94 = v92:Clone();
    v94:RemoveTag("ParticleObject");
    local v95 = {};

    if v94:IsA("BasePart") then
        v95[v94] = v94.CFrame;
    end;

    for _, descendant in v94:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant:RemoveTag("ParticleObject");
            v95[descendant] = descendant.CFrame;
        elseif descendant:IsA("WeldConstraint") or (descendant:IsA("Weld") or descendant:IsA("Motor6D")) then
            descendant:Destroy();
        elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant.Enabled = false;
        end;
    end;

    local FX2 = HumanoidRootPart:FindFirstChild("FX");

    if not (FX2 and FX2:IsA("Folder")) then
        FX2 = Instance.new("Folder");
        FX2.Name = "FX";
        FX2.Parent = HumanoidRootPart;
    end;

    v94.Parent = FX2;

    for i, v in v95 do
        i.Anchored = false;
        i.CanCollide = false;
        i.CanQuery = false;
        i.CFrame = v93 * v;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Name = "FXRender_Weld";
        WeldConstraint.Part0 = HumanoidRootPart;
        WeldConstraint.Part1 = i;
        WeldConstraint.Parent = i;
    end;

    if not v89 then
        v89 = {};
        u67[u84] = v89;
        u68[u84] = u84.Destroying:Once(function() -- Line: 819
            -- upvalues: ReleaseOwner (ref), u84 (copy)
            ReleaseOwner(u84);
        end);
    end;

    v89[p87] = v94;

    if p85 == "Class" then
        u69[u84] = p86;
    end;

    return v94;
end;

local function SetCloneEmitters(p96: userdata, p97: boolean) -- Line: 830
    for _, descendant in p96:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant.Enabled = p97;
        end;
    end;
end;

local function ReconcileLoopsFor(p98: userdata) -- Line: 840
    -- upvalues: Players (copy), u2 (ref), ShouldShowForOwner (copy), GetOrCreateClone (copy), SetCloneEmitters (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p98);

    if PlayerFromCharacter then
        PlayerFromCharacter = PlayerFromCharacter:GetAttribute("Current_Class");
    end;

    if not (PlayerFromCharacter and u2) then
        return;
    end;

    local HumanoidRootPart = p98:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if (u2.Position - HumanoidRootPart.Position).Magnitude > 75 then
        return;
    end;

    if not ShouldShowForOwner(p98) then
        return;
    end;

    for i, v in p98:GetAttributes() do
        if v and i:sub(1, 7) == "FXLoop_" then
            local v99 = GetOrCreateClone(p98, "Class", PlayerFromCharacter, i:sub(8));

            if v99 then
                SetCloneEmitters(v99, true);
            end;
        end;
    end;
end;

local function OnFXEvent(p100, p101, p102, p103, p104) -- Line: 856
    -- upvalues: u67 (copy), SetCloneEmitters (copy), u2 (ref), ShouldShowForOwner (copy), GetOrCreateClone (copy), EmitParticles (copy)
    if typeof(p100) ~= "Instance" or not p100:IsA("Model") then
        return;
    end;

    if typeof(p103) ~= "string" then
        return;
    end;

    if p104 == false then
        local v105 = u67[p100];

        if v105 then
            v105 = v105[p103];
        end;

        if v105 then
            SetCloneEmitters(v105, false);
        end;

        return;
    end;

    if not p100:IsDescendantOf(workspace) then
        return;
    end;

    local HumanoidRootPart = p100:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if u2 and (u2.Position - HumanoidRootPart.Position).Magnitude > 75 then
        return;
    end;

    if not ShouldShowForOwner(p100) then
        return;
    end;

    local v106 = GetOrCreateClone(p100, p101, p102, p103);

    if not v106 then
        return;
    end;

    if p104 == nil then
        EmitParticles(v106);

        return;
    end;

    SetCloneEmitters(v106, true);
end;

FX.OnClientEvent:Connect(OnFXEvent);

if v5 then
    v5:Disconnect();
end;

local v107 = u4;
u4 = nil;

if v107 then
    for _, v in v107 do
        OnFXEvent(table.unpack(v, 1, v.n));
    end;
end;

local function HookPlayer(u108: userdata) -- Line: 906
    -- upvalues: ReconcileLoopsFor (copy), ReleaseOwner (copy)
    u108.CharacterAdded:Connect(function(p109) -- Line: 907
        -- upvalues: ReconcileLoopsFor (ref)
        task.defer(ReconcileLoopsFor, p109);
    end);
    u108:GetAttributeChangedSignal("Current_Class"):Connect(function() -- Line: 915
        -- upvalues: u108 (copy), ReleaseOwner (ref)
        local Character = u108.Character;

        if Character then
            ReleaseOwner(Character);
        end;
    end);

    if u108.Character then
        task.defer(ReconcileLoopsFor, u108.Character);
    end;
end;

for _, v in Players:GetPlayers() do
    HookPlayer(v);
end;

Players.PlayerAdded:Connect(HookPlayer);