--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Black_Divider_Final
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Anti Magic.Black_Divider_Final
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u5 = {
    AnimationName = "Ability_4",
    MaxDuration = 2.5,
    LingerDuration = 4,
    TickInterval = 0.25,

    _PerformHit = function(p1, p2) -- Line: 56, Name: _PerformHit
        local v3 = p1:QueryHitbox(p2.HitboxSize, p2.HitboxRange);
        local v4 = p1:ResolveSkillDamage(p2.DamageMultiplier);

        for _, v in v3 do
            p1:ApplyDamage(v.Character, v4);
        end;
    end
};

function u5._StartLingeringZone(u6, u7) -- Line: 71
    -- upvalues: u5 (copy)
    local u8 = u7.LingerDuration or u5.LingerDuration;
    local u9 = u7.TickInterval or u5.TickInterval;
    task.spawn(function() -- Line: 75
        -- upvalues: u8 (copy), u6 (copy), u5 (ref), u7 (copy), u9 (copy)
        local v10 = 0;

        while v10 < u8 do
            local Character = u6.Character;
            local v11;

            if Character then
                v11 = Character:FindFirstChild("HumanoidRootPart");
            else
                v11 = Character;
            end;

            if not Character or (not Character.Parent or (not v11 or Character:GetAttribute("Dead"))) then
                break;
            end;

            u5._PerformHit(u6, u7);
            task.wait(u9);
            v10 = v10 + u9;
        end;
    end);
end;

function u5.Activate(u12, u13) -- Line: 100
    -- upvalues: u5 (copy), SharedUtils (copy)
    local v14 = u12.Animations[u5.AnimationName];

    if not v14 then
        warn("[Boss Black_Divider_Final] Animation not found:", u5.AnimationName);

        return;
    end;

    local Character = u12.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u12.Is_Using_Skill = true;
    u12.Is_Attacking = true;
    local u15 = false;
    v14:Play(0, 1, u13.AnimSpeed or 1);
    local v18 = v14:GetMarkerReachedSignal("hit"):Connect(function(p16) -- Line: 122
        -- upvalues: u12 (copy), SharedUtils (ref), u5 (ref), u13 (copy)
        local v17 = u12.Character and u12.Character:FindFirstChild("HumanoidRootPart");

        if v17 then
            SharedUtils.PlaySoundAt(v17, "power_spin_04", 1);
            SharedUtils.PlaySoundAt(v17, "explosion_punch", 1);
        end;

        if p16 == "" or not p16 then
            p16 = nil;
        end;

        u12:PlayTurnFX(p16);
        u5._StartLingeringZone(u12, u13);
    end);
    v14.Stopped:Once(function() -- Line: 138
        -- upvalues: u15 (ref)
        u15 = true;
    end);
    task.delay(u5.MaxDuration, function() -- Line: 143
        -- upvalues: u15 (ref)
        u15 = true;
    end);

    while not u15 do
        task.wait();
    end;

    if v18 then
        v18:Disconnect();
    end;

    u12.Is_Using_Skill = false;
    u12.Is_Attacking = false;
end;

return u5;