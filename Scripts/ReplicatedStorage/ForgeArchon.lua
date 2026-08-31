--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ForgeArchon
  Path:     game.ReplicatedStorage.DialogueData.ForgeArchon
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
    npcName = "Forge Archon",
    animation = nil
};
local ForgeArchonMastery = QuestRewardData.Quests.ForgeArchonMastery;
u1.dialogs = {
    {
        text = "I am the <font color=\'rgb(255,80,100)\'>Forge Archon</font>. Every blade I have ever seen, I can make again, without end. I sense the same forge burning in you.",
        responses = { "How does that work?", "I\'ve mastered the Forge Archon.", "Not interested." },
        actions = { {
                goto = 2
            }, {
                goto = 3
            }, {
                hide = "Suit yourself."
            } }
    },
    {
        text = "A swordsman keeps one blade. I keep <font color=\'rgb(255,220,80)\'>infinite</font>. Not stolen, not summoned, <font color=\'rgb(255,200,90)\'>projected</font>, from a world that exists only inside me. Forge enough of them and that world learns your name.",
        responses = { "What name?", "I\'ll leave you to it." },
        actions = { {
                goto = 3
            }, {
                hide = "The forge will be here."
            } }
    },
    {
        text = "<font color=\'rgb(180,80,255)\'>Infinite Blade Works</font>, the shape of a hero\'s inner world. Take the <font color=\'rgb(255,200,90)\'>Forge Archon</font> to <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font> and I will open that world to you, and fill your coffers with <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font> besides.",
        responses = { "I\'ve reached mastery 50.", "Not yet." },
        actions = { {
                questReward = "ForgeArchonMastery"
            }, {
                hide = "Come back when the forge burns hotter."
            } }
    },
    {
        text = "The forge isn\'t hot enough yet. Take the <font color=\'rgb(255,200,90)\'>Forge Archon</font> to <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font>. Trace every blade until they are truly yours. Then return.",
        responses = { "I\'ll be back." },
        actions = { {
                hide = "I\'ll be here."
            } }
    },
    {
        text = "Your inner world is already open to you. <font color=\'rgb(180,80,255)\'>Infinite Blade Works</font> is yours to command. There is nothing more I can forge for you.",
        responses = { "Farewell." },
        actions = { {
                hide = "Trace on."
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 115
    -- upvalues: ForgeArchonMastery (copy), Knit (copy), QuestRewardData (copy)
    if not ForgeArchonMastery then
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

    return CompletedQuests and CompletedQuests.ForgeArchonMastery and 5 or (QuestRewardData.CheckConditions(ForgeArchonMastery, Data) and 3 or 1);
end;

function u1.onResponse(p4, p5, p6) -- Line: 142
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), ForgeArchonMastery (copy)
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

    if Registry and QuestRewardData.CheckConditions(ForgeArchonMastery, Registry.Data) then
        return "server", "QuestReward", {
            questId = v8.questReward
        }, "I am the bone of my sword. The world is open to you now.";
    end;

    return "goto", 4;
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 167
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "ForgeArchonMastery" then
        return;
    end;

    if p12.success then
        print("[ForgeArchon] Quest reward granted successfully!");

        return;
    end;

    warn("[ForgeArchon] Quest reward failed:", p12.reason);
end;

return u1;