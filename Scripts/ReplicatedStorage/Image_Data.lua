--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Image_Data
  Path:     game.ReplicatedStorage.GameInfo.Image_Data
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    UpgradeStones = {
        Common = "rbxassetid://119464815203039",
        Uncommon = "rbxassetid://104061139476040",
        Rare = "rbxassetid://121586233763375",
        Epic = "rbxassetid://86103118729248",
        Legendary = "rbxassetid://71344837910780",
        Mythic = "rbxassetid://105981684278432",
        Celestial = "rbxassetid://100374060154034"
    },
    Crystals = {
        Common = "rbxassetid://86038175473028",
        Uncommon = "rbxassetid://105182612497916",
        Rare = "rbxassetid://89624932292051",
        Epic = "rbxassetid://134318680271523",
        Legendary = "rbxassetid://131029510760587",
        Mythic = "rbxassetid://96073078750149",
        Celestial = "rbxassetid://139859251274043",
        Reroll = "rbxassetid://128432860298351",
        Hyper = "rbxassetid://135600859069110"
    },
    ForgeMaterials = {
        ["Forge Stone"] = "rbxassetid://121586233763375",
        ["Reforge Stone"] = "rbxassetid://79994701193946"
    },
    LootChests = {
        Default = "rbxassetid://79213467205553",
        Legendary = "rbxassetid://109230229609916",
        Mythic = "rbxassetid://88950558780083",
        Celestial = "rbxassetid://128847712470141",
        Frozen = "rbxassetid://83437007671396",
        Molten = "rbxassetid://136920601478797",
        Coyote = "rbxassetid://76246590193507"
    },
    ChestTypes = {
        Plain = "rbxassetid://79611762911739",
        Emerald = "rbxassetid://86621319372890",
        Ruby = "rbxassetid://114710918860453",
        Blue = "rbxassetid://94579471662090",
        Diamond = "rbxassetid://98280978907729",
        Holy = "rbxassetid://138516281831268",
        Prismatic = "rbxassetid://112157823650148",
        Royal = "rbxassetid://105423537955607",
        Soul = "rbxassetid://122597269790591",
        Flame = "rbxassetid://128202330077019"
    }
};
u1.ChestByRarity = {
    Common = u1.ChestTypes.Plain,
    Uncommon = u1.ChestTypes.Emerald,
    Rare = u1.ChestTypes.Ruby,
    Epic = u1.ChestTypes.Blue,
    Legendary = u1.ChestTypes.Diamond,
    Mythic = u1.ChestTypes.Holy,
    Celestial = u1.ChestTypes.Prismatic,
    Exotic = u1.ChestTypes.Royal,
    Admin = u1.ChestTypes.Soul
};

function u1.GetChestForRarity(p2: string?) -- Line: 89
    -- upvalues: u1 (copy)
    if p2 then
        return u1.ChestByRarity[p2];
    end;

    return nil;
end;

