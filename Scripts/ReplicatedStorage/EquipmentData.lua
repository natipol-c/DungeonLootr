--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EquipmentData
  Path:     game.ReplicatedStorage.GameInfo.EquipmentData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    RarityRules = {
        Common = {
            MinLines = 1,
            MaxLines = 1
        },
        Uncommon = {
            MinLines = 1,
            MaxLines = 1
        },
        Rare = {
            MinLines = 1,
            MaxLines = 2
        },
        Epic = {
            MinLines = 1,
            MaxLines = 2
        },
        Legendary = {
            MinLines = 2,
            MaxLines = 3
        },
        Mythic = {
            MinLines = 3,
            MaxLines = 3
        },
        Celestial = {
            MinLines = 3,
            MaxLines = 3
        },
        Exotic = {
            MinLines = 3,
            MaxLines = 3
        }
    },
    MAX_AFFIX_LINES = 4,
    EnchantCaps = {
        Common = 10,
        Uncommon = 10,
        Rare = 15,
        Epic = 20,
        Legendary = 25,
        Mythic = 25,
        Celestial = 30,
        Exotic = 35
    },
    SoulBaseDamageRange = {
        Common = {
            Min = 5,
            Max = 10
        },
        Uncommon = {
            Min = 10,
            Max = 18
        },
        Rare = {
            Min = 18,
            Max = 30
        },
        Epic = {
            Min = 30,
            Max = 50
        },
        Legendary = {
            Min = 50,
            Max = 80
        },
        Mythic = {
            Min = 80.5,
            Max = 115
        },
        Celestial = {
            Min = 130,
            Max = 195
        },
        Exotic = {
            Min = 170,
            Max = 255
        }
    },
    LEVEL_SCALE_FACTOR = 0.04,
    ROLL_POWER = 1.8,
    DEFENSE_K = 100,
    DR_HARD_CAP = 75
};

function u1.ComputeDefenseDR(p2: number) -- Line: 94
    -- upvalues: u1 (copy)
    return (not p2 or p2 <= 0) and 0 or p2 / (p2 + u1.DEFENSE_K) * 100;
end;

function u1.ComputeDamageMultiplier(p3: number, p4: number) -- Line: 102
    -- upvalues: u1 (copy)
    local v5 = u1.DEFENSE_K / (u1.DEFENSE_K + math.max(p3 or 0, 0)) * (1 - math.clamp(p4 or 0, 0, 100) / 100);

    return math.max(v5, 1 - u1.DR_HARD_CAP / 100);
end;

u1.STAT_CAPS = {
    Head = {
        MaxHP = 500,
        CooldownReduction = 25,
        DodgeCooldown = -1.5,
        ParryExtension = 0.5,
        MovementSpeed = 20,
        DodgeRate = 10,
        PhysicalDamage = 20,
        RangedDamage = 20,
        MagicDamage = 20
    },
    Body = {
        MovementSpeed = 20,
        DamageReduction = 35,
        BlockRate = 15,
        BlockMaxHealth = 150,
        DodgeRate = 10,
        Defense = 100,
        PhysicalDamage = 20,
        RangedDamage = 20,
        MagicDamage = 20
    },
    Ring = {
        CritRate = 25,
        CritDamage = 50,
        AttackSpeed = 15,
        BonusDamage = 30,
        AttackDamageBonus = 15,
        SkillDamageBonus = 15,
        ArmorShred = 40,
        LifeSteal = 1,
        SkillCritChance = 20,
        SkillCritDamage = 60
    }
};

function u1.ClampToCap(p6: string, p7: number, p8: string) -- Line: 159
    -- upvalues: u1 (copy)
    local v9 = u1.STAT_CAPS[p8];

    if not v9 then
        return p7;
    end;

    local v10 = v9[p6];

    if not v10 then
        return p7;
    end;

    if v10 < 0 then
        return math.max(p7, v10);
    end;

    return math.min(p7, v10);
end;

u1.FORGE_CAP_MULT = 1.5;
u1.FORGE_CAP_ABSOLUTE = {
    LifeSteal = 1.5
};

function u1.GetForgeCap(p11: string, p12: string) -- Line: 204
    -- upvalues: u1 (copy)
    local v13 = u1.FORGE_CAP_ABSOLUTE[p12];

    if v13 then
        return v13;
    end;

    local v14 = u1.STAT_CAPS[p11];

    if not v14 then
        return nil;
    end;

    local v15 = v14[p12];

    if v15 then
        return v15 * u1.FORGE_CAP_MULT;
    end;

    return nil;
end;

