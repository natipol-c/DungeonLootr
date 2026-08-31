--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ogge
  Path:     game.ReplicatedStorage.DialogueData.Ogge
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
    npcName = "Ogge",
    animation = nil
};
local OggePartyAnimal = QuestRewardData.Quests.OggePartyAnimal;
u1.dialogs = {
    {
        text = "Yooo what\'s good!! You found me! Most people are still looking for my hat!",
        responses = { "Wait... THE Ogge?", "Where\'s your hat??", "I gotta go." },
        actions = { {
                goto = 2
            }, {
                goto = 2
            }, {
                hide = "Aight bet, come back whenever fam!"
            } }
    },
    {
        text = "Bro you have NO idea how many people ask me that. The hat is FINE. It\'s safe. Probably. Look, I didn\'t build all these maps just to talk about headwear, I\'m here to vibe. And YOU look like you know how to vibe.",
        responses = { "I definitely know how to vibe.", "Where do I find your hat?" },
        actions = { {
                goto = 3
            }, {
                goto = 6
            } }
    },
    {
        text = "Look, I got something special for real ones who put in the work. You gotta know your <font color=\'rgb(100,200,140)\'>Monk</font> stuff AND your <font color=\'rgb(100,200,140)\'>Healing Fist</font> game. Oh and... you gotta bring me back my <font color=\'rgb(100,180,255)\'>Blue Fedora</font>. I left it <font color=\'rgb(255,220,80)\'>somewhere around spawn</font>. Don\'t judge me.",
        responses = { "Say less. I\'m ready.", "What am I getting exactly?", "Where do I find your hat?", "Not yet bro." },
        actions = { {
                questReward = "OggePartyAnimal"
            }, {
                goto = 4
            }, {
                goto = 6
            }, {
                hide = "No cap, come back when you\'re ready king."
            } }
    },
    {
        text = "The <font color=\'rgb(255,180,50)\'>Party Animal Aura</font> my guy. Straight drip. Everyone in the lobby gonna KNOW you\'re different. It\'s gonna cost you <font color=\'rgb(255,220,80)\'>10,000 Coins</font> though, quality ain\'t free fam.",
        responses = { "Take my money.", "I\'ll be back." },
        actions = { {
                questReward = "OggePartyAnimal"
            }, {
                hide = "Respect. The grind don\'t stop!"
            } }
    },
    {
        text = "Ayy you\'re not quite there yet fam. Get to <font color=\'rgb(255,220,80)\'>Level 30</font>, train your <font color=\'rgb(255,220,80)\'>Monk</font> and <font color=\'rgb(255,220,80)\'>Healing Fist</font> to <font color=\'rgb(255,220,80)\'>Level 30</font>, find my <font color=\'rgb(100,180,255)\'>Blue Fedora</font> <font color=\'rgb(255,220,80)\'>somewhere around spawn</font>, and bring <font color=\'rgb(255,220,80)\'>10,000 Coins</font>. Then we party.",
        responses = { "On it!" },
        actions = { {
                hide = "LESGOOO! I believe in you bro!"
            } }
    },
    {
        text = "My <font color=\'rgb(100,180,255)\'>Blue Fedora</font>? Yeah I kinda... left it <font color=\'rgb(255,220,80)\'>somewhere around spawn</font>. I was vibing too hard and forgot where I put it. It\'s out there though, just gotta look around. You\'ll know it when you see it, it\'s a fedora. It\'s blue. Can\'t miss it.",
        responses = { "I\'ll go find it.", "Back to the deal." },
        actions = { {
                hide = "Good luck fam, it\'s gotta be around there somewhere!"
            }, {
                goto = 3
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 127
    -- upvalues: OggePartyAnimal (copy), Knit (copy), QuestRewardData (copy)
    if not OggePartyAnimal then
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

    local OwnedCosmetics = v3.Data.OwnedCosmetics;

    if OwnedCosmetics then
        for _, v in OwnedCosmetics do
            if v == "Party Animal" then
                return 1;
            end;
        end;
    end;

    return QuestRewardData.CheckConditions(OggePartyAnimal, v3.Data) and 3 or 1;
end;

function u1.onResponse(p4, p5, p6) -- Line: 156
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), OggePartyAnimal (copy)
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

    if Registry and QuestRewardData.CheckConditions(OggePartyAnimal, Registry.Data) then
        return "server", "QuestReward", {
            questId = v8.questReward
        }, "YOOOO LET\'S GOOOO!!";
    end;

    return "goto", 5;
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 181
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "OggePartyAnimal" then
        return;
    end;

    if p12.success then
        print("[Ogge] Quest reward granted successfully!");

        return;
    end;

    warn("[Ogge] Quest reward failed:", p12.reason);
end;

return u1;