--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Boss_ActionData
  Path:     game.ReplicatedStorage.GameInfo.Boss_ActionData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Index = {
        ["Knight Lord"] = {
            ClassSource = "Oathbreaker",
            BossSet = "Basic",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.5,
            CombatSpeed = 0.65,
            AttackCooldown = 1,
            TurnCount = 4,
            SwingSoundFolder = "Flame_Swing",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(16, 8, 16),
            DefaultRange = 18,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = {
                {
                    ModuleName = "Iron_Stride",
                    DamageMultiplier = 2,
                    AnimSpeed = 0.85,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.8,
                    TelegraphRange = 30,
                    PhaseGate = 1,
                    DashSpeed = 75,
                    DashDuration = 0.2,
                    CloneCount = 4,
                    CloneInterval = 0.15,
                    CloneFadeDuration = 1.2,
                    HitboxSize = Vector3.new(8, 8, 20),
                    HitboxRange = 20,
                    CloneColor = Color3.fromRGB(220, 100, 30)
                },
                {
                    ModuleName = "Ruin_Eruption",
                    DamageMultiplier = 2.5,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1.2,
                    TelegraphRadius = 25,
                    PhaseGate = 1,
                    DashSpeed = 75,
                    DashDuration = 0.2,
                    HitboxSize = Vector3.new(15, 20, 15)
                },
                {
                    ModuleName = "Ruin_Onslaught",
                    DamageMultiplier = 1.5,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1.4,
                    TelegraphRadius = 27,
                    PhaseGate = 2,
                    BarrageTicks = 5,
                    BarrageInterval = 0.12,
                    BarrageMultiplier = 1.1,
                    HitboxSize = Vector3.new(18, 10, 23),
                    HitboxRange = 5
                }
            },
            BasicString = {
                Chance = 0.5,
                EndChainOnParry = true,
                HitCount = 4,
                DamageMultiplier = 0.7,
                HitboxSize = Vector3.new(16, 10, 18),
                HitboxRange = 16,
                StunDuration = 2.5,
                AnimSpeed = 1,
                Endlag = 2,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.2,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.5,
                    Phase = 3
                } }
        },
        ["Bandit Chief"] = {
            ClassSource = "Greatsword",
            BossSet = "Basic",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackCooldown = 1.2,
            TurnCount = 4,
            SwingSoundFolder = "Sword_Swing",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(12, 8, 12),
            DefaultRange = 14,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = {
                {
                    ModuleName = "Forge_Strike",
                    DamageMultiplier = 1.8,
                    AnimSpeed = 0.85,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.8,
                    TelegraphRange = 22,
                    PhaseGate = 1,
                    DashSpeed = 60,
                    DashDuration = 0.2,
                    CloneCount = 3,
                    CloneInterval = 0.06,
                    CloneFadeDuration = 1,
                    HitboxSize = Vector3.new(10, 8, 15),
                    HitboxRange = 15,
                    CloneColor = Color3.fromRGB(200, 50, 50)
                },
                {
                    ModuleName = "Eruption",
                    DamageMultiplier = 1.8,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 25,
                    PhaseGate = 1
                },
                {
                    ModuleName = "Cataclysm",
                    DamageMultiplier = 5.15,
                    AnimSpeed = 0.85,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1.5,
                    TelegraphRadius = 25,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(30, 10, 30),
                    HitboxRange = 5
                }
            },
            BasicString = {
                Chance = 0.5,
                EndChainOnParry = true,
                HitCount = 4,
                DamageMultiplier = 0.6,
                HitboxSize = Vector3.new(14, 10, 16),
                HitboxRange = 14,
                StunDuration = 2.5,
                AnimSpeed = 1,
                Endlag = 2,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.2,
                    Phase = 2
                } }
        },
        ["Goblin Chief"] = {
            ClassSource = "Flame Bastion",
            BossSet = "Basic",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackCooldown = 1,
            TurnCount = 4,
            SwingSoundFolder = "Flame_Swing",
            SwingVolume = 0.5,
            DefaultHitboxSize = Vector3.new(11, 8, 14),
            DefaultRange = 16,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = { {
                    ModuleName = "Ember_Step",
                    DamageMultiplier = 2.5,
                    AnimSpeed = 0.85,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.8,
                    TelegraphRange = 28,
                    PhaseGate = 1,
                    DashSpeed = 70,
                    DashDuration = 0.2,
                    HitboxSize = Vector3.new(10, 8, 17),
                    HitboxRange = 17
                }, {
                    ModuleName = "Blazing_Reach",
                    DamageMultiplier = 3.5,
                    AnimSpeed = 0.85,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.8,
                    TelegraphRange = 22,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(10, 10, 20),
                    HitboxRange = 25
                }, {
                    ModuleName = "Ashen_Onslaught",
                    DamageMultiplier = 1.5,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1.2,
                    TelegraphRadius = 28,
                    PhaseGate = 2,
                    BarrageTicks = 5,
                    BarrageInterval = 0.12,
                    BarrageMultiplier = 0.9,
                    HitboxSize = Vector3.new(23, 10, 23),
                    HitboxRange = 5
                } },
            BasicString = {
                Chance = 0.5,
                EndChainOnParry = true,
                HitCount = 4,
                DamageMultiplier = 0.65,
                HitboxSize = Vector3.new(14, 10, 16),
                HitboxRange = 15,
                StunDuration = 2.5,
                AnimSpeed = 1,
                Endlag = 2,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.2,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.5,
                    Phase = 3
                } }
        },
        Verath = {
            ClassSource = "Shadow Vagrant",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.35,
            CombatSpeed = 0.75,
            AttackCooldown = 1,
            TurnCount = 5,
            SwingSoundFolder = "Ninja",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(18, 10, 18),
            DefaultRange = 20,
            FX_Order = { "Empty", "Empty", "Empty", "Empty", "Empty" },
            Abilities = { {
                    ModuleName = "Rolling_Crescent",
                    DamageMultiplier = 1.2,
                    AnimSpeed = 0.9,
                    Cooldown = 8,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(24, 16, 26),
                    HitboxRange = 14
                }, {
                    ModuleName = "Rolling_Crescent_Hold",
                    DamageMultiplier = 4,
                    AnimSpeed = 0.9,
                    Cooldown = 12,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 40,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(25, 40, 40),
                    HitboxRange = 10
                }, {
                    ModuleName = "Mutilate",
                    DamageMultiplier = 1.2,
                    AnimSpeed = 0.9,
                    Cooldown = 18,
                    TelegraphType = "Line",
                    TelegraphDuration = 1.2,
                    TelegraphRange = 28,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(22, 20, 30),
                    HitboxRange = 28,
                    DashSpeed = 70,
                    DashDuration = 0.18,
                    TickDamage = 1.2,
                    TickInterval = 0.35,
                    FinalDamage = 3.5
                } },
            BasicString = {
                Chance = 0.6,
                EndChainOnParry = true,
                HitCount = 5,
                DamageMultiplier = 0.7,
                HitboxSize = Vector3.new(16, 14, 20),
                HitboxRange = 16,
                StunDuration = 2.5,
                AnimSpeed = 1,
                Endlag = 2,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.3,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.6,
                    Phase = 3
                } }
        },
        Valkskar = {
            ClassSource = "Founder",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.3,
            CombatSpeed = 0.8,
            AttackCooldown = 0.9,
            TurnCount = 5,
            SwingSoundFolder = "Flame_Swing",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(18, 10, 20),
            DefaultRange = 22,
            FX_Order = { "Empty", "Empty", "Empty", "Empty", "Empty" },
            Abilities = { {
                    ModuleName = "Somersault_Crash",
                    DamageMultiplier = 3,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(40, 40, 40),
                    HitboxRange = 0
                }, {
                    ModuleName = "Thousandfold_Thrust",
                    DamageMultiplier = 1.2,
                    AnimSpeed = 0.85,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(28, 20, 30),
                    HitboxRange = 25
                }, {
                    ModuleName = "Pillar_of_Heaven",
                    DamageMultiplier = 4,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(30, 40, 30),
                    HitboxRange = 25
                }, {
                    ModuleName = "Cyclone_Sweep",
                    DamageMultiplier = 2,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 30,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(30, 30, 30),
                    HitboxRange = 25
                } },
            BasicString = {
                Chance = 0.45,
                EndChainOnParry = true,
                HitCount = 5,
                DamageMultiplier = 0.75,
                HitboxSize = Vector3.new(18, 10, 20),
                HitboxRange = 18,
                StunDuration = 2.5,
                AnimSpeed = 1,
                Endlag = 1.8,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.3,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.7,
                    Phase = 3
                } }
        },
        ["Underworld Gatekeeper"] = {
            ClassSource = "Dreadlord",
            BossSet = "Basic",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.25,
            CombatSpeed = 0.85,
            AttackCooldown = 0.9,
            TurnCount = 4,
            SwingSoundFolder = "Flame_Swing",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(20, 12, 22),
            DefaultRange = 24,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = {
                {
                    ModuleName = "Crimson_Rush",
                    DamageMultiplier = 3,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 30,
                    PhaseGate = 1,
                    DashDuration = 0.17,
                    CloneCount = 2,
                    CloneInterval = 0.05,
                    CloneFadeDuration = 0.6,
                    HitboxSize = Vector3.new(25, 15, 30),
                    HitboxRange = 20,
                    DashSpeeds = { 65, 75 },
                    CloneColor = Color3.fromRGB(255, 40, 40)
                },
                {
                    ModuleName = "Dread_Vortex",
                    DamageMultiplier = 1.3,
                    AnimSpeed = 0.9,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(30, 30, 30),
                    HitboxRange = 0
                },
                {
                    ModuleName = "Gravefall",
                    DamageMultiplier = 5,
                    AnimSpeed = 0.85,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.8,
                    TelegraphRange = 35,
                    PhaseGate = 1,
                    DashSpeed = 95,
                    DashDuration = 0.19,
                    HitboxSize = Vector3.new(20, 20, 35),
                    HitboxRange = 20
                },
                {
                    ModuleName = "Rose_Cataclysm",
                    DamageMultiplier = 2,
                    OpenerDamageMult = 1.8,
                    ExplosionDamageMult = 2.5,
                    AnimSpeed = 0.85,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1.5,
                    TelegraphRadius = 35,
                    PhaseGate = 2,
                    OpenerHitboxSize = Vector3.new(20, 20, 30),
                    OpenerHitboxRange = 20,
                    ExplosionHitboxSize = Vector3.new(30, 18, 30)
                }
            },
            BasicString = {
                Chance = 0.3,
                HitCount = 4,
                DamageMultiplier = 0.9,
                HitboxSize = Vector3.new(20, 12, 24),
                HitboxRange = 16,
                StunDuration = 2.5,
                AnimSpeed = 0.9,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.3,
                    Phase = 2,
                    Module = "Underworld_Gatekeeper"
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.7,
                    Phase = 3
                } }
        },
        ["Awakened Devil"] = {
            ClassSource = "Azure Devil",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.25,
            CombatSpeed = 0.85,
            AttackCooldown = 0.8,
            TurnCount = 4,
            SwingSoundFolder = "Sword_Swings",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(20, 12, 22),
            DefaultRange = 24,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = {
                {
                    ModuleName = "Spatial_Cut",
                    DamageMultiplier = 2.5,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 25,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(33, 12, 42),
                    HitboxRange = 5
                },
                {
                    ModuleName = "Cross_Cut",
                    DamageMultiplier = 2,
                    AnimSpeed = 0.9,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.7,
                    TelegraphRadius = 20,
                    PhaseGate = 1
                },
                {
                    ModuleName = "Severance",
                    DamageMultiplier = 5.5,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    AnimSource = "Cursed Child",
                    AnimName = "Ability_2",
                    HitboxSize = Vector3.new(42, 12, 48),
                    HitboxRange = 5
                },
                {
                    ModuleName = "Judgement_Rush",
                    DamageMultiplier = 2.5,
                    FinalMultiplier = 6,
                    AnimSpeed = 0.85,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1.5,
                    TelegraphRadius = 25,
                    PhaseGate = 1,
                    FinalHitboxSize = Vector3.new(36, 14, 36),
                    FinalHitboxRange = 5
                },
                {
                    ModuleName = "Hollow_Rush",
                    DamageMultiplier = 3,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.5,
                    TelegraphRange = 30,
                    PhaseGate = 2,
                    AnimSource = "Cursed Child",
                    AnimName = "Ability_1",
                    DashSpeed = 90,
                    DashDuration = 0.3,
                    HitboxSize = Vector3.new(16, 12, 20),
                    HitboxRange = 20
                },
                {
                    ModuleName = "Void_Cleave",
                    DamageMultiplier = 4,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1.2,
                    TelegraphRadius = 35,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(48, 12, 51),
                    HitboxRange = 5
                }
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.4,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.8,
                    Phase = 3
                } }
        },
        Valen = {
            ClassSource = "Awakened Devil EX",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.2,
            CombatSpeed = 0.9,
            AttackCooldown = 0.7,
            TurnCount = 4,
            SwingSoundFolder = "Sword_Swings",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(22, 12, 24),
            DefaultRange = 26,
            FX_Order = { "Empty", "Empty", "Empty", "Empty" },
            Abilities = {
                {
                    ModuleName = "Mirage_Chase",
                    DamageMultiplier = 1.6,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 30,
                    PhaseGate = 1,
                    DashSpeed = 90,
                    DashDuration = 0.29,
                    HitboxSize = Vector3.new(26, 40, 32),
                    HitboxRange = 30
                },
                {
                    ModuleName = "Spatial_Divide",
                    DamageMultiplier = 1,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 36,
                    PhaseGate = 1,
                    DashSpeed = 70,
                    DashDuration = 0.15,
                    HitboxSize = Vector3.new(27, 12, 38),
                    HitboxRange = 36
                },
                {
                    ModuleName = "Sky_Crash",
                    DamageMultiplier = 2.2,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.7,
                    TelegraphRange = 42,
                    PhaseGate = 1,
                    DashSpeed = 70,
                    DashDuration = 0.15,
                    HitboxSize = Vector3.new(24, 25, 52),
                    HitboxRange = 42
                },
                {
                    ModuleName = "Lunar_Phase",
                    DamageMultiplier = 1.1,
                    TotalHits = 6,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.7,
                    TelegraphRange = 28,
                    PhaseGate = 2,
                    DashSpeed = 60,
                    DashDuration = 0.2,
                    HitboxSize = Vector3.new(26, 12, 32),
                    HitboxRange = 28
                },
                {
                    ModuleName = "Lunar_Eclipse",
                    JudgementMultiplier = 4,
                    SheatheMultiplier = 12,
                    DamageMultiplier = 12,
                    AnimSpeed = 0.9,
                    Cooldown = 18,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1.2,
                    TelegraphRadius = 40,
                    PhaseGate = 3,
                    HitboxSize = Vector3.new(38, 24, 68),
                    HitboxRange = 0
                }
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.4,
                    Phase = 2
                }, {
                    Threshold = 0.2,
                    SpeedMult = 1.9,
                    Phase = 3
                } }
        },
        ["Shadow Monarch"] = {
            ClassSource = "Shadow Vagrant",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.2,
            CombatSpeed = 0.9,
            AttackCooldown = 0.7,
            TurnCount = 5,
            SwingSoundFolder = "Ninja",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(22, 12, 24),
            DefaultRange = 26,
            FX_Order = { "Empty", "Empty", "Empty", "Empty", "Empty" },
            Abilities = { {
                    ModuleName = "Rolling_Crescent",
                    DamageMultiplier = 1.5,
                    AnimSpeed = 0.9,
                    Cooldown = 6,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.7,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(26, 18, 28),
                    HitboxRange = 16
                }, {
                    ModuleName = "Rolling_Crescent_Hold",
                    DamageMultiplier = 5,
                    AnimSpeed = 0.9,
                    Cooldown = 10,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.9,
                    TelegraphRadius = 44,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(28, 44, 44),
                    HitboxRange = 10
                }, {
                    ModuleName = "Mutilate",
                    DamageMultiplier = 1.5,
                    AnimSpeed = 0.9,
                    Cooldown = 15,
                    TelegraphType = "Line",
                    TelegraphDuration = 1,
                    TelegraphRange = 32,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(24, 22, 32),
                    HitboxRange = 30,
                    DashSpeed = 80,
                    DashDuration = 0.2,
                    TickDamage = 1.5,
                    TickInterval = 0.35,
                    FinalDamage = 4.5
                } },
            BasicString = {
                Chance = 0.55,
                EndChainOnParry = true,
                HitCount = 5,
                DamageMultiplier = 0.9,
                HitboxSize = Vector3.new(18, 14, 22),
                HitboxRange = 18,
                StunDuration = 2.5,
                AnimSpeed = 1.1,
                Endlag = 1.6,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.4,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.9,
                    Phase = 3
                } }
        },
        Kieru = {
            ClassSource = "Chaotic Fist",
            ModuleSource = "Chaotic Fist",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.15,
            CombatSpeed = 0.95,
            AttackCooldown = 0.6,
            TurnCount = 4,
            SwingSoundFolder = "Naoya_Punches",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(20, 14, 26),
            DefaultRange = 28,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = {
                {
                    ModuleName = "Air_Type",
                    DamageMultiplier = 2,
                    AnimSpeed = 0.95,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.6,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    FloatUpSpeed = 40,
                    FloatBackSpeed = 20,
                    FloatLaunchDur = 0.35,
                    IFrameDuration = 0.7,
                    HitboxSize = Vector3.new(33, 30, 48),
                    HitboxRange = 5
                },
                {
                    ModuleName = "Annihilation_Type",
                    DamageMultiplier = 6,
                    AnimSpeed = 0.95,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.5,
                    TelegraphRange = 32,
                    PhaseGate = 1,
                    FXDuration = 1,
                    HitboxSize = Vector3.new(22, 22, 32),
                    HitboxRange = 32
                },
                {
                    ModuleName = "Disorder_Type",
                    DamageMultiplier = 0.8,
                    AnimSpeed = 1,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 32,
                    PhaseGate = 2,
                    FXDuration = 3.5,
                    HitboxSize = Vector3.new(19, 22, 32),
                    HitboxRange = 32
                },
                {
                    ModuleName = "Frame_Onslaught",
                    AnimSource = "Framebreaker",
                    AnimName = "Ability_4",
                    DamageMultiplier = 2.8,
                    AnimSpeed = 1,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.7,
                    TelegraphRange = 28,
                    PhaseGate = 2,
                    CloneCount = 3,
                    CloneInterval = 0.04,
                    CloneFadeDuration = 0.8,
                    CloneSpread = 5,
                    HitboxSize = Vector3.new(17, 12, 27),
                    HitboxRange = 27,
                    CloneColor = Color3.fromRGB(0, 200, 180)
                },
                {
                    ModuleName = "Destruction_Type",
                    DamageMultiplier = 0.6,
                    FinalDamageMult = 5,
                    AnimSpeed = 1,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 35,
                    PhaseGate = 3,
                    ChargeFXDuration = 4,
                    FinalFXDuration = 0.5,
                    HitboxSize = Vector3.new(17, 22, 17),
                    HitboxRange = 17,
                    FinalHitboxSize = Vector3.new(22, 22, 32),
                    FinalHitboxRange = 32
                }
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.5,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 2,
                    Phase = 3
                } }
        },
        Miyu = {
            ClassSource = "Artemis",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.2,
            CombatSpeed = 0.9,
            AttackCooldown = 0.7,
            TurnCount = 4,
            SwingSoundFolder = "Bow_Shot",
            SwingVolume = 0.8,
            DefaultHitboxSize = Vector3.new(20, 15, 28),
            DefaultRange = 28,
            FX_Order = { "Shot", "Shot", "Shot", "Shot" },
            Abilities = {
                {
                    ModuleName = "Twin_Bolt",
                    DamageMultiplier = 1.8,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 30,
                    PhaseGate = 1,
                    DashDuration = 0.15,
                    CloneCount = 2,
                    CloneInterval = 0.04,
                    CloneFadeDuration = 0.6,
                    HitboxSize = Vector3.new(22, 15, 28),
                    HitboxRange = 28,
                    DashSpeeds = { 55, 65 },
                    CloneColor = Color3.fromRGB(180, 220, 255)
                },
                {
                    ModuleName = "Tempest_Strike",
                    DamageMultiplier = 3.5,
                    AnimSpeed = 0.9,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    DashSpeed = 70,
                    DashDuration = 0.3,
                    HitboxSize = Vector3.new(51, 30, 51),
                    HitboxRange = 5
                },
                {
                    ModuleName = "Moonfall",
                    DamageMultiplier = 1,
                    AnimSpeed = 0.9,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 32,
                    PhaseGate = 2,
                    RainDuration = 3,
                    TickInterval = 0.25,
                    HitboxSize = Vector3.new(32, 25, 32)
                },
                {
                    ModuleName = "Stormfire",
                    DamageMultiplier = 1.5,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.9,
                    TelegraphRange = 34,
                    PhaseGate = 3,
                    CloneCount = 2,
                    CloneInterval = 0.04,
                    CloneFadeDuration = 0.6,
                    HitboxSize = Vector3.new(28, 18, 34),
                    HitboxRange = 32,
                    CloneColor = Color3.fromRGB(180, 220, 255)
                }
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.4,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.8,
                    Phase = 3
                } }
        },
        Ogge = {
            ClassSource = "Framebreaker",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.2,
            CombatSpeed = 0.9,
            AttackCooldown = 0.7,
            TurnCount = 4,
            SwingSoundFolder = "Naoya_Punches",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(16, 14, 22),
            DefaultRange = 22,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = {
                {
                    ModuleName = "Frame_Skip",
                    DamageMultiplier = 3.5,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.5,
                    TelegraphRange = 18,
                    PhaseGate = 1,
                    DashSpeed = 55,
                    DashDuration = 0.15,
                    CloneCount = 4,
                    CloneInterval = 0.06,
                    CloneFadeDuration = 0.8,
                    HitboxSize = Vector3.new(33, 20, 33),
                    HitboxRange = 5,
                    CloneColor = Color3.fromRGB(0, 200, 180)
                },
                {
                    ModuleName = "Projection_Jab",
                    DamageMultiplier = 2,
                    AnimSpeed = 0.95,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.5,
                    TelegraphRadius = 22,
                    PhaseGate = 1,
                    CloneCount = 2,
                    CloneInterval = 0.04,
                    CloneFadeDuration = 0.6,
                    HitboxSize = Vector3.new(27, 12, 36),
                    HitboxRange = 5,
                    CloneColor = Color3.fromRGB(0, 200, 180)
                },
                {
                    ModuleName = "Earthshatter",
                    DamageMultiplier = 0.9,
                    AnimSpeed = 0.9,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1.2,
                    TelegraphRadius = 34,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(42, 22, 48),
                    HitboxRange = 5
                },
                {
                    ModuleName = "Frame_Onslaught",
                    DamageMultiplier = 2.5,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.9,
                    TelegraphRange = 30,
                    PhaseGate = 3,
                    CloneCount = 3,
                    CloneInterval = 0.04,
                    CloneFadeDuration = 0.8,
                    HitboxSize = Vector3.new(18, 12, 28),
                    HitboxRange = 28,
                    CloneColor = Color3.fromRGB(0, 200, 180)
                }
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.4,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.8,
                    Phase = 3
                } }
        },
        ["Broken Reality"] = {
            ClassSource = "Azure Devil",
            ModuleSource = "Broken Reality",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.22,
            CombatSpeed = 0.88,
            AttackCooldown = 0.75,
            TurnCount = 4,
            SwingSoundFolder = "Sword_Swings",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(20, 12, 24),
            DefaultRange = 24,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = {
                {
                    ModuleName = "Spatial_Cut",
                    DamageMultiplier = 2.5,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 25,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(33, 12, 42),
                    HitboxRange = 5
                },
                {
                    ModuleName = "Cross_Cut",
                    DamageMultiplier = 2,
                    AnimSpeed = 0.9,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.7,
                    TelegraphRadius = 20,
                    PhaseGate = 1
                },
                {
                    ModuleName = "Void_Cleave",
                    DamageMultiplier = 4,
                    AnimSpeed = 0.9,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1.1,
                    TelegraphRadius = 32,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(45, 12, 48),
                    HitboxRange = 5
                },
                {
                    ModuleName = "Judgement_Rush",
                    DamageMultiplier = 2.5,
                    FinalMultiplier = 6,
                    AnimSpeed = 0.9,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1.4,
                    TelegraphRadius = 24,
                    PhaseGate = 2,
                    FinalHitboxSize = Vector3.new(36, 14, 36),
                    FinalHitboxRange = 5
                },
                {
                    ModuleName = "Traced_Arsenal_Hold",
                    AnimSource = "Forge Archon",
                    AnimName = "Ability_1_Hold",
                    DamageMultiplier = 1.8,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.8,
                    TelegraphRange = 30,
                    PhaseGate = 3,
                    DashDuration = 0.15,
                    HitboxSize = Vector3.new(30, 22, 42),
                    HitboxRange = 5,
                    DashSpeeds = { 30, 32, 35, 30, 32, 38 }
                },
                {
                    ModuleName = "Infinite_Creation",
                    AnimSource = "Forge Archon",
                    AnimName = "Ability_4",
                    DamageMultiplier = 0.9,
                    AnimSpeed = 0.9,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1.5,
                    TelegraphRadius = 50,
                    PhaseGate = 3,
                    TickInterval = 0.1,
                    SlashFXInterval = 0.35,
                    HitboxSize = Vector3.new(50, 50, 50),
                    HitboxRange = 0
                }
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.35,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.7,
                    Phase = 3
                } }
        },
        Mimika = {
            ClassSource = "Zero",
            ModuleSource = "Zero",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.22,
            CombatSpeed = 0.88,
            AttackCooldown = 0.75,
            TurnCount = 4,
            SwingSoundFolder = "Corsair_A",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(24, 18, 26),
            DefaultRange = 24,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = { {
                    ModuleName = "Fuuka",
                    DamageMultiplier = 1.6,
                    AnimSpeed = 0.95,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 32,
                    PhaseGate = 1,
                    DashSpeed = 90,
                    DashDuration = 0.29,
                    HitboxSize = Vector3.new(26, 20, 32),
                    HitboxRange = 28
                }, {
                    ModuleName = "Fuyubachi",
                    DamageMultiplier = 1.3,
                    AnimSpeed = 0.95,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.6,
                    TelegraphRadius = 24,
                    PhaseGate = 1,
                    DashSpeed = 40,
                    DashDuration = 0.2,
                    ParryDuration = 0.5,
                    HitboxSize = Vector3.new(24, 12, 26),
                    HitboxRange = 22
                }, {
                    ModuleName = "Kazahana",
                    DamageMultiplier = 1.8,
                    AnimSpeed = 0.9,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 28,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(36, 12, 36),
                    HitboxRange = 20
                } },
            BasicString = {
                Chance = 0.5,
                EndChainOnParry = true,
                HitCount = 4,
                DamageMultiplier = 0.8,
                HitboxSize = Vector3.new(24, 18, 26),
                HitboxRange = 24,
                StunDuration = 2.5,
                AnimSpeed = 1,
                Endlag = 1.6,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.35,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.7,
                    Phase = 3
                } }
        },
        Genesis = {
            ClassSource = "Zero",
            ModuleSource = "Zero",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.18,
            CombatSpeed = 0.9,
            AttackCooldown = 0.6,
            TurnCount = 4,
            SwingSoundFolder = "Corsair_A",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(24, 18, 26),
            DefaultRange = 24,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = {
                {
                    ModuleName = "Fuuka",
                    DamageMultiplier = 1.6,
                    AnimSpeed = 0.95,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 32,
                    PhaseGate = 1,
                    DashSpeed = 90,
                    DashDuration = 0.29,
                    HitboxSize = Vector3.new(26, 20, 32),
                    HitboxRange = 28
                },
                {
                    ModuleName = "Fuyubachi",
                    DamageMultiplier = 1.3,
                    AnimSpeed = 0.95,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.6,
                    TelegraphRadius = 24,
                    PhaseGate = 1,
                    DashSpeed = 40,
                    DashDuration = 0.2,
                    ParryDuration = 0.5,
                    HitboxSize = Vector3.new(24, 12, 26),
                    HitboxRange = 22
                },
                {
                    ModuleName = "Kazahana",
                    DamageMultiplier = 1.8,
                    AnimSpeed = 0.9,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 28,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(36, 12, 36),
                    HitboxRange = 20
                },
                {
                    ModuleName = "Hanafubuki",
                    DamageMultiplier = 1.2,
                    AnimSpeed = 0.95,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 20,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(24, 16, 26),
                    HitboxRange = 14
                },
                {
                    ModuleName = "Hanafubuki_Vortex",
                    DamageMultiplier = 1.2,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 1.2,
                    TelegraphRange = 28,
                    PhaseGate = 3,
                    HitboxSize = Vector3.new(22, 20, 30),
                    HitboxRange = 28,
                    DashSpeed = 70,
                    DashDuration = 0.18,
                    TickDamage = 1.2,
                    TickInterval = 0.35,
                    FinalDamage = 3.5
                }
            },
            BasicString = {
                Chance = 0.5,
                EndChainOnParry = true,
                HitCount = 4,
                DamageMultiplier = 0.8,
                HitboxSize = Vector3.new(24, 18, 26),
                HitboxRange = 24,
                StunDuration = 2.5,
                AnimSpeed = 1,
                Endlag = 1.6,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.35,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.7,
                    Phase = 3
                } }
        },
        ["Forge Archon"] = {
            ClassSource = "Forge Archon",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.12,
            CombatSpeed = 0.95,
            AttackCooldown = 0.55,
            TurnCount = 5,
            SwingSoundFolder = "Magic_Swings",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(22, 14, 26),
            DefaultRange = 26,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Right_Slash", "Left_Slash" },
            Abilities = {
                {
                    ModuleName = "Traced_Arsenal_Tap",
                    DamageMultiplier = 2.2,
                    SwordDamageMult = 2.2,
                    BowDamageMult = 2.2,
                    AnimSpeed = 0.95,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 36,
                    PhaseGate = 1,
                    DashSpeed = 75,
                    DashDuration = 0.15,
                    BowDashDuration = 0.12,
                    SwordHitboxSize = Vector3.new(22, 20, 26),
                    SwordHitboxRange = 26,
                    BowHitboxSize = Vector3.new(16, 20, 36),
                    BowHitboxRange = 36,
                    BowDashSpeeds = { 55, 60, 65 }
                },
                {
                    ModuleName = "Blade_Projection",
                    DamageMultiplier = 5,
                    SlashDamageMult = 5,
                    FinalDamageMult = 3,
                    AnimSpeed = 0.95,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.8,
                    TelegraphRange = 42,
                    PhaseGate = 1,
                    DashSpeed = 80,
                    DashDuration = 0.1,
                    SlashHitboxSize = Vector3.new(18, 20, 42),
                    SlashHitboxRange = 42,
                    FinalHitboxSize = Vector3.new(22, 22, 28),
                    FinalHitboxRange = 28
                },
                {
                    ModuleName = "Traced_Arsenal_Hold",
                    DamageMultiplier = 2,
                    AnimSpeed = 0.95,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.9,
                    TelegraphRange = 32,
                    PhaseGate = 2,
                    DashDuration = 0.15,
                    HitboxSize = Vector3.new(22, 24, 30),
                    HitboxRange = 30,
                    DashSpeeds = { 30, 32, 35, 30, 32, 38 }
                },
                {
                    ModuleName = "Rain_of_Swords_Tap",
                    DamageMultiplier = 2.5,
                    AnimSpeed = 0.95,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.7,
                    TelegraphRange = 38,
                    PhaseGate = 2,
                    DashSpeed = 65,
                    DashDuration = 0.15,
                    HitboxSize = Vector3.new(22, 22, 38),
                    HitboxRange = 38
                },
                {
                    ModuleName = "Rain_of_Swords_Hold",
                    DamageMultiplier = 14,
                    AnimSpeed = 0.95,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1.2,
                    TelegraphRadius = 34,
                    PhaseGate = 3,
                    FloatUpSpeed = 80,
                    FloatBackSpeed = 40,
                    FloatLaunchDur = 0.15,
                    HitboxSize = Vector3.new(48, 50, 48),
                    HitboxRange = 5
                },
                {
                    ModuleName = "Infinite_Creation",
                    DamageMultiplier = 0.9,
                    AnimSpeed = 0.95,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1.5,
                    TelegraphRadius = 55,
                    PhaseGate = 3,
                    TickInterval = 0.1,
                    SlashFXInterval = 0.35,
                    HitboxSize = Vector3.new(55, 55, 55),
                    HitboxRange = 0
                }
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.55,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 2.1,
                    Phase = 3
                } }
        },
        ["Anti Mage"] = {
            ClassSource = "Anti Magic",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.1,
            CombatSpeed = 1,
            AttackCooldown = 0.5,
            TurnCount = 4,
            SwingSoundFolder = "Power_Swing",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(25, 12, 30),
            DefaultRange = 28,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = { {
                    ModuleName = "Black_Hurricane",
                    DamageMultiplier = 3.5,
                    AnimSpeed = 0.95,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.6,
                    TelegraphRadius = 32,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(28, 25, 38),
                    HitboxRange = 5
                }, {
                    ModuleName = "Twelve_Fold_Cleave",
                    DamageMultiplier = 1.8,
                    FinisherMultiplier = 1.6,
                    AnimSpeed = 0.95,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.7,
                    TelegraphRadius = 32,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(28, 25, 38),
                    HitboxRange = 5
                }, {
                    ModuleName = "Black_Divider",
                    DamageMultiplier = 3,
                    FinisherMultiplier = 6.5,
                    AnimSpeed = 0.95,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.9,
                    TelegraphRadius = 36,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(32, 28, 42),
                    HitboxRange = 5
                }, {
                    ModuleName = "Black_Divider_Final",
                    DamageMultiplier = 1.5,
                    AnimSpeed = 0.95,
                    TelegraphType = "Line",
                    TelegraphDuration = 1.1,
                    TelegraphRange = 48,
                    PhaseGate = 1,
                    LingerDuration = 4,
                    TickInterval = 0.25,
                    HitboxSize = Vector3.new(22, 30, 45),
                    HitboxRange = 35
                } },
            BasicString = {
                Chance = 0.4,
                EndChainOnParry = true,
                HitCount = 4,
                DamageMultiplier = 0.9,
                HitboxSize = Vector3.new(25, 12, 30),
                HitboxRange = 24,
                StunDuration = 2.5,
                AnimSpeed = 1,
                Endlag = 1.6,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.5,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 2,
                    Phase = 3
                } }
        },
        ["Great Mage"] = {
            ClassSource = "Demonbane",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.2,
            CombatSpeed = 0.9,
            AttackCooldown = 0.7,
            TurnCount = 4,
            SwingSoundFolder = "Magic_Shoot",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(20, 15, 40),
            DefaultRange = 34,
            FX_Order = { "Shoot", "Shoot", "Shoot", "Shoot" },
            Abilities = { {
                    ModuleName = "Zoltraak",
                    DamageMultiplier = 3.5,
                    AnimSpeed = 0.95,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 35,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(22, 18, 40),
                    HitboxRange = 35
                }, {
                    ModuleName = "Vollzanbel",
                    DamageMultiplier = 1.5,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.9,
                    TelegraphRange = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(25, 20, 30),
                    HitboxRange = 30
                }, {
                    ModuleName = "Catastravia",
                    DamageMultiplier = 1.2,
                    AnimSpeed = 0.9,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1.4,
                    TelegraphRadius = 40,
                    PhaseGate = 2,
                    FieldDuration = 2,
                    TickInterval = 0.15,
                    HitboxSize = Vector3.new(24, 22, 60),
                    HitboxRange = 55
                } },
            BasicString = {
                Chance = 0.35,
                EndChainOnParry = true,
                HitCount = 4,
                DamageMultiplier = 0.8,
                HitboxSize = Vector3.new(20, 18, 40),
                HitboxRange = 34,
                StunDuration = 2.5,
                AnimSpeed = 1,
                Endlag = 1.8,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.4,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.8,
                    Phase = 3
                } }
        },
        Raijin = {
            ClassSource = "Jetstream",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.18,
            CombatSpeed = 0.9,
            AttackCooldown = 0.65,
            TurnCount = 4,
            SwingSoundFolder = "Electric_Swing",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(22, 12, 26),
            DefaultRange = 26,
            FX_Order = { "Empty", "Empty", "Empty", "Empty" },
            Abilities = { {
                    ModuleName = "Blade_Flicker",
                    DamageMultiplier = 2,
                    AnimSpeed = 0.95,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.6,
                    TelegraphRadius = 28,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(24, 14, 30),
                    HitboxRange = 28
                }, {
                    ModuleName = "Rising_Flicker",
                    DamageMultiplier = 1.6,
                    AnimSpeed = 0.95,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.5,
                    TelegraphRange = 32,
                    PhaseGate = 1,
                    DashSpeed = 130,
                    DashDuration = 0.05,
                    HitboxSize = Vector3.new(26, 12, 28),
                    HitboxRange = 28
                }, {
                    ModuleName = "Tempest_Edge",
                    DamageMultiplier = 1.3,
                    AnimSpeed = 0.9,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 0.9,
                    TelegraphRadius = 32,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(28, 16, 32),
                    HitboxRange = 28
                }, {
                    ModuleName = "Jetstream_Sheath",
                    DamageMultiplier = 8,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.7,
                    TelegraphRange = 34,
                    PhaseGate = 1,
                    DashSpeed = 120,
                    DashDuration = 0.2,
                    HitboxSize = Vector3.new(36, 16, 42),
                    HitboxRange = 34
                } },
            BasicString = {
                Chance = 0.5,
                EndChainOnParry = true,
                HitCount = 4,
                DamageMultiplier = 0.85,
                HitboxSize = Vector3.new(22, 12, 26),
                HitboxRange = 24,
                StunDuration = 2.5,
                AnimSpeed = 1.05,
                Endlag = 1.7,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.4,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.9,
                    Phase = 3
                } }
        },
        ["Unrestricted EX"] = {
            ClassSource = "Unrestricted",
            ModuleSource = "Unrestricted EX",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.18,
            CombatSpeed = 0.92,
            AttackCooldown = 0.65,
            TurnCount = 4,
            SwingSoundFolder = "Hard_Slash",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(22, 20, 28),
            DefaultRange = 26,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = {
                {
                    ModuleName = "KillerCadence_Sword",
                    DamageMultiplier = 6,
                    AnimSpeed = 0.95,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 28,
                    HitboxSize = Vector3.new(22, 20, 30),
                    HitboxRange = 26,
                    ActivePhases = {
                        [1] = true,
                        [3] = true
                    }
                },
                {
                    ModuleName = "KillerInstinct_Sword",
                    TickMultiplier = 0.35,
                    TickInterval = 0.1,
                    AnimSpeed = 0.9,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.7,
                    TelegraphRadius = 24,
                    HitboxSize = Vector3.new(24, 18, 28),
                    HitboxRange = 20,
                    ActivePhases = {
                        [1] = true,
                        [3] = true
                    }
                },
                {
                    ModuleName = "DomainShatter_Sword",
                    TickMultiplier = 0.55,
                    TickInterval = 0.1,
                    AnimSpeed = 0.9,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.7,
                    TelegraphRadius = 28,
                    HitboxSize = Vector3.new(30, 22, 32),
                    HitboxRange = 22,
                    ActivePhases = {
                        [1] = true,
                        [3] = true
                    }
                },
                {
                    ModuleName = "KillerCadence_Spear",
                    AnimSource = "Unrestricted",
                    AnimName = "Special_Ability_1",
                    DamageMultiplier = 0.9,
                    AnimSpeed = 0.9,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 30,
                    HitboxSize = Vector3.new(36, 24, 36),
                    HitboxRange = 0,
                    DashSpeed = 40,
                    DashDuration = 0.12,
                    ActivePhases = {
                        [2] = true,
                        [3] = true
                    }
                },
                {
                    ModuleName = "KillerInstinct_Spear",
                    AnimSource = "Unrestricted",
                    AnimName = "Special_Ability_2",
                    DamageMultiplier = 7,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.7,
                    TelegraphRange = 40,
                    HitboxSize = Vector3.new(28, 24, 32),
                    HitboxRange = 26,
                    ActivePhases = {
                        [2] = true,
                        [3] = true
                    }
                },
                {
                    ModuleName = "DomainShatter_Spear",
                    AnimSource = "Unrestricted",
                    AnimName = "Special_Ability_3",
                    TickMultiplier = 0.35,
                    TickInterval = 0.1,
                    AnimSpeed = 0.9,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 40,
                    HitboxSize = Vector3.new(42, 42, 42),
                    HitboxRange = 0,
                    ActivePhases = {
                        [2] = true,
                        [3] = true
                    }
                }
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.65,
                    SpeedMult = 1.35,
                    Phase = 2
                }, {
                    Threshold = 0.3,
                    SpeedMult = 1.7,
                    Phase = 3
                } }
        },
        ["Shadow Knight"] = {
            ClassSource = "Unrestricted",
            ModuleSource = "Unrestricted EX",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.18,
            CombatSpeed = 0.92,
            AttackCooldown = 0.65,
            TurnCount = 4,
            SwingSoundFolder = "Hard_Slash",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(22, 20, 28),
            DefaultRange = 26,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = {
                {
                    ModuleName = "KillerCadence_Sword",
                    DamageMultiplier = 6,
                    AnimSpeed = 0.95,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 28,
                    HitboxSize = Vector3.new(22, 20, 30),
                    HitboxRange = 26,
                    ActivePhases = {
                        [1] = true,
                        [3] = true
                    }
                },
                {
                    ModuleName = "KillerInstinct_Sword",
                    TickMultiplier = 0.35,
                    TickInterval = 0.1,
                    AnimSpeed = 0.9,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.7,
                    TelegraphRadius = 24,
                    HitboxSize = Vector3.new(24, 18, 28),
                    HitboxRange = 20,
                    ActivePhases = {
                        [1] = true,
                        [3] = true
                    }
                },
                {
                    ModuleName = "DomainShatter_Sword",
                    TickMultiplier = 0.55,
                    TickInterval = 0.1,
                    AnimSpeed = 0.9,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.7,
                    TelegraphRadius = 28,
                    HitboxSize = Vector3.new(30, 22, 32),
                    HitboxRange = 22,
                    ActivePhases = {
                        [1] = true,
                        [3] = true
                    }
                },
                {
                    ModuleName = "KillerCadence_Spear",
                    AnimSource = "Unrestricted",
                    AnimName = "Special_Ability_1",
                    DamageMultiplier = 0.9,
                    AnimSpeed = 0.9,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 30,
                    HitboxSize = Vector3.new(36, 24, 36),
                    HitboxRange = 0,
                    DashSpeed = 40,
                    DashDuration = 0.12,
                    ActivePhases = {
                        [2] = true,
                        [3] = true
                    }
                },
                {
                    ModuleName = "KillerInstinct_Spear",
                    AnimSource = "Unrestricted",
                    AnimName = "Special_Ability_2",
                    DamageMultiplier = 7,
                    AnimSpeed = 0.9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.7,
                    TelegraphRange = 40,
                    HitboxSize = Vector3.new(28, 24, 32),
                    HitboxRange = 26,
                    ActivePhases = {
                        [2] = true,
                        [3] = true
                    }
                },
                {
                    ModuleName = "DomainShatter_Spear",
                    AnimSource = "Unrestricted",
                    AnimName = "Special_Ability_3",
                    TickMultiplier = 0.35,
                    TickInterval = 0.1,
                    AnimSpeed = 0.9,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 40,
                    HitboxSize = Vector3.new(42, 42, 42),
                    HitboxRange = 0,
                    ActivePhases = {
                        [2] = true,
                        [3] = true
                    }
                }
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.65,
                    SpeedMult = 1.35,
                    Phase = 2
                }, {
                    Threshold = 0.3,
                    SpeedMult = 1.7,
                    Phase = 3
                } }
        },
        Satori = {
            ClassSource = "Honored One",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.2,
            CombatSpeed = 0.9,
            AttackCooldown = 1.1,
            TurnCount = 4,
            SwingSoundFolder = "Short_Punches",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(14, 14, 20),
            DefaultRange = 20,
            FX_Order = { "Empty", "Empty", "Empty", "Empty" },
            Abilities = { {
                    ModuleName = "Red",
                    DamageMultiplier = 3.5,
                    AnimSpeed = 1,
                    Cooldown = 8,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(25, 20, 35),
                    HitboxRange = 20
                }, {
                    ModuleName = "Blue",
                    DamageMultiplier = 0.5,
                    AnimSpeed = 1,
                    Cooldown = 12,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(30, 30, 30),
                    HitboxRange = 0,
                    TickMultiplier = 0.5,
                    TickInterval = 0.4,
                    TickHitboxSize = Vector3.new(30, 30, 30),
                    TickHitboxRange = 30,
                    FinisherMultiplier = 2,
                    FinisherHitboxSize = Vector3.new(30, 30, 30),
                    FinisherHitboxRange = 30
                } },
            BasicString = {
                Chance = 0.65,
                EndChainOnParry = true,
                HitCount = 4,
                DamageMultiplier = 0.7,
                HitboxSize = Vector3.new(14, 14, 20),
                HitboxRange = 16,
                StunDuration = 3,
                AnimSpeed = 0.95,
                Endlag = 3,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.15,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.3,
                    Phase = 3
                } }
        },
        ["Cursed King"] = {
            ClassSource = "Cursed King",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.2,
            CombatSpeed = 0.9,
            AttackCooldown = 1.1,
            TurnCount = 5,
            SwingSoundFolder = "Sukuna",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(14, 14, 20),
            DefaultRange = 20,
            FX_Order = { "Empty", "Empty", "Empty", "Empty", "Empty" },
            Abilities = {
                {
                    ModuleName = "Slash_Combo",
                    DamageMultiplier = 1,
                    AnimSpeed = 1,
                    Cooldown = 7,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(18, 12, 22),
                    HitboxRange = 18,
                    TickInterval = 0.3
                },
                {
                    ModuleName = "Cleaving_Rush",
                    DamageMultiplier = 1.5,
                    AnimSpeed = 1,
                    Cooldown = 10,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.9,
                    TelegraphRange = 45,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(20, 15, 45),
                    HitboxRange = 45,
                    RangedDamageMultiplier = 1.5,
                    RangedHitboxSize = Vector3.new(20, 15, 45),
                    RangedHitboxRange = 45,
                    FlurryDamageMultiplier = 1,
                    FlurryHitboxSize = Vector3.new(18, 12, 22),
                    FlurryHitboxRange = 18,
                    FlurryTickInterval = 0.3
                },
                {
                    ModuleName = "Fuuga",
                    DamageMultiplier = 1,
                    AnimSpeed = 1,
                    Cooldown = 16,
                    TelegraphType = "Line",
                    TelegraphDuration = 1,
                    TelegraphRange = 45,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(30, 40, 50),
                    HitboxRange = 45,
                    DetonateDelay = 3.4,
                    CubeDistance = 20,
                    DamageRadius = 25,
                    FieldMultiplier = 1,
                    TickInterval = 0.4,
                    DamageDuration = 5
                }
            },
            BasicString = {
                Chance = 0.6,
                EndChainOnParry = true,
                HitCount = 5,
                DamageMultiplier = 0.7,
                HitboxSize = Vector3.new(14, 14, 20),
                HitboxRange = 16,
                StunDuration = 3,
                AnimSpeed = 0.95,
                Endlag = 2.5,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.2,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.35,
                    Phase = 3
                } }
        },
        Tenebris = {
            ClassSource = "Shadow Vagrant",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.35,
            CombatSpeed = 0.75,
            AttackCooldown = 1,
            TurnCount = 5,
            SwingSoundFolder = "Ninja",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(18, 10, 18),
            DefaultRange = 20,
            FX_Order = { "Empty", "Empty", "Empty", "Empty", "Empty" },
            Abilities = { {
                    ModuleName = "Rolling_Crescent",
                    DamageMultiplier = 1.2,
                    AnimSpeed = 0.9,
                    Cooldown = 8,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(24, 16, 26),
                    HitboxRange = 14
                }, {
                    ModuleName = "Rolling_Crescent_Hold",
                    DamageMultiplier = 4,
                    AnimSpeed = 0.9,
                    Cooldown = 12,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 40,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(25, 40, 40),
                    HitboxRange = 10
                }, {
                    ModuleName = "Mutilate",
                    DamageMultiplier = 1.2,
                    AnimSpeed = 0.9,
                    Cooldown = 18,
                    TelegraphType = "Line",
                    TelegraphDuration = 1.2,
                    TelegraphRange = 28,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(22, 20, 30),
                    HitboxRange = 28,
                    DashSpeed = 70,
                    DashDuration = 0.18,
                    TickDamage = 1.2,
                    TickInterval = 0.35,
                    FinalDamage = 3.5
                } },
            BasicString = {
                Chance = 0.6,
                EndChainOnParry = true,
                HitCount = 5,
                DamageMultiplier = 0.7,
                HitboxSize = Vector3.new(16, 14, 20),
                HitboxRange = 16,
                StunDuration = 2.5,
                AnimSpeed = 1,
                Endlag = 2,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.3,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.6,
                    Phase = 3
                } }
        },
        Karasu = {
            ClassSource = "Witch Gunner",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.35,
            CombatSpeed = 0.75,
            AttackCooldown = 1,
            TurnCount = 5,
            SwingSoundFolder = "Gun_Shots",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(16, 10, 19),
            DefaultRange = 19,
            FX_Order = { "Left_Shot", "Left_Shot", "Left_Shot", "Left_Shot", "Left_Shot" },
            Abilities = {
                {
                    ModuleName = "Witch_Twist",
                    DamageMultiplier = 1.2,
                    AnimSpeed = 0.85,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.8,
                    TelegraphRange = 24,
                    PhaseGate = 1,
                    DashSpeed = 55,
                    DashDuration = 0.2,
                    HitboxSize = Vector3.new(20, 12, 22),
                    HitboxRange = 18
                },
                {
                    ModuleName = "Bullet_Carnival",
                    DamageMultiplier = 0.9,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 20,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(35, 17, 35),
                    HitboxRange = 0
                },
                {
                    ModuleName = "Thorn_Recoil",
                    DamageMultiplier = 1.2,
                    AnimSpeed = 0.85,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.8,
                    TelegraphRange = 26,
                    PhaseGate = 1,
                    DashSpeed = 50,
                    DashDuration = 0.25,
                    HitboxSize = Vector3.new(20, 12, 24),
                    HitboxRange = 22
                },
                {
                    ModuleName = "Wicked_Sabbath",
                    DamageMultiplier = 0.6,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1.5,
                    TelegraphRadius = 22,
                    PhaseGate = 2,
                    SavageDamageMultiplier = 0.9,
                    SavageHitboxSize = Vector3.new(28, 20, 38),
                    HitboxSize = Vector3.new(20, 12, 24),
                    HitboxRange = 20
                }
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.3,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.6,
                    Phase = 3
                } }
        },
        ["Bandit Enforcer"] = {
            ClassSource = "Greatsword",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackCooldown = 2,
            TurnCount = 4,
            SwingSoundFolder = "Sword_Swing",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(12, 8, 12),
            DefaultRange = 14,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = { {
                    ModuleName = "Eruption",
                    DamageMultiplier = 1.2,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 22,
                    PhaseGate = 1
                } },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                } }
        },
        ["Goblin Warchief"] = {
            ClassSource = "Flame Bastion",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackCooldown = 2,
            TurnCount = 4,
            SwingSoundFolder = "Flame_Swing",
            SwingVolume = 0.5,
            DefaultHitboxSize = Vector3.new(11, 8, 14),
            DefaultRange = 16,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = { {
                    ModuleName = "Blazing_Reach",
                    DamageMultiplier = 2.5,
                    AnimSpeed = 0.85,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.8,
                    TelegraphRange = 20,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(10, 10, 18),
                    HitboxRange = 22
                } },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                } }
        },
        ["Knight Champion"] = {
            ClassSource = "Oathbreaker",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackCooldown = 2,
            TurnCount = 4,
            SwingSoundFolder = "Sword_Swing",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(14, 8, 14),
            DefaultRange = 16,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = { {
                    ModuleName = "Ruin_Eruption",
                    DamageMultiplier = 1.5,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 22,
                    PhaseGate = 1
                } },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                } }
        },
        ["Dark Revenant"] = {
            ClassSource = "Shadow Vagrant",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackCooldown = 2,
            TurnCount = 5,
            SwingSoundFolder = "Ninja",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(14, 8, 14),
            DefaultRange = 16,
            FX_Order = { "Empty", "Empty", "Empty", "Empty", "Empty" },
            Abilities = { {
                    ModuleName = "Rolling_Crescent",
                    DamageMultiplier = 0.9,
                    AnimSpeed = 0.85,
                    Cooldown = 10,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(22, 16, 24),
                    HitboxRange = 14
                }, {
                    ModuleName = "Rolling_Crescent_Hold",
                    DamageMultiplier = 3,
                    AnimSpeed = 0.85,
                    Cooldown = 15,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1.2,
                    TelegraphRadius = 34,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(22, 34, 34),
                    HitboxRange = 10
                }, {
                    ModuleName = "Mutilate",
                    DamageMultiplier = 0.9,
                    AnimSpeed = 0.85,
                    Cooldown = 22,
                    TelegraphType = "Line",
                    TelegraphDuration = 1.4,
                    TelegraphRange = 26,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(20, 18, 28),
                    HitboxRange = 26,
                    DashSpeed = 65,
                    DashDuration = 0.18,
                    TickDamage = 0.9,
                    TickInterval = 0.35,
                    FinalDamage = 2.5
                } },
            BasicString = {
                Chance = 0.65,
                EndChainOnParry = true,
                HitCount = 4,
                DamageMultiplier = 0.6,
                HitboxSize = Vector3.new(16, 14, 20),
                HitboxRange = 16,
                StunDuration = 2.5,
                AnimSpeed = 1,
                Endlag = 2,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.15,
                    Phase = 2
                } }
        },
        ["Frost Warden"] = {
            ClassSource = "Founder",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackCooldown = 2,
            TurnCount = 5,
            SwingSoundFolder = "Sword_Swing",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(14, 8, 14),
            DefaultRange = 16,
            FX_Order = { "Empty", "Empty", "Empty", "Empty", "Empty" },
            Abilities = { {
                    ModuleName = "Thousandfold_Thrust",
                    DamageMultiplier = 1.4,
                    AnimSpeed = 0.85,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.8,
                    TelegraphRange = 26,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(28, 20, 30),
                    HitboxRange = 25
                } },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                } }
        },
        ["Black Fang"] = {
            ClassSource = "Kage",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackCooldown = 2,
            TurnCount = 4,
            SwingSoundFolder = "Magic_Swings",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(14, 8, 14),
            DefaultRange = 16,
            FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
            Abilities = { {
                    ModuleName = "Shadow_Step",
                    DamageMultiplier = 3.5,
                    AnimSpeed = 1,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 22,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(20, 20, 28),
                    HitboxRange = 28
                }, {
                    ModuleName = "Heart_Stab",
                    DamageMultiplier = 2.5,
                    AnimSpeed = 1,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 20,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(20, 15, 20),
                    HitboxRange = 15
                }, {
                    ModuleName = "Devouring_Gale",
                    DamageMultiplier = 1.5,
                    AnimSpeed = 1,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(30, 30, 30),
                    HitboxRange = 0
                }, {
                    ModuleName = "Fists_of_Ruin",
                    DamageMultiplier = 0.8,
                    FinalDamageMultiplier = 4.5,
                    AnimSpeed = 1,
                    TelegraphType = "Line",
                    TelegraphDuration = 1,
                    TelegraphRange = 20,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(15, 15, 17),
                    HitboxRange = 17
                } },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                } }
        },
        ["Scarlet Knight"] = {
            ClassSource = "Shadow Vagrant",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.25,
            CombatSpeed = 0.9,
            AttackCooldown = 0.8,
            TurnCount = 5,
            SwingSoundFolder = "Ninja",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(20, 12, 22),
            DefaultRange = 24,
            FX_Order = { "Empty", "Empty", "Empty", "Empty", "Empty" },
            Abilities = {
                {
                    ModuleName = "Flickering_Step",
                    DamageMultiplier = 1.6,
                    AnimSpeed = 1,
                    Cooldown = 7,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.6,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(30, 24, 30),
                    HitboxRange = 12,
                    DashSpeed = 70,
                    DashDuration = 0.16
                },
                {
                    ModuleName = "Rolling_Crescent",
                    DamageMultiplier = 1.3,
                    AnimSpeed = 0.9,
                    Cooldown = 6,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.7,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(26, 18, 28),
                    HitboxRange = 16
                },
                {
                    ModuleName = "Foxclaw",
                    DamageMultiplier = 0.83,
                    AnimSpeed = 1,
                    Cooldown = 9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.5,
                    TelegraphRange = 22,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(20, 12, 22),
                    HitboxRange = 20
                },
                {
                    ModuleName = "Rolling_Crescent_Hold",
                    DamageMultiplier = 4.5,
                    AnimSpeed = 0.9,
                    Cooldown = 12,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.9,
                    TelegraphRadius = 44,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(28, 44, 44),
                    HitboxRange = 10
                },
                {
                    ModuleName = "Mutilate",
                    DamageMultiplier = 1.5,
                    AnimSpeed = 0.9,
                    Cooldown = 15,
                    TelegraphType = "Line",
                    TelegraphDuration = 1,
                    TelegraphRange = 32,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(24, 22, 32),
                    HitboxRange = 30,
                    DashSpeed = 80,
                    DashDuration = 0.2,
                    TickDamage = 1.5,
                    TickInterval = 0.35,
                    FinalDamage = 4.5
                }
            },
            BasicString = {
                Chance = 0.5,
                EndChainOnParry = true,
                HitCount = 5,
                DamageMultiplier = 0.85,
                HitboxSize = Vector3.new(18, 14, 22),
                HitboxRange = 18,
                StunDuration = 2.5,
                AnimSpeed = 1.1,
                Endlag = 1.7,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.35,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.75,
                    Phase = 3
                } }
        },
        ["Frigid Monarch"] = {
            ClassSource = "Shadow Vagrant",
            ModuleSource = "Shadow Vagrant",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.2,
            CombatSpeed = 0.95,
            AttackCooldown = 0.55,
            TurnCount = 5,
            SwingSoundFolder = "Ninja",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(20, 12, 22),
            DefaultRange = 24,
            FX_Order = { "Empty", "Empty", "Empty", "Empty", "Empty" },
            Abilities = {
                {
                    ModuleName = "Flickering_Step",
                    DamageMultiplier = 1.6,
                    AnimSpeed = 1,
                    Cooldown = 7,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.6,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(30, 24, 30),
                    HitboxRange = 12,
                    DashSpeed = 70,
                    DashDuration = 0.16
                },
                {
                    ModuleName = "Rolling_Crescent",
                    DamageMultiplier = 1.3,
                    AnimSpeed = 0.9,
                    Cooldown = 6,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.7,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(26, 18, 28),
                    HitboxRange = 16
                },
                {
                    ModuleName = "Foxclaw",
                    DamageMultiplier = 0.83,
                    AnimSpeed = 1,
                    Cooldown = 9,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.5,
                    TelegraphRange = 22,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(20, 12, 22),
                    HitboxRange = 20
                },
                {
                    ModuleName = "Rolling_Crescent_Hold",
                    DamageMultiplier = 4.5,
                    AnimSpeed = 0.9,
                    Cooldown = 12,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.9,
                    TelegraphRadius = 44,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(28, 44, 44),
                    HitboxRange = 10
                },
                {
                    ModuleName = "Mutilate",
                    DamageMultiplier = 1.5,
                    AnimSpeed = 0.9,
                    Cooldown = 15,
                    TelegraphType = "Line",
                    TelegraphDuration = 1,
                    TelegraphRange = 32,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(24, 22, 32),
                    HitboxRange = 30,
                    DashSpeed = 80,
                    DashDuration = 0.2,
                    TickDamage = 1.5,
                    TickInterval = 0.35,
                    FinalDamage = 4.5
                },
                {
                    ModuleName = "KillerCadence_Spear",
                    ModuleSource = "Unrestricted EX",
                    EffectSource = "Unrestricted",
                    AnimSource = "Unrestricted",
                    AnimName = "Special_Ability_1",
                    DamageMultiplier = 0.9,
                    AnimSpeed = 0.9,
                    Cooldown = 8,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(36, 24, 36),
                    HitboxRange = 0,
                    DashSpeed = 40,
                    DashDuration = 0.12
                },
                {
                    ModuleName = "KillerInstinct_Spear",
                    ModuleSource = "Unrestricted EX",
                    EffectSource = "Unrestricted",
                    AnimSource = "Unrestricted",
                    AnimName = "Special_Ability_2",
                    DamageMultiplier = 7,
                    AnimSpeed = 0.9,
                    Cooldown = 11,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.7,
                    TelegraphRange = 40,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(28, 24, 32),
                    HitboxRange = 26
                },
                {
                    ModuleName = "DomainShatter_Spear",
                    ModuleSource = "Unrestricted EX",
                    EffectSource = "Unrestricted",
                    AnimSource = "Unrestricted",
                    AnimName = "Special_Ability_3",
                    TickMultiplier = 0.35,
                    TickInterval = 0.1,
                    AnimSpeed = 0.9,
                    Cooldown = 16,
                    TelegraphType = "BigAoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 40,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(42, 42, 42),
                    HitboxRange = 0
                }
            },
            BasicString = {
                Chance = 0.4,
                EndChainOnParry = true,
                HitCount = 5,
                DamageMultiplier = 0.85,
                HitboxSize = Vector3.new(18, 14, 22),
                HitboxRange = 18,
                StunDuration = 2.5,
                AnimSpeed = 1.15,
                Endlag = 1.6,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.6,
                    SpeedMult = 1.4,
                    Phase = 2
                }, {
                    Threshold = 0.3,
                    SpeedMult = 1.8,
                    Phase = 3
                } }
        },
        Imperator = {
            ClassSource = "Founder",
            ForgeVFX = true,
            WindUpSpeed = 0.1,
            WindUpDuration = 0.3,
            CombatSpeed = 0.8,
            AttackCooldown = 0.9,
            TurnCount = 5,
            SwingSoundFolder = "Flame_Swing",
            SwingVolume = 1,
            DefaultHitboxSize = Vector3.new(18, 10, 20),
            DefaultRange = 22,
            FX_Order = { "Empty", "Empty", "Empty", "Empty", "Empty" },
            Abilities = { {
                    ModuleName = "Somersault_Crash",
                    DamageMultiplier = 3,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(40, 40, 40),
                    HitboxRange = 0
                }, {
                    ModuleName = "Thousandfold_Thrust",
                    DamageMultiplier = 1.2,
                    AnimSpeed = 0.85,
                    TelegraphType = "Line",
                    TelegraphDuration = 0.6,
                    TelegraphRange = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(28, 20, 30),
                    HitboxRange = 25
                }, {
                    ModuleName = "Pillar_of_Heaven",
                    DamageMultiplier = 4,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 1,
                    TelegraphRadius = 30,
                    PhaseGate = 1,
                    HitboxSize = Vector3.new(30, 40, 30),
                    HitboxRange = 25
                }, {
                    ModuleName = "Cyclone_Sweep",
                    DamageMultiplier = 2,
                    AnimSpeed = 0.85,
                    TelegraphType = "AoE",
                    TelegraphDuration = 0.8,
                    TelegraphRadius = 30,
                    PhaseGate = 2,
                    HitboxSize = Vector3.new(30, 30, 30),
                    HitboxRange = 25
                } },
            BasicString = {
                Chance = 0.45,
                EndChainOnParry = true,
                HitCount = 5,
                DamageMultiplier = 0.75,
                HitboxSize = Vector3.new(18, 10, 20),
                HitboxRange = 18,
                StunDuration = 2.5,
                AnimSpeed = 1,
                Endlag = 1.8,
                MinPhase = 1
            },
            Phases = { {
                    Threshold = 1,
                    SpeedMult = 1,
                    Phase = 1
                }, {
                    Threshold = 0.5,
                    SpeedMult = 1.3,
                    Phase = 2
                }, {
                    Threshold = 0.25,
                    SpeedMult = 1.7,
                    Phase = 3
                } }
        }
    }
};

function u1.Resolve(p2: string) -- Line: 3960
    -- upvalues: u1 (copy)
    return u1.Index[p2];
end;

return u1;