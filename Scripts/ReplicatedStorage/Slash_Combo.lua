--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Slash_Combo
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Cursed King.Slash_Combo
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
    EffectModule = "Slash_Combo",
    MaxDuration = 2.5,
    DamageMultiplier = 1,
    TickInterval = 0.3,
    HitboxSize = Vector3.new(18, 12, 22),
    HitboxRange = 18,
    HitSFX = "hit_ultema_s_1",
    HitVolume = 1
};

function u1._Chip(p2, p3) -- Line: 48
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 61
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u7._animKey or u1.AnimationName;
    local v9 = u6.Animations[v8];

    if not v9 then
        warn("[Boss Slash_Combo] Animation not found:", v8);

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
    local u11 = false;
    local u12 = false;
    v9:Play(0, 1, u7.AnimSpeed or 1);
    local v15 = v9:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 84
        -- upvalues: u12 (ref), u6 (copy), u1 (ref), u11 (ref), u7 (copy), SharedUtils (ref)
        if u12 then
            return;
        end;

        u12 = true;
        local v13 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if not v13 then
            return;
        end;

        u6:PlayEffectModule(u1.EffectModule, "Start", v13.CFrame);
        u11 = true;
        task.spawn(function() -- Line: 94
            -- upvalues: u11 (ref), u6 (ref), u1 (ref), u7 (ref), SharedUtils (ref)
            while u11 and u6.Is_Using_Skill do
                u1._Chip(u6, u7);
                local v14 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

                if v14 then
                    SharedUtils.PlaySoundAt(v14, u7.HitSFX or u1.HitSFX, u7.HitVolume or u1.HitVolume);
                end;

                task.wait(u7.TickInterval or u1.TickInterval);
            end;
        end);
    end);
    local v16 = v9:GetMarkerReachedSignal("End"):Connect(function() -- Line: 108
        -- upvalues: u11 (ref)
        u11 = false;
    end);
    v9.Stopped:Once(function() -- Line: 113
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u7.MaxDuration or u1.MaxDuration, function() -- Line: 114
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    u11 = false;

    if v15 then
        v15:Disconnect();
    end;

    if v16 then
        v16:Disconnect();
    end;

    u6:PlayEffectModule(u1.EffectModule, "DBreset", Character.CFrame);
    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;