--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rose
  Path:     game.ReplicatedStorage.DialogueData.Rose
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
    npcName = "Rose",
    animation = nil
};
local RoseSilverKey = QuestRewardData.Quests.RoseSilverKey;
u1.dialogs = {
    {
        text = "Ughhh this is so embarrassing... I locked myself out. Again.",
        responses = { "What happened?", "Need some help?", "Lol, good luck." },
        actions = { {
                goto = 2
            }, {
                goto = 3
            }, {
                hide = "Wow, rude. But fair."
            } }
    },
    {
        text = "Okay so like, I went out to grab snacks for my gaming session and the door just... locked behind me. I don\'t have a spare key and the locksmith wants like a million coins. But a <font color=\'rgb(192,192,192)\'>Silver Key</font> would totally work on this lock.",
        responses = { "I might have one!", "That\'s rough." },
        actions = { {
                goto = 3
            }, {
                hide = "Tell me about it. I\'m missing my raid right now."
            } }
    },
    {
        text = "Wait, you have a <font color=\'rgb(192,192,192)\'>Silver Key</font>?? Okay okay, if you let me use it I\'ll give you this <font color=\'rgb(180,80,255)\'>Epic Gear Pack</font> I got from a dungeon run. I was saving it but honestly, getting inside is way more important right now.",
        responses = { "Deal!", "What\'s in the pack?", "Nah, I need my key." },
        actions = { {
                questReward = "RoseSilverKey"
            }, {
                goto = 4
            }, {
                hide = "Nooo come on! Ugh, fine..."
            } }
    },
    {
        text = "It\'s a full set of <font color=\'rgb(180,80,255)\'>Epic</font> gear, head, body, and ring. Honestly it\'s pretty good stuff, I just... really need to get back to my PC. My guild is gonna be so mad at me.",
        responses = { "Alright, here\'s the key.", "I\'ll think about it." },
        actions = { {
                questReward = "RoseSilverKey"
            }, {
                hide = "Please think fast, it\'s getting cold out here..."
            } }
    },
    {
        text = "You don\'t have a <font color=\'rgb(192,192,192)\'>Silver Key</font>?? Ugh. Okay, if you find one in a dungeon, come back! I also need you to be at least <font color=\'rgb(255,220,80)\'>Level 5</font> so I know you\'re not just some random. No offense.",
        responses = { "I\'ll find one!" },
        actions = { {
                hide = "Please hurry, my pizza rolls are getting cold in there..."
            } }
    },
    {
        text = "Oh hey! Thanks again for the key, you literally saved my life. Well, saved my gaming session. Same thing honestly.",
        responses = { "Glad I could help!", "Enjoy your games." },
        actions = { {
                hide = "You\'re the best! Now if you\'ll excuse me, I have a raid to carry."
            }, {
                hide = "Oh I will. GG!"
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 123
    -- upvalues: RoseSilverKey (copy), Knit (copy), QuestRewardData (copy)
    if not RoseSilverKey then
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

    local CompletedQuests = v3.Data.CompletedQuests;

    return CompletedQuests and CompletedQuests.RoseSilverKey and 6 or (QuestRewardData.CheckConditions(RoseSilverKey, v3.Data) and 3 or 1);
end;

function u1.onResponse(p4, p5, p6) -- Line: 148
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), RoseSilverKey (copy)
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

    if not (Registry and QuestRewardData.CheckConditions(RoseSilverKey, Registry.Data)) then
        return "goto", 5;
    end;

    local CompletedQuests = Registry.Data.CompletedQuests;

    if CompletedQuests and CompletedQuests.RoseSilverKey then
        return "hide", "You already helped me out, remember?";
    end;

    return "server", "QuestReward", {
        questId = v8.questReward
    }, "YES! Thank you so much!!";
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 177
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "RoseSilverKey" then
        return;
    end;

    if p12.success then
        print("[Rose] Quest reward granted successfully!");

        return;
    end;

    warn("[Rose] Quest reward failed:", p12.reason);
end;

return u1;