--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Satchel
  Path:     game.StarterPlayer.StarterPlayerScripts.Satchel.Satchel
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

local ContextActionService = game:GetService("ContextActionService");
local TextChatService = game:GetService("TextChatService");
local UserInputService = game:GetService("UserInputService");
local StarterGui = game:GetService("StarterGui");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local VRService = game:GetService("VRService");
local Players = game:GetService("Players");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local u1 = {
    OpenClose = nil,
    IsOpen = false,
    StateChanged = Instance.new("BindableEvent"),
    ModuleName = "Backpack",
    KeepVRTopbarOpen = true,
    VRIsExclusive = true,
    VRClosesNonExclusive = true,
    BackpackEmpty = Instance.new("BindableEvent")
};
u1.BackpackEmpty.Name = "BackpackEmpty";
u1.BackpackItemAdded = Instance.new("BindableEvent");
u1.BackpackItemAdded.Name = "BackpackAdded";
u1.BackpackItemRemoved = Instance.new("BindableEvent");
u1.BackpackItemRemoved.Name = "BackpackRemoved";
local v2 = script;
local v3 = GuiService.PreferredTransparency or 1;
local u4 = not v2:GetAttribute("OutlineEquipBorder") or false;
local Attribute = v2:GetAttribute("InsetIconPadding");
local u5 = v2:GetAttribute("BackgroundTransparency") or 0.3;
local u6 = u5 * v3;
local UDim_new_ret = UDim.new(0, 8);
local u7 = v2:GetAttribute("BackgroundColor3") or Color3.new(0.09803921568627451, 0.10588235294117647, 0.11372549019607843);
local u8 = v2:GetAttribute("EquipBorderColor3") or Color3.new(0, 0.6352941176470588, 1);
local u9 = v2:GetAttribute("BackgroundTransparency") or 0.3;
local u10 = u9 * v3;
local u11 = v2:GetAttribute("EquipBorderSizePixel") or 5;
local u12 = v2:GetAttribute("CornerRadius") or UDim.new(0, 8);
local Color3_new_ret = Color3.new(1, 1, 1);
local u13 = u12 - UDim.new(0, 5) or UDim.new(0, 3);
local u14 = v2:GetAttribute("BackgroundColor3") or Color3.new(0.09803921568627451, 0.10588235294117647, 0.11372549019607843);
local u15 = v2:GetAttribute("TextColor3") or Color3.new(1, 1, 1);
local u16 = v2:GetAttribute("TextStrokeTransparency") or 0.5;
local u17 = v2:GetAttribute("TextStrokeColor3") or Color3.new(0, 0, 0);
local Color3_new_ret2 = Color3.new(0.09803921568627451, 0.10588235294117647, 0.11372549019607843);
local u18 = v3 * 0.2;
local Color3_new_ret3 = Color3.new(1, 1, 1);
local UDim_new_ret2 = UDim.new(0, 3);
local u19 = v2:GetAttribute("FontFace") or Font.new("rbxasset://fonts/families/BuilderSans.json");
local u20 = v2:GetAttribute("TextSize") or 16;
local Value = Enum.KeyCode.Backspace.Value;
local Value2 = Enum.KeyCode.Zero.Value;
local u21 = {
    [Enum.UserInputType.MouseButton1] = true,
    [Enum.UserInputType.MouseButton2] = true,
    [Enum.UserInputType.MouseButton3] = true,
    [Enum.UserInputType.MouseMovement] = true,
    [Enum.UserInputType.MouseWheel] = true
};
local u22 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
};
local u23 = true;
local topbarplus = require(script.Packages:WaitForChild("topbarplus"));
topbarplus.highlightKey = false;
local u24 = topbarplus.new():setName("Inventory"):setImage("rbxasset://textures/ui/TopBar/inventoryOn.png", "Selected"):setImage("rbxasset://textures/ui/TopBar/inventoryOff.png", "Deselected"):setImageScale(1):setCaption("Inventory"):bindToggleKey(Enum.KeyCode.Backquote):autoDeselect(false):setOrder(-1);
u24.toggled:Connect(function() -- Line: 170
    -- upvalues: GuiService (copy), u1 (copy)
    if not GuiService.MenuIsOpen then
        u1.OpenClose();
    end;
end);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.DisplayOrder = 120;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.ResetOnSpawn = false;
ScreenGui.Name = "BackpackGui";
ScreenGui.Parent = PlayerGui;
local u25 = GuiService:IsTenFootInterface();
local u26;

if u25 then
    u20 = 24;
    u26 = 100;
else
    u26 = 60;
end;

local u27 = false;
local v28 = UserInputService.TouchEnabled and workspace.CurrentCamera.ViewportSize.X < 1024;
local LocalPlayer = Players.LocalPlayer;
local u29 = nil;
local u30 = nil;
local u31 = nil;
local u32 = nil;
local u33 = nil;
local u34 = nil;
local u35 = nil;
local u36 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u36:WaitForChild("Humanoid");
local Backpack = LocalPlayer:WaitForChild("Backpack");
local u37 = {};
local u38 = nil;
local u39 = {};
local u40 = {};
local u41 = {};
local u42 = 0;
local u43 = nil;
local u44 = false;
local u45 = false;
local u46 = false;
local u47 = false;
local u48 = {};
local u49 = false;
local VREnabled = VRService.VREnabled;
local u50 = VREnabled and 6 or (v28 and 6 or 10);
local u51 = VREnabled and 3 or (v28 and 2 or 4);
local u52 = nil;

local function EvaluateBackpackPanelVisibility(p53: boolean) -- Line: 233
    -- upvalues: u24 (copy), u23 (ref), VRService (copy)
    return p53 and (u24.enabled and u23) and VRService.VREnabled;
end;

local function ShowVRBackpackPopup() -- Line: 237
end;

local function FindLowestEmpty() -- Line: 243
    -- upvalues: u50 (copy), u37 (copy)
    for i = 1, u50 do
        local v54 = u37[i];

        if not v54.Tool then
            return v54;
        end;

        local _ = i;
    end;

    return nil;
end;

function u1.IsInventoryEmpty() -- Line: 253
    -- upvalues: u50 (copy), u37 (copy)
    for i = u50 + 1, #u37 do
        local v55 = u37[i];

        if v55 and v55.Tool then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

local function UseGazeSelection() -- Line: 265
    return false;
end;

local function AdjustHotbarFrames() -- Line: 269
    -- upvalues: u31 (ref), u50 (copy), u42 (ref), u37 (copy)
    local Visible = u31.Visible;
    local v56 = Visible and u50 or u42;
    local v57 = 0;

    for i = 1, u50 do
        local v58 = u37[i];
        local v59;

        if v58.Tool or Visible then
            v57 = v57 + 1;
            v58:Readjust(v57, v56);
            v58.Frame.Visible = true;
            v59 = i;
        else
            v58.Frame.Visible = false;
            v59 = i;
        end;
    end;
end;

