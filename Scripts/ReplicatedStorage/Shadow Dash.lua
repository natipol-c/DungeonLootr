--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Shadow Dash
  Path:     game.ReplicatedStorage.Weapons.Weapon_Skills.Shadow Dash
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
u1.ChargeCooldown = 0.2;
u1.ChargeExpiry = 3;
u1.DashDuration = 0.18;
u1.DashVelocity = 150;
u1.IFrameDuration = 0.35;
u1.DamageMultiplier = nil;
u1.HitboxSize = Vector3.new(10, 8, 12);
local GroundEffect = ReplicatedStorage.Assets.Effects.GroundEffect;
local ShadowDash = ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1.CanActivate(p2) -- Line: 49
    if p2.Is_Dodging then
        return false, "Currently dodging";
    end;

    if p2.Is_Stunned then
        return false, "Stunned";
    end;

    if p2._ShadowDash_Charges and p2._ShadowDash_Charges > 0 then
        return true;
    end;

    if p2.Is_Attacking then
        return false, "Already attacking";
    end;

    if p2.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    return true;
end;

function u1.Activate(u3) -- Line: 69
    -- upvalues: u1 (copy)
    local Player = u3.Player;
    local Character = Player.Character;
    local v4;

    if Character then
        v4 = Character:FindFirstChild("HumanoidRootPart");
    else
        v4 = Character;
    end;

    local v5;

    if Character then
        v5 = Character:FindFirstChild("Humanoid");
    else
        v5 = Character;
    end;

    if not (v4 and v5) then
        return;
    end;

    local Skill = u3.Wep_Data.Skill;
    local v6 = not u3._ShadowDash_Charges or u3._ShadowDash_Charges == 0;
    Character:SetAttribute("Skill_Attack_Bypass", true);

    if v6 then
        u3._ShadowDash_Charges = u1.MaxCharges;
        u3._ShadowDash_ExpiryToken = tick();
        Player:SetAttribute("Skill_Charges", u1.MaxCharges);
    end;

    u3._ShadowDash_Charges = u3._ShadowDash_Charges - 1;
    local _ShadowDash_Charges = u3._ShadowDash_Charges;
    Player:SetAttribute("Skill_Charges", _ShadowDash_Charges);
    u1._ExecuteCharge(u3, v4, v5, _ShadowDash_Charges);

    if _ShadowDash_Charges <= 0 then
        Character:SetAttribute("Skill_Attack_Bypass", false);
        u1._StartFullCooldown(u3, Skill);

        return;
    end;

    u3.Skill_Cooldowns[Skill] = os.clock() + u1.ChargeCooldown;
    Player:SetAttribute("Skill_OnCooldown", true);
    Player:SetAttribute("Skill_Cooldown_Duration", u1.ChargeCooldown);
    Player:SetAttribute("Skill_CooldownEnd", os.clock() + u1.ChargeCooldown);
    task.delay(u1.ChargeCooldown, function() -- Line: 107
        -- upvalues: u3 (copy), Player (copy)
        if u3._ShadowDash_Charges and (u3._ShadowDash_Charges > 0 and Player) then
            Player:SetAttribute("Skill_OnCooldown", false);
        end;
    end);
    local u7 = tick();
    u3._ShadowDash_ExpiryToken = u7;
    task.delay(u1.ChargeExpiry, function() -- Line: 119
        -- upvalues: u3 (copy), u7 (copy), Character (copy), u1 (ref), Skill (copy)
        if u3._ShadowDash_ExpiryToken ~= u7 then
            return;
        end;

        if not u3._ShadowDash_Charges or u3._ShadowDash_Charges <= 0 then
            return;
        end;

        Character:SetAttribute("Skill_Attack_Bypass", false);
        u1._ForceExpire(u3, Skill);
    end);
end;

