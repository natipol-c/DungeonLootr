--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GreatMage
  Path:     game.ReplicatedStorage.DialogueData.GreatMage
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
    npcName = "Great Mage",
    animation = nil
};
local GreatMageDemonbane = QuestRewardData.Quests.GreatMageDemonbane;
u1.dialogs = {
    {
        text = "Oh. A visitor. It\'s been a while. Or maybe it hasn\'t. I lose track. What do you want?",
        responses = { "How do I get the Demonbane class?", "I\'ve mastered the Demonbane.", "Nothing." },
        actions = { {
                goto = 2
            }, {
                goto = 3
            }, {
                hide = "Fine. Goodbye, then."
            } }
    },
    {
        text = "The <font color=\'rgb(215,225,255)\'>Great Mage Staff</font>. It\'s the <font color=\'rgb(255,220,80)\'>Tier 50</font> reward on the free track of the <font color=\'rgb(180,80,255)\'>Battlepass</font>. Claim it, and you become the <font color=\'rgb(215,225,255)\'>Demonbane</font>. Simple.",
        responses = { "I\'ve already mastered it.", "Thanks." },
        actions = { {
                goto = 3
            }, {
                hide = "Mm. Off you go."
            } }
    },
    {
        text = "Take the <font color=\'rgb(215,225,255)\'>Demonbane</font> to <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font> and bring me <font color=\'rgb(255,220,80)\'>1,000,000 coins</font>. In return, I\'ll give you the name the demons once gave me. <font color=\'rgb(180,80,255)\'>The Slayer</font>.",
        responses = { "Here\'s the payment.", "Not yet." },
        actions = { {
                questReward = "GreatMageDemonbane"
            }, {
                hide = "Come back when you\'re ready."
            } }
    },
    {
        text = "Not yet. Reach <font color=\'rgb(255,220,80)\'>Demonbane Class Mastery Level 50</font>, and have <font color=\'rgb(255,220,80)\'>1,000,000 coins</font> on hand. Then the name is yours.",
        responses = { "I\'ll be back." },
        actions = { {
                hide = "I\'ll still be here. I usually am."
            } }
    },
    {
        text = "You already carry the name, <font color=\'rgb(180,80,255)\'>Slayer</font>. Wear it better than I did. Now let an old mage rest.",
        responses = { "Farewell." },
        actions = { {
                hide = "Mm. Take care."
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 114
    -- upvalues: GreatMageDemonbane (copy), Knit (copy), QuestRewardData (copy)
    if not GreatMageDemonbane then
        return 1;
    end;

    local Registry = Knit.Registry;

    if not Registry then
        return 1;
    end;

    local v3 = Registry:Get("PlayerData");

    if not (v3 and v3.Data) then
        return 1;
    end;

    local Data = v3.Data;
    local CompletedQuests = Data.CompletedQuests;

    return CompletedQuests and CompletedQuests.GreatMageDemonbane and 5 or (QuestRewardData.CheckConditions(GreatMageDemonbane, Data) and 3 or 1);
end;

function u1.onResponse(p4, p5, p6) -- Line: 141
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), GreatMageDemonbane (copy)
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

    if Registry and QuestRewardData.CheckConditions(GreatMageDemonbane, Registry.Data) then
        return "server", "QuestReward", {
            questId = v8.questReward
        }, "There. You\'re the Slayer now. Try not to lose it.";
    end;

    return "goto", 4;
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 166
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "GreatMageDemonbane" then
        return;
    end;

    if p12.success then
        print("[GreatMage] Quest reward granted successfully!");

        return;
    end;

    warn("[GreatMage] Quest reward failed:", p12.reason);
end;

return u1;