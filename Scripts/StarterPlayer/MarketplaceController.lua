--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     MarketplaceController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.MarketplaceController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local MarketplaceService = game:GetService("MarketplaceService");
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Knit = require(game.ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "MarketplaceController"
});
LocalPlayer:SetAttribute("ProductId", 0);

function v1.KnitStart(p2) -- Line: 20
    -- upvalues: ReplicatedStorage (copy), Knit (copy), LocalPlayer (copy), TweenService (copy), MarketplaceService (copy)
    local u3 = ReplicatedStorage.Assets.UI["Purchase Pending"]:Clone();
    u3.Parent = Knit.PlayerGui;
    u3.Enabled = false;

    local function hide() -- Line: 25
        -- upvalues: u3 (copy), LocalPlayer (ref)
        u3.Enabled = false;
        LocalPlayer:SetAttribute("ProductId", 0);
    end;

    local function show() -- Line: 30
        -- upvalues: u3 (copy), TweenService (ref), ReplicatedStorage (ref)
        u3.Frame.BackgroundTransparency = 1;
        TweenService:Create(u3.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundTransparency = ReplicatedStorage.Assets.UI["Purchase Pending"].Frame.BackgroundTransparency
        }):Play();
        u3.Enabled = true;
    end;

    MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(p4, p5, p6) -- Line: 40
        -- upvalues: LocalPlayer (ref), u3 (copy)
        print("PromptGamePassPurchaseFinished", p4, p5, p6);

        if p4 == LocalPlayer then
            task.wait();
            u3.Enabled = false;
            LocalPlayer:SetAttribute("ProductId", 0);
        end;
    end);
    MarketplaceService.PromptProductPurchaseFinished:Connect(function(p7, p8, p9) -- Line: 48
        -- upvalues: LocalPlayer (ref), u3 (copy)
        if LocalPlayer.UserId == p7 then
            task.wait();
            u3.Enabled = false;
            LocalPlayer:SetAttribute("ProductId", 0);
        end;
    end);
    LocalPlayer:GetAttributeChangedSignal("ProductId"):Connect(function() -- Line: 55
        -- upvalues: LocalPlayer (ref), show (copy)
        if LocalPlayer:GetAttribute("ProductId") ~= 0 then
            show();
        end;
    end);
end;

function v1.PromptProduct(p10, p11) -- Line: 63
    -- upvalues: LocalPlayer (copy), MarketplaceService (copy)
    LocalPlayer:SetAttribute("ProductId", p11);
    MarketplaceService:PromptProductPurchase(LocalPlayer, p11);
end;

function v1.PromptGamepass(p12, p13) -- Line: 68
    -- upvalues: LocalPlayer (copy), MarketplaceService (copy)
    LocalPlayer:SetAttribute("ProductId", p13);
    MarketplaceService:PromptGamePassPurchase(LocalPlayer, p13);
end;

return v1;