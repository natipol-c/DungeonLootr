--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DungeonSelectController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.DungeonSelectController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local UIController = require(script.Parent.UIController);
local ItemIndex = require(script.Parent.Parent.UI.ItemIndex);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local DungeonData = require(ReplicatedStorage.GameInfo.DungeonData);
local EquipmentTemplates = require(ReplicatedStorage.GameInfo.EquipmentTemplates);
local ItemData = require(ReplicatedStorage.GameInfo.ItemData);
local LevelData = require(ReplicatedStorage.GameInfo.LevelData);
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
local PackageData = require(ReplicatedStorage.GameInfo.PackageData);
local HeadShot = Enum.ThumbnailType.HeadShot;
local Size100x100 = Enum.ThumbnailSize.Size100x100;
local u1 = { "Easy", "Normal", "Hard", "Nightmare", "Endless" };
local u2 = { "1", "2", "3", "4" };
local u3 = {
    Head = 1,
    Body = 2,
    Ring = 3
};
local u4 = { "Common", "Uncommon", "Rare", "Epic", "Legendary" };
local TweenInfo_new_ret = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local TweenInfo_new_ret3 = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local Color3_fromRGB_ret = Color3.fromRGB(133, 106, 57);
local Color3_fromRGB_ret2 = Color3.fromRGB(110, 110, 110);
local TweenInfo_new_ret4 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local Color3_fromRGB_ret3 = Color3.fromRGB(77, 255, 77);
local Color3_fromRGB_ret4 = Color3.fromRGB(255, 77, 77);
local u5 = Knit.CreateController({
    Name = "DungeonSelectController"
});
local LocalPlayer = Players.LocalPlayer;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = {};
local u11 = {};
local u12 = {};
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = {};
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = {};
local u26 = 0;
local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = nil;
local u31 = {};
local u32 = nil;
local u33 = nil;
local u34 = nil;
local u35 = nil;
local u36 = nil;
local u37 = nil;
local u38 = false;
local u39 = false;
local u40 = false;
local u41 = "Dungeon";
local u42 = nil;
local u43 = nil;
local u44 = nil;
local u45 = nil;
local u46 = false;
local u47 = false;
local u48 = false;
local u49 = nil;
local u50 = nil;
local u51 = nil;
local u52 = nil;
local u53 = nil;
local u54 = nil;
local u55 = nil;

local function GetThumbnail(u56: number) -- Line: 213
    -- upvalues: Players (copy), HeadShot (copy), Size100x100 (copy)
    local success, result = pcall(function() -- Line: 214
        -- upvalues: Players (ref), u56 (copy), HeadShot (ref), Size100x100 (ref)
        return Players:GetUserThumbnailAsync(u56, HeadShot, Size100x100);
    end);

    return success and result and result or "";
end;

local function GetPlayerLevel(p57: number) -- Line: 221
    -- upvalues: Players (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p57);

    if not PlayerByUserId then
        return nil;
    end;

    local leaderstats = PlayerByUserId:FindFirstChild("leaderstats");

    if leaderstats then
        leaderstats = leaderstats:FindFirstChild("Level");
    end;

    if leaderstats then
        return leaderstats.Value;
    end;

    return PlayerByUserId:GetAttribute("Stat_PlayerLevel");
end;

local function PlaySound(p58: string) -- Line: 231
    -- upvalues: u53 (ref)
    if u53 then
        u53:Play(p58);
    end;
end;

local function FitCanvas(p59: userdata) -- Line: 238
    local v60 = p59:FindFirstChildWhichIsA("UIListLayout");

    if not v60 then
        return;
    end;

    local AbsoluteContentSize = v60.AbsoluteContentSize;

    if v60.FillDirection == Enum.FillDirection.Horizontal then
        p59.CanvasSize = UDim2.new(0, AbsoluteContentSize.X + 10, 0, 0);

        return;
    end;

    p59.CanvasSize = UDim2.new(0, 0, 0, AbsoluteContentSize.Y + 10);
end;

local function ApplyFriendsOnlyVisual(p61: boolean, p62: boolean?) -- Line: 253
    -- upvalues: u33 (ref), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), TweenService (copy), TweenInfo_new_ret4 (copy), u34 (ref)
    if u33 then
        local v63 = p61 and u33:GetAttribute("On") or u33:GetAttribute("Off");
        local v64 = p61 and Color3_fromRGB_ret or Color3_fromRGB_ret2;

        if p62 then
            if v63 then
                u33.Position = v63;
            end;

            u33.BackgroundColor3 = v64;
        else
            local v65 = {
                BackgroundColor3 = v64
            };

            if v63 then
                v65.Position = v63;
            end;

            TweenService:Create(u33, TweenInfo_new_ret4, v65):Play();
        end;
    end;

    if u34 then
        u34.Text = `Friends Only: {p61 and "<font color=\"#4DFF4D\">ON</font>" or "<font color=\"#FF4D4D\">OFF</font>"}`;
    end;
end;

local function ApplySoloVisual(p66: boolean, p67: boolean?) -- Line: 277
    -- upvalues: u36 (ref), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), TweenService (copy), TweenInfo_new_ret4 (copy), u37 (ref), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy)
    if u36 then
        local v68 = p66 and u36:GetAttribute("On") or u36:GetAttribute("Off");
        local v69 = p66 and Color3_fromRGB_ret or Color3_fromRGB_ret2;

        if p67 then
            if v68 then
                u36.Position = v68;
            end;

            u36.BackgroundColor3 = v69;
        else
            local v70 = {
                BackgroundColor3 = v69
            };

            if v68 then
                v70.Position = v68;
            end;

            TweenService:Create(u36, TweenInfo_new_ret4, v70):Play();
        end;
    end;

    if u37 then
        u37.TextColor3 = p66 and Color3_fromRGB_ret3 or Color3_fromRGB_ret4;
    end;
end;

local function UpdateCustomScroll() -- Line: 298
    -- upvalues: u13 (ref), u14 (ref), u8 (ref)
    if not (u13 and (u14 and u8)) then
        return;
    end;

    local Y = u8.AbsoluteCanvasSize.Y;
    local Y2 = u8.AbsoluteWindowSize.Y;

    if Y <= 0 or Y <= Y2 then
        u13.Visible = false;

        return;
    end;

    u13.Visible = true;
    local math_clamp_ret = math.clamp(Y2 / Y, 0.06, 1);
    local v71 = Y - Y2;
    local v72 = v71 > 0 and u8.CanvasPosition.Y / v71 or 0;
    local X = u14.Size.X;
    u14.Size = UDim2.new(X.Scale, X.Offset, math_clamp_ret, 0);
    local X2 = u14.Position.X;
    u14.Position = UDim2.new(X2.Scale, X2.Offset, v72 * (1 - math_clamp_ret), 0);
end;

local u73 = false;
local u74 = 0;
local u75 = 0;

local function ListMaxScroll() -- Line: 331
    -- upvalues: u8 (ref)
    return not u8 and 0 or math.max(0, u8.AbsoluteCanvasSize.Y - u8.AbsoluteWindowSize.Y);
end;

local function ThumbTravel() -- Line: 337
    -- upvalues: u13 (ref), u14 (ref)
    return not (u13 and u14) and 0 or math.max(0, u13.AbsoluteSize.Y - u14.AbsoluteSize.Y);
end;

local function SetListCanvasY(p76: number) -- Line: 342
    -- upvalues: u8 (ref)
    if not u8 then
        return;
    end;

    local Vector2_new = Vector2.new;
    local X = u8.CanvasPosition.X;
    local v77 = not u8 and 0 or math.max(0, u8.AbsoluteCanvasSize.Y - u8.AbsoluteWindowSize.Y);
    u8.CanvasPosition = Vector2_new(X, (math.clamp(p76, 0, v77)));
end;

