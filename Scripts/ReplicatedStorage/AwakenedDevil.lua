--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AwakenedDevil
  Path:     game.ReplicatedStorage.DialogueData.AwakenedDevil
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local QuestRewardData = require(ReplicatedStorage.GameInfo.QuestRewardData);
local u1 = {
    npcName = "Awakened Devil",
    animation = nil
};
local AwakenedDevilJudgementsEdge = QuestRewardData.Quests.AwakenedDevilJudgementsEdge;
u1.dialogs = {
    {
        text = "...",
        responses = { "Who are you?", "What do you want?", "I\'ll leave you alone." },
        actions = { {
                goto = 2
            }, {
                goto = 2
            }, {
                hide = "..."
            } }
    },
    {
        text = "You\'ve walked the <font color=\'rgb(100,150,255)\'>Azure Devil</font> path. Broken yourself against it. Rebuilt. Twice. Few ever make it this far. Fewer still deserve what comes next.",
        responses = { "What are you offering?", "I\'m not interested." },
        actions = { {
                goto = 3
            }, {
                hide = "Then leave."
            } }
    },
    {
        text = "<font color=\'rgb(100,150,255)\'>Judgement\'s Edge</font>. The <font color=\'rgb(100,150,255)\'>True Yamato</font>. A blade that severs causality itself. It has waited for a hand capable of holding it, and the hand has waited for the blade. Take it.",
        responses = { "I accept.", "Not yet." },
        actions = { {
                questReward = "AwakenedDevilJudgementsEdge"
            }, {
                hide = "Return when you are certain."
            } }
    },
    {
        text = "You are not ready. Reach <font color=\'rgb(255,220,80)\'>Level 90</font>. Prestige your <font color=\'rgb(100,150,255)\'>Azure Devil</font> <font color=\'rgb(255,220,80)\'>twice</font>. Then, and only then, the blade will answer to you.",
        responses = { "I\'ll return." },
        actions = { {
                hide = "I will be waiting."
            } }
    },
    {
        text = "The blade is yours already. Wield it well.",
        responses = { "Farewell." },
        actions = { {
                hide = "..."
            } }
    }
};

local function PlayerOwnsRewardItem(p2) -- Line: 117
    local ClassItems = p2.ClassItems;

    if not ClassItems then
        return false;
    end;

    for _, v in ClassItems do
        if v == "Judgements Edge" then
            return true;
        end;
    end;

    return false;
end;

function u1.getStartDialog(p3) -- Line: 130
    -- upvalues: AwakenedDevilJudgementsEdge (copy), Knit (copy), QuestRewardData (copy)
    if not AwakenedDevilJudgementsEdge then
        return 1;
    end;

    local Registry = Knit.Registry;

    if not Registry then
        return 1;
    end;

    local v4 = Registry:Get("PlayerData");

    if not v4 then
        return 1;
    end;

    local Data = v4.Data;
    local ClassItems = Data.ClassItems;
    local v5;

    if ClassItems then
        v5 = false;

        for _, v in ClassItems do
            if v == "Judgements Edge" then
                v5 = true;
                break;
            end;
        end;
    else
        v5 = false;
    end;

    return v5 and 5 or (QuestRewardData.CheckConditions(AwakenedDevilJudgementsEdge, Data) and 2 or 1);
end;

function u1.onResponse(p6, p7, p8) -- Line: 158
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), AwakenedDevilJudgementsEdge (copy)
    local v9 = u1.dialogs[p8];

    if not (v9 and v9.actions) then
        return "hide";
    end;

    local v10 = v9.actions[p7];

    if not v10 then
        return "hide";
    end;

    if v10.goto then
        return "goto", v10.goto, v10.quip;
    end;

    if not v10.questReward then
        if v10.hide then
            return "hide", v10.hide;
        end;

        return "hide";
    end;

    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if Registry and QuestRewardData.CheckConditions(AwakenedDevilJudgementsEdge, Registry.Data) then
        return "server", "QuestReward", {
            questId = v10.questReward
        }, "Rise, Awakened one.";
    end;

    return "goto", 4;
end;

function u1.onServerResult(p11, p12, p13, p14) -- Line: 190
    if p13 ~= "QuestReward" then
        return;
    end;

    if not p14 or p14.questId ~= "AwakenedDevilJudgementsEdge" then
        return;
    end;

    if p14.success then
        print("[AwakenedDevil] Judgement\'s Edge granted.");

        return;
    end;

    warn("[AwakenedDevil] Quest reward failed:", p14.reason);
end;

return u1;