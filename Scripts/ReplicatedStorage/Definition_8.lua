--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Classes.Anti Magic.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:47 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Anti Magic",
    Description = "A magicless warrior who wields a claymore of pure anti-magic. He cannot cast spells what he can do is swing hard enough to erase them. Grit, sweat, and a blade that drinks the impossible.",
    Rarity = "Exotic",
    Summonable = false,
    BaseStats = {
        STR = 15,
        DEX = 0,
        VIT = 14,
        INT = 0,
        LCK = 11
    },
    DamageType = "Physical",
    DamageMultiplier = 1.15,
    CritChance = 0.04,
    CritMultiplier = 1.6,
    AttackSpeed = 1,
    TurnCount = 4,
    ComboEndlag = 0.3,
    DirectionalLunge = true,
    DirectionalLungeStrength = 2.2,
    Range = 26,
    HitboxSize = Vector3.new(23, 10, 28),
    DodgeVelocity = 80,
    DodgeDuration = 0.3,
    DodgeCooldown = 2.5,
    DodgeIFrameDuration = 0.6,
    ParryDuration = 0.65,
    ParryCooldown = 2,
    ParrySuccessCooldown = 0.6,
    Skills = { "Black Hurricane", "Twelve-Fold Cleave", "Black Divider", "Black Divider Final" },
    UtilitySkill = "",
    SkillInfo = { {
            Description = "A whirling three-hit cleave with massive reach. Stationary commitment no dash, no defensive frames, pure damage.",
            TotalMultiplier = 5
        }, {
            Description = "A rapid twelve-hit slash combo nine flowing strikes into a three-hit simultaneous burst finisher. Stationary commitment, parry frame holds through the entire skill.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "Three heavy power-strike cleaves with a brief parry window opening on each hit. The third strike lands with crushing force and stuns enemies for 3 seconds.",
            TotalMultiplier = 5,
            Protection = "Parry"
        }, {
            Description = "Black Divider Final. A single crushing downward swing summons a massive vertical anti-magic slash that travels forward, cleaving everything in its path with continuous damage for 4 seconds.",
            TotalMultiplier = 5
        } },
    StationarySkills = { false, true, true, true },
    NoKnockbackSkills = { true, true, true, true },
    SwingSoundFolder = "Power_Swing_2",
    HitSoundFolder = "Hit",
    Motor6D_Overrides = {
        WHilt = {
            Part0 = "Right Arm"
        }
    },
    FX_Order = { "Right_Slash", "Left_Slash", "Right_Slash", "Left_Slash" },
    AnimationOverrides = {
        idle = "rbxassetid://72080662146225",
        run = "rbxassetid://116531531279085"
    },
    UseHeat = true,
    HeatMax = 100,
    HeatActivationPct = 1,
    HeatPerHit = 0.8,
    HeatPerSkill = 6,
    HeatDecayDelay = 5,
    HeatDecayRate = 0,
    HeatActiveDecayRate = 2,
    HeatNoGainWhileActive = true,
    HeatRunUntilDepleted = true,
    HeatPostDepleteCooldown = 30,
    HeatBonuses = { {
            Stat = "DamageMultiplier",
            Value = 0.3
        }, {
            Stat = "AttackSpeed",
            Value = 0.3
        }, {
            Stat = "CDR",
            Value = 0.25
        } },

    OnHeatActivate = function(p1) -- Line: 109, Name: OnHeatActivate
        local Character = p1.Character;

        if not Character then
            return;
        end;

        local Holder = Character:FindFirstChild("Holder", true);

        if not Holder then
            return;
        end;

        local Left_Arm = Holder:FindFirstChild("Left_Arm");

        if Left_Arm then
            Left_Arm = Left_Arm:FindFirstChild("LeftSword");
        end;

        if Left_Arm then
            if Left_Arm:IsA("BasePart") then
                Left_Arm.Transparency = 0;
            end;

            for _, child in Left_Arm:GetChildren() do
                if child:IsA("MeshPart") then
                    child.Transparency = 0;
                end;
            end;
        end;

        local Torso = Holder:FindFirstChild("Torso");

        if Torso then
            Torso = Torso:FindFirstChild("Wing");
        end;

        if Torso then
            if Torso:IsA("BasePart") then
                Torso.Transparency = 0;
            end;

            local v2 = Torso:FindFirstChildOfClass("Highlight");

            if v2 then
                v2.Enabled = true;
            end;

            Torso:SetAttribute("FX_Activate", true);
        end;
    end,

    OnHeatDeactivate = function(p3) -- Line: 145, Name: OnHeatDeactivate
        local Character = p3.Character;

        if not Character then
            return;
        end;

        local Holder = Character:FindFirstChild("Holder", true);

        if not Holder then
            return;
        end;

        local Left_Arm = Holder:FindFirstChild("Left_Arm");

        if Left_Arm then
            Left_Arm = Left_Arm:FindFirstChild("LeftSword");
        end;

        if Left_Arm then
            if Left_Arm:IsA("BasePart") then
                Left_Arm.Transparency = 1;
            end;

            for _, child in Left_Arm:GetChildren() do
                if child:IsA("MeshPart") then
                    child.Transparency = 1;
                end;
            end;
        end;

        local Torso = Holder:FindFirstChild("Torso");

        if Torso then
            Torso = Torso:FindFirstChild("Wing");
        end;

        if Torso then
            if Torso:IsA("BasePart") then
                Torso.Transparency = 1;
            end;

            local v4 = Torso:FindFirstChildOfClass("Highlight");

            if v4 then
                v4.Enabled = false;
            end;

            Torso:SetAttribute("FX_Activate", false);
        end;
    end
};