u1.DIFFICULTY_LEVEL_WINDOWS = {
    Easy = { 0, 0.4 },
    Normal = { 0.2, 0.65 },
    Hard = { 0.4, 0.85 },
    Nightmare = { 0.55, 0.95 },
    Endless = { 0.55, 1 }
};
u1.GuaranteedBase = {
    Body = { {
            StatKey = "MaxHP",
            Ranges = {
                Common = {
                    Min = 20,
                    Max = 35
                },
                Uncommon = {
                    Min = 30,
                    Max = 50
                },
                Rare = {
                    Min = 40,
                    Max = 70
                },
                Epic = {
                    Min = 55,
                    Max = 95
                },
                Legendary = {
                    Min = 75,
                    Max = 130
                },
                Mythic = {
                    Min = 115,
                    Max = 184
                },
                Celestial = {
                    Min = 182,
                    Max = 286
                },
                Exotic = {
                    Min = 237,
                    Max = 372
                }
            }
        } },
    Head = { {
            StatKey = "Defense",
            Ranges = {
                Common = {
                    Min = 4,
                    Max = 7
                },
                Uncommon = {
                    Min = 6,
                    Max = 10
                },
                Rare = {
                    Min = 9,
                    Max = 15
                },
                Epic = {
                    Min = 13,
                    Max = 21
                },
                Legendary = {
                    Min = 18,
                    Max = 28
                },
                Mythic = {
                    Min = 26,
                    Max = 40
                },
                Celestial = {
                    Min = 33,
                    Max = 50
                },
                Exotic = {
                    Min = 43,
                    Max = 65
                }
            }
        } }
};
local v16 = {
    Common = {
        Min = 2,
        Max = 3
    },
    Uncommon = {
        Min = 2,
        Max = 4
    },
    Rare = {
        Min = 3,
        Max = 5
    },
    Epic = {
        Min = 4,
        Max = 7
    },
    Legendary = {
        Min = 5,
        Max = 9
    },
    Mythic = {
        Min = 6,
        Max = 10
    },
    Celestial = {
        Min = 8,
        Max = 13
    },
    Exotic = {
        Min = 10,
        Max = 16
    }
};
u1.StatPools = {
    Head = {
        MaxHP = {
            Type = "flat",
            Ranges = {
                Common = {
                    Min = 15,
                    Max = 25
                },
                Uncommon = {
                    Min = 20,
                    Max = 35
                },
                Rare = {
                    Min = 25,
                    Max = 50
                },
                Epic = {
                    Min = 35,
                    Max = 65
                },
                Legendary = {
                    Min = 50,
                    Max = 80
                },
                Mythic = {
                    Min = 69,
                    Max = 115
                },
                Celestial = {
                    Min = 110.5,
                    Max = 175.5
                },
                Exotic = {
                    Min = 143.5,
                    Max = 228
                }
            }
        },
        DodgeCooldown = {
            Type = "flat",
            Ranges = {
                Common = {
                    Min = -0.1,
                    Max = -0.05
                },
                Uncommon = {
                    Min = -0.15,
                    Max = -0.08
                },
                Rare = {
                    Min = -0.2,
                    Max = -0.1
                },
                Epic = {
                    Min = -0.3,
                    Max = -0.15
                },
                Legendary = {
                    Min = -0.4,
                    Max = -0.2
                },
                Mythic = {
                    Min = -0.575,
                    Max = -0.345
                },
                Celestial = {
                    Min = -0.845,
                    Max = -0.52
                },
                Exotic = {
                    Min = -1.1,
                    Max = -0.676
                }
            }
        },
        ParryExtension = {
            Type = "flat",
            Ranges = {
                Common = {
                    Min = 0.02,
                    Max = 0.03
                },
                Uncommon = {
                    Min = 0.02,
                    Max = 0.04
                },
                Rare = {
                    Min = 0.03,
                    Max = 0.06
                },
                Epic = {
                    Min = 0.04,
                    Max = 0.07
                },
                Legendary = {
                    Min = 0.05,
                    Max = 0.08
                },
                Mythic = {
                    Min = 0.08,
                    Max = 0.115
                },
                Celestial = {
                    Min = 0.117,
                    Max = 0.169
                },
                Exotic = {
                    Min = 0.152,
                    Max = 0.22
                }
            }
        },
        MovementSpeed = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 1,
                    Max = 2
                },
                Uncommon = {
                    Min = 1,
                    Max = 3
                },
                Rare = {
                    Min = 2,
                    Max = 4
                },
                Epic = {
                    Min = 2,
                    Max = 5
                },
                Legendary = {
                    Min = 3,
                    Max = 5
                },
                Mythic = {
                    Min = 3.45,
                    Max = 5.75
                },
                Celestial = {
                    Min = 5.2,
                    Max = 7.8
                },
                Exotic = {
                    Min = 6.76,
                    Max = 10.14
                }
            }
        },
        CooldownReduction = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 1,
                    Max = 2
                },
                Uncommon = {
                    Min = 1,
                    Max = 3
                },
                Rare = {
                    Min = 2,
                    Max = 4
                },
                Epic = {
                    Min = 3,
                    Max = 6
                },
                Legendary = {
                    Min = 4,
                    Max = 7
                },
                Mythic = {
                    Min = 4.6,
                    Max = 6.9
                },
                Celestial = {
                    Min = 6.5,
                    Max = 10.4
                },
                Exotic = {
                    Min = 8.45,
                    Max = 13.52
                }
            }
        },
        DodgeRate = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 1,
                    Max = 2
                },
                Uncommon = {
                    Min = 1,
                    Max = 3
                },
                Rare = {
                    Min = 2,
                    Max = 4
                },
                Epic = {
                    Min = 2,
                    Max = 5
                },
                Legendary = {
                    Min = 3,
                    Max = 6
                },
                Mythic = {
                    Min = 3.45,
                    Max = 6.9
                },
                Celestial = {
                    Min = 5.2,
                    Max = 8
                },
                Exotic = {
                    Min = 6.76,
                    Max = 10
                }
            }
        },
        PhysicalDamage = {
            Type = "percent",
            Ranges = v16
        },
        RangedDamage = {
            Type = "percent",
            Ranges = v16
        },
        MagicDamage = {
            Type = "percent",
            Ranges = v16
        }
    },
    Body = {
        Defense = {
            Type = "flat",
            Ranges = {
                Common = {
                    Min = 2,
                    Max = 4
                },
                Uncommon = {
                    Min = 3,
                    Max = 6
                },
                Rare = {
                    Min = 5,
                    Max = 9
                },
                Epic = {
                    Min = 7,
                    Max = 12
                },
                Legendary = {
                    Min = 10,
                    Max = 16
                },
                Mythic = {
                    Min = 13,
                    Max = 20
                },
                Celestial = {
                    Min = 18,
                    Max = 28
                },
                Exotic = {
                    Min = 23,
                    Max = 36
                }
            }
        },
        DamageReduction = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 2,
                    Max = 3
                },
                Uncommon = {
                    Min = 2,
                    Max = 4
                },
                Rare = {
                    Min = 3,
                    Max = 6
                },
                Epic = {
                    Min = 4,
                    Max = 8
                },
                Legendary = {
                    Min = 6,
                    Max = 10
                },
                Mythic = {
                    Min = 6.9,
                    Max = 10.35
                },
                Celestial = {
                    Min = 10.4,
                    Max = 15.6
                },
                Exotic = {
                    Min = 13.52,
                    Max = 20.28
                }
            }
        },
        PhysicalDamage = {
            Type = "percent",
            Ranges = v16
        },
        RangedDamage = {
            Type = "percent",
            Ranges = v16
        },
        MagicDamage = {
            Type = "percent",
            Ranges = v16
        },
        BlockRate = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 1,
                    Max = 2
                },
                Uncommon = {
                    Min = 1,
                    Max = 3
                },
                Rare = {
                    Min = 2,
                    Max = 4
                },
                Epic = {
                    Min = 3,
                    Max = 6
                },
                Legendary = {
                    Min = 4,
                    Max = 7
                },
                Mythic = {
                    Min = 4.6,
                    Max = 6.9
                },
                Celestial = {
                    Min = 6.5,
                    Max = 10.4
                },
                Exotic = {
                    Min = 8.45,
                    Max = 13.52
                }
            }
        },
        MovementSpeed = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 1,
                    Max = 2
                },
                Uncommon = {
                    Min = 1,
                    Max = 3
                },
                Rare = {
                    Min = 1,
                    Max = 4
                },
                Epic = {
                    Min = 2,
                    Max = 5
                },
                Legendary = {
                    Min = 2,
                    Max = 5
                },
                Mythic = {
                    Min = 3.45,
                    Max = 5.75
                },
                Celestial = {
                    Min = 5.2,
                    Max = 7.8
                },
                Exotic = {
                    Min = 6.76,
                    Max = 10.14
                }
            }
        },
        BlockMaxHealth = {
            Type = "flat",
            Ranges = {
                Common = {
                    Min = 8,
                    Max = 15
                },
                Uncommon = {
                    Min = 12,
                    Max = 22
                },
                Rare = {
                    Min = 18,
                    Max = 32
                },
                Epic = {
                    Min = 25,
                    Max = 45
                },
                Legendary = {
                    Min = 35,
                    Max = 60
                },
                Mythic = {
                    Min = 48,
                    Max = 78
                },
                Celestial = {
                    Min = 65,
                    Max = 105
                },
                Exotic = {
                    Min = 85,
                    Max = 135
                }
            }
        },
        DodgeRate = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 1,
                    Max = 2
                },
                Uncommon = {
                    Min = 1,
                    Max = 3
                },
                Rare = {
                    Min = 2,
                    Max = 4
                },
                Epic = {
                    Min = 2,
                    Max = 5
                },
                Legendary = {
                    Min = 3,
                    Max = 6
                },
                Mythic = {
                    Min = 3.45,
                    Max = 6.9
                },
                Celestial = {
                    Min = 5.2,
                    Max = 8
                },
                Exotic = {
                    Min = 6.76,
                    Max = 10
                }
            }
        }
    },
    Ring = {
        BonusDamage = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 2,
                    Max = 4
                },
                Uncommon = {
                    Min = 3,
                    Max = 6
                },
                Rare = {
                    Min = 4,
                    Max = 8
                },
                Epic = {
                    Min = 6,
                    Max = 10
                },
                Legendary = {
                    Min = 8,
                    Max = 13
                },
                Mythic = {
                    Min = 10,
                    Max = 16
                },
                Celestial = {
                    Min = 14,
                    Max = 22
                },
                Exotic = {
                    Min = 18,
                    Max = 29
                }
            }
        },
        CritRate = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 1,
                    Max = 2
                },
                Uncommon = {
                    Min = 1,
                    Max = 3
                },
                Rare = {
                    Min = 2,
                    Max = 5
                },
                Epic = {
                    Min = 3,
                    Max = 7
                },
                Legendary = {
                    Min = 5,
                    Max = 8
                },
                Mythic = {
                    Min = 4.6,
                    Max = 8.05
                },
                Celestial = {
                    Min = 6.5,
                    Max = 10.4
                },
                Exotic = {
                    Min = 8.45,
                    Max = 13.52
                }
            }
        },
        CritDamage = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 3,
                    Max = 5
                },
                Uncommon = {
                    Min = 3,
                    Max = 7
                },
                Rare = {
                    Min = 5,
                    Max = 12
                },
                Epic = {
                    Min = 8,
                    Max = 16
                },
                Legendary = {
                    Min = 12,
                    Max = 20
                },
                Mythic = {
                    Min = 11.5,
                    Max = 18.4
                },
                Celestial = {
                    Min = 18.2,
                    Max = 26
                },
                Exotic = {
                    Min = 23.66,
                    Max = 33.8
                }
            }
        },
        AttackSpeed = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 1,
                    Max = 2
                },
                Uncommon = {
                    Min = 1,
                    Max = 3
                },
                Rare = {
                    Min = 2,
                    Max = 4
                },
                Epic = {
                    Min = 3,
                    Max = 6
                },
                Legendary = {
                    Min = 4,
                    Max = 7
                },
                Mythic = {
                    Min = 3.45,
                    Max = 5.75
                },
                Celestial = {
                    Min = 5.2,
                    Max = 9.1
                },
                Exotic = {
                    Min = 6.76,
                    Max = 11.83
                }
            }
        },
        SkillDamageBonus = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 1,
                    Max = 2
                },
                Uncommon = {
                    Min = 1,
                    Max = 3
                },
                Rare = {
                    Min = 2,
                    Max = 4
                },
                Epic = {
                    Min = 3,
                    Max = 6
                },
                Legendary = {
                    Min = 4,
                    Max = 7
                },
                Mythic = {
                    Min = 3.45,
                    Max = 5.75
                },
                Celestial = {
                    Min = 5.2,
                    Max = 9.1
                },
                Exotic = {
                    Min = 6.76,
                    Max = 11.83
                }
            }
        },
        ArmorShred = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 3,
                    Max = 5
                },
                Uncommon = {
                    Min = 3,
                    Max = 7
                },
                Rare = {
                    Min = 5,
                    Max = 12
                },
                Epic = {
                    Min = 8,
                    Max = 16
                },
                Legendary = {
                    Min = 12,
                    Max = 20
                },
                Mythic = {
                    Min = 11.5,
                    Max = 18.4
                },
                Celestial = {
                    Min = 18.2,
                    Max = 26
                },
                Exotic = {
                    Min = 23.66,
                    Max = 33.8
                }
            }
        },
        SkillCritChance = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 1,
                    Max = 2
                },
                Uncommon = {
                    Min = 1,
                    Max = 3
                },
                Rare = {
                    Min = 2,
                    Max = 5
                },
                Epic = {
                    Min = 3,
                    Max = 7
                },
                Legendary = {
                    Min = 5,
                    Max = 8
                },
                Mythic = {
                    Min = 4.6,
                    Max = 8.05
                },
                Celestial = {
                    Min = 6.5,
                    Max = 10.4
                },
                Exotic = {
                    Min = 8.45,
                    Max = 13.52
                }
            }
        },
        SkillCritDamage = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 3,
                    Max = 5
                },
                Uncommon = {
                    Min = 3,
                    Max = 7
                },
                Rare = {
                    Min = 5,
                    Max = 12
                },
                Epic = {
                    Min = 8,
                    Max = 16
                },
                Legendary = {
                    Min = 12,
                    Max = 20
                },
                Mythic = {
                    Min = 11.5,
                    Max = 18.4
                },
                Celestial = {
                    Min = 18.2,
                    Max = 26
                },
                Exotic = {
                    Min = 23.66,
                    Max = 33.8
                }
            }
        },
        AttackDamageBonus = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 1,
                    Max = 2
                },
                Uncommon = {
                    Min = 1,
                    Max = 3
                },
                Rare = {
                    Min = 2,
                    Max = 4
                },
                Epic = {
                    Min = 3,
                    Max = 6
                },
                Legendary = {
                    Min = 4,
                    Max = 7
                },
                Mythic = {
                    Min = 3.45,
                    Max = 5.75
                },
                Celestial = {
                    Min = 5.2,
                    Max = 9.1
                },
                Exotic = {
                    Min = 6.76,
                    Max = 11.83
                }
            }
        },
        LifeSteal = {
            Type = "percent",
            Ranges = {
                Common = {
                    Min = 0.075,
                    Max = 0.1
                },
                Uncommon = {
                    Min = 0.075,
                    Max = 0.15
                },
                Rare = {
                    Min = 0.1,
                    Max = 0.25
                },
                Epic = {
                    Min = 0.15,
                    Max = 0.4
                },
                Legendary = {
                    Min = 0.2,
                    Max = 0.55
                },
                Mythic = {
                    Min = 0.3,
                    Max = 0.7
                },
                Celestial = {
                    Min = 0.45,
                    Max = 0.85
                },
                Exotic = {
                    Min = 0.6,
                    Max = 1
                }
            }
        }
    }
};
u1.GeneratableBonusStats = {
    Head = {},
    Body = {},
    Ring = {}
};
u1.GenerationAffixChances = {
    Mythic = { 0.4 },
    Celestial = { 0.7 },
    Exotic = { 1 }
};

