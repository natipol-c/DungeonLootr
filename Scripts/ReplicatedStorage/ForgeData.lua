--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ForgeData
  Path:     game.ReplicatedStorage.GameInfo.ForgeData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = {
    MAX_FORGE_LEVEL = 20,
    MIN_FORGEABLE_TIER = 4,
    FORGE_PERCENT_STANDARD = 2.5,
    FORGE_PERCENT_HIGH = 5,
    SCALING_VERSION = 4,
    LEVEL_NAMES = {
        [16] = "PRI",
        [17] = "DUO",
        [18] = "TRI",
        [19] = "TET",
        [20] = "PEN"
    },
    SUCCESS_RATES = { 1, 1, 1, 0.95, 0.95, 0.9, 0.9, 0.85, 0.8, 0.75, 0.65, 0.55, 0.45, 0.35, 0.3, 0.3, 0.2, 0.1, 0.03, 0.01 },
    DOWNGRADE_CHANCES = {
        [11] = 0.05,
        [12] = 0.1,
        [13] = 0.2,
        [14] = 0.25,
        [15] = 0.3,
        [16] = 0.45,
        [17] = 0.65,
        [18] = 0.8,
        [19] = 0.95,
        [20] = 0.98
    },
    DOWNGRADE_LEVELS = 1,
    PRE_FORGE_ENABLED = true,
    PRE_FORGE_BASE_CHANCE = 0.03,
    PRE_FORGE_DECAY = 0.7,
    PRE_FORGE_MAX_LEVEL = 15,
    FORGE_AFFIX_POOLS = {
        Head = { "MaxHP", "CooldownReduction", "MovementSpeed", "ParryExtension", "DodgeCooldown", "DodgeRate", "PhysicalDamage", "RangedDamage", "MagicDamage" },
        Body = { "Defense", "DamageReduction", "MovementSpeed", "BlockMaxHealth", "DodgeRate", "PhysicalDamage", "RangedDamage", "MagicDamage" },
        Ring = { "BonusDamage", "CritRate", "CritDamage", "AttackSpeed", "AttackDamageBonus", "SkillDamageBonus", "ArmorShred", "LifeSteal", "SkillCritChance", "SkillCritDamage" }
    },
    MILESTONE_AFFIX_LEVELS = { 1, 5, 10, 15 },
    AFFIX_RARITY = {
        MaxHP = "Uncommon",
        Defense = "Uncommon",
        BlockMaxHealth = "Uncommon",
        MovementSpeed = "Rare",
        CooldownReduction = "Rare",
        ParryExtension = "Rare",
        DamageReduction = "Rare",
        CritRate = "Rare",
        CritDamage = "Rare",
        AttackSpeed = "Rare",
        DodgeCooldown = "Rare",
        DodgeRate = "Rare",
        PhysicalDamage = "Epic",
        RangedDamage = "Epic",
        MagicDamage = "Epic",
        SkillDamageBonus = "Epic",
        AttackDamageBonus = "Epic",
        ArmorShred = "Epic",
        SkillCritChance = "Epic",
        SkillCritDamage = "Legendary",
        BonusDamage = "Legendary",
        LifeSteal = "Legendary"
    }
};

function u4.GetAffixRarity(p5: string) -- Line: 223
    -- upvalues: u4 (copy)
    return u4.AFFIX_RARITY[p5] or "Common";
end;

u4.REFORGE_LOW_COST = 1;
u4.REFORGE_HIGH_COST = 2;
u4.REFORGE_HIGH_COST_LEVEL = 16;
u4.UPGRADE_MATERIAL_SUFFIX = " Ingot";
u4.MATERIAL_ID = "Forge Stone";
u4.REFORGE_MATERIAL_ID = "Reforge Stone";
u4.MATERIAL_COSTS = { 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 5, 5, 7, 7, 10 };
u4.BASE_COIN_COSTS = { 300, 400, 600, 900, 1400, 2200, 3800, 5500, 8500, 15000, 18000, 21000, 25000, 30000, 36000, 45000, 55000, 70000, 85000, 100000 };
u4.TIER_COIN_MULT = {
    [4] = 1.5,
    [5] = 2,
    [6] = 2.5,
    [7] = 3.5
};

local function EnsureLoaded() -- Line: 308
    -- upvalues: u1 (ref), ReplicatedStorage (copy), u2 (ref)
    if not u1 then
        u1 = require(ReplicatedStorage.GameInfo.EquipmentTemplates);
    end;

    if not u2 then
        u2 = require(ReplicatedStorage.GameInfo.DungeonData);
    end;
end;

function u4.GetDungeonTier(p6: string) -- Line: 319
    -- upvalues: u1 (ref), ReplicatedStorage (copy), u2 (ref), u4 (copy)
    if not u1 then
        u1 = require(ReplicatedStorage.GameInfo.EquipmentTemplates);
    end;

    if not u2 then
        u2 = require(ReplicatedStorage.GameInfo.DungeonData);
    end;

    local Template = u1.GetTemplate(p6);

    if not Template then
        return 0;
    end;

    local Dungeon = Template.Dungeon;

    if Dungeon and Dungeon ~= "Universal" then
        local Dungeon2 = u2.GetDungeon(Dungeon);

        if Dungeon2 and Dungeon2.Tier then
            return Dungeon2.Tier;
        end;
    end;

    return Template.EquipTier or u4.MIN_FORGEABLE_TIER;
end;

function u4.IsForgeable(p7: string) -- Line: 340
    return true;
end;

function u4.GetLevelName(p8: number) -- Line: 345
    -- upvalues: u4 (copy)
    return u4.LEVEL_NAMES[p8] or "+" .. tostring(p8);