function u1._ExecuteCharge(u8, u9, p10, p11) -- Line: 137
    -- upvalues: SharedUtils (copy), GroundEffect (copy), Debris (copy), ShadowDash (copy), u1 (copy)
    local Player = u8.Player;
    local Character = u8.Character;
    local MoveDirection = p10.MoveDirection;
    local v12;

    if MoveDirection.Magnitude < 0.1 then
        v12 = u9.CFrame.LookVector;
    else
        v12 = MoveDirection.Unit;
    end;

    u8.Is_Using_Skill = true;
    u8.Is_Attacking = true;
    Player:SetAttribute("Protected", true);
    Player:SetAttribute("iFrame", true);
    Character:SetAttribute("Protected", true);
    Character:SetAttribute("iFrame", true);

    for i, v in u8.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.1);
        end;
    end;

    local Forward = u8.DodgeAnimations.Forward;

    if Forward then
        Forward:Play(0, 1, 1.5);
    end;

    pcall(function() -- Line: 173
        -- upvalues: SharedUtils (ref), u9 (copy)
        SharedUtils.PlaySoundAt(u9, "ShadowDash", 0.6);
    end);
    local u13 = GroundEffect:Clone();
    u13.Parent = workspace;
    u13.CFrame = u9.CFrame * CFrame.new(0, -3, 0);
    task.delay(0.1, function() -- Line: 180
        -- upvalues: u13 (copy)
        u13:SetAttribute("Fire", not u13:GetAttribute("Fire"));
    end);
    Debris:AddItem(u13, 5);

    if ShadowDash then
        ShadowDash:FireAllClients(Player, {
            Action = "Clone",
            FadeDuration = 2.5,
            ChargesRemaining = p11
        });
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "ShadowDashVelocity";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v12 * u1.DashVelocity;
    BodyVelocity.Parent = u9;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
    task.delay(u1.IFrameDuration, function() -- Line: 205
        -- upvalues: u8 (copy), Player (copy), Character (copy)
        if not u8.Is_Dodging then
            Player:SetAttribute("Protected", false);
            Player:SetAttribute("iFrame", false);
            Character:SetAttribute("Protected", false);
            Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay(u1.DashDuration + 0.05, function() -- Line: 215
        -- upvalues: u1 (ref), u8 (copy)
        if u1.DamageMultiplier then
            u1._PerformHit(u8);
        end;

        u8.Is_Attacking = false;

        if not u8._ShadowDash_Charges or u8._ShadowDash_Charges <= 0 then
            u8.Is_Using_Skill = false;
        end;
    end);
end;

function u1._ForceExpire(p14, p15) -- Line: 233
    -- upvalues: u1 (copy)
    p14._ShadowDash_Charges = 0;
    p14._ShadowDash_ExpiryToken = nil;
    p14.Is_Using_Skill = false;
    p14.Is_Attacking = false;

    if p14.Player then
        p14.Player:SetAttribute("Skill_Charges", 0);
    end;

    u1._StartFullCooldown(p14, p15);
end;

function u1._StartFullCooldown(p16, p17) -- Line: 249
    p16._ShadowDash_Charges = 0;
    p16._ShadowDash_ExpiryToken = nil;
    p16.Is_Using_Skill = false;

    if p16.Player then
        p16.Player:SetAttribute("Skill_Charges", 0);
    end;

    p16:StartSkillCooldown(p17);
end;

function u1._PerformHit(p18) -- Line: 264
    -- upvalues: u1 (copy), SharedUtils (copy), Enemy_Manager (copy)
    local Character = p18.Player.Character;
    local v19;

    if Character then
        v19 = Character:FindFirstChild("HumanoidRootPart");
    else
        v19 = Character;
    end;

    if not v19 then
        return;
    end;

    local v20 = v19.CFrame * CFrame.new(0, 0, -u1.HitboxSize.Z / 2);
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { Character };
    local v21 = {
        [Character] = true
    };

    for _, v in workspace:GetPartBoundsInBox(v20, u1.HitboxSize, OverlapParams_new_ret) do
        local v22 = v:FindFirstAncestorOfClass("Model");

        if v22 and (not v21[v22] and (v22:FindFirstChild("Humanoid") and (not game.Players:GetPlayerFromCharacter(v22) or v.Parent == v22))) then
            v21[v22] = true;

            if not (v22:HasTag("Ignore_Damage") or v22:GetAttribute("Dead")) then
                local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(v22);

                if PlayerFromCharacter then
                    if p18.Player:GetAttribute("PVPEnabled") and (PlayerFromCharacter:GetAttribute("PVPEnabled") and not p18:CheckPVPParry(v22, true)) then
                        if PlayerFromCharacter:GetAttribute("iFrame") then
                            local State = p18.GetState(PlayerFromCharacter);

                            if State then
                                State:ApplyDodgeReward();
                            end;

                            local HumanoidRootPart = v22:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart then
                                SharedUtils.ShowText(HumanoidRootPart, "Dodged", Color3.fromRGB(100, 200, 255));
                            end;
                        elseif PlayerFromCharacter:GetAttribute("Protected") then
                            local HumanoidRootPart = v22:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart then
                                SharedUtils.ShowText(HumanoidRootPart, "Protected", Color3.fromRGB(255, 255, 255));
                            end;
                        else
                            p18:Apply_Damage(v22, (p18:ResolveSkillDamage(u1.DamageMultiplier, v22)));
                        end;
                    end;
                else
                    local ByModel = Enemy_Manager.GetByModel(v22);

                    if ByModel and ByModel.Is_Alive then
                        p18:Apply_Damage(v22, (p18:ResolveSkillDamage(u1.DamageMultiplier, v22)));
                    elseif v22:HasTag("Enemy") then
                        p18:Apply_Damage(v22, (p18:ResolveSkillDamage(u1.DamageMultiplier, v22)));
                    end;
                end;
            end;
        end;
    end;
end;

return u1;