--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Kage
  Path:     game.ReplicatedStorage.DialogueData.Kage
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
    npcName = "Kage",
    animation = nil
};
local KageMask = QuestRewardData.Quests.KageMask;
u1.dialogs = {
    {
        text = "... You see me. Most don\'t. The <font color=\'rgb(120,190,255)\'>Kage</font> blade has left its mark on you.",
        responses = { "Who are you?", "I\'ve mastered the Kage.", "Nevermind." },
        actions = { {
                goto = 2
            }, {
                goto = 3
            }, {
                hide = "... Smart."
            } }
    },
    {
        text = "Names are for the living. I shed mine long ago, along with my face. All that remains is the blade... and this mask. Carry the <font color=\'rgb(120,190,255)\'>Kage</font> far enough and it will call you the same thing it once called me.",
        responses = { "And what is that?", "I\'ll leave you be." },
        actions = { {
                goto = 3
            }, {
                hide = "... Wise. The shadows aren\'t kind to the unprepared."
            } }
    },
    {
        text = "The <font color=\'rgb(180,80,255)\'>Black Falcon</font>. It is not a rank you are given, it is one the shadows recognize. Take the <font color=\'rgb(120,190,255)\'>Kage</font> to <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font>, and I will pass you my mask, the name, and a hunter\'s fortune, <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font>.",
        responses = { "I\'ve reached mastery 50.", "Not yet." },
        actions = { {
                questReward = "KageMask"
            }, {
                hide = "... Then you aren\'t ready."
            } }
    },
    {
        text = "My mask holds a lifetime of kills. To wear it is to become <font color=\'rgb(180,80,255)\'>Black Falcon</font>, and no one will ever see you coming.",
        responses = { "Give it to me.", "I need more time." },
        actions = { {
                questReward = "KageMask"
            }, {
                hide = "... The shadows are patient. I am not."
            } }
    },
    {
        text = "You\'re not there yet. Take the <font color=\'rgb(120,190,255)\'>Kage</font> to <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font>. Live inside the blade until it becomes your own. Then we talk.",
        responses = { "I\'ll be back." },
        actions = { {
                hide = "... We\'ll see."
            } }
    },
    {
        text = "You wear the mask now, <font color=\'rgb(180,80,255)\'>Black Falcon</font>. There is nothing left for me to give you. Only the shadows remain.",
        responses = { "Farewell." },
        actions = { {
                hide = "... Strike true."
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 127
    -- upvalues: KageMask (copy), Knit (copy), QuestRewardData (copy)
    if not KageMask then
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

    return CompletedQuests and CompletedQuests.KageMask and 6 or (QuestRewardData.CheckConditions(KageMask, Data) and 3 or 1);
end;

function u1.onResponse(p4, p5, p6) -- Line: 154
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), KageMask (copy)
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

    if Registry and QuestRewardData.CheckConditions(KageMask, Registry.Data) then
        return "server", "QuestReward", {
            questId = v8.questReward
        }, "... Rise, Black Falcon.";
    end;

    return "goto", 5;
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 179
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "KageMask" then
        return;
    end;

    if p12.success then
        print("[Kage] Quest reward granted successfully!");

        return;
    end;

    warn("[Kage] Quest reward failed:", p12.reason);
end;

return u1;