function u1.GetGenerationAffixChances(p17: string) -- Line: 715
    -- upvalues: u1 (copy)
    return u1.GenerationAffixChances[p17];
end;

u1.DungeonThemes = {
    DEX = {
        DisplayName = "Dexterity",
        FavorWeight = 3,
        FavoredStats = {
            Head = { "DodgeCooldown", "MovementSpeed", "CooldownReduction" },
            Body = { "MovementSpeed" }
        }
    },
    STR = {
        DisplayName = "Strength",
        FavorWeight = 3,
        FavoredStats = {
            Head = { "MaxHP", "ParryExtension" },
            Body = { "DamageReduction", "BlockRate" }
        }
    },
    VIT = {
        DisplayName = "Vitality",
        FavorWeight = 3,
        FavoredStats = {
            Head = { "MaxHP" },
            Body = { "DamageReduction", "BlockRate" }
        }
    },
    INT = {
        DisplayName = "Intelligence",
        FavorWeight = 3,
        FavoredStats = {
            Head = { "CooldownReduction" },
            Body = { "DamageReduction" }
        }
    }
};

function u1.GetFavoredStats(p18: string?, p19: string) -- Line: 763
    -- upvalues: u1 (copy)
    if not p18 then
        return nil;
    end;

    local v20 = u1.DungeonThemes[p18];

    if v20 and v20.FavoredStats then
        return v20.FavoredStats[p19];
    end;

    return nil;
