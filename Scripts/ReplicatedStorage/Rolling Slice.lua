--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rolling Slice
  Path:     game.ReplicatedStorage.Weapons.Weapon_Skills.Rolling Slice
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:08 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local Enemy_Manager = require(ReplicatedStorage.Enemies.Modules.Enemy_Manager);
u1.DefaultCooldown = 8;
u1.ManagesCooldown = true;
u1.MaxCharges = 2;
u1.ChargeCooldown = 0.4;
u1.ChargeExpiry = 3;
u1.DashDistance = 20;
u1.DashDuration = 0.15;
u1.IFrameDuration = 0.35;
u1.DamageMultiplier = 1.2;
u1.HitboxSize = Vector3.new(25, 15, 25);
u1.CloneColor = Color3.fromRGB(255, 50, 50);
u1.CloneFadeDuration = 3;
local ShadowDash = ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

local function FireParticles(p2: userdata) -- Line: 57
    if not p2:HasTag("ParticleObject") then
        p2:AddTag("ParticleObject");
    end;

    p2:SetAttribute("Fire", not p2:GetAttribute("Fire"));
end;

local Combat_Sounds = ReplicatedStorage.Assets:WaitForChild("Combat_Sounds");
local u3 = {};

local function GetSoundsFromFolder(p4) -- Line: 67
    -- upvalues: u3 (copy), Combat_Sounds (copy)
    if u3[p4] then
        return u3[p4];
    end;

    local v5 = Combat_Sounds:FindFirstChild(p4);

    if v5 then
        u3[p4] = v5:GetChildren();

        return u3[p4];
    end;

    warn("Combat sound folder not found:", p4);

    return {};
end;

