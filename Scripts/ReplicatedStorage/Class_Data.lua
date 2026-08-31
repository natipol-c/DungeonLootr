--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Class_Data
  Path:     game.ReplicatedStorage.Classes.Class_Data
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

local script_Parent = script.Parent;
local u1 = {
    Name = "Unknown",
    Description = "",
    Rarity = "Rare",
    DamageMultiplier = 1,
    CritChance = 0.05,
    CritMultiplier = 1.5,
    AttackSpeed = 1,
    TurnCount = 4,
    ComboEndlag = 0.2,
    AttackLungeVelocity = 18,
    AttackLungeDuration = 0.1,
    DirectionalLunge = false,
    DirectionalLungeStrength = 1,
    AttackDashVelocity = 55,
    AttackDashDuration = 0.15,
    Range = 8,
    HitboxSize = Vector3.new(5, 5, 8),
    DodgeVelocity = 85,
    DodgeDuration = 0.2,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.7,
    PostDodgeLockout = 0.05,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    ParrySuccessCooldown = 0.7,
    Skills = {},
    UtilitySkill = "",
    Ultimate = "",
    UltimateMeterCost = 100,
    SkillInfo = {},
    SkillDebounce = 0.2,
    BaseStats = {
        STR = 8,
        DEX = 8,
        VIT = 8,
        INT = 8,
        LCK = 8
    },
    DamageType = "Physical",
    Summonable = true,
    IndexHidden = false,
    SwingSoundFolder = "Sword_Swings",
    HitSoundFolder = "Hit",
    SwingVolume = 1,
    HitVolume = 1,
    FX_Order = {},
    WeldOverrides = nil,
    Motor6D_Overrides = nil,
    SkipDefaultWelds = false,
    AnimationOverrides = nil,
    UseProjectile = false,
    ProjectileId = "M",
    ProjectileSpeed = 90,
    ProjectileArc = 0,
    ProjectileTracking = false,
    ProjectileTrackSpeed = 8,
    ProjectileMaxRange = 120,
    ProjectileHitRadius = 4,
    ProjectileSpreadAngle = 55,
    ProjectilePierceCount = 3,
    ProjectilesPerShot = 1
};

local function makeClass(p2) -- Line: 127
    -- upvalues: u1 (copy)
    local table_clone_ret = table.clone(u1);

    for i, v in p2 do
        table_clone_ret[i] = v;
    end;

    return table_clone_ret;
end;

local table_clone_ret = table.clone(u1);
local u3 = {};

for i, v in {
    Name = "Vacio",
    Description = "An embodiment of the void who strikes with cold, absolute emptiness. Each blow erases rather than cuts.",
    Rarity = "Celestial",
    DamageType = "Magic",
    DamageMultiplier = 1.2,
    CritChance = 0.06,
    CritMultiplier = 1.7,
    AttackSpeed = 1,
    TurnCount = 4,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.7,
    Range = 21,
    HitboxSize = Vector3.new(15, 15, 21),
    DodgeVelocity = 85,
    DodgeDuration = 0.2,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.6,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Power_Swing_Fast",
    HitSoundFolder = "Hit",
    ForgeVFX = true,
    BaseStats = {
        STR = 4,
        DEX = 5,
        VIT = 4,
        INT = 17,
        LCK = 20
    },
    Skills = { "Flash Step", "Cero Blast", "Sonido Barrage", "Javelin Toss" },
    SkillInfo = { {
            Description = "Dashes in the input direction and strikes, then summons up to 3 phantom shadow clones to swarm nearby enemies (a lone enemy is hit by all 3). Parry and iFrame during the dash. 3 charges.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "Unleashes a single concentrated Cero blast in a wide forward cone for heavy void damage.",
            TotalMultiplier = 4
        }, {
            Description = "Freezes in place and rips a high-speed barrage, raining rapid void ticks on everything ahead until the flurry ends.",
            TotalMultiplier = 5
        }, {
            Description = "Hurls a void javelin down for a single devastating impact.",
            TotalMultiplier = 4
        } },
    StationarySkills = { false, false, true, true },
    NoKnockbackSkills = {
        [3] = true
    },
    FX_Order = {},
    AnimationOverrides = {
        idle = "rbxassetid://105319444387691"
    }
} do
    table_clone_ret[i] = v;