local function SetupCustomScrollDrag() -- Line: 347
    -- upvalues: u14 (ref), u13 (ref), u8 (ref), u73 (ref), u74 (ref), u75 (ref), GuiService (copy), UserInputService (copy)
    if not (u14 and (u13 and u8)) then
        return;
    end;

    u14.InputBegan:Connect(function(p78) -- Line: 351
        -- upvalues: u73 (ref), u74 (ref), u75 (ref), u8 (ref)
        if p78.UserInputType ~= Enum.UserInputType.MouseButton1 and p78.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        u73 = true;
        u74 = p78.Position.Y;
        u75 = u8.CanvasPosition.Y;
    end);
    u13.InputBegan:Connect(function(p79) -- Line: 363
        -- upvalues: u13 (ref), u14 (ref), GuiService (ref), u8 (ref), u73 (ref), u74 (ref), u75 (ref)
        if p79.UserInputType ~= Enum.UserInputType.MouseButton1 and p79.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        local v80 = not (u13 and u14) and 0 or math.max(0, u13.AbsoluteSize.Y - u14.AbsoluteSize.Y);

        if v80 <= 0 then
            return;
        end;

        local GuiInset = GuiService:GetGuiInset();
        local v81 = math.clamp(p79.Position.Y - (u13.AbsolutePosition.Y + GuiInset.Y) - u14.AbsoluteSize.Y / 2, 0, v80) / v80 * (not u8 and 0 or math.max(0, u8.AbsoluteCanvasSize.Y - u8.AbsoluteWindowSize.Y));

        if u8 then
            local Vector2_new = Vector2.new;
            local X = u8.CanvasPosition.X;
            local v82 = not u8 and 0 or math.max(0, u8.AbsoluteCanvasSize.Y - u8.AbsoluteWindowSize.Y);
            u8.CanvasPosition = Vector2_new(X, (math.clamp(v81, 0, v82)));
        end;

        u73 = true;
        u74 = p79.Position.Y;
        u75 = u8.CanvasPosition.Y;
    end);
    UserInputService.InputChanged:Connect(function(p83) -- Line: 379
        -- upvalues: u73 (ref), u13 (ref), u14 (ref), u74 (ref), u75 (ref), u8 (ref)
        if not u73 then
            return;
        end;

        if p83.UserInputType ~= Enum.UserInputType.MouseMovement and p83.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        local v84 = not (u13 and u14) and 0 or math.max(0, u13.AbsoluteSize.Y - u14.AbsoluteSize.Y);

        if v84 <= 0 then
            return;
        end;

        local v85 = u75 + (p83.Position.Y - u74) / v84 * (not u8 and 0 or math.max(0, u8.AbsoluteCanvasSize.Y - u8.AbsoluteWindowSize.Y));

        if not u8 then
            return;
        end;

        local Vector2_new = Vector2.new;
        local X = u8.CanvasPosition.X;
        local v86 = not u8 and 0 or math.max(0, u8.AbsoluteCanvasSize.Y - u8.AbsoluteWindowSize.Y);
        u8.CanvasPosition = Vector2_new(X, (math.clamp(v85, 0, v86)));
    end);
    UserInputService.InputEnded:Connect(function(p87) -- Line: 391
        -- upvalues: u73 (ref)
        if p87.UserInputType == Enum.UserInputType.MouseButton1 or p87.UserInputType == Enum.UserInputType.Touch then
            u73 = false;
        end;
    end);
end;

local function ApplySelectVisual(p88: string) -- Line: 406
    -- upvalues: u10 (copy), u12 (copy), u42 (ref)
    local v89 = u10[p88];

    if not (v89 and v89.Parent) then
        return;
    end;

    local Main = v89:FindFirstChild("Main");

    if Main then
        Main = Main:FindFirstChild("Select");
    end;

    if not Main then
        return;
    end;

    local Background = Main:FindFirstChild("Background");
    local Title = Main:FindFirstChild("Title");
    local v90 = u42 == p88;

    if u12[p88] == true then
        if Background then
            Background.Image = "rbxassetid://131797347402079";
            Background.ImageTransparency = 0;
        end;

        if Title then
            Title.Text = "LOCKED";
        end;
    elseif v90 then
        if Background then
            Background.Image = "rbxassetid://93874102680577";
            Background.ImageTransparency = 0;
        end;

        if Title then
            Title.Text = "SELECTED";
        end;
    else
        if Background then
            Background.Image = "rbxassetid://93874102680577";
            Background.ImageTransparency = 0.7;
        end;

        if Title then
            Title.Text = "SELECT";
        end;
    end;
end;

local function ApplyDungeonSelectionVisual(p91: string) -- Line: 442
    -- upvalues: u10 (copy), u12 (copy), CollectionService (copy), ApplySelectVisual (copy)
    for i, v in u10 do
        local v92 = v and v.Parent and v:FindFirstChild("Main");

        if v92 then
            local v93;

            if i == p91 then
                v93 = u12[i] ~= true;
            else
                v93 = false;
            end;

            if v93 then
                if not CollectionService:HasTag(v92, "shine_frame") then
                    CollectionService:AddTag(v92, "shine_frame");
                end;
            elseif CollectionService:HasTag(v92, "shine_frame") then
                CollectionService:RemoveTag(v92, "shine_frame");
            end;
        end;

        ApplySelectVisual(i);
    end;
end;

local function GetActiveDisplayOrder() -- Line: 462
    -- upvalues: u41 (ref), DungeonData (copy)
    if u41 == "Challenge" then
        return DungeonData.ChallengeModeDisplayOrder;
    end;

    return DungeonData.ChallengeDisplayOrder;
end;

local function SetDifficultyRowVisible(p94: boolean) -- Line: 471
    -- upvalues: u20 (copy)
    for _, v in u20 do
        if v and v.Button then
            v.Button.Visible = p94;
        end;
    end;
end;

local function PopulateDungeonList() -- Line: 479
    -- upvalues: u10 (copy), u11 (copy), u12 (copy), u44 (ref), u8 (ref), u9 (ref), u41 (ref), u20 (copy), DungeonData (copy), Image_Data (copy), u5 (copy), ApplySelectVisual (copy), u50 (ref), CollectionService (copy), FitCanvas (copy), UpdateCustomScroll (copy)
    for _, v in u10 do
        if v and v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u10);
    table.clear(u11);
    table.clear(u12);
    u44 = nil;

    if not (u8 and u9) then
        return;
    end;

    local v95 = u41 ~= "Challenge";

    for _, v in u20 do
        if v and v.Button then
            v.Button.Visible = v95;
        end;
    end;

    local v96, v97, v98;

    if u41 == "Challenge" then
        v96 = DungeonData.ChallengeModeDisplayOrder;
        v97 = nil;
        v98 = nil;
    else
        v96 = DungeonData.ChallengeDisplayOrder;
        v97 = nil;
        v98 = nil;
    end;

    for i, v in v96, v97, v98 do
        local Dungeon = DungeonData.GetDungeon(v);

        if Dungeon and not Dungeon.HideFromSelect then
            local u99 = u9:Clone();
            u99.Name = v;
            u99.LayoutOrder = i;
            u99.Visible = true;
            u99.BackgroundTransparency = 1;
            local Selected = u99:FindFirstChild("Selected");

            if Selected then
                Selected.Visible = false;
                local v100 = Selected:FindFirstChildWhichIsA("UIScale");

                if v100 then
                    v100.Scale = 0;
                end;
            end;

            local Main = u99:FindFirstChild("Main");
            local u101;

            if Main then
                u101 = Main:FindFirstChild("ImageHolder");
            else
                u101 = Main;
            end;

            local v102 = Dungeon.Locked == true;
            local Locked = u99:FindFirstChild("Locked");

            if Locked then
                Locked.Visible = v102;
            end;

            if u101 then
                local Title = u101:FindFirstChild("Title");

                if Title then
                    Title.Text = Dungeon.DisplayName or v;
                end;

                local Lvl = u101:FindFirstChild("Lvl");

                if Lvl then
                    local v103 = Dungeon.LevelRange or {
                        Min = 0,
                        Max = 100
                    };
                    Lvl.Text = `Levels {v103.Min}-{v103.Max}`;
                end;

                local MapImage = u101:FindFirstChild("MapImage");
                local v104 = Image_Data.Dungeons and Image_Data.Dungeons[v];

                if MapImage and (v104 and v104 ~= "") then
                    MapImage.Image = v104;
                end;
            end;

            if Main then
                Main = Main:FindFirstChild("Select");
            end;

            if Main then
                if v102 then
                    Main.Visible = false;
                else
                    Main.Activated:Connect(function() -- Line: 550
                        -- upvalues: u12 (ref), v (copy), u5 (ref)
                        if u12[v] then
                            return;
                        end;

                        u5:SelectDungeon(v);
                    end);
                end;
            end;

            u99.Parent = u8;
            u10[v] = u99;
            u12[v] = v102;

            if not v102 then
                ApplySelectVisual(v);

                if u50 then
                    task.spawn(function() -- Line: 572
                        -- upvalues: u50 (ref), v (copy), u99 (copy), u101 (copy), Main (copy), u12 (ref), ApplySelectVisual (ref), CollectionService (ref)
                        local v105, v106 = u50:GetDungeonAccessState(v):await();

                        if not (v105 and v106) then
                            return;
                        end;

                        if not (u99 and u99.Parent) then
                            return;
                        end;

                        if v106.Unlocked then
                            return;
                        end;

                        if u101 then
                            u101.ImageTransparency = 0.5;
                            local MapImage = u101:FindFirstChild("MapImage");

                            if MapImage then
                                MapImage.ImageTransparency = 0.5;
                            end;

                            local Title = u101:FindFirstChild("Title");

                            if Title then
                                Title.TextTransparency = 0.5;
                            end;

                            local Lvl = u101:FindFirstChild("Lvl");

                            if Lvl then
                                Lvl.TextTransparency = 0.5;
                                Lvl.Text = v106.Reason or "Locked";
                            end;
                        end;

                        if Main then
                            Main.Active = false;
                        end;

                        u12[v] = true;
                        ApplySelectVisual(v);
                        local Main2 = u99:FindFirstChild("Main");

                        if Main2 and CollectionService:HasTag(Main2, "shine_frame") then
                            CollectionService:RemoveTag(Main2, "shine_frame");
                        end;
                    end);
                end;
            end;
        end;
    end;

    FitCanvas(u8);
    UpdateCustomScroll();
