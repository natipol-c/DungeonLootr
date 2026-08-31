--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hollow_Rush
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Azure Devil.Hollow_Rush
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
    MaxDuration = 2.5,
    HitboxSize = Vector3.new(16, 12, 20),
    HitboxRange = 20
};

function u1._PerformHit(p2, p3) -- Line: 39
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
    local v8 = u7._animKey or u1.AnimationName;
    local v9 = u6.Animations[v8];

    if not v9 then
        warn("[Boss Hollow_Rush] Animation not found:", v8);

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
    local u10 = false;
    v9:Play(0, 1, u7.AnimSpeed or 1);
    SharedUtils.PlaySoundAt(Character, "Dark_Dash", 1);
    local v14 = v9:GetMarkerReachedSignal("dash"):Connect(function(p11) -- Line: 82
        -- upvalues: u6 (copy), u7 (copy), Debris (ref)
        local v12 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v12 then
            return;
        end;

        local v13;

        if p11 == "Back" then
            v13 = -v12.CFrame.LookVector;
        else
            v13 = v12.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v13 * (u7.DashSpeed or 80);
        BodyVelocity.Parent = v12;
        Debris:AddItem(BodyVelocity, u7.DashDuration or 0.3);
    end);
    local v17 = v9:GetMarkerReachedSignal("hit"):Connect(function(p15) -- Line: 100
        -- upvalues: u6 (copy), SharedUtils (ref), u1 (ref), u7 (copy)
        local v16 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v16 then
            SharedUtils.PlaySoundAt(v16, "Fire_Woosh", 1);
        end;

        if p15 == "" or not p15 then
            p15 = nil;
        end;

        u6:PlayTurnFX(p15);
        u1._PerformHit(u6, u7);
    end);
    v9.Stopped:Once(function() -- Line: 110
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 114
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v14 then
        v14:Disconnect();
    end;

    if v17 then
        v17:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;