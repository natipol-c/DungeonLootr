--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EmoteData
  Path:     game.ReplicatedStorage.GameInfo.EmoteData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local Assets = game:GetService("ReplicatedStorage"):WaitForChild("Assets");
local Emotes = Assets:WaitForChild("Emotes");
local EmoteAuras = Assets:WaitForChild("EmoteAuras", 10);
local EmoteSounds = Assets:WaitForChild("EmoteSounds", 10);
u1.WHEEL_SLOTS = 8;
u1.DEFAULT_FORCED_SPEED = 8;
local u2 = {
    Forward = true,
    Back = true,
    Left = true,
    Right = true
};
u1.Emotes = {
    Low_Cortisol = {
        DisplayName = "Low Cortisol",
        Animation = "Low_Cortisol",
        Order = 1,
        Rarity = "Common"
    },
    Shuffle = {
        DisplayName = "Shuffle",
        Animation = "Shuffle",
        Order = 2,
        Rarity = "Uncommon"
    },
    IdleSit = {
        DisplayName = "Idle Sit",
        Animation = "Idle Sit",
        Order = 3,
        Rarity = "Uncommon"
    },
    EDanceSupreme = {
        DisplayName = "E Dance Supreme",
        Animation = "E Dance Surpeme",
        Order = 4,
        Rarity = "Epic"
    },
    SnappySkipping = {
        DisplayName = "Snappy Skipping",
        Animation = "Snappy Skipping",
        Order = 5,
        Rarity = "Epic"
    },
    CashMoneyDance = {
        DisplayName = "Cash Money Dance",
        Animation = "Cash Money Dance",
        Order = 6,
        Rarity = "Epic"
    },
    Moongazer = {
        DisplayName = "Moongazer",
        Animation = "Moongazer",
        Order = 7,
        Rarity = "Rare"
    },
    AnimePose = {
        DisplayName = "Anime Pose",
        Animation = "Anime Pose",
        Order = 8,
        Rarity = "Uncommon"
    },
    ElectroShuffle = {
        DisplayName = "Electro Shuffle",
        Animation = "Electro Shuffle",
        Order = 9,
        Rarity = "Rare"
    },
    Skeleton = {
        DisplayName = "Skeleton",
        Animation = "Skeleton",
        Order = 10,
        Rarity = "Uncommon"
    },
    Marat = {
        DisplayName = "Marat",
        Animation = "Marat",
        Order = 11,
        Rarity = "Epic"
    },
    WibblyWobbly = {
        DisplayName = "Wibbly Wobbly",
        Animation = "Wibbly Wobbly",
        Order = 12,
        Rarity = "Mythic"
    },
    IdleDance = {
        DisplayName = "Idle Dance",
        Animation = "Idle Dance",
        Order = 13,
        Rarity = "Common"
    },
    Flexer = {
        DisplayName = "Flexer",
        Animation = "Flexer",
        Order = 14,
        Rarity = "Epic"
    },
    BandDance = {
        DisplayName = "Band Dance",
        Animation = "Band Dance",
        Order = 15,
        Rarity = "Epic"
    },
    WavyGrooves = {
        DisplayName = "Wavy Grooves",
        Animation = "Wavy Grooves",
        Order = 16,
        Rarity = "Epic"
    },
    SkeletonGrooves = {
        DisplayName = "Skeleton Grooves",
        Animation = "Skeleton Grooves",
        Order = 17,
        Rarity = "Uncommon"
    },
    Jumpstyle = {
        DisplayName = "Jumpstyle",
        Animation = "Jumpstyle",
        Order = 18,
        Rarity = "Celestial",
        Sound = "Jumpstyle"
    },
    BoogieDown = {
        DisplayName = "Boogie Down",
        Animation = "Boogie Down",
        Order = 19,
        Rarity = "Rare"
    },
    ParrotWiggle = {
        DisplayName = "Parrot Wiggle",
        Animation = "Parrot Wiggle",
        Order = 20,
        Rarity = "Epic"
    },
    NekoDance = {
        DisplayName = "Neko Dance",
        Animation = "Neko Dance",
        Order = 21,
        Rarity = "Legendary",
        Limited = true
    },
    GamblerDance = {
        DisplayName = "Gambler Dance",
        Animation = "Gambler Dance",
        Order = 22,
        Rarity = "Celestial",
        Aura = "Gambler Dance"
    },
    TheHonoredOne = {
        DisplayName = "The Honored One",
        Animation = "The Honored One",
        Order = 24,
        Rarity = "Celestial"
    },
    TheStarEmote = {
        DisplayName = "The Star Emote",
        Animation = "The Star Emote",
        Order = 25,
        Rarity = "Mythic"
    },
    CompanyDance = {
        DisplayName = "Company Dance",
        Animation = "Company Dance",
        Order = 26,
        Rarity = "Legendary"
    },
    ReapersRide = {
        DisplayName = "Reaper\'s Ride",
        Animation = "Reaper\'s Ride",
        Order = 27,
        Rarity = "Rare"
    },
    FloatingMeditation = {
        DisplayName = "Floating Meditation",
        Animation = "Floating Meditation",
        Order = 28,
        Rarity = "Legendary"
    },
    KazotskyKick = {
        DisplayName = "Kazotsky Kick",
        Animation = "Kazotsky Kick",
        Order = 29,
        Rarity = "Legendary",
        Movement = true
    },
    OrangeJustice = {
        DisplayName = "Orange Justice",
        Animation = "Orange Justice",
        Order = 30,
        Rarity = "Legendary"
    },
    ZombieDance = {
        DisplayName = "Zombie Dance",
        Animation = "Zombie Dance",
        Order = 31,
        Rarity = "Legendary"
    },
    TakeTheL = {
        DisplayName = "Take the L",
        Animation = "Take the L",
        Order = 32,
        Rarity = "Legendary"
    },
    CouchNap = {
        DisplayName = "Couch Nap",
        Animation = "Couch Nap",
        Order = 33,
        Rarity = "Epic"
    },
    Breakdance = {
        DisplayName = "Breakdance",
        Animation = "Breakdance",
        Order = 34,
        Rarity = "Epic"
    },
    Beatbox = {
        DisplayName = "Beatbox",
        Animation = "Beatbox",
        Order = 35,
        Rarity = "Legendary"
    },
    BlossomBreak = {
        DisplayName = "Blossom Break",
        Animation = "Blossom Break",
        Order = 36,
        Rarity = "Rare"
    },
    CrossedSit = {
        DisplayName = "Crossed Sit",
        Animation = "Crossed Sit",
        Order = 37,
        Rarity = "Rare"
    },
    FeminineIdle = {
        DisplayName = "Feminine Idle",
        Animation = "Feminine Idle",
        Order = 38,
        Rarity = "Epic"
    },
    Lean = {
        DisplayName = "Lean",
        Animation = "Lean",
        Order = 39,
        Rarity = "Mythic"
    },
    LookingUp = {
        DisplayName = "Looking Up",
        Animation = "Looking Up",
        Order = 40,
        Rarity = "Epic"
    },
    PocketHands = {
        DisplayName = "Pocket Hands",
        Animation = "Pocket Hands",
        Order = 41,
        Rarity = "Legendary"
    },
    SeatedGlare = {
        DisplayName = "Seated Glare",
        Animation = "Seated Glare",
        Order = 42,
        Rarity = "Celestial"
    },
    SittingForward = {
        DisplayName = "Sitting Forward",
        Animation = "Sitting Forward",
        Order = 43,
        Rarity = "Legendary"
    },
    WarmUp = {
        DisplayName = "Warm Up",
        Animation = "Warm Up",
        Order = 44,
        Rarity = "Mythic",
        Limited = true
    },
    Lunarwalk = {
        DisplayName = "Lunarwalk",
        Animation = "Lunarwalk",
        Order = 45,
        Rarity = "Mythic",
        Limited = true,
        ForcedMovement = {
            Direction = "Back",
            Speed = 8
        }
    },
    RatDance = {
        DisplayName = "Rat Dance",
        Animation = "Rat Dance",
        Order = 46,
        Rarity = "Celestial"
    }
};
u1.DEFAULT_GRANTS = { "FeminineIdle", "CrossedSit", "IdleDance" };

