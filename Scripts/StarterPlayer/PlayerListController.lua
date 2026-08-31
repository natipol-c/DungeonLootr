--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PlayerListController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.PlayerListController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local HeadShot = Enum.ThumbnailType.HeadShot;
local Size100x100 = Enum.ThumbnailSize.Size100x100;
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(80, 220, 100);
local u1 = Knit.CreateController({
    Name = "PlayerListController"
});
local LocalPlayer = Players.LocalPlayer;
local u2 = {};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = false;
local u11 = nil;
local u12 = {};
local u13 = {};
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = {};

local function GetThumbnail(u18: number) -- Line: 102
    -- upvalues: u2 (copy), Players (copy), HeadShot (copy), Size100x100 (copy)
    local v19 = u2[u18];

    if v19 and v19 ~= "" then
        return v19;
    end;

    local success, result = pcall(function() -- Line: 108
        -- upvalues: Players (ref), u18 (copy), HeadShot (ref), Size100x100 (ref)
        return Players:GetUserThumbnailAsync(u18, HeadShot, Size100x100);
    end);
    local v20 = success and result and result or "";

    if v20 ~= "" then
        u2[u18] = v20;
    end;

    return v20;
end;

local function PrewarmThumbnail(p21: number) -- Line: 120
    -- upvalues: u2 (copy), GetThumbnail (copy)
    if u2[p21] then
        return;
    end;

    task.spawn(GetThumbnail, p21);
end;

local function SetRowSelected(p22: userdata, p23: boolean) -- Line: 126
    -- upvalues: Color3_fromRGB_ret (copy)
    local SelectionStroke = p22:FindFirstChild("SelectionStroke");

    if not SelectionStroke then
        if not p23 then
            return;
        end;

        SelectionStroke = Instance.new("UIStroke");
        SelectionStroke.Name = "SelectionStroke";
        SelectionStroke.Thickness = 2.5;
        SelectionStroke.Color = Color3_fromRGB_ret;
        SelectionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        SelectionStroke.Parent = p22;
    end;

    SelectionStroke.Enabled = p23;
end;

local function FitCanvas() -- Line: 142
    -- upvalues: u7 (ref)
    if not u7:IsA("ScrollingFrame") then
        return;
    end;

    if u7.AutomaticCanvasSize == Enum.AutomaticSize.Y then
        return;
    end;

    local v24 = u7:FindFirstChildWhichIsA("UIListLayout");

    if v24 then
        u7.CanvasSize = UDim2.new(0, 0, 0, v24.AbsoluteContentSize.Y + 10);
    end;
end;

local function ShowPlaceholder() -- Line: 156
    -- upvalues: u14 (ref), u8 (ref), u7 (ref)
    if u14 and u14.Parent then
        return;
    end;

    if not (u8 and u7) then
        return;
    end;

    local v25 = u8:Clone();
    v25.Name = "LoadingPlaceholder";
    v25.LayoutOrder = 1;
    v25.Visible = true;

    if v25:IsA("GuiButton") then
        v25.AutoButtonColor = false;
        v25.Active = false;
    end;

    local PlayerName = v25:FindFirstChild("PlayerName", true);

    if PlayerName then
        PlayerName.Text = "Loading...";
    end;

    local PlayerImage = v25:FindFirstChild("PlayerImage", true);

    if PlayerImage then
        PlayerImage.Image = "";
    end;

    u14 = v25;
    v25.Parent = u7;
end;

local function HidePlaceholder() -- Line: 179
    -- upvalues: u14 (ref)
    if u14 then
        if u14.Parent then
            u14:Destroy();
        end;

        u14 = nil;
    end;
end;

local function UpdatePlaceholder() -- Line: 187
    -- upvalues: u12 (copy), ShowPlaceholder (copy), u14 (ref)
    if next(u12) == nil then
        ShowPlaceholder();

        return;
    end;

    if u14 then
        if u14.Parent then
            u14:Destroy();
        end;

        u14 = nil;
    end;
end;

