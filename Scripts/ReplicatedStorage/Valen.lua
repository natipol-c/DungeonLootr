--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Valen
  Path:     game.ReplicatedStorage.DialogueData.Valen
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
    npcName = "Valen",
    animation = nil
};
local ValenMotivated = QuestRewardData.Quests.ValenMotivated;
local ValenTheStorm = QuestRewardData.Quests.ValenTheStorm;
local ValenJudgement = QuestRewardData.Quests.ValenJudgement;
local ValenStormcaller = QuestRewardData.Quests.ValenStormcaller;
u1.dialogs = {
    {
        text = "... You stand before me as if that means something. Perhaps, now, it does. Which power do you seek to have acknowledged?",
        responses = { "The Azure Devil.", "The Awakened Devil.", "Judgement\'s Edge.", "Who are you?", "I\'ll leave." },
        actions = { {
                goto = 3
            }, {
                goto = 5
            }, {
                goto = 8
            }, {
                goto = 2
            }, {
                hide = "... At least you know your place."
            } }
    },
    {
        text = "I am <font color=\'rgb(100,150,255)\'>Valen</font>. I walked the path of the blade until it demanded everything, then I walked past it, into the devil\'s own power. Bring either path to its peak and I will tell you what you have become.",
        responses = { "The Azure Devil path.", "The Awakened Devil path.", "Later." },
        actions = { {
                goto = 3
            }, {
                goto = 5
            }, {
                hide = "... See that you return."
            } }
    },
    {
        text = "The <font color=\'rgb(100,150,255)\'>Azure Devil</font>, pushed to its absolute limit. <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font>. Do that, and you\'ll understand what it means to be truly <font color=\'rgb(100,150,255)\'>Motivated</font>, and I\'ll leave you <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font> for the road.",
        responses = { "I\'ve reached mastery 50.", "Not yet." },
        actions = { {
                questReward = "ValenMotivated"
            }, {
                hide = "... Foolishness. Come back when it\'s done."
            } }
    },
    {
        text = "You lack the resolve. Take the <font color=\'rgb(100,150,255)\'>Azure Devil</font> to <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font>. Then, and only then, will I acknowledge you as <font color=\'rgb(100,150,255)\'>Motivated</font>.",
        responses = { "I\'ll be back." },
        actions = { {
                hide = "... I need more power. And so do you."
            } }
    },
    {
        text = "The <font color=\'rgb(120,200,255)\'>Awakened Devil EX</font>. Devil Trigger given form. Master it, <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font>, and you become something the world cannot answer for: <font color=\'rgb(120,200,255)\'>The Storm</font>. A fortune of <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font> will follow in your wake.",
        responses = { "I\'ve reached mastery 50.", "Not yet." },
        actions = { {
                questReward = "ValenTheStorm"
            }, {
                hide = "... I am the storm that is approaching. You are not. Yet."
            } }
    },
    {
        text = "You are not the storm. Not yet. Take the <font color=\'rgb(120,200,255)\'>Awakened Devil EX</font> to <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font>. Become the thing that arrives before the thunder. Then return.",
        responses = { "I\'ll return." },
        actions = { {
                hide = "... The storm does not wait."
            } }
    },
    {
        text = "<font color=\'rgb(100,150,255)\'>Motivated</font>. <font color=\'rgb(120,200,255)\'>The Storm</font>. You have taken both halves of the devil to their peak. There is nothing left for me to acknowledge, only for you to wield.",
        responses = { "Farewell." },
        actions = { {
                hide = "... Now we are equals."
            } }
    },
    {
        text = "So. You would forge <font color=\'rgb(120,200,255)\'>Judgement\'s Edge</font> and awaken the devil within. Bring the <font color=\'rgb(100,150,255)\'>Azure Devil</font> to <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font>, tear a <font color=\'rgb(255,80,80)\'>Devil Heart</font> from the Awakened Devil on <font color=\'rgb(180,140,255)\'>Frostspire Nightmare</font>, and lay down <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font>. Then the power is yours.",
        responses = { "I have everything.", "Not yet." },
        actions = { {
                questReward = "ValenJudgement"
            }, {
                hide = "... Then you are not ready to wield it."
            } }
    },
    {
        text = "You come to me empty-handed. <font color=\'rgb(100,150,255)\'>Azure Devil</font> mastery <font color=\'rgb(255,220,80)\'>50</font>. A <font color=\'rgb(255,80,80)\'>Devil Heart</font> from the <font color=\'rgb(120,200,255)\'>Awakened Devil</font> on <font color=\'rgb(180,140,255)\'>Frostspire Nightmare</font>, and you must <font color=\'rgb(255,220,80)\'>survive to extract it</font>. <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font>. Return when it is done.",
        responses = { "I\'ll return." },
        actions = { {
                hide = "... The devil does not suffer the unprepared."
            } }
    },
    {
        text = "Fifty thousand souls, cut down while the <font color=\'rgb(120,200,255)\'>Awakened Devil EX</font> wore your hand. You have become the <font color=\'rgb(120,200,255)\'>Stormcaller</font>. Take the raiment that befits it, the devil\'s own regalia.",
        responses = { "Claim the reward.", "Not yet." },
        actions = { {
                questReward = "ValenStormcaller"
            }, {
                hide = "... The storm is not yet yours to wear."
            } }
    },
    {
        text = "The devil\'s regalia is earned in blood. Slay <font color=\'rgb(255,220,80)\'>50,000</font> enemies with the <font color=\'rgb(120,200,255)\'>Awakened Devil EX</font> equipped. Only then will the storm dress you as its own.",
        responses = { "I\'ll keep hunting." },
        actions = { {
                hide = "... Every kill brings it closer."
            } }
    }
};
local u2 = {
    ValenMotivated = 4,
    ValenTheStorm = 6,
    ValenJudgement = 9,
    ValenStormcaller = 11
};
local u3 = {
    ValenMotivated = "... Now I\'m motivated.",
    ValenTheStorm = "... Rise. I am the storm that is approaching.",
    ValenJudgement = "... Judgement\'s Edge is yours. Awaken.",
    ValenStormcaller = "... Wear it well, Stormcaller."
};

