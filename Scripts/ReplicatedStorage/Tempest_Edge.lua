--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Tempest_Edge
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Jetstream.Tempest_Edge
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_3",
    EffectModule = "Tempest_Edge",
    MaxDuration = 2.4,
    DamageMultiplier = 1.3,
    HitboxSize = Vector3.new(28, 16, 32),
    HitboxRange = 28,
    FinisherParam = "6",
    SheatheSFX = "Sheathe_1"
};

function u1._PerformHit(p2, p3) -- Line: 45
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 55
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Tempest_Edge] Animation not found:", u1.AnimationName);

        return;
    end;

    local v9 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

    if not v9 then
        return;
    end;

    u6.Is_Using_Skill = true;
    u6.Is_Attacking = true;
    local u10 = false;
    v8:Play(0, 1, u7.AnimSpeed or 1);
    local v13 = {
        [#v13 + 1] = v8:GetMarkerReachedSignal("VFX"):Connect(function(p11) -- Line: 74
            -- upvalues: u6 (copy), u1 (ref), SharedUtils (ref)
            if not p11 or p11 == "" then
                return;
            end;

            local v12 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

            if not v12 then
                return;
            end;

            if p11 == u1.FinisherParam then
                SharedUtils.PlaySoundAt(v12, u1.SheatheSFX, 0.85);
            end;

            u6:PlayEffectModule(u1.EffectModule, "Emit", v12.CFrame, p11);
        end),
        [#v13 + 1] = v8:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 85
            -- upvalues: u6 (copy), u7 (copy), u1 (ref)
            u6:PlayCombatSound(u7.SwingSoundFolder or (u6.ClassData.SwingSoundFolder or "Electric_Swing"), nil, u6.ClassData.SwingVolume or 1);
            u1._PerformHit(u6, u7);
        end),
        [#v13 + 1] = v8:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 95
            -- upvalues: u10 (ref)
            u10 = true;
        end)
    };
    v8.Stopped:Once(function() -- Line: 96
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u7.MaxDuration or u1.MaxDuration, function() -- Line: 97
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    for _, v in v13 do
        v:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;