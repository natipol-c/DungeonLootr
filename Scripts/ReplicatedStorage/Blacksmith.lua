--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Blacksmith
  Path:     game.ReplicatedStorage.DialogueData.Blacksmith
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    npcName = "Blacksmith",
    animation = nil,
    dialogs = {
        {
            text = "Need something <font color=\'rgb(255,150,50)\'>forged</font>? Or just here to chat?",
            responses = { "Tell me about weapons.", "Any tips for a beginner?", "See ya." },
            actions = { {
                    goto = 2
                }, {
                    goto = 4
                }, {
                    hide = "Don\'t be a stranger!"
                } }
        },
        {
            text = "Every weapon has a <font color=\'rgb(255,220,80)\'>soul</font>. The more you upgrade it, the stronger that soul becomes. But be careful... upgrades can fail.",
            responses = { "How do I upgrade safely?", "That sounds risky...", "Go back" },
            actions = { {
                    goto = 3
                }, {
                    hide = "Hah! Risk is what makes it exciting."
                }, {
                    goto = 1
                } }
        },
        {
            text = "Protection scrolls are your best friend. They prevent your weapon from <font color=\'rgb(255,80,80)\'>breaking</font> on a failed upgrade. Trust me, you don\'t want to learn that the hard way.",
            responses = { "Good to know!" },
            actions = { {
                    hide = "Now get out there and make something legendary!"
                } }
        },
        {
            text = "Here\'s what I tell every newcomer: clear dungeons, collect heroes, and don\'t forget to lock your base. Thieves are everywhere!",
            responses = { "Thanks for the advice!" },
            actions = { {
                    hide = "Anytime, kid. Now go get \'em!"
                } }
        }
    }
};

function u1.onResponse(p2, p3, p4) -- Line: 85
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