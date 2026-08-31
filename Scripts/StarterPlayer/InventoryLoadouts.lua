--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     InventoryLoadouts
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.InventoryLoadouts
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local LoadoutData = require(GameInfo:WaitForChild("LoadoutData"));
local CosmeticData = require(GameInfo:WaitForChild("CosmeticData"));
local EquipmentData = require(GameInfo:WaitForChild("EquipmentData"));
local EquipmentTemplates = require(GameInfo:WaitForChild("EquipmentTemplates"));
local Image_Data = require(GameInfo:WaitForChild("Image_Data"));
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local CosmeticViewport = require(script.Parent.Parent.ClientUtils.CosmeticViewport);
local u1 = {};
local u2 = {
    Head = "Head",
    Body = "Body",
    Shoulder = "Arms",
    Back = "Back",
    Bottom = "Legs",
    Aura = "Aura"
};
local Color3_fromRGB_ret = Color3.fromRGB(85, 255, 127);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 80, 80);
local Color3_fromRGB_ret3 = Color3.fromRGB(80, 20, 20);
local Color3_fromRGB_ret4 = Color3.fromRGB(120, 120, 120);
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local Color3_new_ret = Color3.new(1, 1, 1);
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = "Equipment";
local u21 = {};
local u22 = false;
local u23 = false;
local u24 = false;

local function Trim(p25: string) -- Line: 88
    return p25:match("^%s*(.-)%s*$") or p25;
end;

local function PlaySound(u26: string) -- Line: 92
    -- upvalues: u19 (ref)
    if u19 then
        pcall(function() -- Line: 94
            -- upvalues: u19 (ref), u26 (copy)
            u19:Play(u26);
        end);
    end;
end;

