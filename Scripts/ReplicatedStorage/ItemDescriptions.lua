--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ItemDescriptions
  Path:     game.ReplicatedStorage.GameInfo.ItemDescriptions
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local script_Parent = script.Parent;
local PotionData = require(script_Parent:WaitForChild("PotionData"));
local BuffPotionData = require(script_Parent:WaitForChild("BuffPotionData"));
local u1 = {
    Descriptions = {
        ["Common Crystal"] = "A basic crystal dropped by Common enemies.",
        ["Uncommon Crystal"] = "A crystal dropped by Uncommon enemies.",
        ["Rare Crystal"] = "A crystal dropped by Rare enemies.",
        ["Epic Crystal"] = "A crystal dropped by Epic enemies.",
        ["Legendary Crystal"] = "A valuable crystal dropped by Legendary enemies.",
        ["Mythic Crystal"] = "A rare crystal dropped by Mythic enemies.",
        ["Celestial Crystal"] = "An extremely rare crystal dropped by Celestial enemies.",
        Legendary_Stone = "Used to enhance Legendary weapons.",
        Mythic_Stone = "Used to enhance Mythic weapons.",
        Celestial_Stone = "Used to enhance Celestial weapons.",
        ProtectionScroll = "Prevents weapon downgrade on a failed enhancement.",
        GoldenHammer = "Guarantees 80% enhancement success rate."
    }
};

function u1.Get(p2: string) -- Line: 53
    -- upvalues: BuffPotionData (copy), PotionData (copy), u1 (copy)
    local Potion = BuffPotionData.GetPotion(p2);

    if Potion and Potion.Description then
        return Potion.Description;
    end;

    local Potion2 = PotionData.GetPotion(p2);

    if Potion2 and Potion2.Description then
        return Potion2.Description;
    end;

    return u1.Descriptions[p2] or (not string.find(p2, "LootChest") and "" or string.gsub(p2, "LootChest", "") .. " rarity loot chest. Open from Inventory.");
end;

return u1;