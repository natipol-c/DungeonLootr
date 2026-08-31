--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cosmetic_Manager
  Path:     game.ReplicatedStorage.Globals.Modules.Cosmetic_Manager
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticData = require(ReplicatedStorage.GameInfo.CosmeticData);
local RigMap = require(ReplicatedStorage.Globals.Modules.RigMap);
local u1 = {};
local u2 = {
    Head = {
        Enum.AccessoryType.Hat,
        Enum.AccessoryType.Hair,
        Enum.AccessoryType.Face,
        Enum.AccessoryType.Eyebrow,
        Enum.AccessoryType.Eyelash
    },
    Body = {
        Enum.AccessoryType.TShirt,
        Enum.AccessoryType.Shirt,
        Enum.AccessoryType.Jacket,
        Enum.AccessoryType.Sweater,
        Enum.AccessoryType.Front
    },
    Shoulder = { Enum.AccessoryType.Shoulder },
    Back = { Enum.AccessoryType.Back },
    Bottom = {
        Enum.AccessoryType.Pants,
        Enum.AccessoryType.Shorts,
        Enum.AccessoryType.DressSkirt,
        Enum.AccessoryType.LeftShoe,
        Enum.AccessoryType.RightShoe,
        Enum.AccessoryType.Waist
    },
    Aura = {}
};
local u3 = {
    ParticleEmitter = true,
    Trail = true,
    Beam = true,
    Fire = true,
    Smoke = true,
    Sparkles = true,
    PointLight = true,
    SpotLight = true,
    SurfaceLight = true
};
local u4 = {
    Head = "HeadColor3",
    Torso = "TorsoColor3",
    ["Left Arm"] = "LeftArmColor3",
    ["Right Arm"] = "RightArmColor3",
    ["Left Leg"] = "LeftLegColor3",
    ["Right Leg"] = "RightLegColor3"
};

local function SlotTag(p5: string) -- Line: 100
    return "Cosmetic_" .. p5;
end;

local function GetSetFolder(p6: string) -- Line: 105
    -- upvalues: ReplicatedStorage (copy)
    local Assets = ReplicatedStorage:FindFirstChild("Assets");

    if not Assets then
        warn("[Cosmetic_Manager] Missing Assets folder");

        return nil;
    end;

    local Cosmetics = Assets:FindFirstChild("Cosmetics");

    if not Cosmetics then
        warn("[Cosmetic_Manager] Missing Assets.Cosmetics folder");

        return nil;
    end;

    local v7 = Cosmetics:FindFirstChild(p6);

    if v7 then
        return v7;
    end;

    warn("[Cosmetic_Manager] Set folder not found:", p6);

    return nil;
end;

local function FindPiecesForSlot(p8: userdata, p9: table) -- Line: 126
    local v10 = {};

    for _, v in p9 do
        v10[v] = true;
    end;

    local v11 = {};

    for _, child in p8:GetChildren() do
        if child:HasTag("Cosmetic") then
            local Attribute = child:GetAttribute("Location");

            if Attribute and v10[Attribute] then
                table.insert(v11, {
                    piece = child,
                    location = Attribute
                });
            end;
        end;
    end;

    return v11;
end;

local function ApplyAdaptiveColor(p12: userdata, p13: userdata, p14: string) -- Line: 153
    -- upvalues: u4 (copy)
    local v15 = u4[p14];

    if not v15 then
        return;
    end;

    local v16 = p13:FindFirstChildOfClass("BodyColors");

    if not v16 then
        return;
    end;

    local v17 = v16[v15];

    if p12:IsA("BasePart") and p12:HasTag("AdaptiveColor") then
        p12.Color = v17;
    end;

    for _, descendant in p12:GetDescendants() do
        if descendant:IsA("BasePart") and descendant:HasTag("AdaptiveColor") then
            descendant.Color = v17;
        end;
    end;
end;

local function AttachAccessory(p18: userdata, p19: userdata, p20: string, p21: string) -- Line: 175
    -- upvalues: CollectionService (copy), ApplyAdaptiveColor (copy)
    local v22 = p19:FindFirstChildOfClass("Humanoid");

    if not v22 then
        warn("[Cosmetic_Manager] No Humanoid for Accessory attach");

        return false;
    end;

    local v23 = p18:Clone();
    CollectionService:AddTag(v23, p21);
    ApplyAdaptiveColor(v23, p19, p20);
    v22:AddAccessory(v23);

    return true;
