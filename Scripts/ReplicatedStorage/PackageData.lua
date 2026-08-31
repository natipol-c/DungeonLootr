--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PackageData
  Path:     game.ReplicatedStorage.GameInfo.PackageData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local CosmeticData = require(script.Parent.CosmeticData);
local Image_Data = require(script.Parent.Image_Data);
local u1 = {
    Packages = {
        BlackVampireHunterPack = {
            Name = "Black Vampire Hunter Set",
            Description = "The complete Black Vampire Hunter cosmetic set.",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Black Vampire Hunter"
                } }
        },
        RedVampireHunterPack = {
            Name = "Red Vampire Hunter Set",
            Description = "The complete Red Vampire Hunter cosmetic set.",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Red Vampire Hunter"
                } }
        },
        WhiteVampireHunterPack = {
            Name = "White Vampire Hunter Set",
            Description = "The complete White Vampire Hunter cosmetic set.",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "White Vampire Hunter"
                } }
        },
        BlackInfernalHunterPack = {
            Name = "Black Infernal Hunter Set",
            Description = "The complete Black Infernal Hunter cosmetic set.",
            Icon = "rbxassetid://107165948635767",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Black Infernal Hunter"
                } }
        },
        BrownInfernalHunterPack = {
            Name = "Brown Infernal Hunter Set",
            Description = "The complete Brown Infernal Hunter cosmetic set.",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Brown Infernal Hunter"
                } }
        },
        WhiteInfernalHunterPack = {
            Name = "White Infernal Hunter Set",
            Description = "The complete White Infernal Hunter cosmetic set.",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "White Infernal Hunter"
                } }
        },
        RedInfernalHunterPack = {
            Name = "Red Infernal Hunter Set",
            Description = "The complete Red Infernal Hunter cosmetic set.",
            Icon = "rbxassetid://135630187839027",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Red Infernal Hunter"
                } }
        },
        VagabondPack = {
            Name = "Vagabond Set",
            Description = "The complete Vagabond cosmetic collection.",
            Icon = "rbxassetid://107165948635767",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Vagabond"
                } }
        },
        ScarletKnightPack = {
            Name = "Scarlet Knight Set",
            Description = "The complete Scarlet Knight cosmetic set.",
            Icon = "rbxassetid://135630187839027",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Scarlet Knight"
                } }
        },
        CoyotePack = {
            Name = "Coyote Set",
            Description = "The complete Coyote cosmetic set.",
            Icon = "rbxassetid://74434140369578",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Coyote Set"
                } }
        },
        DarkShinobiPack = {
            Name = "Dark Shinobi Set",
            Description = "The complete Dark Shinobi collection.",
            Icon = "rbxassetid://107165948635767",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Dark Shinobi"
                } }
        },
        LightShinobiPack = {
            Name = "Light Shinobi Set",
            Description = "The complete Light Shinobi collection.",
            Icon = "rbxassetid://132881669421234",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Light Shinobi"
                } }
        },
        BerserkerPack = {
            Name = "Berserker Set",
            Description = "The complete Berserker collection.",
            Icon = "rbxassetid://135630187839027",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Berserker"
                } }
        },
        UmbralPack = {
            Name = "Umbral Set",
            Description = "The complete Umbral collection.",
            Icon = "rbxassetid://107165948635767",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Umbral"
                } }
        },
        ReaperPack = {
            Name = "Reaper Set",
            Description = "The complete Reaper collection.",
            Icon = "rbxassetid://107165948635767",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Reaper"
                } }
        },
        MidnightSamuraiPack = {
            Name = "Midnight Samurai Set",
            Description = "The complete Midnight Samurai cosmetic set.",
            Icon = "rbxassetid://135630187839027",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Midnight Samurai"
                } }
        },
        TyphoonPack = {
            Name = "Typhoon Set",
            Description = "The complete Typhoon cosmetic set.",
            Icon = "rbxassetid://87633763556362",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Typhoon"
                } }
        },
        SlayerPack = {
            Name = "Slayer Set",
            Description = "The complete Slayer cosmetic set.",
            Icon = "rbxassetid://87633763556362",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Slayer Set"
                } }
        },
        FlameSamuraiPack = {
            Name = "Flame Samurai Set",
            Description = "The complete Flame Samurai cosmetic set.",
            Icon = "rbxassetid://87633763556362",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Flame Samurai"
                } }
        },
        ForgeArchonPack = {
            Name = "Forge Archon Set",
            Description = "The complete Forge Archon cosmetic set.",
            Icon = "rbxassetid://87633763556362",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Forge Archon"
                } }
        },
        ForgeArchonAura = {
            Name = "Forge Archon Aura",
            Description = "Aura for the Forge Archon Set.",
            Icon = "rbxassetid://87633763556362",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Forge Archon Aura"
                } }
        },
        SeaDemonPack = {
            Name = "Sea Demon Set",
            Description = "The complete Sea Demon cosmetic set.",
            Rarity = "Exotic",
            ChestType = "Flame",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Sea Demon"
                } }
        },
        SunCladPack = {
            Name = "Sun Clad Set",
            Description = "The complete Sun Clad cosmetic set.",
            Rarity = "Mythic",
            ChestType = "Holy",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Sun Clad"
                } }
        },
        WarriorPack = {
            Name = "Warrior Set",
            Description = "The complete Warrior cosmetic set.",
            Rarity = "Epic",
            ChestType = "Plain",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Warrior"
                } }
        },
        KnightBanneretPack = {
            Name = "Knight Banneret Set",
            Description = "The complete Knight Banneret cosmetic set.",
            Rarity = "Legendary",
            ChestType = "Ruby",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Knight Banneret"
                } }
        },
        RoninPack = {
            Name = "Ronin Set",
            Description = "The complete Ronin cosmetic set.",
            Rarity = "Legendary",
            ChestType = "Diamond",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Ronin"
                } }
        },
        GuildmasterPack = {
            Name = "Guildmaster Set",
            Description = "The complete Guildmaster cosmetic set.",
            Rarity = "Exotic",
            ChestType = "Royal",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Guildmaster"
                } }
        },
        BountyHunterPack = {
            Name = "Bounty Hunter Set",
            Description = "The complete Bounty Hunter cosmetic set.",
            Rarity = "Celestial",
            ChestType = "Soul",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Bounty Hunter"
                } }
        },
        GreatKnightPack = {
            Name = "Great Knight Set",
            Description = "The complete Great Knight cosmetic set.",
            Rarity = "Epic",
            ChestType = "Blue",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Great Knight"
                } }
        },
        KnightPack = {
            Name = "Knight Set",
            Description = "The complete Knight cosmetic set.",
            Rarity = "Rare",
            ChestType = "Ruby",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Knight"
                } }
        },
        GoblinPack = {
            Name = "Goblin Set",
            Description = "The complete Goblin cosmetic set.",
            Rarity = "Uncommon",
            ChestType = "Emerald",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Goblin"
                } }
        },
        WoodenPack = {
            Name = "Wooden Set",
            Description = "The complete Wooden cosmetic set.",
            Rarity = "Common",
            ChestType = "Plain",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Wooden"
                } }
        },
        PlagueDoctorPack = {
            Name = "Plague Doctor Set",
            Description = "The complete Plague Doctor cosmetic set.",
            Rarity = "Legendary",
            ChestType = "Diamond",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Plague Doctor"
                } }
        },
        SagePack = {
            Name = "Sage Set",
            Description = "The complete Sage cosmetic set.",
            Rarity = "Celestial",
            ChestType = "Flame",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Sage"
                } }
        },
        SatoriRawPack = {
            Name = "Satori Raw Set",
            Description = "The complete Satori Raw cosmetic set.",
            Rarity = "Celestial",
            ChestType = "Soul",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Satori Raw"
                } }
        },
        SatoriPack = {
            Name = "Satori Set",
            Description = "The complete Satori cosmetic set.",
            Rarity = "Celestial",
            ChestType = "Holy",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Satori"
                } }
        },
        BlossomPack = {
            Name = "Blossom Set",
            Description = "The complete Blossom cosmetic set.",
            Rarity = "Celestial",
            ChestType = "Ruby",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Blossom"
                } }
        },
        ShadowKnightPack = {
            Name = "Shadow Knight Set",
            Description = "The complete Shadow Knight cosmetic set.",
            Rarity = "Celestial",
            ChestType = "Soul",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Shadow Knight"
                } }
        },
        ADEXPack = {
            Name = "ADEX Set",
            Description = "The complete ADEX cosmetic set.",
            Rarity = "Celestial",
            ChestType = "Soul",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "ADEX"
                } }
        },
        AstrayPack = {
            Name = "Astray Set",
            Description = "The complete Astray cosmetic set.",
            Rarity = "Mythic",
            ChestType = "Flame",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Astray"
                } }
        },
        KnightLordPack = {
            Name = "Knight Lord Set",
            Description = "A rare relic recovered from the Forgotten Ruins — the complete Knight Lord cosmetic set.",
            Rarity = "Legendary",
            ChestType = "Holy",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Knight Lord"
                } }
        },
        ObsidianWolfPack = {
            Name = "Obsidian Wolf Set",
            Description = "A prize torn from the bandits\' hoard — the complete Obsidian Wolf cosmetic set.",
            Rarity = "Celestial",
            ChestType = "Flame",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Obsidian Wolf"
                } }
        },
        VesselPack = {
            Name = "The Vessel",
            Description = "A body offered to the throne of curses. Grants the complete Vessel cosmetic set and the \"Cursed King\" title.",
            Rarity = "Exotic",
            ChestType = "Flame",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Vessel"
                }, {
                    Type = "Title",
                    Id = "Cursed_King"
                } }
        },
        SupremeWarriorPackage = {
            Name = "Supreme Warrior Package",
            Description = "",
            Icon = "rbxassetid://87633763556362",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Supreme Warrior"
                } }
        },
        AltSupremeWarriorPackage = {
            Name = "Alt Supreme Warrior Package",
            Description = "",
            Icon = "rbxassetid://135630187839027",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Alt Supreme Warrior"
                } }
        },
        JetstreamPack = {
            Name = "Jetstream Set",
            Description = "The complete Jetstream cosmetic set.",
            Icon = "rbxassetid://87633763556362",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Jetstream"
                } }
        },
        DivineWheelPack = {
            Name = "Divine Wheel Set",
            Description = "The complete Divine Wheel cosmetic set.",
            Rarity = "Celestial",
            ChestType = "Prismatic",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Divine Wheel"
                } }
        },
        RedCloudPack = {
            Name = "Red Cloud Set",
            Description = "The complete Red Cloud cosmetic set.",
            Icon = "rbxassetid://87633763556362",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Red Cloud"
                } }
        },
        BetaPack = {
            Name = "Beta Set",
            Description = "The complete Beta cosmetic set.",
            Rarity = "Celestial",
            ChestType = "Prismatic",
            Icon = "rbxassetid://87633763556362",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Beta"
                } }
        },
        BlackSwordsmanPack = {
            Name = "Black Swordsman Set",
            Description = "The complete Black Swordsman cosmetic set.",
            Rarity = "Mythic",
            Icon = Image_Data.ChestTypes.Flame,
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Black Swordsman"
                } }
        },
        GamePlayerPack = {
            Name = "Game Player Set",
            Description = "The complete Game Player cosmetic set.",
            Rarity = "Celestial",
            Icon = "rbxassetid://87633763556362",
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Game Player"
                } }
        },
        EclipsePack = {
            Name = "Eclipse Set",
            Description = "The complete Eclipse cosmetic set.",
            Rarity = "Celestial",
            Icon = Image_Data.ChestTypes.Soul,
            Contents = { {
                    Type = "Cosmetic",
                    Id = "Eclipse"
                } }
        },
        MysteryBox_x2 = {
            Name = "2x Mystery Box",
            Description = "Two consecutive Mystery Box pulls — double the chaos.",
            Rarity = "Legendary",
            Icon = "rbxassetid://98670960915463",
            Contents = { {
                    Type = "Package",
                    Id = "MysteryBox"
                }, {
                    Type = "Package",
                    Id = "MysteryBox"
                } }
        },
        BuffPotionBundle = {
            Name = "Buff Potion Bundle",
            Description = "A random assortment of buff potions — themed around combat, fortune, or scholarship.",
            Rarity = "Rare",
            Icon = "rbxassetid://128983548692880",
            RandomPool = { {
                    PackageId = "BuffBundle_Assault",
                    Weight = 1
                }, {
                    PackageId = "BuffBundle_Fortune",
                    Weight = 1
                }, {
                    PackageId = "BuffBundle_Scholar",
                    Weight = 1
                }, {
                    PackageId = "BuffBundle_Champion",
                    Weight = 1
                } }
        },
        BuffBundle_Assault = {
            Name = "Assault Buff Bundle",
            Description = "2 Damage Potions + 1 Swift Potion.",
            Rarity = "Rare",
            Contents = { {
                    Type = "BuffPotion",
                    Id = "DamagePotion",
                    Amount = 2
                }, {
                    Type = "BuffPotion",
                    Id = "SwiftPotion",
                    Amount = 1
                } }
        },
        BuffBundle_Fortune = {
            Name = "Fortune Buff Bundle",
            Description = "2 Lucky Potions + 1 EXP Potion.",
            Rarity = "Rare",
            Contents = { {
                    Type = "BuffPotion",
                    Id = "LuckyPotion",
                    Amount = 2
                }, {
                    Type = "BuffPotion",
                    Id = "EXPPotion",
                    Amount = 1
                } }
        },
        BuffBundle_Scholar = {
            Name = "Scholar Buff Bundle",
            Description = "2 EXP Potions + 1 Class XP Potion.",
            Rarity = "Rare",
            Contents = { {
                    Type = "BuffPotion",
                    Id = "EXPPotion",
                    Amount = 2
                }, {
                    Type = "BuffPotion",
                    Id = "ClassXPPotion",
                    Amount = 1
                } }
        },
        BuffBundle_Champion = {
            Name = "Champion Buff Bundle",
            Description = "One of each — Damage, Swift, and Lucky.",
            Rarity = "Epic",
            Contents = { {
                    Type = "BuffPotion",
                    Id = "DamagePotion",
                    Amount = 1
                }, {
                    Type = "BuffPotion",
                    Id = "SwiftPotion",
                    Amount = 1
                }, {
                    Type = "BuffPotion",
                    Id = "LuckyPotion",
                    Amount = 1
                } }
        },
        GMBlessing1 = {
            Name = "GM Blessing I",
            Description = "50 Coins, 2 Class EXP Potions, 2 Normal Spins, 3 Iron Scrap, 2 Iron Ore, 2 Common + 1 Uncommon Ingot",
            Rarity = "Rare",
            Icon = "rbxassetid://138516281831268",
            Contents = { {
                    Type = "Coins",
                    Amount = 50
                }, {
                    Type = "ClassEXPPotion",
                    Amount = 2
                }, {
                    Type = "NormalSpins",
                    Amount = 2
                }, {
                    Type = "CraftingMaterial",
                    Id = "Iron Scrap",
                    Amount = 3
                }, {
                    Type = "CraftingMaterial",
                    Id = "Iron Ore",
                    Amount = 2
                }, {
                    Type = "CraftingMaterial",
                    Id = "Common Ingot",
                    Amount = 2
                }, {
                    Type = "CraftingMaterial",
                    Id = "Uncommon Ingot",
                    Amount = 1
                } }
        },
        GMBlessing2 = {
            Name = "GM Blessing II",
            Description = "7 Stars, 175 Coins, 3 Normal Spins, 3 Iron Ore, 2 Gold Ore, 1 Forge Stone Bundle, 2 Uncommon + 1 Rare Ingot",
            Rarity = "Epic",
            Icon = "rbxassetid://138516281831268",
            Contents = { {
                    Type = "Stars",
                    Amount = 7
                }, {
                    Type = "Coins",
                    Amount = 175
                }, {
                    Type = "NormalSpins",
                    Amount = 3
                }, {
                    Type = "CraftingMaterial",
                    Id = "Iron Ore",
                    Amount = 3
                }, {
                    Type = "CraftingMaterial",
                    Id = "Gold Ore",
                    Amount = 2
                }, {
                    Type = "Package",
                    Id = "ForgeStonePackage"
                }, {
                    Type = "CraftingMaterial",
                    Id = "Uncommon Ingot",
                    Amount = 2
                }, {
                    Type = "CraftingMaterial",
                    Id = "Rare Ingot",
                    Amount = 1
                } }
        },
        GMBlessing3 = {
            Name = "GM Blessing III",
            Description = "35 Stars, 10 Class EXP Potions, 2 Lucky Spins, 3 Gold Ore, 2 Obsidian Ore, 1 Forge Stone Bundle, 1 Reforge Stone, 2 Rare + 1 Epic Ingot",
            Rarity = "Legendary",
            Icon = "rbxassetid://138516281831268",
            Contents = { {
                    Type = "Stars",
                    Amount = 35
                }, {
                    Type = "ClassEXPPotion",
                    Amount = 10
                }, {
                    Type = "LuckySpins",
                    Amount = 2
                }, {
                    Type = "CraftingMaterial",
                    Id = "Gold Ore",
                    Amount = 3
                }, {
                    Type = "CraftingMaterial",
                    Id = "Obsidian Ore",
                    Amount = 2
                }, {
                    Type = "Package",
                    Id = "ForgeStonePackage"
                }, {
                    Type = "CraftingMaterial",
                    Id = "Reforge Stone",
                    Amount = 1
                }, {
                    Type = "CraftingMaterial",
                    Id = "Rare Ingot",
                    Amount = 2
                }, {
                    Type = "CraftingMaterial",
                    Id = "Epic Ingot",
                    Amount = 1
                } }
        },
        GMBlessing4 = {
            Name = "GM Blessing IV",
            Description = "350 Coins, 10 Class EXP Potions, 5 Lucky Spins, 3 Obsidian Ore, 2 Celestial Ore, 1 Forge Stone Bundle, 1 Reforge Stone, 2 Epic + 1 Legendary + 1 Mythic Ingot",
            Rarity = "Legendary",
            Icon = "rbxassetid://138516281831268",
            Contents = { {
                    Type = "Coins",
                    Amount = 350
                }, {
                    Type = "ClassEXPPotion",
                    Amount = 10
                }, {
                    Type = "LuckySpins",
                    Amount = 5
                }, {
                    Type = "CraftingMaterial",
                    Id = "Obsidian Ore",
                    Amount = 3
                }, {
                    Type = "CraftingMaterial",
                    Id = "Celestial Ore",
                    Amount = 2
                }, {
                    Type = "Package",
                    Id = "ForgeStonePackage"
                }, {
                    Type = "CraftingMaterial",
                    Id = "Reforge Stone",
                    Amount = 1
                }, {
                    Type = "CraftingMaterial",
                    Id = "Epic Ingot",
                    Amount = 2
                }, {
                    Type = "CraftingMaterial",
                    Id = "Legendary Ingot",
                    Amount = 1
                }, {
                    Type = "CraftingMaterial",
                    Id = "Mythic Ingot",
                    Amount = 1
                } }
        },
        StarterCompensation = {
            Name = "Starter Compensation",
            Description = "A small token of appreciation.",
            Rarity = "Uncommon",
            Icon = "rbxassetid://128983548692880",
            Contents = { {
                    Type = "Coins",
                    Amount = 5000
                }, {
                    Type = "NormalSpins",
                    Amount = 10
                }, {
                    Type = "LuckySpins",
                    Amount = 3
                } }
        },
        MajorCompensation = {
            Name = "Major Compensation",
            Description = "A generous compensation package.",
            Rarity = "Epic",
            Icon = "rbxassetid://132881669421234",
            Contents = { {
                    Type = "Coins",
                    Amount = 25000
                }, {
                    Type = "Stars",
                    Amount = 1000
                }, {
                    Type = "NormalSpins",
                    Amount = 25
                }, {
                    Type = "LuckySpins",
                    Amount = 10
                }, {
                    Type = "ClassEXPPotion",
                    Amount = 10
                } }
        },
        ReturningPlayerPackage = {
            Name = "Returning Player Package",
            Description = "Welcome back, adventurer! A thank-you for sticking with us through the great migration.",
            Rarity = "Epic",
            Icon = "rbxassetid://128983548692880",
            Contents = { {
                    Type = "Coins",
                    Amount = 5000
                }, {
                    Type = "NormalSpins",
                    Amount = 10
                }, {
                    Type = "LuckySpins",
                    Amount = 3
                }, {
                    Type = "ClassEXPPotion",
                    Amount = 5
                } }
        },
        LoyalPlayerPackage = {
            Name = "Loyal Player Package",
            Description = "For the truly devoted — those who carried the game\'s earliest banners.",
            Rarity = "Legendary",
            Icon = "rbxassetid://132881669421234",
            Contents = { {
                    Type = "Coins",
                    Amount = 25000
                }, {
                    Type = "Stars",
                    Amount = 100
                }, {
                    Type = "LuckySpins",
                    Amount = 10
                }, {
                    Type = "ClassEXPPotion",
                    Amount = 15
                } }
        },
        WelcomeBackPackage = {
            Name = "Welcome Back Bundle",
            Description = "35,000 Coins, 2,000 Stars, 40 Normal Spins, 10 Lucky Spins, 15 Protection Scrolls, and 5 Forge Stone Bundles — a thank-you to our Goodbye Bundle faithful.",
            Rarity = "Legendary",
            Icon = "rbxassetid://132881669421234",
            Contents = { {
                    Type = "Coins",
                    Amount = 35000
                }, {
                    Type = "Stars",
                    Amount = 2000
                }, {
                    Type = "NormalSpins",
                    Amount = 40
                }, {
                    Type = "LuckySpins",
                    Amount = 10
                }, {
                    Type = "ProtectionScroll",
                    Amount = 15
                }, {
                    Type = "Package",
                    Id = "ForgeStonePackage"
                }, {
                    Type = "Package",
                    Id = "ForgeStonePackage"
                }, {
                    Type = "Package",
                    Id = "ForgeStonePackage"
                }, {
                    Type = "Package",
                    Id = "ForgeStonePackage"
                }, {
                    Type = "Package",
                    Id = "ForgeStonePackage"
                } }
        },
        RandomGMBlessing = {
            Name = "Random GM Blessing",
            Description = "Opens into a random GM Blessing (I-IV) with equal chance.",
            Rarity = "Legendary",
            Icon = "rbxassetid://138516281831268",
            RandomPool = { {
                    PackageId = "GMBlessing1",
                    Weight = 1
                }, {
                    PackageId = "GMBlessing2",
                    Weight = 1
                }, {
                    PackageId = "GMBlessing3",
                    Weight = 1
                }, {
                    PackageId = "GMBlessing4",
                    Weight = 1
                } }
        },
        BossDropCoins = {
            Name = "Boss Coins",
            Description = "A pile of coins from a defeated boss.",
            Rarity = "Uncommon",
            Contents = { {
                    Type = "Coins",
                    Amount = 100
                } }
        },
        BossDropBuffPotion = {
            Name = "Boss Buff Potion",
            Description = "A random buff potion from a defeated boss.",
            Rarity = "Rare",
            RandomPool = { {
                    PackageId = "BossDropBuff_Swift",
                    Weight = 3
                }, {
                    PackageId = "BossDropBuff_EXP",
                    Weight = 3
                }, {
                    PackageId = "BossDropBuff_Lucky",
                    Weight = 2
                }, {
                    PackageId = "BossDropBuff_Damage",
                    Weight = 2
                } }
        },
        BossDropBuff_Swift = {
            Name = "Swift Potion",
            Description = "A Swift Potion from a defeated boss.",
            Rarity = "Rare",
            Contents = { {
                    Type = "BuffPotion",
                    Id = "SwiftPotion",
                    Amount = 1
                } }
        },
        BossDropBuff_EXP = {
            Name = "EXP Potion",
            Description = "An EXP Potion from a defeated boss.",
            Rarity = "Rare",
            Contents = { {
                    Type = "BuffPotion",
                    Id = "EXPPotion",
                    Amount = 1
                } }
        },
        BossDropBuff_Lucky = {
            Name = "Lucky Potion",
            Description = "A Lucky Potion from a defeated boss.",
            Rarity = "Rare",
            Contents = { {
                    Type = "BuffPotion",
                    Id = "LuckyPotion",
                    Amount = 1
                } }
        },
        BossDropBuff_Damage = {
            Name = "Damage Potion",
            Description = "A Damage Potion from a defeated boss.",
            Rarity = "Rare",
            Contents = { {
                    Type = "BuffPotion",
                    Id = "DamagePotion",
                    Amount = 1
                } }
        },
        BossDropClassEXP = {
            Name = "Boss Class EXP",
            Description = "A bundle of Class EXP Potions from a defeated boss.",
            Rarity = "Epic",
            Contents = { {
                    Type = "ClassEXPPotion",
                    Amount = 10
                }, {
                    Type = "Stars",
                    Amount = 25
                } }
        },
        BossPackage = {
            Name = "Boss Loot Box",
            Description = "Loot from a defeated boss. Could be coins, potions, or something legendary...",
            Rarity = "Legendary",
            Icon = "rbxassetid://132881669421234",
            RandomPool = { {
                    PackageId = "BossDropCoins",
                    Weight = 40
                }, {
                    PackageId = "BossDropBuffPotion",
                    Weight = 30
                }, {
                    PackageId = "RandomGMBlessing",
                    Weight = 15
                }, {
                    PackageId = "BossDropClassEXP",
                    Weight = 10
                }, {
                    PackageId = "GMBlessing4",
                    Weight = 5
                } }
        },
        LegendaryGearPack = {
            Name = "Legendary Gear Set",
            Description = "A full set of Legendary-rarity equipment.",
            Rarity = "Legendary",
            Icon = Image_Data.ChestTypes.Diamond,
            Contents = { {
                    Type = "Equipment",
                    Rarity = "Legendary",
                    Slot = "Head"
                }, {
                    Type = "Equipment",
                    Rarity = "Legendary",
                    Slot = "Body"
                }, {
                    Type = "Equipment",
                    Rarity = "Legendary",
                    Slot = "Ring"
                } }
        },
        MythicGearPack = {
            Name = "Mythic Gear Set",
            Description = "A full set of Mythic-rarity equipment — Head, Body, and Ring.",
            Rarity = "Mythic",
            Icon = Image_Data.ChestTypes.Ruby,
            Contents = { {
                    Type = "Equipment",
                    Rarity = "Mythic",
                    Slot = "Head"
                }, {
                    Type = "Equipment",
                    Rarity = "Mythic",
                    Slot = "Body"
                }, {
                    Type = "Equipment",
                    Rarity = "Mythic",
                    Slot = "Ring"
                } }
        },
        EpicGearPack = {
            Name = "Epic Gear Set",
            Description = "A full set of Epic-rarity equipment.",
            Rarity = "Epic",
            Icon = Image_Data.ChestTypes.Emerald,
            Contents = { {
                    Type = "Equipment",
                    Rarity = "Epic",
                    Slot = "Head"
                }, {
                    Type = "Equipment",
                    Rarity = "Epic",
                    Slot = "Body"
                }, {
                    Type = "Equipment",
                    Rarity = "Epic",
                    Slot = "Ring"
                } }
        },
        RareGearPack = {
            Name = "Rare Gear Set",
            Description = "A full set of Rare-rarity equipment.",
            Rarity = "Rare",
            Icon = Image_Data.ChestTypes.Blue,
            Contents = { {
                    Type = "Equipment",
                    Rarity = "Rare",
                    Slot = "Head"
                }, {
                    Type = "Equipment",
                    Rarity = "Rare",
                    Slot = "Body"
                }, {
                    Type = "Equipment",
                    Rarity = "Rare",
                    Slot = "Ring"
                } }
        },
        CelestialGearPack = {
            Name = "Celestial Gear Set",
            Description = "A full set of Celestial-rarity equipment — Head, Body, and Ring.",
            Rarity = "Celestial",
            Icon = Image_Data.ChestTypes.Soul,
            Contents = { {
                    Type = "Equipment",
                    Rarity = "Celestial",
                    Slot = "Head"
                }, {
                    Type = "Equipment",
                    Rarity = "Celestial",
                    Slot = "Body"
                }, {
                    Type = "Equipment",
                    Rarity = "Celestial",
                    Slot = "Ring"
                } }
        },
        CelestialRingPack = {
            Name = "Celestial Ring Pack",
            Description = "Contains 1-3 Celestial-rarity Rings. More rings = rarer pull.",
            Rarity = "Celestial",
            Icon = Image_Data.ChestTypes.Soul,
            RandomPool = { {
                    PackageId = "CelestialRing_x1",
                    Weight = 50
                }, {
                    PackageId = "CelestialRing_x2",
                    Weight = 35
                }, {
                    PackageId = "CelestialRing_x3",
                    Weight = 15
                } }
        },
        CelestialRing_x1 = {
            Name = "Celestial Ring x1",
            Rarity = "Celestial",
            Contents = { {
                    Type = "Equipment",
                    Rarity = "Celestial",
                    Slot = "Ring"
                } }
        },
        CelestialRing_x2 = {
            Name = "Celestial Ring x2",
            Rarity = "Celestial",
            Contents = { {
                    Type = "Equipment",
                    Rarity = "Celestial",
                    Slot = "Ring"
                }, {
                    Type = "Equipment",
                    Rarity = "Celestial",
                    Slot = "Ring"
                } }
        },
        CelestialRing_x3 = {
            Name = "Celestial Ring x3",
            Rarity = "Celestial",
            Contents = { {
                    Type = "Equipment",
                    Rarity = "Celestial",
                    Slot = "Ring"
                }, {
                    Type = "Equipment",
                    Rarity = "Celestial",
                    Slot = "Ring"
                }, {
                    Type = "Equipment",
                    Rarity = "Celestial",
                    Slot = "Ring"
                } }
        },
        ForgeStonePackage = {
            Name = "Forge Stone Bundle",
            Description = "A haul of forge Ingots — 5 to 30 of a random rarity. Could be a handful... or a jackpot.",
            Rarity = "Celestial",
            Icon = "rbxassetid://86621319372890",
            RandomPool = { {
                    PackageId = "UpgradeMat_Common",
                    Weight = 10
                }, {
                    PackageId = "UpgradeMat_Uncommon",
                    Weight = 18
                }, {
                    PackageId = "UpgradeMat_Rare",
                    Weight = 22
                }, {
                    PackageId = "UpgradeMat_Epic",
                    Weight = 20
                }, {
                    PackageId = "UpgradeMat_Legendary",
                    Weight = 15
                }, {
                    PackageId = "UpgradeMat_Mythic",
                    Weight = 10
                }, {
                    PackageId = "UpgradeMat_Celestial",
                    Weight = 5
                } }
        },
        UpgradeMat_Common = {
            Name = "Common Ingots",
            Rarity = "Common",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Common Ingot",
                    AmountRange = { 5, 30 }
                } }
        },
        UpgradeMat_Uncommon = {
            Name = "Uncommon Ingots",
            Rarity = "Uncommon",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Uncommon Ingot",
                    AmountRange = { 5, 30 }
                } }
        },
        UpgradeMat_Rare = {
            Name = "Rare Ingots",
            Rarity = "Rare",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Rare Ingot",
                    AmountRange = { 5, 30 }
                } }
        },
        UpgradeMat_Epic = {
            Name = "Epic Ingots",
            Rarity = "Epic",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Epic Ingot",
                    AmountRange = { 5, 30 }
                } }
        },
        UpgradeMat_Legendary = {
            Name = "Legendary Ingots",
            Rarity = "Legendary",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Legendary Ingot",
                    AmountRange = { 5, 30 }
                } }
        },
        UpgradeMat_Mythic = {
            Name = "Mythic Ingots",
            Rarity = "Mythic",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Mythic Ingot",
                    AmountRange = { 5, 30 }
                } }
        },
        UpgradeMat_Celestial = {
            Name = "Celestial Ingots",
            Rarity = "Celestial",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Celestial Ingot",
                    AmountRange = { 5, 30 }
                } }
        },
        ForgeStone_x1 = {
            Name = "1x Forge Stone",
            Rarity = "Rare",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Forge Stone",
                    Amount = 1
                } }
        },
        ForgeStone_x2 = {
            Name = "2x Forge Stone",
            Rarity = "Rare",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Forge Stone",
                    Amount = 2
                } }
        },
        ForgeStone_x3 = {
            Name = "3x Forge Stone",
            Rarity = "Rare",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Forge Stone",
                    Amount = 3
                } }
        },
        ForgeStone_x4 = {
            Name = "4x Forge Stone",
            Rarity = "Rare",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Forge Stone",
                    Amount = 4
                } }
        },
        ForgeStone_x5 = {
            Name = "5x Forge Stone",
            Rarity = "Rare",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Forge Stone",
                    Amount = 5
                } }
        },
        ForgeStone_x6 = {
            Name = "6x Forge Stone",
            Rarity = "Epic",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Forge Stone",
                    Amount = 6
                } }
        },
        ForgeStone_x7 = {
            Name = "7x Forge Stone",
            Rarity = "Epic",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Forge Stone",
                    Amount = 7
                } }
        },
        UpgradeMaterialBox = {
            Name = "Ingot Box",
            Description = "10 Common, 10 Uncommon, and 10 Rare Ingots.",
            Rarity = "Rare",
            Icon = "rbxassetid://98670960915463",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Common Ingot",
                    Amount = 10
                }, {
                    Type = "CraftingMaterial",
                    Id = "Uncommon Ingot",
                    Amount = 10
                }, {
                    Type = "CraftingMaterial",
                    Id = "Rare Ingot",
                    Amount = 10
                } }
        },
        ReforgeStonePackage = {
            Name = "Reforge Stone Bundle",
            Description = "A bundle of Reforge Stones. Handle with care.",
            Rarity = "Celestial",
            Icon = Image_Data.ChestTypes.Ruby,
            RandomPool = { {
                    PackageId = "ReforgeStone_x1",
                    Weight = 45
                }, {
                    PackageId = "ReforgeStone_x2",
                    Weight = 35
                }, {
                    PackageId = "ReforgeStone_x3",
                    Weight = 20
                }, {
                    PackageId = "ReforgeStone_x4",
                    Weight = 15
                } }
        },
        ReforgeStone_x1 = {
            Name = "1x Reforge Stone",
            Rarity = "Epic",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Reforge Stone",
                    Amount = 1
                } }
        },
        ReforgeStone_x2 = {
            Name = "2x Reforge Stone",
            Rarity = "Epic",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Reforge Stone",
                    Amount = 2
                } }
        },
        ReforgeStone_x3 = {
            Name = "3x Reforge Stone",
            Rarity = "Legendary",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Reforge Stone",
                    Amount = 3
                } }
        },
        ReforgeStone_x4 = {
            Name = "4x Reforge Stone",
            Rarity = "Legendary",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Reforge Stone",
                    Amount = 4
                } }
        },
        BundleOfCoins = {
            Name = "Bundle of Coins",
            Description = "A mysterious sack of coins. Could be pocket change... or a fortune.",
            Rarity = "Rare",
            Icon = "rbxassetid://98670960915463",
            RandomPool = { {
                    PackageId = "CoinBundle_100",
                    Weight = 30
                }, {
                    PackageId = "CoinBundle_500",
                    Weight = 25
                }, {
                    PackageId = "CoinBundle_1000",
                    Weight = 20
                }, {
                    PackageId = "CoinBundle_5000",
                    Weight = 12
                }, {
                    PackageId = "CoinBundle_10000",
                    Weight = 10
                }, {
                    PackageId = "CoinBundle_25000",
                    Weight = 7
                }, {
                    PackageId = "CoinBundle_50000",
                    Weight = 4
                }, {
                    PackageId = "CoinBundle_100000",
                    Weight = 2
                } }
        },
        CoinBundle_100 = {
            Name = "100 Coins",
            Rarity = "Common",
            Contents = { {
                    Type = "Coins",
                    Amount = 100
                } }
        },
        CoinBundle_500 = {
            Name = "500 Coins",
            Rarity = "Common",
            Contents = { {
                    Type = "Coins",
                    Amount = 500
                } }
        },
        CoinBundle_1000 = {
            Name = "1,000 Coins",
            Rarity = "Uncommon",
            Contents = { {
                    Type = "Coins",
                    Amount = 1000
                } }
        },
        CoinBundle_5000 = {
            Name = "5,000 Coins",
            Rarity = "Rare",
            Contents = { {
                    Type = "Coins",
                    Amount = 5000
                } }
        },
        CoinBundle_10000 = {
            Name = "10,000 Coins",
            Rarity = "Rare",
            Contents = { {
                    Type = "Coins",
                    Amount = 10000
                } }
        },
        CoinBundle_25000 = {
            Name = "25,000 Coins",
            Rarity = "Epic",
            Contents = { {
                    Type = "Coins",
                    Amount = 25000
                } }
        },
        CoinBundle_50000 = {
            Name = "50,000 Coins",
            Rarity = "Legendary",
            Contents = { {
                    Type = "Coins",
                    Amount = 50000
                } }
        },
        CoinBundle_100000 = {
            Name = "100,000 Coins",
            Rarity = "Mythic",
            Contents = { {
                    Type = "Coins",
                    Amount = 100000
                } }
        },
        Mystery_NormalSpins5 = {
            Name = "5 Normal Spins",
            Rarity = "Common",
            Contents = { {
                    Type = "NormalSpins",
                    Amount = 5
                } }
        },
        Mystery_NormalSpins10 = {
            Name = "10 Normal Spins",
            Rarity = "Uncommon",
            Contents = { {
                    Type = "NormalSpins",
                    Amount = 10
                } }
        },
        Mystery_LuckySpins3 = {
            Name = "3 Lucky Spins",
            Rarity = "Rare",
            Contents = { {
                    Type = "LuckySpins",
                    Amount = 3
                } }
        },
        Mystery_LuckySpins5 = {
            Name = "5 Lucky Spins",
            Rarity = "Epic",
            Contents = { {
                    Type = "LuckySpins",
                    Amount = 5
                } }
        },
        Mystery_Stars10 = {
            Name = "10 Stars",
            Rarity = "Uncommon",
            Contents = { {
                    Type = "Stars",
                    Amount = 10
                } }
        },
        Mystery_Stars50 = {
            Name = "50 Stars",
            Rarity = "Rare",
            Contents = { {
                    Type = "Stars",
                    Amount = 50
                } }
        },
        Mystery_ClassEXP5 = {
            Name = "5 Class EXP Potions",
            Rarity = "Common",
            Contents = { {
                    Type = "ClassEXPPotion",
                    Amount = 5
                } }
        },
        Mystery_ClassEXP15 = {
            Name = "15 Class EXP Potions",
            Rarity = "Uncommon",
            Contents = { {
                    Type = "ClassEXPPotion",
                    Amount = 15
                } }
        },
        Mystery_ClassEXP30 = {
            Name = "30 Class EXP Potions",
            Rarity = "Epic",
            Contents = { {
                    Type = "ClassEXPPotion",
                    Amount = 30
                } }
        },
        Mystery_HealPotions = {
            Name = "Healing Potions",
            Rarity = "Common",
            Contents = { {
                    Type = "Potion",
                    Id = "SmallHealPercent",
                    Amount = 5
                } }
        },
        MysteryBox = {
            Name = "Mystery Box",
            Description = "A chaotic box of random rewards. Could be anything from pocket change to a class-defining artifact.",
            Rarity = "Legendary",
            Icon = "rbxassetid://98670960915463",
            RandomPool = {
                {
                    PackageId = "CoinBundle_100",
                    Weight = 84
                },
                {
                    PackageId = "CoinBundle_500",
                    Weight = 60
                },
                {
                    PackageId = "ForgeStone_x1",
                    Weight = 55
                },
                {
                    PackageId = "ForgeStone_x2",
                    Weight = 45
                },
                {
                    PackageId = "Mystery_NormalSpins5",
                    Weight = 60
                },
                {
                    PackageId = "Mystery_HealPotions",
                    Weight = 50
                },
                {
                    PackageId = "Mystery_ClassEXP5",
                    Weight = 50
                },
                {
                    PackageId = "BossDropBuffPotion",
                    Weight = 55
                },
                {
                    PackageId = "Mystery_Stars10",
                    Weight = 45
                },
                {
                    PackageId = "Mystery_NormalSpins10",
                    Weight = 40
                },
                {
                    PackageId = "Mystery_ClassEXP15",
                    Weight = 40
                },
                {
                    PackageId = "ForgeStonePackage",
                    Weight = 35
                },
                {
                    PackageId = "Mystery_LuckySpins3",
                    Weight = 35
                },
                {
                    PackageId = "ReforgeStonePackage",
                    Weight = 35
                },
                {
                    PackageId = "CoinBundle_5000",
                    Weight = 30
                },
                {
                    PackageId = "GMBlessing1",
                    Weight = 30
                },
                {
                    PackageId = "GMBlessing2",
                    Weight = 25
                },
                {
                    PackageId = "Mystery_Stars50",
                    Weight = 20
                },
                {
                    PackageId = "CoinBundle_10000",
                    Weight = 10
                },
                {
                    PackageId = "RareGearPack",
                    Weight = 25
                },
                {
                    PackageId = "EpicGearPack",
                    Weight = 20
                },
                {
                    PackageId = "GMBlessing3",
                    Weight = 20
                },
                {
                    PackageId = "Mystery_ClassEXP30",
                    Weight = 15
                },
                {
                    PackageId = "Mystery_LuckySpins5",
                    Weight = 10
                },
                {
                    PackageId = "BundleOfCoins",
                    Weight = 10
                },
                {
                    PackageId = "GMBlessing4",
                    Weight = 12
                },
                {
                    PackageId = "LegendaryGearPack",
                    Weight = 10
                },
                {
                    PackageId = "VagabondPack",
                    Weight = 5
                },
                {
                    PackageId = "CoyotePack",
                    Weight = 5
                },
                {
                    PackageId = "UmbralPack",
                    Weight = 5
                },
                {
                    PackageId = "ReaperPack",
                    Weight = 5
                },
                {
                    PackageId = "TyphoonPack",
                    Weight = 5
                },
                {
                    PackageId = "MidnightSamuraiPack",
                    Weight = 3
                },
                {
                    PackageId = "ScarletKnightPack",
                    Weight = 8
                },
                {
                    PackageId = "BerserkerPack",
                    Weight = 8
                },
                {
                    PackageId = "SlayerPack",
                    Weight = 7
                },
                {
                    PackageId = "FlameSamuraiPack",
                    Weight = 7
                },
                {
                    PackageId = "CelestialGearPack",
                    Weight = 8
                },
                {
                    PackageId = "CelestialRingPack",
                    Weight = 7
                },
                {
                    PackageId = "ProjectionReelPack",
                    Weight = 0.5
                }
            }
        },
        PrayerBeadsPack = {
            Name = "Prayer Beads",
            Description = "Ancient prayer beads crackling with unstable ki. Grants the Chaotic Fist class.",
            Rarity = "Admin",
            Icon = "rbxassetid://106398422501454",
            Contents = { {
                    Type = "ClassItem",
                    Id = "Prayer Beads"
                } }
        },
        ProjectionReelPack = {
            Name = "Projection Reel",
            Description = "A fractured strip of film that plays at twenty-four frames per second — each frame a killing blow. Grants the Framebreaker class.",
            Rarity = "Admin",
            Icon = "rbxassetid://106398422501454",
            Contents = { {
                    Type = "ClassItem",
                    Id = "Projection Reel"
                } }
        },
        MaterialBundle_Tier1 = {
            Name = "Material Bundle (Tier 1)",
            Description = "Opens into a random early-tier ore — Iron Scrap, Iron Ore, or Gold Ore.",
            Rarity = "Uncommon",
            Icon = Image_Data.MaterialBundles.Tier1,
            RandomPool = { {
                    PackageId = "MatBundle_T1_IronScrap",
                    Weight = 1
                }, {
                    PackageId = "MatBundle_T1_IronIngot",
                    Weight = 1
                }, {
                    PackageId = "MatBundle_T1_GoldIngot",
                    Weight = 1
                } }
        },
        MaterialBundle_Tier2 = {
            Name = "Material Bundle (Tier 2)",
            Description = "Opens into a random mid-tier ore — Iron Ore, Gold Ore, or Obsidian Ore.",
            Rarity = "Rare",
            Icon = Image_Data.MaterialBundles.Tier2,
            RandomPool = { {
                    PackageId = "MatBundle_T2_IronIngot",
                    Weight = 1
                }, {
                    PackageId = "MatBundle_T2_GoldIngot",
                    Weight = 1
                }, {
                    PackageId = "MatBundle_T2_DiamondIngot",
                    Weight = 1
                } }
        },
        MaterialBundle_Tier3 = {
            Name = "Material Bundle (Tier 3)",
            Description = "Opens into a random high-tier ore — Gold Ore, Obsidian Ore, or Celestial Ore.",
            Rarity = "Epic",
            Icon = Image_Data.MaterialBundles.Tier3,
            RandomPool = { {
                    PackageId = "MatBundle_T3_GoldIngot",
                    Weight = 1
                }, {
                    PackageId = "MatBundle_T3_DiamondIngot",
                    Weight = 1
                }, {
                    PackageId = "MatBundle_T3_CelestialIngot",
                    Weight = 1
                } }
        },
        MatBundle_T1_IronScrap = {
            Name = "Iron Scrap",
            Rarity = "Common",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Iron Scrap",
                    AmountRange = { 1, 3 }
                } }
        },
        MatBundle_T1_IronIngot = {
            Name = "Iron Ore",
            Rarity = "Uncommon",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Iron Ore",
                    AmountRange = { 1, 3 }
                } }
        },
        MatBundle_T1_GoldIngot = {
            Name = "Gold Ore",
            Rarity = "Rare",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Gold Ore",
                    AmountRange = { 1, 3 }
                } }
        },
        MatBundle_T2_IronIngot = {
            Name = "Iron Ore",
            Rarity = "Uncommon",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Iron Ore",
                    AmountRange = { 1, 3 }
                } }
        },
        MatBundle_T2_GoldIngot = {
            Name = "Gold Ore",
            Rarity = "Rare",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Gold Ore",
                    AmountRange = { 1, 3 }
                } }
        },
        MatBundle_T2_DiamondIngot = {
            Name = "Obsidian Ore",
            Rarity = "Epic",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Obsidian Ore",
                    AmountRange = { 1, 3 }
                } }
        },
        MatBundle_T3_GoldIngot = {
            Name = "Gold Ore",
            Rarity = "Rare",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Gold Ore",
                    AmountRange = { 1, 3 }
                } }
        },
        MatBundle_T3_DiamondIngot = {
            Name = "Obsidian Ore",
            Rarity = "Epic",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Obsidian Ore",
                    AmountRange = { 1, 3 }
                } }
        },
        MatBundle_T3_CelestialIngot = {
            Name = "Celestial Ore",
            Rarity = "Celestial",
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Celestial Ore",
                    AmountRange = { 1, 3 }
                } }
        },
        RarityChest_Common = {
            Name = "Common Chest",
            Description = "A common chest. Always some Iron Scrap and coins, with a slim chance at gear or a Common Ingot.",
            Rarity = "Common",
            Icon = Image_Data.ChestTypes.Plain,
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Iron Scrap",
                    AmountRange = { 1, 2 }
                }, {
                    Type = "Coins",
                    AmountRange = { 25, 60 }
                }, {
                    Type = "Equipment",
                    Rarity = "Common",
                    Chance = 0.15
                }, {
                    Type = "CraftingMaterial",
                    Id = "Common Ingot",
                    Amount = 1,
                    Chance = 0.07
                } }
        },
        RarityChest_Uncommon = {
            Name = "Uncommon Chest",
            Description = "An uncommon chest. Always some Iron Ore and coins, with a slim chance at gear or an Uncommon Ingot.",
            Rarity = "Uncommon",
            Icon = Image_Data.ChestTypes.Emerald,
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Iron Ore",
                    AmountRange = { 1, 2 }
                }, {
                    Type = "Coins",
                    AmountRange = { 40, 90 }
                }, {
                    Type = "Equipment",
                    Rarity = "Uncommon",
                    Chance = 0.15
                }, {
                    Type = "CraftingMaterial",
                    Id = "Uncommon Ingot",
                    Amount = 1,
                    Chance = 0.07
                } }
        },
        RarityChest_Rare = {
            Name = "Rare Chest",
            Description = "A rare chest. Always some Gold Ore and coins, with a chance at Rare gear or a Rare Ingot.",
            Rarity = "Rare",
            Icon = Image_Data.ChestTypes.Blue,
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Gold Ore",
                    AmountRange = { 1, 3 }
                }, {
                    Type = "Coins",
                    AmountRange = { 75, 160 }
                }, {
                    Type = "Equipment",
                    Rarity = "Rare",
                    Chance = 0.15
                }, {
                    Type = "CraftingMaterial",
                    Id = "Rare Ingot",
                    Amount = 1,
                    Chance = 0.07
                } }
        },
        RarityChest_Epic = {
            Name = "Epic Chest",
            Description = "An epic chest. Always some Obsidian Ore and coins, with a chance at Epic gear or an Epic Ingot.",
            Rarity = "Epic",
            Icon = Image_Data.ChestTypes.Royal,
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Obsidian Ore",
                    AmountRange = { 1, 3 }
                }, {
                    Type = "Coins",
                    AmountRange = { 150, 320 }
                }, {
                    Type = "Equipment",
                    Rarity = "Epic",
                    Chance = 0.15
                }, {
                    Type = "CraftingMaterial",
                    Id = "Epic Ingot",
                    Amount = 1,
                    Chance = 0.07
                } }
        },
        RarityChest_Legendary = {
            Name = "Legendary Chest",
            Description = "A legendary chest. Always some Infernal Ore and coins, with a chance at Legendary gear or a Legendary Ingot.",
            Rarity = "Legendary",
            Icon = Image_Data.ChestTypes.Holy,
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Infernal Ore",
                    AmountRange = { 2, 3 }
                }, {
                    Type = "Coins",
                    AmountRange = { 300, 650 }
                }, {
                    Type = "Equipment",
                    Rarity = "Legendary",
                    Chance = 0.15
                }, {
                    Type = "CraftingMaterial",
                    Id = "Legendary Ingot",
                    Amount = 1,
                    Chance = 0.07
                } }
        },
        RarityChest_Mythic = {
            Name = "Mythic Chest",
            Description = "A mythic chest. Always some Radiant Ore and coins, with a chance at Mythic gear, a Mythic Ingot, or a Boss Rush Skip Ticket.",
            Rarity = "Mythic",
            Icon = Image_Data.ChestTypes.Ruby,
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Radiant Ore",
                    AmountRange = { 2, 4 }
                }, {
                    Type = "Coins",
                    AmountRange = { 600, 1200 }
                }, {
                    Type = "Equipment",
                    Rarity = "Mythic",
                    Chance = 0.15
                }, {
                    Type = "CraftingMaterial",
                    Id = "Mythic Ingot",
                    Amount = 1,
                    Chance = 0.07
                }, {
                    Type = "Consumable",
                    Id = "BossRushSkipTicket",
                    Amount = 1,
                    Chance = 0.1
                } }
        },
        RarityChest_Celestial = {
            Name = "Celestial Chest",
            Description = "A celestial chest. Always some Celestial Ore and coins, with a chance at Celestial gear, a Celestial Ingot, or a Boss Rush Skip Ticket.",
            Rarity = "Celestial",
            Icon = Image_Data.ChestTypes.Prismatic,
            Contents = { {
                    Type = "CraftingMaterial",
                    Id = "Celestial Ore",
                    AmountRange = { 2, 5 }
                }, {
                    Type = "Coins",
                    AmountRange = { 1200, 2500 }
                }, {
                    Type = "Equipment",
                    Rarity = "Celestial",
                    Chance = 0.15
                }, {
                    Type = "CraftingMaterial",
                    Id = "Celestial Ingot",
                    Amount = 1,
                    Chance = 0.07
                }, {
                    Type = "Consumable",
                    Id = "BossRushSkipTicket",
                    Chance = 0.15,
                    AmountRange = { 1, 2 }
                } }
        }
    }
};

