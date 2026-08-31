--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Disorder_Type
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Chaotic Fist.Disorder_Type
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
    AnimationName = "Ability_3",
    MaxDuration = 5,
    HitboxSize = Vector3.new(19, 22, 32),
    HitboxRange = 32
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
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Kieru Disorder_Type] Animation not found:", u1.AnimationName);

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
    local u10 = false;
    v8:Play(0, 1, u7.AnimSpeed or 1);
    local v12 = v8:GetMarkerReachedSignal("start"):Connect(function() -- Line: 81
        -- upvalues: u10 (ref), u6 (copy)
        u10 = true;
        local v11 = u6.FX and u6.FX.Ability_3;

        if v11 then
            v11:SetAttribute("FX_Activate", true);
        end;
    end);
    local v14 = v8:GetMarkerReachedSignal("end"):Connect(function() -- Line: 91
        -- upvalues: u10 (ref), u6 (copy)
        if u10 then
            local v13 = u6.FX and u6.FX.Ability_3;

            if v13 then
                v13:SetAttribute("FX_Activate", false);
            end;

            u10 = false;
        end;
    end);
    local v17 = v8:GetMarkerReachedSignal("hit"):Connect(function(p15) -- Line: 103
        -- upvalues: u6 (copy), SharedUtils (ref), u1 (ref), u7 (copy)
        local v16 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v16 then
            SharedUtils.PlaySoundAt(v16, "Punch_Shot_1", 1);
        end;

        u1._PerformHit(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 115
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 120
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v17 then
        v17:Disconnect();
    end;

    if v12 then
        v12:Disconnect();
    end;

    if v14 then
        v14:Disconnect();
    end;

    if u10 then
        local v18 = u6.FX and u6.FX.Ability_3;

        if v18 then
            v18:SetAttribute("FX_Activate", false);
        end;

        u10 = false;
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;