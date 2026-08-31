--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ChestSelectionController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.ChestSelectionController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local Debris = game:GetService("Debris");
local MarketplaceService = game:GetService("MarketplaceService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local RewardCardRender = require(script.Parent.Parent.ClientUtils.RewardCardRender);
local EquipmentStatLines = require(script.Parent.Parent.ClientUtils.EquipmentStatLines);
local Registry = require(script.Parent.Registry);
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    Mythic = true,
    Celestial = true,
    Exotic = true
};
local Back = Enum.EasingStyle.Back;
local TweenInfo_new_ret = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v2 = Knit.CreateController({
    Name = "ChestSelectionController"
});

local function PlayNamedSFX(p3: string) -- Line: 78
    -- upvalues: SoundService (copy)
    local v4 = SoundService:FindFirstChild(p3, true);

    if v4 and v4:IsA("Sound") then
        v4:Play();
    end;
end;

local function PlayChestLand() -- Line: 87
    -- upvalues: SoundService (copy), Debris (copy)
    local Chest_Land = SoundService:FindFirstChild("Chest_Land", true);

    if not (Chest_Land and Chest_Land:IsA("Sound")) then
        return;
    end;

    local v5 = Chest_Land:Clone();
    v5.PlaybackSpeed = 1 + (math.random() * 2 - 1) * 0.02;
    v5.Parent = SoundService;
    v5:Play();
    Debris:AddItem(v5, 5);
end;

function v2._Resolve(u6) -- Line: 100
    -- upvalues: LocalPlayer (copy)
    if u6._frame then
        return true;
    end;

    local Chest_Selection = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("Chest_Selection");

    if not Chest_Selection then
        warn("[ChestSelectionController] Main.HUD.Chest_Selection missing");

        return false;
    end;

    u6._frame = Chest_Selection;
    u6._textLabel = Chest_Selection:FindFirstChild("TextLabel");
    u6._finish = Chest_Selection:FindFirstChild("Finish");
    u6._chests = {};

    for i = 1, 3 do
        local v7 = Chest_Selection:FindFirstChild("Chest_" .. i);
        local v8;

        if v7 then
            local Chest = v7:FindFirstChild("Chest");
            local Glow = v7:FindFirstChild("Glow");
            local v9;

            if Glow then
                v9 = Glow:FindFirstChildOfClass("UIScale");
            else
                v9 = Glow;
            end;

            if Glow and not v9 then
                v9 = Instance.new("UIScale");
                v9.Scale = 0;
                v9.Parent = Glow;
            end;

            local _chests = u6._chests;
            local v10 = {
                Index = i,
                Button = v7
            };

            if Chest then
                Chest = Chest:FindFirstChildOfClass("UIScale");
            end;

            v10.ChestScale = Chest;
            v10.ItemTemplate = v7:FindFirstChild("ItemTemplate");
            v10.Glow = Glow;
            v10.GlowScale = v9;
            v10.StartPos = v7:GetAttribute("Start_Position");
            v10.EndPos = v7:GetAttribute("End_Position");
            _chests[i] = v10;
            v7.MouseButton1Click:Connect(function() -- Line: 143
                -- upvalues: u6 (copy), i (copy)
                u6:_OnChestClicked(i);
            end);
            v7.MouseEnter:Connect(function() -- Line: 148
                -- upvalues: u6 (copy), i (copy)
                u6:_ShowItemInfo(i);
            end);
            v7.MouseLeave:Connect(function() -- Line: 151
                -- upvalues: u6 (copy), i (copy)
                u6:_HideItemInfo(i);
            end);
            v8 = i;
        else
            v8 = i;
        end;
    end;

    local ItemInfo = Chest_Selection:FindFirstChild("ItemInfo");

    if ItemInfo then
        u6._itemInfo = ItemInfo;
        u6._iiStatsFrame = ItemInfo:FindFirstChild("Stats");
        local v11 = u6._iiStatsFrame and u6._iiStatsFrame:FindFirstChild("Template");
        u6._iiStatTemplate = v11;
        u6._iiStatsTitle = ItemInfo:FindFirstChild("StatsTitle");
        u6._iiForgeLabel = ItemInfo:FindFirstChild("ForgeLevel");
        u6._iiEquipped = ItemInfo:FindFirstChild("Equipped");
        u6._iiLevelLabel = ItemInfo:FindFirstChild("ItemLevel");

        if u6._iiStatTemplate then
            u6._iiStatTemplate.Visible = false;
        end;

        if u6._iiEquipped then
            u6._iiEquipped.Visible = false;
        end;

        ItemInfo.AnchorPoint = Vector2.new(0, 0.5);
        ItemInfo.GroupTransparency = 1;
        ItemInfo.Visible = false;
        ItemInfo.Active = false;
        ItemInfo.Interactable = false;
    end;

    if u6._finish then
        u6._finish.MouseButton1Click:Connect(function() -- Line: 182
            -- upvalues: u6 (copy)
            u6:_OnFinish();
        end);
    end;

    return true;
