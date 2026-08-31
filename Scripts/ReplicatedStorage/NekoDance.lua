--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     NekoDance
  Path:     game.ReplicatedStorage.DialogueData.NekoDance
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = {
    npcName = "Neko Merchant",
    animation = nil
};
local NekoDance = require(ReplicatedStorage.GameInfo.MonetizationList).NekoDance;
local v2 = NekoDance and (NekoDance.Robux or 249) or 249;
u1.dialogs = {
    {
        text = "Nyaa~ Looking for something with a little more <font color=\'rgb(255,140,220)\'>bounce</font>? I\'ve got just the one, exclusive, you won\'t find it in the rotation.",
        responses = { "Show me.", "Not right now." },
        actions = { {
                goto = 2
            }, {
                hide = "Suit yourself, nyaa~"
            } }
    },
    {
        text = `The <font color='rgb(255,140,220)'>Neko Dance</font> emote, all yours for <font color='rgb(120,255,150)'>{v2} Robux</font>. Purr-fect for showing off. Shall I wrap it up?`,
        responses = { `Buy it. ({v2} Robux)`, "Maybe later." },
        actions = { {
                buy = true
            }, {
                hide = "I\'ll keep it warm for you, nyaa~"
            } }
    },
    {
        text = "You\'ve already got the <font color=\'rgb(255,140,220)\'>Neko Dance</font>! Go on, show everyone those moves, nyaa~",
        responses = { "Will do!" },
        actions = { {
                hide = "Dance on, nyaa~"
            } }
    }
};

local function OwnsEmote() -- Line: 91
    -- upvalues: Knit (copy)
    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if Registry then
        Registry = Registry.Data;
    end;

    if Registry then
        Registry = Registry.Emotes;
    end;

    local v3;

    if Registry == nil or Registry.Owned == nil then
        v3 = false;
    else
        v3 = Registry.Owned.NekoDance ~= nil;
    end;

    return v3;
end;

function u1.getStartDialog(p4) -- Line: 101
    -- upvalues: Knit (copy)
    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if Registry then
        Registry = Registry.Data;
    end;

    if Registry then
        Registry = Registry.Emotes;
    end;

    local v5;

    if Registry == nil or Registry.Owned == nil then
        v5 = false;
    else
        v5 = Registry.Owned.NekoDance ~= nil;
    end;

    return v5 and 3 or 1;
end;

function u1.onResponse(p6, p7, p8) -- Line: 110
    -- upvalues: u1 (copy), NekoDance (copy), Knit (copy)
    local v9 = u1.dialogs[p8];

    if not (v9 and v9.actions) then
        return "hide";
    end;

    local v10 = v9.actions[p7];

    if not v10 then
        return "hide";
    end;

    if v10.goto then
        return "goto", v10.goto, v10.quip;
    end;

    if not v10.buy then
        if v10.hide then
            return "hide", v10.hide;
        end;

        return "hide";
    end;

    local v11 = NekoDance and NekoDance.Id;

    if v11 and v11 ~= 0 then
        Knit.GetController("MarketplaceController"):PromptProduct(v11);

        return "hide", "Nyaa~ enjoy the dance!";
    end;

    warn("[NekoDance] No valid product id configured in MonetizationList");

    return "hide", "Something\'s not right with the register... come back later, nyaa~";
end;

return u1;