end;

local function SetDungeonSelectedVisual(p107: string) -- Line: 611
    -- upvalues: u10 (copy), u44 (ref), u11 (copy), TweenService (copy), TweenInfo_new_ret2 (copy), u42 (ref), TweenInfo_new_ret (copy)
    local v108 = u10[p107];

    if u44 and (u44 ~= v108 and u44.Parent) then
        local Selected = u44:FindFirstChild("Selected");
        local v109;

        if Selected then
            v109 = Selected:FindFirstChildWhichIsA("UIScale");
        else
            v109 = Selected;
        end;

        if Selected and v109 then
            local Name = u44.Name;

            if u11[Name] then
                u11[Name]:Cancel();
            end;

            local v110 = TweenService:Create(v109, TweenInfo_new_ret2, {
                Scale = 0
            });
            u11[Name] = v110;
            v110.Completed:Connect(function() -- Line: 623
                -- upvalues: Selected (copy), u42 (ref), Name (copy)
                if Selected and (Selected.Parent and u42 ~= Name) then
                    Selected.Visible = false;
                end;
            end);
            v110:Play();
        end;
    end;

    if v108 then
        local Selected = v108:FindFirstChild("Selected");
        local v111;

        if Selected then
            v111 = Selected:FindFirstChildWhichIsA("UIScale");
        else
            v111 = Selected;
        end;

        if Selected and v111 then
            if u11[p107] then
                u11[p107]:Cancel();
            end;

            Selected.Visible = true;
            local v112 = TweenService:Create(v111, TweenInfo_new_ret, {
                Scale = 1
            });
            u11[p107] = v112;
            v112:Play();
        end;
    end;

    u44 = v108;
end;

local function PopulateBossViewport(p113: string) -- Line: 652
    -- upvalues: u17 (ref), DungeonData (copy), SharedUtils (copy)
    if not u17 then
        return;
    end;

    local Boss = DungeonData.GetBoss(p113);

    if not (Boss and Boss.HeroId) then
        u17:ClearAllChildren();

        return;
    end;

    local success, result = pcall(SharedUtils.LoadItemViewport, u17, Boss.HeroId);

    if not success then
        warn("[DungeonSelectController] Failed to load boss viewport for", Boss.HeroId, ":", result);
    end;
end;

local function HighlightSelectedDifficulty() -- Line: 670
    -- upvalues: u1 (copy), u20 (copy), u43 (ref)
    for i, v in u1 do
        local v114 = u20[i];

        if v114 and v114.Stroke then
            local v115;

            if v == u43 then
                v115 = not v114.Locked;
            else
                v115 = false;
            end;

            v114.Stroke.Enabled = v115;
        end;
    end;
end;

local function RefreshDifficultyButtons(u116: string) -- Line: 679
    -- upvalues: u50 (ref), DungeonData (copy), u1 (copy), u20 (copy), u43 (ref), u5 (copy), HighlightSelectedDifficulty (copy)
    if not (u50 and u116) then
        return;
    end;

    local Dungeon = DungeonData.GetDungeon(u116);

    if Dungeon then
        Dungeon = Dungeon.DifficultyLevelBrackets;
    end;

    task.spawn(function() -- Line: 685
        -- upvalues: u50 (ref), u116 (copy), u1 (ref), u20 (ref), Dungeon (copy), u43 (ref), u5 (ref), HighlightSelectedDifficulty (ref)
        local v117, v118 = u50:GetUnlockedDifficulties(u116):await();

        if not (v117 and v118) then
            return;
        end;

        for i, v in u1 do
            local v119 = u20[i];

            if v119 then
                local v120 = v118[v];
                local v121;

                if v120 then
                    v121 = v120.Unlocked or false;
                else
                    v121 = false;
                end;

                local v122 = v120 and v120.Reason or "Locked";
                v119.Locked = not v121;

                if v119.Background then
                    v119.Background.ImageTransparency = v121 and 0 or 0.5;
                end;

                if v119.TextLabel then
                    v119.TextLabel.TextTransparency = v121 and 0 or 0.5;
                end;

                if v119.Lvl then
                    if v121 then
                        local v123 = Dungeon and Dungeon[v];
                        v119.Lvl.Text = v123 and `Levels {v123.Min}-{v123.Max}` or "";
                    else
                        v119.Lvl.Text = v122;
                    end;
                end;
            end;
        end;

        local v124 = u43 and v118[u43];

        if v124 and v124.Unlocked then
            u5:SelectDifficulty(u43);

            return;
        end;

        local Easy = v118.Easy;

        if Easy and Easy.Unlocked then
            u5:SelectDifficulty("Easy");

            return;
        end;

        u43 = nil;
        HighlightSelectedDifficulty();
    end);
end;

local function ApplyRewardGradient(p125: userdata, p126: userdata?, p127: userdata?) -- Line: 740
    local Holder = p125:FindFirstChild("Holder");

    if not Holder then
        return;
    end;

    local v128 = Holder:FindFirstChildWhichIsA("UIGradient");

    if v128 and p126 then
        v128.Color = p126;
        v128.Enabled = true;
    end;

    local Main = Holder:FindFirstChild("Main");

    if Main then
        Main = Main:FindFirstChildWhichIsA("UIGradient");
    end;

    if Main and p127 then
        Main.Color = p127;
        Main.Enabled = true;
    end;
end;

local function UpdateRewardTotals(p129: string) -- Line: 761
    -- upvalues: DungeonData (copy), u24 (ref), LevelData (copy), u43 (ref), SharedUtils (copy)
    local Dungeon = DungeonData.GetDungeon(p129);

    if Dungeon and Dungeon.ChallengeMode then
        if u24 then
            u24.Text = "";
        end;

        return;
    end;

    if u24 then
        if Dungeon then
            Dungeon = Dungeon.Tier;
        end;

        local DungeonClearXP = LevelData.GetDungeonClearXP(u43 or "Easy", Dungeon);
        u24.Text = "EXP: " .. SharedUtils.FormatWithCommas(DungeonClearXP);
    end;
end;

