--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EquipmentTemplates
  Path:     game.ReplicatedStorage.GameInfo.EquipmentTemplates
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local RarityIndex = require(script.Parent.RarityData).RarityIndex;
local u1 = {
    BanditHood = {
        DisplayName = "Bandit\'s Hood",
        Slot = "Head",
        Dungeon = "Bandits Den",
        MinRarity = "Common",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://133170534964193",
        Description = "A weathered hood favored by forest outlaws."
    },
    OutlawVest = {
        DisplayName = "Outlaw\'s Vest",
        Slot = "Body",
        Dungeon = "Bandits Den",
        MinRarity = "Common",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://81592795693876",
        Description = "Stitched leather worn by highwaymen."
    },
    BrigandSoul = {
        DisplayName = "Copper Ring",
        Slot = "Ring",
        Dungeon = "Bandits Den",
        MinRarity = "Common",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://94448223823198",
        Description = "The desperate spirit of a cornered bandit."
    },
    AssassinCowl = {
        DisplayName = "Assassin\'s Cowl",
        Slot = "Head",
        Dungeon = "Bandits Den",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://130483094366708",
        Description = "A dark cowl worn by those who strike from the shadows."
    },
    AssassinGarb = {
        DisplayName = "Assassin\'s Garb",
        Slot = "Body",
        Dungeon = "Bandits Den",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://139652482050112",
        Description = "Silent leathers designed for swift, lethal movement."
    },
    ShadowBrigandSoul = {
        DisplayName = "Wolf Ring",
        Slot = "Ring",
        Dungeon = "Bandits Den",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://127414706917226",
        Description = "A bandit\'s spirit honed by darkness into something deadlier."
    },
    RaiderSkullcap = {
        DisplayName = "Nature Mask",
        Slot = "Head",
        Dungeon = "Goblins",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://128403783832475",
        Description = "A crude iron skullcap looted from a dozen battlefields."
    },
    ScrapBrigandine = {
        DisplayName = "Nature Plate",
        Slot = "Body",
        Dungeon = "Goblins",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://74372010313466",
        Description = "Scrap metal riveted into a surprisingly sturdy vest."
    },
    RaiderSoul = {
        DisplayName = "Nature Ring",
        Slot = "Ring",
        Dungeon = "Goblins",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://84420808796517",
        Description = "The savage spirit of a goblin raider, always hungry for more."
    },
    WarchiefCrown = {
        DisplayName = "Warchief\'s Crown",
        Slot = "Head",
        Dungeon = "Goblins",
        MinRarity = "Rare",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://108759185012810",
        Description = "A brutal crown forged by the strongest of goblin warlords."
    },
    IronhidePlate = {
        DisplayName = "Ironhide Plate",
        Slot = "Body",
        Dungeon = "Goblins",
        MinRarity = "Rare",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://123756337597352",
        Description = "Thick goblin armor reinforced with scavenged iron plates."
    },
    WarchiefSoul = {
        DisplayName = "Warchief Ring",
        Slot = "Ring",
        Dungeon = "Goblins",
        MinRarity = "Rare",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://106165339376438",
        Description = "The ferocious will of a goblin warchief made manifest."
    },
    RustedVisor = {
        DisplayName = "Rusted Visor",
        Slot = "Head",
        Dungeon = "Knights",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://117075607222424",
        Description = "A corroded visor from a knight who fell long ago."
    },
    TarnishedPlate = {
        DisplayName = "Tarnished Plate",
        Slot = "Body",
        Dungeon = "Knights",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://86261206829209",
        Description = "Dull and battered plate armor, yet still standing after centuries."
    },
    ForsakenSoul = {
        DisplayName = "Winged Ring",
        Slot = "Ring",
        Dungeon = "Knights",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://85989719627988",
        Description = "The lingering sorrow of a knight who broke their oath."
    },
    HollowKnightHelm = {
        DisplayName = "Hollow Knight\'s Helm",
        Slot = "Head",
        Dungeon = "Knights",
        MinRarity = "Rare",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://82202260099381",
        Description = "An empty helm that still moves as if worn by something unseen."
    },
    HollowKnightPlate = {
        DisplayName = "Hollow Knight\'s Plate",
        Slot = "Body",
        Dungeon = "Knights",
        MinRarity = "Rare",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://74435122322787",
        Description = "Armor of the hollow — weightless, cold, and impossibly strong."
    },
    HollowSoul = {
        DisplayName = "Dragon Ring",
        Slot = "Ring",
        Dungeon = "Knights",
        MinRarity = "Rare",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://105340959595746",
        Description = "A soul emptied of everything but the will to endure."
    },
    AcolyteVeil = {
        DisplayName = "Acolyte\'s Veil",
        Slot = "Head",
        Dungeon = "Catacombs",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://116064969424641",
        Description = "A thin shroud worn by those who commune with the dead."
    },
    AcolyteGarb = {
        DisplayName = "Acolyte\'s Garb",
        Slot = "Body",
        Dungeon = "Catacombs",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://84675952450822",
        Description = "Dark robes threaded with grave dust and whispered rites."
    },
    AcolyteSoul = {
        DisplayName = "Acolyte Ring",
        Slot = "Ring",
        Dungeon = "Catacombs",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://80774011190572",
        Description = "A fledgling spirit drawn to the border between life and death."
    },
    DeathlordCirclet = {
        DisplayName = "Deathlord\'s Circlet",
        Slot = "Head",
        Dungeon = "Catacombs",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://75537713481996",
        Description = "A crown of bone that pulses with necrotic authority."
    },
    DeathlordMantle = {
        DisplayName = "Deathlord\'s Mantle",
        Slot = "Body",
        Dungeon = "Catacombs",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://118096212118821",
        Description = "Heavy vestments woven from the silence of a thousand tombs."
    },
    DeathlordSoul = {
        DisplayName = "Deathlord Ring",
        Slot = "Ring",
        Dungeon = "Catacombs",
        MinRarity = "Uncommon",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://121350267626605",
        Description = "The undying will of a lord who conquered death itself."
    },
    ValkyrieHelm = {
        DisplayName = "Valkyrie Helm",
        Slot = "Head",
        Dungeon = "Universal",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        StatMultiplier = 1.5,
        ImageId = "rbxassetid://100887120025390",
        Description = "A winged helm blessed by the choosers of the slain."
    },
    RunicVeil = {
        DisplayName = "Runic Veil",
        Slot = "Head",
        Dungeon = "Universal",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        StatMultiplier = 1.5,
        ImageId = "rbxassetid://134164083938777",
        Description = "Ancient runes shimmer across this translucent shroud."
    },
    MoonCrescentMenpo = {
        DisplayName = "Moon Crescent Menpo",
        Slot = "Head",
        Dungeon = "Universal",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        StatMultiplier = 1.5,
        ImageId = "rbxassetid://104049858011868",
        Description = "A crescent-forged face guard bathed in moonlight."
    },
    AbyssalLordHelm = {
        DisplayName = "Abyssal Lord Helm",
        Slot = "Head",
        Dungeon = "Universal",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        StatMultiplier = 1.5,
        ImageId = "rbxassetid://89402318487808",
        Description = "The crown of one who rules the deepest dark."
    },
    SerpentsGaze = {
        DisplayName = "Serpent\'s Gaze",
        Slot = "Head",
        Dungeon = "Universal",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        StatMultiplier = 1.5,
        ImageId = "rbxassetid://136408043050483",
        Description = "Eyes of the primordial serpent, ever watching."
    },
    ShadowMonarchPlate = {
        DisplayName = "Shadow Monarch Plate",
        Slot = "Body",
        Dungeon = "Universal",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        StatMultiplier = 1.5,
        ImageId = "rbxassetid://71930840402269",
        Description = "Armor forged from solidified shadow, fit for a king."
    },
    RunicHollowPlate = {
        DisplayName = "Runic Hollow Plate",
        Slot = "Body",
        Dungeon = "Universal",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        StatMultiplier = 1.5,
        ImageId = "rbxassetid://102786573528225",
        Description = "Hollow armor inscribed with runes that hum with power."
    },
    KingsArmor = {
        DisplayName = "King\'s Armor",
        Slot = "Body",
        Dungeon = "Universal",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        StatMultiplier = 1.5,
        ImageId = "rbxassetid://95624354575692",
        Description = "Royal plate worn by a sovereign who never fell in battle."
    },
    DragonscalePlateArmor = {
        DisplayName = "Dragonscale Plate Armor",
        Slot = "Body",
        Dungeon = "Universal",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        StatMultiplier = 1.5,
        ImageId = "rbxassetid://76829425978099",
        Description = "Scales of an elder dragon hammered into impenetrable plate."
    },
    BlueFedora = {
        DisplayName = "Blue Fedora",
        Slot = "Head",
        Dungeon = "Quest",
        MinRarity = "Rare",
        MaxRarity = "Celestial",
        EquipTier = 1,
        Unsellable = true,
        ExcludeFromShop = true,
        ImageId = "rbxassetid://104492163190309",
        Description = "Ogge\'s legendary blue fedora. How did you even get this?"
    },
    FrostmireCap = {
        DisplayName = "Frostmire Cap",
        Slot = "Head",
        Dungeon = "Snow",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://111812362477749",
        Description = "A frost-hardened cap worn by those who brave the frozen depths."
    },
    GlacialPlate = {
        DisplayName = "Glacial Plate",
        Slot = "Body",
        Dungeon = "Snow",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://72475886588166",
        Description = "Armor encased in permafrost, cold to the touch yet unyielding."
    },
    GlacialRing = {
        DisplayName = "Glacial Ring",
        Slot = "Ring",
        Dungeon = "Snow",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://120495544710444",
        Description = "A ring of frozen crystal that numbs all it touches."
    },
    RunicHelm = {
        DisplayName = "Runic Helm",
        Slot = "Head",
        Dungeon = "Snow",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://91506908708019",
        Description = "Ancient runes blaze across this helm, warding against oblivion."
    },
    RunicPlate = {
        DisplayName = "Runic Plate",
        Slot = "Body",
        Dungeon = "Snow",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://121197306892144",
        Description = "Plate armor etched with runes that pulse with arcane might."
    },
    DeathsRiteRing = {
        DisplayName = "Death\'s Rite Ring",
        Slot = "Ring",
        Dungeon = "Snow",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://118481585512089",
        Description = "A cursed band that channels the rite of death itself."
    },
    ObsidianKabuto = {
        DisplayName = "Obsidian Kabuto",
        Slot = "Head",
        Dungeon = "Demon",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://89021142515778",
        Description = "A samurai helm forged from volcanic obsidian glass."
    },
    MagmaPlate = {
        DisplayName = "Magma Plate",
        Slot = "Body",
        Dungeon = "Demon",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://112517319329231",
        Description = "Plate armor seared with veins of molten magma."
    },
    DemonsEyeRing = {
        DisplayName = "Demon\'s Eye Ring",
        Slot = "Ring",
        Dungeon = "Demon",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 1,
        ImageId = "rbxassetid://123748312009586",
        Description = "A ring set with the unblinking eye of a lesser demon."
    },
    CrimsonKabuto = {
        DisplayName = "Crimson Kabuto",
        Slot = "Head",
        Dungeon = "Demon",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://80109730945592",
        Description = "A masked kabuto stained in the blood of a thousand sinners."
    },
    DemonicPlate = {
        DisplayName = "Demonic Plate",
        Slot = "Body",
        Dungeon = "Demon",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://116781806050635",
        Description = "Hellforged plate wrought from the carapace of a greater demon."
    },
    UnderworldBinding = {
        DisplayName = "Underworld Binding",
        Slot = "Ring",
        Dungeon = "Demon",
        MinRarity = "Epic",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ImageId = "rbxassetid://82270238725781",
        Description = "A copper band wrapped in coarse darkfur, its crimson jewels pulsing with underworld power."
    },
    KingsCrown = {
        DisplayName = "King\'s Crown",
        Slot = "Head",
        Dungeon = "Craft",
        MinRarity = "Exotic",
        MaxRarity = "Exotic",
        EquipTier = 2,
        ExcludeFromShop = true,
        ImageId = "rbxassetid://137149054253671",
        Description = "A sovereign\'s crown, radiant with the authority of a thousand conquered realms."
    },
    FirelordCap = {
        DisplayName = "Firelord Cap",
        Slot = "Head",
        Dungeon = "Craft",
        MinRarity = "Celestial",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ExcludeFromShop = true,
        ImageId = "rbxassetid://115622551462743",
        Description = "A crown wreathed in living flame, worn by those who command the inferno."
    },
    PossessedHelmet = {
        DisplayName = "Possessed Helmet",
        Slot = "Head",
        Dungeon = "Craft",
        MinRarity = "Celestial",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ExcludeFromShop = true,
        ImageId = "rbxassetid://77047843217993",
        Description = "A helm gripped by a restless spirit that refuses to relinquish its host."
    },
    LivingArmor = {
        DisplayName = "Living Armor",
        Slot = "Body",
        Dungeon = "Craft",
        MinRarity = "Exotic",
        MaxRarity = "Exotic",
        EquipTier = 2,
        ExcludeFromShop = true,
        ImageId = "rbxassetid://82380852141699",
        Description = "Plate that breathes and shifts of its own will, bonding to its wearer as one."
    },
    SupernovaRing = {
        DisplayName = "Supernova Ring",
        Slot = "Ring",
        Dungeon = "Craft",
        MinRarity = "Exotic",
        MaxRarity = "Exotic",
        EquipTier = 2,
        ExcludeFromShop = true,
        ImageId = "rbxassetid://109429376088958",
        Description = "A band holding the collapsing heart of a dying star, endlessly detonating."
    },
    PhoenixRing = {
        DisplayName = "Phoenix Ring",
        Slot = "Ring",
        Dungeon = "Craft",
        MinRarity = "Celestial",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ExcludeFromShop = true,
        ImageId = "rbxassetid://88310590982736",
        Description = "A ring of everburning plumage, reborn from its own ashes with each dawn."
    },
    HydraRing = {
        DisplayName = "Hydra Ring",
        Slot = "Ring",
        Dungeon = "Craft",
        MinRarity = "Celestial",
        MaxRarity = "Celestial",
        EquipTier = 2,
        ExcludeFromShop = true,
        ImageId = "rbxassetid://113701010701806",
        Description = "For every head severed, two more strike back — a ring of relentless resurgence."
    }
};

