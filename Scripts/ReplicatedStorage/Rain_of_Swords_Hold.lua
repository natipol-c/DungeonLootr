--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rain_of_Swords_Hold
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Forge Archon.Rain_of_Swords_Hold
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_3_Hold",
    MaxDuration = 4,
    HitboxSize = Vector3.new(32, 50, 32),
    HitboxRange = 15,
    FloatUpSpeed = 80,
    FloatBackSpeed = 40,
    FloatLaunchDur = 0.15
};

function u1._PerformHit(p2, p3) -- Line: 52
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 67
    -- upvalues: u1 (copy), SharedUtils (copy), Debris (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Rain_of_Swords_Hold] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u6.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u6.Is_Using_Skill = true;
    u6.Is_Attacking = true;
    local u9 = false;
    v8:Play(0, 1, u7.AnimSpeed or 1);
    SharedUtils.PlaySoundAt(Character, "Dark_Dash", 1);
    u6:PlayCombatSound("Bow_Shot3", nil, u6.ClassData.SwingVolume or 1);
    local u10 = nil;
    local v17 = v8:GetMarkerReachedSignal("float"):Connect(function(p11) -- Line: 94
        -- upvalues: u6 (copy), u7 (copy), u1 (ref), Debris (ref), u10 (ref)
        local u12 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not u12 then
            return;
        end;

        if p11 ~= "Start" then
            if p11 == "End" and (u10 and u10.Parent) then
                u10:Destroy();
                u10 = nil;
            end;

            return;
        end;

        local v13 = -u12.CFrame.LookVector;
        local v14 = u7.FloatUpSpeed or u1.FloatUpSpeed;
        local v15 = u7.FloatBackSpeed or u1.FloatBackSpeed;
        local v16 = u7.FloatLaunchDur or u1.FloatLaunchDur;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossRainOfSwordsLaunch";
        BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
        BodyVelocity.Velocity = Vector3.new(0, 1, 0) * v14 + v13 * v15;
        BodyVelocity.Parent = u12;
        Debris:AddItem(BodyVelocity, v16);
        task.delay(v16, function() -- Line: 115
            -- upvalues: u12 (copy), u6 (ref), u10 (ref)
            if not (u12 and u12.Parent) then
                return;
            end;

            if not u6.Is_Using_Skill then
                return;
            end;

            u10 = Instance.new("BodyVelocity");
            u10.Name = "BossRainOfSwordsHold";
            u10.MaxForce = Vector3.new(100000, 100000, 100000);
            u10.Velocity = Vector3.new(0, 0, 0);
            u10.Parent = u12;
        end);
    end);
    local u18 = false;
    local v22 = v8:GetMarkerReachedSignal("hit"):Connect(function(p19) -- Line: 138
        -- upvalues: u18 (ref), u6 (copy), SharedUtils (ref), u1 (ref), u7 (copy)
        if u18 then
            return;
        end;

        u18 = true;
        local v20 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            SharedUtils.PlaySoundAt(v20, "Dark_Dash", 1);
        end;

        u6:PlayCombatSound("Bow_Shot3", nil, u6.ClassData.SwingVolume or 1);
        local v21 = u6.FX and u6.FX.Down_Shot;

        if v21 then
            v21:SetAttribute("Fire", not v21:GetAttribute("Fire"));
        end;

        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 161
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 166
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v17 then
        v17:Disconnect();
    end;

    if v22 then
        v22:Disconnect();
    end;

    if u10 and u10.Parent then
        u10:Destroy();
        u10 = nil;
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;