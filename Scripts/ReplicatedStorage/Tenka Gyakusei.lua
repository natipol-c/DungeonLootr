--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Tenka Gyakusei
  Path:     game.ReplicatedStorage.Weapons.Weapon_Skills.Tenka Gyakusei
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
u1.DefaultCooldown = 9;
u1.ManagesCooldown = true;
u1.MaxCharges = 3;
u1.ChargeCooldown = 0.4;
u1.ChargeExpiry = 3;
u1.DashDuration = 0.2;
u1.DashVelocity = 70;
u1.IFrameDuration = 0.35;
u1.DamageMultiplier = 1.2;
u1.HitboxSize = Vector3.new(12, 8, 14);
u1.CloneFadeDuration = 0.5;
u1.StartSound = "Tenka_Start";
u1.SlashSound = "Tenka_Slash";
u1.EndSound = "Tenka_End";
local ShadowDash = ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

local function FireParticles(p2: userdata) -- Line: 62
    if not p2:HasTag("ParticleObject") then
        p2:AddTag("ParticleObject");
    end;

    p2:SetAttribute("Fire", not p2:GetAttribute("Fire"));
end;

function PlayTurnFX(p3, p4)
    local v5 = p3.FX[p4];

    if not v5 then
        warn("Missing FX part: " .. p4);

        return;
    end;

    if not v5:HasTag("ParticleObject") then
        v5:AddTag("ParticleObject");
    end;

    v5:SetAttribute("Fire", not v5:GetAttribute("Fire"));
end;

local Combat_Sounds = ReplicatedStorage.Assets:WaitForChild("Combat_Sounds");
local u6 = {};

local function GetSoundsFromFolder(p7) -- Line: 82
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

local function PlayCombatSound(p9, p10, p11) -- Line: 92
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
    u13.Ended:Once(function() -- Line: 100
        -- upvalues: u13 (copy)
        u13:Destroy();
    end);
end;

function u1.CanActivate(p14) -- Line: 105
    if p14.Is_Dodging then
        return false, "Currently dodging";
    end;

    if p14.Is_Stunned then
        return false, "Stunned";
    end;

    if p14._TenkaGyakusei_Charges and p14._TenkaGyakusei_Charges > 0 then
        if p14._TenkaGyakusei_AnimPlaying then
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

