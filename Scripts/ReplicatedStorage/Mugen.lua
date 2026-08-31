--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Mugen
  Path:     game.ReplicatedStorage.DialogueData.Mugen
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    npcName = "Mugen",
    animation = nil,
    dialogs = { {
            text = "Nah, I don\'t need anything from you right now. But don\'t worry, when I do, you\'ll know. It\'ll be fun. Well... fun for me.",
            responses = { "Should I be worried?", "Alright then." },
            actions = { {
                    hide = "Probably."
                }, {
                    hide = "See you around. Try not to die before then."
                } }
        } }
};

function u1.onResponse(p2, p3, p4) -- Line: 36
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