--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Azure Devil.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Azure Devil",
    Description = "A demonic swordsman who wields twin blades with blinding speed, swapping hands between every strike. Power demands patience his devastating techniques carry punishing cooldowns.",
    Rarity = "Celestial",
    BaseStats = {
        STR = 13,
        DEX = 12,
        VIT = 5,
        INT = 6,
        LCK = 4
    },
    DamageType = "Physical",
    DamageMultiplier = 1.1,
    CritChance = 0.06,
    CritMultiplier = 1.6,
    AttackSpeed = 1.35,
    TurnCount = 4,
    Range = 19,
    HitboxSize = Vector3.new(15, 10, 19),
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.3,
    DodgeVelocity = 90,
    DodgeDuration = 0.3,
    DodgeCooldown = 1.8,
    DodgeIFrameDuration = 0.65,
    ParryDuration = 0.6,
    ParryCooldown = 1.8,
    ParrySuccessCooldown = 0.5,
    Skills = { "Spatial Cut", "Cross Cut", "Void Cleave", "Judgement Rush", "(Lv. 13 Passive) Phantom Strikes" },
    UtilitySkill = "",
    SkillInfo = { {
            Description = "Three-charge spatial slash with a massive wide hitbox, dashing in your movement direction on each cut.",
            TotalMultiplier = 1.8
        }, {
            Description = "Invulnerable forward dash that cleaves through enemies three times in a wide arc, trailing cyan shadow clones.",
            TotalMultiplier = 4.5,
            Protection = "Dodge"
        }, {
            Description = "Rapid twelve-hit flurry across a massive wide arc. No protections, pure damage.",
            TotalMultiplier = 5
        }, {
            Description = "Channels a relentless storm of slashes, then finishes with two heavy strikes. The class\'s strongest technique.",
            TotalMultiplier = "Variable"
        }, {
            Description = "When combo exceeds 100 hits, basic attacks have a 35% chance to summon a phantom clone that repeats the strike for 110% damage."
        } },
    StationarySkills = { false, false, true, true },
    NoKnockbackSkills = {
        [2] = true,
        [3] = true,
        [4] = true
    },
    SwingSoundFolder = "Corsair_A",
    HitSoundFolder = "Hit",
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://79157534199452",
        run = "rbxassetid://78988120608596"
    },
    SwingSoundOrder = { "Corsair_A", "Corsair_A", "Power_Swing_Fast", "Power_Swing_Fast" },

    OnSwing = function(p1, p2) -- Line: 76, Name: OnSwing
        local Character = p1.Character;

        if not Character then
            return;
        end;

        local v3 = Character:FindFirstChild("Right_Arm", true) and Character:FindFirstChild("Right_Arm", true):FindFirstChild("SwordMain");
        local v4 = Character:FindFirstChild("Left_Arm", true) and Character:FindFirstChild("Left_Arm", true):FindFirstChild("SwordMain");

        if not (v3 and v4) then
            return;
        end;

        v3.Transparency = 0;

        for _, child in v3:GetChildren() do
            if child:IsA("BasePart") then
                child.Transparency = 0;
            end;
        end;

        v4.Transparency = 1;

        for _, child in v4:GetChildren() do
            if child:IsA("BasePart") then
                child.Transparency = 1;
            end;
        end;
    end,

    OnSwingEnd = function(p5, p6) -- Line: 96, Name: OnSwingEnd
        local Character = p5.Character;

        if not Character then
            return;
        end;

        local v7 = Character:FindFirstChild("Right_Arm", true) and Character:FindFirstChild("Right_Arm", true):FindFirstChild("SwordMain");
        local v8 = Character:FindFirstChild("Left_Arm", true) and Character:FindFirstChild("Left_Arm", true):FindFirstChild("SwordMain");

        if not (v7 and v8) then
            return;
        end;

        v7.Transparency = 1;

        for _, child in v7:GetChildren() do
            if child:IsA("BasePart") then
                child.Transparency = 1;
            end;
        end;

        v8.Transparency = 0;

        for _, child in v8:GetChildren() do
            if child:IsA("BasePart") then
                child.Transparency = 0;
            end;
        end;
    end
};