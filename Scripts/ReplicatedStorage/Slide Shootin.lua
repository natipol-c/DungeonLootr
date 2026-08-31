--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Slide Shootin
  Path:     game.ReplicatedStorage.Weapons.Weapon_Skills.Slide Shootin
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:08 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local Enemy_Manager = require(ReplicatedStorage.Enemies.Modules.Enemy_Manager);
u1.DefaultCooldown = 12;
u1.ManagesCooldown = true;
u1.MaxCharges = 5;
u1.ChargeCooldown = 0.4;
u1.ChargeExpiry = 3;
u1.SlideDuration = 0.25;
u1.SlideVelocity = 60;
u1.IFrameDuration = 0.35;
u1.DamageMultiplier = 1;
u1.HitboxSize = Vector3.new(12, 8, 14);
u1.CloneFadeDuration = 0.5;
u1.StartSound = "SideShootin_Start";
u1.SlashSound = "SideShootin_Shot";
u1.EndSound = "SideShootin_End";
local ShadowDash = ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

local function FireParticles(p2: userdata) -- Line: 66
    if not p2:HasTag("ParticleObject") then
        p2:AddTag("ParticleObject");
    end;

    p2:SetAttribute("Fire", not p2:GetAttribute("Fire"));
end;

local function PlayTurnFX(p3, p4) -- Line: 73
    local v5 = p3.FX[p4];

    if not v5 then
        warn("SideShootin: Missing FX part: " .. tostring(p4));

        return;
    end;

    if not v5:HasTag("ParticleObject") then
        v5:AddTag("ParticleObject");
    end;

    v5:SetAttribute("Fire", not v5:GetAttribute("Fire"));
end;

local Combat_Sounds = ReplicatedStorage.Assets:WaitForChild("Combat_Sounds");
local u6 = {};

local function GetSoundsFromFolder(p7) -- Line: 85
    -- upvalues: u6 (copy), Combat_Sounds (copy)
    if u6[p7] then
        return u6[p7];
    end;

    local v8 = Combat_Sounds:FindFirstChild(p7);

    if v8 then
        u6[p7] = v8:GetChildren();

        return u6[p7];
    end;

    warn("Combat sound folder not found:", p7);

    return {};
end;

