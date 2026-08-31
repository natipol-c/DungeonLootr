--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Arrow Rain
  Path:     game.ReplicatedStorage.Weapons.Weapon_Skills.Arrow Rain
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
u1.DefaultCooldown = 12;
u1.DamagePercent = 0.3;
u1.TotalHits = 10;
u1.HitInterval = 0.15;
u1.HitboxSize = Vector3.new(15, 5, 20);

function u1.CanActivate(p2) -- Line: 24
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

function u1.Activate(u3) -- Line: 36
    -- upvalues: u1 (copy), SharedUtils (copy)
    local HumanoidRootPart = u3.Player.Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    local Skill = u3.Animations.Skill;

    if not Skill then
        warn("Arrow_Rain: Missing \'Skill\' animation, using fallback");
        Skill = u3.Animations.Attack_1;
    end;

    local Skill_Rain = u3.FX.Skill_Rain;

    if not Skill_Rain then
        warn("Arrow_Rain: Missing FX.Skill_Rain object");
    end;

    local u4 = {};

    if Skill_Rain then
        for _, child in Skill_Rain:GetChildren() do
            if child:IsA("BasePart") and child.Name == "BowSlash" then
                table.insert(u4, child);
            end;
        end;
    end;

    if #u4 == 0 then
        warn("Arrow_Rain: No BowSlash parts found in Skill_Rain");
    end;

    Skill:Play();

    for i = 1, u1.TotalHits do
        task.delay((i - 1) * u1.HitInterval, function() -- Line: 78
            -- upvalues: u3 (copy), u4 (copy), u1 (ref), SharedUtils (ref), HumanoidRootPart (copy)
            if not u3.Is_Using_Skill then
                return;
            end;

            if not u3.Player then
                return;
            end;

            if #u4 > 0 then
                local v5 = u4[math.random(1, #u4)];
                u1._FireParticles(v5);
            end;

            SharedUtils.PlaySoundAt(HumanoidRootPart, "Bow_Shot");
            u1._PerformHit(u3);
        end);
        local _ = i;
    end;

    local v6 = u1.TotalHits * u1.HitInterval;
    local v7;

    if Skill then
        v7 = Skill.Length or v6;
    else
        v7 = v6;
    end;

    local v8 = math.max(v7, v6) + 0.1;
    task.delay(v8, function() -- Line: 104
        -- upvalues: u3 (copy)
        if u3.Player then
            u3.Is_Using_Skill = false;
            u3.Is_Attacking = false;
        end;
    end);
end;

function u1._PerformHit(p9) -- Line: 115
    -- upvalues: u1 (copy), SharedUtils (copy), Enemy_Manager (copy)
    local v10 = p9.Player and p9.Player.Character;

    if not v10 then
        return;
    end;

    local HumanoidRootPart = v10:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v11 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -u1.HitboxSize.Z / 2);
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { v10 };
    local v12 = {
        [v10] = true
    };

    for _, v in workspace:GetPartBoundsInBox(v11, u1.HitboxSize, OverlapParams_new_ret) do
        local v13 = v:FindFirstAncestorOfClass("Model");

        if v13 and (not v12[v13] and (v13:FindFirstChild("Humanoid") and (not game.Players:GetPlayerFromCharacter(v13) or v.Parent == v13))) then
            v12[v13] = true;

            if not (v13:HasTag("Ignore_Damage") or v13:GetAttribute("Dead")) then
                local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(v13);

                if PlayerFromCharacter then
                    if p9.Player:GetAttribute("PVPEnabled") and (PlayerFromCharacter:GetAttribute("PVPEnabled") and not p9:CheckPVPParry(v13, true)) then
                        if PlayerFromCharacter:GetAttribute("iFrame") then
                            local State = p9.GetState(PlayerFromCharacter);

                            if State then
                                State:ApplyDodgeReward();
                            end;

                            local HumanoidRootPart2 = v13:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart2 then
                                SharedUtils.ShowText(HumanoidRootPart2, "Dodged", Color3.fromRGB(100, 200, 255));
                            end;
                        elseif PlayerFromCharacter:GetAttribute("Protected") then
                            local HumanoidRootPart2 = v13:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart2 then
                                SharedUtils.ShowText(HumanoidRootPart2, "Protected", Color3.fromRGB(255, 255, 255));
                            end;
                        else
                            p9:Apply_Damage(v13, (p9:ResolveSkillDamage(u1.DamagePercent, v13)));
                        end;
                    end;
                else
                    local ByModel = Enemy_Manager.GetByModel(v13);

                    if ByModel and ByModel.Is_Alive then
                        p9:Apply_Damage(v13, (p9:ResolveSkillDamage(u1.DamagePercent, v13)));
                    elseif v13:HasTag("Enemy") then
                        p9:Apply_Damage(v13, (p9:ResolveSkillDamage(u1.DamagePercent, v13)));
                    end;
                end;
            end;
        end;
    end;
end;

function u1._FireParticles(p14) -- Line: 193
    if not p14:HasTag("ParticleObject") then
        p14:AddTag("ParticleObject");
    end;

    p14:SetAttribute("Fire", not p14:GetAttribute("Fire"));
end;

return u1;