end;

function v2.IsActive(p12) -- Line: 196
    return p12._active == true;
end;

function v2._Reset(p13) -- Line: 200
    p13._active = false;
    p13._ready = false;
    p13._candidates = nil;
    p13._selected = {};
    p13._selectedCount = 0;
    p13._pendingThirdIndex = nil;
    p13._revealed = {};
    p13:_HideItemInfoImmediate();

    if not p13._frame then
        return;
    end;

    p13._frame.Visible = false;
    p13._frame.GroupTransparency = 1;

    if p13._finish then
        p13._finish.Visible = false;
    end;

    for _, v in p13._chests do
        if v.ChestScale then
            v.ChestScale.Scale = 1;
        end;

        if v.ItemTemplate then
            v.ItemTemplate.Visible = false;
            v.ItemTemplate.GroupTransparency = 1;
        end;

        if v.StartPos then
            v.Button.Position = v.StartPos;
        end;

        p13:_StopGlow(v);
    end;
end;

function v2._Show(u14: table, p15: any, p16: boolean, p17: string?) -- Line: 237
    -- upvalues: TweenService (copy), Back (copy), PlayChestLand (copy)
    if not u14:_Resolve() then
        return;
    end;

    if type(p15) ~= "table" or #p15 == 0 then
        return;
    end;

    u14:_Reset();
    u14._candidates = p15;
    u14._source = p17 or "Dungeon";
    u14._ownsExtraLoot = p16 == true;
    u14._maxPicks = u14._ownsExtraLoot and 3 or 2;
    u14._active = true;

    if u14._textLabel then
        u14._textLabel.Text = u14._ownsExtraLoot and "SELECT 3 CHESTS:" or "SELECT 2 CHESTS:";
    end;

    u14._frame.Visible = true;
    u14._frame.GroupTransparency = 1;
    TweenService:Create(u14._frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();

    for _, v in u14._chests do
        if v.GlowScale then
            v.GlowScale.Scale = 0;
        end;

        if v.Glow then
            v.Glow.Rotation = 0;
        end;
    end;

    for i = 1, #u14._chests do
        local u18 = u14._chests[i];
        local v19;

        if u18.StartPos and u18.EndPos then
            u18.Button.Position = u18.StartPos;
            task.delay((i - 1) * 0.18, function() -- Line: 271
                -- upvalues: u14 (copy), u18 (copy), TweenService (ref), Back (ref), PlayChestLand (ref)
                if not (u14._active and u18.Button.Parent) then
                    return;
                end;

                local v20 = TweenService:Create(u18.Button, TweenInfo.new(0.55, Back, Enum.EasingDirection.Out), {
                    Position = u18.EndPos
                });
                v20.Completed:Connect(function() -- Line: 278
                    -- upvalues: PlayChestLand (ref)
                    PlayChestLand();
                end);
                v20:Play();
            end);
            v19 = i;
        else
            v19 = i;
        end;
    end;

    task.delay((#u14._chests - 1) * 0.18 + 0.55, function() -- Line: 288
        -- upvalues: u14 (copy)
        if u14._active then
            u14._ready = true;
        end;
    end);
end;

function v2._OnChestClicked(p21: table, p22: number) -- Line: 295
    -- upvalues: Knit (copy)
    if not (p21._active and p21._ready) then
        return;
    end;

    if p21._selected[p22] then
        return;
    end;

    if not (p21._candidates and p21._candidates[p22]) then
        return;
    end;

    if p21._selectedCount >= p21._maxPicks then
        if not p21._ownsExtraLoot and p21._selectedCount == 2 then
            p21._pendingThirdIndex = p22;
            local Controller = Knit.GetController("MarketplaceController");

            if Controller then
                Controller:PromptProduct(3612698416);
            end;
        end;

        return;
    end;

    p21:_SelectChest(p22);
end;

function v2._SelectChest(p23: table, p24: number) -- Line: 319
    p23._selected[p24] = true;
    p23._selectedCount = p23._selectedCount + 1;
    p23:_RevealChest(p24);

    if p23._selectedCount >= p23._maxPicks and p23._finish then
        p23._finish.Visible = true;
    end;
end;

function v2._RevealChest(u25: table, p26: number) -- Line: 331
    -- upvalues: TweenService (copy), RewardCardRender (copy), u1 (copy), SoundService (copy)
    local u27 = u25._chests[p26];
    local u28 = u25._candidates and u25._candidates[p26];

    if not (u27 and u28) then
        return;
    end;

    u25._revealed[p26] = true;
    task.spawn(function() -- Line: 339
        -- upvalues: u27 (copy), TweenService (ref), RewardCardRender (ref), u28 (copy), u25 (copy), u1 (ref), SoundService (ref)
        local ChestScale = u27.ChestScale;

        if ChestScale then
            TweenService:Create(ChestScale, TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Scale = 1.25
            }):Play();
            task.wait(0.22);
            TweenService:Create(ChestScale, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Scale = 0
            }):Play();
            task.wait(0.16);
        end;

        local ItemTemplate = u27.ItemTemplate;

        if ItemTemplate then
            pcall(RewardCardRender.populateRewardCard, ItemTemplate, u28);
            local Item_Level = ItemTemplate:FindFirstChild("Item_Level");

            if Item_Level and Item_Level:IsA("TextLabel") then
                if u28.Type == "Equipment" and u28.LevelReq then
                    Item_Level.Text = "Lv " .. tostring(u28.LevelReq);
                    Item_Level.Visible = true;
                else
                    Item_Level.Visible = false;
                end;
            end;

            ItemTemplate.GroupTransparency = 1;
            ItemTemplate.Visible = true;
            TweenService:Create(ItemTemplate, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                GroupTransparency = 0
            }):Play();
        end;

        u25:_StartGlow(u27);

        if u28.Rarity and u1[u28.Rarity] then
            local Mythic_Chest = SoundService:FindFirstChild("Mythic_Chest", true);

            if Mythic_Chest and Mythic_Chest:IsA("Sound") then
                Mythic_Chest:Play();
            end;
        else
            local UI_LegendaryChest = SoundService:FindFirstChild("UI_LegendaryChest", true);

            if UI_LegendaryChest and UI_LegendaryChest:IsA("Sound") then
                UI_LegendaryChest:Play();
            end;
        end;
    end);