local function PlayCombatSound(p9, p10, p11) -- Line: 95
    -- upvalues: GetSoundsFromFolder (copy)
    local v12 = GetSoundsFromFolder(p9);

    if #v12 == 0 then
        return;
    end;

    local u13 = v12[math.random(1, #v12)]:Clone();
    u13.PlaybackSpeed = 1 + (math.random() * 2 - 1) * 0.35;
    u13.Volume = p11 or 1;
    u13.Parent = p10;
    u13:Play();
    u13.Ended:Once(function() -- Line: 103
        -- upvalues: u13 (copy)
        u13:Destroy();
    end);
end;

function u1.CanActivate(p14) -- Line: 112
    if p14.Is_Dodging then
        return false, "Currently dodging";
    end;

    if p14.Is_Stunned then
        return false, "Stunned";
    end;

    if p14._SideShootin_Charges and p14._SideShootin_Charges > 0 then
        if p14._SideShootin_AnimPlaying then
            return false, "Animation in progress";
        end;

        return true;
    end;

    if p14.Is_Attacking then
        return false, "Already attacking";
    end;

    if p14.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    return true;
end;

function u1.Activate(u15) -- Line: 135
    -- upvalues: u1 (copy), SharedUtils (copy)
    local Player = u15.Player;
    local Character = Player.Character;
    local u16;

    if Character then
        u16 = Character:FindFirstChild("HumanoidRootPart");
    else
        u16 = Character;
    end;

    local v17;

    if Character then
        v17 = Character:FindFirstChild("Humanoid");
    else
        v17 = Character;
    end;

    if not (u16 and v17) then
        return;
    end;

    local Skill = u15.Wep_Data.Skill;
    local v18 = not u15._SideShootin_Charges or u15._SideShootin_Charges == 0;
    Character:SetAttribute("Skill_Attack_Bypass", true);

    if v18 then
        u15._SideShootin_Charges = u1.MaxCharges;
        u15._SideShootin_ExpiryToken = tick();
        Player:SetAttribute("Skill_Charges", u1.MaxCharges);
        u1._EnsureAnimations(u15);
        pcall(function() -- Line: 159
            -- upvalues: SharedUtils (ref), u16 (copy), u1 (ref)
            SharedUtils.PlaySoundAt(u16, u1.StartSound, 0.8);
        end);
    end;

    u15._SideShootin_Charges = u15._SideShootin_Charges - 1;
    local _SideShootin_Charges = u15._SideShootin_Charges;
    Player:SetAttribute("Skill_Charges", _SideShootin_Charges);
    u1._ExecuteCharge(u15, u16, v17, _SideShootin_Charges);

    if _SideShootin_Charges <= 0 then
        Character:SetAttribute("Skill_Attack_Bypass", false);
        pcall(function() -- Line: 202
            -- upvalues: SharedUtils (ref), u16 (copy), u1 (ref)
            SharedUtils.PlaySoundAt(u16, u1.EndSound, 0.8);
        end);
        u1._StartFullCooldown(u15, Skill);

        return;
    end;

    u15.Skill_Cooldowns[Skill] = os.clock() + u1.ChargeCooldown;
    Player:SetAttribute("Skill_OnCooldown", true);
    Player:SetAttribute("Skill_Cooldown_Duration", u1.ChargeCooldown);
    Player:SetAttribute("Skill_CooldownEnd", os.clock() + u1.ChargeCooldown);
    task.delay(u1.ChargeCooldown, function() -- Line: 181
        -- upvalues: u15 (copy), Player (copy)
        if u15._SideShootin_Charges and (u15._SideShootin_Charges > 0 and Player) then
            Player:SetAttribute("Skill_OnCooldown", false);
        end;
    end);
    local u19 = tick();
    u15._SideShootin_ExpiryToken = u19;
    task.delay(u1.ChargeExpiry, function() -- Line: 193
        -- upvalues: u15 (copy), u19 (copy), u1 (ref), Skill (copy), Character (copy)
        if u15._SideShootin_ExpiryToken ~= u19 then
            return;
        end;

        if not u15._SideShootin_Charges or u15._SideShootin_Charges <= 0 then
            return;
        end;

        u1._ForceExpire(u15, Skill);
        Character:SetAttribute("Skill_Attack_Bypass", false);
    end);
end;

function u1._EnsureAnimations(p20) -- Line: 214
    -- upvalues: ReplicatedStorage (copy)
    local v21 = p20.Character and p20.Character:FindFirstChild("Humanoid") and p20.Character.Humanoid:FindFirstChild("Animator");

    if not v21 then
        warn("SideShootin: No Animator found");

        return;
    end;

    local v22 = ReplicatedStorage.Weapons:FindFirstChild("Lucky Revolvers");

    if not v22 then
        warn("SideShootin: Lucky Revolvers weapon folder not found");

        return;
    end;

    local Animations = v22:FindFirstChild("Animations");

    if not Animations then
        warn("SideShootin: Animations folder not found");

        return;
    end;

    if not p20.Animations.SideShootin_Ability then
        local Ability = Animations:FindFirstChild("Ability");

        if Ability then
            local v23 = v21:LoadAnimation(Ability);
            v23.Priority = Enum.AnimationPriority.Action3;
            p20.Animations.SideShootin_Ability = v23;
        else
            warn("SideShootin: Ability animation not found in Lucky Revolvers");
        end;
    end;

    if not p20.Animations.SideShootin_Dodge then
        local Dodge = Animations:FindFirstChild("Dodge");

        if Dodge then
            local v24 = v21:LoadAnimation(Dodge);
            v24.Priority = Enum.AnimationPriority.Action2;
            p20.Animations.SideShootin_Dodge = v24;

            return;
        end;

        warn("SideShootin: Dodge animation not found in Lucky Revolvers");
    end;
end;

function u1._ExecuteCharge(u25, u26, p27, u28) -- Line: 265
    -- upvalues: PlayCombatSound (copy), SharedUtils (copy), u1 (copy), ShadowDash (copy), Debris (copy)
    local Player = u25.Player;
    local Character = u25.Character;
    local MoveDirection = p27.MoveDirection;
    local v29;

    if MoveDirection.Magnitude < 0.1 then
        v29 = u26.CFrame.LookVector;
    else
        v29 = MoveDirection.Unit;
    end;

    u25.Is_Using_Skill = true;
    u25.Is_Attacking = true;
    u25._SideShootin_AnimPlaying = true;
    Player:SetAttribute("Protected", true);
    Player:SetAttribute("iFrame", true);
    Character:SetAttribute("Protected", true);
    Character:SetAttribute("iFrame", true);

    for i, v in u25.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.1);
        end;
    end;

    local SideShootin_Ability = u25.Animations.SideShootin_Ability;
    local SideShootin_Dodge = u25.Animations.SideShootin_Dodge;

    if not SideShootin_Ability then
        warn("SideShootin: Ability animation not loaded");
        u25.Is_Using_Skill = false;
        u25.Is_Attacking = false;
        u25._SideShootin_AnimPlaying = false;

        return;
    end;

    SideShootin_Ability:Play(0, 1, 1);

    if SideShootin_Dodge then
        SideShootin_Dodge:Play(0, 1, 1);
    end;

    local u32 = SideShootin_Ability:GetMarkerReachedSignal("hit"):Connect(function(p30) -- Line: 315
        -- upvalues: PlayCombatSound (ref), u25 (copy), Character (copy), SharedUtils (ref), u26 (copy), u1 (ref), ShadowDash (ref), Player (copy), u28 (copy)
        PlayCombatSound(u25.Wep_Data.SwingSoundFolder or "Gunshot", Character.HumanoidRootPart, u25.Wep_Data.SwingVolume or 0.5);

        if p30 and p30 ~= "" then
            local v31 = u25.FX[p30];

            if v31 then
                if not v31:HasTag("ParticleObject") then
                    v31:AddTag("ParticleObject");
                end;

                v31:SetAttribute("Fire", not v31:GetAttribute("Fire"));
            else
                warn("SideShootin: Missing FX part: " .. tostring(p30));
            end;
        end;

        pcall(function() -- Line: 328
            -- upvalues: SharedUtils (ref), u26 (ref), u1 (ref)
            SharedUtils.PlaySoundAt(u26, u1.SlashSound, 0.6);
        end);

        if ShadowDash then
            ShadowDash:FireAllClients(Player, {
                Action = "Clone",
                FadeDuration = u1.CloneFadeDuration,
                ChargesRemaining = u28,
                Color = Color3.fromRGB(255, 196, 101)
            });
        end;

        u1._PerformHit(u25);
    end);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SideShootinVelocity";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v29 * u1.SlideVelocity;
    BodyVelocity.Parent = u26;
    Debris:AddItem(BodyVelocity, u1.SlideDuration);
    SideShootin_Ability.Stopped:Once(function() -- Line: 356
        -- upvalues: u32 (ref), SideShootin_Dodge (copy), u25 (copy)
        if u32 then
            u32:Disconnect();
            u32 = nil;
        end;

        if SideShootin_Dodge and SideShootin_Dodge.IsPlaying then
            SideShootin_Dodge:Stop(0.15);
        end;

        u25._SideShootin_AnimPlaying = false;
        u25.Is_Attacking = false;

        if not u25._SideShootin_Charges or u25._SideShootin_Charges <= 0 then
            u25.Is_Using_Skill = false;
        end;
    end);
    task.delay(u1.IFrameDuration, function() -- Line: 376
        -- upvalues: u25 (copy), Player (copy), Character (copy)
        if not u25.Is_Dodging then
            Player:SetAttribute("Protected", false);
            Player:SetAttribute("iFrame", false);
            Character:SetAttribute("Protected", false);
            Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay((SideShootin_Ability.Length > 0 and SideShootin_Ability.Length or 1) + 0.5, function() -- Line: 387
        -- upvalues: u32 (ref), SideShootin_Dodge (copy), u25 (copy)
        if u32 then
            u32:Disconnect();
            u32 = nil;
        end;

        if SideShootin_Dodge and SideShootin_Dodge.IsPlaying then
            SideShootin_Dodge:Stop(0.1);
        end;

        u25._SideShootin_AnimPlaying = false;
    end);
end;

function u1._PerformHit(p33) -- Line: 403
    -- upvalues: u1 (copy), SharedUtils (copy), Enemy_Manager (copy)
    local Character = p33.Player.Character;
    local v34;

    if Character then
        v34 = Character:FindFirstChild("HumanoidRootPart");
    else
        v34 = Character;
    end;

    if not v34 then
        return;
    end;

    local v35 = v34.CFrame * CFrame.new(0, 0, -u1.HitboxSize.Z / 2);
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { Character };
    local v36 = {
        [Character] = true
    };

    for _, v in workspace:GetPartBoundsInBox(v35, u1.HitboxSize, OverlapParams_new_ret) do
        local v37 = v:FindFirstAncestorOfClass("Model");

        if v37 and (not v36[v37] and (v37:FindFirstChild("Humanoid") and (not game.Players:GetPlayerFromCharacter(v37) or v.Parent == v37))) then
            v36[v37] = true;

            if not (v37:HasTag("Ignore_Damage") or v37:GetAttribute("Dead")) then
                local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(v37);

                if PlayerFromCharacter then
                    if p33.Player:GetAttribute("PVPEnabled") and (PlayerFromCharacter:GetAttribute("PVPEnabled") and not p33:CheckPVPParry(v37, true)) then
                        if PlayerFromCharacter:GetAttribute("iFrame") then
                            local State = p33.GetState(PlayerFromCharacter);

                            if State then
                                State:ApplyDodgeReward();
                            end;

                            local HumanoidRootPart = v37:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart then
                                SharedUtils.ShowText(HumanoidRootPart, "Dodged", Color3.fromRGB(100, 200, 255));
                            end;
                        elseif PlayerFromCharacter:GetAttribute("Protected") then
                            local HumanoidRootPart = v37:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart then
                                SharedUtils.ShowText(HumanoidRootPart, "Protected", Color3.fromRGB(255, 255, 255));
                            end;
                        else
                            p33:Apply_Damage(v37, (p33:ResolveSkillDamage(u1.DamageMultiplier, v37)));
                        end;
                    end;
                else
                    local ByModel = Enemy_Manager.GetByModel(v37);

                    if ByModel and ByModel.Is_Alive then
                        p33:Apply_Damage(v37, (p33:ResolveSkillDamage(u1.DamageMultiplier, v37)));
                    elseif v37:HasTag("Enemy") then
                        p33:Apply_Damage(v37, (p33:ResolveSkillDamage(u1.DamageMultiplier, v37)));
                    end;
                end;
            end;
        end;
    end;
end;

function u1._ForceExpire(p38, p39) -- Line: 485
    -- upvalues: u1 (copy)
    p38._SideShootin_Charges = 0;
    p38._SideShootin_ExpiryToken = nil;
    p38._SideShootin_AnimPlaying = false;
    p38.Is_Using_Skill = false;
    p38.Is_Attacking = false;

    if p38.Player then
        p38.Player:SetAttribute("Skill_Charges", 0);
    end;

    u1._StartFullCooldown(p38, p39);
end;

function u1._StartFullCooldown(p40, p41) -- Line: 503
    p40._SideShootin_Charges = 0;
    p40._SideShootin_ExpiryToken = nil;
    p40.Is_Using_Skill = false;

    if p40.Player then
        p40.Player:SetAttribute("Skill_Charges", 0);
    end;

    p40:StartSkillCooldown(p41);
end;

return u1;