--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Tachyon
  Path:     game.ReplicatedStorage.DialogueData.Tachyon
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    npcName = "Tachyon",
    animation = nil,
    dialogs = {
        {
            text = "Ah, a visitor! Welcome to my archive. I\'ve been cataloging every powerful entity in these dungeons. Fascinating creatures, truly. What would you like to know?",
            responses = { "Tell me about bosses.", "How do I get class items?", "Nothing right now." },
            actions = { {
                    goto = 2
                }, {
                    goto = 5
                }, {
                    hide = "Come back anytime! Science never sleeps... and neither do I, apparently."
                } }
        },
        {
            text = "Bosses! My favorite subject. I\'ve studied their attack patterns, their habitats, their... dietary habits. Which one interests you?",
            responses = { "Dark Rider", "Awakened Devil", "Back to topics." },
            actions = { {
                    goto = 3
                }, {
                    goto = 4
                }, {
                    goto = 1
                } }
        },
        {
            text = "The <font color=\'rgb(180,80,255)\'>Dark Rider</font>... also known as <font color=\'rgb(255,100,100)\'>Karasu</font>. A spectral swordsman that mirrors the Dark Rider class, Phantom Veil, Maximum Drive, Dead or Alive, and the devastating Death Parade. He\'s a <font color=\'rgb(255,220,80)\'>rare encounter</font> in the <font color=\'rgb(255,220,80)\'>Catacombs</font>, appears in an optional side room with only a <font color=\'rgb(255,100,100)\'>2% spawn chance</font>. Oh, and he drops the <font color=\'rgb(180,80,255)\'>Empty Soul</font>. Very important, remember that.",
            responses = { "What\'s the Empty Soul for?", "Tell me about other bosses.", "Back to topics." },
            actions = { {
                    goto = 8
                }, {
                    goto = 2
                }, {
                    goto = 1
                } }
        },
        {
            text = "The <font color=\'rgb(255,80,80)\'>Awakened Devil</font>. One of the most dangerous entities I\'ve documented. It channels the power of the <font color=\'rgb(100,150,255)\'>Azure Devil</font>, Infernal Onslaught, Hellfire Barrage, Devil\'s Severance... the full arsenal. Incredibly tight attack windows. You\'ll need strong gear and sharp reflexes. Found deep in the <font color=\'rgb(255,220,80)\'>Catacombs</font> on <font color=\'rgb(255,220,80)\'>Hard mode</font> or higher.",
            responses = { "Tell me about other bosses.", "How do I get class items?", "Back to topics." },
            actions = { {
                    goto = 2
                }, {
                    goto = 5
                }, {
                    goto = 1
                } }
        },
        {
            text = "Class items! The rarest treasures in these dungeons. Each one transforms the wielder into something extraordinary. Which class are you interested in?",
            responses = { "Oathbreaker", "Lichborn", "Where do I get an Empty Soul?", "Back to topics." },
            actions = { {
                    goto = 6
                }, {
                    goto = 7
                }, {
                    goto = 8
                }, {
                    goto = 1
                } }
        },
        {
            text = "The <font color=\'rgb(255,100,100)\'>Oathbreaker</font> class, obtained through the <font color=\'rgb(180,80,255)\'>Oathbound Lance</font>. It belonged to <font color=\'rgb(255,220,80)\'>Gilvan, The Oathbound</font>, a fallen knight boss found in the <font color=\'rgb(255,220,80)\'>Knights dungeon</font>, the Forgotten Ruins. Defeat him and claim the lance. A warrior of overwhelming might... if you can handle the weight of a broken oath.",
            responses = { "Tell me about Lichborn.", "Where do I get an Empty Soul?", "Back to topics." },
            actions = { {
                    goto = 7
                }, {
                    goto = 8
                }, {
                    goto = 1
                } }
        },
        {
            text = "The <font color=\'rgb(180,80,255)\'>Lichborn</font> class, obtained through <font color=\'rgb(180,80,255)\'>Verath\'s Soulspear</font>. <font color=\'rgb(255,220,80)\'>Verath, The Lichborn</font> is the boss of the <font color=\'rgb(255,220,80)\'>Catacombs</font>. A revenant caught between life and death. Defeat him and the Soulspear is yours. Its necrotic edge hungers for living souls... poetic, isn\'t it?",
            responses = { "Tell me about Oathbreaker.", "Where do I get an Empty Soul?", "Back to topics." },
            actions = { {
                    goto = 6
                }, {
                    goto = 8
                }, {
                    goto = 1
                } }
        },
        {
            text = "The <font color=\'rgb(180,80,255)\'>Empty Soul</font>, a quest item that drops from <font color=\'rgb(255,100,100)\'>Karasu</font> (the Dark Rider boss) in the <font color=\'rgb(255,220,80)\'>Catacombs</font>. Remember, he\'s a rare 2% spawn. Once you have it, seek out the NPC named <font color=\'rgb(255,220,80)\'>Aura</font>, she can transform the Empty Soul into the <font color=\'rgb(180,80,255)\'>Skull Memory</font>, which grants the <font color=\'rgb(255,100,100)\'>Dark Rider</font> class. A long journey, but the result is extraordinary.",
            responses = { "Tell me about other bosses.", "Tell me about other class items.", "Thanks, Tachyon." },
            actions = { {
                    goto = 2
                }, {
                    goto = 5
                }, {
                    hide = "The pleasure is mine! Knowledge is meant to be shared... especially when the subjects are this dangerous."
                } }
        }
    }
};

function u1.onResponse(p2, p3, p4) -- Line: 159
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