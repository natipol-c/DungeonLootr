--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Guide
  Path:     game.ReplicatedStorage.DialogueData.Guide
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
    npcName = "Guide",
    animation = nil
};
local GuideKickstart = QuestRewardData.Quests.GuideKickstart;
u1.dialogs = {
    {
        text = "Hey there, adventurer! Need some <font color=\'rgb(255,220,80)\'>guidance</font>? I can help you with just about anything.",
        responses = { "How do I change my class?", "How do I get loot?", "How do I sell loot?", "What is Gear Score?" },
        actions = { {
                guide = "ClassArea",
                quip = "Head to the <font color=\'rgb(100,200,140)\'>Classes area</font> and talk to the Class NPC to switch classes. Follow the beam!"
            }, {
                goto = 2
            }, {
                goto = 3
            }, {
                goto = 4
            } }
    },
    {
        text = "Simple, loot lives in the <font color=\'rgb(255,220,80)\'>chests</font> you find inside <font color=\'rgb(255,100,100)\'>Dungeons</font>! Crack them open to score gear, and everything you grab is <font color=\'rgb(100,200,140)\'>banked straight to your inventory</font>, stats and all, ready to equip.",
        responses = { "Where do I start a dungeon?", "What else can I learn?", "Thanks!" },
        actions = { {
                guide = "DungeonDoor",
                quip = "Step into a <font color=\'rgb(255,100,100)\'>dungeon Pod</font> over there to queue up! Follow the beam!"
            }, {
                goto = 1
            }, {
                hide = "Happy looting!"
            } }
    },
    {
        text = "Got gear you don\'t need? The <font color=\'rgb(100,255,100)\'>Sell Shop</font> is right behind me, sell your equipment there for coins. Pro tip: lock any gear you want to keep so you don\'t sell it by accident!",
        responses = { "Show me the shop!", "What else?", "Thanks!" },
        actions = { {
                guide = "SellShop",
                quip = "The <font color=\'rgb(100,255,100)\'>Sell Shop</font> is right behind me! Follow the beam!"
            }, {
                goto = 1
            }, {
                hide = "Sell smart!"
            } }
    },
    {
        text = "<font color=\'rgb(255,220,80)\'>Gear Score</font> is a power estimation, it takes your stats, equipment, and class level into account to give you a rough idea of how strong you are. Higher gear score means you\'re better prepared for tougher dungeons!",
        responses = { "How do I level up my stats?", "Back to topics.", "Got it, thanks!" },
        actions = { {
                goto = 5
            }, {
                goto = 1
            }, {
                hide = "Keep pushing that number up!"
            } }
    },
    {
        text = "Open your <font color=\'rgb(255,220,80)\'>Inventory</font>, then click the green <font color=\'rgb(100,255,100)\'>Stats</font> button to bring up your stat view. Every <font color=\'rgb(255,220,80)\'>Class Level</font> earns you Skill Points, just press the green <font color=\'rgb(100,255,100)\'>+</font> next to a stat to spend them. You can raise <font color=\'rgb(255,100,100)\'>STR</font>, <font color=\'rgb(100,255,100)\'>DEX</font>, <font color=\'rgb(100,150,255)\'>INT</font>, or <font color=\'rgb(255,220,80)\'>VIT</font>. Choose wisely, it shapes your build!",
        responses = { "What stats should I level up?", "Back to topics.", "Thanks!" },
        actions = { {
                goto = 6
            }, {
                goto = 1
            }, {
                hide = "Build smart, adventurer!"
            } }
    },
    {
        text = "That depends on your class\'s <font color=\'rgb(255,220,80)\'>archetype</font>! <font color=\'rgb(255,100,100)\'>Physical</font> classes (like Zero, Founder, or Boxer) hit hardest with <font color=\'rgb(255,100,100)\'>STR</font>. <font color=\'rgb(100,255,100)\'>Ranged</font> classes (like Archer, Bowman, or Witch Gunner) scale off <font color=\'rgb(100,255,100)\'>DEX</font>. <font color=\'rgb(100,150,255)\'>Magic</font> classes (like Demonbane or Shadow Vagrant) power up with <font color=\'rgb(100,150,255)\'>INT</font>. <font color=\'rgb(255,220,80)\'>VIT</font> is for everyone, it boosts your HP and survivability. So pump your archetype\'s damage stat, then top up VIT to stay standing!",
        responses = { "How do I open my stats again?", "Back to topics.", "Thanks!" },
        actions = { {
                goto = 5
            }, {
                goto = 1
            }, {
                hide = "Match your points to your class!"
            } }
    },
    {
        text = "You\'ve been grinding hard and I respect that. I\'ve got a little something for you, a free <font color=\'rgb(180,80,255)\'>Epic Gear Pack</font>! Full set of Epic equipment to give you a kickstart. Consider it a reward for sticking with it.",
        responses = { "Yes please!", "Maybe later." },
        actions = { {
                questReward = "GuideKickstart"
            }, {
                hide = "It\'ll be here when you want it!"
            } }
    },
    {
        text = "You\'re not quite there yet! Hit <font color=\'rgb(255,220,80)\'>Level 10</font> and come talk to me, I\'ve got a free gear pack with your name on it.",
        responses = { "I\'ll be back!" },
        actions = { {
                hide = "Keep grinding, adventurer!"
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 177
    -- upvalues: Knit (copy), GuideKickstart (copy), QuestRewardData (copy)
    local Registry = Knit.Registry;

    if not Registry then
        return 1;
    end;

    local v3 = Registry:Get("PlayerData");

    if not v3 then
        return 1;
    end;

    local CompletedQuests = v3.Data.CompletedQuests;

    return (CompletedQuests and CompletedQuests.GuideKickstart or not (GuideKickstart and QuestRewardData.CheckConditions(GuideKickstart, v3.Data))) and 1 or 7;
end;

function u1.onResponse(p4, p5, p6) -- Line: 197
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), GuideKickstart (copy)
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

    if v8.guide then
        return "server", "GuidePointer", {
            targetId = v8.guide
        }, v8.quip;
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

    if not (Registry and QuestRewardData.CheckConditions(GuideKickstart, Registry.Data)) then
        return "goto", 8;
    end;

    local CompletedQuests = Registry.Data.CompletedQuests;

    if CompletedQuests and CompletedQuests.GuideKickstart then
        return "hide", "You already got your kickstart pack!";
    end;

    return "server", "QuestReward", {
        questId = v8.questReward
    }, "Here you go! Open it from your inventory.";
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 229
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "GuideKickstart" then
        return;
    end;

    if p12.success then
        print("[Guide] Kickstart pack granted successfully!");

        return;
    end;

    warn("[Guide] Kickstart pack failed:", p12.reason);
end;

return u1;