end;

u3.Vacio = table_clone_ret;
local table_clone_ret2 = table.clone(u1);

for i, v in {
    Name = "Artemis",
    Description = "A divine huntress whose arrows strike with the force of nature itself. She commands the battlefield from afar raining devastation from the sky and detonating the earth beneath her enemies\' feet.",
    Rarity = "Celestial",
    Summonable = true,
    DamageType = "Ranged",
    DamageMultiplier = 1,
    CritChance = 0.07,
    CritMultiplier = 1.7,
    AttackSpeed = 1.28,
    TurnCount = 5,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.5,
    Range = 32,
    HitboxSize = Vector3.new(15, 15, 35),
    DodgeVelocity = 85,
    DodgeDuration = 0.35,
    DodgeCooldown = 2,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    UtilitySkill = "",
    SwingSoundFolder = "Archer_Magic",
    HitSoundFolder = "Hit",
    BaseStats = {
        STR = 3,
        DEX = 16,
        VIT = 4,
        INT = 12,
        LCK = 5
    },
    Skills = { "Twin Bolt", "Moonfall", "Tempest Strike", "Stormfire", "(Lv. 13 Passive) Spectral Hunt" },
    SkillInfo = { {
            Description = "Double shot with a directional dash on each hit. 3 charges. Dodge frame.",
            TotalMultiplier = 4.4,
            Protection = "Dodge"
        }, {
            Description = "Calls down a rain of arrows in a wide area ~15 studs ahead, striking every 0.25s for 3 seconds. You\'re free to move once it starts.",
            TotalMultiplier = 5
        }, {
            Description = "Two charges. Dash in your input direction with dodge frames, unleashing a three-hit tempest across a huge area.",
            TotalMultiplier = 5,
            Protection = "Dodge"
        }, {
            Description = "Dashes with every shot in a relentless, fully mobile 8-shot barrage.",
            TotalMultiplier = 5
        }, {
            Description = "After casting Moonfall, summon a spectral clone to fight beside you for 15 seconds at 50% damage. Only one clone can be active at a time."
        } },
    NoKnockbackSkills = {
        [3] = true
    },
    FX_Order = { "Shot", "Shot", "Shot", "Shot", "Shot" },
    AnimationOverrides = {
        idle = "rbxassetid://82837107921468"
    }
} do
    table_clone_ret2[i] = v;
end;

u3.Artemis = table_clone_ret2;
local table_clone_ret3 = table.clone(u1);

