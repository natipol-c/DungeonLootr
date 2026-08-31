--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Jetstream
  Path:     game.ReplicatedStorage.DialogueData.Jetstream
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
    npcName = "Jetstream",
    animation = nil
};
local JetstreamCyberneticKatana = QuestRewardData.Quests.JetstreamCyberneticKatana;
local JetstreamMinuano = QuestRewardData.Quests.JetstreamMinuano;
u1.dialogs = {
    {
        text = "Yo. You\'ve been turning heads lately. Word gets around, especially when someone walks the <font color=\'rgb(180,80,255)\'>Azure Devil</font> path and doesn\'t break.",
        responses = { "You watching me?", "What do you want?", "Just passing through." },
        actions = { {
                goto = 2
            }, {
                goto = 2
            }, {
                hide = "Cool, catch you around."
            } }
    },
    {
        text = "Let\'s skip the small talk. I\'m looking to hand off my <font color=\'rgb(255,80,80)\'>Cybernetic Katana</font>. High-frequency edge, nanomachine-forged, cuts through just about anything. Only person worth giving it to is someone who\'s already walked the devil\'s road to the end.",
        responses = { "What\'s the catch?", "Not interested." },
        actions = { {
                goto = 3
            }, {
                hide = "Fair. Not everyone\'s cut out for it."
            } }
    },
    {
        text = "Here\'s the bar. <font color=\'rgb(180,80,255)\'>Azure Devil</font> mastered to <font color=\'rgb(255,220,80)\'>Level 50</font>. Three <font color=\'rgb(255,80,80)\'>Devil Hearts</font> torn from the Awakened Devil up on Frostspire. One <font color=\'rgb(255,150,50)\'>Exotic Shattered Armor</font>, so I know you\'ve bled for it. And <font color=\'rgb(255,220,80)\'>200,000 Coins</font>, call it a handling fee. Bring all that and the blade\'s yours.",
        responses = { "Deal. Let\'s dance.", "I\'ll come back stronger." },
        actions = { {
                questReward = "JetstreamCyberneticKatana"
            }, {
                hide = "Standing by."
            } }
    },
    {
        text = "Not yet. Come back with your <font color=\'rgb(180,80,255)\'>Azure Devil</font> at <font color=\'rgb(255,220,80)\'>mastery 50</font>, <font color=\'rgb(255,80,80)\'>3 Devil Hearts</font>, <font color=\'rgb(255,150,50)\'>1 Exotic Shattered Armor</font>, and <font color=\'rgb(255,220,80)\'>200,000 Coins</font>. Then we\'ll talk about the blade.",
        responses = { "I\'ll be back." },
        actions = { {
                hide = "Standing by."
            } }
    },
    {
        text = "So you took my blade all the way. <font color=\'rgb(255,80,80)\'>Jetstream</font> mastered to <font color=\'rgb(255,220,80)\'>Level 50</font>. There\'s a name for someone who cuts like a cold wind out of nowhere: <font color=\'rgb(235,50,50)\'>The Minuano</font>. Lay down <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font> and it\'s yours to carry.",
        responses = { "Make it official.", "Later." },
        actions = { {
                questReward = "JetstreamMinuano"
            }, {
                hide = "The wind\'ll keep. So will I."
            } }
    },
    {
        text = "Not there yet. Take <font color=\'rgb(255,80,80)\'>Jetstream</font> to <font color=\'rgb(255,220,80)\'>mastery 50</font> and have <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font> on you. Then I\'ll call you <font color=\'rgb(235,50,50)\'>The Minuano</font>.",
        responses = { "I\'ll get there." },
        actions = { {
                hide = "Keep that edge sharp."
            } }
    }
};
local u2 = {
    JetstreamCyberneticKatana = 4,
    JetstreamMinuano = 6
};
local u3 = {
    JetstreamCyberneticKatana = "Alright. Let\'s see what you\'ve got.",
    JetstreamMinuano = "The Minuano. Wear it well."
};

function u1.getStartDialog(p4) -- Line: 144
    -- upvalues: Knit (copy), JetstreamMinuano (copy), QuestRewardData (copy), JetstreamCyberneticKatana (copy)
    local Registry = Knit.Registry;

    if not Registry then
        return 1;
    end;

    local v5 = Registry:Get("PlayerData");

    if not (v5 and v5.Data) then
        return 1;
    end;

    local Data = v5.Data;

    if JetstreamMinuano and ((Data.CompletedQuests or {}).JetstreamMinuano ~= true and QuestRewardData.CheckConditions(JetstreamMinuano, Data)) then
        return 5;
    end;

    local v6 = false;
    local ClassItems = Data.ClassItems;

    if ClassItems then
        for _, v in ClassItems do
            if v == "Cybernetic Katana" then
                v6 = true;
                break;
            end;
        end;
    end;

    return (v6 or not (JetstreamCyberneticKatana and QuestRewardData.CheckConditions(JetstreamCyberneticKatana, Data))) and 1 or 2;
end;

function u1.onResponse(p7, p8, p9) -- Line: 183
    -- upvalues: u1 (copy), QuestRewardData (copy), Knit (copy), u2 (copy), u3 (copy)
    local v10 = u1.dialogs[p9];

    if not (v10 and v10.actions) then
        return "hide";
    end;

    local v11 = v10.actions[p8];

    if not v11 then
        return "hide";
    end;

    if v11.goto then
        return "goto", v11.goto, v11.quip;
    end;

    if not v11.questReward then
        if v11.hide then
            return "hide", v11.hide;
        end;

        return "hide";
    end;

    local questReward = v11.questReward;
    local v12 = QuestRewardData.Quests[questReward];
    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if not (Registry and (v12 and QuestRewardData.CheckConditions(v12, Registry.Data))) then
        return "goto", u2[questReward] or 4;
    end;

    if (Registry.Data.CompletedQuests or {})[questReward] then
        return "hide", "Already handled. Don\'t wear it out.";
    end;

    return "server", "QuestReward", {
        questId = questReward
    }, u3[questReward] or "...";
end;

function u1.onServerResult(p13, p14, p15, p16) -- Line: 219
    if p15 ~= "QuestReward" then
        return;
    end;

    if not p16 then
        return;
    end;

    if p16.success then
        print("[Jetstream] Quest reward granted:", p16.questId);

        return;
    end;

    warn("[Jetstream] Quest reward failed:", p16.reason);
end;

return u1;