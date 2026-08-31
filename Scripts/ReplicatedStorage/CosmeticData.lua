--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CosmeticData
  Path:     game.ReplicatedStorage.GameInfo.CosmeticData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Slots = { "Head", "Body", "Shoulder", "Back", "Bottom", "Aura" }
};
local u2 = {};

for _, v in u1.Slots do
    u2[v] = true;
end;

u1.SLOT_TO_LOCATIONS = {
    Head = { "Head" },
    Body = { "Torso" },
    Shoulder = { "Left Arm", "Right Arm" },
    Back = { "Back" },
    Bottom = { "Left Leg", "Right Leg", "Waist" },
    Aura = { "Aura" }
};
local v3 = {};

for i, v in u1.SLOT_TO_LOCATIONS do
    local v4 = i;

    for _, v2 in v do
        v3[v2] = v4;
    end;
end;

u1.LOCATION_TO_SLOT = v3;
u1.SLOT_DISPLAY = {
    Head = "Head",
    Body = "Torso",
    Shoulder = "Shoulders",
    Back = "Back",
    Bottom = "Bottom",
    Aura = "Aura"
};
u1.SLOT_ORDER = {
    Head = 0,
    Body = 1,
    Shoulder = 2,
    Back = 3,
    Bottom = 4,
    Aura = 5
};
u1.SLOT_FRAME = {
    Head = "Head",
    Body = "Body",
    Shoulder = "Arms",
    Back = "Back",
    Bottom = "Legs",
    Aura = "Aura"
};
local u5 = {
    ["Black Vampire Hunter"] = {
        DisplayName = "Black Vampire Hunter",
        Rarity = "Uncommon",
        Description = "Garb of a hunter who stalks the night.",
        Icon = "rbxassetid://112645778000827",
        InShop = true,
        StarsCost = 100
    },
    ["Red Vampire Hunter"] = {
        DisplayName = "Red Vampire Hunter",
        Rarity = "Uncommon",
        Description = "Garb of a hunter who stalks the night.",
        Icon = "",
        InShop = true,
        StarsCost = 100
    },
    ["White Vampire Hunter"] = {
        DisplayName = "White Vampire Hunter",
        Rarity = "Uncommon",
        Description = "Garb of a hunter who stalks the night.",
        Icon = "",
        InShop = true,
        StarsCost = 100
    },
    ["Black Infernal Hunter"] = {
        DisplayName = "Black Infernal Hunter",
        Rarity = "Uncommon",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 100
    },
    ["Brown Infernal Hunter"] = {
        DisplayName = "Brown Infernal Hunter",
        Rarity = "Uncommon",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 100
    },
    ["White Infernal Hunter"] = {
        DisplayName = "White Infernal Hunter",
        Rarity = "Uncommon",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 100
    },
    ["Red Infernal Hunter"] = {
        DisplayName = "Red Infernal Hunter",
        Rarity = "Uncommon",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 100
    },
    Vagabond = {
        DisplayName = "Vagabond",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 2000
    },
    ["Scarlet Knight"] = {
        DisplayName = "Scarlet Knight",
        Rarity = "Admin",
        Description = "Model Credit: RuneTheRaccoon",
        Icon = "",
        InShop = false,
        StarsCost = 0
    },
    ["Wolf Set"] = {
        DisplayName = "Wolf Set",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 0
    },
    ["Dark Shinobi"] = {
        DisplayName = "Dark Shinobi",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 1000
    },
    ["Light Shinobi"] = {
        DisplayName = "Light Shinobi",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 1000
    },
    Berserker = {
        DisplayName = "Berserker",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 0
    },
    Reaper = {
        DisplayName = "Reaper",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3500
    },
    Umbral = {
        DisplayName = "Umbral",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Crimson Umbral"] = {
        DisplayName = "Crimson Umbral",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 400
    },
    ["Party Animal"] = {
        DisplayName = "Party Animal",
        Rarity = "Exotic",
        Description = "Ogge\'s personal aura.",
        Icon = "rbxassetid://82954534594537",
        InShop = false,
        StarsCost = 0
    },
    ["Group Aura"] = {
        DisplayName = "Group Aura",
        Rarity = "Rare",
        Description = "An exclusive aura for group members. Thanks for the support!",
        Icon = "",
        InShop = false,
        StarsCost = 0
    },
    ["Midnight Samurai"] = {
        DisplayName = "Midnight Samurai",
        Rarity = "Mythic",
        Description = "(Model Credit: Yami / akistytalvezfuncione)",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Cloud Scarf"] = {
        DisplayName = "Cloud Scarf",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000
    },
    Typhoon = {
        DisplayName = "Typhoon",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Bunny Ears"] = {
        DisplayName = "Bunny Ears",
        Rarity = "Rare",
        Description = "A festive pair of bunny ears. Happy Easter!",
        Icon = "",
        InShop = false,
        StarsCost = 0
    },
    ["Black Swordsman"] = {
        DisplayName = "Black Swordsman Set",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Opulant Coat"] = {
        DisplayName = "Opulant Coat",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 0
    },
    ["Flame Samurai"] = {
        DisplayName = "Flame Samurai",
        Rarity = "Mythic",
        Description = "Model Credit: Neuroticxs",
        Icon = "",
        InShop = false,
        StarsCost = 2500
    },
    ["Juvenile Outfit"] = {
        DisplayName = "Juvenile Outfit",
        Rarity = "Mythic",
        Description = "Model Credit: Neuroticxs",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Slayer Set"] = {
        DisplayName = "Slayer Set",
        Rarity = "Mythic",
        Description = "Model Credit: Neuroticxs",
        Icon = "",
        InShop = false,
        StarsCost = 2500
    },
    ["Muscle (Light)"] = {
        DisplayName = "Muscle (Light)",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000
    },
    ["Muscle (Semi Light)"] = {
        DisplayName = "Muscle (Semi Light)",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000
    },
    ["Muscle (Tan)"] = {
        DisplayName = "Muscle (Tan)",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000
    },
    ["Muscle (Semi Dark)"] = {
        DisplayName = "Muscle (Semi Dark)",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000
    },
    ["Muscle (Dark)"] = {
        DisplayName = "Muscle (Dark)",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000
    },
    ["Forge Archon"] = {
        DisplayName = "Forge Archon",
        Rarity = "Celestial",
        Description = "(Model Credit: zSergiooCy)",
        Icon = "",
        InShop = false,
        StarsCost = 200000
    },
    ["Forge Archon Aura"] = {
        DisplayName = "Forge Archon Aura",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 200000
    },
    ["Forge Archon Alt"] = {
        DisplayName = "Forge Archon Alt",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 200000
    },
    ["Forge Archon Alt Black"] = {
        DisplayName = "Forge Archon Alt Black",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 200000
    },
    ["Crimson Ninja"] = {
        DisplayName = "Crimson Ninja",
        Rarity = "Celestial",
        Description = "Model Credit: Shiki_Tsugu",
        Icon = "",
        InShop = false,
        StarsCost = 200000
    },
    ["Ninja Mask 1"] = {
        DisplayName = "Ninja Mask 1",
        Rarity = "Mythic",
        Description = "Model Credit: Shiki_Tsugu",
        Icon = "",
        InShop = false,
        StarsCost = 200000
    },
    ["Ninja Mask 2"] = {
        DisplayName = "Ninja Mask 2",
        Rarity = "Mythic",
        Description = "Model Credit: Shiki_Tsugu",
        Icon = "",
        InShop = false,
        StarsCost = 200000
    },
    ["Ninja Mask 3"] = {
        DisplayName = "Ninja Mask 3",
        Rarity = "Mythic",
        Description = "Model Credit: Shiki_Tsugu",
        Icon = "",
        InShop = false,
        StarsCost = 200000
    },
    Eclipse = {
        DisplayName = "Eclipse",
        Rarity = "Celestial",
        Description = "Model Credit: Shiki_Tsugu",
        Icon = "",
        InShop = false,
        StarsCost = 200000
    },
    ["Eclipse Aura"] = {
        DisplayName = "Eclipse Aura",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 200000
    },
    Martial = {
        DisplayName = "Martial",
        Rarity = "Mythic",
        Description = "Model Credit: Yami",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Martial Dragon"] = {
        DisplayName = "Martial Dragon",
        Rarity = "Mythic",
        Description = "Model Credit: Yami",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["White Rose"] = {
        DisplayName = "White Rose",
        Rarity = "Mythic",
        Description = "Model Credit: Yami",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Gray Rose"] = {
        DisplayName = "Gray Rose",
        Rarity = "Mythic",
        Description = "Model Credit: Yami",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Astral Body"] = {
        DisplayName = "Astral Body",
        Rarity = "Mythic",
        Description = "Model Credit: Yami",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Red Cloud"] = {
        DisplayName = "Red Cloud",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Mechanical Arms"] = {
        DisplayName = "Mechanical Arms",
        Rarity = "Mythic",
        Description = "Model Credit: Shiki_Tsugu",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    Astray = {
        DisplayName = "Astray",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    Jetstream = {
        DisplayName = "Jetstream",
        Rarity = "Celestial",
        Description = "Model Credit: Shiki_Tsugu",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Unrestricted = {
        DisplayName = "Unrestricted",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Divine Wheel"] = {
        DisplayName = "Divine Wheel",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Divine Clothes"] = {
        DisplayName = "Divine Clothes",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Supreme Aura"] = {
        DisplayName = "Supreme Aura",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3500
    },
    ["Supreme Warrior"] = {
        DisplayName = "Supreme Warrior",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Alt Supreme Warrior"] = {
        DisplayName = "Alt Supreme Warrior",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3500
    },
    ["Lionheart Armor"] = {
        DisplayName = "Lionheart Armor",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Lionheart Casual"] = {
        DisplayName = "Lionheart Casual",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Artemis = {
        DisplayName = "Artemis",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Alcideus = {
        DisplayName = "Alcideus",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    King = {
        DisplayName = "King",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Ghoul Hunter"] = {
        DisplayName = "Ghoul Hunter",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Oni = {
        DisplayName = "Oni",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Flame Company"] = {
        DisplayName = "Flame Company",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Flame Company Dark"] = {
        DisplayName = "Flame Company Dark",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Swordsman Dark"] = {
        DisplayName = "Swordsman Dark",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000
    },
    Vessel = {
        DisplayName = "Vessel",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Martial Artist"] = {
        DisplayName = "Martial Artist",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Martial Artist Dark"] = {
        DisplayName = "Martial Artist Dark",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ADEX = {
        DisplayName = "ADEX",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Shadow Knight"] = {
        DisplayName = "Shadow Knight",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Beta = {
        DisplayName = "Beta",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Restricted = {
        DisplayName = "Restricted",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Blossom = {
        DisplayName = "Blossom",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3500
    },
    Satori = {
        DisplayName = "Satori",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Satori Raw"] = {
        DisplayName = "Satori Raw",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Sage = {
        DisplayName = "Sage",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3500
    },
    ["Game Player"] = {
        DisplayName = "Game Player",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Plague Doctor"] = {
        DisplayName = "Plague Doctor",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000
    },
    Wooden = {
        DisplayName = "Wooden Armor",
        Rarity = "Common",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 50
    },
    Goblin = {
        DisplayName = "Goblin Armor",
        Rarity = "Uncommon",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 100
    },
    Knight = {
        DisplayName = "Knight Armor",
        Rarity = "Rare",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 170
    },
    ["Great Knight"] = {
        DisplayName = "Great Knight Armor",
        Rarity = "Epic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 500
    },
    ["Bounty Hunter"] = {
        DisplayName = "Bounty Hunter",
        Rarity = "Exotic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 4500
    },
    ["Dark Bounty Hunter"] = {
        DisplayName = "Dark Bounty Hunter",
        Rarity = "Exotic",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Guildmaster = {
        DisplayName = "Guildmaster",
        Rarity = "Exotic",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Ronin = {
        DisplayName = "Ronin",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000,
        IncludedSets = { "Ronin Headband", "Ronin Mask", "Ronin Headband Mask" }
    },
    ["Ronin Headband"] = {
        DisplayName = "Ronin Headband",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 0
    },
    ["Ronin Mask"] = {
        DisplayName = "Ronin Mask",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 0
    },
    ["Ronin Headband Mask"] = {
        DisplayName = "Ronin Headband Mask",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 0
    },
    ["Ronin White"] = {
        DisplayName = "Ronin white",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 0
    },
    ["Knight Banneret"] = {
        DisplayName = "Knight Banneret",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000
    },
    Warrior = {
        DisplayName = "Warrior",
        Rarity = "Epic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 500
    },
    ["Sun Clad"] = {
        DisplayName = "Sun Clad",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 0
    },
    ["Sea Demon"] = {
        DisplayName = "Sea Demon",
        Rarity = "Exotic",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 0
    },
    ["Cursed Child"] = {
        DisplayName = "Cursed Child",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3500
    },
    Dragonguard = {
        DisplayName = "Dragonguard",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    Dynasty = {
        DisplayName = "Dynasty",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Dynasty Female"] = {
        DisplayName = "Dynasty Female",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Warren Leather"] = {
        DisplayName = "Warren Leather",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Obsidian Wolf"] = {
        DisplayName = "Obsidian Wolf",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3500
    },
    Lionguard = {
        DisplayName = "Lionguard",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3500
    },
    ["Grand Founder"] = {
        DisplayName = "Grand Founder",
        Rarity = "Exotic",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Grand Imperator"] = {
        DisplayName = "Grand Imperator",
        Rarity = "Exotic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 4500
    },
    ["Grand Inquisitor"] = {
        DisplayName = "Grand Inquisitor",
        Rarity = "Exotic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 4500
    },
    ["Knight Lord"] = {
        DisplayName = "Knight Lord",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 4500
    },
    ["Monster Slayer"] = {
        DisplayName = "Monster Slayer",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000
    },
    ["Sun Kong"] = {
        DisplayName = "Sun Kong",
        Rarity = "Exotic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 4500
    },
    ["Straw Hat Light"] = {
        DisplayName = "Straw Hat Light",
        Rarity = "Rare",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 250
    },
    ["Straw Hat Dark"] = {
        DisplayName = "Straw Hat Dark",
        Rarity = "Epic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 500
    },
    ["Desert Poncho"] = {
        DisplayName = "Desert Poncho",
        Rarity = "Epic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 500
    },
    ["Rogue Ninja Cape"] = {
        DisplayName = "Rogue Ninja Cape",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000
    },
    ["Sage Scarf"] = {
        DisplayName = "Sage Scarf",
        Rarity = "Legendary",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 2000
    },
    ["Golden Halo"] = {
        DisplayName = "Golden Halo",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Diamond Halo"] = {
        DisplayName = "Diamond Halo",
        Rarity = "Mythic",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3000
    },
    ["Corrupted Halo"] = {
        DisplayName = "Corrupted Halo",
        Rarity = "Celestial",
        Description = "",
        Icon = "",
        InShop = true,
        StarsCost = 3500
    },
    Cloud = {
        DisplayName = "Cloud",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Vergil = {
        DisplayName = "Vergil",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Gojo = {
        DisplayName = "Gojo",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    SJW = {
        DisplayName = "SJW",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["SJW Mustang"] = {
        DisplayName = "SJW Mustang",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Chin Wu"] = {
        DisplayName = "Chin Wu",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Gunner = {
        DisplayName = "Gunner",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Celine1 = {
        DisplayName = "Celine1",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Kieru1 = {
        DisplayName = "Kieru1",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Kieru2 = {
        DisplayName = "Kieru2",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Kieru3 = {
        DisplayName = "Kieru3",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    Sovereign = {
        DisplayName = "Sovereign",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Dark Pyro"] = {
        DisplayName = "Dark Pyro",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Dark Coyote"] = {
        DisplayName = "Dark Coyote",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Dark Revenant"] = {
        DisplayName = "Dark Revenant",
        Rarity = "Exotic",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    },
    ["Dark Mage Professor"] = {
        DisplayName = "Dark Mage Professor",
        Rarity = "Admin",
        Description = "",
        Icon = "",
        InShop = false,
        StarsCost = 3000
    }
};
u1.Catalog = u5;

function u1.Get(p6: string) -- Line: 1203
    -- upvalues: u5 (copy)
    return u5[p6];
end;

function u1.GetAll() -- Line: 1208
    -- upvalues: u5 (copy)
    local v7 = {};

    for i in u5 do
        table.insert(v7, i);
    end;

    return v7;
end;

function u1.GetShopItems() -- Line: 1218
    -- upvalues: u5 (copy)
    local v8 = {};

    for i, v in u5 do
        if v.InShop then
            v8[i] = {
                DisplayName = v.DisplayName,
                Rarity = v.Rarity,
                Description = v.Description,
                Icon = v.Icon,
                StarsCost = v.StarsCost
            };
        end;
    end;

    return v8;
end;

function u1.Validate(p9: string) -- Line: 1236
    -- upvalues: u5 (copy)
    if u5[p9] then
        return true, nil;
    end;

    return false, "Unknown cosmetic set: " .. tostring(p9);
end;

function u1.IsValidSlot(p10: string) -- Line: 1244
    -- upvalues: u2 (copy)
    return u2[p10] == true;
end;

function u1.GetLocationsForSlot(p11: string) -- Line: 1249
    -- upvalues: u1 (copy)
    return u1.SLOT_TO_LOCATIONS[p11];
end;

return u1;