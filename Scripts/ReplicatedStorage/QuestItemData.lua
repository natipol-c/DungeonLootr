--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     QuestItemData
  Path:     game.ReplicatedStorage.GameInfo.QuestItemData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Items = {
        ["Empty Memory"] = {
            DisplayName = "Empty Memory",
            Rarity = "Legendary",
            Description = "A hollow Gaia Memory, drained of its power. Perhaps someone knows how to restore it...",
            Icon = "rbxassetid://123188741881686",
            MaxOwned = 1,
            LayoutOrder = 450
        },
        ["Flaming Crystal"] = {
            DisplayName = "Flaming Crystal",
            Rarity = "Legendary",
            Description = "A shard of blue fire harvested from the Azure Nightmare. It pulses with lingering devilry.",
            Icon = "rbxassetid://100636287806695",
            MaxOwned = 3,
            LayoutOrder = 451
        },
        ["Obsidian Skull"] = {
            DisplayName = "Obsidian Skull",
            Rarity = "Legendary",
            Description = "A skull forged in volcanic darkness, taken from the Lichborn himself. Its hollow eyes still smolder.",
            Icon = "rbxassetid://88296537152095",
            MaxOwned = 1,
            LayoutOrder = 452
        },
        ["Corrupted Seed"] = {
            DisplayName = "Corrupted Seed",
            Rarity = "Legendary",
            Description = "A frozen seed pulsing with dark energy, pried from Valkskar\'s shattered throne. It yearns to take root.",
            Icon = "rbxassetid://104799459378816",
            MaxOwned = 1,
            LayoutOrder = 453
        },
        ["Gem Topaz"] = {
            DisplayName = "Gem Topaz",
            Rarity = "Legendary",
            Description = "A brilliant topaz wrested from the Forest Warden\'s hoard. It glows with trapped sunlight.",
            Icon = "rbxassetid://138879509039194",
            MaxOwned = 1,
            LayoutOrder = 454
        },
        ["Corrupted Feather"] = {
            DisplayName = "Corrupted Feather",
            Rarity = "Mythic",
            Description = "A mysterious feather, filled with energy- yet corrupted.",
            Icon = "rbxassetid://83650837592829",
            MaxOwned = 30,
            LayoutOrder = 455
        },
        ["Purity Stone"] = {
            DisplayName = "Purity Stone",
            Rarity = "Mythic",
            Description = "A pure stone, free of all influence. Enhance a forge with one to raise its success chance — consumed whether the forge succeeds or fails.",
            Icon = "rbxassetid://118186017072665 ",
            LayoutOrder = 456
        },
        ["Heavenly Fragment"] = {
            DisplayName = "Heavenly Fragment",
            Rarity = "Celestial",
            Description = "A shard of shattered heaven, torn loose from a collapsing domain. It weighs nothing, yet only the truly Unrestricted can bear to hold it.",
            Icon = "rbxassetid://118186017072665",
            MaxOwned = 10,
            LayoutOrder = 458,
            GrantedOnDrop = true
        },
        ["Devil Heart"] = {
            DisplayName = "Devil Heart",
            Rarity = "Mythic",
            Description = "The still-beating core torn from the Awakened Devil on Frostspire\'s cruelest night. It thrums with borrowed Devil Trigger.",
            Icon = "rbxassetid://93161112180346",
            MaxOwned = 10,
            LayoutOrder = 457
        }
    }
};

function u1.Get(p2: string) -- Line: 119
    -- upvalues: u1 (copy)
    return u1.Items[p2];
end;

return u1;