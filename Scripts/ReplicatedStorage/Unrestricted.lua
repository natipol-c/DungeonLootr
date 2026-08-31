--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Unrestricted
  Path:     game.ReplicatedStorage.DialogueData.Unrestricted
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
    npcName = "Unrestricted",
    animation = nil
};
local UnrestrictedInvertedSpear = QuestRewardData.Quests.UnrestrictedInvertedSpear;
local UnrestrictedUnchained = QuestRewardData.Quests.UnrestrictedUnchained;
u1.dialogs = {
    {
        text = "No cursed energy on you? Good. Neither on me. That\'s the only kind of person I can actually talk to. What do you want?",
        responses = { "The Inverted Spear.", "Acknowledge my mastery.", "Who are you?", "Nothing." },
        actions = { {
                goto = 3
            }, {
                goto = 6
            }, {
                goto = 2
            }, {
                hide = "Then stop wasting my time."
            } }
    },
    {
        text = "Just a man with a body and a job. No technique, no domain, no talent handed down from the heavens. I killed the ones who had all of that anyway. The <font color=\'rgb(150,220,255)\'>Inverted Spear of Heaven</font> was my tool. If you\'ve got the raw physicality to swing it, it could be yours.",
        responses = { "Tell me how.", "Later." },
        actions = { {
                goto = 3
            }, {
                hide = "Suit yourself."
            } }
    },
    {
        text = "Simple. Prove your body\'s caught up to your ambition: <font color=\'rgb(255,220,80)\'>Player Level 75</font>. Master the strongest there is: the <font color=\'rgb(120,200,255)\'>Honored One</font> to <font color=\'rgb(255,220,80)\'>Class Mastery Level 25</font>. Bring me <font color=\'rgb(150,220,255)\'>10 Heavenly Fragments</font> and a fee of <font color=\'rgb(255,220,80)\'>500,000 Coins</font>. Do that, and the <font color=\'rgb(150,220,255)\'>Inverted Spear</font> is yours.",
        responses = { "I have everything.", "Where do I find Heavenly Fragments?", "Not yet." },
        actions = { {
                questReward = "UnrestrictedInvertedSpear"
            }, {
                goto = 5
            }, {
                hide = "Then come back when you do."
            } }
    },
    {
        text = "You\'re short. <font color=\'rgb(255,220,80)\'>Player Level 75</font>. <font color=\'rgb(120,200,255)\'>Honored One</font> mastery <font color=\'rgb(255,220,80)\'>25</font>. <font color=\'rgb(150,220,255)\'>10 Heavenly Fragments</font>. <font color=\'rgb(255,220,80)\'>500,000 Coins</font>. I don\'t hand out favors. Earn it, then come back.",
        responses = { "Where do I find Heavenly Fragments?", "Understood." },
        actions = { {
                goto = 5
            }, {
                hide = "Don\'t come back empty-handed."
            } }
    },
    {
        text = "<font color=\'rgb(150,220,255)\'>Heavenly Fragments</font> break loose when a domain shatters. Push deep into the <font color=\'rgb(255,120,120)\'>Challenge Dungeon</font>. Past <font color=\'rgb(255,220,80)\'>Wave 40</font>, the bosses that headline every tenth wave sometimes leave one behind when they fall. Rare. You\'ll be there a while.",
        responses = { "Back to the spear.", "Got it." },
        actions = { {
                goto = 3
            }, {
                hide = "Get to work."
            } }
    },
    {
        text = "So you\'ve mastered the spear: <font color=\'rgb(255,220,80)\'>Unrestricted Class Mastery Level 50</font>. There\'s nothing left holding you back, is there? Lay down <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font> and I\'ll give you a name that fits: <font color=\'rgb(255,45,45)\'>Unchained</font>.",
        responses = { "Here\'s the tribute.", "Not yet." },
        actions = { {
                questReward = "UnrestrictedUnchained"
            }, {
                hide = "Then you\'re still chained to something. Figure out what."
            } }
    },
    {
        text = "Not yet you haven\'t. Take the <font color=\'rgb(150,220,255)\'>Unrestricted</font> to <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font> and bring <font color=\'rgb(255,220,80)\'>1,000,000 Coins</font>. Only then are you truly <font color=\'rgb(255,45,45)\'>Unchained</font>.",
        responses = { "I\'ll be back." },
        actions = { {
                hide = "Go break your limits."
            } }
    },
    {
        text = "The spear\'s yours. The name\'s yours. <font color=\'rgb(255,45,45)\'>Unchained</font>: no heavens above you, no cursed energy holding you down. That\'s as free as anyone gets. Now get out there.",
        responses = { "See you around." },
        actions = { {
                hide = "Heh. Try not to die."
            } }
    }
};
local u2 = {
    UnrestrictedInvertedSpear = 4,
    UnrestrictedUnchained = 7
};
local u3 = {
    UnrestrictedInvertedSpear = "The Inverted Spear is yours. Don\'t get yourself killed with it.",
    UnrestrictedUnchained = "Unchained. Now nothing\'s above you. Go."
};

function u1.getStartDialog(p4) -- Line: 179
    -- upvalues: Knit (copy), UnrestrictedUnchained (copy), QuestRewardData (copy), UnrestrictedInvertedSpear (copy)
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
    local v7 = v6.UnrestrictedInvertedSpear == true;
    local v8 = v6.UnrestrictedUnchained == true;

    return v7 and v8 and 8 or (UnrestrictedUnchained and (not v8 and QuestRewardData.CheckConditions(UnrestrictedUnchained, Data)) and 6 or (UnrestrictedInvertedSpear and (not v7 and QuestRewardData.CheckConditions(UnrestrictedInvertedSpear, Data)) and 3 or 1));
end;

function u1.onResponse(p9, p10, p11) -- Line: 212
    -- upvalues: u1 (copy), QuestRewardData (copy), Knit (copy), u2 (copy), u3 (copy)
    local v12 = u1.dialogs[p11];

    if not (v12 and v12.actions) then
        return "hide";
    end;

    local v13 = v12.actions[p10];

    if not v13 then
        return "hide";
    end;

    if v13.goto then
        return "goto", v13.goto, v13.quip;
    end;

    if not v13.questReward then
        if v13.hide then
            return "hide", v13.hide;
        end;

        return "hide";
    end;

    local questReward = v13.questReward;
    local v14 = QuestRewardData.Quests[questReward];
    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if not (Registry and (v14 and QuestRewardData.CheckConditions(v14, Registry.Data))) then
        return "goto", u2[questReward] or 4;
    end;

    if (Registry.Data.CompletedQuests or {})[questReward] then
        return "hide", "You already took that from me. Once is enough.";
    end;

    return "server", "QuestReward", {
        questId = questReward
    }, u3[questReward] or "...";
end;

function u1.onServerResult(p15, p16, p17, p18) -- Line: 249
    if p17 ~= "QuestReward" then
        return;
    end;

    if not p18 then
        return;
    end;

    if p18.success then
        print("[Unrestricted] Quest reward granted:", p18.questId);

        return;
    end;

    warn("[Unrestricted] Quest reward failed:", p18.reason);
end;

return u1;