for i, v in {
    Name = "Awakened Devil EX",
    Description = "A devil swordsman whose twin blades have shed every restraint. Awakened beyond the Azure form, his strikes summon phantoms more often, and each copy cuts deeper.",
    Rarity = "Exotic",
    Summonable = false,
    BaseStats = {
        STR = 14,
        DEX = 14,
        VIT = 3,
        INT = 6,
        LCK = 3
    },
    DamageType = "Physical",
    DamageMultiplier = 1.15,
    CritChance = 0.06,
    CritMultiplier = 1.6,
    AttackSpeed = 1,
    TurnCount = 4,
    Range = 25,
    HitboxSize = Vector3.new(20, 10, 25),
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.2,
    DodgeVelocity = 90,
    DodgeDuration = 0.3,
    DodgeCooldown = 2.1,
    DodgeIFrameDuration = 0.65,
    ParryDuration = 0.65,
    ParryCooldown = 1.8,
    ParrySuccessCooldown = 0.5,
    Skills = { "Mirage Chase", "Spatial Divide", "Sky Crash", "Lunar Phase", "(Lv. 13 Passive) Summoned Sword" },
    UtilitySkill = "",
    Ultimate = "Lunar Eclipse",
    UltimateMeterCost = 100,
    SkillInfo = {
        [1] = {
            Description = "Two charges. An invulnerable four-strike dash that cleaves through enemies in a wide arc, trailing afterimage clones. Cast airborne, altitude freezes for a flat air-dash.",
            TotalMultiplier = 5,
            Protection = "iFrame"
        },
        [2] = {
            Description = "Three charges. Tap: a wide spatial slash — a directional dash into a heavy cleave. Hold: an air-lift — launch skyward and hang suspended, striking as you rise.",
            TotalMultiplier = 1.8
        },
        [3] = {
            Description = "A spatial crash with two forms. On the ground, dash in and strike; airborne, dive down-and-forward into a three-hit crash.",
            TotalMultiplier = 4.8
        },
        [4] = {
            Description = "A directional dash into a devastating six-strike barrage each cut drives forward with blinding speed, the sixth landing a thunderous finisher.",
            TotalMultiplier = 5
        },
        E = {
            Description = "ULTIMATE — Lunar Eclipse: the full-charge Judgement Cut. Flicker-steps into a frozen stance, then sheathes to detonate a massive space-splitting burst. Cast with G once the meter is full.",
            TotalMultiplier = 28
        },
        [5] = {
            Description = "Summoned Sword: basic attacks have a 50% chance to summon a phantom blade above each struck enemy. After a brief delay, every blade strikes its target for 190% damage."
        }
    },
    StationarySkills = {
        [1] = false,
        [2] = false,
        [3] = false,
        [4] = false,
        E = true
    },
    NoKnockbackSkills = {
        [1] = true,
        [3] = true,
        [4] = true,
        E = true
    },
    SwingSoundFolder = "Power_Swing_Fast",
    SwingSoundOrder = { "Power_Swing_Fast", "Power_Swing_Fast", "Power_Swing_Fast", "Sukuna" },
    HitSoundFolder = "Hit",
    FX_Order = {},
    ForgeVFX = true,
    AnimationOverrides = {
        idle = "rbxassetid://87511690849407",
        run = "rbxassetid://78988120608596"
    },

    OnSwing = function(p4, p5) -- Line: 605, Name: OnSwing
        local Character = p4.Character;

        if not Character then
            return;
        end;

        local v6 = Character:FindFirstChild("Right_Arm", true) and Character:FindFirstChild("Right_Arm", true):FindFirstChild("SwordMain");
        local v7 = Character:FindFirstChild("Left_Arm", true) and Character:FindFirstChild("Left_Arm", true):FindFirstChild("SwordMain");

        if not (v6 and v7) then
            return;
        end;

        v6.Transparency = 0;

        for _, child in v6:GetChildren() do
            if child:IsA("BasePart") then
                child.Transparency = 0;
            end;
        end;

        v7.Transparency = 1;

        for _, child in v7:GetChildren() do
            if child:IsA("BasePart") then
                child.Transparency = 1;
            end;
        end;
    end,

    OnSwingEnd = function(p8, p9) -- Line: 625, Name: OnSwingEnd
        local Character = p8.Character;

        if not Character then
            return;
        end;

        local v10 = Character:FindFirstChild("Right_Arm", true) and Character:FindFirstChild("Right_Arm", true):FindFirstChild("SwordMain");
        local v11 = Character:FindFirstChild("Left_Arm", true) and Character:FindFirstChild("Left_Arm", true):FindFirstChild("SwordMain");

        if not (v10 and v11) then
            return;
        end;

        v10.Transparency = 1;

        for _, child in v10:GetChildren() do
            if child:IsA("BasePart") then
                child.Transparency = 1;
            end;
        end;

        v11.Transparency = 0;

        for _, child in v11:GetChildren() do
            if child:IsA("BasePart") then
                child.Transparency = 0;
            end;
        end;
    end
} do
    table_clone_ret3[i] = v;
end;

u3["Awakened Devil EX"] = table_clone_ret3;
local u12 = {};
local u13 = {};

local function getDefinitionModule(p14: userdata) -- Line: 678
    local Definition = p14:FindFirstChild("Definition");

    if Definition and Definition:IsA("ModuleScript") then
        return Definition;
    end;

    return nil;
end;

local function findDefinitionModule(p15: string) -- Line: 687
    -- upvalues: script_Parent (copy)
    local v16 = script_Parent:FindFirstChild(p15);

    if not (v16 and v16:IsA("Folder")) then
        return nil;
    end;

    local Definition = v16:FindFirstChild("Definition");

    if Definition and Definition:IsA("ModuleScript") then
        return Definition;
    end;

    return nil;
end;

