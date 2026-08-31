--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Air_Type
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Chaotic Fist.Air_Type
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:34 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_1",
    MaxDuration = 3,
    HitboxSize = Vector3.new(22, 30, 32),
    HitboxRange = 12
};

function u1._PerformHit(p2, p3) -- Line: 36
    -- upvalues: u1 (copy)
    local HitboxSize = p2.ClassData.HitboxSize;
    local Range = p2.ClassData.Range;
    p2.ClassData.HitboxSize = p3.HitboxSize or u1.HitboxSize;
    p2.ClassData.Range = p3.HitboxRange or u1.HitboxRange;
    local v4 = p2:QueryHitbox();
    p2.ClassData.HitboxSize = HitboxSize;
    p2.ClassData.Range = Range;
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 58
    -- upvalues: u1 (copy), SharedUtils (copy), Debris (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Kieru Air_Type] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u6.Character;
    local v9;

    if Character then
        v9 = Character:FindFirstChild("HumanoidRootPart");
    else
        v9 = Character;
    end;

    if not v9 then
        return;
    end;

    u6.Is_Using_Skill = true;
    u6.Is_Attacking = true;
    local u10 = false;
    v8:Play(0, 1, u7.AnimSpeed or 1);
    SharedUtils.PlaySoundAt(v9, "Dark_Dash", 1);
    local v11 = u7.IFrameDuration or 0.7;
    Character:SetAttribute("Dodge", true);
    task.delay(v11, function() -- Line: 84
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    local u12 = nil;
    local v19 = v8:GetMarkerReachedSignal("float"):Connect(function(p13) -- Line: 93
        -- upvalues: u6 (copy), u7 (copy), Debris (ref), u12 (ref)
        local u14 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not u14 then
            return;
        end;

        if p13 ~= "Start" then
            if p13 == "End" and (u12 and u12.Parent) then
                u12:Destroy();
                u12 = nil;
            end;

            return;
        end;

        local v15 = -u14.CFrame.LookVector;
        local v16 = u7.FloatUpSpeed or 40;
        local v17 = u7.FloatBackSpeed or 20;
        local v18 = u7.FloatLaunchDur or 0.35;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossAirTypeLaunch";
        BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
        BodyVelocity.Velocity = Vector3.new(0, 1, 0) * v16 + v15 * v17;
        BodyVelocity.Parent = u14;
        Debris:AddItem(BodyVelocity, v18);
        task.delay(v18, function() -- Line: 112
            -- upvalues: u14 (copy), u6 (ref), u12 (ref)
            if not (u14 and u14.Parent) then
                return;
            end;

            if not u6.Is_Using_Skill then
                return;
            end;

            u12 = Instance.new("BodyVelocity");
            u12.Name = "BossAirTypeHold";
            u12.MaxForce = Vector3.new(100000, 100000, 100000);
            u12.Velocity = Vector3.new(0, 0, 0);
            u12.Parent = u14;
        end);
    end);
    local v22 = v8:GetMarkerReachedSignal("hit"):Connect(function(p20) -- Line: 133
        -- upvalues: u6 (copy), u1 (ref), u7 (copy)
        u6:PlayCombatSound(u6.ClassData.SwingSoundFolder or "Naoya_Punches", nil, u6.ClassData.SwingVolume or 1);

        if p20 and p20 ~= "" then
            local u21 = u6.FX and u6.FX[p20];

            if u21 then
                u21:SetAttribute("FX_Activate", true);
                task.delay(0.5, function() -- Line: 143
                    -- upvalues: u21 (copy)
                    if u21 and u21.Parent then
                        u21:SetAttribute("FX_Activate", false);
                    end;
                end);
            end;
        end;

        u6:PlayTurnFX(nil);
        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 159
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 164
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v22 then
        v22:Disconnect();
    end;

    if v19 then
        v19:Disconnect();
    end;

    if u12 and u12.Parent then
        u12:Destroy();
        u12 = nil;
    end;

    Character:SetAttribute("Dodge", false);
    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;