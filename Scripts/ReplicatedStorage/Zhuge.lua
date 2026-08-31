--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Zhuge
  Path:     game.ReplicatedStorage.DialogueData.Zhuge
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
    npcName = "Zhuge",
    animation = nil
};

local function ownsClassItem(p2, p3) -- Line: 49
    local ClassItems = p2.ClassItems;

    if not ClassItems then
        return false;
    end;

    for _, v in ClassItems do
        if v == p3 then
            return true;
        end;
    end;

    return false;
end;

u1.dialogs = {
    {
        text = "The path draws warriors of many shapes. Tell me, are you here seeking strength, or merely passing beneath the blossoms?",
        responses = { "Who are you?", "I seek the Onyx Hand Fans.", "Just passing through." },
        actions = { {
                goto = 2
            }, {
                goto = 6
            }, {
                hide = "Then may the wind carry you well."
            } }
    },
    {
        text = "I am <font color=\'rgb(255,80,100)\'>Zhuge</font>. I keep relics that do not belong to the idle, weapons that chose their wielders long before you were born. If you have walked far enough, perhaps one of them will answer your hand.",
        responses = { "Tell me about the Onyx Hand Fans.", "I\'ll consider it." },
        actions = { {
                goto = 6
            }, {
                hide = "Take your time. The relics are patient, I am less so."
            } }
    },
    {
        text = "The <font color=\'rgb(255,220,80)\'>Prisma Stone</font> adorns the wielder\'s fists with prismatic claws, each slash tears a rift in reality itself. To prove you are worthy of the <font color=\'rgb(180,80,255)\'>Prisma</font> class, bring me <font color=\'rgb(255,80,100)\'>30 Purity Stones</font>, reach <font color=\'rgb(255,220,80)\'>Level 50</font>, and offer <font color=\'rgb(255,220,80)\'>50,000 Coins</font> as tribute.",
        responses = { "I have everything you need.", "Where do I find Purity Stones?", "Not yet." },
        actions = { {
                questReward = "ZhugePrismaStone"
            }, {
                goto = 4
            }, {
                hide = "Return when the stones hum in your hands."
            } }
    },
    {
        text = "The <font color=\'rgb(255,80,100)\'>Purity Stone</font> is a crystallized fragment of untouched light. You will find them by slaying the <font color=\'rgb(100,200,255)\'>Wayfarers</font>, <font color=\'rgb(100,200,255)\'>Vikings</font>, and <font color=\'rgb(100,200,255)\'>Tribal Archers</font> of the <font color=\'rgb(100,200,255)\'>Frostspire</font>, but only on <font color=\'rgb(255,80,100)\'>Nightmare</font> difficulty. A rare drop. Prepare for many runs.",
        responses = { "Back to the quest.", "Understood." },
        actions = { {
                goto = 3
            }, {
                hide = "May clarity guide your blade."
            } }
    },
    {
        text = "You lack what is required. Return when you have reached <font color=\'rgb(255,220,80)\'>Level 50</font>, gathered <font color=\'rgb(255,80,100)\'>30 Purity Stones</font>, and brought <font color=\'rgb(255,220,80)\'>50,000 Coins</font> as tribute.",
        responses = { "Where do I find Purity Stones?", "I understand." },
        actions = { {
                goto = 4
            }, {
                hide = "The stone will wait. But not forever."
            } }
    },
    {
        text = "The <font color=\'rgb(255,220,80)\'>Onyx Hand Fans</font> command slashing winds that answer to no storm. To earn the <font color=\'rgb(180,80,255)\'>Nightbloom</font> class, bring me <font color=\'rgb(255,80,100)\'>30 Corrupted Feathers</font>, reach <font color=\'rgb(255,220,80)\'>Level 60</font>, and offer <font color=\'rgb(255,220,80)\'>90,000 Coins</font> as tribute.",
        responses = { "I have everything you need.", "Where do I find Corrupted Feathers?", "Not yet." },
        actions = { {
                questReward = "ZhugeOnyxFans"
            }, {
                goto = 7
            }, {
                hide = "Return when the feathers whisper your name."
            } }
    },
    {
        text = "The <font color=\'rgb(255,80,100)\'>Corrupted Feather</font> falls from the wings of demonkind. Slay the <font color=\'rgb(100,200,255)\'>Daemons</font>, <font color=\'rgb(100,200,255)\'>Rogue Daemons</font>, and <font color=\'rgb(100,200,255)\'>Archer Daemons</font> in the <font color=\'rgb(100,200,255)\'>Underworld</font> on <font color=\'rgb(255,80,100)\'>Normal</font> difficulty or above. The feathers are uncommon, patience will serve you.",
        responses = { "Back to the quest.", "Understood." },
        actions = { {
                goto = 6
            }, {
                hide = "May the wind answer your call."
            } }
    },
    {
        text = "You lack what is required. Return when you have reached <font color=\'rgb(255,220,80)\'>Level 60</font>, gathered <font color=\'rgb(255,80,100)\'>30 Corrupted Feathers</font>, and brought <font color=\'rgb(255,220,80)\'>90,000 Coins</font> as tribute.",
        responses = { "Where do I find Corrupted Feathers?", "I understand." },
        actions = { {
                goto = 7
            }, {
                hide = "The fans will wait. But not forever."
            } }
    },
    {
        text = "Both relics have found their wielder. The prismatic edge and the howling wind, few carry both. You have earned my respect.",
        responses = { "Thank you, Zhuge." },
        actions = { {
                hide = "Walk well. The blossoms remember those who earned their shade."
            } }
    }
};

