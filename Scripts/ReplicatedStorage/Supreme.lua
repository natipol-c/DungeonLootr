--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Supreme
  Path:     game.ReplicatedStorage.DialogueData.Supreme
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
    npcName = "Broly",
    animation = nil
};
local SupremeWarrior100 = QuestRewardData.Quests.SupremeWarrior100;
local SupremeWarrior800 = QuestRewardData.Quests.SupremeWarrior800;
local SupremeWarrior1000 = QuestRewardData.Quests.SupremeWarrior1000;
local SupremeWarrior1500 = QuestRewardData.Quests.SupremeWarrior1500;

local function GetPVPStats() -- Line: 64
    -- upvalues: Knit (copy)
    local Registry = Knit.Registry;

    if not Registry then
        return 0, 0;
    end;

    local v2 = Registry:Get("PlayerData");

    if not (v2 and (v2.Data and v2.Data.Stats)) then
        return 0, 0;
    end;

    local Stats = v2.Data.Stats;

    return Stats.PVPKills or 0, Stats.PVPDeaths or 0;
end;

local function RefreshStatsText(p3) -- Line: 77
    -- upvalues: Knit (copy), u1 (copy)
    local Registry = Knit.Registry;
    local v4, v5;

    if Registry then
        local v6 = Registry:Get("PlayerData");

        if v6 and (v6.Data and v6.Data.Stats) then
            local Stats = v6.Data.Stats;
            v4 = Stats.PVPKills or 0;
            v5 = Stats.PVPDeaths or 0;
        else
            v4 = 0;
            v5 = 0;
        end;
    else
        v4 = 0;
        v5 = 0;
    end;

    local string_format_ret = string.format("<font color=\'rgb(180,255,60)\'>Hmph.</font> You have killed <font color=\'rgb(255,80,80)\'>%d</font>. You have died <font color=\'rgb(150,150,150)\'>%d</font> times. Blood, flesh, bone. <font color=\'rgb(255,220,80)\'>That is all that matters.</font>", v4, v5);
    u1.dialogs[3].text = string_format_ret;

    if p3 and (p3.dialogs and p3.dialogs[3]) then
        p3.dialogs[3].text = string_format_ret;
    end;
end;