local function PopulateRewards(p130: string, p131: boolean?) -- Line: 781
    -- upvalues: u21 (ref), u22 (ref), u25 (copy), u26 (ref), DungeonData (copy), u24 (ref), LevelData (copy), u43 (ref), SharedUtils (copy), FitCanvas (copy), CollectionService (copy), ApplyRewardGradient (copy), ItemIndex (copy), RarityGradient (copy), Image_Data (copy), u4 (copy), ItemData (copy), EquipmentTemplates (copy), u3 (copy), PackageData (copy), TweenService (copy), TweenInfo_new_ret3 (copy)
    local u132 = p131 == nil and true or p131;

    if not (u21 and u22) then
        return;
    end;

    for _, v in u25 do
        if v and v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u25);
    u26 = u26 + 1;
    local u133 = u26;
    local u134 = {};
    local Dungeon = DungeonData.GetDungeon(p130);

    if Dungeon and Dungeon.ChallengeMode then
        if u24 then
            u24.Text = "";
        end;
    elseif u24 then
        if Dungeon then
            Dungeon = Dungeon.Tier;
        end;

        local DungeonClearXP = LevelData.GetDungeonClearXP(u43 or "Easy", Dungeon);
        u24.Text = "EXP: " .. SharedUtils.FormatWithCommas(DungeonClearXP);
    end;

    local Dungeon2 = DungeonData.GetDungeon(p130);

    if not (Dungeon2 and Dungeon2.Rewards) then
        FitCanvas(u21);

        return;
    end;

    local u135 = 0;

    local function AddRewardEntry(p136: string?, p137: string, p138: userdata?, p139: userdata?, p140: string?) -- Line: 804
        -- upvalues: u135 (ref), u22 (ref), CollectionService (ref), ApplyRewardGradient (ref), u132 (ref), ItemIndex (ref), u21 (ref), u25 (ref), u134 (copy)
        u135 = u135 + 1;
        local v141 = u22:Clone();
        local v142;

        if p137 == "" or not p137 then
            v142 = "Reward_" .. u135;
        else
            v142 = p137;
        end;

        v141.Name = v142;
        v141.LayoutOrder = u135;
        v141.ZIndex = 1000 - u135;
        v141.Visible = true;
        local ItemImage = v141:FindFirstChild("ItemImage", true);

        if ItemImage and (p136 and p136 ~= "") then
            ItemImage.Image = p136;
        end;

        local Amount = v141:FindFirstChild("Amount", true);

        if Amount then
            Amount.Visible = false;
        end;

        local ItemName = v141:FindFirstChild("ItemName", true);

        if ItemName then
            ItemName.Text = p137;
            ItemName.Visible = false;
        end;

        local v143 = v141:FindFirstChild("Button") or v141;
        v143:SetAttribute("Tip", p137);

        if not CollectionService:HasTag(v143, "ToolTip") then
            CollectionService:AddTag(v143, "ToolTip");
        end;

        ApplyRewardGradient(v141, p138, p139);
        local v144 = v141:FindFirstChildWhichIsA("UIScale");

        if v144 then
            v144.Scale = u132 and 0 or 1;
        end;

        ItemIndex.BindCard(v141, p140, "Dungeon_Select");
        v141.Parent = u21;
        table.insert(u25, v141);
        table.insert(u134, v141);
    end;

    if Dungeon2.ChallengeMode then
        local v145 = RarityGradient.colorSequence("Celestial");
        AddRewardEntry(Image_Data.Rewards.ProtectionScroll, "Protection Scroll", v145, v145, "ProtectionScroll");

        for _, v in u4 do
            local OreForRarity = ItemData.GetOreForRarity(v);

            if OreForRarity then
                local v146 = RarityGradient.colorSequence(OreForRarity.Rarity);
                AddRewardEntry(OreForRarity.Icon, OreForRarity.Name, v146, v146, OreForRarity.Id);
            end;
        end;

        local v147 = {};

        for _, v in EquipmentTemplates.GetItemsForDungeon(Dungeon2.RewardPreviewDungeon or p130) do
            table.insert(v147, v);
        end;

        table.sort(v147, function(p148, p149) -- Line: 880
            -- upvalues: u3 (ref)
            local v150 = u3[p148.Slot] or 9;
            local v151 = u3[p149.Slot] or 9;

            if v150 == v151 then
                return (p148.DisplayName or "") < (p149.DisplayName or "");
            end;

            return v150 < v151;
        end);

        for _, v in v147 do
            local v152 = v.DisplayName or "Equipment";

            if v.Slot then
                v152 = `{v152} ({v.Slot})`;
            end;

            local v153 = RarityGradient.colorSequence(v.MaxRarity or v.MinRarity);
            AddRewardEntry(v.ImageId, v152, v153, v153);
        end;
    else
        local DungeonMaterialPool = ItemData.GetDungeonMaterialPool(p130, u43 or "Easy");

        if DungeonMaterialPool then
            for i = #DungeonMaterialPool, 1, -1 do
                local Material = DungeonMaterialPool[i].Material;
                local v154 = RarityGradient.colorSequence(Material.Rarity);
                AddRewardEntry(Material.Icon, Material.Name, v154, v154, Material.Id);
                local _ = i;
            end;
        end;

        local v155 = {};

        for _, v in EquipmentTemplates.GetItemsForDungeon(p130) do
            table.insert(v155, v);
        end;

        table.sort(v155, function(p156, p157) -- Line: 914
            -- upvalues: u3 (ref)
            local v158 = u3[p156.Slot] or 9;
            local v159 = u3[p157.Slot] or 9;

            if v158 == v159 then
                return (p156.DisplayName or "") < (p157.DisplayName or "");
            end;

            return v158 < v159;
        end);

        for _, v in v155 do
            local v160 = v.DisplayName or "Equipment";

            if v.Slot then
                v160 = `{v160} ({v.Slot})`;
            end;

            local v161 = RarityGradient.colorSequence(v.MinRarity);
            AddRewardEntry(v.ImageId, v160, v161, v161);
        end;

        if Dungeon2.CosmeticRewards then
            for _, v in Dungeon2.CosmeticRewards do
                local v162 = v.PackageId and PackageData.Get(v.PackageId);

                if v162 then
                    local v163 = RarityGradient.colorSequence(v162.Rarity);
                    local v164 = string.format("%.1f", (v.Chance or 0) * 100):gsub("%.0$", "");
                    AddRewardEntry(v162.Icon, `{v162.Name} ({v164}% Drop)`, v163, v163);
                end;
            end;
        end;
    end;

    FitCanvas(u21);

    if u132 then
        task.spawn(function() -- Line: 949
            -- upvalues: u134 (copy), u26 (ref), u133 (copy), TweenService (ref), TweenInfo_new_ret3 (ref)
            for _, v in u134 do
                if u26 ~= u133 then
                    return;
                end;

                local v165 = v and (v.Parent and v:FindFirstChildWhichIsA("UIScale"));

                if v165 then
                    TweenService:Create(v165, TweenInfo_new_ret3, {
                        Scale = 1
                    }):Play();
                end;

                task.wait(0.06);
            end;
        end);
    end;
end;

local function PopulateInfoPanel(p166: string) -- Line: 967
    -- upvalues: DungeonData (copy), u16 (ref), u19 (ref), Image_Data (copy), u15 (ref)
    local Dungeon = DungeonData.GetDungeon(p166);

    if not Dungeon then
        return;
    end;

    if u16 then
        u16.Text = Dungeon.DisplayName or p166;
    end;

    if u19 then
        local v167 = Image_Data.Dungeons and Image_Data.Dungeons[p166];

        if v167 and v167 ~= "" then
            u19.Image = v167;
        end;
    end;

    if u15 then
        u15.Visible = true;
    end;
end;

function u5.SelectDungeon(p168: table, u169: string) -- Line: 991
    -- upvalues: u42 (ref), u41 (ref), u43 (ref), u46 (ref), u50 (ref), DungeonData (copy), u16 (ref), u19 (ref), Image_Data (copy), u15 (ref), PopulateBossViewport (copy), PopulateRewards (copy), u20 (copy), u1 (copy), u5 (copy), HighlightSelectedDifficulty (copy), SetDungeonSelectedVisual (copy), ApplyDungeonSelectionVisual (copy)
    u42 = u169;
    local v170 = u41 == "Challenge";
    u43 = v170 and "Challenge" or "Easy";

    if u46 and u50 then
        task.spawn(function() -- Line: 1000
            -- upvalues: u50 (ref), u169 (copy)
            u50:RequestSelectDungeon(u169):await();
        end);
    end;

    local Dungeon = DungeonData.GetDungeon(u169);

    if Dungeon then
        if u16 then
            u16.Text = Dungeon.DisplayName or u169;
        end;

        if u19 then
            local v171 = Image_Data.Dungeons and Image_Data.Dungeons[u169];

            if v171 and v171 ~= "" then
                u19.Image = v171;
            end;
        end;

        if u15 then
            u15.Visible = true;
        end;
    end;

    PopulateBossViewport(u169);
    PopulateRewards(u169);

    if v170 then
        for _, v in u20 do
            if v and v.Button then
                v.Button.Visible = false;
            end;
        end;
    else
        for _, v in u20 do
            if v and v.Button then
                v.Button.Visible = true;
            end;
        end;

        if u50 and u169 then
            local Dungeon2 = DungeonData.GetDungeon(u169);

            if Dungeon2 then
                Dungeon2 = Dungeon2.DifficultyLevelBrackets;
            end;

            task.spawn(function() -- Line: 685
                -- upvalues: u50 (ref), u169 (copy), u1 (ref), u20 (ref), Dungeon2 (copy), u43 (ref), u5 (ref), HighlightSelectedDifficulty (ref)
                local v172, v173 = u50:GetUnlockedDifficulties(u169):await();

                if not (v172 and v173) then
                    return;
                end;

                for i, v in u1 do
                    local v174 = u20[i];

                    if v174 then
                        local v175 = v173[v];
                        local v176;

                        if v175 then
                            v176 = v175.Unlocked or false;
                        else
                            v176 = false;
                        end;

                        local v177 = v175 and v175.Reason or "Locked";
                        v174.Locked = not v176;

                        if v174.Background then
                            v174.Background.ImageTransparency = v176 and 0 or 0.5;
                        end;

                        if v174.TextLabel then
                            v174.TextLabel.TextTransparency = v176 and 0 or 0.5;
                        end;

                        if v174.Lvl then
                            if v176 then
                                local v178 = Dungeon2 and Dungeon2[v];
                                v174.Lvl.Text = v178 and `Levels {v178.Min}-{v178.Max}` or "";
                            else
                                v174.Lvl.Text = v177;
                            end;
                        end;
                    end;
                end;

                local v179 = u43 and v173[u43];

                if v179 and v179.Unlocked then
                    u5:SelectDifficulty(u43);

                    return;
                end;

                local Easy = v173.Easy;

                if Easy and Easy.Unlocked then
                    u5:SelectDifficulty("Easy");

                    return;
                end;

                u43 = nil;
                HighlightSelectedDifficulty();
            end);
        end;
    end;

    SetDungeonSelectedVisual(u169);
    ApplyDungeonSelectionVisual(u169);
    HighlightSelectedDifficulty();
