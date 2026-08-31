--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Soul_Rend
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Reaper.Soul_Rend
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
    AnimationName = "Ability_4",
    MaxDuration = 4,
    HitboxSize = Vector3.new(20, 12, 22),
    HitboxRange = 22
};

function u1._PerformHit(p2, p3) -- Line: 38
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
        warn("[Boss Soul_Rend] Animation not found:", u1.AnimationName);

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
    local v13 = v8:GetMarkerReachedSignal("hit"):Connect(function(p11) -- Line: 82
        -- upvalues: u10 (ref), u6 (copy), SharedUtils (ref), u1 (ref), u7 (copy)
        u10 = u10 + 1;
        local v12 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v12 then
            if u10 == 1 then
                SharedUtils.PlaySoundAt(v12, "Dark_Swing", 1);
            else
                SharedUtils.PlaySoundAt(v12, "Dark_Echo", 1);
            end;

            SharedUtils.PlaySoundAt(v12, "Rolling_Swing", 1);
        end;

        if p11 == "" or not p11 then
            p11 = nil;
        end;

        u6:PlayTurnFX(p11);
        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 102
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 107
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v13 then
        v13:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;