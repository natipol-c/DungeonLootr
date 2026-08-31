--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     MenuButtons
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.MenuButtons
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local UIController = require(script.Parent.Parent.Controllers.UIController);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local v1 = {};
local u2 = nil;
local u3 = {
    Battlepass = "rbxassetid://113058620605410",
    Quests = "rbxassetid://107709086972637",
    Shop = "rbxassetid://102491975116144",
    Inventory = "rbxassetid://116530138711283",
    Codes = "rbxassetid://98551072671662",
    Titles = "rbxassetid://78316440717208",
    Class = "rbxassetid://112946047881086",
    Dungeon = "rbxassetid://107632890324632",
    Forge = "rbxassetid://136802788787936",
    Settings = "rbxassetid://82442016069045",
    Updates = ""
};
local u4 = { {
        key = "Battlepass",
        label = "Battlepass",
        frame = "Battlepass"
    }, {
        key = "Quests",
        label = "Quests",
        frame = "Quests"
    }, {
        key = "Shop",
        label = "Shop",
        frame = "Shop"
    }, {
        key = "Inventory",
        label = "Inventory",
        frame = "Inventory"
    }, {
        key = "Codes",
        label = "Codes",
        frame = "Codes"
    }, {
        key = "Updates",
        label = "Updates",
        notes = true
    }, {
        key = "Titles",
        label = "Titles",
        frame = "TitleIndex"
    }, {
        key = "Class",
        label = "Class",
        frame = "Class"
    }, {
        key = "Dungeon",
        label = "Dungeon",
        warp = "Play"
    }, {
        key = "Forge",
        label = "Forge",
        warp = "Forge"
    }, {
        key = "Settings",
        label = "Settings",
        settings = true
    } };

local function getOrCreateWindow(p5) -- Line: 77
    -- upvalues: u2 (ref), UIController (copy)
    local v6 = u2.Frames:FindFirstChild(p5);

    if not v6 then
        warn((`[MenuButtons] Frames.{p5} not found — skipping`));

        return nil;
    end;

    local u7 = UIController.getByName(p5) or UIController._cached[v6];

    if not u7 then
        u7 = UIController.new(v6);
        local v8 = v6:FindFirstChild("Exit", true) or v6:FindFirstChild("Close", true);

        if v8 and v8:IsA("GuiButton") then
            v8.MouseButton1Click:Connect(function() -- Line: 88
                -- upvalues: u7 (ref)
                u7:close();
            end);
        end;
    end;

    return u7;
end;

local function handleMenu(p9, p10) -- Line: 97
    -- upvalues: getOrCreateWindow (copy), Knit (copy)
    if p9.frame then
        local v11 = getOrCreateWindow(p9.frame);

        if v11 then
            v11:open();
        end;

        return;
    end;

    p10:close();

    if p9.notes then
        local success, result = pcall(require, script.Parent.PatchNotes);

        if success and (result and result.Open) then
            result.Open();
        end;
    elseif p9.warp then
        local Controller = Knit.GetController("AreaWarpController");

        if Controller then
            Controller:WarpToArea(p9.warp);
        end;
    else
        local v12 = p9.settings and Knit.GetController("SettingsController");

        if v12 then
            v12:ToggleSettings();
        end;
    end;
end;

function v1._Init(p13) -- Line: 129
    -- upvalues: u2 (ref), UIController (copy), u4 (copy), u3 (copy), handleMenu (copy), Registry (copy)
    u2 = p13;
    local MenuButtons = u2.Frames:FindFirstChild("MenuButtons");

    if not MenuButtons then
        warn("[MenuButtons] Frames.MenuButtons not found — skipping");

        return;
    end;

    local Content = MenuButtons:FindFirstChild("Content");

    if Content then
        Content = Content:FindFirstChild("ButtonContainer");
    end;

    local v14;

    if Content then
        v14 = Content:FindFirstChild("Template");
    else
        v14 = Content;
    end;

    if not v14 then
        warn("[MenuButtons] Content.ButtonContainer.Template not found — skipping");

        return;
    end;

    v14.Visible = false;
    MenuButtons.Visible = false;
    local u15 = UIController.getByName("MenuButtons") or UIController.new(MenuButtons);
    local Exit = MenuButtons:FindFirstChild("Exit", true);

    if Exit and Exit:IsA("GuiButton") then
        Exit.MouseButton1Click:Connect(function() -- Line: 152
            -- upvalues: u15 (copy)
            u15:close();
        end);
    end;

    local More = u2.HUD.Actions.Left.Buttons:FindFirstChild("More");

    if More and More:IsA("GuiButton") then
        More.Activated:Connect(function() -- Line: 161
            -- upvalues: u15 (copy)
            u15:toggle();
        end);
    else
        warn("[MenuButtons] Left.Buttons.More button not found");
    end;

    local u16 = {};

    for i, v in ipairs(u4) do
        local v17 = v14:Clone();
        v17.Name = v.key;
        v17.LayoutOrder = i;
        v17.Visible = true;
        local ImageLabel = v17:FindFirstChild("ImageLabel");

        if ImageLabel then
            ImageLabel.Image = u3[v.key] or "";
        end;

        local ButtonName = v17:FindFirstChild("ButtonName");

        if ButtonName and ButtonName:IsA("TextLabel") then
            ButtonName.Text = v.label;
        end;

        local Notification = v17:FindFirstChild("Notification");

        if Notification then
            Notification.Visible = false;
            u16[v.key] = Notification;
        end;

        v17.Activated:Connect(function() -- Line: 193
            -- upvalues: handleMenu (ref), v (copy), u15 (copy)
            handleMenu(v, u15);
        end);
        v17.Parent = Content;
    end;

    local u18;

    if More then
        u18 = More:FindFirstChild("Notification");
    else
        u18 = More;
    end;

    local function moduleClaimable(p19: string, p20: string) -- Line: 209
        local success, result = pcall(require, script.Parent:FindFirstChild(p19));

        if not success or (type(result) ~= "table" or type(result[p20]) ~= "function") then
            return false;
        end;

        local success2, result2 = pcall(result[p20]);

        if success2 then
            success2 = result2 == true;
        end;

        return success2;
    end;

    local function refreshNotices() -- Line: 218
        -- upvalues: moduleClaimable (copy), u16 (copy), u18 (copy)
        local v21 = moduleClaimable("Quests", "HasClaimable");
        local v22 = moduleClaimable("Battlepass", "HasNotice");

        if u16.Quests then
            u16.Quests.Visible = v21;
        end;

        if u16.Battlepass then
            u16.Battlepass.Visible = v22;
        end;

        if u18 then
            u18.Visible = v21 or v22;
        end;
    end;

    task.defer(refreshNotices);
    local v23 = Registry:Get("PlayerData");

    if v23 then
        v23:OnChange(function(p24, p25) -- Line: 232
            -- upvalues: moduleClaimable (copy), u16 (copy), u18 (copy)
            if p25[1] == "Quests" or p25[1] == "Battlepass" then
                local v26 = moduleClaimable("Quests", "HasClaimable");
                local v27 = moduleClaimable("Battlepass", "HasNotice");

                if u16.Quests then
                    u16.Quests.Visible = v26;
                end;

                if u16.Battlepass then
                    u16.Battlepass.Visible = v27;
                end;

                if u18 then
                    u18.Visible = v26 or v27;
                end;
            end;
        end);
    end;

    if More and More:IsA("GuiButton") then
        More.Activated:Connect(refreshNotices);
    end;
end;

return v1;