local function EnsureRow(p26: userdata) -- Line: 198
    -- upvalues: u12 (copy), u8 (ref), u2 (copy), Players (copy), HeadShot (copy), Size100x100 (copy), u15 (ref), Color3_fromRGB_ret (copy), u1 (copy), u7 (ref)
    local UserId = p26.UserId;
    local v27 = u12[UserId];

    if v27 and v27.Parent then
        return;
    end;

    local v28 = u8:Clone();
    v28.Name = "Row_" .. UserId;
    v28.LayoutOrder = #u12 + 1;
    v28.Visible = true;
    u12[UserId] = v28;
    local PlayerName = v28:FindFirstChild("PlayerName", true);

    if PlayerName then
        PlayerName.Text = "@" .. p26.Name;
    end;

    local PlayerImage = v28:FindFirstChild("PlayerImage", true);

    if PlayerImage then
        local v29 = u2[UserId];

        if v29 and v29 ~= "" then
            PlayerImage.Image = v29;
        else
            PlayerImage.Image = "";
            task.spawn(function() -- Line: 221
                -- upvalues: UserId (copy), u2 (ref), Players (ref), HeadShot (ref), Size100x100 (ref), PlayerImage (copy)
                local u30 = UserId;
                local v31 = u2[u30];

                if not v31 or v31 == "" then
                    local success, result = pcall(function() -- Line: 108
                        -- upvalues: Players (ref), u30 (copy), HeadShot (ref), Size100x100 (ref)
                        return Players:GetUserThumbnailAsync(u30, HeadShot, Size100x100);
                    end);
                    v31 = success and result and result or "";

                    if v31 ~= "" then
                        u2[u30] = v31;
                    end;
                end;

                if PlayerImage.Parent and v31 ~= "" then
                    PlayerImage.Image = v31;
                end;
            end);
        end;
    end;

    local v32 = u15 == UserId;
    local SelectionStroke = v28:FindFirstChild("SelectionStroke");

    if not SelectionStroke then
        if not v32 then
            if v28:IsA("GuiButton") then
                v28.Activated:Connect(function() -- Line: 234
                    -- upvalues: u1 (ref), UserId (copy)
                    u1:_OnRowActivated(UserId);
                end);
            end;

            v28.Parent = u7;

            return;
        end;

        SelectionStroke = Instance.new("UIStroke");
        SelectionStroke.Name = "SelectionStroke";
        SelectionStroke.Thickness = 2.5;
        SelectionStroke.Color = Color3_fromRGB_ret;
        SelectionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        SelectionStroke.Parent = v28;
    end;

    SelectionStroke.Enabled = v32;

    if v28:IsA("GuiButton") then
        v28.Activated:Connect(function() -- Line: 234
            -- upvalues: u1 (ref), UserId (copy)
            u1:_OnRowActivated(UserId);
        end);
    end;

    v28.Parent = u7;
end;

local function RefreshRows() -- Line: 243
    -- upvalues: u10 (ref), u7 (ref), u8 (ref), Players (copy), LocalPlayer (copy), EnsureRow (copy), u12 (copy), u15 (ref), u13 (copy), ShowPlaceholder (copy), u14 (ref), FitCanvas (copy)
    if not u10 then
        return;
    end;

    if not (u7 and u8) then
        return;
    end;

    local v33 = {};

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer then
            v33[v.UserId] = true;
            EnsureRow(v);
        end;
    end;

    for i, v in u12 do
        if not v33[i] then
            if u15 == i then
                u15 = nil;
            end;

            u13[i] = nil;

            if v and v.Parent then
                v:Destroy();
            end;

            u12[i] = nil;
        end;
    end;

    if next(u12) == nil then
        ShowPlaceholder();
    elseif u14 then
        if u14.Parent then
            u14:Destroy();
        end;

        u14 = nil;
    end;

    FitCanvas();
end;

local function ClearRows() -- Line: 271
    -- upvalues: u12 (copy), u13 (copy), u14 (ref)
    for _, v in u12 do
        if v and v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u12);
    table.clear(u13);

    if u14 then
        if u14.Parent then
            u14:Destroy();
        end;

        u14 = nil;
    end;
end;

