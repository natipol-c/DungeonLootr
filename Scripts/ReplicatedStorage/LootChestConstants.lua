--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LootChestConstants
  Path:     game.ReplicatedStorage.GameInfo.LootChestConstants
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local Image_Data = require(script.Parent:WaitForChild("Image_Data"));

return {
    RewardIcons = {
        RarityWeapon = "",
        UpgradeStone = Image_Data.Crystals.Reroll,
        RarityCrystal = Image_Data.Crystals.Common
    },
    UpgradeStoneImages = Image_Data.UpgradeStones,
    RarityColors = {
        Common = Color3.fromRGB(180, 180, 180),
        Uncommon = Color3.fromRGB(100, 200, 100),
        Rare = Color3.fromRGB(80, 140, 255),
        Epic = Color3.fromRGB(180, 80, 255),
        Legendary = Color3.fromRGB(255, 180, 40),
        Mythic = Color3.fromRGB(255, 60, 100),
        Celestial = Color3.fromRGB(255, 50, 255)
    },
    AnticipationDurations = {
        Common = 1,
        Mid = 2,
        Jackpot = 4
    },
    RewardToTier = {
        RarityCrystal = "Common",
        UpgradeStone = "Mid",
        RarityWeapon = "Jackpot"
    },
    HighlightConfig = {
        FillTransparency = 0.6,
        OutlineTransparency = 0.3,
        StartColor = Color3.fromRGB(60, 60, 60),
        PeakColor = Color3.fromRGB(255, 255, 255)
    },
    CHEST_TIMEOUT = 30,
    REVEAL_DISPLAY_TIME = 5
};