local function PlayCombatSound(p6, p7, p8) -- Line: 77
    -- upvalues: GetSoundsFromFolder (copy)
    local v9 = GetSoundsFromFolder(p6);

    if #v9 == 0 then
        return;
    end;

    local u10 = v9[math.random(1, #v9)]:Clone();
    u10.PlaybackSpeed = 1 + (math.random() * 2 - 1) * 0.35;
    u10.Volume = p8 or 1;
    u10.Parent = p7;
    u10:Play();
    u10.Ended:Once(function() -- Line: 85
        -- upvalues: u10 (copy)
        u10:Destroy();
    end);
end;

function u1.CanActivate(p11) -- Line: 94
    if p11.Is_Dodging then
        return false, "Currently dodging";
    end;

    if p11.Is_Stunned then
        return false, "Stunned";
    end;

    if p11._RollingSlice_Charges and p11._RollingSlice_Charges > 0 then
        if p11._RollingSlice_AnimPlaying then
            return false, "Animation in progress";
        end;

        return true;
    end;

    if p11.Is_Attacking then
        return false, "Already attacking";
    end;

    if p11.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    return true;
end;

function u1.Activate(u12) -- Line: 118
    -- upvalues: u1 (copy)
    local Player = u12.Player;
    local Character = Player.Character;
    local v13;

    if Character then
        v13 = Character:FindFirstChild("HumanoidRootPart");
    else
        v13 = Character;
    end;

    local v14;

    if Character then
        v14 = Character:FindFirstChild("Humanoid");
    else
        v14 = Character;
    end;

    if not (v13 and v14) then
        return;
    end;

    local Skill = u12.Wep_Data.Skill;
    local v15 = not u12._RollingSlice_Charges or u12._RollingSlice_Charges == 0;
    Character:SetAttribute("Skill_Attack_Bypass", true);

    if v15 then
        u12._RollingSlice_Charges = u1.MaxCharges;
        u12._RollingSlice_ExpiryToken = tick();
        Player:SetAttribute("Skill_Charges", u1.MaxCharges);
    end;

    u12._RollingSlice_Charges = u12._RollingSlice_Charges - 1;
    local _RollingSlice_Charges = u12._RollingSlice_Charges;
    Player:SetAttribute("Skill_Charges", _RollingSlice_Charges);
    u1._ExecuteCharge(u12, v13, v14, _RollingSlice_Charges);

    if _RollingSlice_Charges <= 0 then
        Character:SetAttribute("Skill_Attack_Bypass", false);
        u1._StartFullCooldown(u12, Skill);

        return;
    end;

    u12.Skill_Cooldowns[Skill] = os.clock() + u1.ChargeCooldown;
    Player:SetAttribute("Skill_OnCooldown", true);
    Player:SetAttribute("Skill_Cooldown_Duration", u1.ChargeCooldown);
    Player:SetAttribute("Skill_CooldownEnd", os.clock() + u1.ChargeCooldown);
    task.delay(u1.ChargeCooldown, function() -- Line: 156
        -- upvalues: u12 (copy), Player (copy)
        if u12._RollingSlice_Charges and (u12._RollingSlice_Charges > 0 and Player) then
            Player:SetAttribute("Skill_OnCooldown", false);
        end;
    end);
    local u16 = tick();
    u12._RollingSlice_ExpiryToken = u16;
    task.delay(u1.ChargeExpiry, function() -- Line: 168
        -- upvalues: u12 (copy), u16 (copy), u1 (ref), Skill (copy), Character (copy)
        if u12._RollingSlice_ExpiryToken ~= u16 then
            return;
        end;

        if not u12._RollingSlice_Charges or u12._RollingSlice_Charges <= 0 then
            return;
        end;

        u1._ForceExpire(u12, Skill);
        Character:SetAttribute("Skill_Attack_Bypass", false);
    end);
end;

function u1._ExecuteCharge(u17, u18, p19, u20) -- Line: 185
    -- upvalues: u1 (copy), PlayCombatSound (copy), SharedUtils (copy), ShadowDash (copy)
    local Player = u17.Player;
    local Character = u17.Character;
    u17.Is_Using_Skill = true;
    u17.Is_Attacking = true;
    u17._RollingSlice_AnimPlaying = true;
    Player:SetAttribute("Protected", true);
    Player:SetAttribute("iFrame", true);
    Character:SetAttribute("Protected", true);
    Character:SetAttribute("iFrame", true);

    for i, v in u17.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.1);
        end;
    end;

    local Skill_Rolling_Slice = u17.Animations.Skill_Rolling_Slice;

    if not Skill_Rolling_Slice then
        warn("Rolling_Slice: Missing Skill_Rolling_Slice animation, using fallback");
        Skill_Rolling_Slice = u17.Animations.Attack_1;
    end;

    if not Skill_Rolling_Slice then
        warn("Rolling_Slice: No animation available");
        u17.Is_Using_Skill = false;
        u17.Is_Attacking = false;
        u17._RollingSlice_AnimPlaying = false;

        return;
    end;

    Skill_Rolling_Slice:Play();
    Character:SetAttribute("Combat_Facing", true);
    local u21 = 0;
    local u22 = false;
    local u24 = Skill_Rolling_Slice:GetMarkerReachedSignal("hit"):Connect(function(p23) -- Line: 232
        -- upvalues: u21 (ref), u22 (ref), u1 (ref), u17 (copy), u18 (copy), PlayCombatSound (ref), SharedUtils (ref), ShadowDash (ref), Player (copy), u20 (copy)
        u21 = u21 + 1;

        if not u22 then
            u22 = true;
            u1._PerformDash(u17, u18);
        end;

        PlayCombatSound(u17.Wep_Data.SwingSoundFolder or "Sword_Swings", u18, u17.Wep_Data.SwingVolume or 0.4);
        pcall(function() -- Line: 248
            -- upvalues: SharedUtils (ref), u18 (ref)
            SharedUtils.PlaySoundAt(u18, "Rolling_Swing", 0.6);
        end);
        u1._PlaySlashFX(u17, u21);

        if ShadowDash then
            ShadowDash:FireAllClients(Player, {
                Action = "Clone",
                FadeDuration = u1.CloneFadeDuration,
                ChargesRemaining = u20,
                Color = u1.CloneColor
            });
        end;

        u1._PerformHit(u17, u21);
    end);
    Skill_Rolling_Slice.Stopped:Once(function() -- Line: 271
        -- upvalues: u24 (ref), Character (copy), u17 (copy)
        if u24 then
            u24:Disconnect();
            u24 = nil;
        end;

        Character:SetAttribute("Combat_Facing", false);
        u17._RollingSlice_AnimPlaying = false;
        u17.Is_Attacking = false;

        if not u17._RollingSlice_Charges or u17._RollingSlice_Charges <= 0 then
            u17.Is_Using_Skill = false;
        end;
    end);
    task.delay(u1.IFrameDuration, function() -- Line: 288
        -- upvalues: u17 (copy), Player (copy), Character (copy)
        if not u17.Is_Dodging then
            Player:SetAttribute("Protected", false);
            Player:SetAttribute("iFrame", false);
            Character:SetAttribute("Protected", false);
            Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay((Skill_Rolling_Slice.Length > 0 and Skill_Rolling_Slice.Length or 1) + 0.5, function() -- Line: 299
        -- upvalues: u24 (ref), u17 (copy), Character (copy)
        if u24 then
            u24:Disconnect();
            u24 = nil;
        end;

        u17._RollingSlice_AnimPlaying = false;
        Character:SetAttribute("Combat_Facing", false);
    end);
end;

function u1._PerformDash(p25, u26) -- Line: 313
    -- upvalues: u1 (copy)
    local u27 = u1.DashDistance / u1.DashDuration;
    local u28 = 0;
    local BodyForce = Instance.new("BodyForce");
    BodyForce.Force = Vector3.new(0, u26.AssemblyMass * workspace.Gravity, 0);
    BodyForce.Parent = u26;
    local u29 = nil;
    u29 = game:GetService("RunService").Heartbeat:Connect(function(p30) -- Line: 323
        -- upvalues: u28 (ref), u1 (ref), u29 (ref), BodyForce (copy), u26 (copy), u27 (copy)
        u28 = u28 + p30;

        if u28 < u1.DashDuration then
            u26.AssemblyLinearVelocity = u26.CFrame.LookVector * u27 + Vector3.new(0, u26.AssemblyLinearVelocity.Y, 0);

            return;
        end;

        u29:Disconnect();
        BodyForce:Destroy();
    end);
    local Skill_Trail = p25.FX.Skill_Trail;

    if Skill_Trail then
        if not Skill_Trail:HasTag("ParticleObject") then
            Skill_Trail:AddTag("ParticleObject");
        end;

        Skill_Trail:SetAttribute("Fire", not Skill_Trail:GetAttribute("Fire"));
    end;
end;

function u1._PlaySlashFX(p31, p32) -- Line: 347
    local v33;

    if p32 <= 2 then
        v33 = p31.FX.Center_Slash;
    elseif p32 == 3 then
        v33 = p31.FX.Left_Slash;
    else
        v33 = p31.FX.Side_Slash;
    end;

    if v33 then
        if not v33:HasTag("ParticleObject") then
            v33:AddTag("ParticleObject");
        end;

        v33:SetAttribute("Fire", not v33:GetAttribute("Fire"));
    end;
end;

function u1._PerformHit(p34, p35) -- Line: 371
    -- upvalues: u1 (copy), SharedUtils (copy), Enemy_Manager (copy)
    local Character = p34.Player.Character;
    local v36;

    if Character then
        v36 = Character:FindFirstChild("HumanoidRootPart");
    else
        v36 = Character;
    end;

    if not v36 then
        return;
    end;

    local v37 = v36.CFrame * CFrame.new(0, 0, -u1.HitboxSize.Z / 2);
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { Character };
    local v38 = {
        [Character] = true
    };

    for _, v in workspace:GetPartBoundsInBox(v37, u1.HitboxSize, OverlapParams_new_ret) do
        local v39 = v:FindFirstAncestorOfClass("Model");

        if v39 and (not v38[v39] and (v39:FindFirstChild("Humanoid") and (not game.Players:GetPlayerFromCharacter(v39) or v.Parent == v39))) then
            v38[v39] = true;

            if not (v39:HasTag("Ignore_Damage") or v39:GetAttribute("Dead")) then
                local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(v39);

                if PlayerFromCharacter then
                    if p34.Player:GetAttribute("PVPEnabled") and (PlayerFromCharacter:GetAttribute("PVPEnabled") and not p34:CheckPVPParry(v39, true)) then
                        if PlayerFromCharacter:GetAttribute("iFrame") then
                            local State = p34.GetState(PlayerFromCharacter);

                            if State then
                                State:ApplyDodgeReward();
                            end;

                            local HumanoidRootPart = v39:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart then
                                SharedUtils.ShowText(HumanoidRootPart, "Dodged", Color3.fromRGB(100, 200, 255));
                            end;
                        elseif PlayerFromCharacter:GetAttribute("Protected") then
                            local HumanoidRootPart = v39:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart then
                                SharedUtils.ShowText(HumanoidRootPart, "Protected", Color3.fromRGB(255, 255, 255));
                            end;
                        else
                            p34:Apply_Damage(v39, (p34:ResolveSkillDamage(u1.DamageMultiplier, v39)));
                        end;
                    end;
                else
                    local ByModel = Enemy_Manager.GetByModel(v39);

                    if ByModel and ByModel.Is_Alive then
                        p34:Apply_Damage(v39, (p34:ResolveSkillDamage(u1.DamageMultiplier, v39)));
                    elseif v39:HasTag("Enemy") then
                        p34:Apply_Damage(v39, (p34:ResolveSkillDamage(u1.DamageMultiplier, v39)));
                    end;
                end;
            end;
        end;
    end;
end;

function u1._ForceExpire(p40, p41) -- Line: 453
    -- upvalues: u1 (copy)
    p40._RollingSlice_Charges = 0;
    p40._RollingSlice_ExpiryToken = nil;
    p40._RollingSlice_AnimPlaying = false;
    p40.Is_Using_Skill = false;
    p40.Is_Attacking = false;

    if p40.Player then
        p40.Player:SetAttribute("Skill_Charges", 0);
    end;

    u1._StartFullCooldown(p40, p41);
end;

function u1._StartFullCooldown(p42, p43) -- Line: 471
    p42._RollingSlice_Charges = 0;
    p42._RollingSlice_ExpiryToken = nil;
    p42.Is_Using_Skill = false;

    if p42.Player then
        p42.Player:SetAttribute("Skill_Charges", 0);
    end;

    p42:StartSkillCooldown(p43);
end;

return u1;