function u1.Activate(u15) -- Line: 128
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
    local v18 = not u15._TenkaGyakusei_Charges or u15._TenkaGyakusei_Charges == 0;
    Character:SetAttribute("Skill_Attack_Bypass", true);

    if v18 then
        u15._TenkaGyakusei_Charges = u1.MaxCharges;
        u15._TenkaGyakusei_ExpiryToken = tick();
        Player:SetAttribute("Skill_Charges", u1.MaxCharges);
        u1._EnsureAnimation(u15);
        pcall(function() -- Line: 152
            -- upvalues: SharedUtils (ref), u16 (copy), u1 (ref)
            SharedUtils.PlaySoundAt(u16, u1.StartSound, 0.8);
        end);
    end;

    u15._TenkaGyakusei_Charges = u15._TenkaGyakusei_Charges - 1;
    local _TenkaGyakusei_Charges = u15._TenkaGyakusei_Charges;
    Player:SetAttribute("Skill_Charges", _TenkaGyakusei_Charges);
    u1._ExecuteCharge(u15, u16, v17, _TenkaGyakusei_Charges);

    if _TenkaGyakusei_Charges <= 0 then
        Character:SetAttribute("Skill_Attack_Bypass", false);
        pcall(function() -- Line: 196
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
    task.delay(u1.ChargeCooldown, function() -- Line: 174
        -- upvalues: u15 (copy), Player (copy)
        if u15._TenkaGyakusei_Charges and (u15._TenkaGyakusei_Charges > 0 and Player) then
            Player:SetAttribute("Skill_OnCooldown", false);
        end;
    end);
    local u19 = tick();
    u15._TenkaGyakusei_ExpiryToken = u19;
    task.delay(u1.ChargeExpiry, function() -- Line: 186
        -- upvalues: u15 (copy), u19 (copy), u1 (ref), Skill (copy), Character (copy)
        if u15._TenkaGyakusei_ExpiryToken ~= u19 then
            return;
        end;

        if not u15._TenkaGyakusei_Charges or u15._TenkaGyakusei_Charges <= 0 then
            return;
        end;

        u1._ForceExpire(u15, Skill);
        Character:SetAttribute("Skill_Attack_Bypass", false);
    end);
end;

function u1._EnsureAnimation(p20) -- Line: 207
    -- upvalues: ReplicatedStorage (copy)
    if p20.Animations.Skill_CrossSlash then
        return;
    end;

    local v21 = ReplicatedStorage.Weapons:FindFirstChild("Tenka Kokin");

    if v21 then
        v21 = v21:FindFirstChild("Skill_Animations");
    end;

    if v21 then
        v21 = v21:FindFirstChild("Skill_CrossSlash");
    end;

    if not v21 then
        warn("TenkaGyakusei: Skill_CrossSlash animation not found");

        return;
    end;

    local v22 = p20.Character and p20.Character:FindFirstChild("Humanoid") and p20.Character.Humanoid:FindFirstChild("Animator");

    if not v22 then
        warn("TenkaGyakusei: No Animator found");

        return;
    end;

    local v23 = v22:LoadAnimation(v21);
    v23.Priority = Enum.AnimationPriority.Action3;
    p20.Animations.Skill_CrossSlash = v23;
end;

function u1._ExecuteCharge(u24, u25, p26, u27) -- Line: 236
    -- upvalues: PlayCombatSound (copy), SharedUtils (copy), u1 (copy), ShadowDash (copy), Debris (copy)
    local Player = u24.Player;
    local Character = u24.Character;
    local MoveDirection = p26.MoveDirection;
    local v28;

    if MoveDirection.Magnitude < 0.1 then
        v28 = u25.CFrame.LookVector;
    else
        v28 = MoveDirection.Unit;
    end;

    u24.Is_Using_Skill = true;
    u24.Is_Attacking = true;
    u24._TenkaGyakusei_AnimPlaying = true;
    Player:SetAttribute("Protected", true);
    Player:SetAttribute("iFrame", true);
    Character:SetAttribute("Protected", true);
    Character:SetAttribute("iFrame", true);

    for i, v in u24.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.1);
        end;
    end;

    local Skill_CrossSlash = u24.Animations.Skill_CrossSlash;

    if not Skill_CrossSlash then
        warn("TenkaGyakusei: Skill_CrossSlash animation not loaded");
        u24.Is_Using_Skill = false;
        u24.Is_Attacking = false;
        u24._TenkaGyakusei_AnimPlaying = false;

        return;
    end;

    Skill_CrossSlash:Play(0, 1, 1);
    local u30 = Skill_CrossSlash:GetMarkerReachedSignal("hit"):Connect(function(p29) -- Line: 280
        -- upvalues: PlayCombatSound (ref), u24 (copy), Character (copy), SharedUtils (ref), u25 (copy), u1 (ref), ShadowDash (ref), Player (copy), u27 (copy)
        PlayCombatSound(u24.Wep_Data.SwingSoundFolder or "Sword_Swings", Character.HumanoidRootPart, u24.Wep_Data.SwingVolume or 0.4);
        PlayTurnFX(u24, p29);
        pcall(function() -- Line: 289
            -- upvalues: SharedUtils (ref), u25 (ref), u1 (ref)
            SharedUtils.PlaySoundAt(u25, u1.SlashSound, 0.6);
        end);

        if ShadowDash then
            ShadowDash:FireAllClients(Player, {
                Action = "Clone",
                FadeDuration = u1.CloneFadeDuration,
                ChargesRemaining = u27,
                Color = Color3.fromRGB(255, 196, 101)
            });
        end;

        u1._PerformHit(u24);
    end);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "TenkaVelocity";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v28 * u1.DashVelocity;
    BodyVelocity.Parent = u25;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
    Skill_CrossSlash.Stopped:Once(function() -- Line: 317
        -- upvalues: u30 (ref), u24 (copy)
        if u30 then
            u30:Disconnect();
            u30 = nil;
        end;

        u24._TenkaGyakusei_AnimPlaying = false;
        u24.Is_Attacking = false;

        if not u24._TenkaGyakusei_Charges or u24._TenkaGyakusei_Charges <= 0 then
            u24.Is_Using_Skill = false;
        end;
    end);
    task.delay(u1.IFrameDuration, function() -- Line: 332
        -- upvalues: u24 (copy), Player (copy), Character (copy)
        if not u24.Is_Dodging then
            Player:SetAttribute("Protected", false);
            Player:SetAttribute("iFrame", false);
            Character:SetAttribute("Protected", false);
            Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay((Skill_CrossSlash.Length > 0 and Skill_CrossSlash.Length or 1) + 0.5, function() -- Line: 343
        -- upvalues: u30 (ref), u24 (copy)
        if u30 then
            u30:Disconnect();
            u30 = nil;
        end;

        u24._TenkaGyakusei_AnimPlaying = false;
    end);
end;

function u1._PerformHit(p31) -- Line: 356
    -- upvalues: u1 (copy), SharedUtils (copy), Enemy_Manager (copy)
    local Character = p31.Player.Character;
    local v32;

    if Character then
        v32 = Character:FindFirstChild("HumanoidRootPart");
    else
        v32 = Character;
    end;

    if not v32 then
        return;
    end;

    local v33 = v32.CFrame * CFrame.new(0, 0, -u1.HitboxSize.Z / 2);
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { Character };
    local v34 = {
        [Character] = true
    };

    for _, v in workspace:GetPartBoundsInBox(v33, u1.HitboxSize, OverlapParams_new_ret) do
        local v35 = v:FindFirstAncestorOfClass("Model");

        if v35 and (not v34[v35] and (v35:FindFirstChild("Humanoid") and (not game.Players:GetPlayerFromCharacter(v35) or v.Parent == v35))) then
            v34[v35] = true;

            if not (v35:HasTag("Ignore_Damage") or v35:GetAttribute("Dead")) then
                local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(v35);

                if PlayerFromCharacter then
                    if p31.Player:GetAttribute("PVPEnabled") and (PlayerFromCharacter:GetAttribute("PVPEnabled") and not p31:CheckPVPParry(v35, true)) then
                        if PlayerFromCharacter:GetAttribute("iFrame") then
                            local State = p31.GetState(PlayerFromCharacter);

                            if State then
                                State:ApplyDodgeReward();
                            end;

                            local HumanoidRootPart = v35:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart then
                                SharedUtils.ShowText(HumanoidRootPart, "Dodged", Color3.fromRGB(100, 200, 255));
                            end;
                        elseif PlayerFromCharacter:GetAttribute("Protected") then
                            local HumanoidRootPart = v35:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart then
                                SharedUtils.ShowText(HumanoidRootPart, "Protected", Color3.fromRGB(255, 255, 255));
                            end;
                        else
                            p31:Apply_Damage(v35, (p31:ResolveSkillDamage(u1.DamageMultiplier, v35)));
                        end;
                    end;
                else
                    local ByModel = Enemy_Manager.GetByModel(v35);

                    if ByModel and ByModel.Is_Alive then
                        p31:Apply_Damage(v35, (p31:ResolveSkillDamage(u1.DamageMultiplier, v35)));
                    elseif v35:HasTag("Enemy") then
                        p31:Apply_Damage(v35, (p31:ResolveSkillDamage(u1.DamageMultiplier, v35)));
                    end;
                end;
            end;
        end;
    end;
end;

function u1._ForceExpire(p36, p37) -- Line: 437
    -- upvalues: u1 (copy)
    p36._TenkaGyakusei_Charges = 0;
    p36._TenkaGyakusei_ExpiryToken = nil;
    p36._TenkaGyakusei_AnimPlaying = false;
    p36.Is_Using_Skill = false;
    p36.Is_Attacking = false;

    if p36.Player then
        p36.Player:SetAttribute("Skill_Charges", 0);
    end;

    u1._StartFullCooldown(p36, p37);
end;

function u1._StartFullCooldown(p38, p39) -- Line: 454
    p38._TenkaGyakusei_Charges = 0;
    p38._TenkaGyakusei_ExpiryToken = nil;
    p38.Is_Using_Skill = false;

    if p38.Player then
        p38.Player:SetAttribute("Skill_Charges", 0);
    end;

    p38:StartSkillCooldown(p39);
end;

return u1;