end;

function u1.GetFavorWeight(p21: string?) -- Line: 771
    -- upvalues: u1 (copy)
    if not p21 then
        return 1;
    end;

    local v22 = u1.DungeonThemes[p21];

    return v22 and v22.FavorWeight or 1;
end;

function u1.GetStatKeysForSlot(p23: string) -- Line: 782
    -- upvalues: u1 (copy)
    local v24 = u1.StatPools[p23];

    if not v24 then
        return {};
    end;

    local v25 = {};

    for i in v24 do
        table.insert(v25, i);
    end;

    return v25;
end;

function u1.GetGeneratableBonusStatKeys(p26: string) -- Line: 796
    -- upvalues: u1 (copy)
    local v27 = u1.GeneratableBonusStats[p26];

    if not v27 then
        return {};
    end;

    local v28 = {};

    for _, v in v27 do
        table.insert(v28, v);
    end;

    return v28;
end;

function u1.GetRange(p29: string, p30: string, p31: string) -- Line: 807
    -- upvalues: u1 (copy)
    local v32 = u1.StatPools[p29];

    if v32 and v32[p30] then
        return v32[p30].Ranges[p31];
    end;

    return nil;
end;

u1.GearScoreRarityBase = {
    Common = 40,
    Uncommon = 90,
    Rare = 160,
    Epic = 280,
    Legendary = 440,
    Mythic = 650,
    Celestial = 900,
    Exotic = 1200
};
u1.GEAR_SCORE_LEVEL_MULT = 8;
u1.GEAR_SCORE_STAT_WEIGHT = 25;

