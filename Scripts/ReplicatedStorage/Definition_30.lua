--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Forge Archon.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:58 2026
]]

-- Decompiled with Potassium's decompiler.

local function findBowParts(p1) -- Line: 16
    if not p1 then
        return nil, nil, nil;
    end;

    local Left_Arm = p1:FindFirstChild("Left_Arm", true);
    local Right_Arm = p1:FindFirstChild("Right_Arm", true);

    if Left_Arm and Right_Arm then
        return Left_Arm:FindFirstChild("Bow"), Left_Arm:FindFirstChild("LeftSword"), Right_Arm:FindFirstChild("RightSword");
    end;

    return nil, nil, nil;
end;

local function fireBow(p2) -- Line: 25
    if p2 then
        p2:SetAttribute("Fire", not p2:GetAttribute("Fire"));
    end;
end;

local function setModeVisual(p3, p4) -- Line: 33
    -- upvalues: findBowParts (copy)
    local v5, v6, v7 = findBowParts(p3.Character);

    for _, v in { v6, v7 } do
        if v then
            v.Transparency = p4 and 1 or 0;

            for _, child in v:GetChildren() do
                if child:IsA("BasePart") then
                    child.Transparency = p4 and 1 or 0;
                end;
            end;
        end;
    end;

    if v5 then
        v5.Transparency = p4 and 0 or 1;

        if v5 then
            v5:SetAttribute("Fire", not v5:GetAttribute("Fire"));
        end;
    end;
end;

return {
    Name = "Forge Archon",
    Description = "A nameless blade smith who projects an endless arsenal from memory. Twin swords materialize and shatter with each strike every weapon he wields is a copy, and every copy is a masterpiece.",
    Rarity = "Celestial",
    BaseStats = {
        STR = 2,
        DEX = 14,
        VIT = 2,
        INT = 11,
        LCK = 1
    },
    DamageType = "Ranged",
    DamageMultiplier = 1,
    CritChance = 0.06,
    CritMultiplier = 1.7,
    AttackSpeed = 1.1,
    TurnCount = 5,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.4,
    Range = 16,
    HitboxSize = Vector3.new(15, 10, 17),
    ForgeVFX = true,
    SpecialMovesetLegacyFX = true,
    HitboxSizeOrder = {
        [5] = Vector3.new(13, 10, 35)
    },
    RangeOrder = {
        [5] = 27
    },
    SpecialTurnCount = 4,
    SpecialSwingSoundFolder = "Bow_Shot3",
    SpecialRangeBonus = 10,
    DodgeVelocity = 90,
    DodgeDuration = 0.35,
    DodgeCooldown = 1.8,
    DodgeIFrameDuration = 0.75,
    ParryDuration = 0.55,
    ParryCooldown = 2,
    Skills = { "Twin Projection", "Crane Wing", "Hrunting", "Supreme Cell Blades" },
    UtilitySkill = "",
    SkillInfo = { {
            Description = "Traces a greatsword and looses a single cross-shaped slash that carves forward, tearing through everything in its path.",
            TotalMultiplier = 4
        }, {
            Description = "A heavy opening slash erupts into a rising blade-tornado, lifting the Archon skyward as a storm of traced swords shreds all around. Parry active as the tornado forms.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "Snaps skyward (or strikes in place if already airborne), charging a projected blade before crashing down a devastating strike. Dodge on cast and on the leap.",
            TotalMultiplier = 4,
            Protection = "Dodge"
        }, {
            Description = "Three sweeping strikes carve massive arcs left and right, stepping in your input direction on every blow. Each traced blade parries as it lands the Archon\'s strongest sequence.",
            TotalMultiplier = 5,
            Protection = "Parry"
        } },
    StationarySkills = { true, true, false, true },
    NoKnockbackSkills = {
        [2] = true,
        [4] = true
    },
    SwingSoundOrder = { "Maewha", "Maewha", "Ninja", "Ninja", "Maewha" },
    SwingSoundFolder = "Ninja",
    HitSoundFolder = "Hit",
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Right_Slash", "Left_Slash" },

    OnSwing = function(p8, p9) -- Line: 145, Name: OnSwing
        -- upvalues: findBowParts (copy)
        local v10 = (p8.SpecialMoveset or 0) > 0 and findBowParts(p8.Character);

        if v10 then
            v10:SetAttribute("Fire", not v10:GetAttribute("Fire"));
        end;
    end,

    EnterBowMode = function(p11) -- Line: 156, Name: EnterBowMode
        -- upvalues: setModeVisual (copy)
        p11.SpecialMoveset = 1;
        p11.TurnCount = 1;
        p11._animHitIndex = 0;
        setModeVisual(p11, true);
    end,

    EnterMeleeMode = function(p12) -- Line: 163, Name: EnterMeleeMode
        -- upvalues: setModeVisual (copy)
        p12.SpecialMoveset = 0;
        p12.TurnCount = 1;
        p12._animHitIndex = 0;
        setModeVisual(p12, false);
    end
};