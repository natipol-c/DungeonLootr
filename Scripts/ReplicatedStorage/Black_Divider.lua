--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Black_Divider
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Anti Magic.Black_Divider
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u6 = {
    AnimationName = "Ability_3",
    MaxDuration = 3,
    MainMultiplier = 3,
    FinisherMultiplier = 6.5,

    _PerformHit = function(p1, p2, p3) -- Line: 52, Name: _PerformHit
        local v4 = p1:QueryHitbox(p2.HitboxSize, p2.HitboxRange);
        local v5 = p1:ResolveSkillDamage(p3);

        for _, v in v4 do
            p1:ApplyDamage(v.Character, v5);
        end;
    end
};

function u6.Activate(u7, u8) -- Line: 67
    -- upvalues: u6 (copy), SharedUtils (copy)
    local v9 = u7.Animations[u6.AnimationName];

    if not v9 then
        warn("[Boss Black_Divider] Animation not found:", u6.AnimationName);

        return;
    end;

    local Character = u7.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u7.Is_Using_Skill = true;
    u7.Is_Attacking = true;
    local u10 = false;
    local u11 = u8.DamageMultiplier or u6.MainMultiplier;
    local u12 = u8.FinisherMultiplier or u6.FinisherMultiplier;
    v9:Play(0, 1, u8.AnimSpeed or 1);
    local u13 = 0;
    local v17 = v9:GetMarkerReachedSignal("hit"):Connect(function(p14) -- Line: 94
        -- upvalues: u13 (ref), u7 (copy), SharedUtils (ref), u11 (copy), u12 (copy), u6 (ref), u8 (copy)
        u13 = u13 + 1;
        local v15 = u7.Character and u7.Character:FindFirstChild("HumanoidRootPart");

        if v15 then
            if u13 == 1 then
                SharedUtils.PlaySoundAt(v15, "anime_explode", 1);
                SharedUtils.PlaySoundAt(v15, "power_spin_01", 1);
            elseif u13 == 2 then
                SharedUtils.PlaySoundAt(v15, "anime_explode", 1);
                SharedUtils.PlaySoundAt(v15, "power_spin_02", 1);
            elseif u13 == 3 then
                SharedUtils.PlaySoundAt(v15, "explosion_punch", 1);
                SharedUtils.PlaySoundAt(v15, "power_spin_04", 1);
            end;
        end;

        if p14 == "" or not p14 then
            p14 = nil;
        end;

        u7:PlayTurnFX(p14);
        local v16;

        if u13 <= 2 then
            v16 = u11;
        else
            v16 = u12;
        end;

        u6._PerformHit(u7, u8, v16);
    end);
    v9.Stopped:Once(function() -- Line: 121
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u6.MaxDuration, function() -- Line: 126
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    if v17 then
        v17:Disconnect();
    end;

    u7.Is_Using_Skill = false;
    u7.Is_Attacking = false;
end;

return u6;