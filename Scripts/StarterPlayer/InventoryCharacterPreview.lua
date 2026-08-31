--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     InventoryCharacterPreview
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.InventoryCharacterPreview
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local CosmeticData = require(ReplicatedStorage.GameInfo.CosmeticData);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local Cosmetic_Manager = require(ReplicatedStorage.Globals.Modules.Cosmetic_Manager);
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
local CosmeticViewport = require(script.Parent.Parent.ClientUtils.CosmeticViewport);
local u1 = {};
local CFrame_new_ret = CFrame.new(Vector3.new(0, 0.5, -12), Vector3.new(0, 0.5, 0));
local CFrame_new_ret2 = CFrame.new(0, 0.5, 0);
local u2 = {
    [Enum.AccessoryType.Hair] = true,
    [Enum.AccessoryType.Face] = true
};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = false;
local u12 = {};
local u13 = 0;

local function GetCosmeticSlotFrame(p14: string) -- Line: 79
    -- upvalues: u6 (ref), CosmeticData (copy)
    if u6 then
        return u6:FindFirstChild(CosmeticData.SLOT_FRAME[p14] or p14);
    end;

    return nil;
end;

function u1.GetSlotView(p15: string) -- Line: 85
    -- upvalues: u6 (ref), CosmeticData (copy)
    local v16;

    if u6 then
        v16 = u6:FindFirstChild(CosmeticData.SLOT_FRAME[p15] or p15);
    else
        v16 = nil;
    end;

    if v16 then
        v16 = v16:FindFirstChild("View");
    end;

    return v16;
end;

local function RenderEquippedCosmeticSlot(p17: string, p18: string?) -- Line: 94
    -- upvalues: u6 (ref), CosmeticData (copy), CosmeticViewport (copy)
    local v19;

    if u6 then
        v19 = u6:FindFirstChild(CosmeticData.SLOT_FRAME[p17] or p17);
    else
        v19 = nil;
    end;

    if not v19 then
        return;
    end;

    local View = v19:FindFirstChild("View");
    local v20 = View and View:FindFirstChild("ItemImage") or v19:FindFirstChild("ItemImage");
    local v21 = View and View:FindFirstChild("ViewportFrame") or v19:FindFirstChild("ViewportFrame");
    local v22 = View and View:FindFirstChild("PlaceHolder") or v19:FindFirstChild("PlaceHolder");

    if p18 and p18 ~= "" then
        local v23;

        if v21 then
            v23 = CosmeticViewport.Load(v21, p18, p17);
            v21.Visible = v23;
        else
            v23 = false;
        end;

        if v23 then
            if v20 then
                v20.Visible = false;
            end;

            if v22 then
                v22.Visible = false;
            end;
        else
            local v24 = CosmeticData.Get(p18);
            local v25 = v24 and v24.Icon or "";

            if v20 and (v25 ~= "" and v25 ~= "rbxassetid://0") then
                v20.Image = v25;
                v20.Visible = true;

                if v22 then
                    v22.Visible = false;
                end;
            else
                if v20 then
                    v20.Visible = false;
                end;

                if v22 then
                    v22.Visible = true;
                end;
            end;
        end;
    else
        if v21 then
            v21:ClearAllChildren();
            v21.Visible = false;
        end;

        if v20 then
            v20.Image = "";
            v20.Visible = false;
        end;

        if v22 then
            v22.Visible = true;
        end;
    end;
end;

function u1.RefreshCosmetics() -- Line: 141
    -- upvalues: u6 (ref), u4 (ref), CosmeticData (copy), RenderEquippedCosmeticSlot (copy)
    if not u6 then
        return;
    end;

    local v26 = u4.Data.CosmeticSlots or {};

    for _, v in CosmeticData.Slots do
        RenderEquippedCosmeticSlot(v, v26[v]);
    end;
end;

local function SetupCosmeticInfo() -- Line: 149
    -- upvalues: u6 (ref), u5 (ref), CosmeticData (copy), u3 (ref), u1 (copy)
    local v27 = u5 and u5:FindFirstChild("Equipped_Cosmetics");
    u6 = v27;

    if not u6 then
        return;
    end;

    u6.Visible = false;

    for _, v in CosmeticData.Slots do
        local v28;

        if u6 then
            v28 = u6:FindFirstChild(CosmeticData.SLOT_FRAME[v] or v);
        else
            v28 = nil;
        end;

        if v28 then
            local v29 = v28:FindFirstChild("View") or v28;
            local SelectButton = v29:FindFirstChild("SelectButton");

            if not SelectButton then
                SelectButton = Instance.new("TextButton");
                SelectButton.Name = "SelectButton";
                SelectButton.BackgroundTransparency = 1;
                SelectButton.Text = "";
                SelectButton.Size = UDim2.fromScale(1, 1);
                SelectButton.ZIndex = v29.ZIndex + 5;
                SelectButton.Parent = v29;
            end;

            SelectButton.MouseButton1Click:Connect(function() -- Line: 175
                -- upvalues: u3 (ref), v (copy)
                u3.OnCosmeticSlotClicked(v);
            end);
            SelectButton.MouseButton2Click:Connect(function() -- Line: 179
                -- upvalues: u3 (ref), v (copy)
                u3.OnCosmeticSlotRightClicked(v);
            end);
        end;
    end;

    u1.RefreshCosmetics();
