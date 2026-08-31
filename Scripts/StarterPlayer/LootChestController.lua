--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LootChestController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.LootChestController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Packages = ReplicatedStorage:WaitForChild("Packages");
local Knit = require(Packages.Knit);
local LootChestData = require(ReplicatedStorage.GameInfo.LootChestData);
local ViewportModel = require(ReplicatedStorage.Modules.ViewportModel);
local v1 = Knit.CreateController({
    Name = "LootChestController"
});

local function DeepFind(p2, p3) -- Line: 29
    return p2:FindFirstChild(p3, true);
end;

local function SetupWeaponViewport(p4: userdata, p5: string) -- Line: 34
    -- upvalues: ReplicatedStorage (copy), ViewportModel (copy)
    for _, child in p4:GetChildren() do
        if child:IsA("Camera") or (child:IsA("Model") or child:IsA("WorldModel")) then
            child:Destroy();
        end;
    end;

    local v6 = ReplicatedStorage.Weapons:FindFirstChild(p5);

    if not v6 then
        warn("[LootChestController] Weapon prefab not found:", p5);

        return;
    end;

    local Prefab = v6:FindFirstChild("Prefab");

    if not Prefab then
        warn("[LootChestController] No Prefab folder in weapon:", p5);

        return;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = p4;
    local Model = Instance.new("Model");
    Model.Name = p5;

    for _, child in Prefab:GetChildren() do
        if child:IsA("BasePart") or child:IsA("MeshPart") then
            local v7 = child:Clone();
            v7.Anchored = true;
            v7.CanCollide = false;
            v7.Parent = Model;

            if not Model.PrimaryPart then
                Model.PrimaryPart = v7;
            end;
        end;
    end;

    Model.Parent = WorldModel;
    local Camera = Instance.new("Camera");
    Camera.Parent = p4;
    p4.CurrentCamera = Camera;
    local v8 = ViewportModel.new(p4, Camera);
    v8:SetModel(Model);
    local BoundingBox, _ = Model:GetBoundingBox();
    local FitDistance = v8:GetFitDistance();
    local CFrame_Angles_ret = CFrame.Angles(-0.2617993877991494, 0.4363323129985824, 0);
    Camera.CFrame = CFrame.new(BoundingBox.Position) * CFrame_Angles_ret * CFrame.new(0, 0, FitDistance * 1.2);
end;

local function PopulateBillboard(p9, p10) -- Line: 91
    -- upvalues: LootChestData (copy), SetupWeaponViewport (copy)
    local Main = p9:FindFirstChild("Main");

    if not Main then
        return;
    end;

    local ItemName = Main:FindFirstChild("ItemName");
    local ItemImage = Main:FindFirstChild("ItemImage");
    local ItemAmount = Main:FindFirstChild("ItemAmount");
    local Chance = Main:FindFirstChild("Chance");
    local ViewportFrame = Main:FindFirstChild("ViewportFrame");

    if ItemName then
        if p10.Type == "RarityWeapon" and p10.WeaponName then
            ItemName.Text = p10.WeaponName;
        elseif p10.Type == "UpgradeStone" then
            ItemName.Text = (p10.StoneRarity or "") .. " Upgrade Stones";
        elseif p10.Type == "RarityCrystal" then
            ItemName.Text = (p10.CrystalRarity or "") .. " Crystals";
        else
            ItemName.Text = p10.DisplayName or "Reward";
        end;

        local v11 = LootChestData.RarityColors[p10.Rarity];

        if v11 and ItemName:IsA("TextLabel") then
            ItemName.TextColor3 = v11;
        end;
    end;

    if ItemAmount then
        if p10.Amount and p10.Amount > 1 then
            ItemAmount.Text = "x" .. tostring(p10.Amount);
            ItemAmount.Visible = true;
        else
            ItemAmount.Visible = false;
        end;
    end;

    if Chance then
        local v12 = LootChestData.RewardToTier[p10.Type] or "Common";

        if v12 == "Jackpot" then
            Chance.Text = "★" .. p10.Chance .. "%★";
            Chance.TextColor3 = Color3.fromRGB(255, 215, 0);
        elseif v12 == "Mid" then
            Chance.Text = p10.Chance .. "%";
            Chance.TextColor3 = Color3.fromRGB(200, 200, 255);
        else
            Chance.Text = p10.Chance .. "%";
            Chance.TextColor3 = Color3.fromRGB(180, 255, 180);
        end;
    end;

    local v13;

    if p10.Type == "RarityWeapon" then
        v13 = p10.WeaponName;
    else
        v13 = false;
    end;

    if ViewportFrame then
        if v13 then
            ViewportFrame.Visible = true;
            ViewportFrame.ImageColor3 = Color3.new(0, 0, 0);
            SetupWeaponViewport(ViewportFrame, p10.WeaponName);
        else
            ViewportFrame.Visible = false;
        end;
    end;

    if ItemImage then
        if v13 then
            ItemImage.Visible = false;
        else
            ItemImage.Visible = true;
            local v14 = LootChestData.RewardIcons[p10.Type] or "";

            if v14 ~= "" then
                ItemImage.Image = v14;
            end;

            ItemImage.ImageColor3 = Color3.new(0, 0, 0);
        end;

        if p10.Type == "UpgradeStone" then
            local v15 = LootChestData.UpgradeStoneImages[p10.Rarity];

            if v15 then
                ItemImage.Image = v15;

                return;
            end;

            ItemImage.Image = LootChestData.RewardIcons.UpgradeStone;
        end;
    end;
