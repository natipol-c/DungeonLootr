--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Magic Barrage
  Path:     game.ReplicatedStorage.Weapons.Weapon_Skills.Magic Barrage
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
u1.DamagePercent = 0.8;
u1.TotalHits = 15;
u1.HitInterval = 0.2;
u1.HitboxSize = Vector3.new(8, 25, 25);
u1.AnimSpeed = 0.5;
u1.AnimationSequence = { "Attack_4" };

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

function u1.Activate(u3) -- Line: 34
    -- upvalues: u1 (copy), SharedUtils (copy)
    local Character = u3.Player.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    Character:SetAttribute("Combat_Facing", true);
    local u4 = {};
    local v5 = u3.FX["Air_" .. 1];

    if v5 then
        table.insert(u4, v5);
    else
        warn("Magic_Barrage: Missing FX.Air_" .. 1);
    end;

    local v6 = u3.FX["Air_" .. 2];

    if v6 then
        table.insert(u4, v6);
    else
        warn("Magic_Barrage: Missing FX.Air_" .. 2);
    end;

    local v7 = u3.FX["Air_" .. 3];

    if v7 then
        table.insert(u4, v7);
    else
        warn("Magic_Barrage: Missing FX.Air_" .. 3);
    end;

    local Long_1 = u3.FX.Long_1;

    if Long_1 then
        Long_1:SetAttribute("FX_Activate", true);
    else
        warn("Magic_Barrage: Missing FX.Long_1");
    end;

    local v8 = u3.Animations[u1.AnimationSequence[1]];
    v8:Play(0);
    v8:AdjustSpeed(u1.AnimSpeed);
    local v9 = u1.TotalHits * u1.HitInterval;
    local u10 = 0;

    for i = 1, u1.TotalHits do
        task.delay((i - 1) * u1.HitInterval, function() -- Line: 75
            -- upvalues: u3 (copy), u4 (copy), u1 (ref), u10 (ref), SharedUtils (ref), HumanoidRootPart (copy)
            if not u3.Is_Using_Skill then
                return;
            end;

            if not u3.Player then
                return;
            end;

            if #u4 > 0 then
                local v11 = u1._GetRandomExcluding(#u4, u10);
                u10 = v11;
                u1._FireParticles(u4[v11]);
            end;

            SharedUtils.PlaySoundAt(HumanoidRootPart, "Cero_Shot");
            u1._PerformHit(u3);
        end);
        local _ = i;
    end;

    task.delay(v9 + 0.3, function() -- Line: 95
        -- upvalues: u3 (copy), Character (copy), u1 (ref), Long_1 (copy)
        if u3.Player then
            u3.Is_Using_Skill = false;
            u3.Is_Attacking = false;
        end;

        Character:SetAttribute("Combat_Facing", false);

        for _, v in u1.AnimationSequence do
            local v12 = u3.Animations[v];

            if v12 and v12.IsPlaying then
                v12:Stop();
            end;
        end;

        if Long_1 then
            Long_1:SetAttribute("FX_Activate", false);
        end;
    end);
end;

function u1._GetRandomExcluding(p13, p14) -- Line: 117
    if p13 <= 1 then
        return 1;
    end;

    local v15;

    repeat
        v15 = math.random(1, p13);
    until v15 ~= p14;

    return v15;
end;

function u1._PerformHit(p16) -- Line: 126
    -- upvalues: u1 (copy), SharedUtils (copy), Enemy_Manager (copy)
    local v17 = p16.Player and p16.Player.Character;

    if not v17 then
        return;
    end;

    local HumanoidRootPart = v17:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v18 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -u1.HitboxSize.Z / 2);
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { v17 };
    local v19 = {
        [v17] = true
    };

    for _, v in workspace:GetPartBoundsInBox(v18, u1.HitboxSize, OverlapParams_new_ret) do
        local v20 = v:FindFirstAncestorOfClass("Model");

        if v20 and (not v19[v20] and (v20:FindFirstChild("Humanoid") and (not game.Players:GetPlayerFromCharacter(v20) or v.Parent == v20))) then
            v19[v20] = true;

            if not (v20:HasTag("Ignore_Damage") or v20:GetAttribute("Dead")) then
                local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(v20);

                if PlayerFromCharacter then
                    if p16.Player:GetAttribute("PVPEnabled") and (PlayerFromCharacter:GetAttribute("PVPEnabled") and not p16:CheckPVPParry(v20, true)) then
                        if PlayerFromCharacter:GetAttribute("iFrame") then
                            local State = p16.GetState(PlayerFromCharacter);

                            if State then
                                State:ApplyDodgeReward();
                            end;

                            local HumanoidRootPart2 = v20:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart2 then
                                SharedUtils.ShowText(HumanoidRootPart2, "Dodged", Color3.fromRGB(100, 200, 255));
                            end;
                        elseif PlayerFromCharacter:GetAttribute("Protected") then
                            local HumanoidRootPart2 = v20:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart2 then
                                SharedUtils.ShowText(HumanoidRootPart2, "Protected", Color3.fromRGB(255, 255, 255));
                            end;
                        else
                            p16:Apply_Damage(v20, (p16:ResolveSkillDamage(u1.DamagePercent, v20)));
                        end;
                    end;
                else
                    local ByModel = Enemy_Manager.GetByModel(v20);

                    if ByModel and ByModel.Is_Alive then
                        p16:Apply_Damage(v20, (p16:ResolveSkillDamage(u1.DamagePercent, v20)));
                    elseif v20:HasTag("Enemy") then
                        p16:Apply_Damage(v20, (p16:ResolveSkillDamage(u1.DamagePercent, v20)));
                    end;
                end;
            end;
        end;
    end;
end;

function u1._FireParticles(p21) -- Line: 201
    if not p21:HasTag("ParticleObject") then
        p21:AddTag("ParticleObject");
    end;

    p21:SetAttribute("Fire", not p21:GetAttribute("Fire"));
end;

return u1;