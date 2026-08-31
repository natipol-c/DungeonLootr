--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DungeonChestController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.DungeonChestController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local ProximityPromptService = game:GetService("ProximityPromptService");
local Debris = game:GetService("Debris");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Registry = require(script.Parent.Registry);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local ForgeVFXUtil = require(ReplicatedStorage.Modules.ForgeVFXUtil);
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local u1 = nil;

local function GetCoinPopTemplate() -- Line: 41
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    if u1 and u1.Parent then
        return u1;
    end;

    local Assets = ReplicatedStorage:FindFirstChild("Assets");

    if Assets then
        Assets = Assets:FindFirstChild("Effects");
    end;

    if Assets then
        Assets = Assets:FindFirstChild("CoinPop");
    end;

    if not (Assets and Assets:IsA("PVInstance")) then
        return nil;
    end;

    u1 = Assets;

    return Assets;
end;

local v2 = Knit.CreateController({
    Name = "DungeonChestController"
});

local function FindByAttribute(p3: string, p4: string) -- Line: 63
    local Dungeons = workspace:FindFirstChild("Dungeons");

    if Dungeons then
        for _, descendant in Dungeons:GetDescendants() do
            if descendant:GetAttribute(p3) == p4 then
                return descendant;
            end;
        end;
    end;

    for _, child in workspace:GetChildren() do
        if child:IsA("Folder") and child ~= Dungeons then
            for _, descendant in child:GetDescendants() do
                if descendant:GetAttribute(p3) == p4 then
                    return descendant;
                end;
            end;
        end;
    end;

    return nil;
end;

local function FindChestByUID(p5: string) -- Line: 87
    -- upvalues: FindByAttribute (copy)
    return FindByAttribute("ChestUID", p5);
end;

local function FindBookByUID(p6: string) -- Line: 92
    -- upvalues: FindByAttribute (copy)
    return FindByAttribute("BookUID", p6);
end;

function v2._PlayCollectionVFX(p7: table, u8: userdata, p9: string?) -- Line: 99
    -- upvalues: SharedUtils (copy), TweenService (copy)
    if not (u8 and u8.Parent) then
        return;
    end;

    local RarityHighlight = u8:FindFirstChild("RarityHighlight");

    if RarityHighlight then
        RarityHighlight.Enabled = false;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.FillTransparency = 0.2;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = u8;
    local v10 = u8.PrimaryPart or u8:FindFirstChildWhichIsA("BasePart");

    if v10 then
        SharedUtils.PlaySoundAt(v10, p9 or "Opening_Chest");
    end;

    TweenService:Create(Highlight, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();

    for _, descendant in u8:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Transparency < 1 then
            TweenService:Create(descendant, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end;
    end;

    local v11 = u8:FindFirstChildOfClass("ProximityPrompt") or u8:FindFirstChildWhichIsA("ProximityPrompt", true);

    if v11 then
        v11.Enabled = false;
    end;

    task.delay(0.5, function() -- Line: 148
        -- upvalues: Highlight (copy), u8 (copy)
        if Highlight and Highlight.Parent then
            Highlight:Destroy();
        end;

        if u8 and u8.Parent then
            u8:Destroy();
        end;
    end);
end;

function v2._PlayChestCoinPop(p12: table, p13: userdata) -- Line: 164
    -- upvalues: GetCoinPopTemplate (copy), ForgeVFXUtil (copy), Debris (copy)
    if not (p13 and p13.Parent) then
        return;
    end;

    local v14 = GetCoinPopTemplate();

    if not v14 then
        return;
    end;

    local BoundingBox, v15 = p13:GetBoundingBox();
    local v16 = BoundingBox * CFrame.new(0, v15.Y / 2, 0);
    local u17 = v14:Clone();
    u17:PivotTo(v16);
    u17.Parent = ForgeVFXUtil.GetDefaultParent();
    task.delay(0.05, function() -- Line: 181
        -- upvalues: u17 (copy), ForgeVFXUtil (ref), Debris (ref)
        if not u17.Parent then
            return;
        end;

        ForgeVFXUtil.GetForge().emit(u17);
        Debris:AddItem(u17, 1.5);
    end);
end;

function v2.KnitInit(p18) -- Line: 190
end;

function v2.KnitStart(u19) -- Line: 194
    -- upvalues: Knit (copy), ProximityPromptService (copy), ReplicatedStorage (copy), FindByAttribute (copy), Registry (copy), Color3_fromRGB_ret (copy)
    local Service = Knit.GetService("DungeonChestService");
    ProximityPromptService.PromptShown:Connect(function(p20) -- Line: 209
        if p20.Name == "ChestPrompt" and p20.Style == Enum.ProximityPromptStyle.Custom then
            p20:InputHoldBegin();
        end;
    end);
    ProximityPromptService.PromptHidden:Connect(function(p21) -- Line: 214
        if p21.Name == "ChestPrompt" and p21.Style == Enum.ProximityPromptStyle.Custom then
            p21:InputHoldEnd();
        end;
    end);
    local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
    local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
    require(GameInfo:WaitForChild("KeyData"));
    local RarityData = require(GameInfo:WaitForChild("RarityData"));
    local u22 = RarityData.RarityIndex.Legendary or 5;
    local success, result = pcall(Knit.GetController, "RewardRevealController");

    if not success then
        result = nil;
    end;

    Service.ChestCollected:Connect(function(p23, p24, p25, p26, p27) -- Line: 234
        -- upvalues: FindByAttribute (ref), RarityData (copy), u22 (copy), u19 (copy), result (ref), Registry (ref), RarityColors (copy), Color3_fromRGB_ret (ref)
        local v28 = FindByAttribute("ChestUID", p23);

        if v28 then
            u19:_PlayCollectionVFX(v28, u22 <= (RarityData.RarityIndex[p24] or 0) and "UI_LegendaryChest" or "UI_NormalOpen");
            u19:_PlayChestCoinPop(v28);
        end;

        local v29;

        if result and (p27 and #p27 > 0) then
            v29 = result:PlayEntries(p27, (p24 == nil or p24 == "") and "Chest Opened" or (`{p24} Chest` or "Chest Opened")) == true;
        else
            v29 = false;
        end;

        local v30 = Registry:Get("ItemNotification");

        if not v30 then
            return;
        end;

        if p25 == "Gear" then
            if not v29 and (p26 and p26 ~= "") then
                local v31 = RarityColors[p24];
                local v32 = v31 and v31.TextColor3 or Color3_fromRGB_ret;
                v30.ShowItem(`{p24} {p26}`, nil, v32);
            end;
        else
            if p25 == "Material" then
                return;
            end;

            if p25 == "Coins" then
                return;
            end;

            if p25 == "Stars" then
                return;
            end;

            if p25 == "Key" then
                return;
            end;

            if p25 == "PotionRefill" then
                v30.ShowItem("Potion Refill", nil, Color3.fromRGB(80, 255, 120));
            end;
        end;
    end);
    Service.BookCollected:Connect(function(p33, p34, p35) -- Line: 295
        -- upvalues: FindByAttribute (ref), u19 (copy)
        local v36 = FindByAttribute("BookUID", p33);

        if v36 then
            u19:_PlayCollectionVFX(v36);
        end;
    end);
    Knit.GetService("DungeonRunService").PotionStationUsed:Connect(function() -- Line: 310
        -- upvalues: Registry (ref)
        local v37 = Registry:Get("ItemNotification");

        if v37 then
            v37.ShowItem("Potion Refill", nil, Color3.fromRGB(80, 255, 120));
        end;
    end);
end;

return v2;