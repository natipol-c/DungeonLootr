--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AFKChamber
  Path:     game.ReplicatedStorage.DialogueData.AFKChamber
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    npcName = "AFK Chamber",
    animation = nil,
    dialogs = { {
            text = "Need to step away for a while? I can send you to the <font color=\'rgb(120,200,255)\'>AFK Chamber</font>. Kick back, stay idle, and keep earning while you\'re gone. Want to head in?",
            responses = { "Yeah, take me in.", "Not right now." },
            actions = { {
                    enter = true
                }, {
                    hide = "No problem. Come find me whenever you need a break."
                } }
        }, {
            text = "Hm, the chamber isn\'t reachable from here right now. Try again from the live game.",
            responses = { "Alright." },
            actions = { {
                    hide = "Come back and try again later."
                } }
        } }
};

function u1.onResponse(p2, p3, p4) -- Line: 64
    -- upvalues: u1 (copy)
    local v5 = u1.dialogs[p4];

    if not (v5 and v5.actions) then
        return "hide";
    end;

    local v6 = v5.actions[p3];

    if not v6 then
        return "hide";
    end;

    if v6.enter then
        return "server", "EnterAFKChamber", {}, "One moment...";
    end;

    if v6.goto then
        return "goto", v6.goto, v6.quip;
    end;

    if v6.hide then
        return "hide", v6.hide;
    end;

    return "hide";
end;

function u1.onServerResult(p7, p8, p9, p10) -- Line: 89
    if p9 ~= "EnterAFKChamber" then
        return;
    end;

    if p8 ~= p7.dialogueId then
        return;
    end;

    if not p10 or p10.success then
        return;
    end;

    warn("[AFKChamber] Entry failed:", p10.reason);
    local dialogObject = p7.dialogObject;

    if dialogObject then
        dialogObject:triggerDialog(p7.player, 2);
    end;
end;

return u1;