function u1._OnRowActivated(p34: table, p35: number) -- Line: 282
    -- upvalues: u13 (copy), Players (copy), RefreshRows (copy), u11 (ref)
    if u13[p35] then
        return;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p35);

    if not PlayerByUserId then
        RefreshRows();

        return;
    end;

    p34:SetSelected(p35);
    local v36 = u11;

    if v36 and v36.OnSelect then
        task.spawn(v36.OnSelect, PlayerByUserId);
    end;

    if v36 and v36.MarkInvitedOnSelect then
        p34:MarkInvited(p35);

        return;
    end;

    if not v36 or v36.CloseOnSelect ~= false then
        p34:Close();
    end;
end;

function u1.SetSelected(p37: table, p38: number?) -- Line: 316
    -- upvalues: u15 (ref), u12 (copy), Color3_fromRGB_ret (copy)
    u15 = p38;

    for i, v in u12 do
        local v39 = i == p38;
        local SelectionStroke = v:FindFirstChild("SelectionStroke");

        if SelectionStroke then
            SelectionStroke.Enabled = v39;
        elseif v39 then
            SelectionStroke = Instance.new("UIStroke");
            SelectionStroke.Name = "SelectionStroke";
            SelectionStroke.Thickness = 2.5;
            SelectionStroke.Color = Color3_fromRGB_ret;
            SelectionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            SelectionStroke.Parent = v;
            SelectionStroke.Enabled = v39;
        end;
    end;
end;

function u1.MarkInvited(p40: table, u41: number) -- Line: 325
    -- upvalues: u12 (copy), u13 (copy), Color3_fromRGB_ret2 (copy), u1 (copy)
    local v42 = u12[u41];

    if not v42 then
        return;
    end;

    local PlayerName = v42:FindFirstChild("PlayerName", true);

    if not PlayerName then
        return;
    end;

    local v43 = u13[u41];
    local u44 = (v43 and (v43.Token or 0) or 0) + 1;
    u13[u41] = {
        Token = u44,
        Color = v43 and v43.Color or PlayerName.TextColor3
    };
    PlayerName.Text = "Invited...";
    PlayerName.TextColor3 = Color3_fromRGB_ret2;
    task.delay(32, function() -- Line: 341
        -- upvalues: u13 (ref), u41 (copy), u44 (copy), u1 (ref)
        local v45 = u13[u41];

        if v45 and v45.Token == u44 then
            u1:ResetInvited(u41);
        end;
    end);
end;

function u1.ResetInvited(p46: table, p47: number) -- Line: 351
    -- upvalues: u13 (copy), u12 (copy), Players (copy)
    local v48 = u13[p47];

    if not v48 then
        return;
    end;

    u13[p47] = nil;
    local v49 = u12[p47];

    if not v49 then
        return;
    end;

    local PlayerName = v49:FindFirstChild("PlayerName", true);

    if not PlayerName then
        return;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p47);
    PlayerName.Text = PlayerByUserId and "@" .. PlayerByUserId.Name or "@Player";
    PlayerName.TextColor3 = v48.Color;
end;

function u1.IsOpen(p50) -- Line: 366
    -- upvalues: u10 (ref)
    return u10;
end;

function u1.Open(p51, p52) -- Line: 371
    -- upvalues: u3 (ref), u11 (ref), u15 (ref), u4 (ref), u5 (ref), ClearRows (copy), RefreshRows (copy), u10 (ref), u9 (ref), TweenService (copy), TweenInfo_new_ret (copy), u17 (copy), Players (copy), u16 (ref)
    if not u3 then
        warn("[PlayerListController] PlayerList frame not found — cannot open");

        return;
    end;

    u11 = p52 or {};
    u15 = u11.SelectedUserId;

    if u4 then
        u4.Text = u11.Header or "PLAYERS";
    end;

    if u5 then
        u5.Text = u11.Subtitle or "Select a Player";
    end;

    ClearRows();
    RefreshRows();
    u10 = true;
    u3.Visible = true;

    if u9 then
        u9.Scale = 0.85;
        TweenService:Create(u9, TweenInfo_new_ret, {
            Scale = 1
        }):Play();
    end;

    table.insert(u17, Players.PlayerAdded:Connect(RefreshRows));
    table.insert(u17, Players.PlayerRemoving:Connect(function() -- Line: 402
        -- upvalues: RefreshRows (ref)
        task.defer(RefreshRows);
    end));

    if u16 then
        pcall(task.cancel, u16);
    end;

    u16 = task.spawn(function() -- Line: 408
        -- upvalues: u10 (ref), RefreshRows (ref)
        while u10 do
            task.wait(3);
            RefreshRows();
        end;
    end);
