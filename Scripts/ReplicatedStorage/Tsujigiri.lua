--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Tsujigiri
  Path:     game.ReplicatedStorage.Weapons.Weapon_Skills.Tsujigiri
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:08 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local Enemy_Manager = require(ReplicatedStorage.Enemies.Modules.Enemy_Manager);
u1.DefaultCooldown = 8;
u1.DamageMultiplier = 2.5;
u1.DashDistance = 20;
u1.DashDuration = 0.15;
u1.HitboxSize = Vector3.new(8, 15, 25);

function u1.CanActivate(p2) -- Line: 26
    if p2.Is_Attacking then
        return false, "Already attacking";
    end;

    if p2.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p2.Is_Dodging then
        return false, "Currently dodging";
    end;

    if p2.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u3) -- Line: 40
    -- upvalues: SharedUtils (copy), u1 (copy)
    local HumanoidRootPart = u3.Player.Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    local Skill_Tsujigiri = u3.Animations.Skill_Tsujigiri;

    if Skill_Tsujigiri then
        Skill_Tsujigiri:Play();
    else
        u3.Animations.Attack_1:Play(0, 1, 2);
    end;

    SharedUtils.PlaySoundAt(HumanoidRootPart, "Tsujigiri_Swing");
    u1._PerformDash(u3, HumanoidRootPart);
    task.delay(u1.DashDuration, function() -- Line: 66
        -- upvalues: u1 (ref), u3 (copy)
        u1._PerformHit(u3);
    end);
    task.delay(Skill_Tsujigiri and Skill_Tsujigiri.Length or 0.5, function() -- Line: 72
        -- upvalues: u3 (copy)
        u3.Is_Using_Skill = false;
        u3.Is_Attacking = false;
    end);
end;

function u1._PerformDash(p4, u5) -- Line: 81
    -- upvalues: u1 (copy)
    local u6 = u1.DashDistance / u1.DashDuration;
    local u7 = 0;
    local BodyForce = Instance.new("BodyForce");
    BodyForce.Force = Vector3.new(0, u5.AssemblyMass * workspace.Gravity, 0);
    BodyForce.Parent = u5;
    local u8 = nil;
    u8 = game:GetService("RunService").Heartbeat:Connect(function(p9) -- Line: 91
        -- upvalues: u7 (ref), u1 (ref), u8 (ref), BodyForce (copy), u5 (copy), u6 (copy)
        u7 = u7 + p9;

        if u7 < u1.DashDuration then
            u5.AssemblyLinearVelocity = u5.CFrame.LookVector * u6 + Vector3.new(0, u5.AssemblyLinearVelocity.Y, 0);

            return;
        end;

        u8:Disconnect();
        BodyForce:Destroy();
    end);
    local Skill_Trail = p4.FX.Skill_Trail;

    if Skill_Trail then
        u1._FireParticles(Skill_Trail);
    end;
end;

function u1._PerformHit(p10) -- Line: 113
    -- upvalues: u1 (copy), SharedUtils (copy), Enemy_Manager (copy)
    local Character = p10.Player.Character;
    local v11;

    if Character then
        v11 = Character:FindFirstChild("HumanoidRootPart");
    else
        v11 = Character;
    end;

    if not v11 then
        return;
    end;

    local v12 = v11.CFrame * CFrame.new(0, 0, -u1.HitboxSize.Z / 2);
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { Character };
    local v13 = {
        [Character] = true
    };

    for _, v in workspace:GetPartBoundsInBox(v12, u1.HitboxSize, OverlapParams_new_ret) do
        local v14 = v:FindFirstAncestorOfClass("Model");

        if v14 and (not v13[v14] and (v14:FindFirstChild("Humanoid") and (not game.Players:GetPlayerFromCharacter(v14) or v.Parent == v14))) then
            v13[v14] = true;

            if not (v14:HasTag("Ignore_Damage") or v14:GetAttribute("Dead")) then
                local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(v14);

                if PlayerFromCharacter then
                    if p10.Player:GetAttribute("PVPEnabled") and (PlayerFromCharacter:GetAttribute("PVPEnabled") and not p10:CheckPVPParry(v14, true)) then
                        if PlayerFromCharacter:GetAttribute("iFrame") then
                            local State = p10.GetState(PlayerFromCharacter);

                            if State then
                                State:ApplyDodgeReward();
                            end;

                            local HumanoidRootPart = v14:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart then
                                SharedUtils.ShowText(HumanoidRootPart, "Dodged", Color3.fromRGB(100, 200, 255));
                            end;
                        elseif PlayerFromCharacter:GetAttribute("Protected") then
                            local HumanoidRootPart = v14:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart then
                                SharedUtils.ShowText(HumanoidRootPart, "Protected", Color3.fromRGB(255, 255, 255));
                            end;
                        else
                            p10:Apply_Damage(v14, (p10:ResolveSkillDamage(u1.DamageMultiplier, v14)));
                        end;
                    end;
                else
                    local ByModel = Enemy_Manager.GetByModel(v14);

                    if ByModel and ByModel.Is_Alive then
                        p10:Apply_Damage(v14, (p10:ResolveSkillDamage(u1.DamageMultiplier, v14)));
                    elseif v14:HasTag("Enemy") then
                        p10:Apply_Damage(v14, (p10:ResolveSkillDamage(u1.DamageMultiplier, v14)));
                    end;
                end;
            end;
        end;
    end;

    local Center_Slash = p10.FX.Center_Slash;

    if Center_Slash then
        u1._FireParticles(Center_Slash);
    end;
end;

function u1._FireParticles(p15) -- Line: 196
    if not p15:HasTag("ParticleObject") then
        p15:AddTag("ParticleObject");
    end;

    p15:SetAttribute("Fire", not p15:GetAttribute("Fire"));
end;

return u1;