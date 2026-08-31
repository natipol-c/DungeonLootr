--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Mooncarver
  Path:     game.ReplicatedStorage.DialogueData.Mooncarver
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
    npcName = "Mooncarver",
    animation = nil
};
local MooncarverDemonsEye = QuestRewardData.Quests.MooncarverDemonsEye;
u1.dialogs = {
    {
        text = "How many centuries has it been... since someone stood before me without trembling?",
        responses = { "What are you?", "I\'m not afraid of you.", "I should go." },
        actions = { {
                goto = 2
            }, {
                goto = 3
            }, {
                hide = "... Pitiful."
            } }
    },
    {
        text = "I was once a swordsman, the finest of my era. But perfection was not enough. I craved eternity... and eternity craved something in return. These eyes see everything now. Every flaw. Every opening. Every death before it happens.",
        responses = { "Give me that power.", "That sounds like a curse." },
        actions = { {
                goto = 3
            }, {
                hide = "Curse... blessing... the distinction fades after the first hundred years."
            } }
    },
    {
        text = "You\'ve walked three paths of the blade, the <font color=\'rgb(180,80,255)\'>Master Swordsman\'s</font> discipline, the <font color=\'rgb(180,80,255)\'>Ronin\'s</font> resolve, and the <font color=\'rgb(180,80,255)\'>Cursed Child\'s</font> hunger. I can see it in you... the same ambition that consumed me.",
        responses = { "Grant me the Demon\'s Eye.", "What will it cost me?", "I\'m not ready." },
        actions = { {
                questReward = "MooncarverDemonsEye"
            }, {
                goto = 4
            }, {
                hide = "Then you will die ordinary. Leave."
            } }
    },
    {
        text = "<font color=\'rgb(255,220,80)\'>50,000 Coins</font>, a mortal tribute for an immortal gift. The <font color=\'rgb(255,80,80)\'>Demon\'s Eye</font> will open within you. You will see as I see... cut as I cut. There is no returning to what you were.",
        responses = { "I accept.", "Not yet." },
        actions = { {
                questReward = "MooncarverDemonsEye"
            }, {
                hide = "The moon will rise again. Whether you will still draw breath... that is uncertain."
            } }
    },
    {
        text = "You lack the foundation. Master the <font color=\'rgb(255,220,80)\'>Master Swordsman</font>, the <font color=\'rgb(255,220,80)\'>Ronin</font>, and the <font color=\'rgb(255,220,80)\'>Cursed Child</font>, all to <font color=\'rgb(255,220,80)\'>Level 30</font>. Reach <font color=\'rgb(255,220,80)\'>Level 40</font>. Bring <font color=\'rgb(255,220,80)\'>50,000 Coins</font>. Only then will these eyes acknowledge you.",
        responses = { "I\'ll return stronger." },
        actions = { {
                hide = "... If you survive that long."
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 111
    -- upvalues: MooncarverDemonsEye (copy), Knit (copy), QuestRewardData (copy)
    if not MooncarverDemonsEye then
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

    local ClassItems = v3.Data.ClassItems;

    if ClassItems then
        for _, v in ClassItems do
            if v == "Demons Eye" then
                return 1;
            end;
        end;
    end;

    return QuestRewardData.CheckConditions(MooncarverDemonsEye, v3.Data) and 3 or 1;
end;

function u1.onResponse(p4, p5, p6) -- Line: 140
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), MooncarverDemonsEye (copy)
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

    if Registry and QuestRewardData.CheckConditions(MooncarverDemonsEye, Registry.Data) then
        return "server", "QuestReward", {
            questId = v8.questReward
        }, "... The moon weeps for what you\'ve become.";
    end;

    return "goto", 5;
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 165
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "MooncarverDemonsEye" then
        return;
    end;

    if p12.success then
        print("[Mooncarver] Quest reward granted successfully!");

        return;
    end;

    warn("[Mooncarver] Quest reward failed:", p12.reason);
end;

return u1;