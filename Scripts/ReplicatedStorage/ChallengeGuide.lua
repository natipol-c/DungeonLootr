--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ChallengeGuide
  Path:     game.ReplicatedStorage.DialogueData.ChallengeGuide
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local u2 = {
    npcName = "Challenge Guide",
    animation = nil,
    dialogs = {
        {
            text = "Welcome to the <font color=\'rgb(255,177,82)\'>Challenge Dungeon</font>. It is an endless test of survival against a boss and its army. Push as deep as you can. What would you like to know?",
            responses = { "How does the timer work?", "Tell me about the waves.", "What do I earn along the way?", "How are my scores saved?", "How do I get in?" },
            actions = { {
                    goto = 2
                }, {
                    goto = 3
                }, {
                    goto = 4
                }, {
                    goto = 7
                }, {
                    goto = 6
                } }
        },
        {
            text = "You start with <font color=\'rgb(255,177,82)\'>one minute</font> on the clock, and it is always ticking down. Every enemy you kill adds <font color=\'rgb(100,255,100)\'>1.5 seconds</font>, and every boss adds <font color=\'rgb(100,255,100)\'>5 seconds</font>. Every <font color=\'rgb(255,177,82)\'>10th wave</font> the clock also refills to a full minute. When it hits zero, the run ends and your loot is banked.",
            responses = { "Tell me about the waves.", "Back to topics.", "Got it, thanks!" },
            actions = { {
                    goto = 3
                }, {
                    goto = 1
                }, {
                    hide = "Keep that clock full!"
                } }
        },
        {
            text = "Each wave spawns all at once. Clear the last enemy and the next wave begins instantly, no rest. Every <font color=\'rgb(255,177,82)\'>5 waves</font> the enemies grow <font color=\'rgb(255,100,100)\'>10% stronger</font>, and every <font color=\'rgb(255,177,82)\'>10th wave</font> the featured boss joins the fight.",
            responses = { "What do I earn along the way?", "Back to topics.", "Got it, thanks!" },
            actions = { {
                    goto = 4
                }, {
                    goto = 1
                }, {
                    hide = "Stay sharp out there!"
                } }
        },
        {
            text = "Every <font color=\'rgb(255,177,82)\'>5 waves</font>, <font color=\'rgb(255,220,80)\'>3 chests</font> appear for you to loot. Every <font color=\'rgb(255,177,82)\'>10th wave</font>, you choose a <font color=\'rgb(180,80,255)\'>Blessing</font> to power up your run. Grab both whenever you can, they get you deeper.",
            responses = { "What happens if I die?", "Back to topics.", "Got it, thanks!" },
            actions = { {
                    goto = 5
                }, {
                    goto = 1
                }, {
                    hide = "Claim every reward!"
                } }
        },
        {
            text = "You get <font color=\'rgb(255,220,80)\'>3 lives</font>. Run out and you drop into <font color=\'rgb(180,180,180)\'>spectator mode</font>, watching your party fight on. You can pay <font color=\'rgb(100,255,100)\'>Robux</font> to revive and rejoin. Leaving is always your own choice, no one can pull you out.",
            responses = { "How do I get in?", "Back to topics.", "Got it, thanks!" },
            actions = { {
                    goto = 6
                }, {
                    goto = 1
                }, {
                    hide = "Make those lives count!"
                } }
        },
        {
            text = "Look for the <font color=\'rgb(255,177,82)\'>golden pods</font>. Step on one to open the Challenge menu, then pick your dungeon and press Enter. You will need to be at least <font color=\'rgb(255,220,80)\'>Level 55</font>. Good luck, you will need it.",
            responses = { "Back to topics.", "Thanks!" },
            actions = { {
                    goto = 1
                }, {
                    hide = "See you in the arena!"
                } }
        },
        {
            text = "Every Challenge has two leaderboards, one for <font color=\'rgb(255,177,82)\'>solo</font> runs and one for <font color=\'rgb(255,177,82)\'>parties</font>. Both save the highest floor you reach, but each one has its own rules.",
            responses = { "How does solo scoring work?", "How does party scoring work?", "Back to topics." },
            actions = { {
                    goto = 8
                }, {
                    goto = 10
                }, {
                    goto = 1
                } }
        },
        {
            text = "Your best floor is <font color=\'rgb(100,255,100)\'>saved</font> the moment your run ends, whether the timer runs out, you lose all your lives, or you leave. The one exception is reviving, which <font color=\'rgb(255,100,100)\'>cancels</font> your score for that run.",
            responses = { "Tell me more about that.", "How does party scoring work?", "Back to topics." },
            actions = { {
                    goto = 9
                }, {
                    goto = 10
                }, {
                    goto = 1
                } }
        },
        {
            text = "Reviving means you did not finish that run on your own, so nothing from it gets recorded. Also, if you leave in the middle of a wave, the game saves the last floor you fully <font color=\'rgb(100,255,100)\'>cleared</font>, not the one you are standing on. So clear a floor before you leave if you want it to count.",
            responses = { "How does party scoring work?", "Back to topics.", "Got it, thanks!" },
            actions = { {
                    goto = 10
                }, {
                    goto = 1
                }, {
                    hide = "Climb as high as you can!"
                } }
        },
        {
            text = "A party score only counts if your team reaches the end of the run <font color=\'rgb(255,177,82)\'>together</font>. If a living teammate leaves early while the rest keep fighting, the whole party score is <font color=\'rgb(255,100,100)\'>cancelled</font>.",
            responses = { "What counts as ending together?", "How does reviving affect my party?", "Back to topics." },
            actions = { {
                    goto = 11
                }, {
                    goto = 12
                }, {
                    goto = 1
                } }
        },
        {
            text = "Ending together means the run stops for the whole group at once. That happens when the timer runs out, when everyone loses their last life, or when every player still alive leaves on the <font color=\'rgb(255,177,82)\'>same floor</font>. Teammates who already ran out of lives are spectating, so they can leave whenever they want without hurting the score. It only breaks when a living player quits the fight early while the others push on.",
            responses = { "How does reviving affect my party?", "Back to topics.", "Got it, thanks!" },
            actions = { {
                    goto = 12
                }, {
                    goto = 1
                }, {
                    hide = "Stick together out there!"
                } }
        },
        {
            text = "Reviving does not cancel your party\'s score, but it does <font color=\'rgb(255,100,100)\'>remove you</font> from it. So if you revive and the team climbs higher, only the teammates who never revived get placed on the party board. You still keep playing and looting as normal, you just are not part of that record.",
            responses = { "Back to topics.", "Got it, thanks!" },
            actions = { {
                    goto = 1
                }, {
                    hide = "Good luck up there!"
                } }
        }
    },

    getStartDialog = function(p1) -- Line: 226, Name: getStartDialog
        return 1;
    end
};

function u2.onResponse(p3, p4, p5) -- Line: 232
    -- upvalues: u2 (copy)
    local v6 = u2.dialogs[p5];

    if not (v6 and v6.actions) then
        return "hide";
    end;

    local v7 = v6.actions[p4];

    if not v7 then
        return "hide";
    end;

    if v7.goto then
        return "goto", v7.goto, v7.quip;
    end;

    if v7.hide then
        return "hide", v7.hide;
    end;

    return "hide";
end;

return u2;