for i, v in u1 do
    v.ItemId = i;
end;

local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};

for i, v in u1 do
    local Dungeon = v.Dungeon;

    if not u2[Dungeon] then
        u2[Dungeon] = {};
    end;

    u2[Dungeon][i] = v;
    local v7 = v.EquipTier or 1;

    if not u3[Dungeon] then
        u3[Dungeon] = {};
    end;

    if not u3[Dungeon][v7] then
        u3[Dungeon][v7] = {};
    end;

    u3[Dungeon][v7][i] = v;
    local Slot = v.Slot;

    if not u4[Slot] then
        u4[Slot] = {};
    end;

    u4[Slot][i] = v;
    table.insert(u6, i);

    if not v.ExcludeFromShop then
        table.insert(u5, i);
    end;
end;

table.sort(u6);
table.sort(u5);

return {
    GetTemplate = function(p8: string) -- Line: 715, Name: GetTemplate
        -- upvalues: u1 (copy)
        return u1[p8];
    end,

    GetTier = function(p9: string) -- Line: 722, Name: GetTier
        -- upvalues: u1 (copy)
        local v10 = u1[p9];

        return v10 and (v10.EquipTier or 1) or nil;
    end,

    GetItemsForDungeon = function(p11: string) -- Line: 730, Name: GetItemsForDungeon
        -- upvalues: u2 (copy)
        return u2[p11] or {};
    end,

    GetItemsForDungeonTier = function(p12: string, p13: number) -- Line: 737, Name: GetItemsForDungeonTier
        -- upvalues: u3 (copy)
        local v14 = u3[p12];

        return v14 and (v14[p13] or v14[1] or {}) or {};
    end,

    GetItemsForSlot = function(p15: string) -- Line: 745, Name: GetItemsForSlot
        -- upvalues: u4 (copy)
        return u4[p15] or {};
    end,

    IsValidRarity = function(p16: string, p17: string) -- Line: 750, Name: IsValidRarity
        -- upvalues: u1 (copy), RarityIndex (copy)
        local v18 = u1[p16];

        if not v18 then
            return false;
        end;

        local v19 = RarityIndex[p17];
        local v20 = RarityIndex[v18.MinRarity];
        local v21 = RarityIndex[v18.MaxRarity];

        if not (v19 and (v20 and v21)) then
            return false;
        end;

        local v22;

        if v20 <= v19 then
            v22 = v19 <= v21;
        else
            v22 = false;
        end;

        return v22;
    end,

    GetAllItemIds = function() -- Line: 763, Name: GetAllItemIds
        -- upvalues: u6 (copy)
        return u6;
    end,

    GetShopItemIds = function() -- Line: 771, Name: GetShopItemIds
        -- upvalues: u5 (copy)
        return u5;
    end,

    GetUniversalItems = function() -- Line: 777, Name: GetUniversalItems
        -- upvalues: u2 (copy)
        return u2.Universal or {};
    end,

    GetAll = function() -- Line: 782, Name: GetAll
        -- upvalues: u1 (copy)
        return u1;
    end
};