function u1.getStartDialog(p4) -- Line: 185
    return 1;
end;

function u1.onResponse(p5, p6, p7) -- Line: 194
    -- upvalues: u1 (copy), Knit (copy), QuestRewardData (copy)
    local v8 = u1.dialogs[p7];

    if not (v8 and v8.actions) then
        return "hide";
    end;

    local v9 = v8.actions[p6];

    if not v9 then
        return "hide";
    end;

    if not v9.goto then
        if not v9.questReward then
            if v9.hide then
                return "hide", v9.hide;
            end;

            return "hide";
        end;

        local Registry = Knit.Registry;

        if Registry then
            Registry = Registry:Get("PlayerData");
        end;

        if not Registry then
            return "goto", 5;
        end;

        local v10 = QuestRewardData.Quests[v9.questReward];

        if v10 and QuestRewardData.CheckConditions(v10, Registry.Data) then
            return "server", "QuestReward", {
                questId = v9.questReward
            }, v9.questReward == "ZhugePrismaStone" and "The tear in reality blooms. You are now the Prisma." or "The wind obeys. You are now the Nightbloom.";
        end;

        if v9.questReward == "ZhugePrismaStone" then
            return "goto", 5;
        end;

        return "goto", 8;
    end;

    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if Registry then
        local Data = Registry.Data;

        if v9.goto == 3 then
            local ClassItems = Data.ClassItems;
            local v11;

            if ClassItems then
                v11 = false;

                for _, v in ClassItems do
                    if v == "Prisma Stone" then
                        v11 = true;
                        break;
                    end;
                end;
            else
                v11 = false;
            end;

            if v11 then
                return "hide", "The prismatic edge already answers to you.";
            end;
        end;

        if v9.goto == 6 then
            local ClassItems = Data.ClassItems;
            local v12;

            if ClassItems then
                v12 = false;

                for _, v in ClassItems do
                    if v == "Onyx Hand Fans" then
                        v12 = true;
                        break;
                    end;
                end;
            else
                v12 = false;
            end;

            if v12 then
                return "hide", "The fans already sing to your hand.";
            end;
        end;
    end;

    return "goto", v9.goto, v9.quip;
end;

function u1.onServerResult(p13, p14, p15, p16) -- Line: 248
    if p15 ~= "QuestReward" then
        return;
    end;

    if not p16 then
        return;
    end;

    if p16.success then
        print((`[Zhuge] Quest reward '{p16.questId}' granted successfully!`));

        return;
    end;

    warn((`[Zhuge] Quest reward failed: {p16.reason}`));
end;

return u1;