u1.Potions = {
    SmallHealFlat = "rbxassetid://138747788603782",
    MediumHealFlat = "rbxassetid://138747788603782",
    LargeHealFlat = "rbxassetid://138747788603782",
    SmallHealPercent = "rbxassetid://138393245004394",
    MediumHealPercent = "rbxassetid://117032455923428",
    LargeHealPercent = "rbxassetid://117032455923428",
    ClassXPEssence = "rbxassetid://79049037007830",
    PrimaryHealthPotion = "rbxassetid://92187815781766"
};
u1.BuffPotions = {
    MinorDropRate = "rbxassetid://99931652248233",
    MajorDropRate = "rbxassetid://106974346230984",
    MinorLuckRate = "rbxassetid://106065138341213",
    MajorLuckRate = "rbxassetid://130338962719250",
    MinorMoveSpeed = "rbxassetid://93644055495237",
    MajorMoveSpeed = "rbxassetid://132331765832793",
    MinorCashRate = "rbxassetid://73536608277889",
    MajorCashRate = "rbxassetid://89115063124199",
    SwiftPotion = "rbxassetid://131267954185511",
    LuckyPotion = "rbxassetid://96750128126321",
    EXPPotion = "rbxassetid://110625004855894",
    DamagePotion = "rbxassetid://90190534788022",
    ClassXPPotion = "rbxassetid://87387889447476",
    Friends = "rbxassetid://129968931640482",
    Premium = "rbxassetid://125566952843725",
    DoubleEXPPotion = "rbxassetid://133478242910827",
    LootLuckPotion = "rbxassetid://92316820329236",
    LuckPotionT1 = "rbxassetid://77034839031830",
    LuckPotionT2 = "rbxassetid://127576936443950",
    LuckPotionT3 = "rbxassetid://132803716027103",
    DoublePlayerEXP = "rbxassetid://97286814074229",
    DoubleClassEXP = "rbxassetid://75690262617382"
};
u1.Rewards = {
    Cash = "rbxassetid://91389011596762",
    Stars = "rbxassetid://115426390748984",
    ProtectionScroll = "rbxassetid://70402311500633",
    GoldenHammer = "rbxassetid://70945862920898",
    Title = "rbxassetid://103956521140190",
    NormalSpins = "rbxassetid://87395589306114",
    LuckySpins = "rbxassetid://85930151258615",
    Cosmetic = "rbxassetid://87633763556362"
};
u1.Equipment = {
    BanditHood = "rbxassetid://133170534964193",
    OutlawVest = "rbxassetid://81592795693876",
    BrigandSoul = "rbxassetid://94448223823198",
    AssassinCowl = "rbxassetid://130483094366708",
    AssassinGarb = "rbxassetid://139652482050112",
    ShadowBrigandSoul = "rbxassetid://127414706917226",
    RaiderSkullcap = "rbxassetid://128403783832475",
    ScrapBrigandine = "rbxassetid://74372010313466",
    RaiderSoul = "rbxassetid://84420808796517",
    WarchiefCrown = "rbxassetid://108759185012810",
    IronhidePlate = "rbxassetid://123756337597352",
    WarchiefSoul = "rbxassetid://106165339376438",
    RustedVisor = "rbxassetid://117075607222424",
    TarnishedPlate = "rbxassetid://86261206829209",
    ForsakenSoul = "rbxassetid://85989719627988",
    HollowKnightHelm = "rbxassetid://82202260099381",
    HollowKnightPlate = "rbxassetid://74435122322787",
    HollowSoul = "rbxassetid://105340959595746",
    AcolyteVeil = "rbxassetid://116064969424641",
    AcolyteGarb = "rbxassetid://84675952450822",
    AcolyteSoul = "rbxassetid://80774011190572",
    DeathlordCirclet = "rbxassetid://75537713481996",
    DeathlordMantle = "rbxassetid://118096212118821",
    DeathlordSoul = "rbxassetid://121350267626605",
    ValkyrieHelm = "rbxassetid://100887120025390",
    ShadowMonarchPlate = "rbxassetid://71930840402269",
    SerpentsGaze = "rbxassetid://136408043050483",
    RunicVeil = "rbxassetid://134164083938777",
    RunicHollowPlate = "rbxassetid://102786573528225",
    MoonCrescentMenpo = "rbxassetid://104049858011868",
    KingsArmor = "rbxassetid://95624354575692",
    DragonscalePlateArmor = "rbxassetid://76829425978099",
    AbyssalLordHelm = "rbxassetid://89402318487808",
    WarchiefHelm = "rbxassetid://105519100461259",
    StockadePlate = "rbxassetid://86938612013369",
    PhantomCowl = "rbxassetid://95448837811849",
    SpectralShroud = "rbxassetid://135384108743224",
    ShadowVeil = "rbxassetid://101734746071571",
    ObsidianGuard = "rbxassetid://105134528480448",
    EmberCrown = "rbxassetid://78654390505664",
    CruciblePlate = "rbxassetid://77815981458126",
    FrostVisor = "rbxassetid://125855412794525",
    GlacialAegis = "rbxassetid://126636121786688",
    AbyssalCrown = "rbxassetid://111755586133704",
    VoidforgePlate = "rbxassetid://122572321539674"
};
u1.Class_Items = {
    ShadowVagrant = "rbxassetid://88163498202716",
    SkullMemory = "rbxassetid://88797217682643",
    Artemis = "rbxassetid://119798840404618",
    Kage = "rbxassetid://114779412959037",
    Mooncarver = "rbxassetid://128318292601982",
    GoldenKatana = "rbxassetid://106807389797839",
    JudgementsEdge = "rbxassetid://75442341013503",
    GreatMageStaff = "rbxassetid://83739947840952",
    CursedShrine = "rbxassetid://140002396428813",
    InfinityCore = "rbxassetid://128507028070506",
    InvertedSpear = "rbxassetid://91978433908959",
    TidebreakerKatana = "rbxassetid://101006334180578",
    AntiMagicClaymore = "rbxassetid://120849327926749",
    Founder = "rbxassetid://116924858153858",
    OathboundLance = "rbxassetid://111061632047017",
    UnderworldGlaive = "rbxassetid://94914665545832",
    ProjectionReel = "rbxassetid://93773809120916",
    CyberneticKatana = "rbxassetid://106828808357459"
};
u1.Class_Icons = {
    Physical = "rbxassetid://93222482563125",
    Magic = "rbxassetid://109378076596164",
    Ranged = "rbxassetid://92783045647274"
};

function u1.GetClassIcon(p3: string?) -- Line: 284
    -- upvalues: u1 (copy)
    if p3 then
        return u1.Class_Icons[p3];
    end;

    return nil;
end;