end;

function v2._StartGlow(p29, u30) -- Line: 394
    -- upvalues: TweenService (copy)
    local GlowScale = u30.GlowScale;
    local Glow = u30.Glow;

    if not (GlowScale and Glow) then
        return;
    end;

    if u30.GlowScaleTween then
        u30.GlowScaleTween:Cancel();
    end;

    GlowScale.Scale = 0;
    local u31 = TweenService:Create(GlowScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    });
    u30.GlowScaleTween = u31;
    u31.Completed:Connect(function(p32) -- Line: 410
        -- upvalues: u30 (copy), u31 (copy), Glow (copy), TweenService (ref)
        if p32 ~= Enum.PlaybackState.Completed then
            return;
        end;

        if u30.GlowScaleTween ~= u31 then
            return;
        end;

        if u30.GlowSpinTween then
            u30.GlowSpinTween:Cancel();
        end;

        Glow.Rotation = 0;
        u30.GlowSpinTween = TweenService:Create(Glow, TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
            Rotation = 360
        });
        u30.GlowSpinTween:Play();
    end);
    u31:Play();
end;

function v2._StopGlow(p33, p34) -- Line: 428
    if p34.GlowScaleTween then
        p34.GlowScaleTween:Cancel();
        p34.GlowScaleTween = nil;
    end;

    if p34.GlowSpinTween then
        p34.GlowSpinTween:Cancel();
        p34.GlowSpinTween = nil;
    end;
end;

function v2._PositionItemInfoAtMouse(p35) -- Line: 448
    -- upvalues: UserInputService (copy)
    if not p35._itemInfo then
        return;
    end;

    local MouseLocation = UserInputService:GetMouseLocation();
    p35._itemInfo.Position = UDim2.fromOffset(MouseLocation.X + 18, MouseLocation.Y);
