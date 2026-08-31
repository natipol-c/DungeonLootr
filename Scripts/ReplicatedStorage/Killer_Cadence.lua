--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Killer_Cadence
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Unrestricted.Killer_Cadence
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u7 = {
    AnimationName = "Ability_1",
    MaxDuration = 3,
    ChipMultiplier = 1.5,
    FinisherMultiplier = 8,
    HitboxSize = Vector3.new(22, 20, 32),
    HitboxRange = 5,
    HitSFX = {
        [1] = "Sword_Clash_4",
        [4] = "anime_explode"
    },

    _PerformHit = function(p1, p2, p3, p4) -- Line: 62, Name: _PerformHit
        local v5 = p1:QueryHitbox(p3, p4);
        local v6 = p1:ResolveSkillDamage(p2);

        for _, v in v5 do
            p1:ApplyDamage(v.Character, v6);
        end;
    end
};

function u7.Activate(u8, u9) -- Line: 74
    -- upvalues: u7 (copy), SharedUtils (copy)
    local v10 = u8.Animations[u7.AnimationName];

    if not v10 then
        warn("[Boss Killer_Cadence] Animation not found:", u7.AnimationName);

        return;
    end;

    local Character = u8.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u8.Is_Using_Skill = true;
    u8.Is_Attacking = true;
    local u11 = false;
    local u12 = u9.DamageMultiplier or u7.ChipMultiplier;
    local u13 = u9.FinalDamageMult or u7.FinisherMultiplier;
    local u14 = u9.HitboxSize or u7.HitboxSize;
    local u15 = u9.HitboxRange or u7.HitboxRange;
    v10:Play(0, 1, u9.AnimSpeed or 1);
    local u16 = 0;
    local v22 = v10:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 103
        -- upvalues: u16 (ref), u8 (copy), u7 (ref), SharedUtils (ref), u9 (copy), u12 (copy), u13 (copy), u14 (copy), u15 (copy)
        u16 = u16 + 1;
        local v18 = u8.ClassData.SwingVolume or 1;
        local v19 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");
        local v20 = u7.HitSFX[u16];

        if v20 and v19 then
            SharedUtils.PlaySoundAt(v19, v20, v18);
        else
            u8:PlayCombatSound(u9.SwingSoundFolder or (u8.ClassData.SwingSoundFolder or "Chain_Swing"), nil, v18);
        end;

        if p17 == "" or not p17 then
            p17 = nil;
        end;

        u8:PlayTurnFX(p17);
        local v21;

        if u16 <= 3 then
            v21 = u12;
        else
            v21 = u13;
        end;

        u7._PerformHit(u8, v21, u14, u15);
    end);
    v10.Stopped:Once(function() -- Line: 129
        -- upvalues: u11 (ref)
        u11 = true;
    end);
    task.delay(u7.MaxDuration, function() -- Line: 134
        -- upvalues: u11 (ref)
        u11 = true;
    end);

    while not u11 do
        task.wait();
    end;

    if v22 then
        v22:Disconnect();
    end;

    u8.Is_Using_Skill = false;
    u8.Is_Attacking = false;
end;

return u7;