u1.dialogs = {
    {
        text = "<font color=\'rgb(180,255,60)\'>RRRAAAH...</font> You stand before me. Breathing. Weak. Show me you are not <font color=\'rgb(255,80,80)\'>worthless</font>.",
        responses = { "Who are you?", "Show me my kills.", "What do you want from me?", "I\'m leaving." },
        actions = { {
                goto = 2
            }, {
                goto = 3
            }, {
                goto = 4
            }, {
                hide = "<font color=\'rgb(180,255,60)\'>Hmph.</font> Run, then. Cowards always run."
            } }
    },
    {
        text = "I am <font color=\'rgb(180,255,60)\'>Broly</font>. I was left to rot on a dead rock. Alone. Hungry. I ate stone. I broke bone. I grew <font color=\'rgb(255,80,80)\'>strong</font>. Now I watch the weak fight. Sometimes... sometimes one is not so weak.",
        responses = { "What do you offer me?", "Show me my kills.", "I\'ll prove I\'m strong." },
        actions = { {
                goto = 4
            }, {
                goto = 3
            }, {
                hide = "<font color=\'rgb(180,255,60)\'>Tch.</font> Words. Come back with <font color=\'rgb(255,80,80)\'>blood</font>."
            } }
    },
    {
        text = "...",
        responses = { "What can I earn?", "Back.", "Enough." },
        actions = { {
                goto = 4
            }, {
                goto = 1
            }, {
                hide = "<font color=\'rgb(180,255,60)\'>Go. Kill more.</font>"
            } }
    },
    {
        text = "<font color=\'rgb(180,255,60)\'>Listen.</font> Four trophies. <font color=\'rgb(255,220,80)\'>100 dead</font>, a warrior\'s armor. <font color=\'rgb(255,220,80)\'>800 dead</font>, the dark twin. <font color=\'rgb(255,220,80)\'>1000 dead</font>, my aura on your skin. <font color=\'rgb(255,220,80)\'>1500 dead</font>, a name carved in <font color=\'rgb(255,80,80)\'>green fire</font>. Earn them, or do not speak to me.",
        responses = { "Show me my kills.", "I\'ll return with blood." },
        actions = { {
                goto = 3
            }, {
                hide = "<font color=\'rgb(180,255,60)\'>Good. Now go break something.</font>"
            } }
    },
    {
        text = "<font color=\'rgb(255,220,80)\'>100.</font> You have killed <font color=\'rgb(255,220,80)\'>100</font>. Hmph. Not worthless. Here. The <font color=\'rgb(180,80,255)\'>Supreme Warrior Package</font>. Wear it. Let them see you coming.",
        responses = { "Give it to me.", "Show me my kills first.", "Later." },
        actions = { {
                questReward = "SupremeWarrior100"
            }, {
                goto = 3
            }, {
                hide = "<font color=\'rgb(180,255,60)\'>Tch.</font> Pride? Fine. Go."
            } }
    },
    {
        text = "<font color=\'rgb(255,80,80)\'>800.</font> Still breathing. Still killing. Good. Take the <font color=\'rgb(180,80,255)\'>Alt Supreme Warrior Package</font>. Darker. Uglier. Like you when the blood dries.",
        responses = { "Give it.", "Show me my kills first.", "Not yet." },
        actions = { {
                questReward = "SupremeWarrior800"
            }, {
                goto = 3
            }, {
                hide = "<font color=\'rgb(180,255,60)\'>Hmph.</font> Then keep killing."
            } }
    },
    {
        text = "<font color=\'rgb(180,255,60)\'>ONE. THOUSAND.</font> The ground remembers your feet. Take this. <font color=\'rgb(180,255,60)\'>My aura.</font> It will wrap you like it wraps me. The weak will feel it in their bones before they see you.",
        responses = { "I\'ll take the aura.", "Show me my kills first.", "Not now." },
        actions = { {
                questReward = "SupremeWarrior1000"
            }, {
                goto = 3
            }, {
                hide = "<font color=\'rgb(180,255,60)\'>Go. The aura waits.</font>"
            } }
    },
    {
        text = "<font color=\'rgb(255,255,100)\'>1500.</font> You... you are like me. Hnngh. A monster. A killer. A <font color=\'rgb(180,255,60)\'>Supreme Being</font>. Take the name. Burn it into them. Let them remember who walked past their corpses.",
        responses = { "I accept the name.", "Show me my kills first.", "I need a moment." },
        actions = { {
                questReward = "SupremeWarrior1500"
            }, {
                goto = 3
            }, {
                hide = "<font color=\'rgb(180,255,60)\'>Hmph.</font> The name will wait. Not long."
            } }
    },
    {
        text = "<font color=\'rgb(180,255,60)\'>You.</font> Armor. Twin. Aura. Name. All of it. There is nothing left for me to give. Only the blood you take from here on. <font color=\'rgb(255,80,80)\'>Keep taking it.</font>",
        responses = { "Show me my kills.", "Farewell, Broly." },
        actions = { {
                goto = 3
            }, {
                hide = "<font color=\'rgb(180,255,60)\'>RRRAAAH.</font> Walk, Supreme Being."
            } }
    },
    {
        text = "<font color=\'rgb(180,255,60)\'>Tch.</font> Not enough. <font color=\'rgb(255,80,80)\'>100</font> dead. That is the smallest price. Bring me <font color=\'rgb(255,80,80)\'>100 dead</font>, and we will speak of trophies.",
        responses = { "Show me my kills.", "I\'ll be back." },
        actions = { {
                goto = 3
            }, {
                hide = "<font color=\'rgb(180,255,60)\'>Go. Kill. Return.</font>"
            } }
    }
};

