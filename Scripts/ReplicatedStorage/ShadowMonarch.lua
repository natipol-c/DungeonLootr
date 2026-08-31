--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ShadowMonarch
  Path:     game.ReplicatedStorage.DialogueData.ShadowMonarch
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
    npcName = "Shadow Monarch",
    animation = nil
};
local ShadowMonarchBlackHeart = QuestRewardData.Quests.ShadowMonarchBlackHeart;
u1.dialogs = {
    {
        text = "You stand before the throne of shadows. Speak quickly. Eternity is patient, but I am not.",
        responses = { "I seek your power.", "What\'s happening to the game?", "I\'ll leave you alone." },
        actions = { {
                classOffer = true
            }, {
                goto = 5
            }, {
                hide = "Then go."
            } }
    },
    {
        text = "<font color=\'rgb(180,80,255)\'>The Black Heart</font>. The Demon King\'s pulse, condensed into a single shard of midnight. It beats only for those strong enough to bear its weight, and you have walked far enough to be heard. Take it, and you will move between worlds as I do.",
        responses = { "I accept.", "Not yet." },
        actions = { {
                questReward = "ShadowMonarchBlackHeart"
            }, {
                hide = "Return when you are certain."
            } }
    },
    {
        text = "Not yet, mortal. The Heart will burn through any vessel less than <font color=\'rgb(255,220,80)\'>Level 50</font>. Climb. Bleed. When you are forged, return, and the shadows will remember your name.",
        responses = { "I\'ll grow stronger." },
        actions = { {
                hide = "I will be waiting."
            } }
    },
    {
        text = "The Heart already beats within you. Wield its silence well.",
        responses = { "Farewell." },
        actions = { {
                hide = "..."
            } }
    },
    {
        text = "This world is ending. On the <font color=\'rgb(255,220,80)\'>first day of the fifth month, at the tenth hour past dawn</font>, <font color=\'rgb(180,80,255)\'>May 1st, 10:00 AM PST</font>, the gates close. What rises in its place will be remade from the ground up. Bone, shadow, and sinew. A complete rewrite of all that was.",
        responses = { "What happens to my Gamepasses?", "How can I help?", "Other questions.", "I\'ll leave you alone." },
        actions = { {
                goto = 6
            }, {
                goto = 7
            }, {
                goto = 1
            }, {
                hide = "Then go."
            } }
    },
    {
        text = "You ask about the tributes you have offered. I will return what I can, but the new world has little patience for old chains. <font color=\'rgb(255,100,100)\'>Most of what was bound to you will be unmade</font>, for the rewrite cannot carry the weight of all that came before. I cannot promise more, only that I will fight for as much as it allows.",
        responses = { "How can I help?", "Tell me about the rewrite again.", "Other questions.", "I\'ll leave you alone." },
        actions = { {
                goto = 7
            }, {
                goto = 5
            }, {
                goto = 1
            }, {
                hide = "Then go."
            } }
    },
    {
        text = "Endure. Stand with me until the <font color=\'rgb(255,220,80)\'>first day of the sixth month</font>, <font color=\'rgb(180,80,255)\'>June 1st</font>. Have faith. The shadows remember those who waited.",
        responses = { "I\'ll be there.", "Other questions.", "I\'ll leave you alone." },
        actions = { {
                hide = "Good. Rise on that day."
            }, {
                goto = 1
            }, {
                hide = "Then go."
            } }
    }
};

local function PlayerOwnsRewardItem(p2) -- Line: 154
    local ClassItems = p2.ClassItems;

    if not ClassItems then
        return false;
    end;

    for _, v in ClassItems do
        if v == "Black Heart" then
            return true;
        end;
    end;

    return false;
end;

function u1.getStartDialog(p3) -- Line: 170
    return 1;
end;

function u1.onResponse(p4, p5, p6) -- Line: 176
    -- upvalues: u1 (copy), Knit (copy), ShadowMonarchBlackHeart (copy), QuestRewardData (copy)
    local v7 = u1.dialogs[p6];

    if not (v7 and v7.actions) then
        return "hide";
    end;

    local v8 = v7.actions[p5];

    if not v8 then
        return "hide";
    end;

    if not v8.classOffer then
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

        if Registry and (ShadowMonarchBlackHeart and QuestRewardData.CheckConditions(ShadowMonarchBlackHeart, Registry.Data)) then
            return "server", "QuestReward", {
                questId = v8.questReward
            }, "Rise, sovereign.";
        end;

        return "goto", 3;
    end;

    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if Registry then
        Registry = Registry.Data;
    end;

    if Registry then
        local ClassItems = Registry.ClassItems;
        local v9;

        if ClassItems then
            v9 = false;

            for _, v in ClassItems do
                if v == "Black Heart" then
                    v9 = true;
                    break;
                end;
            end;
        else
            v9 = false;
        end;

        if v9 then
            return "goto", 4;
        end;
    end;

    if ShadowMonarchBlackHeart and (Registry and QuestRewardData.CheckConditions(ShadowMonarchBlackHeart, Registry)) then
        return "goto", 2;
    end;

    return "goto", 3;
end;

function u1.onServerResult(p10, p11, p12, p13) -- Line: 223
    if p12 ~= "QuestReward" then
        return;
    end;

    if not p13 or p13.questId ~= "ShadowMonarchBlackHeart" then
        return;
    end;

    if p13.success then
        print("[ShadowMonarch] Black Heart granted.");

        return;
    end;

    warn("[ShadowMonarch] Quest reward failed:", p13.reason);
end;

return u1;