end;

function u1.SetVanityView(p30: boolean) -- Line: 195
    -- upvalues: u6 (ref), u7 (ref)
    if u6 then
        u6.Visible = p30;
    end;

    if u7 then
        u7.Visible = p30;
    end;
end;

function u1.RefreshClassIcon() -- Line: 207
    -- upvalues: u8 (ref), u4 (ref), Class_Data (copy), Image_Data (copy)
    if not u8 then
        return;
    end;

    local v31 = u4.Data.ActiveClass or "";
    local v32 = v31 ~= "" and Class_Data[v31] or nil;
    local v33 = v32 and Image_Data.GetClassIcon(v32.DamageType) or nil;

    if not v33 then
        u8.Visible = false;

        return;
    end;

    u8.Image = v33;
    u8.Visible = true;
end;

local function GetClassIdleAnim(p34: string) -- Line: 227
    -- upvalues: Class_Data (copy)
    local v35 = Class_Data[p34];

    if v35 and (v35.AnimationOverrides and v35.AnimationOverrides.idle) then
        return v35.AnimationOverrides.idle;
    end;

    return nil;
end;

local function PreserveAvatarHairAndFace(p36: userdata) -- Line: 239
    -- upvalues: u2 (copy)
    for _, child in p36:GetChildren() do
        if child:IsA("Accessory") and (u2[child.AccessoryType] and not child:HasTag("Cosmetic")) then
            local Handle = child:FindFirstChild("Handle");

            if Handle then
                Handle.Transparency = 0;
            end;
        end;
    end;
end;

local function ApplyPreviewCosmetics(p37: userdata) -- Line: 254
    -- upvalues: Cosmetic_Manager (copy), u4 (ref), SharedUtils (copy), PreserveAvatarHairAndFace (copy)
    Cosmetic_Manager.ClearAll(p37);
    Cosmetic_Manager.ApplyAll(p37, u4.Data.CosmeticSlots or {});
    SharedUtils.SnapViewportAccessories(p37);
    PreserveAvatarHairAndFace(p37);
end;

local function ClearCharacterViewport() -- Line: 262
    -- upvalues: u10 (ref), u9 (ref)
    if u10 then
        if u10.animTrack then
            u10.animTrack:Stop();
        end;

        if u10.worldModel and u10.worldModel.Parent then
            u10.worldModel:Destroy();
        end;

        u10 = nil;
    end;

    if u9 then
        for _, child in u9:GetChildren() do
            if child:IsA("WorldModel") or (child:IsA("Camera") or child:IsA("Model")) then
                child:Destroy();
            end;
        end;
    end;
end;