end;

local function TweenReveal(p16, p17) -- Line: 185
    -- upvalues: TweenService (copy)
    local Main = p16:FindFirstChild("Main");

    if not Main then
        return;
    end;

    local ItemImage = Main:FindFirstChild("ItemImage");
    local ViewportFrame = Main:FindFirstChild("ViewportFrame");
    local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

    if ViewportFrame and ViewportFrame.Visible then
        TweenService:Create(ViewportFrame, TweenInfo_new_ret, {
            ImageColor3 = Color3.new(1, 1, 1)
        }):Play();
    end;

    if ItemImage and ItemImage.Visible then
        TweenService:Create(ItemImage, TweenInfo_new_ret, {
            ImageColor3 = Color3.new(1, 1, 1)
        }):Play();
    end;
end;

function v1._HandleChestReveal(p18: table, u19: userdata, u20: userdata, p21: number, p22: string) -- Line: 210
    -- upvalues: LootChestData (copy), TweenService (copy), PopulateBillboard (copy), TweenReveal (copy)
    if not (u19 and u19.Parent) then
        return;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = LootChestData.HighlightConfig.StartColor;
    Highlight.OutlineColor = LootChestData.HighlightConfig.StartColor;
    Highlight.FillTransparency = LootChestData.HighlightConfig.FillTransparency;
    Highlight.OutlineTransparency = LootChestData.HighlightConfig.OutlineTransparency;
    Highlight.Adornee = u19;
    Highlight.Parent = u19;
    local TweenInfo_new_ret = TweenInfo.new(p21, Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
    local u23 = LootChestData.RarityColors[u20.Rarity] or LootChestData.HighlightConfig.PeakColor;
    TweenService:Create(Highlight, TweenInfo_new_ret, {
        FillTransparency = 0.3,
        OutlineTransparency = 0,
        FillColor = LootChestData.HighlightConfig.PeakColor,
        OutlineColor = u23
    }):Play();
    local Gui_Attachment = u19:FindFirstChild("Gui_Attachment", true);
    local u24 = nil;

    if Gui_Attachment then
        local v25 = Gui_Attachment:FindFirstChildOfClass("BillboardGui");

        if v25 then
            u24 = v25:FindFirstChild("Container");

            if u24 then
                u24.Visible = false;
                PopulateBillboard(u24, u20);
            end;
        end;
    end;

    local Owner_Attachment = u19:FindFirstChild("Owner_Attachment", true);
    local v26 = Owner_Attachment and Owner_Attachment:FindFirstChildOfClass("BillboardGui");

    if v26 then
        local Container = v26:FindFirstChild("Container");
        local v27 = Container and Container:FindFirstChild("OwnerName");

        if v27 then
            v27.Text = p22 or "";
        end;
    end;

    task.delay(p21, function() -- Line: 273
        -- upvalues: u19 (copy), u24 (ref), TweenReveal (ref), u20 (copy), Highlight (copy), TweenService (ref), u23 (copy)
        if not (u19 and u19.Parent) then
            return;
        end;

        if u24 then
            u24.Visible = true;
            TweenReveal(u24, u20);
        end;

        if Highlight and Highlight.Parent then
            TweenService:Create(Highlight, TweenInfo.new(0.2), {
                FillTransparency = 0,
                FillColor = Color3.new(1, 1, 1)
            }):Play();
            task.delay(0.3, function() -- Line: 289
                -- upvalues: Highlight (ref), TweenService (ref), u23 (ref)
                if Highlight and Highlight.Parent then
                    TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        FillTransparency = 0.5,
                        FillColor = u23,
                        OutlineColor = u23
                    }):Play();
                end;
            end);
        end;
    end);
    task.delay(p21 + LootChestData.REVEAL_DISPLAY_TIME - 1, function() -- Line: 303
        -- upvalues: Highlight (copy), TweenService (ref)
        if Highlight and Highlight.Parent then
            TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                FillTransparency = 1,
                OutlineTransparency = 1
            }):Play();
        end;
    end);
end;

function v1.KnitStart(u28) -- Line: 315
    -- upvalues: Knit (copy)
    Knit.GetService("ChestService").LootChestReveal:Connect(function(p29, p30, p31, p32) -- Line: 318
        -- upvalues: u28 (copy)
        u28:_HandleChestReveal(p29, p30, p31, p32);
    end);
end;

return v1;