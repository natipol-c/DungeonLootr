--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Aura
  Path:     game.ReplicatedStorage.DialogueData.Aura
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
    npcName = "Aura",
    animation = nil
};
local AuraIronSights = QuestRewardData.Quests.AuraIronSights;
u1.dialogs = {
    {
        text = "Heh, took ya long enough. Not many walk the <font color=\'rgb(180,80,255)\'>Witch Gunner</font> road far enough to catch my eye. You just might.",
        responses = { "You\'ve been watching me?", "What do you want?", "k bye." },
        actions = { {
                goto = 2
            }, {
                goto = 2
            }, {
                hide = "Keep it cool, twin."
            } }
    },
    {
        text = "A gun\'s only as sharp as the hand behind it. You\'ve mastered the <font color=\'rgb(180,80,255)\'>Witch Gunner</font>, so let me put a name on that aim: <font color=\'rgb(255,210,130)\'>Iron Sights</font>. But a title like that? It costs. Steel and coin, no shortcuts.",
        responses = { "What\'s the price?", "Not yet." },
        actions = { {
                goto = 3
            }, {
                hide = "Come back when you\'ve made up your mind."
            } }
    },
    {
        text = "Here\'s the tab. <font color=\'rgb(180,80,255)\'>Witch Gunner</font> mastered to <font color=\'rgb(255,220,80)\'>Level 50</font>. Bring me <font color=\'rgb(200,225,255)\'>67 Celestial Ingots</font>. And lay down <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font>. Do all that and <font color=\'rgb(255,210,130)\'>Iron Sights</font> is yours. There\'s no refund.",
        responses = { "Do it. I\'m ready.", "I need more time." },
        actions = { {
                questReward = "AuraIronSights"
            }, {
                hide = "The forge\'ll keep. So will I."
            } }
    },
    {
        text = "Not yet, twin. Come back once you\'ve mastered the <font color=\'rgb(180,80,255)\'>Witch Gunner to Level 50</font>, and you\'re carrying <font color=\'rgb(200,225,255)\'>67 Celestial Ingots</font> and <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font>. Then we\'ll talk.",
        responses = { "I\'ll be back." },
        actions = { {
                hide = "I\'ll be waiting."
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 100
    -- upvalues: AuraIronSights (copy), Knit (copy), QuestRewardData (copy)
    if not AuraIronSights then
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

    return (Data.CompletedQuests or {}).AuraIronSights == true and 1 or (QuestRewardData.CheckConditions(AuraIronSights, Data) and 2 or 1);
end;

function u1.onResponse(p4, p5, p6) -- Line: 127
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), AuraIronSights (copy)
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

    if not (Registry and QuestRewardData.CheckConditions(AuraIronSights, Registry.Data)) then
        return "goto", 4;
    end;

    if (Registry.Data.CompletedQuests or {}).AuraIronSights then
        return "hide", "You already earned those sights, twin.";
    end;

    return "server", "QuestReward", {
        questId = v8.questReward
    }, "Steady hands. Dead-eye. That\'s the mark.";
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 160
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "AuraIronSights" then
        return;
    end;

    if p12.success then
        print("[Aura] Iron Sights granted successfully!");

        return;
    end;

    warn("[Aura] Quest reward failed:", p12.reason);
end;

return u1;