local function ComputeGearScoreInternal(p33: any, u34: table?) -- Line: 839
    -- upvalues: u1 (copy)
    if type(p33) ~= "table" then
        return 0;
    end;

    if p33.Identified == false then
        return 0;
    end;

    local v35 = p33.Rarity or "Common";
    local v36 = p33.LevelReq or 1;
    local v37 = p33.Slot or "";
    local v38 = (u1.GearScoreRarityBase[v35] or 40) + v36 * u1.GEAR_SCORE_LEVEL_MULT;
    local GEAR_SCORE_STAT_WEIGHT = u1.GEAR_SCORE_STAT_WEIGHT;
    local u39 = 1 + (v36 - 1) * u1.LEVEL_SCALE_FACTOR;
    local u40 = u34 ~= nil;

    local function NormalizeRoll(p41: number, p42: number, p43: number, p44: string) -- Line: 860
        -- upvalues: u39 (copy), u1 (ref), u40 (copy)
        local v45 = p42 * u39;
        local v46 = p43 * u39;

        if v45 == v46 then
            return 1;
        end;

        local v47;

        if u1.InvertedStats[p44] then
            v47 = (v46 - p41) / (v46 - v45);
        else
            v47 = (p41 - v45) / (v46 - v45);
        end;

        if u40 then
            return math.max(v47, 0);
        end;

        return math.clamp(v47, 0, 1);
    end;

    local function BonusFor(p48: string) -- Line: 876
        -- upvalues: u34 (copy)
        return u34 and u34[p48] or 0;
    end;

    if p33.GuaranteedStat and type(p33.GuaranteedStat) == "table" then
        local GuaranteedStat = p33.GuaranteedStat;
        local v49 = u1.GuaranteedBase[v37];

        if v49 then
            for _, v in v49 do
                if v.StatKey == GuaranteedStat.StatKey then
                    local v50 = v.Ranges[v35];

                    if v50 then
                        local v51 = GuaranteedStat.Value + (u34 and (u34[GuaranteedStat.StatKey] or 0) or 0);
                        local StatKey = GuaranteedStat.StatKey;
                        local v52 = v50.Min * u39;
                        local v53 = v50.Max * u39;
                        local v54;

                        if v52 == v53 then
                            v54 = 1;
                        else
                            local v55;

                            if u1.InvertedStats[StatKey] then
                                v55 = (v53 - v51) / (v53 - v52);
                            else
                                v55 = (v51 - v52) / (v53 - v52);
                            end;

                            if u40 then
                                v54 = math.max(v55, 0);
                            else
                                v54 = math.clamp(v55, 0, 1);
                            end;
                        end;

                        v38 = v38 + v54 * GEAR_SCORE_STAT_WEIGHT;
                    end;

                    break;
                end;
            end;
        end;
    end;

    if p33.Stats then
        local v56 = u1.StatPools[v37];

        if v56 then
            for i, v in p33.Stats do
                local v57 = v56[i];

                if v57 then
                    local v58 = v57.Ranges[v35];

                    if v58 then
                        local v59 = v + (u34 and (u34[i] or 0) or 0);
                        local v60 = v58.Min * u39;
                        local v61 = v58.Max * u39;
                        local v62;

                        if v60 == v61 then
                            v62 = 1;
                        else
                            local v63;

                            if u1.InvertedStats[i] then
                                v63 = (v61 - v59) / (v61 - v60);
                            else
                                v63 = (v59 - v60) / (v61 - v60);
                            end;

                            if u40 then
                                v62 = math.max(v63, 0);
                            else
                                v62 = math.clamp(v63, 0, 1);
                            end;
                        end;

                        v38 = v38 + v62 * GEAR_SCORE_STAT_WEIGHT;
                    end;
                end;
            end;
        end;
    end;

    if v37 == "Ring" and p33.BaseDamage then
        local v64 = u1.SoulBaseDamageRange[v35];

        if v64 then
            local v65 = p33.BaseDamage + (u34 and u34.BaseDamage or 0);
            local v66 = v64.Min * u39;
            local v67 = v64.Max * u39;
            local v68;

            if v66 == v67 then
                v68 = 1;
            else
                local v69;

                if u1.InvertedStats.SoulBaseDamage then
                    v69 = (v67 - v65) / (v67 - v66);
                else
                    v69 = (v65 - v66) / (v67 - v66);
                end;

                if u40 then
                    v68 = math.max(v69, 0);
                else
                    v68 = math.clamp(v69, 0, 1);
                end;
            end;

            v38 = v38 + v68 * GEAR_SCORE_STAT_WEIGHT;
        end;
    end;

    return math.floor(v38 + 0.5);
