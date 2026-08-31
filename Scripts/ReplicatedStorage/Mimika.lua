--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Mimika
  Path:     game.ReplicatedStorage.DialogueData.Mimika
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
    npcName = "Mimika",
    animation = nil
};
local MimikaGoldenKatana = QuestRewardData.Quests.MimikaGoldenKatana;
u1.dialogs = {
    {
        text = "You have a warrior\'s eyes. Tell me, do you walk the path of the blade, or merely wander near it?",
        responses = { "Who are you?", "I walk the path.", "I\'m just passing through." },
        actions = { {
                goto = 2
            }, {
                goto = 3
            }, {
                hide = "Then pass. The path is not for all."
            } }
    },
    {
        text = "I am <font color=\'rgb(255,80,100)\'>Mimika</font>. I wear the mark of the <font color=\'rgb(255,80,100)\'>Battlegoddess</font>, earned through a thousand duels, sworn under blood and roses. I was given a relic once... a <font color=\'rgb(255,220,80)\'>Golden Katana</font>. It is not mine to keep. But it may find its way to one who proves worthy.",
        responses = { "Tell me what it takes.", "I\'ll come back stronger." },
        actions = { {
                goto = 3
            }, {
                hide = "Then go. Temper yourself."
            } }
    },
    {
        text = "Master the way of the <font color=\'rgb(180,80,255)\'>Ronin</font> to <font color=\'rgb(255,220,80)\'>Level 30</font>. Prove yourself worthy by reaching <font color=\'rgb(255,220,80)\'>Level 50</font>. Bring me <font color=\'rgb(255,80,100)\'>three Flaming Crystals</font>, and a tribute of <font color=\'rgb(255,220,80)\'>50,000 Coins</font>. Only then will the Golden Katana acknowledge you.",
        responses = { "I have everything you need.", "Where do I find Flaming Crystals?", "I need more time." },
        actions = { {
                questReward = "MimikaGoldenKatana"
            }, {
                goto = 6
            }, {
                hide = "The roses do not wait for the hesitant."
            } }
    },
    {
        text = "The <font color=\'rgb(255,220,80)\'>Golden Katana</font> was forged by a swordsmith who transcended his craft. With it, you will become the <font color=\'rgb(180,80,255)\'>Master Ronin</font>, a blade whose every cut answers the heavens. Tell me. Are you ready to carry that weight?",
        responses = { "I am ready.", "Not yet." },
        actions = { {
                questReward = "MimikaGoldenKatana"
            }, {
                hide = "Then return when the weight feels lighter. Not before."
            } }
    },
    {
        text = "You lack what is required. Return when you have reached <font color=\'rgb(255,220,80)\'>Level 50</font>, mastered the <font color=\'rgb(255,220,80)\'>Ronin</font> to <font color=\'rgb(255,220,80)\'>Level 30</font>, gathered <font color=\'rgb(255,80,100)\'>three Flaming Crystals</font>, and brought <font color=\'rgb(255,220,80)\'>50,000 Coins</font> as tribute.",
        responses = { "Where do I find Flaming Crystals?", "I understand." },
        actions = { {
                goto = 6
            }, {
                hide = "The blade will wait. But not forever."
            } }
    },
    {
        text = "The <font color=\'rgb(255,80,100)\'>Flaming Crystal</font> is a shard of blue fire, torn from the heart of a demon. You will find them by defeating the <font color=\'rgb(100,150,255)\'>Awakened Devil</font>, a special boss who rises only in the <font color=\'rgb(100,200,255)\'>Frostspire</font> dungeon. A dangerous encounter. Prepare well.",
        responses = { "Back to the quest.", "Thank you, Mimika." },
        actions = { {
                goto = 3
            }, {
                hide = "May your blade remain sharp."
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 127
    -- upvalues: MimikaGoldenKatana (copy), Knit (copy), QuestRewardData (copy)
    if not MimikaGoldenKatana then
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
            if v == "Golden Katana" then
                return 1;
            end;
        end;
    end;

    return QuestRewardData.CheckConditions(MimikaGoldenKatana, v3.Data) and 3 or 1;
end;

function u1.onResponse(p4, p5, p6) -- Line: 156
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), MimikaGoldenKatana (copy)
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

    if Registry and QuestRewardData.CheckConditions(MimikaGoldenKatana, Registry.Data) then
        return "server", "QuestReward", {
            questId = v8.questReward
        }, "The roses bloom red once more.";
    end;

    return "goto", 5;
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 181
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "MimikaGoldenKatana" then
        return;
    end;

    if p12.success then
        print("[Mimika] Quest reward granted successfully!");

        return;
    end;

    warn("[Mimika] Quest reward failed:", p12.reason);
end;

return u1;