end;

local function AttachWeldPart(p24: userdata, p25: userdata, p26: string, p27: string) -- Line: 191
    -- upvalues: RigMap (copy), CollectionService (copy), ApplyAdaptiveColor (copy)
    if not p25:FindFirstChild("HumanoidRootPart") then
        warn("[Cosmetic_Manager] No HumanoidRootPart for weld attach");

        return false;
    end;

    local WeldTarget, v28 = RigMap.GetWeldTarget(p25, p26);

    if not WeldTarget then
        warn("[Cosmetic_Manager] Character limb not found:", p26);

        return false;
    end;

    local v29 = p24:Clone();
    CollectionService:AddTag(v29, p27);
    ApplyAdaptiveColor(v29, p25, p26);
    v29.Parent = WeldTarget;

    if v29:IsA("BasePart") then
        local Weld = Instance.new("Weld");
        Weld.Name = "CosmeticWeld";
        Weld.Part0 = WeldTarget;
        Weld.Part1 = v29;

        if v28 then
            Weld.C0 = v28.CFrame;
            v29.CFrame = WeldTarget.CFrame * v28.CFrame;
        else
            v29.CFrame = WeldTarget.CFrame;
        end;

        Weld.Parent = v29;
    elseif v29:IsA("Model") then
        local v30 = v29.PrimaryPart or v29:FindFirstChildWhichIsA("BasePart");

        if not v30 then
            warn("[Cosmetic_Manager] Part_Cosmetic model has no BasePart:", p24.Name);
            v29:Destroy();

            return false;
        end;

        local Weld = Instance.new("Weld");
        Weld.Name = "CosmeticWeld";
        Weld.Part0 = WeldTarget;
        Weld.Part1 = v30;

        if v28 then
            Weld.C0 = v28.CFrame;
            v30.CFrame = WeldTarget.CFrame * v28.CFrame;
        else
            v30.CFrame = WeldTarget.CFrame;
        end;

        Weld.Parent = v30;
    end;

    return true;
end;

local function ToggleEffect(p31: userdata, p32: boolean) -- Line: 250
    if p32 then
        if p31.Enabled then
            p31:SetAttribute("_CosmeticHidEffect", true);
            p31.Enabled = false;
        end;
    elseif p31:GetAttribute("_CosmeticHidEffect") ~= nil then
        p31.Enabled = true;
        p31:SetAttribute("_CosmeticHidEffect", nil);
    end;
end;

local function IsGameManagedPiece(p33: userdata) -- Line: 266
    -- upvalues: CosmeticData (copy)
    if p33:HasTag("Class_Prefab") then
        return true;
    end;

    for _, v in CosmeticData.Slots do
        if p33:HasTag("Cosmetic_" .. v) then
            return true;
        end;
    end;

    return false;
end;

local function SetAccessoryEffectsHidden(p34: userdata, p35: boolean) -- Line: 277
    -- upvalues: u3 (copy)
    for _, descendant in p34:GetDescendants() do
        if u3[descendant.ClassName] then
            if p35 then
                if descendant.Enabled then
                    descendant:SetAttribute("_CosmeticHidEffect", true);
                    descendant.Enabled = false;
                end;
            elseif descendant:GetAttribute("_CosmeticHidEffect") ~= nil then
                descendant.Enabled = true;
                descendant:SetAttribute("_CosmeticHidEffect", nil);
            end;
        end;
    end;
end;