function u1.Get(p3: string) -- Line: 420
    -- upvalues: u1 (copy)
    return u1.Emotes[p3];
end;

function u1.IsValid(p4: string) -- Line: 425
    -- upvalues: u1 (copy)
    return u1.Emotes[p4] ~= nil;
end;

function u1.IsPlayable(p5: string) -- Line: 435
    -- upvalues: u1 (copy)
    return u1.GetAnimation(p5) ~= nil;
end;

function u1.IsShopEligible(p6: string) -- Line: 443
    -- upvalues: u1 (copy)
    local v7 = u1.Emotes[p6];
    local v8;

    if v7 == nil then
        v8 = false;
    else
        v8 = not v7.Limited;
    end;

    return v8;
end;

function u1.AllowsMovement(p9: string) -- Line: 452
    -- upvalues: u1 (copy)
    local v10 = u1.Emotes[p9];
    local v11;

    if v10 == nil then
        v11 = false;
    else
        v11 = v10.Movement == true;
    end;

    return v11;
end;

function u1.GetForcedMovement(p12: string) -- Line: 462
    -- upvalues: u1 (copy), u2 (copy)
    local v13 = u1.Emotes[p12];

    if not v13 or type(v13.ForcedMovement) ~= "table" then
        return nil;
    end;

    local ForcedMovement = v13.ForcedMovement;
    local Direction = ForcedMovement.Direction;
    local v14 = (type(Direction) ~= "string" or not u2[Direction]) and "Back" or Direction;
    local Speed = ForcedMovement.Speed;

    if type(Speed) ~= "number" or Speed <= 0 then
        Speed = u1.DEFAULT_FORCED_SPEED;
    end;

    return {
        Direction = v14,
        Speed = Speed
    };
