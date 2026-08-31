--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Judgement
  Path:     game.ReplicatedStorage.Weapons.Weapon_Skills.Judgement
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:08 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local Enemy_Manager = require(ReplicatedStorage.Enemies.Modules.Enemy_Manager);
u1.DefaultCooldown = 10;
u1.DamagePercent = 0.65;
u1.TotalHits = 15;
u1.HitInterval = 0.08;
u1.HitboxSize = Vector3.new(8, 6, 15);
u1.SlashOptions = { "Center_Slash", "Left_Slash", "Right_Slash", "Side_Slash" };

function u1.CanActivate(p2) -- Line: 33
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

function u1.Activate(u3) -- Line: 45
    -- upvalues: ReplicatedStorage (copy), SoundService (copy), u1 (copy), SharedUtils (copy)
    local Character = u3.Player.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    Character:SetAttribute("Combat_Facing", true);
    local Attack_1 = u3.Animations.Attack_1;

    if not Attack_1 then
        warn("Judgement: Missing \'Attack_1\' animation");
        u3.Is_Using_Skill = false;
        u3.Is_Attacking = false;

        return;
    end;

    local v4 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Combat_Sounds") and ReplicatedStorage.Assets.Combat_Sounds:FindFirstChild("Magic_Swings");
    local u5 = {};

    if v4 then
        for _, child in v4:GetChildren() do
            if child:IsA("Sound") then
                table.insert(u5, child);
            end;
        end;
    end;

    if #u5 == 0 then
        warn("Judgement: No sounds found in Magic_Swings folder");
    end;

    local v6 = SoundService:FindFirstChild("SFX") and SoundService.SFX:FindFirstChild("Judgement_Cut");

    if v6 then
        local u7 = v6:Clone();
        u7.Parent = HumanoidRootPart;
        u7:Play();
        u7.Ended:Once(function() -- Line: 92
            -- upvalues: u7 (copy)
            u7:Destroy();
        end);
    else
        warn("Judgement: Missing SoundService.SFX.Judgement_Cut");
    end;

    local v8 = u1.TotalHits * u1.HitInterval;
    Attack_1:Play(0, 1, (math.max(0.5, Attack_1.Length / v8)));
    local u9 = 0;

    for i = 1, u1.TotalHits do
        task.delay((i - 1) * u1.HitInterval, function() -- Line: 109
            -- upvalues: u3 (copy), u1 (ref), u9 (ref), u5 (copy), SharedUtils (ref), HumanoidRootPart (copy)
            if not u3.Is_Using_Skill then
                return;
            end;

            if not u3.Player then
                return;
            end;

            local v10 = u1._GetRandomExcluding(#u1.SlashOptions, u9);
            u9 = v10;
            local v11 = u3.FX[u1.SlashOptions[v10]];

            if v11 then
                u1._FireParticles(v11);
            end;

            if #u5 > 0 then
                local v12 = u5[math.random(1, #u5)];
                SharedUtils.PlaySoundAt(HumanoidRootPart, v12);
            end;

            u1._PerformHit(u3);
        end);
        local _ = i;
    end;

    task.delay(v8 + 0.2, function() -- Line: 137
        -- upvalues: u3 (copy), Character (copy), Attack_1 (copy)
        if u3.Player then
            u3.Is_Using_Skill = false;
            u3.Is_Attacking = false;
        end;

        Character:SetAttribute("Combat_Facing", false);

        if Attack_1.IsPlaying then
            Attack_1:Stop();
        end;
    end);
end;

function u1._GetRandomExcluding(p13, p14) -- Line: 154
    if p13 <= 1 then
        return 1;
    end;

    local v15;

    repeat
        v15 = math.random(1, p13);
    until v15 ~= p14;

    return v15;
end;

function u1._PerformHit(p16) -- Line: 168
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

function u1._FireParticles(p21) -- Line: 246
    if not p21:HasTag("ParticleObject") then
        p21:AddTag("ParticleObject");
    end;

    p21:SetAttribute("Fire", not p21:GetAttribute("Fire"));
end;

return u1;