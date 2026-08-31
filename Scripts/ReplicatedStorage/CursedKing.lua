--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CursedKing
  Path:     game.ReplicatedStorage.DialogueData.CursedKing
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
    npcName = "Cursed King",
    animation = nil
};
local CursedKingMastery = QuestRewardData.Quests.CursedKingMastery;
u1.dialogs = {
    {
        text = "Hmph. A vessel walks in wearing my curse like it\'s your own. Bold. Reckless, even. Speak, before I decide which.",
        responses = { "What are you?", "I\'ve mastered the Cursed King.", "Nothing. I\'ll go." },
        actions = { {
                goto = 2
            }, {
                goto = 3
            }, {
                hide = "Then stop wasting my time."
            } }
    },
    {
        text = "I am the <font color=\'rgb(255,70,60)\'>King of Curses</font>. Every technique you throw around so casually is a scrap of me you were permitted to hold. Hold enough of it, wield it like it was always yours, and even I would be forced to call you by my own name.",
        responses = { "Then let me earn it.", "I\'ve heard enough." },
        actions = { {
                goto = 3
            }, {
                hide = "As expected. Disappointing."
            } }
    },
    {
        text = "The title of <font color=\'rgb(180,80,255)\'>King of Curses</font> is not handed out, it is seized. Take the <font color=\'rgb(255,70,60)\'>Cursed King</font> to <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font>. Prove the curse answers to you. Do that, and the crown, and <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font>, are yours.",
        responses = { "I\'ve reached mastery 50.", "Not yet." },
        actions = { {
                questReward = "CursedKingMastery"
            }, {
                hide = "Then you are still just a vessel. Leave."
            } }
    },
    {
        text = "Pathetic. The curse still owns you, not the other way around. Take the <font color=\'rgb(255,70,60)\'>Cursed King</font> to <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font>. Then crawl back and show me a king.",
        responses = { "I\'ll be back." },
        actions = { {
                hide = "Try not to die on the way. It would bore me."
            } }
    },
    {
        text = "The crown already sits on your head, <font color=\'rgb(180,80,255)\'>King of Curses</font>. Two kings, one curse. Amusing. Now leave me to my throne.",
        responses = { "As you wish." },
        actions = { {
                hide = "Hmph. Not bad... for a vessel."
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 115
    -- upvalues: CursedKingMastery (copy), Knit (copy), QuestRewardData (copy)
    if not CursedKingMastery then
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

    return CompletedQuests and CompletedQuests.CursedKingMastery and 5 or (QuestRewardData.CheckConditions(CursedKingMastery, Data) and 3 or 1);
end;

function u1.onResponse(p4, p5, p6) -- Line: 142
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), CursedKingMastery (copy)
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

    if Registry and QuestRewardData.CheckConditions(CursedKingMastery, Registry.Data) then
        return "server", "QuestReward", {
            questId = v8.questReward
        }, "Rise, King of Curses. Do not embarrass the name.";
    end;

    return "goto", 4;
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 167
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "CursedKingMastery" then
        return;
    end;

    if p12.success then
        print("[CursedKing] Quest reward granted successfully!");

        return;
    end;

    warn("[CursedKing] Quest reward failed:", p12.reason);
end;

return u1;