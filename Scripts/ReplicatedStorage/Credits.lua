--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Credits
  Path:     game.ReplicatedStorage.DialogueData.Credits
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    npcName = "Credits",
    animation = nil,
    dialogs = {
        {
            text = "Hey! This board is here to give credit where credit is due. A lot of love went into this game, and some of that came from the community.",
            responses = { "What open source assets are used?", "I think my asset was used." },
            actions = { {
                    goto = 2
                }, {
                    goto = 3
                } }
        },
        {
            text = "Some of the <font color=\'rgb(255,220,80)\'>VFX</font>, <font color=\'rgb(255,220,80)\'>sounds</font>, and <font color=\'rgb(255,220,80)\'>models</font> used in the game are open source assets created by talented community members. We appreciate everyone who makes their work available for others to build on!",
            responses = { "I think my asset was used.", "Cool, thanks!" },
            actions = { {
                    goto = 3
                }, {
                    hide = "Thanks for checking in!"
                } }
        },
        {
            text = "If you believe your asset was used in the game and you\'d like to be properly credited for your work, please join our Discord and open a <font color=\'rgb(180,80,255)\'>#support-ticket</font>. We\'ll make sure you get the credit you deserve!\n\nDiscord: <font color=\'rgb(100,150,255)\'>discord.com/invite/aXXGe2gG8A</font>",
            responses = { "What open source assets are used?", "Got it, thanks!" },
            actions = { {
                    goto = 2
                }, {
                    hide = "Thanks for reaching out! We\'ll get you credited."
                } }
        }
    }
};

function u1.onResponse(p2, p3, p4) -- Line: 70
    -- upvalues: u1 (copy)
    local v5 = u1.dialogs[p4];

    if not (v5 and v5.actions) then
        return "hide";
    end;

    local v6 = v5.actions[p3];

    if not v6 then
        return "hide";
    end;

    if v6.goto then
        return "goto", v6.goto, v6.quip;
    end;

    if v6.hide then
        return "hide", v6.hide;
    end;

    return "hide";
end;

return u1;