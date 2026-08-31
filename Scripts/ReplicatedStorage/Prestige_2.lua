--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Prestige
  Path:     game.ReplicatedStorage.DialogueData.Prestige
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
local PrestigeData = require(ReplicatedStorage.GameInfo.PrestigeData);
local u3 = {
    npcName = "Prestige",
    animation = nil,
    dialogs = {
        {
            text = "Hey, looks like your class is maxed out. Want to prestige it? Costs <font color=\'rgb(255,220,80)\'>100,000 Coins</font>, and you\'ll walk away with <font color=\'rgb(255,220,80)\'>5 Skill Tokens</font> for that class.",
            responses = { "Wait, what happens?", "Yeah, let\'s do it.", "Maybe later." },
            actions = { {
                    goto = 2
                }, {
                    goto = 3
                }, {
                    hide = "Cool, come back whenever."
                } }
        },
        {
            text = "Sure, here\'s the deal. Your class level drops back to <font color=\'rgb(255,220,80)\'>1</font>, but you keep every Mastery bonus you\'ve already unlocked. You get <font color=\'rgb(255,220,80)\'>5 Skill Tokens</font> to spend on that class\'s skills or its Mastery track.\n\nOne catch: a class can only hold <font color=\'rgb(255,220,80)\'>10 Skill Tokens</font> total, so if you want to fully juice it you\'ll need to prestige twice. And yeah, the class has to be at <font color=\'rgb(255,220,80)\'>Level 50</font> each time.",
            responses = { "Alright, let\'s do it.", "Eh, let me think." },
            actions = { {
                    goto = 3
                }, {
                    hide = "No rush."
                } }
        },
        {
            text = "Quick confirmation, <font color=\'rgb(255,80,80)\'>100,000 Coins</font> gone, class level drops to <font color=\'rgb(255,80,80)\'>1</font>. You good?",
            responses = { "Do it.", "Actually, nah." },
            actions = { {
                    prestige = true
                }, {
                    hide = "Fair enough."
                } }
        },
        {
            text = "Your class isn\'t at <font color=\'rgb(255,220,80)\'>Level 50</font> yet. Come back when it is and we\'ll get this sorted.",
            responses = { "Got it." },
            actions = { {
                    hide = "Keep grinding."
                } }
        },
        {
            text = "You\'re good to prestige, but you\'re short on coins. Costs <font color=\'rgb(255,220,80)\'>100,000</font>, come back when you\'ve got it.",
            responses = { "I\'ll come back." },
            actions = { {
                    hide = "Go earn some coins."
                } }
        }
    },

    getStartDialog = function(p1) -- Line: 103, Name: getStartDialog
        -- upvalues: Knit (copy), QuestRewardData (copy), PrestigeData (copy)
        local Registry = Knit.Registry;

        if not Registry then
            return 4;
        end;

        local v2 = Registry:Get("PlayerData");

        if not v2 then
            return 4;
        end;

        local Data = v2.Data;

        return QuestRewardData.CheckConditions({
            Conditions = { {
                    Type = "CanPrestigeActiveClass"
                } }
        }, Data) and ((Data.Currency or 0) < PrestigeData.NPC_COIN_COST and 5 or 1) or 4;
    end
};

function u3.onResponse(p4, p5, p6) -- Line: 129
    -- upvalues: u3 (copy), Knit (copy), QuestRewardData (copy), PrestigeData (copy)
    local v7 = u3.dialogs[p6];

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

    if not v8.prestige then
        if v8.hide then
            return "hide", v8.hide;
        end;

        return "hide";
    end;

    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if not Registry then
        return "hide";
    end;

    local Data = Registry.Data;

    if not QuestRewardData.CheckConditions({
        Conditions = { {
                Type = "CanPrestigeActiveClass"
            } }
    }, Data) then
        return "goto", 4;
    end;

    if (Data.Currency or 0) < PrestigeData.NPC_COIN_COST then
        return "goto", 5;
    end;

    return "server", "Prestige", {}, "Alright, here we go...";
end;

function u3.onServerResult(p9, p10, p11, p12) -- Line: 171
    if p11 ~= "Prestige" then
        return;
    end;

    if not p12 then
        return;
    end;

    if p12.success then
        print(string.format("[Prestige] %s prestiged, Prestige #%d, +%d Skill Tokens.", tostring(p12.className), tonumber(p12.prestiges) or 0, tonumber(p12.tokensGranted) or 0));

        return;
    end;

    warn("[Prestige] Prestige failed:", p12.reason);
end;

return u3;