function u1.getStartDialog(p4) -- Line: 228
    -- upvalues: Knit (copy), ValenStormcaller (copy), QuestRewardData (copy), ValenTheStorm (copy), ValenJudgement (copy), ValenMotivated (copy)
    local Registry = Knit.Registry;

    if not Registry then
        return 1;
    end;

    local v5 = Registry:Get("PlayerData");

    if not (v5 and v5.Data) then
        return 1;
    end;

    local Data = v5.Data;
    local v6 = Data.CompletedQuests or {};
    local v7 = v6.ValenMotivated == true;
    local v8 = v6.ValenTheStorm == true;
    local v9 = v6.ValenJudgement == true;

    return ValenStormcaller and (v6.ValenStormcaller ~= true and QuestRewardData.CheckConditions(ValenStormcaller, Data)) and 10 or (v7 and v8 and 7 or (ValenTheStorm and (not v8 and QuestRewardData.CheckConditions(ValenTheStorm, Data)) and 5 or (ValenJudgement and (not v9 and QuestRewardData.CheckConditions(ValenJudgement, Data)) and 8 or (ValenMotivated and (not v7 and QuestRewardData.CheckConditions(ValenMotivated, Data)) and 3 or 1))));
end;

function u1.onResponse(p10, p11, p12) -- Line: 272
    -- upvalues: u1 (copy), QuestRewardData (copy), Knit (copy), u2 (copy), u3 (copy)
    local v13 = u1.dialogs[p12];

    if not (v13 and v13.actions) then
        return "hide";
    end;

    local v14 = v13.actions[p11];

    if not v14 then
        return "hide";
    end;

    if v14.goto then
        return "goto", v14.goto, v14.quip;
    end;

    if not v14.questReward then
        if v14.hide then
            return "hide", v14.hide;
        end;

        return "hide";
    end;

    local questReward = v14.questReward;
    local v15 = QuestRewardData.Quests[questReward];
    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if not (Registry and (v15 and QuestRewardData.CheckConditions(v15, Registry.Data))) then
        return "goto", u2[questReward] or 4;
    end;

    if (Registry.Data.CompletedQuests or {})[questReward] then
        return "hide", "... That power is already yours.";
    end;

    return "server", "QuestReward", {
        questId = questReward
    }, u3[questReward] or "...";
end;

function u1.onServerResult(p16, p17, p18, p19) -- Line: 309
    if p18 ~= "QuestReward" then
        return;
    end;

    if not p19 then
        return;
    end;

    if p19.success then
        print("[Valen] Quest reward granted:", p19.questId);

        return;
    end;

    warn("[Valen] Quest reward failed:", p19.reason);
end;

return u1;