--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Coyote
  Path:     game.ReplicatedStorage.DialogueData.Coyote
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
    npcName = "Coyote",
    animation = nil
};
local CoyotePack = QuestRewardData.Quests.CoyotePack;
u1.dialogs = {
    {
        text = "Oh? You actually made it here. Not gonna lie, I didn\'t think anyone would.",
        responses = { "Who are you?", "I\'ve been through a lot to get here.", "Just exploring." },
        actions = { {
                goto = 2
            }, {
                goto = 3
            }, {
                hide = "Heh, enjoy the view then."
            } }
    },
    {
        text = "Me? I\'m just the guy who built all this. Every dungeon, every room, every tile you\'ve walked on, that\'s me. But you didn\'t come here for a history lesson, did you?",
        responses = { "No, I came for something more.", "Wait, you BUILT all this?" },
        actions = { {
                goto = 3
            }, {
                hide = "Every. Single. Block. But hey, who\'s counting?"
            } }
    },
    {
        text = "Alright look, you walked the path of the <font color=\'rgb(255,80,80)\'>Kage</font>, that alone tells me you\'re built different. Most people can\'t even find that guy, let alone earn his mask. I respect that. So here\'s the deal.",
        responses = { "I\'m listening.", "What\'s the deal?", "Maybe later." },
        actions = { {
                questReward = "CoyotePack"
            }, {
                goto = 4
            }, {
                hide = "No rush. I\'ll be here... I literally can\'t leave."
            } }
    },
    {
        text = "My set. The <font color=\'rgb(255,220,80)\'>Coyote Set</font>. The real deal. Only the most dedicated players get to wear it. It\'ll cost you <font color=\'rgb(255,220,80)\'>100,000 Coins</font>, consider it a donation to the development fund.",
        responses = { "Shut up and take my coins.", "I\'ll come back." },
        actions = { {
                questReward = "CoyotePack"
            }, {
                hide = "Smart. Save up. It\'s worth every coin, trust me."
            } }
    },
    {
        text = "You\'re close but not quite there. I need you at <font color=\'rgb(255,220,80)\'>Level 50</font>, with <font color=\'rgb(255,220,80)\'>Kage Level 5</font>, and <font color=\'rgb(255,220,80)\'>100,000 Coins</font>. Yeah it\'s a lot. That\'s kind of the point.",
        responses = { "I\'ll grind it out." },
        actions = { {
                hide = "That\'s the spirit. Now go make me proud."
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 111
    -- upvalues: CoyotePack (copy), Knit (copy), QuestRewardData (copy)
    if not CoyotePack then
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
            if v == "Coyote Set" then
                return 1;
            end;
        end;
    end;

    local Packs = v3.Data.Packs;

    return Packs and (Packs.CoyotePack or 0) > 0 and 1 or (QuestRewardData.CheckConditions(CoyotePack, v3.Data) and 3 or 1);
end;

function u1.onResponse(p4, p5, p6) -- Line: 146
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy), CoyotePack (copy)
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

    if Registry and QuestRewardData.CheckConditions(CoyotePack, Registry.Data) then
        return "server", "QuestReward", {
            questId = v8.questReward
        }, "Welcome to the club.";
    end;

    return "goto", 5;
end;

function u1.onServerResult(p9, p10, p11, p12) -- Line: 171
    if p11 ~= "QuestReward" then
        return;
    end;

    if not p12 or p12.questId ~= "CoyotePack" then
        return;
    end;

    if p12.success then
        print("[Coyote] Quest reward granted successfully!");

        return;
    end;

    warn("[Coyote] Quest reward failed:", p12.reason);
end;

return u1;