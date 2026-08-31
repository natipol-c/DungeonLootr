--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DevilHunter
  Path:     game.ReplicatedStorage.DialogueData.DevilHunter
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local QuestRewardData = require(ReplicatedStorage.GameInfo.QuestRewardData);
local u1 = {
    npcName = "Devil Hunter",
    animation = nil
};
local DevilHunterMastery = QuestRewardData.Quests.DevilHunterMastery;
u1.dialogs = {
    {
        text = "Well, well. Another trigger-happy hotshot struts into my shop. Let me guess. You swing those <font color=\'rgb(255,45,45)\'>Sinister Triggers</font> around and think that makes you a devil hunter. Cute. What do you want?",
        responses = { "I want the name. Make it official.", "Who are you, exactly?", "Just browsing." },
        actions = { {
                goto = 3
            }, {
                goto = 2
            }, {
                hide = "Then keep it moving, tourist."
            } }
    },
    {
        text = "Me? I\'m the guy demons tell scary stories about. Been putting bullets in things that go bump in the night since before you could hold a pistol straight. The trade\'s got a dress code, though. You don\'t get to call yourself a <font color=\'rgb(255,45,45)\'>Devil Hunter</font> just because you own a couple of loud guns. You earn it. In blood, ideally not yours.",
        responses = { "So how do I earn it?", "Maybe later." },
        actions = { {
                goto = 3
            }, {
                hide = "Heh. They always come back."
            } }
    },
    {
        text = "Alright, showoff, here\'s the deal. Take the <font color=\'rgb(255,45,45)\'>Sinister Trigger</font> all the way: <font color=\'rgb(255,220,80)\'>Class Mastery Level 50</font>. Then pay the toll: <font color=\'rgb(255,220,80)\'>2,000,000 Coins</font>, <font color=\'rgb(255,45,45)\'>5 Devil Hearts</font> to prove you\'ve actually killed something that bites back, and <font color=\'rgb(150,220,255)\'>2 Exotic Ingots</font> so I know your gear won\'t fall apart mid-fight. Do all that, and the name <font color=\'rgb(255,45,45)\'>Devil Hunter</font> is yours.",
        responses = { "Toll\'s paid. Every last coin.", "Where do I get the hearts and ingots?", "That\'s a steep price." },
        actions = { {
                questReward = "DevilHunterMastery"
            }, {
                goto = 5
            }, {
                hide = "Quality costs, kid. Come back when you can afford it."
            } }
    },
    {
        text = "Nice try, but the books don\'t lie. You\'re missing something. <font color=\'rgb(255,45,45)\'>Sinister Trigger</font> mastery <font color=\'rgb(255,220,80)\'>50</font>. <font color=\'rgb(255,220,80)\'>2,000,000 Coins</font>. <font color=\'rgb(255,45,45)\'>5 Devil Hearts</font>. <font color=\'rgb(150,220,255)\'>2 Exotic Ingots</font>. No IOUs, no discounts. Come back when it\'s all on the table.",
        responses = { "Where do I get the hearts and ingots?", "Understood." },
        actions = { {
                goto = 5
            }, {
                hide = "Don\'t keep me waiting too long."
            } }
    },
    {
        text = "<font color=\'rgb(255,45,45)\'>Devil Hearts</font> come out of the <font color=\'rgb(120,200,255)\'>Awakened Devil</font>. Hunt it on <font color=\'rgb(150,220,255)\'>Frostspire, Nightmare or worse</font>, and clear the run or you leave with nothing. <font color=\'rgb(150,220,255)\'>Exotic Ingots</font> you forge yourself: the <font color=\'rgb(255,120,120)\'>Scarlet Knight</font> in the Underworld drops <font color=\'rgb(150,220,255)\'>Exotic Ore</font>, and the bench turns ore into ingots. Simple. Bloody, but simple.",
        responses = { "Back to the deal.", "Got it." },
        actions = { {
                goto = 3
            }, {
                hide = "Go earn it, hotshot."
            } }
    },
    {
        text = "Look who it is: a genuine, card-carrying <font color=\'rgb(255,45,45)\'>Devil Hunter</font>. Told you the name means something. Wear it well, and try not to make me regret handing it over. Now buy me a pizza and get back to work.",
        responses = { "Always." },
        actions = { {
                hide = "Devils never cry, kid. Neither do we."
            } }
    }
};
local u2 = {
    DevilHunterMastery = 4
};
local u3 = {
    DevilHunterMastery = "Welcome to the trade, Devil Hunter. Now go make something bleed."
};

function u1.getStartDialog(p4) -- Line: 147
    -- upvalues: Knit (copy), DevilHunterMastery (copy), QuestRewardData (copy)
    local Registry = Knit.Registry;

    if not Registry then
        return 1;
    end;

    local v5 = Registry:Get("PlayerData");

    if not (v5 and v5.Data) then
        return 1;
    end;

    local Data = v5.Data;

    return (Data.CompletedQuests or {}).DevilHunterMastery == true and 6 or (DevilHunterMastery and QuestRewardData.CheckConditions(DevilHunterMastery, Data) and 3 or 1);
end;

function u1.onResponse(p6, p7, p8) -- Line: 172
    -- upvalues: u1 (copy), QuestRewardData (copy), Knit (copy), u2 (copy), u3 (copy)
    local v9 = u1.dialogs[p8];

    if not (v9 and v9.actions) then
        return "hide";
    end;

    local v10 = v9.actions[p7];

    if not v10 then
        return "hide";
    end;

    if v10.goto then
        return "goto", v10.goto, v10.quip;
    end;

    if not v10.questReward then
        if v10.hide then
            return "hide", v10.hide;
        end;

        return "hide";
    end;

    local questReward = v10.questReward;
    local v11 = QuestRewardData.Quests[questReward];
    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if not (Registry and (v11 and QuestRewardData.CheckConditions(v11, Registry.Data))) then
        return "goto", u2[questReward] or 4;
    end;

    if (Registry.Data.CompletedQuests or {})[questReward] then
        return "hide", "You\'ve already got the name. One\'s all you get.";
    end;

    return "server", "QuestReward", {
        questId = questReward
    }, u3[questReward] or "...";
end;

function u1.onServerResult(p12, p13, p14, p15) -- Line: 209
    if p14 ~= "QuestReward" then
        return;
    end;

    if not p15 then
        return;
    end;

    if p15.success then
        print("[DevilHunter] Quest reward granted:", p15.questId);

        return;
    end;

    warn("[DevilHunter] Quest reward failed:", p15.reason);
end;

return u1;