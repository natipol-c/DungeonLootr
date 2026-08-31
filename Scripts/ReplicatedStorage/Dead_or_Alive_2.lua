--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Dead_or_Alive
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Founder.Dead_or_Alive
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:34 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_2",
    MaxDuration = 4,
    HitboxSize = Vector3.new(14, 18, 25),
    HitboxRange = 25
};

function u1._PerformHit(p2, p3) -- Line: 37
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

function u1.Activate(u6, u7) -- Line: 59
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Dead_or_Alive] Animation not found:", u1.AnimationName);

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
    local u10 = 0;
    local u11 = u6.ClassData.SwingVolume or 1;
    local v15 = v8:GetMarkerReachedSignal("hit"):Connect(function(p12) -- Line: 83
        -- upvalues: u10 (ref), u6 (copy), SharedUtils (ref), u11 (copy), u1 (ref), u7 (copy)
        u10 = u10 + 1;
        local v13 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v13 then
            SharedUtils.PlaySoundAt(v13, u10 <= 2 and "Fire_Woosh" or "Dark_Echo", u11);
        end;

        if u10 == 4 then
            u6:PlayTurnFX("Dash_Attack");

            if v13 then
                SharedUtils.PlaySoundAt(v13, "Tsujigiri_Swing", u11);
            end;

            task.delay(0.3, function() -- Line: 97
                -- upvalues: u6 (ref), SharedUtils (ref), u11 (ref)
                local v14 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

                if v14 then
                    SharedUtils.PlaySoundAt(v14, "Tiger_Roar", u11);
                end;
            end);
        end;

        if p12 and p12 ~= "" then
            u6:PlayTurnFX(p12);
        end;

        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 111
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 115
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v15 then
        v15:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;