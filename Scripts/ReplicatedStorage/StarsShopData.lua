--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     StarsShopData
  Path:     game.ReplicatedStorage.GameInfo.StarsShopData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    ROTATION_INTERVAL = 3600,
    EMOTE_SLOTS = 9,
    COSMETIC_SLOTS = 9,
    RarityToTier = {
        Common = 1,
        Uncommon = 1,
        Rare = 1,
        Epic = 1,
        Legendary = 2,
        Mythic = 2,
        Celestial = 3,
        Exotic = 4
    }
};

function u1.GetRobuxProductKey(p2: string, p3: string) -- Line: 52
    -- upvalues: u1 (copy)
    local v4 = u1.RarityToTier[p3];

    if v4 then
        return `{p2}_Tier{v4}`;
    end;

    return nil;
end;

u1.EmoteStarsCost = {
    Common = 50,
    Uncommon = 75,
    Rare = 120,
    Epic = 200,
    Legendary = 2000,
    Mythic = 2500,
    Celestial = 3000,
    Exotic = 3500
};

return u1;