--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Unrestricted.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local function setModeVisual(p1, p2) -- Line: 18
    local ClassPrefab = p1.ClassPrefab;

    if ClassPrefab then
        ClassPrefab = ClassPrefab:FindFirstChild("Right_Arm");
    end;

    if not ClassPrefab then
        return;
    end;

    local Sword = ClassPrefab:FindFirstChild("Sword");
    local Spear = ClassPrefab:FindFirstChild("Spear");

    if Sword then
        Sword.Transparency = p2 and 1 or 0;

        for _, child in ipairs(Sword:GetChildren()) do
            if child:IsA("MeshPart") then
                child.Transparency = p2 and 1 or 0;
            end;
        end;
    end;

    if Spear then
        Spear.Transparency = p2 and 0 or 1;

        for _, child in ipairs(Spear:GetChildren()) do
            if child:IsA("MeshPart") then
                child.Transparency = p2 and 0 or 1;
            end;
        end;
    end;

    local function setFX(p3, p4) -- Line: 37
        if not p3 then
            return;
        end;

        for _, descendant in ipairs(p3:GetDescendants()) do
            if descendant:IsA("Trail") or descendant:IsA("Beam") then
                descendant.Enabled = p4;
            end;
        end;
    end;

    setFX(Sword, not p2);
    setFX(Spear, p2);
end;

return {
    Name = "Unrestricted",
    Description = "A sorcerer killer born without cursed energy. He wields the Inverted Spear of Heaven with brutal physical mastery in his hands, a chain is a death sentence.",
    Rarity = "Celestial",
    Summonable = false,
    BaseStats = {
        STR = 13,
        DEX = 13,
        VIT = 14,
        INT = 0,
        LCK = 0
    },
    DamageType = "Physical",
    DamageMultiplier = 1.15,
    CritChance = 0.05,
    CritMultiplier = 1.6,
    AttackSpeed = 1.1,
    TurnCount = 4,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.5,
    Range = 23,
    HitboxSize = Vector3.new(20, 20, 25),
    DodgeVelocity = 90,
    DodgeDuration = 0.3,
    DodgeCooldown = 1.8,
    DodgeIFrameDuration = 0.7,
    ParryDuration = 0.6,
    ParryCooldown = 2,
    ParrySuccessCooldown = 0.6,
    Skills = { "Killer Cadence", "Killer Instinct", "Domain Shatter", "Tool Swap" },
    UtilitySkill = "",
    SkillInfo = { {
            Description = "Killer Cadence — Sword: a single, devastating hard slash. Spear: a seven-hit slashing barrage over a wide area with a gentle dash between strikes.",
            TotalMultiplier = 5,
            Protection = "None"
        }, {
            Description = "Killer Instinct — Sword: a stationary counter that unleashes a high-speed flurry with parry held throughout. Spear: leap and blink behind the nearest enemy, then land a heavy frontal strike.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "Domain Shatter — Sword: a blindingly fast barrage that strikes from every angle. Spear: a sustained three-second onslaught in a massive radius with parry held throughout.",
            TotalMultiplier = 6,
            Protection = "Parry"
        }, {
            Description = "Tool Swap — a spinning dash that swaps between Sword and Spear, cutting through anything in the way. Parry on cast.",
            TotalMultiplier = 3,
            Protection = "Parry"
        } },
    StationarySkills = { false, true, true, false },
    NoKnockbackSkills = {
        [2] = true,
        [3] = true
    },
    SwingSoundFolder = "Hard_Slash",
    HitSoundFolder = "Hit",
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    Motor6D_Overrides = {
        Dagger = {
            Part0 = "Right Arm"
        }
    },
    AnimationOverrides = {
        idle = "rbxassetid://87511690849407"
    },
    ForgeVFX = true,
    SpecialTurnCount = 4,

    GetCooldownMode = function(p5) -- Line: 126, Name: GetCooldownMode
        return (p5.SpecialMoveset or 0) > 0 and "Spear" or "Sword";
    end,

    ToggleWeaponMode = function(p6) -- Line: 130, Name: ToggleWeaponMode
        -- upvalues: setModeVisual (copy)
        local v7 = (p6.SpecialMoveset or 0) <= 0;
        p6.SpecialMoveset = v7 and 1 or 0;
        p6.TurnCount = 1;
        p6._animHitIndex = 0;
        local Character = p6.Character;

        if Character then
            Character:SetAttribute("M1Mode", v7 and "Spear" or "Sword");
        end;

        setModeVisual(p6, v7);

        if p6.RefreshCooldownDisplay then
            p6:RefreshCooldownDisplay();
        end;
    end
};