end;

function u5.SelectDifficulty(p180: table, u181: string) -- Line: 1020
    -- upvalues: u43 (ref), HighlightSelectedDifficulty (copy), u42 (ref), PopulateRewards (copy), u46 (ref), u50 (ref)
    u43 = u181;
    HighlightSelectedDifficulty();

    if u42 then
        PopulateRewards(u42, false);
    end;

    if u46 and u50 then
        task.spawn(function() -- Line: 1031
            -- upvalues: u50 (ref), u181 (copy)
            u50:RequestSelectDifficulty(u181):await();
        end);
    end;
end;

local function RefreshPartyRoster(p182) -- Line: 1040
    -- upvalues: u45 (ref), u46 (ref), LocalPlayer (copy), u38 (ref), u5 (copy), u55 (ref), u31 (copy), Players (copy), HeadShot (copy), Size100x100 (copy), u48 (ref), u27 (ref), ApplyFriendsOnlyVisual (copy), u39 (ref), u32 (ref), u40 (ref), u36 (ref), Color3_fromRGB_ret2 (copy), TweenService (copy), TweenInfo_new_ret4 (copy), u37 (ref), Color3_fromRGB_ret4 (copy), u42 (ref), DungeonData (copy), u16 (ref), u19 (ref), Image_Data (copy), u15 (ref), PopulateBossViewport (copy), PopulateRewards (copy), u50 (ref), u1 (copy), u20 (copy), u43 (ref), HighlightSelectedDifficulty (copy), SetDungeonSelectedVisual (copy), ApplyDungeonSelectionVisual (copy)
    u45 = p182;
    u46 = p182 and p182.LeaderId == LocalPlayer.UserId and true or false;

    if u38 and (not u46 and (p182 and p182.SelectedMode == "Challenge")) then
        u5:Close();

        if u55 then
            u55:Open();
        end;

        return;
    end;

    local v183 = {};

    if p182 and p182.Members then
        for _, v in p182.Members do
            if v.UserId == p182.LeaderId then
                table.insert(v183, 1, v);
            end;
        end;

        for _, v in p182.Members do
            if v.UserId ~= p182.LeaderId then
                table.insert(v183, v);
            end;
        end;
    end;

    for i = 1, 4 do
        local v184 = u31[i];
        local v185;

        if v184 then
            local v186 = v183[i];

            if v186 then
                if v184.Player then
                    v184.Player.Visible = true;
                end;

                if v184.Add then
                    v184.Add.Visible = false;
                end;

                if v184.ProfileImage then
                    local ProfileImage = v184.ProfileImage;
                    local UserId = v186.UserId;
                    local success, result = pcall(function() -- Line: 214
                        -- upvalues: Players (ref), UserId (copy), HeadShot (ref), Size100x100 (ref)
                        return Players:GetUserThumbnailAsync(UserId, HeadShot, Size100x100);
                    end);
                    ProfileImage.Image = success and result and result or "";
                end;

                if v184.PlayerName then
                    v184.PlayerName.Text = v186.DisplayName or (v186.Name or "");
                end;

                if v184.PlayerLevel then
                    local PlayerByUserId = Players:GetPlayerByUserId(v186.UserId);
                    local v187;

                    if PlayerByUserId then
                        local leaderstats = PlayerByUserId:FindFirstChild("leaderstats");

                        if leaderstats then
                            leaderstats = leaderstats:FindFirstChild("Level");
                        end;

                        if leaderstats then
                            v187 = leaderstats.Value;
                        else
                            v187 = PlayerByUserId:GetAttribute("Stat_PlayerLevel");
                        end;
                    else
                        v187 = nil;
                    end;

                    v184.PlayerLevel.Text = v187 and `lvl. {v187}` or "";
                    v185 = i;
                else
                    v185 = i;
                end;
            else
                if v184.Player then
                    v184.Player.Visible = false;
                end;

                if v184.Add then
                    v184.Add.Visible = u46 and not u48;
                    v185 = i;
                else
                    v185 = i;
                end;
            end;
        else
            v185 = i;
        end;
    end;

    if u27 then
        u27.Visible = u46;
    end;

    local v188;

    if p182 then
        v188 = p182.FriendsOnly;
    else
        v188 = p182;
    end;

    local v189 = v188 == true;
    ApplyFriendsOnlyVisual(v189, v189 == u39);
    u39 = v189;

    if u32 then
        u32.Active = u46;
        u32.AutoButtonColor = u46;
    end;

    if (p182 and (p182.MemberCount or 0) > 1 and true or false) and u40 then
        u40 = false;

        if u36 then
            local Attribute = u36:GetAttribute("Off");
            local v190 = {
                BackgroundColor3 = Color3_fromRGB_ret2
            };

            if Attribute then
                v190.Position = Attribute;
            end;

            TweenService:Create(u36, TweenInfo_new_ret4, v190):Play();
        end;

        if u37 then
            u37.TextColor3 = Color3_fromRGB_ret4;
        end;
    end;

    if p182 then
        if p182.SelectedDungeon and p182.SelectedDungeon ~= u42 then
            u42 = p182.SelectedDungeon;
            local v191 = u42;
            local Dungeon = DungeonData.GetDungeon(v191);

            if Dungeon then
                if u16 then
                    u16.Text = Dungeon.DisplayName or v191;
                end;

                if u19 then
                    local v192 = Image_Data.Dungeons and Image_Data.Dungeons[v191];

                    if v192 and v192 ~= "" then
                        u19.Image = v192;
                    end;
                end;

                if u15 then
                    u15.Visible = true;
                end;
            end;

            PopulateBossViewport(u42);
            PopulateRewards(u42);
            local u193 = u42;

            if u50 and u193 then
                local Dungeon2 = DungeonData.GetDungeon(u193);

                if Dungeon2 then
                    Dungeon2 = Dungeon2.DifficultyLevelBrackets;
                end;

                task.spawn(function() -- Line: 685
                    -- upvalues: u50 (ref), u193 (copy), u1 (ref), u20 (ref), Dungeon2 (copy), u43 (ref), u5 (ref), HighlightSelectedDifficulty (ref)
                    local v194, v195 = u50:GetUnlockedDifficulties(u193):await();

                    if not (v194 and v195) then
                        return;
                    end;

                    for i, v in u1 do
                        local v196 = u20[i];

                        if v196 then
                            local v197 = v195[v];
                            local v198;

                            if v197 then
                                v198 = v197.Unlocked or false;
                            else
                                v198 = false;
                            end;

                            local v199 = v197 and v197.Reason or "Locked";
                            v196.Locked = not v198;

                            if v196.Background then
                                v196.Background.ImageTransparency = v198 and 0 or 0.5;
                            end;

                            if v196.TextLabel then
                                v196.TextLabel.TextTransparency = v198 and 0 or 0.5;
                            end;

                            if v196.Lvl then
                                if v198 then
                                    local v200 = Dungeon2 and Dungeon2[v];
                                    v196.Lvl.Text = v200 and `Levels {v200.Min}-{v200.Max}` or "";
                                else
                                    v196.Lvl.Text = v199;
                                end;
                            end;
                        end;
                    end;

                    local v201 = u43 and v195[u43];

                    if v201 and v201.Unlocked then
                        u5:SelectDifficulty(u43);

                        return;
                    end;

                    local Easy = v195.Easy;

                    if Easy and Easy.Unlocked then
                        u5:SelectDifficulty("Easy");

                        return;
                    end;

                    u43 = nil;
                    HighlightSelectedDifficulty();
                end);
            end;

            SetDungeonSelectedVisual(u42);
            ApplyDungeonSelectionVisual(u42);
        end;

        if p182.SelectedDifficulty and p182.SelectedDifficulty ~= u43 then
            u43 = p182.SelectedDifficulty;
            HighlightSelectedDifficulty();
        end;
    end;
