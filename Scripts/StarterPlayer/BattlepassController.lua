--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BattlepassController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.BattlepassController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local BattlepassData = require(ReplicatedStorage.GameInfo.BattlepassData);
local v1 = Knit.CreateController({
    Name = "BattlepassController"
});
v1._seasonInfo = nil;
v1._onTierUp = nil;
v1._onQuestCompleted = nil;
v1._onQuestProgress = nil;

function v1.GetSeasonInfo(p2) -- Line: 31
    return p2._seasonInfo;
end;

function v1.GetBattlepassData(p3) -- Line: 36
    -- upvalues: BattlepassData (copy)
    return BattlepassData;
end;

function v1.ClaimReward(p4: table, p5: number, p6: string) -- Line: 41
    -- upvalues: Knit (copy)
    return Knit.GetService("BattlepassService"):ClaimReward(p5, p6):await();
end;

function v1.ClaimQuest(p7: table, p8: number) -- Line: 47
    -- upvalues: Knit (copy)
    return Knit.GetService("BattlepassService"):ClaimQuest(p8):await();
end;

function v1.PromptPremiumPurchase(p9) -- Line: 53
    -- upvalues: ReplicatedStorage (copy), Knit (copy)
    local BattlepassPremium = require(ReplicatedStorage.GameInfo.MonetizationList).BattlepassPremium;

    if BattlepassPremium and (BattlepassPremium.Id and BattlepassPremium.Id > 0) then
        Knit.GetController("MarketplaceController"):PromptProduct(BattlepassPremium.Id);

        return;
    end;

    warn("[BattlepassController] BattlepassPremium product ID not set");
end;

function v1.PromptTierSkip(p10: table, p11: number) -- Line: 65
    -- upvalues: ReplicatedStorage (copy), Knit (copy)
    local MonetizationList = require(ReplicatedStorage.GameInfo.MonetizationList);
    local v12 = "BattlepassSkip" .. tostring(p11);
    local v13 = MonetizationList[v12];

    if v13 and (v13.Id and v13.Id > 0) then
        Knit.GetController("MarketplaceController"):PromptProduct(v13.Id);

        return;
    end;

    warn((`[BattlepassController] {v12} product ID not set`));
end;

function v1.OnTierUp(p14: table, p15: function) -- Line: 77
    p14._onTierUp = p15;
end;

function v1.OnQuestCompleted(p16: table, p17: function) -- Line: 81
    p16._onQuestCompleted = p17;
end;

function v1.OnQuestProgress(p18: table, p19: function) -- Line: 85
    p18._onQuestProgress = p19;
end;

function v1.KnitInit(p20) -- Line: 91
end;

function v1.KnitStart(u21) -- Line: 95
    -- upvalues: Knit (copy)
    local Service = Knit.GetService("BattlepassService");
    local v22, v23 = Service:GetSeasonInfo():await();

    if v22 and v23 then
        u21._seasonInfo = v23;
    end;

    Service.TierUp:Connect(function(p24) -- Line: 105
        -- upvalues: u21 (copy)
        if u21._onTierUp then
            u21._onTierUp(p24);
        end;
    end);
    Service.QuestCompleted:Connect(function(p25) -- Line: 111
        -- upvalues: u21 (copy)
        if u21._onQuestCompleted then
            u21._onQuestCompleted(p25);
        end;
    end);
    Service.QuestProgress:Connect(function(p26, p27) -- Line: 117
        -- upvalues: u21 (copy)
        if u21._onQuestProgress then
            u21._onQuestProgress(p26, p27);
        end;
    end);
end;

return v1;