end;

function v2._PopulateItemInfo(p36, p37) -- Line: 456
    -- upvalues: EquipmentStatLines (copy), Registry (copy)
    if not (p36._iiStatsFrame and p36._iiStatTemplate) then
        return;
    end;

    local v38 = {
        Slot = p37.Slot,
        BaseDamage = p37.BaseDamage,
        GuaranteedStat = p37.GuaranteedStat,
        StatLines = EquipmentStatLines.build(p37.Stats, p37.Slot),
        ForgeBonuses = p37.ForgeBonuses
    };
    local v39 = Registry:Get("PlayerData");

    if v39 then
        v39 = v39.Data;
    end;

    local v40;

    if v39 and (v39.Equipment and p37.Slot) then
        v40 = v39.Equipment[p37.Slot];
    else
        v40 = nil;
    end;

    EquipmentStatLines.render(p36._iiStatsFrame, p36._iiStatTemplate, v38, v40);

    if p36._iiStatsTitle then
        p36._iiStatsTitle.Visible = true;
    end;

    if p36._iiLevelLabel then
        if p37.LevelReq and p37.LevelReq > 0 then
            p36._iiLevelLabel.Text = "Lvl. " .. p37.LevelReq;
            p36._iiLevelLabel.TextColor3 = (v39 and v39.PlayerLevel or 1) < p37.LevelReq and Color3.fromRGB(255, 75, 75) or Color3.fromRGB(180, 180, 180);
            p36._iiLevelLabel.Visible = true;
        else
            p36._iiLevelLabel.Visible = false;
        end;
    end;

    if p36._iiForgeLabel then
        local v41 = p37.ForgeLevel or 0;

        if v41 >= 1 then
            p36._iiForgeLabel.Text = "Forge Lvl. " .. v41;
            p36._iiForgeLabel.Visible = true;

            return;
        end;

        p36._iiForgeLabel.Visible = false;
    end;
end;

function v2._ShowItemInfo(u42: table, p43: number) -- Line: 507
    -- upvalues: RunService (copy), TweenService (copy), TweenInfo_new_ret (copy)
    if not (u42._active and u42._itemInfo) then
        return;
    end;

    if not (u42._revealed and u42._revealed[p43]) then
        return;
    end;

    local v44 = u42._candidates and u42._candidates[p43];

    if not v44 or v44.Type ~= "Equipment" then
        return;
    end;

    u42:_PopulateItemInfo(v44);
    u42._iiTarget = p43;
    u42._itemInfo.Visible = true;
    u42:_PositionItemInfoAtMouse();

    if u42._iiFollowConn then
        u42._iiFollowConn:Disconnect();
    end;

    u42._iiFollowConn = RunService.RenderStepped:Connect(function() -- Line: 520
        -- upvalues: u42 (copy)
        u42:_PositionItemInfoAtMouse();
    end);

    if u42._iiTween then
        u42._iiTween:Cancel();
    end;

    u42._iiTween = TweenService:Create(u42._itemInfo, TweenInfo_new_ret, {
        GroupTransparency = 0
    });
    u42._iiTween:Play();
end;

function v2._HideItemInfo(u45: table, p46: number?) -- Line: 530
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    if not u45._itemInfo then
        return;
    end;

    if p46 ~= nil and u45._iiTarget ~= p46 then
        return;
    end;

    u45._iiTarget = nil;

    if u45._iiFollowConn then
        u45._iiFollowConn:Disconnect();
        u45._iiFollowConn = nil;
    end;

    if u45._iiTween then
        u45._iiTween:Cancel();
    end;

    local u47 = TweenService:Create(u45._itemInfo, TweenInfo_new_ret, {
        GroupTransparency = 1
    });
    u45._iiTween = u47;
    u47.Completed:Connect(function(p48) -- Line: 543
        -- upvalues: u45 (copy), u47 (copy)
        if p48 == Enum.PlaybackState.Completed and (u45._iiTarget == nil and u45._iiTween == u47) then
            u45._itemInfo.Visible = false;
        end;
    end);
    u47:Play();
end;

function v2._HideItemInfoImmediate(p49) -- Line: 553
    p49._iiTarget = nil;

    if p49._iiFollowConn then
        p49._iiFollowConn:Disconnect();
        p49._iiFollowConn = nil;
    end;

    if p49._iiTween then
        p49._iiTween:Cancel();
        p49._iiTween = nil;
    end;

    if p49._itemInfo then
        p49._itemInfo.GroupTransparency = 1;
        p49._itemInfo.Visible = false;
    end;