end;

local function OpenInvitePicker(p202: number) -- Line: 1140
    -- upvalues: u46 (ref), u54 (ref), u50 (ref)
    if p202 == 1 then
        return;
    end;

    if not u46 then
        return;
    end;

    if not u54 then
        return;
    end;

    u54:Open({
        Header = "INVITE",
        Subtitle = "Select a player to invite",
        CloseOnSelect = false,
        MarkInvitedOnSelect = true,

        OnSelect = function(u203: userdata) -- Line: 1150, Name: OnSelect
            -- upvalues: u50 (ref)
            if not u50 then
                return;
            end;

            task.spawn(function() -- Line: 1152
                -- upvalues: u50 (ref), u203 (copy)
                pcall(function() -- Line: 1153
                    -- upvalues: u50 (ref), u203 (ref)
                    u50:RequestInvite(u203.UserId);
                end);
            end);
        end
    });
end;

local function RefreshInDungeonRoster(p204, p205) -- Line: 1166
    -- upvalues: RefreshPartyRoster (copy), LocalPlayer (copy)
    local v206 = p204 or {};
    RefreshPartyRoster({
        SelectedMode = "Dungeon",
        FriendsOnly = false,
        LeaderId = p205 or LocalPlayer.UserId,
        Members = v206,
        MemberCount = #v206
    });
end;

local function OnOpen() -- Line: 1177
    -- upvalues: u38 (ref), PopulateDungeonList (copy), u29 (ref), u48 (ref), u32 (ref), u34 (ref), u35 (ref), u37 (ref), u51 (ref), RefreshInDungeonRoster (copy), u50 (ref), RefreshPartyRoster (copy), u42 (ref), u41 (ref), DungeonData (copy), u5 (copy), u16 (ref), u19 (ref), Image_Data (copy), u15 (ref), PopulateBossViewport (copy), PopulateRewards (copy), u20 (copy), u1 (copy), u43 (ref), HighlightSelectedDifficulty (copy), SetDungeonSelectedVisual (copy), ApplyDungeonSelectionVisual (copy)
    u38 = true;
    PopulateDungeonList();

    if u29 then
        u29.Visible = not u48;
    end;

    if u32 then
        u32.Visible = not u48;
    end;

    if u34 then
        u34.Visible = not u48;
    end;

    if u35 then
        u35.Visible = not u48;
    end;

    if u37 then
        u37.Visible = not u48;
    end;

    task.spawn(function() -- Line: 1189
        -- upvalues: u48 (ref), u51 (ref), RefreshInDungeonRoster (ref), u50 (ref), RefreshPartyRoster (ref), u42 (ref), u41 (ref), DungeonData (ref), u5 (ref), u16 (ref), u19 (ref), Image_Data (ref), u15 (ref), PopulateBossViewport (ref), PopulateRewards (ref), u20 (ref), u1 (ref), u43 (ref), HighlightSelectedDifficulty (ref), SetDungeonSelectedVisual (ref), ApplyDungeonSelectionVisual (ref)
        if u48 then
            if u51 then
                local v207, v208, v209 = u51:GetSessionMembers():await();

                if v207 and v208 then
                    RefreshInDungeonRoster(v208, v209);
                end;
            end;
        elseif u50 then
            local v210, v211 = u50:RequestPartyData():await();

            if v210 and v211 then
                RefreshPartyRoster(v211);
            end;
        end;

        if not u42 then
            local v212, v213, v214;

            if u41 == "Challenge" then
                v212 = DungeonData.ChallengeModeDisplayOrder;
                v213 = nil;
                v214 = nil;
            else
                v212 = DungeonData.ChallengeDisplayOrder;
                v213 = nil;
                v214 = nil;
            end;

            for _, v in v212, v213, v214 do
                local Dungeon = DungeonData.GetDungeon(v);

                if Dungeon and not Dungeon.HideFromSelect then
                    u5:SelectDungeon(v);

                    return;
                end;
            end;

            return;
        end;

        local v215 = u42;
        local Dungeon = DungeonData.GetDungeon(v215);

        if Dungeon then
            if u16 then
                u16.Text = Dungeon.DisplayName or v215;
            end;

            if u19 then
                local v216 = Image_Data.Dungeons and Image_Data.Dungeons[v215];

                if v216 and v216 ~= "" then
                    u19.Image = v216;
                end;
            end;

            if u15 then
                u15.Visible = true;
            end;
        end;

        PopulateBossViewport(u42);
        PopulateRewards(u42);

        if u41 == "Challenge" then
            for _, v in u20 do
                if v and v.Button then
                    v.Button.Visible = false;
                end;
            end;
        else
            for _, v in u20 do
                if v and v.Button then
                    v.Button.Visible = true;
                end;
            end;

            local u217 = u42;

            if u50 and u217 then
                local Dungeon2 = DungeonData.GetDungeon(u217);

                if Dungeon2 then
                    Dungeon2 = Dungeon2.DifficultyLevelBrackets;
                end;

                task.spawn(function() -- Line: 685
                    -- upvalues: u50 (ref), u217 (copy), u1 (ref), u20 (ref), Dungeon2 (copy), u43 (ref), u5 (ref), HighlightSelectedDifficulty (ref)
                    local v218, v219 = u50:GetUnlockedDifficulties(u217):await();

                    if not (v218 and v219) then
                        return;
                    end;

                    for i, v in u1 do
                        local v220 = u20[i];

                        if v220 then
                            local v221 = v219[v];
                            local v222;

                            if v221 then
                                v222 = v221.Unlocked or false;
                            else
                                v222 = false;
                            end;

                            local v223 = v221 and v221.Reason or "Locked";
                            v220.Locked = not v222;

                            if v220.Background then
                                v220.Background.ImageTransparency = v222 and 0 or 0.5;
                            end;

                            if v220.TextLabel then
                                v220.TextLabel.TextTransparency = v222 and 0 or 0.5;
                            end;

                            if v220.Lvl then
                                if v222 then
                                    local v224 = Dungeon2 and Dungeon2[v];
                                    v220.Lvl.Text = v224 and `Levels {v224.Min}-{v224.Max}` or "";
                                else
                                    v220.Lvl.Text = v223;
                                end;
                            end;
                        end;
                    end;

                    local v225 = u43 and v219[u43];

                    if v225 and v225.Unlocked then
                        u5:SelectDifficulty(u43);

                        return;
                    end;

                    local Easy = v219.Easy;

                    if Easy and Easy.Unlocked then
                        u5:SelectDifficulty("Easy");

                        return;
                    end;

                    u43 = nil;
                    HighlightSelectedDifficulty();
                end);
            end;
        end;

        SetDungeonSelectedVisual(u42);
        ApplyDungeonSelectionVisual(u42);
        HighlightSelectedDifficulty();
    end);
end;

local function OnClose() -- Line: 1230
    -- upvalues: u38 (ref), u48 (ref), u49 (ref), u17 (ref), u41 (ref), u42 (ref), u43 (ref), u20 (copy), u50 (ref)
    u38 = false;
    u48 = false;
    local v226 = u49;
    u49 = nil;

    if v226 then
        task.spawn(v226);
    end;

    if u17 then
        u17:ClearAllChildren();
    end;

    if u41 == "Challenge" then
        u41 = "Dungeon";
        u42 = nil;
        u43 = nil;

        for _, v in u20 do
            if v and v.Button then
                v.Button.Visible = true;
            end;
        end;

        if u50 then
            task.spawn(function() -- Line: 1250
                -- upvalues: u50 (ref)
                u50:RequestSelectMode("Dungeon"):await();
            end);
        end;
    end;