end;

function u1.GetAnimation(p15: string) -- Line: 478
    -- upvalues: u1 (copy), Emotes (copy)
    local v16 = u1.Emotes[p15];

    if not v16 then
        return nil;
    end;

    local v17 = Emotes:FindFirstChild(v16.Animation);

    if v17 and v17:IsA("Animation") then
        return v17;
    end;

    return nil;
end;

function u1.GetAura(p18: string) -- Line: 491
    -- upvalues: u1 (copy), EmoteAuras (copy)
    local v19 = u1.Emotes[p18];

    if not (v19 and v19.Aura) then
        return nil;
    end;

    if EmoteAuras then
        return EmoteAuras:FindFirstChild(v19.Aura);
    end;

    return nil;
end;

function u1.GetSound(p20: string) -- Line: 500
    -- upvalues: u1 (copy), EmoteSounds (copy)
    local v21 = u1.Emotes[p20];

    if not (v21 and v21.Sound) then
        return nil;
    end;

    if not EmoteSounds then
        return nil;
    end;

    local v22 = EmoteSounds:FindFirstChild(v21.Sound);

    if v22 and v22:IsA("Sound") then
        return v22;
    end;

    return nil;
end;

function u1.HasFX(p23: string) -- Line: 514
    -- upvalues: u1 (copy)
    local v24 = u1.Emotes[p23];
    local v25;

    if v24 == nil then
        v25 = false;
    else
        v25 = v24.Aura ~= nil and true or v24.Sound ~= nil;
    end;

    return v25;
end;

function u1.GetAllIds() -- Line: 520
    -- upvalues: u1 (copy)
    local v26 = {};

    for i in u1.Emotes do
        table.insert(v26, i);
    end;

    table.sort(v26, function(p27, p28) -- Line: 525
        -- upvalues: u1 (ref)
        local v29 = u1.Emotes[p27].Order or (1 / 0);
        local v30 = u1.Emotes[p28].Order or (1 / 0);

        if v29 == v30 then
            return p27 < p28;
        end;

        return v29 < v30;
    end);

    return v26;
end;

return u1;