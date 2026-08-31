--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Currency
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Currency
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:12 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("GuiService");
game:GetService("RunService");
ReplicatedStorage:WaitForChild("GameInfo");
require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local v3 = {};
local u4 = {
    Currency = {
        uiElement = "Currency",
        sound = "CurrencyAdded",
        formatter = SharedUtils.FormatCashString
    },
    Stars = {
        uiElement = "Stars",
        sound = "StarsAdded",
        formatter = SharedUtils.FormatNumber
    }
};

function v3._Init(p5) -- Line: 63
    -- upvalues: u1 (ref), u2 (ref), Registry (copy), u4 (copy), Knit (copy)
    u1 = p5;
    u2 = Registry:Get("PlayerData");
    local Currency = u1.HUD.Actions.Profile:FindFirstChild("Currency");
    local v6;

    if Currency then
        v6 = Currency:FindFirstChild("Top");
    else
        v6 = Currency;
    end;

    if Currency then
        Currency = Currency:FindFirstChild("Bottom");
    end;

    local u7 = {};

    if v6 then
        v6 = v6:FindFirstChild("Gold");
    end;

    u7.Currency = v6;

    if Currency then
        Currency = Currency:FindFirstChild("Stars");
    end;

    u7.Stars = Currency;
    local u8 = {};

    for i, _ in u4 do
        u8[i] = u2.Data[i] or 0;
    end;

    local function updateCurrency(p9: string) -- Line: 85
        -- upvalues: u4 (ref), u7 (copy), u2 (ref), u8 (copy), Knit (ref)
        local v10 = u4[p9];
        local v11 = u7[p9];

        if not v11 then
            return;
        end;

        local v12 = u2.Data[p9] or 0;
        v11.Text = v10.formatter(v12);

        if u8[p9] < v12 then
            Knit.GetController("SoundController"):Play(v10.sound);
        end;

        u8[p9] = v12;
    end;

    for i, _ in u4 do
        local v13 = u4[i];
        local v14 = u7[i];

        if v14 then
            local v15 = u2.Data[i] or 0;
            v14.Text = v13.formatter(v15);

            if u8[i] < v15 then
                Knit.GetController("SoundController"):Play(v13.sound);
            end;

            u8[i] = v15;
        end;
    end;

    u2:OnChange(function(p16, p17, p18, p19) -- Line: 105
        -- upvalues: u4 (ref), u7 (copy), u2 (ref), u8 (copy), Knit (ref)
        if u4[p17[1]] then
            local v20 = p17[1];
            local v21 = u4[v20];
            local v22 = u7[v20];

            if not v22 then
                return;
            end;

            local v23 = u2.Data[v20] or 0;
            v22.Text = v21.formatter(v23);

            if u8[v20] < v23 then
                Knit.GetController("SoundController"):Play(v21.sound);
            end;

            u8[v20] = v23;
        end;
    end);
end;

return v3;