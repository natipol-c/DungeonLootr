--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PassiveBonusData
  Path:     game.ReplicatedStorage.GameInfo.PassiveBonusData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local Image_Data = require(script.Parent:WaitForChild("Image_Data"));
local u4 = {
    Bonuses = {
        Friends = {
            Id = "Friends",
            Name = "Friend Bonus",
            Description = "+5% Player & Class EXP per friend in this server (max +20%).",
            LayoutOrder = 1,
            PlayerMultPerStack = 0.05,
            ClassMultPerStack = 0.05,
            MaxStacks = 4,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.Friends or "rbxassetid://0") or "rbxassetid://0",

            FormatDisplay = function(p1) -- Line: 49, Name: FormatDisplay
                local math_min_ret = math.min(p1 and p1.Count or 0, 4);

                return math_min_ret <= 0 and "" or string.format("+%d%%", math_min_ret * 5);
            end,

            FormatDetail = function(p2) -- Line: 57, Name: FormatDetail
                local v3 = p2 and p2.Count or 0;

                return v3 <= 0 and "No friends in this server" or (v3 == 1 and "1 friend in this server" or string.format("%d friends in this server", v3));
            end
        },
        Premium = {
            Id = "Premium",
            Name = "Premium Bonus",
            Description = "Roblox Premium: +5% Player EXP and +10% Class EXP.",
            LayoutOrder = 2,
            PlayerMult = 0.05,
            ClassMult = 0.1,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.Premium or "rbxassetid://0") or "rbxassetid://0",

            FormatDisplay = function() -- Line: 77, Name: FormatDisplay
                return "";
            end,

            FormatDetail = function() -- Line: 79, Name: FormatDetail
                return "Premium Active";
            end
        },
        VIP = {
            Id = "VIP",
            Name = "VIP Bonus",
            Description = "VIP: +15% Player & Class EXP.",
            LayoutOrder = 2,
            PlayerMult = 0.15,
            ClassMult = 0.15,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.VIP or "rbxassetid://0") or "rbxassetid://0",

            FormatDisplay = function() -- Line: 93, Name: FormatDisplay
                return "+15%";
            end,

            FormatDetail = function() -- Line: 94, Name: FormatDetail
                return "VIP Active";
            end
        },
        GrandSovereign = {
            Id = "GrandSovereign",
            Name = "Grand Sovereign Bonus",
            Description = "Grand Sovereign Pack: +20% Player & Class EXP.",
            LayoutOrder = 2,
            PlayerMult = 0.2,
            ClassMult = 0.2,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.VIP or "rbxassetid://0") or "rbxassetid://0",

            FormatDisplay = function() -- Line: 112, Name: FormatDisplay
                return "+20%";
            end,

            FormatDetail = function() -- Line: 113, Name: FormatDetail
                return "Grand Sovereign Active";
            end
        },
        DoublePlayerEXP = {
            Id = "DoublePlayerEXP",
            Name = "2x Player EXP",
            Description = "Gamepass: permanently doubles Player EXP from all sources.",
            LayoutOrder = 3,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.DoublePlayerEXP or "rbxassetid://0") or "rbxassetid://0",

            FormatDisplay = function() -- Line: 129, Name: FormatDisplay
                return "x2";
            end,

            FormatDetail = function() -- Line: 130, Name: FormatDetail
                return "2x Player EXP (permanent)";
            end
        },
        DoubleClassEXP = {
            Id = "DoubleClassEXP",
            Name = "2x Class EXP",
            Description = "Gamepass: permanently doubles Class EXP from all sources.",
            LayoutOrder = 4,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.DoubleClassEXP or "rbxassetid://0") or "rbxassetid://0",

            FormatDisplay = function() -- Line: 139, Name: FormatDisplay
                return "x2";
            end,

            FormatDetail = function() -- Line: 140, Name: FormatDetail
                return "2x Class EXP (permanent)";
            end
        },
        IncreasedLuck = {
            Id = "IncreasedLuck",
            Name = "Increased Luck",
            Description = "Gamepass: permanently boosts dungeon loot luck.",
            LayoutOrder = 5,
            Icon = Image_Data.BuffPotions and Image_Data.BuffPotions.LootLuckPotion or "rbxassetid://0",

            FormatDisplay = function() -- Line: 149, Name: FormatDisplay
                return "";
            end,

            FormatDetail = function() -- Line: 150, Name: FormatDetail
                return "Increased loot luck (permanent)";
            end
        }
    }
};

function u4.Get(p5: string) -- Line: 159
    -- upvalues: u4 (copy)
    return u4.Bonuses[p5];
end;

function u4.GetPlayerMultiplier(p6: table?) -- Line: 166
    -- upvalues: u4 (copy)
    if not p6 then
        return 0;
    end;

    local v7 = 0;
    local Friends = p6.Friends;

    if Friends and Friends.Count then
        local Friends2 = u4.Bonuses.Friends;
        v7 = v7 + math.min(Friends.Count, Friends2.MaxStacks) * Friends2.PlayerMultPerStack;
    end;

    local Premium = p6.Premium;

    if Premium and Premium.Active then
        v7 = v7 + u4.Bonuses.Premium.PlayerMult;
    end;

    local VIP = p6.VIP;

    if VIP and VIP.Active then
        v7 = v7 + u4.Bonuses.VIP.PlayerMult;
    end;

    local GrandSovereign = p6.GrandSovereign;

    if GrandSovereign and GrandSovereign.Active then
        v7 = v7 + u4.Bonuses.GrandSovereign.PlayerMult;
    end;

    return v7;
end;

function u4.GetClassMultiplier(p8: table?) -- Line: 196
    -- upvalues: u4 (copy)
    if not p8 then
        return 0;
    end;

    local v9 = 0;
    local Friends = p8.Friends;

    if Friends and Friends.Count then
        local Friends2 = u4.Bonuses.Friends;
        v9 = v9 + math.min(Friends.Count, Friends2.MaxStacks) * Friends2.ClassMultPerStack;
    end;

    local Premium = p8.Premium;

    if Premium and Premium.Active then
        v9 = v9 + u4.Bonuses.Premium.ClassMult;
    end;

    local VIP = p8.VIP;

    if VIP and VIP.Active then
        v9 = v9 + u4.Bonuses.VIP.ClassMult;
    end;

    local GrandSovereign = p8.GrandSovereign;

    if GrandSovereign and GrandSovereign.Active then
        v9 = v9 + u4.Bonuses.GrandSovereign.ClassMult;
    end;

    return v9;
end;

return u4;