local function SetLimbEffectsHidden(p36: userdata, p37: boolean) -- Line: 288
    -- upvalues: IsGameManagedPiece (copy), u3 (copy)
    for _, child in p36:GetChildren() do
        if not IsGameManagedPiece(child) then
            if u3[child.ClassName] then
                if p37 then
                    if child.Enabled then
                        child:SetAttribute("_CosmeticHidEffect", true);
                        child.Enabled = false;
                    end;
                elseif child:GetAttribute("_CosmeticHidEffect") ~= nil then
                    child.Enabled = true;
                    child:SetAttribute("_CosmeticHidEffect", nil);
                end;
            end;

            for _, descendant in child:GetDescendants() do
                if u3[descendant.ClassName] then
                    if p37 then
                        if descendant.Enabled then
                            descendant:SetAttribute("_CosmeticHidEffect", true);
                            descendant.Enabled = false;
                        end;
                    elseif descendant:GetAttribute("_CosmeticHidEffect") ~= nil then
                        descendant.Enabled = true;
                        descendant:SetAttribute("_CosmeticHidEffect", nil);
                    end;
                end;
            end;
        end;
    end;
end;

local function SetSlotLimbTransparency(p38: userdata, p39: string, p40: number) -- Line: 305
    -- upvalues: CosmeticData (copy), RigMap (copy), SetLimbEffectsHidden (copy)
    local LocationsForSlot = CosmeticData.GetLocationsForSlot(p39);

    if not LocationsForSlot then
        return;
    end;

    local v41 = p40 >= 1;

    for _, v in LocationsForSlot do
        for _, v2 in RigMap.GetLimbParts(p38, v) do
            v2.Transparency = p40;
            SetLimbEffectsHidden(v2, v41);
        end;
    end;
end;

local function SlotWantsHide(p42: table) -- Line: 321
    for _, v in p42 do
        if v.piece:GetAttribute("Hide") == true then
            return true;
        end;
    end;

    return false;
end;

local function IsAnyCosmeticAccessory(p43: userdata) -- Line: 331
    -- upvalues: CosmeticData (copy)
    for _, v in CosmeticData.Slots do
        if p43:HasTag("Cosmetic_" .. v) then
            return true;
        end;
    end;

    return false;
end;

local function SetSlotAccessoryTransparency(p44: userdata, p45: string, p46: number) -- Line: 342
    -- upvalues: u2 (copy), IsAnyCosmeticAccessory (copy), SetAccessoryEffectsHidden (copy)
    local v47 = u2[p45];

    if not v47 or #v47 == 0 then
        return;
    end;

    local v48 = {};

    for _, v in v47 do
        v48[v] = true;
    end;

    local v49 = p46 >= 1;

    for _, child in p44:GetChildren() do
        if child:IsA("Accessory") and (not IsAnyCosmeticAccessory(child) and v48[child.AccessoryType]) then
            local Handle = child:FindFirstChild("Handle");

            if Handle then
                Handle.Transparency = p46;
            end;

            SetAccessoryEffectsHidden(child, v49);
        end;
    end;
end;

local u50 = setmetatable({}, {
    __mode = "k"
});

local function HideSlotTag(p51: string) -- Line: 379
    return "CosmeticHide_" .. p51;
end;

local function OnCharacterChildAdded(p52: userdata, p53: userdata) -- Line: 385
    -- upvalues: IsAnyCosmeticAccessory (copy), u2 (copy), SetAccessoryEffectsHidden (copy)
    if not p53:IsA("Accessory") then
        return;
    end;

    if IsAnyCosmeticAccessory(p53) then
        return;
    end;

    for i, v in u2 do
        if p52:HasTag("CosmeticHide_" .. i) then
            for _, v2 in v do
                if p53.AccessoryType == v2 then
                    local Handle = p53:FindFirstChild("Handle");

                    if Handle then
                        Handle.Transparency = 1;
                    end;

                    SetAccessoryEffectsHidden(p53, true);

                    return;
                end;
            end;
        end;
    end;
end;

local function EnsureHideListener(u54: userdata) -- Line: 406
    -- upvalues: u50 (copy), OnCharacterChildAdded (copy)
    if u50[u54] then
        return;
    end;

    u50[u54] = u54.ChildAdded:Connect(function(p55) -- Line: 409
        -- upvalues: OnCharacterChildAdded (ref), u54 (copy)
        OnCharacterChildAdded(u54, p55);
    end);
end;

local function CleanupHideListener(p56: userdata) -- Line: 415
    -- upvalues: CosmeticData (copy), u50 (copy)
    for _, v in CosmeticData.Slots do
        if p56:HasTag("CosmeticHide_" .. v) then
            return;
        end;
    end;

    local v57 = u50[p56];

    if v57 then
        v57:Disconnect();
        u50[p56] = nil;
    end;
