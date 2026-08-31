--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     NotificationController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.NotificationController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TextChatService = game:GetService("TextChatService");
game:GetService("RunService");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Knit = require(game.ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.SharedDictionaries.RarityColors);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    [4931652257] = Color3.fromRGB(255, 0, 0),
    [5458619467] = Color3.fromRGB(255, 170, 0),
    [1484939719] = Color3.fromRGB(255, 170, 255)
};
local Color3_fromRGB_ret = Color3.fromRGB(255, 206, 82);
local u2 = Knit.CreateController({
    Name = "NotificationController",
    _current = {},
    _messageCount = {},
    _hideToken = {}
});

function u2.KnitInit(p3) -- Line: 33
    -- upvalues: Knit (copy)
    local PlayerGui = Knit.PlayerGui;
    Knit.NotificationGui = PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):WaitForChild("Notification");
    Knit.Template = Knit.NotificationGui:WaitForChild("Template");
    Knit.Template.Visible = false;
    Knit.AnnouncementGui = PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):WaitForChild("Announcements");
    Knit.AnnouncementTemplate = Knit.AnnouncementGui:WaitForChild("Template");
    Knit.AnnouncementTemplate.Visible = false;
end;

function u2.KnitStart(u4) -- Line: 45
    -- upvalues: Knit (copy)
    Knit.GetService("NotificationService").SendMessage:Connect(function(p5, ...) -- Line: 47
        -- upvalues: u4 (copy)
        u4:Show(p5, ...);
    end);
end;

local function Color3ToHex(p6) -- Line: 55
    local math_floor_ret = math.floor(p6.R * 255);
    local math_floor_ret2 = math.floor(p6.G * 255);
    local math_floor_ret3 = math.floor(p6.B * 255);

    return string.format("#%02X%02X%02X", math_floor_ret, math_floor_ret2, math_floor_ret3);
end;

function u2.SendSystemChatMessage(p7: string, p8) -- Line: 65
    -- upvalues: TextChatService (copy)
    local v9 = p8 or Color3.fromRGB(80, 255, 80);
    local math_floor_ret = math.floor(v9.R * 255);
    local math_floor_ret2 = math.floor(v9.G * 255);
    local math_floor_ret3 = math.floor(v9.B * 255);
    local v10 = `<font color="{string.format("#%02X%02X%02X", math_floor_ret, math_floor_ret2, math_floor_ret3)}">{p7}</font>`;
    local v11 = TextChatService:FindFirstChild("TextChannels") and TextChatService.TextChannels:FindFirstChild("RBXGeneral");

    if v11 then
        v11:DisplaySystemMessage(v10);
    end;
end;