local function BuildCharacterViewport() -- Line: 282
    -- upvalues: ClearCharacterViewport (copy), u9 (ref), LocalPlayer (copy), CFrame_new_ret2 (copy), ApplyPreviewCosmetics (copy), CFrame_new_ret (copy), Class_Data (copy), ReplicatedStorage (copy), u10 (ref), u11 (ref)
    ClearCharacterViewport();

    if not (u9 and u9.Parent) then
        return;
    end;

    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v38 = {};

    for _, descendant in Character:GetDescendants() do
        if not descendant.Archivable then
            descendant.Archivable = true;
            table.insert(v38, descendant);
        end;
    end;

    local Archivable = Character.Archivable;
    Character.Archivable = true;
    local v39 = Character:Clone();
    Character.Archivable = Archivable;

    for _, v in v38 do
        v.Archivable = false;
    end;

    for _, descendant in v39:GetDescendants() do
        if descendant:IsA("BaseScript") or (descendant:IsA("Tool") or (descendant:IsA("ForceField") or descendant:IsA("BillboardGui"))) then
            descendant:Destroy();
        end;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "CharacterWorld";
    WorldModel.Parent = u9;
    v39:PivotTo(CFrame_new_ret2);
    v39.Parent = WorldModel;
    pcall(ApplyPreviewCosmetics, v39);
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 30;
    Camera.CFrame = CFrame_new_ret;
    Camera.Parent = u9;
    u9.CurrentCamera = Camera;
    local v40 = nil;
    local v41 = v39:FindFirstChildOfClass("Humanoid");
    local v42;

    if v41 then
        local u43 = v41:FindFirstChildOfClass("Animator");

        if not u43 then
            u43 = Instance.new("Animator");
            u43.Parent = v41;
        end;

        local v44 = Class_Data[LocalPlayer:GetAttribute("Stat_ActiveClass") or ""];
        local v45;

        if v44 and (v44.AnimationOverrides and v44.AnimationOverrides.idle) then
            v45 = v44.AnimationOverrides.idle;
        else
            v45 = nil;
        end;

        local u46;

        if v45 then
            u46 = Instance.new("Animation");
            u46.AnimationId = v45;
        else
            u46 = ReplicatedStorage:FindFirstChild("Assets");

            if u46 then
                u46 = u46:FindFirstChild("Idle_Animations");
            end;

            if u46 then
                u46 = u46:FindFirstChild("Hitman_Idle");
            end;
        end;

        if u46 then
            local v47;
            v47, v42 = pcall(function() -- Line: 357
                -- upvalues: u43 (ref), u46 (ref)
                return u43:LoadAnimation(u46);
            end);

            if v47 and v42 then
                v42.Looped = true;
                v42:Play();
            else
                v42 = v40;
            end;
        else
            v42 = v40;
        end;
    else
        v42 = v40;
    end;

    u10 = {
        clone = v39,
        worldModel = WorldModel,
        camera = Camera,
        animTrack = v42
    };

    if u11 and v42 then
        v42:AdjustSpeed(0);
    end;
end;

function u1.RefreshViewportCosmetics() -- Line: 383
    -- upvalues: u10 (ref), BuildCharacterViewport (copy), ApplyPreviewCosmetics (copy)
    if u10 and (u10.clone and u10.clone.Parent) then
        pcall(ApplyPreviewCosmetics, u10.clone);

        return;
    end;

    BuildCharacterViewport();
end;

local function SetViewportPaused(p48: boolean) -- Line: 392
    -- upvalues: u11 (ref), u10 (ref)
    u11 = p48;

    if u10 and u10.animTrack then
        u10.animTrack:AdjustSpeed(p48 and 0 or 1);
    end;
end;

function u1.RebuildDeferred() -- Line: 404
    -- upvalues: u13 (ref), BuildCharacterViewport (copy)
    u13 = u13 + 1;
    local u49 = u13;
    task.delay(0.5, function() -- Line: 407
        -- upvalues: u49 (copy), u13 (ref), BuildCharacterViewport (ref)
        if u49 == u13 then
            BuildCharacterViewport();
        end;
    end);
end;

local function SetupCharacterViewport() -- Line: 414
    -- upvalues: u5 (ref), u9 (ref), u7 (ref), u8 (ref), u1 (copy), u3 (ref), u11 (ref), u12 (copy), u10 (ref), LocalPlayer (copy), BuildCharacterViewport (copy)
    if not u5 then
        return;
    end;

    u9 = u5:FindFirstChild("Viewport");
    u7 = u5:FindFirstChild("Vanity");
    u8 = u5:FindFirstChild("Class_Icon");
    u1.SetVanityView(true);
    u1.RefreshClassIcon();

    if not u9 then
        return;
    end;

    local InventoryFrame = u3.InventoryFrame;
    u11 = not InventoryFrame.Visible;
    local PropertyChangedSignal = InventoryFrame:GetPropertyChangedSignal("Visible");
    table.insert(u12, PropertyChangedSignal:Connect(function() -- Line: 434
        -- upvalues: InventoryFrame (copy), u11 (ref), u10 (ref)
        local v50 = not InventoryFrame.Visible;
        u11 = v50;

        if u10 and u10.animTrack then
            u10.animTrack:AdjustSpeed(v50 and 0 or 1);
        end;
    end));
    table.insert(u12, LocalPlayer.CharacterAdded:Connect(u1.RebuildDeferred));
    BuildCharacterViewport();
end;

function u1.Setup(p51) -- Line: 449
    -- upvalues: u3 (ref), u4 (ref), u5 (ref), SetupCosmeticInfo (copy), SetupCharacterViewport (copy)
    u3 = p51;
    u4 = u3.PlayerData;
    u5 = u3.CharacterInfoFrame;
    SetupCosmeticInfo();
    SetupCharacterViewport();
end;

function u1.Destroy() -- Line: 458
    -- upvalues: ClearCharacterViewport (copy), u12 (copy), u11 (ref)
    ClearCharacterViewport();

    for _, v in u12 do
        v:Disconnect();
    end;

    table.clear(u12);
    u11 = false;
end;

return u1;