end;

function u1.ApplySlot(u58: userdata, p59: string, p60: string) -- Line: 439
    -- upvalues: CosmeticData (copy), GetSetFolder (copy), u1 (copy), FindPiecesForSlot (copy), AttachAccessory (copy), AttachWeldPart (copy), SetSlotLimbTransparency (copy), SetSlotAccessoryTransparency (copy), CollectionService (copy), u50 (copy), OnCharacterChildAdded (copy)
    local LocationsForSlot = CosmeticData.GetLocationsForSlot(p59);

    if not LocationsForSlot then
        warn("[Cosmetic_Manager] Invalid slot:", p59);

        return false;
    end;

    local v61 = GetSetFolder(p60);

    if not v61 then
        return false;
    end;

    u1.ClearSlot(u58, p59);
    local v62 = "Cosmetic_" .. p59;
    local v63 = FindPiecesForSlot(v61, LocationsForSlot);

    if #v63 == 0 then
        warn("[Cosmetic_Manager] No pieces found for slot", p59, "in set", p60);

        return false;
    end;

    local v64 = false;

    for _, v in v63 do
        local piece = v.piece;
        local location = v.location;
        local v65 = false;

        if piece:HasTag("Accessory") then
            v65 = AttachAccessory(piece, u58, location, v62);
        elseif piece:HasTag("Part_Cosmetic") then
            v65 = AttachWeldPart(piece, u58, location, v62);
        else
            warn("[Cosmetic_Manager] Piece has no type tag (Accessory/Part_Cosmetic):", piece.Name);
        end;

        if v65 then
            v64 = true;
        end;
    end;

    if v64 then
        local v66 = false;

        for _, v in v63 do
            if v.piece:GetAttribute("Hide") == true then
                v66 = true;
                break;
            end;
        end;

        if v66 then
            SetSlotLimbTransparency(u58, p59, 1);
            SetSlotAccessoryTransparency(u58, p59, 1);
            CollectionService:AddTag(u58, "CosmeticHide_" .. p59);

            if u50[u58] then
                return v64;
            end;

            u50[u58] = u58.ChildAdded:Connect(function(p67) -- Line: 409
                -- upvalues: OnCharacterChildAdded (ref), u58 (copy)
                OnCharacterChildAdded(u58, p67);
            end);
        end;
    end;

    return v64;
end;

function u1.ClearSlot(p68: userdata, p69: string) -- Line: 496
    -- upvalues: CollectionService (copy), SetSlotLimbTransparency (copy), SetSlotAccessoryTransparency (copy), CleanupHideListener (copy)
    CollectionService:RemoveTag(p68, "CosmeticHide_" .. p69);
    SetSlotLimbTransparency(p68, p69, 0);
    SetSlotAccessoryTransparency(p68, p69, 0);
    CleanupHideListener(p68);

    for _, v in CollectionService:GetTagged("Cosmetic_" .. p69) do
        if v:IsDescendantOf(p68) then
            v:Destroy();
        end;
    end;
end;

function u1.ClearAll(p70: userdata) -- Line: 514
    -- upvalues: CosmeticData (copy), u1 (copy)
    for _, v in CosmeticData.Slots do
        u1.ClearSlot(p70, v);
    end;
end;

function u1.ApplyAll(p71: userdata, p72: table) -- Line: 524
    -- upvalues: CosmeticData (copy), u1 (copy)
    for _, v in CosmeticData.Slots do
        local v73 = p72[v];

        if v73 and v73 ~= "" then
            u1.ApplySlot(p71, v, v73);
        end;
    end;
end;

function u1.SetHasSlot(p74: string, p75: string) -- Line: 539
    -- upvalues: CosmeticData (copy), GetSetFolder (copy), FindPiecesForSlot (copy)
    local LocationsForSlot = CosmeticData.GetLocationsForSlot(p75);

    if not LocationsForSlot then
        return false;
    end;

    local v76 = GetSetFolder(p74);

    if v76 then
        return #FindPiecesForSlot(v76, LocationsForSlot) > 0;
    end;

    return false;
end;

return u1;