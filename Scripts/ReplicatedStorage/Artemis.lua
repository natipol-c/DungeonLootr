--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Artemis
  Path:     game.ReplicatedStorage.DialogueData.Artemis
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
    npcName = "Artemis",
    animation = nil
};
local ArtemisArrow = QuestRewardData.Quests.ArtemisArrow;
u1.dialogs = {
    {
        text = "You walk with purpose, hunter. Not many find their way here.",
        responses = { "Who are you?", "I want to master the bow.", "Just passing through." },
        actions = { {
                goto = 2
            }, {
                goto = 2
            }, {
                hide = "The wild remembers those who tread lightly."
            } }
    },
    {
        text = "I am Artemis. I watch over those who wield my power. Master it fully, and I will mark you as one of my own.",
        responses = { "How do I prove myself?", "I\'ll come back stronger." },
        actions = { {
                goto = 3
            }, {
                hide = "The hunt waits for no one."
            } }
    },
    {
        text = "Take the <font color=\'rgb(255,215,80)\'>Artemis</font> class to <font color=\'rgb(255,220,80)\'>Level 50</font>. Reach the peak of its mastery, and my Arrow and the title of <font color=\'rgb(255,215,80)\'>God Hunter</font> are yours.",
        responses = { "I\'ve done it. Grant me the title.", "What does the title give me?", "Not yet." },
        actions = { {
                questReward = "ArtemisArrow"
            }, {
                goto = 4
            }, {
                hide = "Return when your mastery is complete."
            } }
    },
    {
        text = "The <font color=\'rgb(255,215,80)\'>God Hunter</font> title marks a true master of the hunt. Claim it now, along with my Arrow, and wear both with pride.",
        responses = { "I\'m ready.", "I need more time." },
        actions = { {
                questReward = "ArtemisArrow"
            }, {
                hide = "The wind will carry my voice when you are ready."
            } }
    },
    {
        text = "You are not there yet. Master the <font color=\'rgb(255,215,80)\'>Artemis</font> class to <font color=\'rgb(255,220,80)\'>Level 50</font>, then return to me.",
        responses = { "I understand." },
        actions = { {
                hide = "The forest is patient. I am not."
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 110
    -- upvalues: ArtemisArrow (copy), Knit (copy), QuestRewardData (copy)
    if not ArtemisArrow then
        return 1;
    end;

    local Registry = Knit.Registry;

    if not Registry then
        return 1;
    end;

    local v3 = Registry:Get("PlayerData");

    if not v3 then
        return 1;
    end;

    local UnlockedTitles = v3.Data.UnlockedTitles;

    return UnlockedTitles and table.find(UnlockedTitles, "God Hunter") and 1 or (QuestRewardData.CheckConditions(ArtemisArrow, v3.Data) and 3 or 1);
end;

function u1.onResponse(p4, p5, p6) -- Line: 135
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), ArtemisArrow (copy)
    local v7 = u1.dialogs[p6];

    if not (v7 and v7.actions) then
        return "hide";
    end;

    local v8 = v7.actions[p5];

    if not v8 then
        return "hide";
    end;

    if v8.goto then
        return "goto", v8.goto, v8.quip;
    end;

    if not v8.questReward then
        if v8.hide then
            return "hide", v8.hide;
        end;

        return "hide";
    end;

    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if Registry and QuestRewardData.CheckConditions(ArtemisArrow, Registry.Data) then
        return "server", "QuestReward", {
            questId = v8.questReward
        }, "The hunt begins anew...";
    end;

    return "goto", 5;
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 161
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "ArtemisArrow" then
        return;
    end;

    if p12.success then
        print("[Artemis] Quest reward granted successfully!");

        return;
    end;

    warn("[Artemis] Quest reward failed:", p12.reason);
end;

return u1;