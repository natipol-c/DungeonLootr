--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Heart_Stab
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Kage.Heart_Stab
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_2",
    MaxDuration = 4,
    HitboxSize = Vector3.new(20, 15, 20),
    HitboxRange = 15,
    WarpSearchRange = 80,
    WarpBehindOffset = 5,
    MinHPPercent = 0.2
};

function u1._FindEligibleTarget(p2) -- Line: 54
    -- upvalues: u1 (copy), Players (copy)
    local v3 = p2.Character and p2.Character:FindFirstChild("HumanoidRootPart");

    if not v3 then
        return nil;
    end;

    local Position = v3.Position;
    local v4 = u1.WarpSearchRange + 1;
    local v5 = nil;

    for _, v in Players:GetPlayers() do
        if not v:GetAttribute("IsSpectating") then
            local Character = v.Character;

            if Character and not Character:GetAttribute("Dead") then
                local v6 = Character:FindFirstChildOfClass("Humanoid");

                if v6 and (v6.MaxHealth > 0 and v6.Health / v6.MaxHealth >= u1.MinHPPercent) then
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

                    if HumanoidRootPart then
                        local Magnitude = (HumanoidRootPart.Position - Position).Magnitude;

                        if Magnitude <= u1.WarpSearchRange and Magnitude < v4 then
                            v4 = Magnitude;
                            v5 = {
                                character = Character,
                                hrp = HumanoidRootPart
                            };
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v5;
end;

function u1._WarpBehind(p7, p8) -- Line: 86
    -- upvalues: u1 (copy)
    local v9 = p7.Character and p7.Character:FindFirstChild("HumanoidRootPart");

    if not (v9 and p8.hrp) then
        return;
    end;

    local v10 = p8.hrp.CFrame * CFrame.new(0, 0, u1.WarpBehindOffset);
    v9.CFrame = CFrame.new(v10.Position, p8.hrp.Position);
end;

function u1._PerformHit(p11, p12) -- Line: 95
    -- upvalues: u1 (copy)
    local HitboxSize = p11.ClassData.HitboxSize;
    local Range = p11.ClassData.Range;
    p11.ClassData.HitboxSize = p12.HitboxSize or u1.HitboxSize;
    p11.ClassData.Range = p12.HitboxRange or u1.HitboxRange;
    local v13 = p11:QueryHitbox();
    p11.ClassData.HitboxSize = HitboxSize;
    p11.ClassData.Range = Range;
    local v14 = p11:ResolveSkillDamage(p12.DamageMultiplier);

    for _, v in v13 do
        p11:ApplyDamage(v.Character, v14);
    end;
end;

function u1.Activate(u15, u16) -- Line: 117
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v17 = u15.Animations[u1.AnimationName];

    if not v17 then
        warn("[Boss Heart_Stab] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u15.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;
    local u18 = false;
    local u19 = u1._FindEligibleTarget(u15);
    v17:Play(0, 1, u16.AnimSpeed or 1);
    local v22 = v17:GetMarkerReachedSignal("teleport"):Connect(function(p20) -- Line: 142
        -- upvalues: u15 (copy), SharedUtils (ref), u19 (copy), u1 (ref)
        local v21 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if not v21 then
            return;
        end;

        SharedUtils.PlaySoundAt(v21, "Dark_Chase", 1);

        if u19 then
            u1._WarpBehind(u15, u19);
        end;
    end);
    local v24 = v17:GetMarkerReachedSignal("hit"):Connect(function(p23) -- Line: 155
        -- upvalues: u16 (copy), u15 (copy), u1 (ref)
        u15:PlayCombatSound(u16.SwingSoundFolder or (u15.ClassData.SwingSoundFolder or "Magic_Swings"), nil, u15.ClassData.SwingVolume or 1);

        if p23 == "" or not p23 then
            p23 = nil;
        end;

        u15:PlayTurnFX(p23);
        u1._PerformHit(u15, u16);
    end);
    v17.Stopped:Once(function() -- Line: 163
        -- upvalues: u18 (ref)
        u18 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 167
        -- upvalues: u18 (ref)
        u18 = true;
    end);

    while not u18 do
        task.wait();
    end;

    if v24 then
        v24:Disconnect();
    end;

    if v22 then
        v22:Disconnect();
    end;

    u15.Is_Using_Skill = false;
    u15.Is_Attacking = false;
end;

return u1;