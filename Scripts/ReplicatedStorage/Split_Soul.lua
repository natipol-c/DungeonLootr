--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Split_Soul
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Unrestricted.Split_Soul
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_2",
    MaxDuration = 4,
    DamageMultiplier = 14,
    HitboxSize = Vector3.new(45, 40, 45),
    HitboxRange = 0,
    FX_Name = "Barrage",
    StartSFX = "Multiple_Dismantle",
    EndSFX = "sukuna_slash_single"
};

function u1._PerformDetonation(p2, p3) -- Line: 54
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier or u1.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 71
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Split_Soul] Animation not found:", u1.AnimationName);

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
    local u11 = u6.FX and u6.FX[u1.FX_Name];
    v8:Play(0, 1, u7.AnimSpeed or 1);
    local v14 = v8:GetMarkerReachedSignal("Start"):Connect(function(p12) -- Line: 97
        -- upvalues: u11 (copy), u10 (ref), u6 (copy), SharedUtils (ref), u1 (ref)
        if u11 and u11.Parent then
            u11:SetAttribute("FX_Activate", true);
            u10 = true;
        end;

        local v13 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v13 then
            SharedUtils.PlaySoundAt(v13, u1.StartSFX, u6.ClassData.SwingVolume or 1);
        end;
    end);
    local v17 = v8:GetMarkerReachedSignal("End"):Connect(function(p15) -- Line: 115
        -- upvalues: u10 (ref), u11 (copy), u6 (copy), SharedUtils (ref), u1 (ref), u7 (copy)
        if u10 and (u11 and u11.Parent) then
            u11:SetAttribute("FX_Activate", false);
            u10 = false;
        end;

        local v16 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v16 then
            SharedUtils.PlaySoundAt(v16, u1.EndSFX, u6.ClassData.SwingVolume or 1);
        end;

        u1._PerformDetonation(u6, u7);
    end);
    v8.Stopped:Once(function() -- Line: 134
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 139
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if v14 then
        v14:Disconnect();
    end;

    if v17 then
        v17:Disconnect();
    end;

    if u10 and (u11 and u11.Parent) then
        u11:SetAttribute("FX_Activate", false);
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;