u2.PRESETS = {
    DUNGEON_CLEARED = function(p12) -- Line: 81
        -- upvalues: u2 (copy)
        u2:Show("Custom", `🏆 {p12} Cleared!`, 5, Color3.fromRGB(100, 255, 100), Color3.fromRGB(30, 80, 30), "GiftReceived");
    end,

    DUNGEON_FAILED = function(p13) -- Line: 92
        -- upvalues: u2 (copy)
        u2:Show("Custom", `💀 {p13} Failed!`, 5, Color3.fromRGB(255, 80, 80), Color3.fromRGB(80, 20, 20), "Error");
    end,

    BOSS_SPAWNING = function(p14) -- Line: 103
        -- upvalues: u2 (copy)
        u2:Show("Custom", `⚠️ {p14} has appeared!`, 5, Color3.fromRGB(255, 50, 50), Color3.fromRGB(80, 10, 10), "GiftReceived");
    end,

    DUNGEON_TIME_WARNING = function(p15) -- Line: 114
        -- upvalues: u2 (copy)
        u2:Show("Custom", `⏰ {p15} seconds remaining!`, 3, Color3.fromRGB(255, 200, 50), Color3.fromRGB(80, 60, 10), "Error");
    end,

    DUNGEON_ESCAPE = function() -- Line: 125
        -- upvalues: u2 (copy)
        u2:Show("Custom", "🚪 Get to the portal! 15 seconds!", 5, Color3.fromRGB(100, 200, 255), Color3.fromRGB(20, 60, 80), "Ting");
    end,

    DUNGEON_LOCKED = function() -- Line: 136
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Dungeon is already in progress", 3, Color3.fromRGB(255, 150, 50), Color3.fromRGB(80, 40, 10), "Error");
    end,

    WAVE_CLEARED = function(p16) -- Line: 147
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Wave cleared!", 2, Color3.fromRGB(150, 255, 150), Color3.fromRGB(30, 80, 30), "Ting");
    end,

    NO_SLOTS = function() -- Line: 170
        -- upvalues: u2 (copy)
        u2:Show("Custom", "No available slots", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    NO_SPACE_INVENTORY = function() -- Line: 181
        -- upvalues: u2 (copy)
        u2:Show("Custom", "No space in inventory", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    INVENTORY_FULL = function() -- Line: 192
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Inventory is full!", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    IDENTIFY_INVENTORY_FULL = function() -- Line: 205
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Not enough inventory space to extract all items!", 5, Color3.new(1, 0.65, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    LOOT_BAG_FULL = function() -- Line: 216
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Loot bag is full! Lower rarity items will be replaced.", 5, Color3.new(1, 0.5, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    LOOT_REPLACED = function(p17, p18) -- Line: 227
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Replaced {p18} item with {p17} drop!`, 4, Color3.fromRGB(255, 200, 50), Color3.fromRGB(80, 60, 10), "Ting");
    end,

    LOOT_STORAGE_FULL = function() -- Line: 239
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Inventory and Loot Storage are full! Collect or sell to make room.", 5, Color3.new(1, 0.5, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    FLOOR_UNLOCKED = function(p19) -- Line: 250
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Floor {p19} Unlocked!`, 5, Color3.new(0, 1, 0.4), Color3.new(0, 0.5, 0.2), "Ting");
    end,

    MAX_FLOOR_REACHED = function() -- Line: 261
        -- upvalues: u2 (copy)
        u2:Show("Custom", "You\'ve unlocked all floors!", 3, Color3.new(1, 0.8, 0), Color3.new(0.5, 0.4, 0), "Ting");
    end,

    TITLE_UNLOCKED = function(p20) -- Line: 272
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Unlocked {p20}`, 5, Color3.new(1, 0.666667, 0), Color3.new(0.666667, 0.333333, 0), "Ting");
    end,

    WEAPON_UNLOCKED = function(p21) -- Line: 283
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Unlocked {p21}`, 5, Color3.new(1, 0.666667, 0), Color3.new(0.666667, 0.333333, 0), "Ting");
    end,

    INVENTORY_ADDED = function(p22) -- Line: 294
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `Added {SharedUtils.GetRichCharacterName(p22)} to inventory`, 5, Color3.new(0.298039, 1, 0.235294), Color3.new(0.258823, 0.513725, 0.160784), "Ting");
    end,

    BASE_ITEM_ADDED = function(p23) -- Line: 305
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `Added {SharedUtils.GetRichCharacterName(p23)} to base`, 5, Color3.new(0.298039, 1, 0.235294), Color3.new(0.258823, 0.513725, 0.160784), "Ting");
    end,

    ITEM_EQUIPPED = function(p24) -- Line: 316
        -- upvalues: SharedUtils (copy), u2 (copy)
        u2:Show("Custom", `Equipped {SharedUtils.GetRichCharacterName(p24)}`, 5, Color3.new(0.298039, 1, 0.235294), Color3.new(0.258823, 0.513725, 0.160784), "Ting");
    end,

    ITEM_STOLEN = function(p25, p26) -- Line: 328
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `🚨 {p25} is stealing your {SharedUtils.GetRichCharacterName(p26)} !`, 5, Color3.new(1, 0.309803, 0.309803), Color3.new(0.419607, 0.117647, 0.117647), "Stealing");
    end,

    STEALING = function(p27, p28) -- Line: 339
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `You are stealing {SharedUtils.GetRichCharacterName(p28)} from {p27}!`, 5, Color3.new(1, 0.309803, 0.309803), Color3.new(0.419607, 0.117647, 0.117647), "Ting");
    end,

    THEFT_SUCCESS = function(p29) -- Line: 350
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `Successfully stole {SharedUtils.GetRichCharacterName(p29)}!`, 5, Color3.new(0.298039, 1, 0.235294), Color3.new(0.258823, 0.513725, 0.160784), "Ting");
    end,

    THEFT_FAILED = function() -- Line: 361
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Theft failed!", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    LOST_ITEM = function(p30) -- Line: 372
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `You lost {SharedUtils.GetRichCharacterName(p30)}!`, 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    ITEM_SOLD = function(p31) -- Line: 383
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `Sold {SharedUtils.GetRichCharacterName(p31)}!`, 5, Color3.new(1, 1, 1), Color3.new(0.258823, 0.258823, 0.258823), "Ting");
    end,

    NO_CASH = function(p32) -- Line: 394
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `Not enough coins to buy {SharedUtils.GetRichCharacterName(p32)}!`, 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    NO_CASH_BUY_ITEM = function(p33) -- Line: 405
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Not enough coins to buy {p33}!`, 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    ALREADY_OWNED = function(p34) -- Line: 416
        -- upvalues: u2 (copy)
        u2:Show("Custom", `You already own {p34}!`, 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    NOT_ENOUGH_REBIRTHS = function(p35) -- Line: 429
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Not enough rebirths to purchase {p35}!`, 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    MAX_REBIRTHS = function() -- Line: 440
        -- upvalues: u2 (copy)
        u2:Show("Custom", "You have reached the maximum rebirths!", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    NO_ITEM = function(p36) -- Line: 451
        -- upvalues: u2 (copy)
        u2:Show("Custom", `No item found with ID {p36}!`, 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    REBIRTH_SUCCESSFUL = function(p37) -- Line: 462
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Rebirth successful! You are now at Rebirth {p37}!`, 5, Color3.new(0.654901, 0.235294, 1), Color3.new(0.247058, 0.117647, 0.392156), "GiftReceived");
    end,

    REBIRTH_FAILED = function() -- Line: 473
        -- upvalues: u2 (copy)
        u2:Show("Custom", "You cannot rebirth yet! Check your requirements.", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    ITEM_DROP = function(p38) -- Line: 484
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `You dropped {SharedUtils.GetRichCharacterName(p38)}!`, 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509));
    end,

    BASE_LOCKED = function(p39: number) -- Line: 494
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Your base is locked for {p39}s!`, 5, Color3.new(0, 0.431372, 1), Color3.new(0, 0, 0), "Ting");
    end,

    BASE_UNLOCKED = function() -- Line: 505
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Your base is unlocked!", 5, Color3.new(0.298039, 1, 0.235294), Color3.new(0.258823, 0.513725, 0.160784), "Ting");
    end,

    ITEM_LOOTED = function(p40) -- Line: 516
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `You looted {SharedUtils.GetRichCharacterName(p40)}!`, 5, Color3.new(0.298039, 1, 0.235294), Color3.new(0.258823, 0.513725, 0.160784), "Ting");
    end,

    ITEM_RELEASED = function(p41) -- Line: 527
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `You released {SharedUtils.GetRichCharacterName(p41)}!`, 5, Color3.new(1, 0, 0), Color3.new(0, 0, 0), "Ting");
    end,

    ITEM_SNIPE = function(p42, p43) -- Line: 538
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `You lost {SharedUtils.GetRichCharacterName(p42)} to {p43.Name}!`, 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    PURCHASE_SUCCESS = function() -- Line: 549
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Thanks for the Purchase!", 5, Color3.new(0.298039, 1, 0.235294), Color3.new(0.258823, 0.513725, 0.160784), "Ting");
    end,

    NOT_ENOUGH_STARS = function() -- Line: 559
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Not enough Stars!", 5, Color3.new(1, 0.8, 0), Color3.new(0.4, 0.3, 0), "Error");
    end,

    STARS_AWARDED = function(p44) -- Line: 569
        -- upvalues: u2 (copy)
        u2:Show("Custom", `+{p44} ⭐ Stars`, 3, Color3.new(0.666667, 1, 1), Color3.new(0.666667, 0.666667, 1), "Ting");
    end,

    PURCHASE_FAILED = function() -- Line: 580
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Purchase failed!", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    SKILL_THEFT = function() -- Line: 590
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Can\'t use skills while stealing!", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    RETURN_BACK_TO_BASE = function(p45) -- Line: 601
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Return Back to Base to {p45}`, 5, Color3.new(1, 0, 0), Color3.new(0.247058, 0, 0), "Error");
    end,

    CASH_AWARDED = function(p46) -- Line: 612
        -- upvalues: u2 (copy)
        u2:Show("Custom", `+{require(game.ReplicatedStorage.Modules.SharedUtils).FormatCashString(p46)} Cash!`, 5, Color3.new(0.298039, 1, 0.235294), Color3.new(0.258823, 0.513725, 0.160784), "Ting");
    end,

    ANNOUNCEMENT = function(p47, p48, p49) -- Line: 626
        -- upvalues: u1 (copy), Color3_fromRGB_ret (copy), u2 (copy)
        local v50 = u1[p49] or Color3_fromRGB_ret;
        local math_floor_ret = math.floor(v50.R * 255);
        local math_floor_ret2 = math.floor(v50.G * 255);
        local math_floor_ret3 = math.floor(v50.B * 255);
        u2:Show("Announcement", `<font color="{string.format("#%02X%02X%02X", math_floor_ret, math_floor_ret2, math_floor_ret3)}">[{p48 or "Server"}]:</font> {p47}`, 8, Color3.new(1, 1, 1), Color3.new(0, 0, 0), "GiftReceived");
    end,

    CODE_SUCCESS = function() -- Line: 642
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Code redeemed successfully!", 5, Color3.new(0.298039, 1, 0.235294), Color3.new(0.258823, 0.513725, 0.160784), "GiftReceived");
    end,

    CODE_INVALID = function() -- Line: 653
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Invalid code!", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    CODE_EXPIRED = function() -- Line: 664
        -- upvalues: u2 (copy)
        u2:Show("Custom", "This code has expired!", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    CODE_ALREADY_REDEEMED = function() -- Line: 675
        -- upvalues: u2 (copy)
        u2:Show("Custom", "You\'ve already redeemed this code!", 5, Color3.new(1, 0.666667, 0), Color3.new(0.5, 0.333333, 0), "Error");
    end,

    CODE_MAX_USES = function() -- Line: 686
        -- upvalues: u2 (copy)
        u2:Show("Custom", "This code has reached its maximum uses!", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    CODE_BUSY = function() -- Line: 697
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Still processing your last code — try again in a moment!", 5, Color3.new(1, 0.666667, 0), Color3.new(0.5, 0.333333, 0), "Ting");
    end,

    CODE_REQUIRES_GROUP = function() -- Line: 708
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Join our group to use this code!", 5, Color3.new(0, 0.666667, 1), Color3.new(0, 0.333333, 0.5), "Ting");
    end,

    CODE_REQUIRES_ROLE = function() -- Line: 719
        -- upvalues: u2 (copy)
        u2:Show("Custom", "This code is restricted to a specific group role!", 5, Color3.new(0, 0.666667, 1), Color3.new(0, 0.333333, 0.5), "Error");
    end,

    CODE_REQUIRES_LEVEL = function(p51) -- Line: 730
        -- upvalues: u2 (copy)
        u2:Show("Custom", `You must be Level {p51 or "??"} to use this code!`, 5, Color3.new(1, 0.666667, 0), Color3.new(0.5, 0.333333, 0), "Error");
    end,

    CODE_FAILED = function() -- Line: 741
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Failed to redeem code. Please try again.", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    CODE_CURRENCY = function(p52) -- Line: 754
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `Received {SharedUtils.FormatNumber(p52)} Coins!`, 5, Color3.new(1, 0.843137, 0), Color3.new(0.5, 0.4, 0), "GiftReceived");
    end,

    CODE_HERO = function(p53) -- Line: 765
        -- upvalues: u2 (copy), SharedUtils (copy)
        u2:Show("Custom", `Received {SharedUtils.GetRichCharacterName(p53)}!`, 5, Color3.new(0.654901, 0.235294, 1), Color3.new(0.247058, 0.117647, 0.392156), "GiftReceived");
    end,

    CODE_REBIRTHS = function(p54) -- Line: 778
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Received {p54} Rebirth(s)!`, 5, Color3.new(0.654901, 0.235294, 1), Color3.new(0.247058, 0.117647, 0.392156), "GiftReceived");
    end,

    CODE_MATERIAL = function(p55, p56) -- Line: 789
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Received {p56}x {p55}!`, 5, Color3.new(0.6, 0.85, 1), Color3.new(0.2, 0.35, 0.5), "GiftReceived");
    end,

    CODE_CUSTOM = function() -- Line: 800
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Special reward received!", 5, Color3.new(1, 0.843137, 0), Color3.new(0.5, 0.4, 0), "GiftReceived");
    end,

    CHECK_FOLLOW_REQUIRED = function() -- Line: 812
        -- upvalues: u2 (copy)
        u2:Show("Custom", "Make sure you\'re following this developer! Follow and try again", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end,

    CHECK_CLAIMED = function(p57) -- Line: 823
        -- upvalues: u2 (copy)
        u2:Show("Custom", p57 and `Received {p57}!` or "Reward claimed!", 5, Color3.new(0.298039, 1, 0.235294), Color3.new(0.258823, 0.513725, 0.160784), "GiftReceived");
    end,

    CODE_COSMETIC = function(p58) -- Line: 834
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Unlocked cosmetic: {p58 or "Unknown"}!`, 5, Color3.fromRGB(180, 100, 255), Color3.fromRGB(60, 30, 90), "GiftReceived");
    end,

    COSMETIC_PACK_DROP = function(p59) -- Line: 845
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Rare drop! {p59 or "Cosmetic Package"} — open it from your Inventory!`, 6, Color3.fromRGB(255, 200, 90), Color3.fromRGB(90, 60, 20), "GiftReceived");
    end,

    ALREADY_PROTECTED = function() -- Line: 856
        -- upvalues: u2 (copy)
        u2:Show("Custom", "This hero is already protected!", 5, Color3.new(1, 0.666667, 0), Color3.new(0.5, 0.333333, 0), "Error");
    end,

    SKILL_ACTIVATED = function(p60) -- Line: 868
        -- upvalues: u2 (copy)
        u2:Show("Custom", `⚔️ {p60}`, 2, Color3.new(1, 0.8, 0.2), Color3.new(0.4, 0.2, 0), "SkillActivate");
    end,

    SKILL_READY = function(p61) -- Line: 879
        -- upvalues: u2 (copy)
        u2:Show("Custom", `{p61} Ready!`, 2, Color3.new(0.2, 1, 0.6), Color3.new(0, 0.4, 0.2), "SkillReady");
    end,

    STARS_COLLECTED = function(p62) -- Line: 891
        -- upvalues: u2 (copy)
        u2:Show("Custom", `+{p62} ⭐ Stars`, 3, Color3.fromRGB(255, 215, 0), Color3.fromRGB(100, 80, 0), "Ting");
    end,

    CRYSTAL_COLLECTED = function(p63, p64) -- Line: 902
        -- upvalues: u2 (copy)
        u2:Show("Custom", `+{p64} 💎 {string.gsub(p63, " Crystal", "")} Crystal`, 3, Color3.fromRGB(180, 100, 255), Color3.fromRGB(60, 30, 90), "Ting");
    end,

    WEAPON_CRAFTED = function(p65) -- Line: 917
        -- upvalues: u2 (copy)
        u2:Show("Custom", `🔨 Crafted {p65}!`, 5, Color3.fromRGB(100, 255, 150), Color3.fromRGB(30, 80, 50), "Ting");
    end,

    CHEST_TO_INVENTORY = function(p66, p67) -- Line: 928
        -- upvalues: u2 (copy)
        u2:Show("Custom", p67 > 1 and `{p67}x {p66} added to Inventory` or `{p66} added to Inventory`, 5, Color3.fromRGB(255, 215, 0), Color3.fromRGB(80, 60, 10), "GiftReceived");
    end,

    BUFF_ACTIVATED = function(p68, p69) -- Line: 942
        -- upvalues: u2 (copy)
        u2:Show("Custom", `🧪 {p68} activated! ({math.floor(p69 / 60)}m)`, 5, Color3.fromRGB(100, 200, 255), Color3.fromRGB(20, 60, 80), "GiftReceived");
    end,

    BUFF_EXTENDED = function(p70, p71) -- Line: 954
        -- upvalues: u2 (copy)
        u2:Show("Custom", `🧪 {p70} extended! (+{math.floor(p71 / 60)}m)`, 5, Color3.fromRGB(100, 255, 200), Color3.fromRGB(20, 80, 60), "GiftReceived");
    end,

    BUFF_EXPIRED = function(p72) -- Line: 966
        -- upvalues: u2 (copy)
        u2:Show("Custom", `{p72} has expired`, 4, Color3.fromRGB(200, 200, 200), Color3.fromRGB(60, 60, 60), "Ting");
    end,

    QUEST_ITEM_GRANTED = function(p73) -- Line: 977
        -- upvalues: u2 (copy)
        u2:Show("Custom", `Quest Item Obtained: {p73}`, 5, Color3.fromRGB(180, 80, 255), Color3.fromRGB(40, 0, 80), "GiftReceived");
    end,

    GIFT_RECEIVED = function(p74, p75) -- Line: 988
        -- upvalues: u2 (copy)
        local v76 = p75 and ` ({p75})` or "";
        u2:Show("Custom", `🎁 You received a gift from {p74}!{v76}`, 5, Color3.fromRGB(80, 255, 80), Color3.fromRGB(20, 80, 20), "GiftReceived");
        u2.SendSystemChatMessage(`🎁 You received a gift from {p74}!{v76}`, Color3.fromRGB(80, 255, 80));
    end,

    GIFT_SENT = function(p77) -- Line: 1006
        -- upvalues: u2 (copy)
        u2:Show("Custom", `🎁 Gift sent to {p77}!`, 5, Color3.fromRGB(80, 255, 80), Color3.fromRGB(20, 80, 20), "GiftReceived");
        u2.SendSystemChatMessage(`🎁 Gift sent to {p77}!`, Color3.fromRGB(80, 255, 80));
    end,

    SKILL_UPGRADE_NO_COINS = function(p78) -- Line: 1025
        -- upvalues: SharedUtils (copy), u2 (copy)
        u2:Show("Custom", p78 and `Not enough coins to upgrade! ({SharedUtils.FormatNumber(p78)} Coins needed)` or "Not enough coins to upgrade skill!", 5, Color3.new(1, 0, 0), Color3.new(0.278431, 0.074509, 0.074509), "Error");
    end
};

