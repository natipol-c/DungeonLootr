--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Eclipse
  Path:     game.ReplicatedStorage.DialogueData.Eclipse
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
    npcName = "Eclipse",
    animation = nil
};
local EclipseBuffPotions = QuestRewardData.Quests.EclipseBuffPotions;
local EclipseCenturion = QuestRewardData.Quests.EclipseCenturion;
u1.dialogs = {
    {
        text = "... You stand before me as though you\'re ready. <font color=\'rgb(180,80,255)\'>Are you?</font>",
        responses = { "What is this place?", "What about those swords behind you?", "What can you offer me?", "I\'ll come back later." },
        actions = { {
                goto = 2
            }, {
                goto = 7
            }, {
                goto = 5
            }, {
                hide = "... Then you already know the answer."
            } }
    },
    {
        text = "This arena was built for those who refuse to fall. The <font color=\'rgb(255,80,80)\'>Boss Rush</font> is a gauntlet of the strongest enemies you\'ve ever faced, back to back, <font color=\'rgb(255,80,80)\'>no rest</font>, <font color=\'rgb(255,80,80)\'>no mercy</font>. Reach <font color=\'rgb(255,220,80)\'>Floor 50</font>, and I\'ll acknowledge your effort. Reach <font color=\'rgb(255,220,80)\'>Floor 100</font>, and I\'ll acknowledge you as my equal.",
        responses = { "Tell me about those swords.", "I\'ll return when I\'m stronger." },
        actions = { {
                goto = 7
            }, {
                hide = "... Good. Patience is a weapon too."
            } }
    },
    {
        text = "You\'ve carved your way to <font color=\'rgb(255,220,80)\'>Floor 50</font>. That\'s no small feat. For your perseverance, take these <font color=\'rgb(180,80,255)\'>10 Buff Potion Packages</font>. Let them fuel your climb to the summit.",
        responses = { "I\'ll take them.", "About those swords?", "Later." },
        actions = { {
                questReward = "EclipseBuffPotions"
            }, {
                goto = 7
            }, {
                hide = "... Don\'t be long."
            } }
    },
    {
        text = "You reached the <font color=\'rgb(255,220,80)\'>summit</font>. One hundred floors. One hundred bosses. You stand where few ever will. I grant you the title of <font color=\'rgb(180,80,255)\'>Centurion</font>. It was earned in blood.",
        responses = { "I accept the title.", "About those swords?", "Later." },
        actions = { {
                questReward = "EclipseCenturion"
            }, {
                goto = 7
            }, {
                hide = "... The summit waits for no one."
            } }
    },
    {
        text = "Reach <font color=\'rgb(255,220,80)\'>Floor 50</font> of the Boss Rush, and I\'ll gift you <font color=\'rgb(180,80,255)\'>10 Buff Potion Packages</font>. Clear <font color=\'rgb(255,220,80)\'>Floor 100</font>, and I\'ll grant you the title of <font color=\'rgb(180,80,255)\'>Centurion</font>. Earn them, and return to me.",
        responses = { "About those swords?", "I\'ll prove myself." },
        actions = { {
                goto = 7
            }, {
                hide = "... Then stop talking and start climbing."
            } }
    },
    {
        text = "<font color=\'rgb(180,80,255)\'>Centurion.</font> You\'ve walked the full path. There\'s nothing more I can give you. Only the swords remain, and those are not mine to grant. You\'ll have to earn them yourself.",
        responses = { "About those swords?", "Farewell." },
        actions = { {
                goto = 7
            }, {
                hide = "... Until we meet again."
            } }
    },
    {
        text = "Those blades aren\'t mine. They belong to someone who fought with <font color=\'rgb(255,80,80)\'>no magic</font> in a world that demanded it. They surface in the Boss Rush from <font color=\'rgb(255,220,80)\'>Floor 80</font> onward, but only for those with the strength to reach them.",
        responses = { "What are the exact chances?", "Back to the gauntlet.", "I\'ll keep my eyes open." },
        actions = { {
                goto = 8
            }, {
                goto = 2
            }, {
                hide = "... You should."
            } }
    },
    {
        text = "Clear <font color=\'rgb(255,220,80)\'>Floor 80</font> and the blades have a <font color=\'rgb(180,80,255)\'>5% chance</font> to appear. <font color=\'rgb(255,220,80)\'>Floor 90</font>: <font color=\'rgb(180,80,255)\'>15%</font>. <font color=\'rgb(255,220,80)\'>Floor 100</font>: <font color=\'rgb(180,80,255)\'>30%</font>. <font color=\'rgb(255,80,80)\'>But hear me:</font> if you <font color=\'rgb(255,80,80)\'>revive</font> during a run, the blades will <font color=\'rgb(255,80,80)\'>never</font> appear for you that session.",
        responses = { "Understood.", "Back to the gauntlet." },
        actions = { {
                hide = "... Discipline, not luck, wins the summit."
            }, {
                goto = 2
            } }
    }
};

function u1.getStartDialog(p2) -- Line: 167
    -- upvalues: Knit (copy), EclipseCenturion (copy), QuestRewardData (copy), EclipseBuffPotions (copy)
    local Registry = Knit.Registry;

    if not Registry then
        return 1;
    end;

    local v3 = Registry:Get("PlayerData");

    if not (v3 and v3.Data) then
        return 1;
    end;

    local v4 = v3.Data.CompletedQuests or {};
    local v5 = v4.EclipseBuffPotions == true;
    local v6 = v4.EclipseCenturion == true;

    return v5 and v6 and 6 or (EclipseCenturion and (not v6 and QuestRewardData.CheckConditions(EclipseCenturion, v3.Data)) and 4 or (EclipseBuffPotions and (not v5 and QuestRewardData.CheckConditions(EclipseBuffPotions, v3.Data)) and 3 or 1));
end;

function u1.onResponse(p7, p8, p9) -- Line: 197
    -- upvalues: u1 (copy), QuestRewardData (copy), Knit (copy)
    local v10 = u1.dialogs[p9];

    if not (v10 and v10.actions) then
        return "hide";
    end;

    local v11 = v10.actions[p8];

    if not v11 then
        return "hide";
    end;

    if v11.goto then
        return "goto", v11.goto, v11.quip;
    end;

    if not v11.questReward then
        if v11.hide then
            return "hide", v11.hide;
        end;

        return "hide";
    end;

    local questReward = v11.questReward;
    local v12 = QuestRewardData.Quests[questReward];
    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if not (Registry and (v12 and QuestRewardData.CheckConditions(v12, Registry.Data))) then
        return "goto", 5;
    end;

    if (Registry.Data.CompletedQuests or {})[questReward] then
        return "hide", "... You already claimed this one.";
    end;

    return "server", "QuestReward", {
        questId = questReward
    }, questReward == "EclipseCenturion" and "... Rise, Centurion." or "... Spend them wisely.";
end;

function u1.onServerResult(p13, p14, p15, p16) -- Line: 231
    if p15 ~= "QuestReward" then
        return;
    end;

    if not p16 then
        return;
    end;

    if p16.success then
        print("[Eclipse] Quest reward granted:", p16.questId);

        return;
    end;

    warn("[Eclipse] Quest reward failed:", p16.reason);
end;

return u1;