end;

function u5.Open(p227, p228) -- Line: 1262
    -- upvalues: u38 (ref), u6 (ref), u48 (ref), u49 (ref), OnOpen (copy)
    if u38 then
        return;
    end;

    if not u6 then
        return;
    end;

    local v229;

    if p228 then
        v229 = p228.InDungeon;
    else
        v229 = p228;
    end;

    u48 = v229 == true;
    u49 = p228 and p228.OnClose or nil;
    u6:open();
    OnOpen();
end;

function u5.Close(p230) -- Line: 1272
    -- upvalues: u38 (ref), u6 (ref)
    if not u38 then
        return;
    end;

    if not u6 then
        return;
    end;

    u6:close();
end;

function u5.Toggle(p231) -- Line: 1280
    -- upvalues: u38 (ref)
    if u38 then
        p231:Close();

        return;
    end;

    p231:Open();
end;

function u5.IsOpen(p232) -- Line: 1285
    -- upvalues: u38 (ref)
    return u38;
end;

function u5.KnitInit(p233) -- Line: 1291
    -- upvalues: Knit (copy), u7 (ref), u6 (ref), UIController (copy), OnClose (copy), u32 (ref), u33 (ref), u34 (ref), Color3_fromRGB_ret2 (copy), u35 (ref), u36 (ref), u37 (ref), Color3_fromRGB_ret4 (copy), u8 (ref), u9 (ref), u13 (ref), u14 (ref), u2 (copy), u31 (copy), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u1 (copy), u20 (copy), u21 (ref), u22 (ref), u23 (ref), u24 (ref), u27 (ref), u28 (ref), u29 (ref), u30 (ref)
    u7 = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("Frames"):FindFirstChild("Dungeon_Select");

    if not u7 then
        warn("[DungeonSelectController] Dungeon_Select frame not found in Main.Frames");

        return;
    end;

    u7.Visible = false;
    u6 = UIController._cached[u7] or UIController.new(u7);
    u6.onClose = OnClose;
    local Contents = u7:FindFirstChild("Contents");
    local v234;

    if Contents then
        v234 = Contents:FindFirstChild("LeftSection");
    else
        v234 = Contents;
    end;

    local v235;

    if Contents then
        v235 = Contents:FindFirstChild("RightSection");
    else
        v235 = Contents;
    end;

    if Contents then
        u32 = Contents:FindFirstChild("FriendsOnlyButton");
        local v236 = u32 and u32:FindFirstChild("Check");
        u33 = v236;
        u34 = Contents:FindFirstChild("FriendsOnlyTitle");

        if u33 then
            local Attribute = u33:GetAttribute("Off");

            if Attribute then
                u33.Position = Attribute;
            end;

            u33.BackgroundColor3 = Color3_fromRGB_ret2;
        end;

        if u34 then
            u34.Text = "Friends Only: <font color=\"#FF4D4D\">OFF</font>";
        end;

        u35 = Contents:FindFirstChild("SoloButton");
        local v237 = u35 and u35:FindFirstChild("Check");
        u36 = v237;
        u37 = Contents:FindFirstChild("SoloTitle");

        if u36 then
            local Attribute = u36:GetAttribute("Off");

            if Attribute then
                u36.Position = Attribute;
            end;

            u36.BackgroundColor3 = Color3_fromRGB_ret2;
        end;

        if u37 then
            u37.TextColor3 = Color3_fromRGB_ret4;
        end;
    end;

    if v234 then
        u8 = v234:FindFirstChild("ScrollingFrame");

        if u8 then
            u8.ScrollBarThickness = 0;
            u9 = u8:FindFirstChild("DungeonTemplate");

            if u9 then
                u9.Visible = false;
            end;
        end;

        u13 = v234:FindFirstChild("CustomScroll");
        u14 = u13 and u13:FindFirstChild("Bar");

        if u14 then
            u14.AnchorPoint = Vector2.new(u14.AnchorPoint.X, 0);
        end;

        local Party = v234:FindFirstChild("Party");

        if Party then
            Party = Party:FindFirstChild("Players");
        end;

        if Party then
            for i, v in u2 do
                local v238 = Party:FindFirstChild(v);

                if v238 then
                    local Player = v238:FindFirstChild("Player");
                    local v239 = {
                        Button = v238,
                        Player = Player,
                        Add = v238:FindFirstChild("Add")
                    };
                    local v240;

                    if Player then
                        v240 = Player:FindFirstChild("ProfileImage");
                    else
                        v240 = Player;
                    end;

                    v239.ProfileImage = v240;
                    local v241;

                    if Player then
                        v241 = Player:FindFirstChild("PlayerName");
                    else
                        v241 = Player;
                    end;

                    v239.PlayerName = v241;

                    if Player then
                        Player = Player:FindFirstChild("PlayerLevel");
                    end;

                    v239.PlayerLevel = Player;
                    u31[i] = v239;
                end;
            end;
        end;
    end;

    if v235 then
        v235 = v235:FindFirstChild("Info");
    end;

    u15 = v235;

    if u15 then
        u16 = u15:FindFirstChild("Title");
        local View = u15:FindFirstChild("View");

        if View then
            u17 = View:FindFirstChild("ViewportFrame");
            u18 = View:FindFirstChild("Text");
            u19 = View:FindFirstChild("MapImage");

            if u18 then
                u18.Visible = false;
            end;
        end;

        for i, v in u1 do
            local v242 = u15:FindFirstChild(v);

            if v242 then
                local v243 = v242:FindFirstChild("Background") or v242;
                local SelectionStroke = v243:FindFirstChild("SelectionStroke");

                if not SelectionStroke then
                    SelectionStroke = Instance.new("UIStroke");
                    SelectionStroke.Name = "SelectionStroke";
                    SelectionStroke.Thickness = 2.5;
                    SelectionStroke.Color = Color3.fromRGB(255, 255, 255);
                    SelectionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    SelectionStroke.Enabled = false;
                    SelectionStroke.Parent = v243;
                end;

                u20[i] = {
                    Locked = false,
                    Button = v242,
                    Background = v242:FindFirstChild("Background"),
                    TextLabel = v242:FindFirstChild("TextLabel"),
                    Lvl = v242:FindFirstChild("Lvl"),
                    Stroke = SelectionStroke
                };
            end;
        end;

        local Rewards = u15:FindFirstChild("Rewards");
        local v244;

        if Rewards then
            v244 = Rewards:FindFirstChild("ScrollingFrame");
        else
            v244 = Rewards;
        end;

        u21 = v244;
        u22 = u21 and u21:FindFirstChild("Template");

        if u22 then
            u22.Visible = false;
        end;

        local v245;

        if Rewards then
            v245 = Rewards:FindFirstChild("Coins");
        else
            v245 = Rewards;
        end;

        u23 = v245;

        if u23 then
            u23.Visible = false;
        end;

        if Rewards then
            Rewards = Rewards:FindFirstChild("EXP");
        end;

        u24 = Rewards;
        local Buttons = u15:FindFirstChild("Buttons");

        if Buttons then
            u27 = Buttons:FindFirstChild("Enter");
            local v246 = u27 and u27:FindFirstChild("Text");
            u28 = v246;
            u29 = Buttons:FindFirstChild("Leave");
        end;
    end;

    u30 = u7:FindFirstChild("Close");
end;

