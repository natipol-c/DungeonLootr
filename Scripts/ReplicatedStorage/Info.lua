--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Info
  Path:     game.ReplicatedStorage.DialogueData.Info
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    npcName = "Info",
    animation = nil,
    dialogs = {
        {
            text = "Hey! Want to know about something?",
            responses = { "What do I get from doing Dungeons?", "Can my friends join me in Dungeons?", "How do I get loot chests?", "Sorry, nevermind!" },
            actions = { {
                    goto = 2
                }, {
                    goto = 3
                }, {
                    goto = 4
                }, {
                    hide = "Come back anytime!"
                } }
        },
        {
            text = "Doing dungeons earns you Coins, Stars, Crafting materials and even loot chests if you defeat the boss!",
            responses = { "very cool!", "thanks!" },
            actions = { {
                    hide = "Come back anytime!"
                }, {
                    hide = "Come back anytime!"
                } }
        },
        {
            text = "Anyone can join a freshly started dungeon within the first 30 seconds of it starting!",
            responses = { "very cool!", "thanks!" },
            actions = { {
                    hide = "Come back anytime!"
                }, {
                    hide = "Come back anytime!"
                } }
        },
        {
            text = "Loot chests can be obtained from doing Dungeons, getting 1st or 2nd place in killing NPC\'s, completing quests, and even claiming achievements!",
            responses = { "very cool!", "thanks!" },
            actions = { {
                    hide = "Come back anytime!"
                }, {
                    hide = "Come back anytime!"
                } }
        }
    }
};

function u1.onResponse(p2, p3, p4) -- Line: 90
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