--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ClassObtainment
  Path:     game.ReplicatedStorage.GameInfo.ClassObtainment
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {};
local u2 = {
    Admin = true,
    Owner = true
};
local u3 = {
    Demonbane = "Level 50 Battlepass Reward (Free Track)",
    Streamline = "Early Access+ Exclusive Reward",
    ["Anti Magic"] = "Boss Rush Rare Drop or Crafting",
    ["Awakened Devil EX"] = "Valen NPC Quest Completion",
    ["Cursed King"] = "Boss Rush Rare Drop or Crafting",
    Dreadlord = "Underworld (Nightmare) Rare Drop",
    Founder = "Limited Exclusive — Grand Sovereign Bundle",
    Framebreaker = "No Longer Obtainable",
    ["Honored One"] = "Boss Rush Rare Drop or Crafting",
    Jetstream = "Jetstream NPC Quest Completion",
    Prisma = "No Longer Obtainable",
    ["Shadow Vagrant"] = "Limited Exclusive — Shadow Monarch Pack",
    Unrestricted = "Unrestricted Fighter NPC Quest Completion"
};

function v1.Get(p4: string, p5: any) -- Line: 61
    -- upvalues: u3 (copy), ReplicatedStorage (copy), u2 (copy)
    local v6 = u3[p4];

    if v6 then
        return v6;
    end;

    if p5 == nil then
        p5 = require(ReplicatedStorage.Classes.Class_Data).Get(p4);
    end;

    return p5 and (p5.Summonable ~= false and not p5.IndexHidden) and "Class Summon" or (p5 and u2[p5.Rarity or ""] and "Developer Exclusive" or "Currently Unavailable");
end;

return v1;