end;

function u1.ComputeItemGearScore(p70) -- Line: 929
    -- upvalues: ComputeGearScoreInternal (copy)
    return ComputeGearScoreInternal(p70, nil);
end;

function u1.ComputeItemGearScoreWithBonuses(p71: any, p72: table?) -- Line: 937
    -- upvalues: ComputeGearScoreInternal (copy)
    return ComputeGearScoreInternal(p71, p72);
end;

function u1.ComputeTotalGearScore(p73) -- Line: 942
    -- upvalues: u1 (copy)
    if type(p73) ~= "table" then
        return 0;
    end;

    local v74 = 0;

    for _, v in { "Head", "Body", "Ring" } do
        v74 = v74 + u1.ComputeItemGearScore(p73[v]);
    end;

    return v74;
end;

function u1.GetLineCount(p75: string) -- Line: 954
    -- upvalues: u1 (copy)
    local v76 = u1.RarityRules[p75];

    if v76 then
        return v76.MinLines, v76.MaxLines;
    end;

    return 1, 1;
end;

u1.StatDisplayNames = {
    MaxHP = "Max HP",
    MaxMana = "Max Mana",
    Defense = "Defense",
    BonusDamage = "Bonus Damage",
    DamageReduction = "Damage Reduction",
    BlockRate = "Block Rate",
    BlockMaxHealth = "Block Strength",
    AttackDamageBonus = "Basic Damage",
    LifeSteal = "Lifesteal",
    SkillDamageBonus = "Skill Damage",
    PhysicalDamage = "Physical Damage",
    RangedDamage = "Ranged Damage",
    MagicDamage = "Magic Damage",
    ArmorShred = "Armor Shred",
    CritRate = "Crit Rate",
    CritDamage = "Crit Damage",
    SkillCritChance = "Skill Crit Rate",
    SkillCritDamage = "Skill Crit Damage",
    AttackSpeed = "Attack Speed",
    MovementSpeed = "Movement Speed",
    DodgeCooldown = "Dodge Cooldown",
    ParryExtension = "Parry Extension",
    CooldownReduction = "Cooldown Reduction",
    ManaRegen = "Mana Regen",
    LootBias = "Loot Bias",
    HPRegen = "HP Regen",
    DodgeRate = "Evasion",
    SoulBaseDamage = "Base Damage",
    GearScore = "Gear Score"
};
u1.StatTypes = {
    MaxHP = "flat",
    MaxMana = "flat",
    Defense = "flat",
    BonusDamage = "percent",
    DamageReduction = "percent",
    BlockRate = "percent",
    BlockMaxHealth = "flat",
    AttackDamageBonus = "percent",
    LifeSteal = "percent",
    SkillDamageBonus = "percent",
    PhysicalDamage = "percent",
    RangedDamage = "percent",
    MagicDamage = "percent",
    ArmorShred = "percent",
    CritRate = "percent",
    CritDamage = "percent",
    SkillCritChance = "percent",
    SkillCritDamage = "percent",
    AttackSpeed = "percent",
    MovementSpeed = "percent",
    DodgeCooldown = "seconds",
    ParryExtension = "seconds",
    CooldownReduction = "percent",
    ManaRegen = "flat",
    LootBias = "flat",
    SoulBaseDamage = "flat",
    HPRegen = "flat",
    DodgeRate = "percent",
    GearScore = "hidden"
};
u1.StatDescriptions = {
    MaxHP = "Increases your maximum health.",
    MaxMana = "Increases your maximum mana.",
    Defense = "Reduces damage taken.",
    BonusDamage = "Increased Base Damage contribution.",
    DamageReduction = "Reduces all damage taken.",
    BlockRate = "Increased chance to block attacks.",
    BlockMaxHealth = "Strengthens your block so it absorbs more damage before breaking.",
    AttackDamageBonus = "Increases basic (M1) attack damage.",
    LifeSteal = "Heals you for a percent of the damage you deal.",
    SkillDamageBonus = "Increases skill damage.",
    PhysicalDamage = "Increases all damage dealt by Physical (melee) classes.",
    RangedDamage = "Increases all damage dealt by Ranged classes.",
    MagicDamage = "Increases all damage dealt by Magic classes.",
    ArmorShred = "Deals extra damage to enemy armor.",
    CritRate = "Increases critical strike chance.",
    CritDamage = "Increases critical strike damage.",
    SkillCritChance = "Increases skills\' critical strike chance.",
    SkillCritDamage = "Increases skills\' critical strike damage.",
    AttackSpeed = "Increases attack speed.",
    MovementSpeed = "Increases movement speed.",
    DodgeCooldown = "Reduces dodge cooldown.",
    ParryExtension = "Extends the parry timing window.",
    CooldownReduction = "Reduces skill cooldowns.",
    ManaRegen = "Increases mana regeneration.",
    LootBias = "Improves loot roll quality.",
    HPRegen = "Increases health regeneration.",
    DodgeRate = "Chance to completely evade an attack.",
    SoulBaseDamage = "Increases your base weapon damage."
};

