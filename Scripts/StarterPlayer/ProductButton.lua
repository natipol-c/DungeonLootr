--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ProductButton
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.ProductButton
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local MonetizationList = require(GameInfo:WaitForChild("MonetizationList"));
local LocalPlayer = game.Players.LocalPlayer;
local u1 = nil;

function _init(u2: userdata)
    -- upvalues: MonetizationList (copy), u1 (ref), LocalPlayer (copy), MarketplaceService (copy), Knit (copy)
    local Attribute = u2:GetAttribute("ProductName");

    if not Attribute then
        return;
    end;

    local u3 = MonetizationList[Attribute];

    if not u3 then
        warn((`Missing product info for {Attribute}`));

        return;
    end;

    local u4 = nil;

    local function getOwnedLabel() -- Line: 35
        -- upvalues: u2 (copy)
        local Parent = u2.Parent;

        if Parent then
            Parent = Parent:FindFirstChild("Owned");
        end;

        if Parent and Parent:IsA("ImageLabel") then
            return Parent;
        end;

        return nil;
    end;

    local function setOwnedState(p5: boolean) -- Line: 45
        -- upvalues: u2 (copy)
        local Parent = u2.Parent;

        if Parent then
            Parent = Parent:FindFirstChild("Owned");
        end;

        if not (Parent and Parent:IsA("ImageLabel")) then
            Parent = nil;
        end;

        if not Parent then
            return;
        end;

        Parent.Visible = p5;
        u2.Visible = not p5;
    end;

    local function updateOwnershipDisplay() -- Line: 54
        -- upvalues: u1 (ref), u2 (copy), u4 (ref), u3 (copy), LocalPlayer (ref), MarketplaceService (ref)
        if not (u1 and u1.Data) then
            return;
        end;

        if u2:GetAttribute("SuppressPurchasePrompt") then
            return;
        end;

        if u2:GetAttribute("GiftingMode") then
            local v6 = u4 and u2:FindFirstChild("RobuxAmount");

            if v6 then
                v6.Text = u4;
            end;

            if u2:FindFirstChild("ImageLabel") then
                u2.ImageLabel.Visible = true;
            end;

            local Parent = u2.Parent;
            local v7 = Parent and Parent:FindFirstChild("Owned");

            if not (v7 and v7:IsA("ImageLabel")) then
                v7 = nil;
            end;

            if not v7 then
                return;
            end;

            v7.Visible = false;
            u2.Visible = true;

            return;
        end;

        local v8 = u3.DoesPlayerOwn and u3.DoesPlayerOwn(LocalPlayer, u1.Data);

        if v8 then
            if u2:FindFirstChild("RobuxAmount") then
                u2.RobuxAmount.Text = "Owned";
            end;

            if u2:FindFirstChild("ImageLabel") then
                u2.ImageLabel.Visible = false;
            end;

            local Parent = u2.Parent;
            local v9 = Parent and Parent:FindFirstChild("Owned");

            if not (v9 and v9:IsA("ImageLabel")) then
                v9 = nil;
            end;

            if not v9 then
                return;
            end;

            v9.Visible = true;
            u2.Visible = false;

            return;
        end;

        local RobuxAmount = u2:FindFirstChild("RobuxAmount");
        local u10 = u3.GetId and u3.GetId() or u3.Id;
        local u11 = u3.Type == "Gamepass" and Enum.InfoType.GamePass or Enum.InfoType.Product;

        if u3.GamepassId then
            u10 = u3.GamepassId;
            u11 = Enum.InfoType.GamePass;
        end;

        if u10 and (typeof(u10) == "table" and u10[2]) then
            if RobuxAmount then
                RobuxAmount.Text = u10[2];
            end;

            u4 = u10[2];
        elseif typeof(u10) == "number" then
            local success, result = pcall(function() -- Line: 107
                -- upvalues: MarketplaceService (ref), u10 (ref), u11 (ref)
                return MarketplaceService:GetProductInfo(u10, u11);
            end);

            if success and (result and RobuxAmount) then
                RobuxAmount.Text = result.PriceInRobux;
                u4 = result.PriceInRobux;
            end;
        end;

        if u2:FindFirstChild("ImageLabel") then
            u2.ImageLabel.Visible = true;
        end;

        local Parent = u2.Parent;

        if Parent then
            Parent = Parent:FindFirstChild("Owned");
        end;

        if not (Parent and Parent:IsA("ImageLabel")) then
            Parent = nil;
        end;

        if Parent then
            Parent.Visible = false;
            u2.Visible = true;
        end;
    end;

    task.defer(updateOwnershipDisplay);
    u1:OnChange(function(p12, p13, p14, p15) -- Line: 127
        -- upvalues: updateOwnershipDisplay (copy)
        if p13[1] == "PermanentItems" or (p13[1] == "OwnedItems" or p13[1] == "VIP") then
            updateOwnershipDisplay();
        end;
    end);
    u2:GetAttributeChangedSignal("GiftingMode"):Connect(function() -- Line: 135
        -- upvalues: updateOwnershipDisplay (copy)
        updateOwnershipDisplay();
    end);
    u2.MouseButton1Click:Connect(function() -- Line: 140
        -- upvalues: u2 (copy), u3 (copy), LocalPlayer (ref), u1 (ref), Knit (ref)
        if u2:GetAttribute("SuppressPurchasePrompt") then
            return;
        end;

        local os_time_ret = os.time();

        if u3.UnlockTime and os_time_ret < u3.UnlockTime then
            return;
        end;

        if u3.EndTime and u3.EndTime <= os_time_ret then
            return;
        end;

        local Attribute2 = u2:GetAttribute("GiftingMode");

        if not Attribute2 and (u3.DoesPlayerOwn and u3.DoesPlayerOwn(LocalPlayer, u1.Data)) then
            return;
        end;

        if Attribute2 then
            Knit.GetController("MarketplaceController"):PromptProduct(u3.Id);

            return;
        end;

        local v16 = u3.GetId and u3.GetId()[1] or u3.Id;

        if u3.GamepassId then
            Knit.GetController("MarketplaceController"):PromptGamepass(u3.GamepassId);

            return;
        end;

        if u3.Type == "Gamepass" then
            Knit.GetController("MarketplaceController"):PromptGamepass(v16);

            return;
        end;

        Knit.GetController("MarketplaceController"):PromptProduct(v16);
    end);
end;

return function(p17, p18) -- Line: 188
    -- upvalues: u1 (ref), CollectionService (copy)
    u1 = p18;
    CollectionService:GetInstanceAddedSignal("PRODUCT_BUTTON"):Connect(function(p19) -- Line: 190
        _init(p19);
    end);

    for _, v in ipairs(CollectionService:GetTagged("PRODUCT_BUTTON")) do
        _init(v);
    end;
end;