local function UpdateScrollingFrameCanvasSize() -- Line: 286
    -- upvalues: u33 (ref), u26 (ref), u34 (ref)
    local math_floor_ret = math.floor(u33.AbsoluteSize.X / (u26 + 5));
    local v60 = (#u34:GetChildren() - 1) / math_floor_ret;
    local v61 = math.ceil(v60) * (u26 + 5) + 5;
    u33.CanvasSize = UDim2.new(0, 0, 0, v61);
end;

local function AdjustInventoryFrames() -- Line: 293
    -- upvalues: u50 (copy), u37 (copy), UpdateScrollingFrameCanvasSize (copy)
    for i = u50 + 1, #u37 do
        local v62 = u37[i];
        v62.Frame.LayoutOrder = v62.Index;
        v62.Frame.Visible = v62.Tool ~= nil;
        local _ = i;
    end;

    UpdateScrollingFrameCanvasSize();
end;

local function UpdateBackpackLayout() -- Line: 302
    -- upvalues: u30 (ref), u50 (copy), u26 (ref), u31 (ref), u51 (copy), VREnabled (copy), u33 (ref), AdjustHotbarFrames (copy), AdjustInventoryFrames (copy)
    u30.Size = UDim2.new(0, u50 * (u26 + 5) + 5, 0, u26 + 5 + 5);
    u30.Position = UDim2.new(0.5, -u30.Size.X.Offset / 2, 1, -u30.Size.Y.Offset);
    u31.Size = UDim2.new(0, u30.Size.X.Offset, 0, u30.Size.Y.Offset * u51 + 40 + (VREnabled and 80 or 0));
    u31.Position = UDim2.new(0.5, -u31.Size.X.Offset / 2, 1, u30.Position.Y.Offset - u31.Size.Y.Offset);
    u33.Size = UDim2.new(1, u33.ScrollBarThickness + 1, 1, -40 - (VREnabled and 80 or 0));
    u33.Position = UDim2.new(0, 0, 0, 40 + (VREnabled and 40 or 0));
    AdjustHotbarFrames();
    AdjustInventoryFrames();
end;

local function Clamp(p63: number, p64: number, p65: number) -- Line: 336
    local math_max_ret = math.max(p63, p65);

    return math.min(p64, math_max_ret);
end;

local function CheckBounds(p66: userdata, p67: number, p68: number) -- Line: 340
    local AbsolutePosition = p66.AbsolutePosition;
    local AbsoluteSize = p66.AbsoluteSize;
    local v69;

    if AbsolutePosition.X < p67 and (p67 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < p68) then
        v69 = p68 <= AbsolutePosition.Y + AbsoluteSize.Y;
    else
        v69 = false;
    end;

    return v69;
end;

local function GetOffset(p70: userdata, p71) -- Line: 346
    return (p70.AbsolutePosition + p70.AbsoluteSize / 2 - p71).Magnitude;
end;

local function DisableActiveHopper() -- Line: 351
    -- upvalues: u43 (ref), u39 (copy)
    u43:ToggleSelect();
    u39[u43]:UpdateEquipView();
    u43 = nil;
end;

local function UnequipAllTools() -- Line: 357
    -- upvalues: Humanoid (ref), u43 (ref), u39 (copy)
    if Humanoid then
        Humanoid:UnequipTools();

        if u43 then
            u43:ToggleSelect();
            u39[u43]:UpdateEquipView();
            u43 = nil;
        end;
    end;
end;

local function EquipNewTool(p72: userdata) -- Line: 366
    -- upvalues: Humanoid (ref), u43 (ref), u39 (copy)
    if Humanoid then
        Humanoid:UnequipTools();

        if u43 then
            u43:ToggleSelect();
            u39[u43]:UpdateEquipView();
            u43 = nil;
        end;
    end;

    Humanoid:EquipTool(p72);
end;

local function IsEquipped(p73: userdata) -- Line: 372
    -- upvalues: u36 (ref)
    if p73 then
        p73 = p73.Parent == u36;
    end;

    return p73;
end;

local function MakeSlot(p74: userdata, p75: number?) -- Line: 377
    -- upvalues: u37 (copy), u10 (ref), u30 (ref), u26 (ref), u50 (copy), u31 (ref), UserInputService (copy), u42 (ref), u45 (ref), u27 (ref), ContextActionService (copy), u35 (ref), u39 (copy), u38 (ref), u36 (ref), u52 (ref), u11 (copy), u8 (copy), u4 (copy), UpdateScrollingFrameCanvasSize (copy), Humanoid (ref), u43 (ref), Backpack (ref), u7 (copy), Color3_new_ret (copy), u12 (copy), Attribute (copy), u15 (copy), u16 (copy), u17 (copy), u19 (copy), u20 (ref), u14 (copy), u13 (copy), MakeSlot (copy), u34 (ref), u47 (ref), u40 (copy), Value2 (copy), u41 (copy), u24 (copy), u33 (ref)
    local v76 = p75 or #u37 + 1;
    local u77 = {
        Tool = nil,
        Index = v76,
        Frame = nil
    };
    local u78 = nil;
    local u79 = nil;
    local u80 = nil;
    local u81 = nil;
    local u82 = nil;
    local u83 = nil;
    local u84 = nil;
    local u85 = nil;

    local function UpdateSlotFading() -- Line: 402
        -- upvalues: u78 (ref), u10 (ref)
        u78.SelectionImageObject = nil;
        u78.BackgroundTransparency = u78.Draggable and 0 or u10;
    end;

    function u77.Readjust(p86: table, p87: number, p88: number) -- Line: 408
        -- upvalues: u30 (ref), u26 (ref), u78 (ref)
        u78.Position = UDim2.new(0, u30.Size.X.Offset / 2 - u26 / 2 + (u26 + 5) * (p87 - (p88 / 2 + 0.5)), 0, 5);
    end;

    function u77.Fill(p89: table, u90: userdata) -- Line: 418
        -- upvalues: u80 (ref), u81 (ref), u84 (ref), u82 (ref), u50 (ref), u31 (ref), UserInputService (ref), u78 (ref), u42 (ref), u45 (ref), u27 (ref), ContextActionService (ref), u35 (ref), u39 (ref), u38 (ref), u37 (ref)
        if not u90 then
            return p89:Clear();
        end;

        p89.Tool = u90;

        local function assignToolData() -- Line: 427
            -- upvalues: u90 (copy), u80 (ref), u81 (ref), u84 (ref)
            local TextureId = u90.TextureId;
            u80.Image = TextureId;

            if TextureId == "" then
                u81.Visible = true;
            else
                u81.Visible = false;
            end;

            u81.Text = u90.Name;

            if u84 and u90:IsA("Tool") then
                u84.Text = u90.ToolTip;
                u84.Size = UDim2.new(0, 0, 0, 16);
                u84.Position = UDim2.new(0.5, 0, 0, -5);
            end;
        end;

        assignToolData();

        if u82 then
            u82:Disconnect();
            u82 = nil;
        end;

        u82 = u90.Changed:Connect(function(p91: string) -- Line: 456
            -- upvalues: assignToolData (copy)
            if p91 == "TextureId" or (p91 == "Name" or p91 == "ToolTip") then
                assignToolData();
            end;
        end);
        local v92 = p89.Index <= u50;

        if (not v92 or u31.Visible) and not UserInputService.VREnabled then
            u78.Draggable = true;
        end;

        p89:UpdateEquipView();

        if v92 then
            u42 = u42 + 1;

            if u45 and (u42 >= 1 and not u27) then
                u27 = true;
                ContextActionService:BindAction("BackpackHotbarEquip", u35, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
            end;
        end;

        u39[u90] = p89;
        local v93;

        for i = 1, u50 do
            v93 = u37[i];

            if not v93.Tool then
                break;
            end;

            local _ = i;
        end;

        v93 = nil;
        u38 = v93;
    end;

    function u77.Clear(p94) -- Line: 492
        -- upvalues: u82 (ref), u80 (ref), u81 (ref), u84 (ref), u78 (ref), u50 (ref), u42 (ref), u27 (ref), ContextActionService (ref), u39 (ref), u38 (ref), u37 (ref)
        if not p94.Tool then
            return;
        end;

        if u82 then
            u82:Disconnect();
            u82 = nil;
        end;

        u80.Image = "";
        u81.Text = "";

        if u84 then
            u84.Text = "";
            u84.Visible = false;
        end;

        u78.Draggable = false;
        p94:UpdateEquipView(true);

        if p94.Index <= u50 then
            u42 = u42 - 1;

            if u42 < 1 then
                u27 = false;
                ContextActionService:UnbindAction("BackpackHotbarEquip");
            end;
        end;

        u39[p94.Tool] = nil;
        p94.Tool = nil;
        local v95;

        for i = 1, u50 do
            v95 = u37[i];

            if not v95.Tool then
                break;
            end;

            local _ = i;
        end;

        v95 = nil;
        u38 = v95;
    end;

    function u77.UpdateEquipView(p96: table, p97: boolean?) -- Line: 527
        -- upvalues: u36 (ref), u52 (ref), u77 (copy), u83 (ref), u11 (ref), u8 (ref), u4 (ref), u80 (ref), u78 (ref), u10 (ref)
        if p97 or false then
            if u83 then
                u83.Parent = nil;
            end;
        else
            local Tool = p96.Tool;

            if Tool then
                Tool = Tool.Parent == u36;
            end;

            if Tool then
                u52 = u77;

                if not u83 then
                    u83 = Instance.new("UIStroke");
                    u83.Name = "Border";
                    u83.Thickness = u11;
                    u83.Color = u8;
                    u83.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                end;

                if u4 == true then
                    u83.Parent = u80;
                else
                    u83.Parent = u78;
                end;
            elseif u83 then
                u83.Parent = nil;
            end;
        end;

        u78.SelectionImageObject = nil;
        u78.BackgroundTransparency = u78.Draggable and 0 or u10;
    end;

    function u77.IsEquipped(p98) -- Line: 551
        -- upvalues: u36 (ref)
        local Tool = p98.Tool;

        if Tool then
            Tool = Tool.Parent == u36;
        end;

        return Tool;
    end;

    function u77.Delete(p99) -- Line: 555
        -- upvalues: u78 (ref), u37 (ref), UpdateScrollingFrameCanvasSize (ref)
        u78:Destroy();
        table.remove(u37, p99.Index);

        for i = p99.Index, #u37 do
            u37[i]:SlideBack();
            local _ = i;
        end;

        UpdateScrollingFrameCanvasSize();
    end;

    function u77.Swap(p100, p101) -- Line: 568
        local Tool = p100.Tool;
        local Tool2 = p101.Tool;
        p100:Clear();

        if Tool2 then
            p101:Clear();
            p100:Fill(Tool2);
        end;

        if Tool then
            p101:Fill(Tool);

            return;
        end;

        p101:Clear();
    end;

    function u77.SlideBack(p102) -- Line: 582
        -- upvalues: u78 (ref)
        p102.Index = p102.Index - 1;
        u78.Name = p102.Index;
        u78.LayoutOrder = p102.Index;
    end;

    function u77.TurnNumber(p103: table, p104: boolean) -- Line: 588
        -- upvalues: u85 (ref)
        if u85 then
            u85.Visible = p104;
        end;
    end;

    function u77.SetClickability(p105: table, p106: boolean) -- Line: 594
        -- upvalues: UserInputService (ref), u78 (ref), u10 (ref)
        if p105.Tool then
            if UserInputService.VREnabled then
                u78.Draggable = false;
            else
                u78.Draggable = not p106;
            end;

            u78.SelectionImageObject = nil;
            u78.BackgroundTransparency = u78.Draggable and 0 or u10;
        end;
    end;

    function u77.CheckTerms(p107, p108) -- Line: 605
        -- upvalues: u81 (ref), u84 (ref)
        local u109 = 0;

        local function checkEm(p110: string, p111: any) -- Line: 607
            -- upvalues: u109 (ref)
            local _, v112 = p110:lower():gsub(p111, "");
            u109 = u109 + v112;
        end;

        local Tool = p107.Tool;

        if Tool then
            for i in pairs(p108) do
                local _, v113 = u81.Text:lower():gsub(i, "");
                u109 = u109 + v113;

                if Tool:IsA("Tool") then
                    local _, v114 = (u84 and u84.Text or ""):lower():gsub(i, "");
                    u109 = u109 + v114;
                end;
            end;
        end;

        return u109;
    end;

    function u77.Select(p115) -- Line: 625
        -- upvalues: u77 (copy), u36 (ref), Humanoid (ref), u43 (ref), u39 (ref), Backpack (ref)
        local Tool = u77.Tool;

        if Tool then
            local v116;

            if Tool then
                v116 = Tool.Parent == u36;
            else
                v116 = Tool;
            end;

            if v116 then
                if Humanoid then
                    Humanoid:UnequipTools();

                    if u43 then
                        u43:ToggleSelect();
                        u39[u43]:UpdateEquipView();
                        u43 = nil;
                    end;
                end;
            elseif Tool.Parent == Backpack then
                if Humanoid then
                    Humanoid:UnequipTools();

                    if u43 then
                        u43:ToggleSelect();
                        u39[u43]:UpdateEquipView();
                        u43 = nil;
                    end;
                end;

                Humanoid:EquipTool(Tool);
            end;
        end;
    end;

    u78 = Instance.new("TextButton");
    u78.Name = tostring(v76);
    u78.BackgroundColor3 = u7;
    u78.BorderColor3 = Color3_new_ret;
    u78.Text = "";
    u78.BorderSizePixel = 0;
    u78.Size = UDim2.new(0, u26, 0, u26);
    u78.Active = true;
    u78.Draggable = false;
    u78.BackgroundTransparency = u10;
    u78.MouseButton1Click:Connect(function() -- Line: 648
        -- upvalues: u77 (copy)
        changeSlot(u77);
    end);
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "Corner";
    UICorner.CornerRadius = u12;
    UICorner.Parent = u78;
    u77.Frame = u78;
    local Frame = Instance.new("Frame");
    Frame.Name = "SelectionObjectClipper";
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.Parent = u78;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Selector";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.new(1, 0, 1, 0);
    ImageLabel.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png";
    ImageLabel.ScaleType = Enum.ScaleType.Slice;
    ImageLabel.SliceCenter = Rect.new(12, 12, 52, 52);
    ImageLabel.Parent = Frame;
    u80 = Instance.new("ImageLabel");
    u80.BackgroundTransparency = 1;
    u80.Name = "Icon";
    u80.Size = UDim2.new(1, 0, 1, 0);
    u80.Position = UDim2.new(0.5, 0, 0.5, 0);
    u80.AnchorPoint = Vector2.new(0.5, 0.5);

    if Attribute == true then
        u80.Size = UDim2.new(1, -u11 * 2, 1, -u11 * 2);
    else
        u80.Size = UDim2.new(1, 0, 1, 0);
    end;

    u80.Parent = u78;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "Corner";

    if Attribute == true then
        UICorner2.CornerRadius = u12 - UDim.new(0, u11);
    else
        UICorner2.CornerRadius = u12;
    end;

    UICorner2.Parent = u80;
    u81 = Instance.new("TextLabel");
    u81.BackgroundTransparency = 1;
    u81.Name = "ToolName";
    u81.Text = "";
    u81.TextColor3 = u15;
    u81.TextStrokeTransparency = u16;
    u81.TextStrokeColor3 = u17;
    u81.FontFace = Font.new(u19.Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    u81.TextSize = u20;
    u81.Size = UDim2.new(1, -u11 * 2, 1, -u11 * 2);
    u81.Position = UDim2.new(0.5, 0, 0.5, 0);
    u81.AnchorPoint = Vector2.new(0.5, 0.5);
    u81.TextWrapped = true;
    u81.TextTruncate = Enum.TextTruncate.AtEnd;
    u81.Parent = u78;
    u77.Frame.LayoutOrder = u77.Index;

    if v76 <= u50 then
        u84 = Instance.new("TextLabel");
        u84.Name = "ToolTip";
        u84.Text = "";
        u84.Size = UDim2.new(1, 0, 1, 0);
        u84.TextColor3 = u15;
        u84.TextStrokeTransparency = u16;
        u84.TextStrokeColor3 = u17;
        u84.FontFace = Font.new(u19.Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal);
        u84.TextSize = u20;
        u84.ZIndex = 2;
        u84.TextWrapped = false;
        u84.TextYAlignment = Enum.TextYAlignment.Center;
        u84.BackgroundColor3 = u14;
        u84.BackgroundTransparency = u10;
        u84.AnchorPoint = Vector2.new(0.5, 1);
        u84.BorderSizePixel = 0;
        u84.Visible = false;
        u84.AutomaticSize = Enum.AutomaticSize.X;
        u84.Parent = u78;
        local UICorner3 = Instance.new("UICorner");
        UICorner3.Name = "Corner";
        UICorner3.CornerRadius = u13;
        UICorner3.Parent = u84;
        local UIPadding = Instance.new("UIPadding");
        UIPadding.PaddingLeft = UDim.new(0, 4);
        UIPadding.PaddingRight = UDim.new(0, 4);
        UIPadding.PaddingTop = UDim.new(0, 4);
        UIPadding.PaddingBottom = UDim.new(0, 4);
        UIPadding.Parent = u84;
        u78.MouseEnter:Connect(function() -- Line: 747
            -- upvalues: u84 (ref)
            if u84.Text ~= "" then
                u84.Visible = true;
            end;
        end);
        u78.MouseLeave:Connect(function() -- Line: 752
            -- upvalues: u84 (ref)
            u84.Visible = false;
        end);

        function u77.MoveToInventory(p117) -- Line: 756
            -- upvalues: u77 (copy), u50 (ref), MakeSlot (ref), u34 (ref), u36 (ref), Humanoid (ref), u43 (ref), u39 (ref), u47 (ref), u31 (ref)
            if u77.Index <= u50 then
                local Tool = u77.Tool;
                p117:Clear();
                local v118 = MakeSlot(u34);
                v118:Fill(Tool);

                if Tool then
                    Tool = Tool.Parent == u36;
                end;

                if Tool and Humanoid then
                    Humanoid:UnequipTools();

                    if u43 then
                        u43:ToggleSelect();
                        u39[u43]:UpdateEquipView();
                        u43 = nil;
                    end;
                end;

                if u47 then
                    v118.Frame.Visible = false;
                    v118.Parent = u31;
                end;
            end;
        end;

        if v76 < 10 or v76 == u50 then
            local v119 = v76 < 10 and (v76 or 0) or 0;
            u85 = Instance.new("TextLabel");
            u85.BackgroundTransparency = 1;
            u85.Name = "Number";
            u85.TextColor3 = u15;
            u85.TextStrokeTransparency = u16;
            u85.TextStrokeColor3 = u17;
            u85.TextSize = u20;
            u85.Text = tostring(v119);
            u85.FontFace = Font.new(u19.Family, Enum.FontWeight.Heavy, Enum.FontStyle.Normal);
            u85.Size = UDim2.new(0.4, 0, 0.4, 0);
            u85.Visible = false;
            u85.Parent = u78;
            u40[Value2 + v119] = u77.Select;
        end;
    end;

    local Position = u78.Position;
    local u120 = 0;
    local u121 = nil;
    u78.DragBegin:Connect(function(p122) -- Line: 797
        -- upvalues: u41 (ref), u78 (ref), Position (ref), u24 (ref), u80 (ref), u81 (ref), u85 (ref), u121 (ref), u34 (ref), u31 (ref), u79 (ref)
        u41[u78] = true;
        Position = p122;
        u78.BorderSizePixel = 2;
        u24:lock();
        u78.ZIndex = 2;
        u80.ZIndex = 2;
        u81.ZIndex = 2;
        u78.Parent.ZIndex = 2;

        if u85 then
            u85.ZIndex = 2;
        end;

        u121 = u78.Parent;

        if u121 == u34 then
            local UDim2_new_ret = UDim2.new(0, u78.AbsolutePosition.X - u31.AbsolutePosition.X, 0, u78.AbsolutePosition.Y - u31.AbsolutePosition.Y);
            u78.Parent = u31;
            u78.Position = UDim2_new_ret;
            u79 = Instance.new("Frame");
            u79.Name = "FakeSlot";
            u79.LayoutOrder = u78.LayoutOrder;
            u79.Size = u78.Size;
            u79.BackgroundTransparency = 1;
            u79.Parent = u34;
        end;
    end);
    u78.DragStopped:Connect(function(p123: number, p124: number) -- Line: 840
        -- upvalues: u79 (ref), u78 (ref), Position (ref), u121 (ref), u24 (ref), u80 (ref), u81 (ref), u85 (ref), u41 (ref), u77 (copy), u31 (ref), u50 (ref), u120 (ref), u38 (ref), u30 (ref), u37 (ref), u36 (ref), Humanoid (ref), u43 (ref), u39 (ref), u47 (ref)
        if u79 then
            u79:Destroy();
        end;

        local os_clock_ret = os.clock();
        u78.Position = Position;
        u78.Parent = u121;
        u78.BorderSizePixel = 0;
        u24:unlock();
        u78.ZIndex = 1;
        u80.ZIndex = 1;
        u81.ZIndex = 1;
        u121.ZIndex = 1;

        if u85 then
            u85.ZIndex = 1;
        end;

        u41[u78] = nil;

        if not u77.Tool then
            return;
        end;

        local v125 = u31;
        local AbsolutePosition = v125.AbsolutePosition;
        local AbsoluteSize = v125.AbsoluteSize;
        local v126;

        if AbsolutePosition.X < p123 and (p123 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < p124) then
            v126 = p124 <= AbsolutePosition.Y + AbsoluteSize.Y;
        else
            v126 = false;
        end;

        if v126 then
            if u77.Index <= u50 then
                u77:MoveToInventory();
            end;

            if u50 < u77.Index and os_clock_ret - u120 < 0.5 then
                if u38 then
                    local Tool = u77.Tool;
                    u77:Clear();
                    u38:Fill(Tool);
                    u77:Delete();
                    os_clock_ret = 0;
                else
                    os_clock_ret = 0;
                end;
            end;
        else
            local v127 = u30;
            local AbsolutePosition2 = v127.AbsolutePosition;
            local AbsoluteSize2 = v127.AbsoluteSize;
            local v128;

            if AbsolutePosition2.X < p123 and (p123 <= AbsolutePosition2.X + AbsoluteSize2.X and AbsolutePosition2.Y < p124) then
                v128 = p124 <= AbsolutePosition2.Y + AbsoluteSize2.Y;
            else
                v128 = false;
            end;

            if v128 then
                local v129 = { (1 / 0), nil };

                for i = 1, u50 do
                    local v130 = u37[i];
                    local Frame2 = v130.Frame;
                    local Vector2_new_ret = Vector2.new(p123, p124);
                    local Magnitude = (Frame2.AbsolutePosition + Frame2.AbsoluteSize / 2 - Vector2_new_ret).Magnitude;
                    local v131;

                    if Magnitude < v129[1] then
                        v131 = i;
                        v129 = { Magnitude, v130 };
                    else
                        v131 = i;
                    end;
                end;

                local v132 = v129[2];

                if v132 ~= u77 then
                    u77:Swap(v132);

                    if u50 < u77.Index then
                        local Tool = u77.Tool;

                        if Tool then
                            if Tool then
                                Tool = Tool.Parent == u36;
                            end;

                            if Tool and Humanoid then
                                Humanoid:UnequipTools();

                                if u43 then
                                    u43:ToggleSelect();
                                    u39[u43]:UpdateEquipView();
                                    u43 = nil;
                                end;
                            end;

                            if u47 then
                                u77.Frame.Visible = false;
                                u77.Frame.Parent = u31;
                            end;
                        else
                            u77:Delete();
                        end;
                    end;
                end;
            elseif u77.Index <= u50 then
                u77:MoveToInventory();
            end;
        end;

        u120 = os_clock_ret;
    end);
    u78.Parent = p74;
    u37[v76] = u77;

    if u50 < v76 then
        UpdateScrollingFrameCanvasSize();

        if u31.Visible and not u47 then
            u33.CanvasPosition = Vector2.new(0, (math.max(0, u33.CanvasSize.Y.Offset - u33.AbsoluteSize.Y)));
        end;
    end;

    return u77;
end;

local function OnChildAdded(p133: userdata) -- Line: 950
    -- upvalues: u36 (ref), Humanoid (ref), u43 (ref), u39 (copy), u44 (ref), LocalPlayer (ref), u38 (ref), MakeSlot (copy), u34 (ref), u37 (copy), Backpack (ref), AdjustHotbarFrames (copy), u50 (copy), u31 (ref), u1 (copy)
    if not (p133:IsA("Tool") or p133:IsA("HopperBin")) then
        if p133:IsA("Humanoid") and p133.Parent == u36 then
            Humanoid = p133;
        end;

        return;
    end;

    local _ = p133.Parent == u36;

    if u43 and p133.Parent == u36 then
        u43:ToggleSelect();
        u39[u43]:UpdateEquipView();
        u43 = nil;
    end;

    if not u44 and (p133.Parent == u36 and not u39[p133]) then
        local StarterGear = LocalPlayer:FindFirstChild("StarterGear");

        if StarterGear and StarterGear:FindFirstChild(p133.Name) then
            u44 = true;

            for i = (u38 or MakeSlot(u34)).Index, 1, -1 do
                local v134 = u37[i];
                local v135 = i - 1;
                local v136;

                if v135 > 0 then
                    u37[v135]:Swap(v134);
                    v136 = i;
                else
                    v134:Fill(p133);
                    v136 = i;
                end;
            end;

            for _, child in pairs(u36:GetChildren()) do
                if child:IsA("Tool") and child ~= p133 then
                    child.Parent = Backpack;
                end;
            end;

            AdjustHotbarFrames();

            return;
        end;
    end;

    local v137 = u39[p133];

    if v137 then
        v137:UpdateEquipView();
    else
        local v138 = u38 or MakeSlot(u34);
        v138:Fill(p133);

        if v138.Index <= u50 and not u31.Visible then
            AdjustHotbarFrames();
        end;

        if p133:IsA("HopperBin") and p133.Active then
            if Humanoid then
                Humanoid:UnequipTools();

                if u43 then
                    u43:ToggleSelect();
                    u39[u43]:UpdateEquipView();
                    u43 = nil;
                end;
            end;

            u43 = p133;
        end;
    end;

    u1.BackpackItemAdded:Fire();
end;

local function OnChildRemoved(p139: userdata) -- Line: 1017
    -- upvalues: u36 (ref), Backpack (ref), u39 (copy), u50 (copy), u31 (ref), AdjustHotbarFrames (copy), u43 (ref), u1 (copy), u37 (copy)
    if not (p139:IsA("Tool") or p139:IsA("HopperBin")) then
        return;
    end;

    local Parent = p139.Parent;

    if Parent == u36 or Parent == Backpack then
        return;
    end;

    local v140 = u39[p139];

    if v140 then
        v140:Clear();

        if u50 < v140.Index then
            v140:Delete();
        elseif not u31.Visible then
            AdjustHotbarFrames();
        end;
    end;

    if p139 == u43 then
        u43 = nil;
    end;

    u1.BackpackItemRemoved:Fire();
    local v141 = true;

    for i = u50 + 1, #u37 do
        local v142 = u37[i];

        if v142 and v142.Tool then
            v141 = false;
            break;
        end;

        local _ = i;
    end;

    if v141 then
        u1.BackpackEmpty:Fire();
    end;
end;

local function OnCharacterAdded(p143: userdata) -- Line: 1051
    -- upvalues: u37 (copy), u50 (copy), u43 (ref), u48 (ref), u36 (ref), OnChildRemoved (copy), OnChildAdded (copy), Backpack (ref), LocalPlayer (ref), AdjustHotbarFrames (copy)
    for i = #u37, 1, -1 do
        local v144 = u37[i];

        if v144.Tool then
            v144:Clear();
        end;

        local v145;

        if u50 < i then
            v144:Delete();
            v145 = i;
        else
            v145 = i;
        end;
    end;

    u43 = nil;

    for _, v in pairs(u48) do
        v:Disconnect();
    end;

    u48 = {};
    u36 = p143;
    table.insert(u48, p143.ChildRemoved:Connect(OnChildRemoved));
    table.insert(u48, p143.ChildAdded:Connect(OnChildAdded));

    for _, child in pairs(p143:GetChildren()) do
        OnChildAdded(child);
    end;

    Backpack = LocalPlayer:WaitForChild("Backpack");
    table.insert(u48, Backpack.ChildRemoved:Connect(OnChildRemoved));
    table.insert(u48, Backpack.ChildAdded:Connect(OnChildAdded));

    for _, child in pairs(Backpack:GetChildren()) do
        OnChildAdded(child);
    end;

    AdjustHotbarFrames();
end;

local function OnInputBegan(p146: userdata, p147: boolean) -- Line: 1090
    -- upvalues: TextChatService (copy), u46 (ref), u45 (ref), Value (copy), u40 (copy), u31 (ref), u24 (copy)
    local v148 = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration");
    local v149 = p146.UserInputType == Enum.UserInputType.Keyboard and (not u46 and (not v148.IsFocused and (u45 or p146.KeyCode.Value == Value))) and u40[p146.KeyCode.Value];

    if v149 then
        v149(p147);
    end;

    local UserInputType = p146.UserInputType;

    if not p147 and (UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch) and u31.Visible then
        u24:deselect();
    end;
end;

local function OnUISChanged() -- Line: 1116
    -- upvalues: UserInputService (copy), u50 (copy), u37 (copy), u21 (copy), u22 (copy)
    if UserInputService:GetLastInputType() == Enum.UserInputType.Touch then
        for i = 1, u50 do
            u37[i]:TurnNumber(false);
            local _ = i;
        end;

        return;
    end;

    if UserInputService:GetLastInputType() == Enum.UserInputType.Keyboard then
        for i = 1, u50 do
            u37[i]:TurnNumber(true);
            local _ = i;
        end;

        return;
    end;

    for _, v in pairs(u21) do
        if UserInputService:GetLastInputType() == v then
            for i = 1, u50 do
                u37[i]:TurnNumber(true);
                local _ = i;
            end;

            return;
        end;
    end;

    for _, v in pairs(u22) do
        if UserInputService:GetLastInputType() == v then
            for i = 1, u50 do
                u37[i]:TurnNumber(false);
                local _ = i;
            end;

            return;
        end;
    end;
end;

local u150 = nil;
local u151 = nil;

local function u152() -- Line: 1157
end;

function unbindAllGamepadEquipActions()
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("BackpackHasGamepadFocus");
    ContextActionService:UnbindAction("BackpackCloseInventory");
end;

u35 = function(p153: string, p154: any, u155: userdata) -- Line: 1236
    -- upvalues: u150 (ref), u151 (ref), Humanoid (ref), u43 (ref), u39 (copy), u50 (copy), u37 (copy), u52 (ref)
    if p154 ~= Enum.UserInputState.Begin then
        return;
    end;

    if u150 and (u150.KeyCode == Enum.KeyCode.ButtonR1 and u155.KeyCode == Enum.KeyCode.ButtonL1 or u150.KeyCode == Enum.KeyCode.ButtonL1 and u155.KeyCode == Enum.KeyCode.ButtonR1) and os.clock() - u151 <= 0.06 then
        if Humanoid then
            Humanoid:UnequipTools();

            if u43 then
                u43:ToggleSelect();
                u39[u43]:UpdateEquipView();
                u43 = nil;
            end;
        end;

        u150 = u155;
        u151 = os.clock();

        return;
    end;

    u150 = u155;
    u151 = os.clock();
    task.delay(0.06, function() -- Line: 1264
        -- upvalues: u150 (ref), u155 (copy), u50 (ref), u37 (ref), Humanoid (ref), u43 (ref), u39 (ref), u52 (ref)
        if u150 ~= u155 then
            return;
        end;

        local v156 = u155.KeyCode == Enum.KeyCode.ButtonL1 and -1 or 1;

        for i = 1, u50 do
            if u37[i]:IsEquipped() then
                local v157 = v156 + i;
                local v158 = false;

                if u50 < v157 then
                    v157 = 1;
                    v158 = true;
                elseif v157 < 1 then
                    v157 = u50;
                    v158 = true;
                end;

                local v159 = v157;

                while not u37[v157].Tool do
                    v157 = v157 + v156;

                    if v157 == v159 then
                        return;
                    end;

                    if u50 < v157 then
                        v157 = 1;
                        v158 = true;
                    elseif v157 < 1 then
                        v157 = u50;
                        v158 = true;
                    end;
                end;

                if not v158 then
                    u37[v157]:Select();

                    return;
                end;

                if Humanoid then
                    Humanoid:UnequipTools();

                    if u43 then
                        u43:ToggleSelect();
                        u39[u43]:UpdateEquipView();
                        u43 = nil;
                    end;
                end;

                u52 = nil;

                return;
            end;

            local _ = i;
        end;

        if u52 and u52.Tool then
            u52:Select();

            return;
        end;

        for i = v156 == -1 and (u50 or 1) or 1, v156 == -1 and 1 or u50, v156 do
            if u37[i].Tool then
                u37[i]:Select();

                return;
            end;

            local _ = i;
        end;
    end);
end;

function getGamepadSwapSlot()
    -- upvalues: u37 (copy)
    for i = 1, #u37 do
        if u37[i].Frame.BorderSizePixel > 0 then
            return u37[i];
        end;

        local _ = i;
    end;
end;

function changeSlot(u160)
    -- upvalues: VRService (copy), u31 (ref), GuiService (copy), u32 (ref), u50 (copy)
    if u160.Frame == GuiService.SelectedObject and (not VRService.VREnabled or u31.Visible) then
        local v161 = getGamepadSwapSlot();

        if not v161 then
            local Size = u160.Frame.Size;
            local Position = u160.Frame.Position;
            u160.Frame:TweenSizeAndPosition(Size + UDim2.new(0, 10, 0, 10), Position - UDim2.new(0, 5, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() -- Line: 1377
                -- upvalues: u160 (copy), Size (copy), Position (copy)
                u160.Frame:TweenSizeAndPosition(Size, Position, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true);
            end);
            u160.Frame.BorderSizePixel = 3;
            u32.SelectionImageObject.Visible = true;

            return;
        end;

        v161.Frame.BorderSizePixel = 0;

        if v161 ~= u160 then
            u160:Swap(v161);
            u32.SelectionImageObject.Visible = false;

            if u50 < u160.Index and not u160.Tool then
                if GuiService.SelectedObject == u160.Frame then
                    GuiService.SelectedObject = v161.Frame;
                end;

                u160:Delete();
            end;

            if u50 < v161.Index and not v161.Tool then
                if GuiService.SelectedObject == v161.Frame then
                    GuiService.SelectedObject = u160.Frame;
                end;

                v161:Delete();
            end;
        end;
    else
        u160:Select();
        u32.SelectionImageObject.Visible = false;
    end;
end;

function vrMoveSlotToInventory()
    -- upvalues: VRService (copy), u32 (ref)
    if not VRService.VREnabled then
        return;
    end;

    local v162 = getGamepadSwapSlot();

    if v162 and v162.Tool then
        v162.Frame.BorderSizePixel = 0;
        v162:MoveToInventory();
        u32.SelectionImageObject.Visible = false;
    end;
end;

function enableGamepadInventoryControl()
    -- upvalues: u31 (ref), u24 (copy), ContextActionService (copy), u152 (copy), GuiService (copy), u30 (ref)
    local function v164() -- Line: 1411
        -- upvalues: u31 (ref), u24 (ref)
        if getGamepadSwapSlot() then
            local v163 = getGamepadSwapSlot();

            if v163 then
                v163.Frame.BorderSizePixel = 0;
            end;
        elseif u31.Visible then
            u24:deselect();
        end;
    end;

    ContextActionService:BindAction("BackpackHasGamepadFocus", u152, false, Enum.UserInputType.Gamepad1);
    ContextActionService:BindAction("BackpackCloseInventory", v164, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart);

    if true then
        GuiService.SelectedObject = u30:FindFirstChild("1");
    end;
end;

function disableGamepadInventoryControl()
    -- upvalues: u50 (copy), u37 (copy), GuiService (copy), u29 (ref)
    unbindAllGamepadEquipActions();

    for i = 1, u50 do
        local v165 = u37[i];
        local v166;

        if v165 and v165.Frame then
            v165.Frame.BorderSizePixel = 0;
            v166 = i;
        else
            v166 = i;
        end;
    end;

    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u29) then
        GuiService.SelectedObject = nil;
    end;
end;

local function bindBackpackHotbarAction() -- Line: 1459
    -- upvalues: u45 (ref), u27 (ref), ContextActionService (copy), u35 (ref)
    if u45 and not u27 then
        u27 = true;
        ContextActionService:BindAction("BackpackHotbarEquip", u35, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
    end;
end;

local function unbindBackpackHotbarAction() -- Line: 1472
    -- upvalues: u27 (ref), ContextActionService (copy)
    disableGamepadInventoryControl();
    u27 = false;
    ContextActionService:UnbindAction("BackpackHotbarEquip");
end;

function gamepadDisconnected()
    -- upvalues: u49 (ref)
    u49 = false;
    disableGamepadInventoryControl();
end;

function gamepadConnected()
    -- upvalues: u49 (ref), GuiService (copy), u29 (ref), u42 (ref), u45 (ref), u27 (ref), ContextActionService (copy), u35 (ref), u31 (ref)
    u49 = true;
    GuiService:AddSelectionParent("BackpackSelection", u29);

    if u42 >= 1 and (u45 and not u27) then
        u27 = true;
        ContextActionService:BindAction("BackpackHotbarEquip", u35, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
    end;

    if u31.Visible then
        enableGamepadInventoryControl();
    end;
end;

local function OnIconChanged(p167: boolean) -- Line: 1496
    -- upvalues: StarterGui (copy), u45 (ref), u29 (ref), u42 (ref), u27 (ref), ContextActionService (copy), u35 (ref)
    if p167 then
        p167 = StarterGui:GetCore("TopbarEnabled");
    end;

    u45 = p167;
    u29.Visible = p167;

    if p167 then
        if u42 >= 1 and (u45 and not u27) then
            u27 = true;
            ContextActionService:BindAction("BackpackHotbarEquip", u35, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
        end;
    else
        disableGamepadInventoryControl();
        u27 = false;
        ContextActionService:UnbindAction("BackpackHotbarEquip");
    end;
end;

local function MakeVRRoundButton(p168: string, p169: string) -- Line: 1520
    local ImageButton = Instance.new("ImageButton");
    ImageButton.BackgroundTransparency = 1;
    ImageButton.Name = p168;
    ImageButton.Size = UDim2.new(0, 40, 0, 40);
    ImageButton.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png";
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Icon";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0);
    ImageLabel.Position = UDim2.new(0.25, 0, 0.25, 0);
    ImageLabel.Image = p169;
    ImageLabel.Parent = ImageButton;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Name = "Selection";
    ImageLabel2.Size = UDim2.new(0.9, 0, 0.9, 0);
    ImageLabel2.Position = UDim2.new(0.05, 0, 0.05, 0);
    ImageLabel2.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png";
    ImageButton.SelectionImageObject = ImageLabel2;

    return ImageButton, ImageLabel, ImageLabel2;
end;

u29 = Instance.new("Frame");
u29.BackgroundTransparency = 1;
u29.Name = "Backpack";
u29.Size = UDim2.new(1, 0, 1, 0);
u29.Visible = false;
u29.Parent = ScreenGui;
u30 = Instance.new("Frame");
u30.BackgroundTransparency = 1;
u30.Name = "Hotbar";
u30.Size = UDim2.new(1, 0, 1, 0);
u30.Parent = u29;

for i = 1, u50 do
    local v170 = MakeSlot(u30, i);
    v170.Frame.Visible = false;
    local v171;

    if u38 then
        v171 = i;
    else
        u38 = v170;
        v171 = i;
    end;
end;

local ImageLabel = Instance.new("ImageLabel");
ImageLabel.BackgroundTransparency = 1;
ImageLabel.Name = "LeftBumper";
ImageLabel.Size = UDim2.new(0, 40, 0, 40);
ImageLabel.Position = UDim2.new(0, -ImageLabel.Size.X.Offset, 0.5, -ImageLabel.Size.Y.Offset / 2);
local ImageLabel2 = Instance.new("ImageLabel");
ImageLabel2.BackgroundTransparency = 1;
ImageLabel2.Name = "RightBumper";
ImageLabel2.Size = UDim2.new(0, 40, 0, 40);
ImageLabel2.Position = UDim2.new(1, 0, 0.5, -ImageLabel2.Size.Y.Offset / 2);
u31 = Instance.new("Frame");
u31.Name = "Inventory";
u31.Size = UDim2.new(1, 0, 1, 0);
u31.BackgroundTransparency = u6;
u31.BackgroundColor3 = u7;
u31.Active = true;
u31.Visible = false;
u31.Parent = u29;
local UICorner = Instance.new("UICorner");
UICorner.Name = "Corner";
UICorner.CornerRadius = UDim_new_ret;
UICorner.Parent = u31;
u32 = Instance.new("TextButton");
u32.Name = "VRInventorySelector";
u32.Position = UDim2.new(0, 0, 0, 0);
u32.Size = UDim2.new(1, 0, 1, 0);
u32.BackgroundTransparency = 1;
u32.Text = "";
u32.Parent = u31;
local ImageLabel3 = Instance.new("ImageLabel");
ImageLabel3.BackgroundTransparency = 1;
ImageLabel3.Name = "Selector";
ImageLabel3.Size = UDim2.new(1, 0, 1, 0);
ImageLabel3.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png";
ImageLabel3.ScaleType = Enum.ScaleType.Slice;
ImageLabel3.SliceCenter = Rect.new(12, 12, 52, 52);
ImageLabel3.Visible = false;
u32.SelectionImageObject = ImageLabel3;
u32.MouseButton1Click:Connect(function() -- Line: 1617
    vrMoveSlotToInventory();
end);
u33 = Instance.new("ScrollingFrame");
u33.BackgroundTransparency = 1;
u33.Name = "ScrollingFrame";
u33.Size = UDim2.new(1, 0, 1, 0);
u33.Selectable = false;
u33.ScrollingDirection = Enum.ScrollingDirection.Y;
u33.BorderSizePixel = 0;
u33.ScrollBarThickness = 8;
u33.ScrollBarImageColor3 = Color3.new(1, 1, 1);
u33.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
u33.CanvasSize = UDim2.new(0, 0, 0, 0);
u33.Parent = u31;
u34 = Instance.new("Frame");
u34.BackgroundTransparency = 1;
u34.Name = "UIGridFrame";
u34.Selectable = false;
u34.Size = UDim2.new(1, -10, 1, 0);
u34.Position = UDim2.new(0, 5, 0, 0);
u34.Parent = u33;
local UIGridLayout = Instance.new("UIGridLayout");
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder;
UIGridLayout.CellSize = UDim2.new(0, u26, 0, u26);
UIGridLayout.CellPadding = UDim2.new(0, 5, 0, 5);
UIGridLayout.Parent = u34;
local u172 = MakeVRRoundButton("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png");
u172.Size = UDim2.new(0, 34, 0, 34);
u172.Position = UDim2.new(0.5, -u172.Size.X.Offset / 2, 0, 43);
u172.Icon.Position = u172.Icon.Position - UDim2.new(0, 0, 0, 2);
u172.MouseButton1Click:Connect(function() -- Line: 1654
    -- upvalues: u33 (ref), u26 (ref)
    local Vector2_new = Vector2.new;
    local X = u33.CanvasPosition.X;
    local v173 = u33.CanvasSize.Y.Offset - u33.AbsoluteWindowSize.Y;
    local math_max_ret = math.max(0, u33.CanvasPosition.Y - (u26 + 5));
    u33.CanvasPosition = Vector2_new(X, (math.min(v173, math_max_ret)));
end);
local u174 = MakeVRRoundButton("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png");
u174.Rotation = 180;
u174.Icon.Position = u174.Icon.Position - UDim2.new(0, 0, 0, 2);
u174.Size = UDim2.new(0, 34, 0, 34);
u174.Position = UDim2.new(0.5, -u174.Size.X.Offset / 2, 1, -u174.Size.Y.Offset - 3);
u174.MouseButton1Click:Connect(function() -- Line: 1671
    -- upvalues: u33 (ref), u26 (ref)
    local Vector2_new = Vector2.new;
    local X = u33.CanvasPosition.X;
    local v175 = u33.CanvasSize.Y.Offset - u33.AbsoluteWindowSize.Y;
    local math_max_ret = math.max(0, u33.CanvasPosition.Y + (u26 + 5));
    u33.CanvasPosition = Vector2_new(X, (math.min(v175, math_max_ret)));
end);
u33.Changed:Connect(function(p176: string) -- Line: 1682
    -- upvalues: u33 (ref), u172 (ref), u174 (ref)
    if p176 == "AbsoluteWindowSize" or (p176 == "CanvasPosition" or p176 == "CanvasSize") then
        local v177 = u33.CanvasPosition.Y < u33.CanvasSize.Y.Offset - u33.AbsoluteWindowSize.Y;
        u172.Visible = u33.CanvasPosition.Y ~= 0;
        u174.Visible = v177;
    end;
end);
UpdateBackpackLayout();
local Frame = Instance.new("Frame");
Frame.Name = "GamepadHintsFrame";
Frame.Size = UDim2.new(0, u30.Size.X.Offset, 0, u25 and 95 or 60);
Frame.BackgroundTransparency = u6;
Frame.BackgroundColor3 = u7;
Frame.Visible = false;
Frame.Parent = u29;
local UIListLayout = Instance.new("UIListLayout");
UIListLayout.Name = "Layout";
UIListLayout.Padding = UDim.new(0, 25);
UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
UIListLayout.Parent = Frame;
local UICorner2 = Instance.new("UICorner");
UICorner2.Name = "Corner";
UICorner2.CornerRadius = UDim_new_ret;
UICorner2.Parent = Frame;

local function addGamepadHint(p178: string, p179: string) -- Line: 1718
    -- upvalues: Frame (copy), u25 (copy), u19 (copy)
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "HintFrame";
    Frame2.AutomaticSize = Enum.AutomaticSize.XY;
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = Frame;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.Name = "Layout";
    UIListLayout2.Padding = u25 and UDim.new(0, 20) or UDim.new(0, 12);
    UIListLayout2.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout2.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout2.Parent = Frame2;
    local ImageLabel4 = Instance.new("ImageLabel");
    ImageLabel4.Name = "HintImage";
    ImageLabel4.Size = u25 and UDim2.new(0, 60, 0, 60) or UDim2.new(0, 30, 0, 30);
    ImageLabel4.BackgroundTransparency = 1;
    ImageLabel4.Image = p178;
    ImageLabel4.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "HintText";
    TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
    TextLabel.FontFace = Font.new(u19.Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    TextLabel.TextSize = u25 and 32 or 19;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = p179;
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
    TextLabel.TextWrapped = true;
    TextLabel.Parent = Frame2;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = TextLabel.TextSize;
    UITextSizeConstraint.Parent = TextLabel;
end;

addGamepadHint(UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonX), "Remove From Hotbar");
addGamepadHint(UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonA), "Select/Swap");
addGamepadHint(UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonB), "Close Backpack");

local function resizeGamepadHintsFrame() -- Line: 1762
    -- upvalues: Frame (copy), u30 (ref), u25 (copy), u31 (ref)
    Frame.Size = UDim2.new(u30.Size.X.Scale, u30.Size.X.Offset, 0, u25 and 95 or 60);
    Frame.Position = UDim2.new(u30.Position.X.Scale, u30.Position.X.Offset, u31.Position.Y.Scale, u31.Position.Y.Offset - Frame.Size.Y.Offset - 5);
    local Children = Frame:GetChildren();
    local v180 = {};
    local v181 = 0;

    for _, v in pairs(Children) do
        if v:IsA("GuiObject") then
            table.insert(v180, v);
        end;
    end;

    for i = 1, #v180 do
        local v182;

        if v180[i]:IsA("GuiObject") then
            v180[i].Size = UDim2.new(1, 0, 1, -5);
            v180[i].Position = UDim2.new(0, 0, 0, 0);
            v181 = v181 + (v180[i].HintText.Position.X.Offset + v180[i].HintText.TextBounds.X);
            v182 = i;
        else
            v182 = i;
        end;
    end;

    local v183 = (Frame.AbsoluteSize.X - v181) / (#v180 - 1);

    for i = 1, #v180 do
        v180[i].Position = i == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0, v180[i - 1].Position.X.Offset + v180[i - 1].Size.X.Offset + v183, 0, 0);
        v180[i].Size = UDim2.new(0, v180[i].HintText.Position.X.Offset + v180[i].HintText.TextBounds.X, 1, -5);
        local _ = i;
    end;
end;

local Frame2 = Instance.new("Frame");
Frame2.Name = "Search";
Frame2.BackgroundColor3 = Color3_new_ret2;
Frame2.BackgroundTransparency = u18;
Frame2.Size = UDim2.new(0, 190, 0, 30);
Frame2.Position = UDim2.new(1, -Frame2.Size.X.Offset - 5, 0, 5);
Frame2.Parent = u31;
local UICorner3 = Instance.new("UICorner");
UICorner3.Name = "Corner";
UICorner3.CornerRadius = UDim_new_ret2;
UICorner3.Parent = Frame2;
local UIStroke = Instance.new("UIStroke");
UIStroke.Name = "Border";
UIStroke.Color = Color3_new_ret3;
UIStroke.Thickness = 1;
UIStroke.Transparency = 0.8;
UIStroke.Parent = Frame2;
local TextBox = Instance.new("TextBox");
TextBox.BackgroundTransparency = 1;
TextBox.Name = "TextBox";
TextBox.Text = "";
TextBox.TextColor3 = u15;
TextBox.TextStrokeTransparency = u16;
TextBox.TextStrokeColor3 = u17;
TextBox.FontFace = Font.new(u19.Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal);
TextBox.PlaceholderText = "Search";
TextBox.TextColor3 = u15;
TextBox.TextTransparency = u16;
TextBox.TextStrokeColor3 = u17;
TextBox.ClearTextOnFocus = false;
TextBox.TextTruncate = Enum.TextTruncate.AtEnd;
TextBox.TextSize = u20;
TextBox.TextXAlignment = Enum.TextXAlignment.Left;
TextBox.TextYAlignment = Enum.TextYAlignment.Center;
TextBox.Size = UDim2.new(0, 154, 0, 14);
TextBox.AnchorPoint = Vector2.new(0, 0.5);
TextBox.Position = UDim2.new(0, 8, 0.5, 0);
TextBox.ZIndex = 2;
TextBox.Parent = Frame2;
local TextButton = Instance.new("TextButton");
TextButton.Name = "X";
TextButton.Text = "";
TextButton.Size = UDim2.new(0, 30, 0, 30);
TextButton.Position = UDim2.new(1, -TextButton.Size.X.Offset, 0.5, -TextButton.Size.Y.Offset / 2);
TextButton.ZIndex = 4;
TextButton.Visible = false;
TextButton.BackgroundTransparency = 1;
TextButton.Parent = Frame2;
local ImageButton = Instance.new("ImageButton");
ImageButton.Name = "X";
ImageButton.Image = "rbxasset://textures/ui/InspectMenu/x.png";
ImageButton.BackgroundTransparency = 1;
ImageButton.Size = UDim2.new(0, Frame2.Size.Y.Offset - 20, 0, Frame2.Size.Y.Offset - 20);
ImageButton.AnchorPoint = Vector2.new(0.5, 0.5);
ImageButton.Position = UDim2.new(0.5, 0, 0.5, 0);
ImageButton.ZIndex = 1;
ImageButton.BorderSizePixel = 0;
ImageButton.Parent = TextButton;

local function search() -- Line: 1899
    -- upvalues: TextBox (copy), u50 (copy), u37 (copy), u31 (ref), u47 (ref), u34 (ref), u33 (ref), UpdateScrollingFrameCanvasSize (copy), TextButton (copy)
    local v184 = {};

    for i in TextBox.Text:gmatch("%S+") do
        v184[i:lower()] = true;
    end;

    local v185 = {};

    for i = u50 + 1, #u37 do
        local v186 = u37[i];
        local v187 = { v186, (v186:CheckTerms(v184)) };
        table.insert(v185, v187);
        v186.Frame.Visible = false;
        v186.Frame.Parent = u31;
        local _ = i;
    end;

    table.sort(v185, function(p188, p189) -- Line: 1914
        return p188[2] > p189[2];
    end);
    u47 = true;
    local v190 = 0;

    for _, v in ipairs(v185) do
        local v191 = v[1];

        if v[2] > 0 then
            v191.Frame.Visible = true;
            v191.Frame.Parent = u34;
            v191.Frame.LayoutOrder = u50 + v190;
            v190 = v190 + 1;
        end;
    end;

    u33.CanvasPosition = Vector2.new(0, 0);
    UpdateScrollingFrameCanvasSize();
    TextButton.ZIndex = 3;
end;

local function clearResults() -- Line: 1936
    -- upvalues: TextButton (copy), u47 (ref), u50 (copy), u37 (copy), u34 (ref), UpdateScrollingFrameCanvasSize (copy)
    if TextButton.ZIndex > 0 then
        u47 = false;

        for i = u50 + 1, #u37 do
            local v192 = u37[i];
            v192.Frame.LayoutOrder = v192.Index;
            v192.Frame.Parent = u34;
            v192.Frame.Visible = true;
            local _ = i;
        end;

        TextButton.ZIndex = 0;
    end;

    UpdateScrollingFrameCanvasSize();
end;

TextButton.MouseButton1Click:Connect(function() -- Line: 1950, Name: reset
    -- upvalues: clearResults (copy), TextBox (copy)
    clearResults();
    TextBox.Text = "";
end);
TextBox.Changed:Connect(function(p193: string) -- Line: 1955, Name: onChanged
    -- upvalues: TextBox (copy), u16 (copy), clearResults (copy), search (copy), TextButton (copy)
    if p193 == "Text" then
        local Text = TextBox.Text;

        if Text == "" then
            TextBox.TextTransparency = u16;
            clearResults();
        elseif Text ~= "" then
            TextBox.TextTransparency = 0;
            search();
        end;

        local v194;

        if Text == "" then
            v194 = false;
        else
            v194 = Text ~= "";
        end;

        TextButton.Visible = v194;
    end;
end);
TextBox.FocusLost:Connect(function(p195: boolean) -- Line: 1969, Name: focusLost
    -- upvalues: search (copy)
    if p195 then
        search();
    end;
end);
u1.StateChanged.Event:Connect(function(p196: boolean) -- Line: 1980
    -- upvalues: clearResults (copy), TextBox (copy)
    if not p196 then
        clearResults();
        TextBox.Text = "";
    end;
end);

u40[Enum.KeyCode.Escape.Value] = function(p197) -- Line: 1988
    -- upvalues: clearResults (copy), TextBox (copy)
    if p197 then
        clearResults();
        TextBox.Text = "";
    end;
end;

UserInputService.LastInputTypeChanged:Connect(function(p198) -- Line: 1993, Name: detectGamepad
    -- upvalues: UserInputService (copy), Frame2 (copy)
    if p198 == Enum.UserInputType.Gamepad1 and not UserInputService.VREnabled then
        Frame2.Visible = false;

        return;
    end;

    Frame2.Visible = true;
end);
GuiService.MenuOpened:Connect(function() -- Line: 2004
    -- upvalues: ScreenGui (copy), u24 (copy)
    ScreenGui.Enabled = false;
    u24:setEnabled(false);
end);
GuiService.MenuClosed:Connect(function() -- Line: 2010
    -- upvalues: ScreenGui (copy), u24 (copy)
    ScreenGui.Enabled = true;
    u24:setEnabled(true);
end);

local function u202(p199: string, p200: any, p201: userdata) -- Line: 2017
    -- upvalues: GuiService (copy), u50 (copy), u37 (copy)
    if p200 ~= Enum.UserInputState.Begin then
        return;
    end;

    if not GuiService.SelectedObject then
        return;
    end;

    for i = 1, u50 do
        if u37[i].Frame == GuiService.SelectedObject and u37[i].Tool then
            u37[i]:MoveToInventory();

            return;
        end;

        local _ = i;
    end;
end;

local function openClose() -- Line: 2033
    -- upvalues: u41 (copy), u31 (ref), AdjustHotbarFrames (copy), u30 (ref), u50 (copy), u37 (copy), u49 (ref), u22 (copy), UserInputService (copy), resizeGamepadHintsFrame (copy), Frame (copy), ContextActionService (copy), u202 (copy), u1 (copy)
    if not next(u41) then
        u31.Visible = not u31.Visible;
        local Visible = u31.Visible;
        AdjustHotbarFrames();
        u30.Active = not u30.Active;

        for i = 1, u50 do
            u37[i]:SetClickability(not Visible);
            local _ = i;
        end;
    end;

    if u31.Visible then
        if u49 then
            if u22[UserInputService:GetLastInputType()] then
                resizeGamepadHintsFrame();
                Frame.Visible = not UserInputService.VREnabled;
            end;

            enableGamepadInventoryControl();
        end;
    else
        if u49 then
            Frame.Visible = false;
        end;

        disableGamepadInventoryControl();
    end;

    if u31.Visible then
        ContextActionService:BindAction("BackpackRemoveSlot", u202, false, Enum.KeyCode.ButtonX);
    else
        ContextActionService:UnbindAction("BackpackRemoveSlot");
    end;

    u1.IsOpen = u31.Visible;
    u1.StateChanged:Fire(u31.Visible);
end;

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
u1.OpenClose = openClose;

while not LocalPlayer do
    task.wait();
    LocalPlayer = Players.LocalPlayer;
end;

LocalPlayer.CharacterAdded:Connect(OnCharacterAdded);

if LocalPlayer.Character then
    OnCharacterAdded(LocalPlayer.Character);
end;

UserInputService.InputBegan:Connect(OnInputBegan);
UserInputService.TextBoxFocused:Connect(function() -- Line: 2096
    -- upvalues: u46 (ref)
    u46 = true;
end);
UserInputService.TextBoxFocusReleased:Connect(function() -- Line: 2099
    -- upvalues: u46 (ref)
    u46 = false;
end);

u40[Value] = function() -- Line: 2104
    -- upvalues: u43 (ref), Humanoid (ref), u39 (copy)
    if u43 and Humanoid then
        Humanoid:UnequipTools();

        if u43 then
            u43:ToggleSelect();
            u39[u43]:UpdateEquipView();
            u43 = nil;
        end;
    end;
end;

UserInputService.LastInputTypeChanged:Connect(OnUISChanged);
OnUISChanged();

if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
    gamepadConnected();
end;

UserInputService.GamepadConnected:Connect(function(p203) -- Line: 2118
    if p203 == Enum.UserInputType.Gamepad1 then
        gamepadConnected();
    end;
end);
UserInputService.GamepadDisconnected:Connect(function(p204) -- Line: 2123
    if p204 == Enum.UserInputType.Gamepad1 then
        gamepadDisconnected();
    end;
end);

function u1.SetBackpackEnabled(p205: table, p206: boolean) -- Line: 2131
    -- upvalues: u23 (ref)
    u23 = p206;
end;

function u1.IsOpened(p207) -- Line: 2136
    -- upvalues: u1 (copy)
    return u1.IsOpen;
end;

function u1.GetBackpackEnabled(p208) -- Line: 2141
    -- upvalues: u23 (ref)
    return u23;
end;

function u1.GetStateChangedEvent(p209) -- Line: 2146
    -- upvalues: u1 (copy)
    return u1.StateChanged;
end;

RunService.Heartbeat:Connect(function() -- Line: 2151
    -- upvalues: u23 (ref), StarterGui (copy), u45 (ref), u29 (ref), u42 (ref), u27 (ref), ContextActionService (copy), u35 (ref)
    local v210 = u23 and StarterGui:GetCore("TopbarEnabled");
    u45 = v210;
    u29.Visible = v210;

    if v210 then
        if u42 >= 1 and (u45 and not u27) then
            u27 = true;
            ContextActionService:BindAction("BackpackHotbarEquip", u35, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
        end;
    else
        disableGamepadInventoryControl();
        u27 = false;
        ContextActionService:UnbindAction("BackpackHotbarEquip");
    end;
end);

local function OnPreferredTransparencyChanged() -- Line: 2156
    -- upvalues: GuiService (copy), u6 (ref), u5 (copy), u31 (ref), u10 (ref), u9 (copy), u37 (copy), u18 (ref), Frame2 (copy)
    local PreferredTransparency = GuiService.PreferredTransparency;
    u6 = u5 * PreferredTransparency;
    u31.BackgroundTransparency = u6;
    u10 = u9 * PreferredTransparency;

    for _, v in ipairs(u37) do
        v.Frame.BackgroundTransparency = u10;
    end;

    u18 = PreferredTransparency * 0.2;
    Frame2.BackgroundTransparency = u18;
end;

GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(OnPreferredTransparencyChanged);

return u1;