end;

function u1.Close(p53) -- Line: 417
    -- upvalues: u10 (ref), u16 (ref), u17 (copy), ClearRows (copy), u15 (ref), u11 (ref), u3 (ref)
    if not u10 then
        return;
    end;

    u10 = false;

    if u16 then
        pcall(task.cancel, u16);
        u16 = nil;
    end;

    for _, v in u17 do
        v:Disconnect();
    end;

    table.clear(u17);
    ClearRows();
    u15 = nil;
    u11 = nil;

    if u3 then
        u3.Visible = false;
    end;
end;

local function ResolveTitleLabels(p54: userdata) -- Line: 442
    -- upvalues: u4 (ref), u5 (ref)
    if not p54 then
        return;
    end;

    local v55 = {};

    for _, child in p54:GetChildren() do
        if child:IsA("TextLabel") then
            table.insert(v55, child);
        end;
    end;

    for _, v in v55 do
        if v.TextXAlignment == Enum.TextXAlignment.Left and not u4 then
            u4 = v;
        elseif v.TextXAlignment == Enum.TextXAlignment.Center and not u5 then
            u5 = v;
        end;
    end;

    u4 = u4 or v55[1];
    u5 = u5 or v55[2];
end;

function u1.KnitInit(p56) -- Line: 462
    -- upvalues: Knit (copy), u3 (ref), u9 (ref), ResolveTitleLabels (copy), u6 (ref), u7 (ref), u8 (ref)
    u3 = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("Frames"):FindFirstChild("PlayerList");

    if not u3 then
        warn("[PlayerListController] PlayerList frame not found in Main.Frames");

        return;
    end;

    u3.Visible = false;
    u9 = u3:FindFirstChildWhichIsA("UIScale") or Instance.new("UIScale");
    u9.Parent = u3;
    ResolveTitleLabels(u3:FindFirstChild("Title"));
    u6 = u3:FindFirstChild("Exit");
    local Contents = u3:FindFirstChild("Contents");

    if Contents then
        Contents = Contents:FindFirstChild("Selection");
    end;

    u7 = Contents;

    if u7 then
        u8 = u7:FindFirstChild("Template");

        if u8 then
            u8.Visible = false;
        end;

        local TopPadding = u7:FindFirstChild("TopPadding");

        if TopPadding then
            TopPadding.LayoutOrder = -100000;
        end;

        local BottomPadding = u7:FindFirstChild("BottomPadding");

        if BottomPadding then
            BottomPadding.LayoutOrder = 100000;
        end;
    end;
end;

function u1.KnitStart(p57) -- Line: 496
    -- upvalues: u6 (ref), u1 (copy), Players (copy), LocalPlayer (copy), u2 (copy), GetThumbnail (copy)
    if u6 and u6:IsA("GuiButton") then
        u6.Activated:Connect(function() -- Line: 498
            -- upvalues: u1 (ref)
            u1:Close();
        end);
    end;

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer then
            local UserId = v.UserId;

            if not u2[UserId] then
                task.spawn(GetThumbnail, UserId);
            end;
        end;
    end;

    Players.PlayerAdded:Connect(function(p58) -- Line: 510
        -- upvalues: LocalPlayer (ref), u2 (ref), GetThumbnail (ref)
        if p58 ~= LocalPlayer then
            local UserId = p58.UserId;

            if u2[UserId] then
                return;
            end;

            task.spawn(GetThumbnail, UserId);
        end;
    end);
    Players.PlayerRemoving:Connect(function(p59) -- Line: 515
        -- upvalues: u2 (ref)
        u2[p59.UserId] = nil;
    end);
end;

return u1;