function u5.KnitStart(u247) -- Line: 1434
    -- upvalues: u53 (ref), Knit (copy), u52 (ref), u54 (ref), u55 (ref), u1 (copy), u20 (copy), u31 (copy), OpenInvitePicker (copy), u8 (ref), UpdateCustomScroll (copy), SetupCustomScrollDrag (copy), u30 (ref), u27 (ref), u46 (ref), u50 (ref), u47 (ref), u42 (ref), u43 (ref), u28 (ref), u48 (ref), u51 (ref), u40 (ref), u29 (ref), u32 (ref), u39 (ref), u33 (ref), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), TweenService (copy), TweenInfo_new_ret4 (copy), u34 (ref), u35 (ref), u45 (ref), u36 (ref), u37 (ref), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), RefreshPartyRoster (copy), LocalPlayer (copy), u41 (ref), u38 (ref), RefreshInDungeonRoster (copy)
    pcall(function() -- Line: 1435
        -- upvalues: u53 (ref), Knit (ref)
        u53 = Knit.GetController("SoundController");
    end);
    pcall(function() -- Line: 1436
        -- upvalues: u52 (ref), Knit (ref)
        u52 = Knit.GetController("NotificationController");
    end);
    pcall(function() -- Line: 1437
        -- upvalues: u54 (ref), Knit (ref)
        u54 = Knit.GetController("PlayerListController");
    end);
    pcall(function() -- Line: 1438
        -- upvalues: u55 (ref), Knit (ref)
        u55 = Knit.GetController("ChallengeDungeonController");
    end);

    for i, v in u1 do
        local u248 = u20[i];

        if u248 and u248.Button then
            u248.Button.Activated:Connect(function() -- Line: 1444
                -- upvalues: u248 (copy), u247 (copy), v (copy)
                if u248.Locked then
                    return;
                end;

                u247:SelectDifficulty(v);
            end);
        end;
    end;

    for i, v in u31 do
        if v.Button then
            v.Button.Activated:Connect(function() -- Line: 1455
                -- upvalues: OpenInvitePicker (ref), i (copy)
                OpenInvitePicker(i);
            end);
        end;
    end;

    if u8 then
        u8:GetPropertyChangedSignal("CanvasPosition"):Connect(UpdateCustomScroll);
        u8:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(UpdateCustomScroll);
        u8:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(UpdateCustomScroll);
    end;

    SetupCustomScrollDrag();

    if u30 then
        u30.Activated:Connect(function() -- Line: 1471
            -- upvalues: u247 (copy)
            u247:Close();
        end);
    end;

    if u27 then
        u27.Activated:Connect(function() -- Line: 1478
            -- upvalues: u46 (ref), u50 (ref), u47 (ref), u42 (ref), u52 (ref), u43 (ref), u27 (ref), u28 (ref), u48 (ref), u51 (ref), u40 (ref), u53 (ref), u247 (copy)
            if not u46 then
                return;
            end;

            if not u50 then
                return;
            end;

            if u47 then
                return;
            end;

            if not u42 then
                if u52 then
                    u52:Show("Custom", "Select a dungeon first.", 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
                end;

                return;
            end;

            if not u43 then
                if u52 then
                    u52:Show("Custom", "Select a difficulty first.", 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
                end;

                return;
            end;

            u47 = true;
            u27.Active = false;

            if u28 then
                u28.Text = "WARPING...";
            end;

            task.spawn(function() -- Line: 1502
                -- upvalues: u48 (ref), u51 (ref), u42 (ref), u43 (ref), u40 (ref), u50 (ref), u47 (ref), u27 (ref), u28 (ref), u53 (ref), u247 (ref), u52 (ref)
                local v249, v250, v251;

                if u48 then
                    if u51 then
                        v249, v250, v251 = u51:RequestDungeonChange(u42, u43):await();
                    else
                        v249 = false;
                        v250 = false;
                        v251 = "Service unavailable";
                    end;
                elseif u40 then
                    v249, v250, v251 = u50:RequestStartSoloRun():await();
                else
                    v249, v250, v251 = u50:RequestStartPodQueue():await();
                end;

                if not v249 then
                    v250 = false;
                    v251 = "Server request failed";
                end;

                u47 = false;

                if u27 then
                    u27.Active = true;
                end;

                if u28 then
                    u28.Text = "ENTER";
                end;

                if not v250 then
                    if u52 then
                        u52:Show("Custom", v251 or "Failed to start.", 4, Color3.fromRGB(255, 80, 80), Color3.fromRGB(60, 15, 15), "Error");
                    end;

                    return;
                end;

                if u53 then
                    u53:Play("UI_Begin");
                end;

                u247:Close();
            end);
        end);
    end;

    if u29 then
        u29.Activated:Connect(function() -- Line: 1538
            -- upvalues: u48 (ref), u50 (ref)
            if u48 then
                return;
            end;

            if not u50 then
                return;
            end;

            task.spawn(function() -- Line: 1541
                -- upvalues: u50 (ref)
                u50:RequestLeaveParty():await();
            end);
        end);
    end;

    if u32 then
        u32.Activated:Connect(function() -- Line: 1549
            -- upvalues: u48 (ref), u46 (ref), u50 (ref), u53 (ref), u39 (ref), u33 (ref), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref), TweenService (ref), TweenInfo_new_ret4 (ref), u34 (ref)
            if u48 then
                return;
            end;

            if not u46 then
                return;
            end;

            if not u50 then
                return;
            end;

            if u53 then
                u53:Play("Click");
            end;

            local u252 = not u39;

            if u33 then
                local v253 = u252 and u33:GetAttribute("On") or u33:GetAttribute("Off");
                local v254 = {
                    BackgroundColor3 = u252 and Color3_fromRGB_ret or Color3_fromRGB_ret2
                };

                if v253 then
                    v254.Position = v253;
                end;

                TweenService:Create(u33, TweenInfo_new_ret4, v254):Play();
            end;

            if u34 then
                u34.Text = `Friends Only: {u252 and "<font color=\"#4DFF4D\">ON</font>" or "<font color=\"#FF4D4D\">OFF</font>"}`;
            end;

            u39 = u252;
            task.spawn(function() -- Line: 1559
                -- upvalues: u50 (ref), u252 (copy)
                u50:RequestSetFriendsOnly(u252):await();
            end);
        end);
    end;

    if u35 then
        u35.Activated:Connect(function() -- Line: 1567
            -- upvalues: u48 (ref), u40 (ref), u45 (ref), u52 (ref), u53 (ref), u36 (ref), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref), TweenService (ref), TweenInfo_new_ret4 (ref), u37 (ref), Color3_fromRGB_ret3 (ref), Color3_fromRGB_ret4 (ref)
            if u48 then
                return;
            end;

            local v255 = not u40;

            if v255 and (u45 and (u45.MemberCount or 0) > 1) then
                if u52 then
                    u52:Show("Custom", "Can\'t enable Solo mode while in a party.", 3, Color3.fromRGB(255, 80, 80), Color3.fromRGB(60, 15, 15), "Error");
                end;

                return;
            end;

            if u53 then
                u53:Play("Click");
            end;

            u40 = v255;

            if u36 then
                local v256 = v255 and u36:GetAttribute("On") or u36:GetAttribute("Off");
                local v257 = {
                    BackgroundColor3 = v255 and Color3_fromRGB_ret or Color3_fromRGB_ret2
                };

                if v256 then
                    v257.Position = v256;
                end;

                TweenService:Create(u36, TweenInfo_new_ret4, v257):Play();
            end;

            if u37 then
                u37.TextColor3 = v255 and Color3_fromRGB_ret3 or Color3_fromRGB_ret4;
            end;
        end);
    end;

    local success, result = pcall(function() -- Line: 1587
        -- upvalues: Knit (ref)
        return Knit.GetService("DungeonQueueService");
    end);

    if success and result then
        u50 = result;
        u50.PartyUpdate:Connect(function(p258) -- Line: 1594
            -- upvalues: u48 (ref), RefreshPartyRoster (ref)
            if u48 then
                return;
            end;

            RefreshPartyRoster(p258);
        end);
        u50.PodPromptRequested:Connect(function(p259) -- Line: 1601
            -- upvalues: u45 (ref), LocalPlayer (ref), u55 (ref), u41 (ref), u42 (ref), u43 (ref), u50 (ref), u247 (copy)
            if p259 == "Challenge" or p259 == "Raids" then
                return;
            end;

            local v260 = u45;

            if v260 and (v260.LeaderId ~= LocalPlayer.UserId and v260.SelectedMode == "Challenge") then
                if u55 then
                    u55:Open();
                end;

                return;
            end;

            if u41 ~= "Dungeon" then
                u41 = "Dungeon";
                u42 = nil;
                u43 = nil;
            end;

            if u50 then
                task.spawn(function() -- Line: 1627
                    -- upvalues: u50 (ref)
                    u50:RequestSelectMode("Dungeon"):await();
                end);
            end;

            u247:Open();
        end);
    else
        warn("[DungeonSelectController] DungeonQueueService not available — server features disabled");
    end;

    local success2, result2 = pcall(function() -- Line: 1638
        -- upvalues: Knit (ref)
        return Knit.GetService("DungeonRunService");
    end);

    if success2 and result2 then
        u51 = result2;
        u51.SessionMemberUpdate:Connect(function(p261, p262) -- Line: 1645
            -- upvalues: u38 (ref), u48 (ref), RefreshInDungeonRoster (ref)
            if not (u38 and u48) then
                return;
            end;

            RefreshInDungeonRoster(p261, p262);
        end);
    end;
end;

return u5;