function u1.Get(p2: string) -- Line: 1270
    -- upvalues: u1 (copy), CosmeticData (copy), Image_Data (copy)
    local v3 = u1.Packages[p2];

    if not v3 then
        return nil;
    end;

    if not v3.Rarity and v3.Contents then
        for _, v in ipairs(v3.Contents) do
            if v.Type == "Cosmetic" and v.Id then
                local v4 = CosmeticData.Get(v.Id);

                if v4 and v4.Rarity then
                    v3.Rarity = v4.Rarity;
                    break;
                end;
            end;
        end;

        if not v3.Rarity then
            v3.Rarity = "Rare";
        end;
    end;

    if not v3._ChestIconResolved and v3.Contents then
        v3._ChestIconResolved = true;
        local v5 = false;

        for _, v in ipairs(v3.Contents) do
            if v.Type == "Cosmetic" then
                v5 = true;
                break;
            end;
        end;

        if v5 then
            local v6 = v3.ChestType and Image_Data.ChestTypes[v3.ChestType] or Image_Data.GetChestForRarity(v3.Rarity);

            if v6 then
                v3.Icon = v6;
            end;
        end;
    end;

    return v3;
end;

function u1.ResolveRandomPool(p7: table) -- Line: 1321
    if not p7 or #p7 == 0 then
        return nil;
    end;

    local v8 = 0;

    for _, v in ipairs(p7) do
        v8 = v8 + (v.Weight or 1);
    end;

    local v9 = math.random() * v8;
    local v10 = 0;

    for _, v in ipairs(p7) do
        v10 = v10 + (v.Weight or 1);

        if v9 <= v10 then
            return v.PackageId;
        end;
    end;

    return p7[#p7].PackageId;
end;

function u1.IsRandom(p11: string) -- Line: 1342
    -- upvalues: u1 (copy)
    local v12 = u1.Packages[p11];
    local v13;

    if v12 == nil then
        v13 = false;
    else
        v13 = v12.RandomPool ~= nil;
    end;

    return v13;
end;

function u1.IsGearPackage(p14: string, p15: number?) -- Line: 1358
    -- upvalues: u1 (copy)
    local v16 = p15 or 0;

    if v16 > 5 then
        return false;
    end;

    local v17 = u1.Packages[p14];

    if not v17 then
        return false;
    end;

    if not v17.RandomPool then
        if v17.Contents then
            for _, v in ipairs(v17.Contents) do
                if v.Type == "Equipment" and not v.Chance then
                    return true;
                end;

                if v.Type == "Package" and (v.Id and u1.IsGearPackage(v.Id, v16 + 1)) then
                    return true;
                end;
            end;
        end;

        return false;
    end;

    if #v17.RandomPool == 0 then
        return false;
    end;

    for _, v in ipairs(v17.RandomPool) do
        if not (v.PackageId and u1.IsGearPackage(v.PackageId, v16 + 1)) then
            return false;
        end;
    end;

    return true;
end;

function u1.GetAll() -- Line: 1391
    -- upvalues: u1 (copy)
    local v18 = {};

    for i in u1.Packages do
        table.insert(v18, i);
    end;

    return v18;
end;

function u1.GetFlatContents(p19: string, p20: number?) -- Line: 1404
    -- upvalues: u1 (copy)
    local v21 = p20 or 0;

    if v21 > 5 then
        return nil;
    end;

    local v22 = u1.Packages[p19];

    if not v22 then
        return nil;
    end;

    local v23 = {};

    for _, v in ipairs(v22.Contents) do
        if v.Type == "Package" and v.Id then
            local FlatContents = u1.GetFlatContents(v.Id, v21 + 1);

            if FlatContents then
                for _, v2 in ipairs(FlatContents) do
                    table.insert(v23, v2);
                end;
            end;
        else
            table.insert(v23, v);
        end;
    end;

    return v23;
end;

return u1;