--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ForgeGuide
  Path:     game.ReplicatedStorage.DialogueData.ForgeGuide
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.GameInfo.QuestRewardData);
local u1 = {
    npcName = "Forge Guide",
    animation = nil,
    dialogs = {
        {
            text = "Welcome to the <font color=\'rgb(255,150,60)\'>Forge</font>, adventurer! Forging is how you push your equipment past its natural limits, more stats, brand-new affixes, real power. What would you like to know?",
            responses = { "How does forging add stats?", "What are the risks?", "What does Reforging do?", "How do I get materials?" },
            actions = { {
                    goto = 2
                }, {
                    goto = 3
                }, {
                    goto = 4
                }, {
                    goto = 5
                } }
        },
        {
            text = "Every forge level boosts all the stats already on your gear, but the real prizes are the <font color=\'rgb(255,220,80)\'>milestones</font>. When you successfully forge to <font color=\'rgb(100,255,100)\'>+1</font>, <font color=\'rgb(100,255,100)\'>+5</font>, <font color=\'rgb(100,255,100)\'>+10</font>, and <font color=\'rgb(100,255,100)\'>+15</font>, your equipment gains a fresh, <font color=\'rgb(180,80,255)\'>randomly rolled affix</font> from that slot\'s pool, a stat it didn\'t have before. That\'s up to <font color=\'rgb(255,220,80)\'>four extra affixes</font> by the time you reach +15. Chase those milestones!",
            responses = { "What are the risks?", "Any freebies to get me started?", "Back to topics.", "Thanks!" },
            actions = { {
                    goto = 3
                }, {
                    materialBag = true
                }, {
                    goto = 1
                }, {
                    hide = "Go chase those milestones!"
                } }
        },
        {
            text = "Forging is never guaranteed, and the success rate drops the higher you climb. Here\'s the important part: once you\'re pushing to <font color=\'rgb(255,100,100)\'>+11 and beyond</font>, a <font color=\'rgb(255,100,100)\'>failed attempt can downlevel</font> your equipment, knocking it down a forge level. Below +11, a failure just fizzles with no loss. So stack up materials before you gamble on those high levels!",
            responses = { "What does Reforging do?", "Any freebies to get me started?", "Back to topics.", "Thanks!" },
            actions = { {
                    goto = 4
                }, {
                    materialBag = true
                }, {
                    goto = 1
                }, {
                    hide = "Forge carefully out there!"
                } }
        },
        {
            text = "Rolled some affixes you don\'t love? <font color=\'rgb(100,200,255)\'>Reforging</font> spends a <font color=\'rgb(100,200,255)\'>Reforge Stone</font> to <font color=\'rgb(180,80,255)\'>regenerate the affix rolls</font> on a piece of equipment, fresh values across all of its affixes at once. Keep reforging until the rolls line up with the build you want.",
            responses = { "How do I get materials?", "Any freebies to get me started?", "Back to topics.", "Thanks!" },
            actions = { {
                    goto = 5
                }, {
                    materialBag = true
                }, {
                    goto = 1
                }, {
                    hide = "Reforge \'til it\'s perfect!"
                } }
        },
        {
            text = "Forging eats <font color=\'rgb(255,220,80)\'>materials</font> matched to your gear\'s rarity. Two ways to keep your stock up: <font color=\'rgb(255,100,100)\'>run dungeons</font>, they\'re your main source of materials, or <font color=\'rgb(100,255,100)\'>craft</font> higher-grade materials by combining lower-grade ones at the crafting station. Low-grade mats are everywhere, so trade up whenever you need something rarer!",
            responses = { "Tell me about forging stats.", "Any freebies to get me started?", "Back to topics.", "Thanks!" },
            actions = { {
                    goto = 2
                }, {
                    materialBag = true
                }, {
                    goto = 1
                }, {
                    hide = "Happy forging!"
                } }
        },
        {
            text = "First time at the Forge? Let me set you up. Here\'s a <font color=\'rgb(100,255,100)\'>free bag of 5 Tier 1 Material Bundles</font>, crack them open for early ingots to kick off your forging. One per adventurer, so make it count!",
            responses = { "Claim my free bag!", "Maybe later." },
            actions = { {
                    questReward = "ForgeGuideMaterialBag"
                }, {
                    goto = 1
                } }
        },
        {
            text = "You\'ve already grabbed your free starter bag! From here on out, materials come from dungeon runs and crafting. Go put those to work at the Forge!",
            responses = { "Back to topics.", "Thanks!" },
            actions = { {
                    goto = 1
                }, {
                    hide = "See you at the anvil!"
                } }
        }
    }
};

function u1.onResponse(p2, p3, p4) -- Line: 165
    -- upvalues: u1 (copy), Knit (copy)
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

    if v6.materialBag then
        local Registry = Knit.Registry;

        if Registry then
            Registry = Registry:Get("PlayerData");
        end;

        if Registry then
            Registry = Registry.Data.CompletedQuests;
        end;

        if Registry and Registry.ForgeGuideMaterialBag then
            return "goto", 7;
        end;

        return "goto", 6;
    end;

    if not v6.questReward then
        if v6.hide then
            return "hide", v6.hide;
        end;

        return "hide";
    end;

    local Registry = Knit.Registry;

    if Registry then
        Registry = Registry:Get("PlayerData");
    end;

    if not Registry then
        return "hide";
    end;

    local CompletedQuests = Registry.Data.CompletedQuests;

    if CompletedQuests and CompletedQuests.ForgeGuideMaterialBag then
        return "goto", 7;
    end;

    return "server", "QuestReward", {
        questId = v6.questReward
    }, "Here you go! Open the bundles from your inventory.";
end;

function u1.onServerResult(p7, p8, p9, p10) -- Line: 207
    if p9 ~= "QuestReward" then
        return;
    end;

    if not p10 or p10.questId ~= "ForgeGuideMaterialBag" then
        return;
    end;

    if p10.success then
        print("[ForgeGuide] Starter material bag granted successfully!");

        return;
    end;

    warn("[ForgeGuide] Starter material bag failed:", p10.reason);
end;

return u1;