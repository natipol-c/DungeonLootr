--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Coyote Barrage
  Path:     game.ReplicatedStorage.Weapons.Weapon_Skills.Coyote Barrage
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
u1.DefaultCooldown = 10;
u1.DamagePercent = 0.25;
u1.TotalHits = 50;
u1.HitInterval = 0.08;
u1.HitboxSize = Vector3.new(8, 25, 25);
u1.AnimSpeed = 1;
u1.AnimationSequence = { "Attack_3" };

function u1.CanActivate(p2) -- Line: 30
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

function u1.Activate(u3) -- Line: 42
    -- upvalues: u1 (copy), SharedUtils (copy)
    local Character = u3.Player.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    Character:SetAttribute("Combat_Facing", true);
    local Cero_Ability = u3.FX.Cero_Ability;

    if not Cero_Ability then
        warn("Coyote_Barrage: Missing FX.Cero_Ability object");
    end;

    local v4 = {};

    if Cero_Ability then
        for _, child in Cero_Ability:GetChildren() do
            if child:IsA("BasePart") then
                table.insert(v4, child);
            end;
        end;
    end;

    if #v4 == 0 then
        warn("Coyote_Barrage: No valid parts found in Cero_Ability");
    end;

    local v5 = u1.TotalHits * u1.HitInterval;
    u3.Animations[u1.AnimationSequence[1]]:Play(0);

    for i = 1, u1.TotalHits do
        task.delay((i - 1) * u1.HitInterval, function() -- Line: 85
            -- upvalues: u3 (copy), SharedUtils (ref), HumanoidRootPart (copy), u1 (ref)
            if not u3.Is_Using_Skill then
                return;
            end;

            if not u3.Player then
                return;
            end;

            u3.FX.Cero_Ability.Cero_1:SetAttribute("FX_Activate", true);
            SharedUtils.PlaySoundAt(HumanoidRootPart, "Cero_Shot");
            u1._PerformHit(u3);
        end);
        local _ = i;
    end;

    task.delay(v5 + 0.3, function() -- Line: 109
        -- upvalues: u3 (copy), Character (copy), u1 (ref)
        if u3.Player then
            u3.Is_Using_Skill = false;
            u3.Is_Attacking = false;
        end;

        Character:SetAttribute("Combat_Facing", false);

        for _, v in u1.AnimationSequence do
            local v6 = u3.Animations[v];

            if v6 and v6.IsPlaying then
                v6:Stop();
            end;
        end;

        u3.FX.Cero_Ability.Cero_1:SetAttribute("FX_Activate", false);
        u1._SetArmFX(u3, true);
        task.delay(u1.DefaultCooldown, function() -- Line: 130
            -- upvalues: u1 (ref), u3 (ref)
            u1._SetArmFX(u3, false);
        end);
    end);
end;

function u1._SetArmFX(p7, p8) -- Line: 139
    local Weapon_Model = p7.Weapon_Model;

    if not Weapon_Model then
        return;
    end;

    for _, v in { "Left_Arm", "Right_Arm" } do
        local v9 = Weapon_Model:FindFirstChild(v);

        if v9 then
            for _, child in v9:GetChildren() do
                if child:IsA("MeshPart") then
                    child:SetAttribute("FX_Activate", p8);
                end;
            end;
        end;
    end;
end;

function u1._GetRandomExcluding(p10, p11) -- Line: 160
    if p10 <= 1 then
        return 1;
    end;

    local v12;

    repeat
        v12 = math.random(1, p10);
    until v12 ~= p11;

    return v12;
end;

function u1._PerformHit(p13) -- Line: 174
    -- upvalues: u1 (copy), SharedUtils (copy), Enemy_Manager (copy)
    local v14 = p13.Player and p13.Player.Character;

    if not v14 then
        return;
    end;

    local HumanoidRootPart = v14:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v15 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -u1.HitboxSize.Z / 2);
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { v14 };
    local v16 = {
        [v14] = true
    };

    for _, v in workspace:GetPartBoundsInBox(v15, u1.HitboxSize, OverlapParams_new_ret) do
        local v17 = v:FindFirstAncestorOfClass("Model");

        if v17 and (not v16[v17] and (v17:FindFirstChild("Humanoid") and (not game.Players:GetPlayerFromCharacter(v17) or v.Parent == v17))) then
            v16[v17] = true;

            if not (v17:HasTag("Ignore_Damage") or v17:GetAttribute("Dead")) then
                local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(v17);

                if PlayerFromCharacter then
                    if p13.Player:GetAttribute("PVPEnabled") and (PlayerFromCharacter:GetAttribute("PVPEnabled") and not p13:CheckPVPParry(v17, true)) then
                        if PlayerFromCharacter:GetAttribute("iFrame") then
                            local State = p13.GetState(PlayerFromCharacter);

                            if State then
                                State:ApplyDodgeReward();
                            end;

                            local HumanoidRootPart2 = v17:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart2 then
                                SharedUtils.ShowText(HumanoidRootPart2, "Dodged", Color3.fromRGB(100, 200, 255));
                            end;
                        elseif PlayerFromCharacter:GetAttribute("Protected") then
                            local HumanoidRootPart2 = v17:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart2 then
                                SharedUtils.ShowText(HumanoidRootPart2, "Protected", Color3.fromRGB(255, 255, 255));
                            end;
                        else
                            p13:Apply_Damage(v17, (p13:ResolveSkillDamage(u1.DamagePercent, v17)));
                        end;
                    end;
                else
                    local ByModel = Enemy_Manager.GetByModel(v17);

                    if ByModel and ByModel.Is_Alive then
                        p13:Apply_Damage(v17, (p13:ResolveSkillDamage(u1.DamagePercent, v17)));
                    elseif v17:HasTag("Enemy") then
                        p13:Apply_Damage(v17, (p13:ResolveSkillDamage(u1.DamagePercent, v17)));
                    end;
                end;
            end;
        end;
    end;
end;

function u1._FireParticles(p18) -- Line: 252
    if not p18:HasTag("ParticleObject") then
        p18:AddTag("ParticleObject");
    end;

    p18:SetAttribute("Fire", not p18:GetAttribute("Fire"));
end;

return u1;