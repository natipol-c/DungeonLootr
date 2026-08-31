--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PotionData
  Path:     game.ReplicatedStorage.GameInfo.PotionData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local Image_Data = require(script.Parent:WaitForChild("Image_Data"));
local u1 = {
    DEFAULT_MAX_STACK = 10,
    Types = {
        Flat = "Flat",
        Percent = "Percent",
        HoT = "HoT",
        DualPurpose = "DualPurpose",
        ClassXP = "ClassXP"
    },
    BuffStats = { "DamagePercent", "AttackSpeed", "MaxHealth", "WalkSpeed" },
    Potions = {
        {
            Id = "SmallHealFlat",
            Name = "Minor Healing Potion",
            Type = "Flat",
            HealAmount = 15,
            Cooldown = 8,
            Cost = 1000,
            RequiredRebirth = 0,
            Description = "Restores 15 HP instantly.",
            LayoutOrder = 1,
            Icon = Image_Data.Potions.SmallHealFlat
        },
        {
            Id = "MediumHealFlat",
            Name = "Healing Potion",
            Type = "Flat",
            HealAmount = 30,
            Cooldown = 12,
            Cost = 5000,
            RequiredRebirth = 0,
            Description = "Restores 30 HP instantly.",
            LayoutOrder = 2,
            Icon = Image_Data.Potions.MediumHealFlat
        },
        {
            Id = "LargeHealFlat",
            Name = "Greater Healing Potion",
            Type = "Flat",
            HealAmount = 75,
            Cooldown = 15,
            Cost = 25000,
            RequiredRebirth = 1,
            Description = "Restores 75 HP instantly.",
            LayoutOrder = 3,
            Icon = Image_Data.Potions.LargeHealFlat
        },
        {
            Id = "SmallHealPercent",
            Name = "Rejuvenation Tonic",
            Type = "Percent",
            HealPercent = 0.4,
            Cooldown = 7,
            Cost = 900000,
            RequiredRebirth = 0,
            Description = "Restores 40% of your Max HP.",
            LayoutOrder = 10,
            Icon = Image_Data.Potions.PrimaryHealthPotion
        },
        {
            Id = "MediumHealPercent",
            Name = "Rejuvenation Elixir",
            Type = "Percent",
            HealPercent = 0.4,
            Cooldown = 20,
            Cost = 5000000,
            RequiredRebirth = 1,
            Description = "Restores 40% of your Max HP.",
            LayoutOrder = 11,
            Icon = Image_Data.Potions.MediumHealPercent
        },
        {
            Id = "LargeHealPercent",
            Name = "Supreme Elixir",
            Type = "Percent",
            HealPercent = 0.7,
            Cooldown = 30,
            Cost = 20000000,
            RequiredRebirth = 2,
            Description = "Restores 70% of your Max HP.",
            LayoutOrder = 12,
            Icon = Image_Data.Potions.LargeHealPercent
        },
        {
            Id = "SmallRegen",
            Name = "Potion of Regeneration",
            Type = "HoT",
            HealPerTick = 5,
            TickRate = 1,
            Duration = 10,
            Cooldown = 25,
            Cost = 6000,
            RequiredRebirth = 0,
            Description = "Restores 5 HP every second for 10s (50 HP total).",
            Icon = "rbxassetid://0",
            LayoutOrder = 20
        },
        {
            Id = "MediumRegen",
            Name = "Greater Regeneration",
            Type = "HoT",
            HealPerTick = 12,
            TickRate = 1,
            Duration = 12,
            Cooldown = 30,
            Cost = 20000,
            RequiredRebirth = 1,
            Description = "Restores 12 HP every second for 12s (144 HP total).",
            Icon = "rbxassetid://0",
            LayoutOrder = 21
        },
        {
            Id = "LargeRegen",
            Name = "Elixir of Vitality",
            Type = "HoT",
            HealPerTick = 25,
            TickRate = 1,
            Duration = 15,
            Cooldown = 40,
            Cost = 75000,
            RequiredRebirth = 2,
            Description = "Restores 25 HP every second for 15s (375 HP total).",
            Icon = "rbxassetid://0",
            LayoutOrder = 22
        },
        {
            Id = "WarriorsElixir",
            Name = "Warrior\'s Elixir",
            Type = "DualPurpose",
            HealAmount = 30,
            BuffStat = "DamagePercent",
            BuffAmount = 0.1,
            BuffDuration = 15,
            Cooldown = 0,
            Cost = 50000,
            RequiredRebirth = 1,
            Description = "Restores 30 HP and boosts Damage by 10% for 15s.",
            Icon = "rbxassetid://0",
            LayoutOrder = 30,
            InstantUse = true
        },
        {
            Id = "SwiftElixir",
            Name = "Swift Elixir",
            Type = "DualPurpose",
            HealAmount = 20,
            BuffStat = "AttackSpeed",
            BuffAmount = 0.15,
            BuffDuration = 12,
            Cooldown = 0,
            Cost = 40000,
            RequiredRebirth = 1,
            Description = "Restores 20 HP and boosts Attack Speed by 15% for 12s.",
            Icon = "rbxassetid://0",
            LayoutOrder = 31,
            InstantUse = true
        },
        {
            Id = "FortifyingDraught",
            Name = "Fortifying Draught",
            Type = "DualPurpose",
            HealAmount = 40,
            BuffStat = "MaxHealth",
            BuffAmount = 50,
            BuffDuration = 20,
            Cooldown = 0,
            Cost = 60000,
            RequiredRebirth = 2,
            Description = "Restores 40 HP and boosts Max Health by 50 for 20s.",
            Icon = "rbxassetid://0",
            LayoutOrder = 32,
            InstantUse = true
        },
        {
            Id = "MysteryElixir",
            Name = "Mystery Elixir",
            Type = "DualPurpose",
            HealAmount = 35,
            BuffStat = "Random",
            BuffAmount = 0.12,
            BuffDuration = 15,
            Cooldown = 0,
            Cost = 35000,
            RequiredRebirth = 1,
            Description = "Restores 35 HP and boosts a random stat for 15s.",
            Icon = "rbxassetid://0",
            LayoutOrder = 33,
            InstantUse = true
        },
        {
            Id = "ClassXPEssence",
            Name = "Class XP Essence",
            Type = "ClassXP",
            ClassXPAmount = 100,
            Cooldown = 0,
            Cost = 0,
            RequiredRebirth = 0,
            Description = "Grants 100 Class XP to your active class instantly.",
            LayoutOrder = 40,
            MaxStack = 9999,
            HideFromShop = true,
            InstantUse = true,
            Icon = Image_Data.Potions.ClassXPEssence
        }
    },
    RandomBuffOverrides = {
        DamagePercent = 0.12,
        AttackSpeed = 0.15,
        MaxHealth = 40,
        WalkSpeed = 6
    },
    Index = {}
};

for _, v in ipairs(u1.Potions) do
    u1.Index[v.Id] = v;
end;

function u1.GetPotion(p2: string) -- Line: 306
    -- upvalues: u1 (copy)
    return u1.Index[p2];
end;

function u1.GetAvailablePotions(p3: number) -- Line: 311
    -- upvalues: u1 (copy)
    local v4 = {};

    for _, v in ipairs(u1.Potions) do
        if v.RequiredRebirth <= p3 then
            table.insert(v4, v);
        end;
    end;

    return v4;
end;

function u1.GetAllIds() -- Line: 322
    -- upvalues: u1 (copy)
    local v5 = {};

    for _, v in ipairs(u1.Potions) do
        table.insert(v5, v.Id);
    end;

    return v5;
end;

function u1.GetMaxStack(p6: string) -- Line: 331
    -- upvalues: u1 (copy)
    local v7 = u1.Index[p6];

    if v7 and v7.MaxStack then
        return v7.MaxStack;
    end;

    return u1.DEFAULT_MAX_STACK;
end;

return u1;