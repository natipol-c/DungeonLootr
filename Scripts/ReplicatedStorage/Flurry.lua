--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Flurry
  Path:     game.ReplicatedStorage.Weapons.Weapon_Skills.Flurry
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
u1.DefaultCooldown = 7;
u1.DamagePercent = 0.8;
u1.TotalHits = 6;
u1.HitInterval = 0.3;
u1.HitboxSize = Vector3.new(15, 15, 15);
u1.AnimSpeed = 1.2;
u1.AnimationSequence = { "Attack_1", "Attack_2", "Attack_3", "Attack_4" };
u1.SlashOptions = { "Reverse_Left_Slash", "Left_Slash", "Right_Slash" };

function u1.CanActivate(p2) -- Line: 41
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

function u1.Activate(u3) -- Line: 53
    -- upvalues: ReplicatedStorage (copy), SoundService (copy), u1 (copy), SharedUtils (copy)
    local Character = u3.Player.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    Character:SetAttribute("Combat_Facing", true);
    local v4 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Combat_Sounds") and ReplicatedStorage.Assets.Combat_Sounds:FindFirstChild("Flame_Swing");
    local u5 = {};

    if v4 then
        for _, child in v4:GetChildren() do
            if child:IsA("Sound") then
                table.insert(u5, child);
            end;
        end;
    end;

    if #u5 == 0 then
        warn("Flurry: No sounds found in Magic_Swings folder");
    end;

    local v6 = SoundService:FindFirstChild("SFX") and SoundService.SFX:FindFirstChild("Fire Punch");

    if v6 then
        local u7 = v6:Clone();
        u7.Parent = HumanoidRootPart;
        u7:Play();
        u7.Ended:Once(function() -- Line: 90
            -- upvalues: u7 (copy)
            u7:Destroy();
        end);
    end;

    local v8 = u1.TotalHits * u1.HitInterval;
    local u9 = 0;

    for i = 1, u1.TotalHits do
        task.delay((i - 1) * u1.HitInterval, function() -- Line: 101
            -- upvalues: u3 (copy), i (copy), u1 (ref), u9 (ref), u5 (copy), SharedUtils (ref), HumanoidRootPart (copy)
            if not u3.Is_Using_Skill then
                return;
            end;

            if not u3.Player then
                return;
            end;

            local v10 = u3.Animations[u1.AnimationSequence[(i - 1) % #u1.AnimationSequence + 1]];

            if v10 then
                v10:Play(0);
                v10:AdjustSpeed(u1.AnimSpeed);
            end;

            local v11 = u1._GetRandomExcluding(#u1.SlashOptions, u9);
            u9 = v11;
            local v12 = u3.FX[u1.SlashOptions[v11]];

            if v12 then
                u1._FireParticles(v12);
            end;

            if #u5 > 0 then
                local v13 = u5[math.random(1, #u5)];
                SharedUtils.PlaySoundAt(HumanoidRootPart, v13);
            end;

            u1._PerformHit(u3);
        end);
        local _ = i;
    end;

    task.delay(v8 + 0.3, function() -- Line: 139
        -- upvalues: u3 (copy), Character (copy), u1 (ref)
        if u3.Player then
            u3.Is_Using_Skill = false;
            u3.Is_Attacking = false;
        end;

        Character:SetAttribute("Combat_Facing", false);

        for _, v in u1.AnimationSequence do
            local v14 = u3.Animations[v];

            if v14 and v14.IsPlaying then
                v14:Stop();
            end;
        end;
    end);
end;

function u1._GetRandomExcluding(p15, p16) -- Line: 159
    if p15 <= 1 then
        return 1;
    end;

    local v17;

    repeat
        v17 = math.random(1, p15);
    until v17 ~= p16;

    return v17;
end;

function u1._PerformHit(p18) -- Line: 173
    -- upvalues: u1 (copy), SharedUtils (copy), Enemy_Manager (copy)
    local v19 = p18.Player and p18.Player.Character;

    if not v19 then
        return;
    end;

    local HumanoidRootPart = v19:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v20 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -u1.HitboxSize.Z / 2);
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { v19 };
    local v21 = {
        [v19] = true
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

                            local HumanoidRootPart2 = v22:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart2 then
                                SharedUtils.ShowText(HumanoidRootPart2, "Dodged", Color3.fromRGB(100, 200, 255));
                            end;
                        elseif PlayerFromCharacter:GetAttribute("Protected") then
                            local HumanoidRootPart2 = v22:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart2 then
                                SharedUtils.ShowText(HumanoidRootPart2, "Protected", Color3.fromRGB(255, 255, 255));
                            end;
                        else
                            p18:Apply_Damage(v22, (p18:ResolveSkillDamage(u1.DamagePercent, v22)));
                        end;
                    end;
                else
                    local ByModel = Enemy_Manager.GetByModel(v22);

                    if ByModel and ByModel.Is_Alive then
                        p18:Apply_Damage(v22, (p18:ResolveSkillDamage(u1.DamagePercent, v22)));
                    elseif v22:HasTag("Enemy") then
                        p18:Apply_Damage(v22, (p18:ResolveSkillDamage(u1.DamagePercent, v22)));
                    end;
                end;
            end;
        end;
    end;
end;

function u1._FireParticles(p23) -- Line: 251
    if not p23:HasTag("ParticleObject") then
        p23:AddTag("ParticleObject");
    end;

    p23:SetAttribute("Fire", not p23:GetAttribute("Fire"));
end;

return u1;