end;

function u4.GetUpgradeMaterialId(p9: string?) -- Line: 352
    -- upvalues: u4 (copy)
    return (p9 or "Common") .. u4.UPGRADE_MATERIAL_SUFFIX;
end;

function u4.GetSuccessRate(p10: number) -- Line: 359
    -- upvalues: u4 (copy)
    return u4.SUCCESS_RATES[p10 + 1] or 0;
end;

function u4.GetDowngradeChance(p11: number) -- Line: 368
    -- upvalues: u4 (copy)
    return u4.DOWNGRADE_CHANCES[p11 + 1] or 0;
end;

u4.PURITY_SUCCESS_BONUS = { 0.02, 0.02, 0.02, 0.02, 0.02, 0.03, 0.03, 0.03, 0.03, 0.03, 0.04, 0.04, 0.04, 0.04, 0.04, 0.05, 0.05, 0.05, 0.05, 0.05 };
u4.PURITY_ITEM_ID = "Purity Stone";

function u4.GetPurityBonus(p12: number) -- Line: 393
    -- upvalues: u4 (copy)
    return u4.PURITY_SUCCESS_BONUS[p12 + 1] or 0;
end;

function u4.IsMilestoneLevel(p13: number) -- Line: 403
    -- upvalues: u4 (copy)
    for _, v in u4.MILESTONE_AFFIX_LEVELS do
        if v == p13 then
            return true;
        end;
    end;

    return false;
end;

function u4.GetCosts(p14: number, p15: number) -- Line: 416
    -- upvalues: u4 (copy)
    local v16 = p14 + 1;

    return u4.MATERIAL_COSTS[v16] or 1, math.floor((u4.BASE_COIN_COSTS[v16] or 100) * (u4.TIER_COIN_MULT[p15] or 1));
end;

local function TotalForgePercent(p17: number) -- Line: 426
    -- upvalues: u4 (copy)
    local math_min_ret = math.min(p17, 15);
    local math_max_ret = math.max(p17 - 15, 0);

    return math_min_ret * u4.FORGE_PERCENT_STANDARD + math_max_ret * u4.FORGE_PERCENT_HIGH;
end;

function u4.GetForgeBonusPerLevel(p18: number, p19: number) -- Line: 437
    -- upvalues: u4 (copy)
    return p18 * ((p19 > 15 and u4.FORGE_PERCENT_HIGH or u4.FORGE_PERCENT_STANDARD) / 100);
end;

function u4.ComputeForgeBonuses(p20: any, p21: number) -- Line: 450
    -- upvalues: u4 (copy), u3 (ref), ReplicatedStorage (copy)
    if p21 <= 0 then
        return {};
    end;

    local u22 = {};
    local math_min_ret = math.min(p21, 15);
    local math_max_ret = math.max(p21 - 15, 0);
    local u23 = (math_min_ret * u4.FORGE_PERCENT_STANDARD + math_max_ret * u4.FORGE_PERCENT_HIGH) / 100;
    u3 = u3 or require(ReplicatedStorage.GameInfo.EquipmentData);
    local Slot = p20.Slot;

    local function addBonus(p24: string, p25: number?) -- Line: 461
        -- upvalues: u23 (copy), Slot (copy), u3 (ref), u22 (copy)
        if not p25 or p25 == 0 then
            return;
        end;

        local v26 = math.floor(p25 * u23 * 100 + 0.5) / 100;
        local v27 = Slot and u3.GetForgeCap(Slot, p24);

        if v27 then
            if v27 >= 0 then
                local math_max_ret2 = math.max(0, v27 - p25);
                v26 = math.min(v26, math_max_ret2);
            else
                local math_min_ret2 = math.min(0, v27 - p25);
                v26 = math.max(v26, math_min_ret2);
            end;
        end;

        if v26 ~= 0 then
            u22[p24] = v26;
        end;
    end;

    if p20.BaseDamage then
        addBonus("BaseDamage", p20.BaseDamage);
    end;

    if p20.GuaranteedStat and p20.GuaranteedStat.StatKey then
        addBonus(p20.GuaranteedStat.StatKey, p20.GuaranteedStat.Value);
    end;

    if p20.Stats then
        for i, v in p20.Stats do
            addBonus(i, v);
        end;
    end;

    return u22;
end;

function u4.RollPreForgeLevel(p28: userdata?) -- Line: 508
    -- upvalues: u4 (copy)
    if not u4.PRE_FORGE_ENABLED then
        return 0;
    end;

    local v29 = p28 and p28:NextNumber() or math.random();
    local PRE_FORGE_BASE_CHANCE = u4.PRE_FORGE_BASE_CHANCE;
    local v30 = 0;

    for i = 1, u4.PRE_FORGE_MAX_LEVEL do
        v30 = v30 + PRE_FORGE_BASE_CHANCE;

        if v29 < v30 then
            return i;
        end;

        PRE_FORGE_BASE_CHANCE = PRE_FORGE_BASE_CHANCE * u4.PRE_FORGE_DECAY;
        local _ = i;
    end;

    return 0;
end;

function u4.GetReforgeCost(p31: number) -- Line: 527
    -- upvalues: u4 (copy)
    if math.clamp(p31 or 0, 0, u4.MAX_FORGE_LEVEL) >= u4.REFORGE_HIGH_COST_LEVEL then
        return u4.REFORGE_HIGH_COST;
    end;

    return u4.REFORGE_LOW_COST;
end;

function u4.GetProjectedBonuses(p32: any, p33: number) -- Line: 539
    -- upvalues: u4 (copy)
    return u4.ComputeForgeBonuses(p32, p33 + 1);
end;

return u4;