function u1.getStartDialog(p7) -- Line: 243
    -- upvalues: Knit (copy), SupremeWarrior1500 (copy), QuestRewardData (copy), SupremeWarrior1000 (copy), SupremeWarrior800 (copy), SupremeWarrior100 (copy)
    local Registry = Knit.Registry;

    if not Registry then
        return 1;
    end;

    local v8 = Registry:Get("PlayerData");

    if not (v8 and v8.Data) then
        return 1;
    end;

    local v9 = v8.Data.CompletedQuests or {};
    local v10 = v9.SupremeWarrior100 == true;
    local v11 = v9.SupremeWarrior800 == true;
    local v12 = v9.SupremeWarrior1000 == true;
    local v13 = v9.SupremeWarrior1500 == true;

    return v10 and (v11 and (v12 and v13)) and 9 or (SupremeWarrior1500 and (not v13 and QuestRewardData.CheckConditions(SupremeWarrior1500, v8.Data)) and 8 or (SupremeWarrior1000 and (not v12 and QuestRewardData.CheckConditions(SupremeWarrior1000, v8.Data)) and 7 or (SupremeWarrior800 and (not v11 and QuestRewardData.CheckConditions(SupremeWarrior800, v8.Data)) and 6 or (SupremeWarrior100 and (not v10 and QuestRewardData.CheckConditions(SupremeWarrior100, v8.Data)) and 5 or 1))));
end;

function u1.onResponse(p14, p15, p16) -- Line: 282
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy)
    local v17 = u1.dialogs[p16];

    if not (v17 and v17.actions) then
        return "hide";
    end;

    local v18 = v17.actions[p15];

    if not v18 then
        return "hide";
    end;

    if v18.goto == 3 then
        if p14 then
            p14 = p14.dialogObject;
        end;

        local Registry = Knit.Registry;
        local v19, v20;

        if Registry then
            local v21 = Registry:Get("PlayerData");

            if v21 and (v21.Data and v21.Data.Stats) then
                local Stats = v21.Data.Stats;
                v19 = Stats.PVPKills or 0;
                v20 = Stats.PVPDeaths or 0;
            else
                v19 = 0;
                v20 = 0;
            end;
        else
            v19 = 0;
            v20 = 0;
        end;

        local string_format_ret = string.format("<font color=\'rgb(180,255,60)\'>Hmph.</font> You have killed <font color=\'rgb(255,80,80)\'>%d</font>. You have died <font color=\'rgb(150,150,150)\'>%d</font> times. Blood, flesh, bone. <font color=\'rgb(255,220,80)\'>That is all that matters.</font>", v19, v20);
        u1.dialogs[3].text = string_format_ret;

        if p14 and (p14.dialogs and p14.dialogs[3]) then
            p14.dialogs[3].text = string_format_ret;
        end;
    end;

    if v18.goto then
        return "goto", v18.goto, v18.quip;
    end;

    if not v18.questReward then
        if v18.hide then
            return "hide", v18.hide;
        end;

        return "hide";
    end;

    local questReward = v18.questReward;
    local v22 = QuestRewardData.Quests[questReward];
    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if not (Registry and (v22 and QuestRewardData.CheckConditions(v22, Registry.Data))) then
        return "goto", 10;
    end;

    if (Registry.Data.CompletedQuests or {})[questReward] then
        return "hide", "<font color=\'rgb(180,255,60)\'>Already yours. Move on.</font>";
    end;

    return "server", "QuestReward", {
        questId = questReward
    }, questReward == "SupremeWarrior1500" and "<font color=\'rgb(180,255,60)\'>RRRAAAH. Walk, Supreme Being.</font>" or (questReward == "SupremeWarrior1000" and "<font color=\'rgb(180,255,60)\'>Wear it. Let them feel it.</font>" or (questReward == "SupremeWarrior800" and "<font color=\'rgb(180,255,60)\'>Good. Keep killing.</font>" or "<font color=\'rgb(180,255,60)\'>Hmph. Wear it with pride.</font>"));
end;

function u1.onServerResult(p23, p24, p25, p26) -- Line: 327
    if p25 ~= "QuestReward" then
        return;
    end;

    if not p26 then
        return;
    end;

    if p26.success then
        print("[Supreme] Quest reward granted:", p26.questId);

        return;
    end;

    warn("[Supreme] Quest reward failed:", p26.reason);
end;

return u1;