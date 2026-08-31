--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GroupReward
  Path:     game.ReplicatedStorage.DialogueData.GroupReward
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local QuestRewardData = require(ReplicatedStorage.GameInfo.QuestRewardData);
local u1 = {
    npcName = "GroupReward",
    animation = nil
};
local GroupReward = QuestRewardData.Quests.GroupReward;
local LocalPlayer = Players.LocalPlayer;
u1.dialogs = {
    {
        text = "Yo! See this aura? Pretty sick right? It\'s exclusive to group members. Join the group and I\'ll hook you up with one, plus a little bonus gear.",
        responses = { "I want it!", "What do I get exactly?", "Maybe later." },
        actions = { {
                questReward = "GroupReward"
            }, {
                goto = 2
            }, {
                hide = "No rush, I\'ll be here."
            } }
    },
    {
        text = "You\'ll get the <font color=\'rgb(180,80,255)\'>Group Aura</font>, same one I\'m wearing right now. Plus a <font color=\'rgb(100,200,255)\'>Rare Gear Pack</font> to get you started. All you gotta do is be in the group. That\'s it. Free stuff for supporting us!",
        responses = { "Let\'s go!", "I\'ll think about it." },
        actions = { {
                questReward = "GroupReward"
            }, {
                hide = "Take your time, the offer isn\'t going anywhere."
            } }
    },
    {
        text = "Looks like you\'re not in the group yet! I just sent you an invite, join up and come talk to me again. It\'s free and you get some cool stuff out of it!",
        responses = { "I just joined!", "I\'ll join later." },
        actions = { {
                questReward = "GroupReward"
            }, {
                hide = "No worries, the aura will be waiting for you!"
            } }
    },
    {
        text = "Ayyy looking good with that aura! Thanks for being part of the group, it really means a lot.",
        responses = { "Thanks!", "Where\'d the Aura go?", "Looks fire." },
        actions = { {
                hide = "You already know!"
            }, {
                goto = 5
            }, {
                hide = "Straight drip, no cap."
            } }
    },
    {
        text = "Oh easy, open your <font color=\'rgb(255,220,80)\'>Inventory</font> and look for the purple <font color=\'rgb(180,80,255)\'>Cosmetics</font> button. That\'ll show all your cosmetics including the <font color=\'rgb(180,80,255)\'>Group Aura</font>. Just select it and equip it to your Aura slot. You\'ll be glowing in no time!",
        responses = { "Got it, thanks!", "I still don\'t see it." },
        actions = { {
                hide = "Now go show it off!"
            }, {
                goto = 6
            } }
    },
    {
        text = "Hmm, that happens sometimes. Try <font color=\'rgb(255,220,80)\'>rejoining the game</font>, it should load into your inventory once you\'re back in. If it\'s still not there after that, let us know!",
        responses = { "Alright, I\'ll rejoin." },
        actions = { {
                hide = "See you in a sec!"
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 127
    -- upvalues: GroupReward (copy), Knit (copy)
    if not GroupReward then
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

    return CompletedQuests and CompletedQuests.GroupReward and 4 or 1;
end;

function u1.onResponse(p4, p5, p6) -- Line: 147
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), LocalPlayer (copy)
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

    if Registry then
        local CompletedQuests = Registry.Data.CompletedQuests;

        if CompletedQuests and CompletedQuests.GroupReward then
            return "hide", "You already claimed your group reward!";
        end;
    end;

    if QuestRewardData.EnsureGroupMembership(LocalPlayer) then
        return "server", "QuestReward", {
            questId = v8.questReward
        }, "Welcome to the group! Check your Cosmetics tab in your inventory to equip the aura.";
    end;

    return "goto", 3;
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 182
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "GroupReward" then
        return;
    end;

    if p12.success then
        print("[GroupReward] Quest reward granted successfully!");

        return;
    end;

    warn("[GroupReward] Quest reward failed:", p12.reason);
end;

return u1;