local function resolve(p17: string) -- Line: 697
    -- upvalues: u13 (copy), u3 (copy), script_Parent (copy), u1 (copy)
    local v18 = u13[p17];

    if v18 then
        return v18;
    end;

    local v19 = u3[p17];

    if not v19 then
        local v20 = script_Parent:FindFirstChild(p17);
        local v21;

        if v20 and v20:IsA("Folder") then
            v21 = v20:FindFirstChild("Definition");

            if not (v21 and v21:IsA("ModuleScript")) then
                v21 = nil;
            end;
        else
            v21 = nil;
        end;

        if v21 then
            local success, result = pcall(require, v21);

            if success and type(result) == "table" then
                local table_clone_ret4 = table.clone(u1);

                for i, v in result do
                    table_clone_ret4[i] = v;
                end;

                u13[p17] = table_clone_ret4;

                return table_clone_ret4;
            end;

            warn((`[Class_Data] Definition module for "{p17}" failed to load: {tostring(result)}`));
        end;

        return nil;
    end;

    local v22 = script_Parent:FindFirstChild(p17);
    local v23;

    if v22 and v22:IsA("Folder") then
        v23 = v22:FindFirstChild("Definition");

        if not (v23 and v23:IsA("ModuleScript")) then
            v23 = nil;
        end;
    else
        v23 = nil;
    end;

    if v23 then
        warn((`[Class_Data] "{p17}" has both an INLINE entry and a Definition module — INLINE wins; delete one of the two.`));
    end;

    u13[p17] = v19;

    return v19;
end;

function u12.Get(p24: string) -- Line: 729
    -- upvalues: resolve (copy)
    return resolve(p24);
end;

function u12.GetAllClassNames() -- Line: 734
    -- upvalues: u3 (copy), script_Parent (copy)
    local v25 = {};

    for i in u3 do
        table.insert(v25, i);
    end;

    for _, child in script_Parent:GetChildren() do
        if child:IsA("Folder") and u3[child.Name] == nil then
            local Definition = child:FindFirstChild("Definition");

            if not (Definition and Definition:IsA("ModuleScript")) then
                Definition = nil;
            end;

            if Definition then
                table.insert(v25, child.Name);
            end;
        end;
    end;

    return v25;
end;

function u12.Exists(p26: string) -- Line: 748
    -- upvalues: resolve (copy)
    return resolve(p26) ~= nil;
end;

function u12.GetClassFolder(p27: string) -- Line: 753
    -- upvalues: script_Parent (copy)
    return script_Parent:FindFirstChild(p27);
end;

function u12.GetClassesByRarity(p28: string) -- Line: 758
    -- upvalues: u12 (copy), resolve (copy)
    local v29 = {};

    for _, v in u12.GetAllClassNames() do
        local v30 = resolve(v);

        if v30 and v30.Rarity == p28 then
            table.insert(v29, v);
        end;
    end;

    return v29;
end;

function u12.GetSummonableClassesByRarity(p31: string) -- Line: 770
    -- upvalues: u12 (copy), resolve (copy)
    local v32 = {};

    for _, v in u12.GetAllClassNames() do
        local v33 = resolve(v);

        if v33 and (v33.Rarity == p31 and v33.Summonable ~= false) then
            table.insert(v32, v);
        end;
    end;

    return v32;
end;

function u12.GetRarity(p34: string) -- Line: 782
    -- upvalues: resolve (copy)
    local v35 = resolve(p34);

    if v35 then
        return v35.Rarity;
    end;

    return nil;
end;

setmetatable(u12, {
    __index = function(p36, p37) -- Line: 792, Name: __index
        -- upvalues: resolve (copy)
        if type(p37) == "string" then
            return resolve(p37);
        end;

        return nil;
    end,

    __iter = function() -- Line: 801, Name: __iter
        -- upvalues: u12 (copy), resolve (copy)
        local AllClassNames = u12.GetAllClassNames();
        local u38 = 0;

        return function() -- Line: 804
            -- upvalues: u38 (ref), AllClassNames (copy), resolve (ref)
            while true do
                u38 = u38 + 1;
                local v39 = AllClassNames[u38];

                if v39 == nil then
                    break;
                end;

                local v40 = resolve(v39);

                if v40 ~= nil then
                    return v39, v40;
                end;
            end;

            return nil;
        end;
    end
});

return u12;