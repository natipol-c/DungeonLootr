--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hitman
  Path:     game.ReplicatedStorage.DialogueData.Hitman
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    npcName = "Hitman",
    animation = nil
};
local Hitman = game:GetService("ReplicatedStorage").Assets.Dialogue_Quips.Hitman;
u1.voiceLines = { Hitman["Wanna be a hitman"].SoundId, Hitman["Cant understand"].SoundId, Hitman.Quest.SoundId };
u1.dialogs = { {
        text = "で、お前はヒットマンになりたいのか？",
        responses = { "Uhh, what?", "Yes...?", "Later dude..." },
        actions = { {
                goto = 2
            }, {
                goto = 2
            }, {
                hide = "..."
            } }
    }, {
        text = "何言ってんだ？俺の言ってることが分からないのか？",
        responses = { "Yes..?", "Bye dude" },
        actions = { {
                goto = 3
            }, {
                hide = "..."
            } }
    }, {
        text = "まあいい、俺のクエストはまだ準備中だ。でも準備ができたら、お前も覚悟しとけよ。",
        responses = { "Yes sir!", "Dude I still don\'t know what you said what are you even talking about" },
        actions = { {
                hide = "..."
            }, {
                hide = "..."
            } }
    } };

function u1.onResponse(p2, p3, p4) -- Line: 93
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