end;

function v2._OnPurchaseFinished(p50: table, p51: number, p52: boolean) -- Line: 573
    if p51 ~= 3612698416 or not p52 then
        return;
    end;

    if not p50._active then
        return;
    end;

    p50._ownsExtraLoot = true;
    p50._maxPicks = 3;

    if p50._textLabel then
        p50._textLabel.Text = "SELECT 3 CHESTS:";
    end;

    local _pendingThirdIndex = p50._pendingThirdIndex;
    p50._pendingThirdIndex = nil;

    if _pendingThirdIndex and (not p50._selected[_pendingThirdIndex] and p50._selectedCount < p50._maxPicks) then
        p50:_SelectChest(_pendingThirdIndex);
    end;
end;

function v2._OnFinish(u53) -- Line: 590
    -- upvalues: TweenService (copy), Knit (copy)
    if not u53._active then
        return;
    end;

    if u53._selectedCount < u53._maxPicks then
        return;
    end;

    u53._active = false;
    u53._ready = false;

    if u53._finish then
        u53._finish.Visible = false;
    end;

    for _, v in u53._chests do
        u53:_StopGlow(v);
    end;

    local u54 = {};

    for i in u53._selected do
        table.insert(u54, i);
    end;

    if u53._frame then
        TweenService:Create(u53._frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            GroupTransparency = 1
        }):Play();
    end;

    local u55 = u53._source or "Dungeon";
    task.spawn(function() -- Line: 620
        -- upvalues: u53 (copy), u55 (copy), Knit (ref), u54 (copy)
        task.wait(0.35);

        if u53._frame then
            u53._frame.Visible = false;
        end;

        local v56, v57, v58;

        if u55 == "BossRush" then
            v56, v57, v58 = Knit.GetService("BossRushService"):SelectFloorChests(u54):await();
        elseif u55 == "MidRun" then
            v56, v57, v58 = Knit.GetService("DungeonRunService"):SelectMidRunChests(u54):await();
        else
            v56, v57, v58 = Knit.GetService("DungeonRunService"):SelectChests(u54):await();
        end;

        if not (v56 and v57) then
            warn("[ChestSelectionController] SelectChests failed:", v58 or (v56 and "unknown" or "promise rejected"));
        end;

        u53:_Reset();
    end);
end;

function v2.KnitStart(u59) -- Line: 650
    -- upvalues: Knit (copy), MarketplaceService (copy), LocalPlayer (copy)
    u59._selected = {};
    u59._selectedCount = 0;

    if u59:_Resolve() then
        u59:_Reset();
    end;

    local Service = Knit.GetService("DungeonRunService");
    Service.ChestSelection:Connect(function(p60, p61) -- Line: 660
        -- upvalues: u59 (copy)
        u59:_Show(p60, p61, "Dungeon");
    end);
    Service.MidRunChestSelection:Connect(function(p62, p63) -- Line: 666
        -- upvalues: u59 (copy)
        u59:_Show(p62, p63, "MidRun");
    end);
    Service.DungeonComplete:Connect(function() -- Line: 672
        -- upvalues: u59 (copy)
        if u59._frame and u59._frame.Visible then
            u59:_Reset();
        end;
    end);
    local success, result = pcall(function() -- Line: 681
        -- upvalues: Knit (ref)
        return Knit.GetService("BossRushService");
    end);

    if success and result then
        if result.ChestSelection then
            result.ChestSelection:Connect(function(p64, p65) -- Line: 686
                -- upvalues: u59 (copy)
                u59:_Show(p64, p65, "BossRush");
            end);
        end;

        if result.DungeonComplete then
            result.DungeonComplete:Connect(function() -- Line: 691
                -- upvalues: u59 (copy)
                if u59._frame and u59._frame.Visible then
                    u59:_Reset();
                end;
            end);
        end;
    end;

    MarketplaceService.PromptProductPurchaseFinished:Connect(function(p66, p67, p68) -- Line: 700
        -- upvalues: LocalPlayer (ref), u59 (copy)
        if p66 ~= LocalPlayer.UserId then
            return;
        end;

        u59:_OnPurchaseFinished(p67, p68);
    end);
end;

return v2;