local function ResolveStatType(p77: string, p78: string?) -- Line: 1067
    -- upvalues: u1 (copy)
    local v79 = u1.StatTypes[p77] or "flat";

    if p78 then
        local v80 = u1.StatPools[p78];

        if v80 and v80[p77] then
            v79 = v80[p77].Type;
        end;
    end;

    return v79;
end;

local function FormatStatNumber(p81: number) -- Line: 1080
    if math.abs(p81) < 1 and p81 ~= 0 then
        return string.format("%.2f", p81);
    end;

    if p81 ~= math.floor(p81) then
        return string.format("%.1f", p81);
    end;

    local math_floor_ret = math.floor(p81);

    return tostring(math_floor_ret);
end;

function u1.FormatStatValue(p82: string, p83: any, p84: string?) -- Line: 1092
    -- upvalues: u1 (copy), FormatStatNumber (copy)
    local v85 = u1.StatTypes[p82] or "flat";

    if p84 then
        local v86 = u1.StatPools[p84];

        if v86 and v86[p82] then
            v85 = v86[p82].Type;
        end;
    end;

    if v85 == "hidden" then
        return "";
    end;

    if v85 == "label" then
        return tostring(p83);
    end;

    local v87 = tonumber(p83) or 0;

    return FormatStatNumber(v87) .. (v85 == "percent" and "%" or (v85 == "seconds" and "s" or ""));