u1.Materials = {
    IronScrap = "rbxassetid://129740384432970",
    IronIngots = "rbxassetid://83967960939763",
    GoldIngot = "rbxassetid://110318035685768",
    DiamondIngot = "rbxassetid://120559224875437",
    CelestialIngot = "rbxassetid://124123727642257"
};
u1.Ores = {
    IronScrap = "rbxassetid://129740384432970",
    IronOre = "rbxassetid://112330239973802",
    GoldOre = "rbxassetid://131773245794649",
    ObsidianOre = "rbxassetid://81076475697276",
    InfernalOre = "rbxassetid://99975370636742",
    RadiantOre = "rbxassetid://112667248704353",
    CelestialOre = "rbxassetid://76590795554643",
    ExoticOre = "rbxassetid://123769594698946"
};
u1.Ingots = {
    Common = "rbxassetid://72557658379312",
    Uncommon = "rbxassetid://94044175397674",
    Rare = "rbxassetid://113369917037826",
    Epic = "rbxassetid://87974903170083",
    Legendary = "rbxassetid://105205067616672",
    Mythic = "rbxassetid://79516078239647",
    Celestial = "rbxassetid://72277148701992",
    Exotic = "rbxassetid://75274857744243"
};
u1.MaterialBundles = {
    Tier1 = "rbxassetid://84510186961169",
    Tier2 = "rbxassetid://84510186961169",
    Tier3 = "rbxassetid://84510186961169"
};
u1.Keys = {
    T1 = "rbxassetid://98819310083513",
    T2 = "rbxassetid://94541869115528",
    T3 = "rbxassetid://104445211023344",
    T4 = "rbxassetid://131874497208249",
    T5 = "rbxassetid://80924120801706"
};
u1.SkillImages = {};

function u1.GetSkillImage(p4: string, p5: number) -- Line: 376
    -- upvalues: u1 (copy)
    local v6 = u1.SkillImages[p4];

    return v6 and v6[p5] or nil;
end;

u1.Dungeons = {
    ["Bandits Den"] = "rbxassetid://111227794476359",
    Goblins = "rbxassetid://77035618150349",
    Knights = "rbxassetid://86935411829908",
    Catacombs = "rbxassetid://76660309106103",
    Snow = "rbxassetid://129369670824098",
    Demon = "rbxassetid://75082082418390",
    ["Forest Challenge"] = "rbxassetid://111227794476359",
    ["Double Dungeon"] = "rbxassetid://76660309106103",
    ["Throne Room"] = "rbxassetid://86935411829908",
    ["Boss Rush"] = "rbxassetid://75082082418390",
    Raids = "rbxassetid://86935411829908"
};
u1.Aspects = {
    Fulmin = "rbxassetid://83328390794342",
    Glaciel = "rbxassetid://88198046735161",
    Blaze = "rbxassetid://81019963394881",
    Verdant = "rbxassetid://77779465563913",
    Sanguine = "rbxassetid://90387329703639",
    Umbral = "rbxassetid://101657780527610",
    Aegis = "rbxassetid://76506396908385",
    Tempest = "rbxassetid://98252340713925",
    Phantom = "rbxassetid://72574670109270",
    Ruin = "rbxassetid://77041266776499",
    Alacrity = "rbxassetid://111717006771732"
};
u1.UI = {
    Lock = "rbxassetid://119062900434102",
    Unlocked = "rbxassetid://118698010652776"
};
u1.Consumables = {
    AspectGem = "rbxassetid://131348314867544",
    BossRushSkipTicket = "rbxassetid://126472006264478"
};
u1.StatIcons = {
    MaxHP = "rbxassetid://111926445102665",
    CooldownReduction = "rbxassetid://90866878187474",
    MovementSpeed = "rbxassetid://107343539776713",
    ParryExtension = "rbxassetid://121562607936182",
    Defense = "rbxassetid://113790618744929",
    DamageReduction = "rbxassetid://96186715125367",
    BonusDamage = "rbxassetid://96628372016661",
    CritRate = "rbxassetid://101608400303297",
    CritDamage = "rbxassetid://128168846338066",
    AttackSpeed = "rbxassetid://140085609076260",
    SkillDamageBonus = "rbxassetid://139309853679910",
    ArmorShred = "rbxassetid://104212423809269",
    SkillCritChance = "rbxassetid://101608400303297",
    SkillCritDamage = "rbxassetid://128168846338066",
    AttackDamageBonus = "rbxassetid://96628372016661",
    LifeSteal = "rbxassetid://111926445102665",
    BlockMaxHealth = "rbxassetid://113790618744929",
    DodgeCooldown = "rbxassetid://121562607936182",
    DodgeRate = "rbxassetid://107343539776713"
};
u1.StatIconsBySlot = {
    MovementSpeed = {
        Body = "rbxassetid://71407003400768"
    }
};
u1.ForgeUI = {
    On = "rbxassetid://137603271530251",
    Off = "rbxassetid://82810857968789"
};

function u1.GetStatIcon(p7: string?, p8: string?) -- Line: 482
    -- upvalues: u1 (copy)
    if not p7 then
        return nil;
    end;

    local v9 = u1.StatIconsBySlot[p7];

    if v9 and (p8 and v9[p8]) then
        return v9[p8];
    end;

    return u1.StatIcons[p7];
end;

return u1;