function u2.Alert(p79, ...) -- Line: 1041
    -- upvalues: Knit (copy), TweenService (copy), u2 (copy)
    if p79 ~= "Announcement" then
        if p79 == "Custom" then
            local u80, v81, v82, v83, v84 = ...;
            u2._messageCount[u80] = (u2._messageCount[u80] or 0) + 1;
            local v85 = u2._messageCount[u80];
            local v86;

            if v85 > 1 then
                v86 = `{u80} (x{v85})` or u80;
            else
                v86 = u80;
            end;

            local v87 = not u2._current[u80];
            local u88 = u2._current[u80] or Knit.Template:Clone();
            u88.Text = v86;
            u88.TextColor3 = v82 or Color3.new(1, 1, 1);
            u88.UIStroke.Color = v83 or Color3.new(0, 0, 0);
            u88.Parent = Knit.NotificationGui;
            u88.Visible = true;
            u2._current[u80] = u88;

            if v87 then
                u88.Size = UDim2.fromScale(0, 0);
                TweenService:Create(u88, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = Knit.Template.Size
                }):Play();
            end;

            local u89 = (u2._hideToken[u80] or 0) + 1;
            u2._hideToken[u80] = u89;
            task.delay(v81 or 5, function() -- Line: 1112
                -- upvalues: u2 (ref), u80 (copy), u89 (copy), TweenService (ref), u88 (copy)
                if u2._hideToken[u80] ~= u89 then
                    return;
                end;

                TweenService:Create(u88, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(0, 0)
                }):Play();
                u2._current[u80] = nil;
                u2._messageCount[u80] = nil;
                u2._hideToken[u80] = nil;
                task.wait(0.2);
                u88:Destroy();
            end);

            if v84 then
                Knit.GetController("SoundController"):Play(v84);
            end;
        end;

        local v90 = { ... };
        local v91 = u2.PRESETS[p79];

        if v91 then
            v91(unpack(v90));
        end;

        return;
    end;

    local v92, v93, v94, v95, v96 = ...;
    local u97 = Knit.AnnouncementTemplate:Clone();
    u97.Text = v92;
    u97.TextColor3 = v94 or Color3.new(1, 1, 1);
    u97.UIStroke.Color = v95 or Color3.new(0, 0, 0);
    u97.Parent = Knit.AnnouncementGui;
    u97.Visible = true;
    u97.Size = UDim2.fromScale(0, 0);
    TweenService:Create(u97, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = Knit.AnnouncementTemplate.Size
    }):Play();
    task.delay(v93 or 8, function() -- Line: 1062
        -- upvalues: TweenService (ref), u97 (copy)
        TweenService:Create(u97, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Size = UDim2.fromScale(0, 0)
        }):Play();
        task.wait(0.3);
        u97:Destroy();
    end);

    if v96 then
        Knit.GetController("SoundController"):Play(v96);
    end;
end;

function u2.Show(p98, p99, ...) -- Line: 1141
    -- upvalues: u2 (copy)
    u2.Alert(p99, ...);
end;

return u2;