end;

function u1.FormatStat(p88: string, p89: any, p90: string?) -- Line: 1116
    -- upvalues: u1 (copy)
    local v91 = u1.StatDisplayNames[p88] or p88;
    local v92 = u1.StatTypes[p88] or "flat";

    if p90 then
        local v93 = u1.StatPools[p90];

        if v93 and v93[p88] then
            v92 = v93[p88].Type;
        end;
    end;

    if v92 == "hidden" then
        return "";
    end;

    if v92 == "label" then
        return v91 .. ": " .. tostring(p89);
    end;

    return ((tonumber(p89) or 0) >= 0 and "+" or "") .. u1.FormatStatValue(p88, p89, p90) .. " " .. v91;
end;

function u1.ApplyLevelScale(p94: number, p95: number) -- Line: 1136
    -- upvalues: u1 (copy)
    return p94 * (1 + (p95 - 1) * u1.LEVEL_SCALE_FACTOR);
end;

function u1.ApplyLevelScalePercent(p96: number, p97: number) -- Line: 1146
    -- upvalues: u1 (copy)
    return p96 * (1 + (p97 - 1) * u1.LEVEL_SCALE_FACTOR);
end;

function u1.IsPercentStat(p98: string, p99: string?) -- Line: 1152
    -- upvalues: u1 (copy)
    if p99 then
        local v100 = u1.StatPools[p99];

        if v100 and (v100[p98] and v100[p98].Type) then
            return v100[p98].Type == "percent";
        end;
    end;

    return u1.StatTypes[p98] == "percent";
end;

function u1.GetDifficultyLevelRange(p101: table, p102: string) -- Line: 1166
    -- upvalues: u1 (copy)
    local v103 = u1.DIFFICULTY_LEVEL_WINDOWS[p102] or u1.DIFFICULTY_LEVEL_WINDOWS.Easy;
    local v104 = p101.Max - p101.Min;
    local math_floor_ret = math.floor(p101.Min + v103[1] * v104);
    local math_floor_ret2 = math.floor(p101.Min + v103[2] * v104);
    local math_max_ret = math.max(math_floor_ret, p101.Min);
    local math_min_ret = math.min(math_floor_ret2, p101.Max);

    return math_max_ret, math.max(math_max_ret, math_min_ret);
end;

u1.InvertedStats = {
    DodgeCooldown = true
};

function u1.GetStatRollQuality(p105: string, p106: number, p107: number, p108: number) -- Line: 1189
    -- upvalues: u1 (copy)
    if p107 == p108 then
        return "Legendary";
    end;

    local v109;

    if u1.InvertedStats[p105] then
        v109 = (p108 - p106) / (p108 - p107);
    else
        v109 = (p106 - p107) / (p108 - p107);
    end;

    local math_clamp_ret = math.clamp(v109, 0, 1);

    return math_clamp_ret >= 0.9 and "Legendary" or (math_clamp_ret >= 0.75 and "Epic" or (math_clamp_ret >= 0.5 and "Rare" or (math_clamp_ret >= 0.25 and "Uncommon" or "Common")));
end;

return u1;