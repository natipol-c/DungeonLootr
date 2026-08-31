--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SkipEndless
  Path:     game.ReplicatedStorage.DialogueData.SkipEndless
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    npcName = "Floor Skipper",
    animation = nil
};
local u2 = { {
        MinWave = 1,
        MaxWave = 19,
        TargetWave = 20,
        KeyTier = 3,
        KeyCount = 10,
        DisplayName = "Legendary Keys"
    }, {
        MinWave = 20,
        MaxWave = 39,
        TargetWave = 40,
        KeyTier = 4,
        KeyCount = 10,
        DisplayName = "Mythic Keys"
    }, {
        MinWave = 40,
        MaxWave = 59,
        TargetWave = 60,
        KeyTier = 5,
        KeyCount = 10,
        DisplayName = "Celestial Keys"
    }, {
        MinWave = 60,
        MaxWave = 79,
        TargetWave = 80,
        KeyTier = 5,
        KeyCount = 20,
        DisplayName = "Celestial Keys"
    } };
u1.SKIP_BRACKETS = u2;

function u1.GetBracketForWave(p3: number) -- Line: 77
    -- upvalues: u2 (copy)
    for i, v in u2 do
        if v.MinWave <= p3 and p3 <= v.MaxWave then
            return v, i;
        end;
    end;

    return nil, nil;
end;

u1.dialogs = {
    {
        text = "I only work the <font color=\'rgb(180,80,255)\'>Endless</font> floors. Find me inside a run and I can cut you a deal.",
        responses = { "Got it." },
        actions = { {
                hide = "See you in the pit."
            } }
    },
    {
        text = "You\'ve already pushed past anything I can help with. The rest of the climb is on you.",
        responses = { "Understood." },
        actions = { {
                hide = "Good hunting."
            } }
    },
    {
        text = "You don\'t have the keys for that skip. Come back when you\'re carrying enough.",
        responses = { "I\'ll be back." },
        actions = { {
                hide = "I\'ll be here."
            } }
    },
    {
        text = "Something went wrong on my end. The skip didn\'t take. No keys were spent.",
        responses = { "Alright." },
        actions = { {
                hide = "Try me again."
            } }
    },
    {
        text = "",
        responses = { "..." },
        actions = { {
                hide = ""
            } }
    },
    {
        text = "",
        responses = { "..." },
        actions = { {
                hide = ""
            } }
    },
    {
        text = "",
        responses = { "..." },
        actions = { {
                hide = ""
            } }
    },
    {
        text = "",
        responses = { "..." },
        actions = { {
                hide = ""
            } }
    },
    {
        text = "",
        responses = { "..." },
        actions = { {
                hide = ""
            } }
    },
    {
        text = "You\'re still in the early floors. For <font color=\'rgb(255,220,80)\'>10 Legendary Keys</font>, I can drop you at <font color=\'rgb(180,80,255)\'>Floor 20</font>. Straight into the action.",
        responses = { "Take them. Skip me to Floor 20.", "Not yet." },
        actions = { {
                skipTo = 1
            }, {
                hide = "Come back when you\'re ready."
            } }
    },
    {
        text = "You\'ve cleared the early floors. For <font color=\'rgb(255,220,80)\'>10 Mythic Keys</font>, I can move you up to <font color=\'rgb(180,80,255)\'>Floor 40</font>.",
        responses = { "Take them. Skip me to Floor 40.", "Not yet." },
        actions = { {
                skipTo = 2
            }, {
                hide = "Come back when you\'re ready."
            } }
    },
    {
        text = "You\'re grinding deep now. <font color=\'rgb(255,220,80)\'>10 Celestial Keys</font> buys you a jump to <font color=\'rgb(180,80,255)\'>Floor 60</font>. Worth it if you\'re fishing for high-tier drops.",
        responses = { "Take them. Skip me to Floor 60.", "Not yet." },
        actions = { {
                skipTo = 3
            }, {
                hide = "Come back when you\'re ready."
            } }
    },
    {
        text = "The final stretch. <font color=\'rgb(255,220,80)\'>20 Celestial Keys</font> and I\'ll put you at <font color=\'rgb(180,80,255)\'>Floor 80</font>. This is the deepest I can take you.",
        responses = { "Take them. Skip me to Floor 80.", "Not yet." },
        actions = { {
                skipTo = 4
            }, {
                hide = "Come back when you\'re ready."
            } }
    }
};

function u1.getStartDialog(p4) -- Line: 187
    -- upvalues: u1 (copy)
    local player = p4.player;

    if not player then
        return 1;
    end;

    if not player:GetAttribute("InEndless") then
        return 1;
    end;

    local v5 = player:GetAttribute("EndlessWave") or 1;
    local _, v6 = u1.GetBracketForWave(v5);

    return not v6 and 2 or 10 + (v6 - 1);
end;

function u1.onResponse(p7, p8, p9) -- Line: 206
    -- upvalues: u1 (copy), u2 (copy)
    local v10 = u1.dialogs[p9];

    if not (v10 and v10.actions) then
        return "hide";
    end;

    local v11 = v10.actions[p8];

    if not v11 then
        return "hide";
    end;

    if v11.hide then
        return "hide", v11.hide;
    end;

    if not v11.skipTo then
        return "hide";
    end;

    if u2[v11.skipTo] then
        return "server", "EndlessFloorSkip", {
            bracketIdx = v11.skipTo
        }, "Hold tight...";
    end;

    return "hide";
end;

function u1.onServerResult(p12, p13, p14, p15) -- Line: 232
    if p14 ~= "EndlessFloorSkip" then
        return;
    end;

    if not p15 then
        return;
    end;

    if p15.success then
        print((`[SkipEndless] Skipped to wave {p15.targetWave} (spent {p15.keyCount}× T{p15.keyTier} keys)`));

        return;
    end;

    warn((`[SkipEndless] Skip rejected: {p15.reason}`));
end;

return u1;