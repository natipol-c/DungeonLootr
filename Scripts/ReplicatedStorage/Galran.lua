--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Galran
  Path:     game.ReplicatedStorage.DialogueData.Galran
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    npcName = "Galran",
    animation = nil,
    dialogs = {
        {
            text = "You want to survive out there? Then listen. I didn\'t earn these scars by reading books. Ask me what you need to know.",
            responses = { "What does dodging do?", "What does parrying do?", "What is Affinity?", "My ring isn\'t doing the right damage." },
            actions = { {
                    goto = 2
                }, {
                    goto = 3
                }, {
                    goto = 7
                }, {
                    goto = 8
                } }
        },
        {
            text = "Dodging isn\'t just about moving out of the way. When you time a dodge right, you get <font color=\'rgb(255,220,80)\'>invincibility frames</font>, a brief window where nothing can touch you. The better your timing, the more you can punish an enemy\'s swing while they\'re still recovering. Master it, or you\'ll be eating dirt.",
            responses = { "What about parrying?", "What is Evasion?", "More topics.", "Thanks, Galran." },
            actions = { {
                    goto = 3
                }, {
                    goto = 5
                }, {
                    goto = 1
                }, {
                    hide = "Don\'t thank me. Survive. That\'s thanks enough."
                } }
        },
        {
            text = "A well-timed parry does two things. First, it <font color=\'rgb(255,220,80)\'>stuns grunt enemies</font>, leaving them wide open. Second, it cancels your recovery, letting you <font color=\'rgb(255,220,80)\'>continue attacking immediately</font> after the parry. Against bosses, the stun won\'t work, but the attack cancel will still save your life. Learn to parry. It separates warriors from corpses.",
            responses = { "What about dodging?", "What\'s a Mastery Passive?", "More topics.", "Thanks, Galran." },
            actions = { {
                    goto = 2
                }, {
                    goto = 6
                }, {
                    goto = 1
                }, {
                    hide = "Now go put it to use."
                } }
        },
        {
            text = "Dying too fast? Your <font color=\'rgb(100,255,100)\'>VIT</font> stat is your lifeline. Every point you put into VIT gives you <font color=\'rgb(255,220,80)\'>15 HP</font>. Doesn\'t sound like much until it\'s the difference between standing and dead. Pair it with good Body armor and you\'ll be the last one standing. I always am.",
            responses = { "What is Affinity?", "What is Evasion?", "More topics.", "Thanks, Galran." },
            actions = { {
                    goto = 7
                }, {
                    goto = 5
                }, {
                    goto = 1
                }, {
                    hide = "Stay alive. That\'s an order."
                } }
        },
        {
            text = "<font color=\'rgb(255,220,80)\'>Evasion</font> is a passive stat, you don\'t activate it, it activates for you. It comes from your <font color=\'rgb(255,180,50)\'>DEX</font> stat. The higher your DEX, the better your chance of <font color=\'rgb(255,220,80)\'>automatically evading</font> an incoming attack entirely. Think of it as your instincts keeping you alive when your brain is too slow to react.",
            responses = { "What does dodging do?", "What\'s a Mastery Passive?", "More topics.", "Thanks, Galran." },
            actions = { {
                    goto = 2
                }, {
                    goto = 6
                }, {
                    goto = 1
                }, {
                    hide = "Trust your instincts. They\'ll save you when nothing else will."
                } }
        },
        {
            text = "<font color=\'rgb(255,220,80)\'>Mastery Passives</font> are unique to certain classes. As you level a class, some unlock <font color=\'rgb(180,80,255)\'>special activation skills</font> that fundamentally change how the class plays, making it stronger or giving it entirely new mechanics. Not every class has one, but the ones that do? They\'re worth mastering. Check your class mastery tree to see if yours has something waiting.",
            responses = { "What is Affinity?", "What is Evasion?", "More topics.", "Thanks, Galran." },
            actions = { {
                    goto = 7
                }, {
                    goto = 5
                }, {
                    goto = 1
                }, {
                    hide = "Mastery comes from blood and repetition. Get to it."
                } }
        },
        {
            text = "Every class has an <font color=\'rgb(255,220,80)\'>Affinity</font>, <font color=\'rgb(255,100,100)\'>Physical</font>, <font color=\'rgb(100,255,100)\'>Ranged</font>, or <font color=\'rgb(100,150,255)\'>Magic</font>. Your Ring has one too. When they <font color=\'rgb(255,220,80)\'>match</font>, you get <font color=\'rgb(255,220,80)\'>100% of the ring\'s base damage</font>. When they <font color=\'rgb(255,100,100)\'>don\'t match</font>, you\'re only getting <font color=\'rgb(255,100,100)\'>70%</font>. Always match your ring to your class. Anything less is fighting with one arm tied behind your back.",
            responses = { "What\'s a Mastery Passive?", "I need more Health.", "More topics.", "Thanks, Galran." },
            actions = { {
                    goto = 6
                }, {
                    goto = 4
                }, {
                    goto = 1
                }, {
                    hide = "Match your weapons to your strengths. War has no room for waste."
                } }
        },
        {
            text = "Your ring\'s damage gets cut down when it doesn\'t match your class. Every class carries an <font color=\'rgb(255,220,80)\'>Affinity</font>, <font color=\'rgb(255,100,100)\'>Physical</font>, <font color=\'rgb(100,255,100)\'>Ranged</font>, or <font color=\'rgb(100,150,255)\'>Magic</font>, and so does every ring. <font color=\'rgb(255,220,80)\'>Match them</font>, and you wield <font color=\'rgb(255,220,80)\'>100% of the ring\'s base damage</font>. <font color=\'rgb(255,100,100)\'>Mismatch them</font>, and you\'re swinging at <font color=\'rgb(255,100,100)\'>70%</font>. Check your class, check your ring, and make them agree. Simple as that.",
            responses = { "Tell me more about Affinity.", "More topics.", "Thanks, Galran." },
            actions = { {
                    goto = 7
                }, {
                    goto = 1
                }, {
                    hide = "Good. Now go crush something with the right tool in your hand."
                } }
        }
    }
};

function u1.onResponse(p2, p3, p4) -- Line: 171
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