local function NotifyError(p27: string) -- Line: 98
    -- upvalues: u17 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    if u17 then
        u17:Show("Custom", p27, 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
    end;
end;

local function CapacityFor(p28: string) -- Line: 105
    -- upvalues: u4 (ref), LoadoutData (copy)
    local Loadouts = u4.Data.Loadouts;

    if not Loadouts then
        return LoadoutData.FREE_SLOTS;
    end;

    if p28 == "Equipment" then
        return Loadouts.EquipmentCapacity or LoadoutData.FREE_SLOTS;
    end;

    return Loadouts.CosmeticCapacity or LoadoutData.FREE_SLOTS;
end;

local function ResolveEquipmentItem(p29: string) -- Line: 116
    -- upvalues: u4 (ref), LoadoutData (copy)
    if p29 == "" then
        return nil;
    end;

    local Data = u4.Data;

    for _, v in LoadoutData.EquipmentSlots do
        local v30 = Data.Equipment and Data.Equipment[v];

        if type(v30) == "table" and v30.GUID == p29 then
            return v30;
        end;
    end;

    if Data.EquipmentInventory then
        for _, v in Data.EquipmentInventory do
            if type(v) == "table" and v.GUID == p29 then
                return v;
            end;
        end;
    end;

    return nil;
end;

local function EquipmentIcon(p31) -- Line: 131
    -- upvalues: Image_Data (copy), EquipmentTemplates (copy)
    if not p31 then
        return "";
    end;

    local v32 = Image_Data.Equipment and Image_Data.Equipment[p31.ItemId];

    if v32 then
        return v32;
    end;

    local Template = EquipmentTemplates.GetTemplate(p31.ItemId);

    return Template and Template.ImageId or "";
end;

local function IsLoadoutEquipped(p33: string, p34: userdata) -- Line: 140
    -- upvalues: u4 (ref), LoadoutData (copy), CosmeticData (copy)
    if not p34.Saved then
        return false;
    end;

    local Data = u4.Data;

    if p33 == "Equipment" then
        for _, v in LoadoutData.EquipmentSlots do
            local v35 = Data.Equipment and Data.Equipment[v];

            if (type(v35) == "table" and (v35.GUID or "") or "") ~= (p34.Items[v] or "") then
                return false;
            end;
        end;

        return true;
    end;

    local v36 = Data.CosmeticSlots or {};

    for _, v in CosmeticData.Slots do
        if (v36[v] or "") ~= (p34.Sets[v] or "") then
            return false;
        end;
    end;

    return true;
end;

local function RenderEquipmentMiniSlot(p37: userdata, p38: string) -- Line: 162
    -- upvalues: RarityGradient (copy), ResolveEquipmentItem (copy), Color3_fromRGB_ret4 (copy), Image_Data (copy), EquipmentTemplates (copy)
    local View = p37:FindFirstChild("View");
    local v39 = View and View:FindFirstChild("ItemImage") or p37:FindFirstChild("ItemImage");
    local v40;

    if View then
        v40 = View:FindFirstChild("ViewportFrame");
    else
        v40 = View;
    end;

    local v41 = View and View:FindFirstChild("PlaceHolder") or p37:FindFirstChild("PlaceHolder");

    if View then
        View = View:FindFirstChild("Background");
    end;

    if v40 then
        v40.Visible = false;
    end;

    if p38 == "" then
        if v39 then
            v39.Image = "";
            v39.Visible = false;
        end;

        if v41 then
            v41.Visible = true;
        end;

        if View then
            View.ImageColor3 = Color3.new(1, 1, 1);
            RarityGradient.set(View, nil);
        end;

        return;
    end;

    local v42 = ResolveEquipmentItem(p38);

    if v42 then
        local v43;

        if v42 then
            v43 = Image_Data.Equipment and Image_Data.Equipment[v42.ItemId];

            if not v43 then
                local Template = EquipmentTemplates.GetTemplate(v42.ItemId);
                v43 = Template and Template.ImageId or "";
            end;
        else
            v43 = "";
        end;

        if View then
            View.ImageColor3 = Color3.new(1, 1, 1);
            RarityGradient.set(View, v42.Rarity);
        end;

        if v43 == "" or not v39 then
            if v39 then
                v39.Visible = false;
            end;

            if v41 then
                v41.Visible = true;
            end;
        else
            v39.Image = v43;
            v39.Visible = true;

            if v41 then
                v41.Visible = false;

                return;
            end;
        end;

        return;
    end;

    if v39 then
        v39.Visible = false;
    end;

    if v41 then
        v41.Visible = true;
    end;

    if View then
        View.ImageColor3 = Color3_fromRGB_ret4;
        RarityGradient.set(View, nil);
    end;
end;

local function RenderCosmeticMiniSlot(p44: userdata, p45: string, p46: string) -- Line: 211
    -- upvalues: CosmeticViewport (copy), CosmeticData (copy)
    local View = p44:FindFirstChild("View");
    local v47 = View and View:FindFirstChild("ItemImage") or p44:FindFirstChild("ItemImage");
    local v48 = View and View:FindFirstChild("ViewportFrame") or p44:FindFirstChild("ViewportFrame");
    local v49 = View and View:FindFirstChild("PlaceHolder") or p44:FindFirstChild("PlaceHolder");

    if p46 ~= "" then
        local v50;

        if v48 then
            v50 = CosmeticViewport.Load(v48, p46, p45);
            v48.Visible = v50;
        else
            v50 = false;
        end;

        if v50 then
            if v47 then
                v47.Visible = false;
            end;

            if v49 then
                v49.Visible = false;

                return;
            end;
        else
            local v51 = CosmeticData.Get(p46);
            local v52 = v51 and v51.Icon or "";

            if v47 and (v52 ~= "" and v52 ~= "rbxassetid://0") then
                v47.Image = v52;
                v47.Visible = true;

                if v49 then
                    v49.Visible = false;

                    return;
                end;
            else
                if v47 then
                    v47.Visible = false;
                end;

                if v49 then
                    v49.Visible = true;
                end;
            end;
        end;

        return;
    end;

    if v48 then
        v48:ClearAllChildren();
        v48.Visible = false;
    end;

    if v47 then
        v47.Image = "";
        v47.Visible = false;
    end;

    if v49 then
        v49.Visible = true;
    end;
end;

local function RenderCardContents(p53: userdata, p54: string, p55: userdata) -- Line: 247
    -- upvalues: LoadoutData (copy), RenderEquipmentMiniSlot (copy), ResolveEquipmentItem (copy), EquipmentData (copy), CosmeticData (copy), u2 (copy), RenderCosmeticMiniSlot (copy)
    local Equipped = p53:FindFirstChild("Equipped");

    if not Equipped then
        return;
    end;

    if p54 == "Equipment" then
        for _, v in LoadoutData.EquipmentSlots do
            local v56 = Equipped:FindFirstChild(v);

            if v56 then
                RenderEquipmentMiniSlot(v56, p55.Items[v] or "");
            end;
        end;

        local Gearscore = p53:FindFirstChild("Gearscore");

        if Gearscore then
            local v57 = 0;

            for _, v in LoadoutData.EquipmentSlots do
                local v58 = ResolveEquipmentItem(p55.Items[v] or "");

                if v58 then
                    v57 = v57 + EquipmentData.ComputeItemGearScore(v58);
                end;
            end;

            Gearscore.Text = tostring(v57);
        end;
    else
        for _, v in CosmeticData.Slots do
            local v59 = Equipped:FindFirstChild(u2[v] or v);

            if v59 then
                RenderCosmeticMiniSlot(v59, v, p55.Sets[v] or "");
            end;
        end;
    end;
end;

local function SetupRename(p60: userdata, u61: string, u62: number, u63: userdata) -- Line: 284
    -- upvalues: u22 (ref), LoadoutData (copy), u17 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), u16 (ref), u19 (ref), u1 (copy)
    local Title = p60:FindFirstChild("Title");
    local TitleTextBox = p60:FindFirstChild("TitleTextBox");
    local EditName = p60:FindFirstChild("EditName");
    local NameConfirm = p60:FindFirstChild("NameConfirm");
    local NameCancel = p60:FindFirstChild("NameCancel");

    if not (Title and (TitleTextBox and (EditName and (NameConfirm and NameCancel)))) then
        return;
    end;

    TitleTextBox.Visible = false;
    NameConfirm.Visible = false;
    NameCancel.Visible = false;
    EditName.Visible = true;
    local u64 = false;

    local function exitEditVisual() -- Line: 300
        -- upvalues: u22 (ref), TitleTextBox (copy), NameConfirm (copy), NameCancel (copy), Title (copy), EditName (copy)
        u22 = false;
        TitleTextBox.Visible = false;
        NameConfirm.Visible = false;
        NameCancel.Visible = false;
        Title.Visible = true;
        EditName.Visible = true;
    end;

    local function cancelEdit() -- Line: 309
        -- upvalues: u64 (ref), u22 (ref), TitleTextBox (copy), NameConfirm (copy), NameCancel (copy), Title (copy), EditName (copy)
        if u64 then
            return;
        end;

        u64 = true;
        u22 = false;
        TitleTextBox.Visible = false;
        NameConfirm.Visible = false;
        NameCancel.Visible = false;
        Title.Visible = true;
        EditName.Visible = true;
    end;

    local function commit() -- Line: 315
        -- upvalues: u64 (ref), TitleTextBox (copy), u22 (ref), NameConfirm (copy), NameCancel (copy), Title (copy), EditName (copy), LoadoutData (ref), u17 (ref), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret3 (ref), u16 (ref), u61 (copy), u62 (copy), u19 (ref), u1 (ref)
        if u64 then
            return;
        end;

        u64 = true;
        local Text = TitleTextBox.Text;
        local v65 = Text:match("^%s*(.-)%s*$") or Text;

        if #v65 == 0 then
            u22 = false;
            TitleTextBox.Visible = false;
            NameConfirm.Visible = false;
            NameCancel.Visible = false;
            Title.Visible = true;
            EditName.Visible = true;

            return;
        end;

        if (utf8.len(v65) or #v65) > LoadoutData.MAX_NAME_LENGTH then
            local v66 = `Loadout names are capped at {LoadoutData.MAX_NAME_LENGTH} characters.`;

            if u17 then
                u17:Show("Custom", v66, 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
            end;

            u64 = false;
            TitleTextBox:CaptureFocus();

            return;
        end;

        local v67, v68, v69 = u16:RenameLoadout(u61, u62, v65):await();

        if v67 and (v68 and type(v69) == "string") then
            if u19 then
                local u70 = "UI_Begin";
                pcall(function() -- Line: 94
                    -- upvalues: u19 (ref), u70 (copy)
                    u19:Play(u70);
                end);
            end;
        elseif u17 then
            u17:Show("Custom", "Couldn\'t save that loadout name.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
        end;

        u22 = false;
        TitleTextBox.Visible = false;
        NameConfirm.Visible = false;
        NameCancel.Visible = false;
        Title.Visible = true;
        EditName.Visible = true;
        u1._Render();
    end;

    EditName.MouseButton1Click:Connect(function() -- Line: 344
        -- upvalues: u22 (ref), u64 (ref), Title (copy), EditName (copy), TitleTextBox (copy), u63 (copy), NameConfirm (copy), NameCancel (copy)
        if u22 then
            return;
        end;

        u22 = true;
        u64 = false;
        Title.Visible = false;
        EditName.Visible = false;
        TitleTextBox.Text = u63.Name == "" and "" or (u63.Name or "");
        TitleTextBox.Visible = true;
        NameConfirm.Visible = true;
        NameCancel.Visible = true;
        TitleTextBox:CaptureFocus();
    end);
    TitleTextBox.FocusLost:Connect(function(p71) -- Line: 357
        -- upvalues: u64 (ref), commit (copy), u22 (ref), TitleTextBox (copy), NameConfirm (copy), NameCancel (copy), Title (copy), EditName (copy)
        if u64 then
            return;
        end;

        if p71 then
            commit();

            return;
        end;

        task.defer(function() -- Line: 364
            -- upvalues: u64 (ref), u22 (ref), TitleTextBox (ref), NameConfirm (ref), NameCancel (ref), Title (ref), EditName (ref)
            if not u64 then
                if u64 then
                    return;
                end;

                u64 = true;
                u22 = false;
                TitleTextBox.Visible = false;
                NameConfirm.Visible = false;
                NameCancel.Visible = false;
                Title.Visible = true;
                EditName.Visible = true;
            end;
        end);
    end);
    NameConfirm.MouseButton1Click:Connect(commit);
    NameCancel.MouseButton1Click:Connect(cancelEdit);
end;

local function DescribeSlots(p72: table) -- Line: 376
    local v73 = {};

    for _, v in p72 do
        local v74;

        if type(v) == "table" then
            v74 = v.Slot or v;
        else
            v74 = v;
        end;

        table.insert(v73, v74);
    end;

    return table.concat(v73, ", ");
end;

local function DoSave(p75: string, p76: number) -- Line: 387
    -- upvalues: u16 (ref), u19 (ref), u17 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    local v77, v78, v79 = u16:SaveLoadout(p75, p76):await();

    if v77 and v78 then
        if u19 then
            local u80 = "Equip";
            pcall(function() -- Line: 94
                -- upvalues: u19 (ref), u80 (copy)
                u19:Play(u80);
            end);
        end;
    elseif v79 == "NothingEquipped" then
        if u17 then
            u17:Show("Custom", "Equip something first, then save it to this loadout.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
        end;
    elseif v79 == "AlreadySaved" then
        if u17 then
            u17:Show("Custom", "Reset this loadout before saving over it.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
        end;
    elseif u17 then
        u17:Show("Custom", "Couldn\'t save loadout.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
    end;
end;

local function DoEquip(p81: string, p82: number) -- Line: 400
    -- upvalues: u16 (ref), u17 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), u19 (ref), DescribeSlots (copy)
    local v83, v84, v85 = u16:EquipLoadout(p81, p82):await();

    if not (v83 and v84) then
        if u17 then
            u17:Show("Custom", "Couldn\'t equip loadout.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
        end;

        return;
    end;

    if u19 then
        local u86 = "Equip";
        pcall(function() -- Line: 94
            -- upvalues: u19 (ref), u86 (copy)
            u19:Play(u86);
        end);
    end;

    if type(v85) == "table" then
        local v87 = {};

        if v85.Missing and #v85.Missing > 0 then
            local v88 = "no longer owned: " .. DescribeSlots(v85.Missing);
            table.insert(v87, v88);
        end;

        if v85.Failed and #v85.Failed > 0 then
            local v89 = "couldn\'t equip: " .. DescribeSlots(v85.Failed);
            table.insert(v87, v89);
        end;

        if #v87 > 0 then
            local v90 = "Loadout equipped — " .. table.concat(v87, "; ") .. ".";

            if u17 then
                u17:Show("Custom", v90, 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
            end;
        end;
    end;
end;

local function DoUnequip(p91: string, p92: number) -- Line: 421
    -- upvalues: u16 (ref), u19 (ref), u17 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    local v93, v94, v95 = u16:UnequipLoadout(p91, p92):await();

    if v93 and v94 then
        if u19 then
            local u96 = "Equip";
            pcall(function() -- Line: 94
                -- upvalues: u19 (ref), u96 (copy)
                u19:Play(u96);
            end);
        end;
    elseif v95 == "InventoryFull" then
        if u17 then
            u17:Show("Custom", "Inventory is full — make room before unequipping.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
        end;
    elseif u17 then
        u17:Show("Custom", "Couldn\'t unequip loadout.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
    end;
end;

local function DoReset(p97: string, p98: number) -- Line: 432
    -- upvalues: u18 (ref), u16 (ref), u19 (ref), u17 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    if not u18 then
        return;
    end;

    if not u18:Prompt({
        Message = "Reset this loadout? Its saved items will be cleared (the name is kept).",
        ConfirmText = "Reset",
        DenyText = "Cancel"
    }) then
        return;
    end;

    local v99, v100 = u16:ResetLoadout(p97, p98):await();

    if v99 and v100 then
        if u19 then
            local u101 = "UI_Begin";
            pcall(function() -- Line: 94
                -- upvalues: u19 (ref), u101 (copy)
                u19:Play(u101);
            end);
        end;
    elseif u17 then
        u17:Show("Custom", "Couldn\'t reset loadout.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
    end;
end;

local function RunAction(p102: function) -- Line: 449
    -- upvalues: u23 (ref)
    if u23 then
        return;
    end;

    u23 = true;
    local success, result = pcall(p102);
    u23 = false;

    if not success then
        warn("[InventoryLoadouts] action error:", result);
    end;
end;

local function SetupCard(p103: userdata, u104: string, u105: number, u106: userdata) -- Line: 461
    -- upvalues: IsLoadoutEquipped (copy), Color3_fromRGB_ret (copy), Color3_new_ret (ref), DoSave (copy), u16 (ref), u19 (ref), u17 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), DoEquip (copy), u23 (ref), DoReset (copy), RenderCardContents (copy), SetupRename (copy)
    local v107 = u106.Saved == true;
    local v108 = IsLoadoutEquipped(u104, u106);
    local Title = p103:FindFirstChild("Title");

    if Title then
        if u106.Name == "" then
            Title.Text = "Loadout #" .. u105;
            Title.TextColor3 = Color3_new_ret;
        else
            Title.Text = u106.Name;
            Title.TextColor3 = Color3_fromRGB_ret;
        end;
    end;

    local v109 = p103:FindFirstChild("Save/Equip");
    local v110;

    if v109 then
        v110 = v109:FindFirstChild("TextLabel");
    else
        v110 = v109;
    end;

    if v110 then
        if v107 then
            if v108 then
                v110.Text = "Unequip";
            else
                v110.Text = "Equip";
            end;
        else
            v110.Text = "Save";
        end;
    end;

    if v109 then
        v109.MouseButton1Click:Connect(function() -- Line: 490
            -- upvalues: u106 (copy), DoSave (ref), u104 (copy), u105 (copy), IsLoadoutEquipped (ref), u16 (ref), u19 (ref), u17 (ref), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret3 (ref), DoEquip (ref), u23 (ref)
            local function v115() -- Line: 491
                -- upvalues: u106 (ref), DoSave (ref), u104 (ref), u105 (ref), IsLoadoutEquipped (ref), u16 (ref), u19 (ref), u17 (ref), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret3 (ref), DoEquip (ref)
                if u106.Saved then
                    if IsLoadoutEquipped(u104, u106) then
                        local v111, v112, v113 = u16:UnequipLoadout(u104, u105):await();

                        if v111 and v112 then
                            if u19 then
                                local u114 = "Equip";
                                pcall(function() -- Line: 94
                                    -- upvalues: u19 (ref), u114 (copy)
                                    u19:Play(u114);
                                end);

                                return;
                            end;
                        elseif v113 == "InventoryFull" then
                            if u17 then
                                u17:Show("Custom", "Inventory is full — make room before unequipping.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");

                                return;
                            end;
                        elseif u17 then
                            u17:Show("Custom", "Couldn\'t unequip loadout.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");

                            return;
                        end;
                    else
                        DoEquip(u104, u105);
                    end;

                    return;
                end;

                DoSave(u104, u105);
            end;

            if u23 then
                return;
            end;

            u23 = true;
            local success, result = pcall(v115);
            u23 = false;

            if not success then
                warn("[InventoryLoadouts] action error:", result);
            end;
        end);
    end;

    local Reset = p103:FindFirstChild("Reset");

    if Reset then
        Reset.Visible = v107;
        Reset.MouseButton1Click:Connect(function() -- Line: 507
            -- upvalues: DoReset (ref), u104 (copy), u105 (copy), u23 (ref)
            local function v116() -- Line: 508
                -- upvalues: DoReset (ref), u104 (ref), u105 (ref)
                DoReset(u104, u105);
            end;

            if u23 then
                return;
            end;

            u23 = true;
            local success, result = pcall(v116);
            u23 = false;

            if not success then
                warn("[InventoryLoadouts] action error:", result);
            end;
        end);
    end;

    local Status = p103:FindFirstChild("Status");

    if Status then
        Status.Visible = v107 and v108;
    end;

    RenderCardContents(p103, u104, u106);
    SetupRename(p103, u104, u105, u106);
end;

local function ClearCards() -- Line: 526
    -- upvalues: u21 (copy)
    for _, v in u21 do
        v:Destroy();
    end;

    table.clear(u21);
end;

function u1._Render() -- Line: 535
    -- upvalues: u22 (ref), u7 (ref), u4 (ref), u12 (ref), u20 (ref), u13 (ref), u21 (copy), LoadoutData (copy), u9 (ref), u10 (ref), SetupCard (copy), u8 (ref), u14 (ref), u11 (ref), u15 (ref)
    if u22 then
        return;
    end;

    if not (u7 and u4.Data.Loadouts) then
        return;
    end;

    if u12 then
        local Active = u12:FindFirstChild("Active");
        local Inactive = u12:FindFirstChild("Inactive");

        if Active then
            Active.Visible = u20 == "Equipment";
        end;

        if Inactive then
            Inactive.Visible = u20 ~= "Equipment";
        end;
    end;

    if u13 then
        local Active = u13:FindFirstChild("Active");
        local Inactive = u13:FindFirstChild("Inactive");

        if Active then
            Active.Visible = u20 == "Cosmetics";
        end;

        if Inactive then
            Inactive.Visible = u20 ~= "Cosmetics";
        end;
    end;

    for _, v in u21 do
        v:Destroy();
    end;

    table.clear(u21);
    local v117 = u20;
    local Loadouts = u4.Data.Loadouts;
    local v118;

    if Loadouts then
        if v117 == "Equipment" then
            v118 = Loadouts.EquipmentCapacity or LoadoutData.FREE_SLOTS;
        else
            v118 = Loadouts.CosmeticCapacity or LoadoutData.FREE_SLOTS;
        end;
    else
        v118 = LoadoutData.FREE_SLOTS;
    end;

    local math_clamp_ret = math.clamp(v118, LoadoutData.FREE_SLOTS, LoadoutData.MAX_SLOTS);
    local v119 = u4.Data.Loadouts[v117] or {};
    local v120 = v117 == "Equipment" and u9 or u10;

    if not v120 then
        return;
    end;

    local v121 = v117 == "Equipment" and LoadoutData.NewEquipmentEntry or LoadoutData.NewCosmeticEntry;

    for i = 1, math_clamp_ret do
        local v122 = v119[i] or v121();
        local v123 = v120:Clone();
        v123.Name = "Loadout_" .. i;
        v123.LayoutOrder = i;
        v123.Visible = true;
        SetupCard(v123, v117, i, v122);
        v123.Parent = u8;
        table.insert(u21, v123);
        local _ = i;
    end;

    if u14 then
        u14.Text = string.format("%d/%d", math_clamp_ret, LoadoutData.MAX_SLOTS);
    end;

    if u11 then
        local v124 = LoadoutData.MAX_SLOTS <= math_clamp_ret;
        u11.Visible = not v124;
        u11.LayoutOrder = 999;

        if not v124 then
            local NextSlotCost = LoadoutData.GetNextSlotCost(math_clamp_ret);
            local CoinAmount = u11:FindFirstChild("CoinAmount");

            if CoinAmount and NextSlotCost then
                CoinAmount.Text = tostring(NextSlotCost);
            end;
        end;
    end;

    if u15 then
        u15.Visible = math_clamp_ret < LoadoutData.MAX_SLOTS;
    end;
end;

local function QueueRender() -- Line: 599
    -- upvalues: u24 (ref), u1 (copy)
    if u24 then
        return;
    end;

    u24 = true;
    task.defer(function() -- Line: 602
        -- upvalues: u24 (ref), u1 (ref)
        u24 = false;
        u1._Render();
    end);
end;

function u1.Show() -- Line: 610
    -- upvalues: u7 (ref), u6 (ref), u1 (copy)
    if not u7 then
        return;
    end;

    if u6 then
        u6.Visible = false;
    end;

    u7.Visible = true;
    u1._Render();
end;

function u1.Hide() -- Line: 617
    -- upvalues: u7 (ref), u6 (ref)
    if not u7 then
        return;
    end;

    u7.Visible = false;

    if u6 then
        u6.Visible = true;
    end;
end;

local function SetTab(p125: string) -- Line: 623
    -- upvalues: u20 (ref), u1 (copy)
    if u20 == p125 then
        return;
    end;

    u20 = p125;
    u1._Render();
end;

local function DoBuySlot() -- Line: 629
    -- upvalues: u18 (ref), u20 (ref), u4 (ref), LoadoutData (copy), u17 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), u16 (ref), u19 (ref)
    if not u18 then
        return;
    end;

    local v126 = u20;
    local Loadouts = u4.Data.Loadouts;
    local v127;

    if Loadouts then
        if v126 == "Equipment" then
            v127 = Loadouts.EquipmentCapacity or LoadoutData.FREE_SLOTS;
        else
            v127 = Loadouts.CosmeticCapacity or LoadoutData.FREE_SLOTS;
        end;
    else
        v127 = LoadoutData.FREE_SLOTS;
    end;

    if LoadoutData.MAX_SLOTS <= v127 then
        if u17 then
            u17:Show("Custom", "You\'ve unlocked all loadout slots for this category.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
        end;

        return;
    end;

    local NextSlotCost = LoadoutData.GetNextSlotCost(v127);

    if not NextSlotCost then
        return;
    end;

    if not u18:Prompt({
        ConfirmText = "Buy",
        DenyText = "Cancel",
        Message = string.format("Buy 1 more %s loadout slot (%d → %d) for <b>%s Coins</b>?", u20 == "Equipment" and "equipment" or "cosmetic", v127, v127 + 1, (tostring(NextSlotCost)))
    }) then
        return;
    end;

    local v128, v129, v130 = u16:BuySlot(u20):await();

    if v128 and (v129 and type(v130) == "number") then
        if u19 then
            local u131 = "ItemPurchased";
            pcall(function() -- Line: 94
                -- upvalues: u19 (ref), u131 (copy)
                u19:Play(u131);
            end);
        end;
    elseif v130 == "NoCash" then
        if u17 then
            u17:Show("Custom", "Not enough Coins for another loadout slot.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
        end;
    elseif v130 == "MaxSlots" then
        if u17 then
            u17:Show("Custom", "You\'ve unlocked all loadout slots for this category.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
        end;
    elseif u17 then
        u17:Show("Custom", "Couldn\'t purchase loadout slot.", 4, Color3_fromRGB_ret2, Color3_fromRGB_ret3, "Error");
    end;
end;

function u1._Init(p132) -- Line: 663
    -- upvalues: u3 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), Color3_new_ret (ref), u12 (ref), u13 (ref), u20 (ref), u1 (copy), u14 (ref), u15 (ref), DoBuySlot (copy), u23 (ref), u4 (ref), Registry (copy), u16 (ref), Knit (copy), u19 (ref), u17 (ref), u18 (ref), u24 (ref)
    if u3 then
        return;
    end;

    u3 = p132;
    u5 = u3.Frames.Inventory;
    local Contents = u5:WaitForChild("Contents");
    u6 = Contents:WaitForChild("InventorySection");
    u7 = Contents:WaitForChild("Loadouts");
    local ItemPanel = u7:WaitForChild("ItemPanel");
    u8 = ItemPanel:WaitForChild("ItemGrid");
    u9 = u8:WaitForChild("EquipmentTemplate");
    u10 = u8:WaitForChild("CosmeticTemplate");
    u11 = u8:FindFirstChild("BuyLoadout");
    Color3_new_ret = u9:FindFirstChild("Title") and u9.Title.TextColor3 or Color3.new(1, 1, 1);
    u9.Visible = false;
    u10.Visible = false;
    local Tabs = ItemPanel:FindFirstChild("Tabs");
    local v133;

    if Tabs then
        v133 = Tabs:FindFirstChild("Equipment");
    else
        v133 = Tabs;
    end;

    u12 = v133;

    if Tabs then
        Tabs = Tabs:FindFirstChild("Cosmetics");
    end;

    u13 = Tabs;

    if u12 and u12:IsA("GuiButton") then
        u12.MouseButton1Click:Connect(function() -- Line: 696
            -- upvalues: u20 (ref), u1 (ref)
            if u20 == "Equipment" then
                return;
            end;

            u20 = "Equipment";
            u1._Render();
        end);
    end;

    if u13 and u13:IsA("GuiButton") then
        u13.MouseButton1Click:Connect(function() -- Line: 699
            -- upvalues: u20 (ref), u1 (ref)
            if u20 == "Cosmetics" then
                return;
            end;

            u20 = "Cosmetics";
            u1._Render();
        end);
    end;

    local SlotCapacity = u7:FindFirstChild("SlotCapacity");

    if SlotCapacity then
        local Icon = SlotCapacity:FindFirstChild("Icon");

        if Icon then
            Icon = Icon:FindFirstChild("Amount");
        end;

        u14 = Icon;
        u15 = SlotCapacity:FindFirstChild("Button");

        if u15 and u15:IsA("GuiButton") then
            u15.MouseButton1Click:Connect(function() -- Line: 709
                -- upvalues: DoBuySlot (ref), u23 (ref)
                if u23 then
                    return;
                end;

                u23 = true;
                local success, result = pcall(DoBuySlot);
                u23 = false;

                if not success then
                    warn("[InventoryLoadouts] action error:", result);
                end;
            end);
        end;
    end;

    if u11 then
        local Coins = u11:FindFirstChild("Coins");

        if Coins and Coins:IsA("GuiButton") then
            Coins.MouseButton1Click:Connect(function() -- Line: 717
                -- upvalues: DoBuySlot (ref), u23 (ref)
                if u23 then
                    return;
                end;

                u23 = true;
                local success, result = pcall(DoBuySlot);
                u23 = false;

                if not success then
                    warn("[InventoryLoadouts] action error:", result);
                end;
            end);
        end;

        local Robux = u11:FindFirstChild("Robux");

        if Robux then
            Robux.Visible = false;
        end;

        local RobuxAmount = u11:FindFirstChild("RobuxAmount");

        if RobuxAmount then
            RobuxAmount.Visible = false;
        end;
    end;

    local Buttons = u7:FindFirstChild("Buttons");

    if Buttons then
        Buttons = Buttons:FindFirstChild("Inventory");
    end;

    if Buttons and Buttons:IsA("GuiButton") then
        Buttons.MouseButton1Click:Connect(function() -- Line: 729
            -- upvalues: u1 (ref)
            u1.Hide();
        end);
    end;

    u4 = Registry:Get("PlayerData");
    u16 = Knit.GetService("LoadoutService");
    u19 = Knit.GetController("SoundController");
    pcall(function() -- Line: 738
        -- upvalues: u17 (ref), Knit (ref)
        u17 = Knit.GetController("NotificationController");
    end);
    pcall(function() -- Line: 739
        -- upvalues: u18 (ref), Knit (ref)
        u18 = Knit.GetController("WarningController");
    end);
    u7.Visible = false;
    u4:OnChange(function(p134, p135) -- Line: 746
        -- upvalues: u7 (ref), u24 (ref), u1 (ref)
        if not u7.Visible then
            return;
        end;

        local v136 = p135[1];

        if v136 == "Loadouts" or (v136 == "Equipment" or (v136 == "EquipmentInventory" or (v136 == "CosmeticSlots" or v136 == "Currency"))) then
            if u24 then
                return;
            end;

            u24 = true;
            task.defer(function() -- Line: 602
                -- upvalues: u24 (ref), u1 (ref)
                u24 = false;
                u1._Render();
            end);
        end;
    end);
    u5:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 761
        -- upvalues: u5 (ref), u7 (ref), u1 (ref)
        if not u5.Visible and u7.Visible then
            u1.Hide();
        end;
    end);
end;

return u1;