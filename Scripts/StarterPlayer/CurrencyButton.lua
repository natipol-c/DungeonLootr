--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CurrencyButton
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.CurrencyButton
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local _ = game.Players.LocalPlayer;
local u1 = nil;

local function _init(p2: userdata) -- Line: 13
    -- upvalues: SharedUtils (copy), u1 (ref), Knit (copy)
    local Attribute = p2:GetAttribute("ProductName");
    local u3 = p2:GetAttribute("CurrencyType") or "Stars";
    local Attribute2 = p2:GetAttribute("Cost");

    if not (Attribute and Attribute2) then
        warn("CurrencyButton missing ProductName or Cost attribute");

        return;
    end;

    local v4 = p2:FindFirstChild("PriceLabel") or p2:FindFirstChild("RobuxAmount");

    if v4 then
        v4.Text = SharedUtils.FormatNumber(Attribute2);
    end;

    p2.MouseButton1Click:Connect(function() -- Line: 29
        -- upvalues: u1 (ref), u3 (copy), Attribute2 (copy), Knit (ref), Attribute (copy)
        if (u1.Data[u3] or 0) < Attribute2 then
            Knit.GetController("NotificationController"):Show("NOT_ENOUGH_STARS");

            return;
        end;

        local v5, v6 = Knit.GetService("MonetizationService"):PurchaseWithCurrency(Attribute, u3, Attribute2):await();

        if v5 and v6 then
            return;
        end;

        Knit.GetController("NotificationController"):Show("PURCHASE_FAILED");
    end);
end;

return function(p7, p8) -- Line: 49
    -- upvalues: u1 (ref), CollectionService (copy), _init (copy)
    u1 = p8;
    CollectionService:GetInstanceAddedSignal("CURRENCY_BUTTON"):Connect(function(p9) -- Line: 52
        -- upvalues: _init (ref)
        _init(p9);
    end);

    for _, v in ipairs(CollectionService:GetTagged("CURRENCY_BUTTON")) do
        _init(v);
    end;
end;