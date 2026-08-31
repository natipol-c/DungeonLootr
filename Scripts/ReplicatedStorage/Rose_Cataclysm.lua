--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rose_Cataclysm
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Dreadlord.Rose_Cataclysm
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
    AnimationName = "Ability_4",
    MaxDuration = 6,
    OpenerHitboxSize = Vector3.new(20, 20, 30),
    OpenerHitboxRange = 20,
    ExplosionHitboxSize = Vector3.new(30, 18, 30)
};

local function getFXPosition(p2) -- Line: 54
    if p2:IsA("BasePart") then
        return p2.Position;
    end;

    local v3 = p2:IsA("Model") and (p2.PrimaryPart or p2:FindFirstChildWhichIsA("BasePart"));

    if v3 then
        return v3.Position;
    end;

    return nil;
end;

local function getFXSoundAnchor(p4) -- Line: 65
    if p4:IsA("BasePart") then
        return p4;
    end;

    if p4:IsA("Model") then
        return p4.PrimaryPart or p4:FindFirstChildWhichIsA("BasePart");
    end;

    return nil;
end;

function u1._PerformOpenerHit(p5, p6) -- Line: 75
    -- upvalues: u1 (copy)
    local HitboxSize = p5.ClassData.HitboxSize;
    local Range = p5.ClassData.Range;
    p5.ClassData.HitboxSize = p6.OpenerHitboxSize or u1.OpenerHitboxSize;
    p5.ClassData.Range = p6.OpenerHitboxRange or u1.OpenerHitboxRange;
    local v7 = p5:QueryHitbox();
    p5.ClassData.HitboxSize = HitboxSize;
    p5.ClassData.Range = Range;
    local v8 = p5:ResolveSkillDamage(p6.OpenerDamageMult or p6.DamageMultiplier);

    for _, v in v7 do
        p5:ApplyDamage(v.Character, v8);
    end;
end;

function u1._PerformExplosionHit(p9, p10, p11) -- Line: 96
    -- upvalues: u1 (copy)
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { p9.Character };
    local v12 = p10.ExplosionHitboxSize or u1.ExplosionHitboxSize;
    local v13 = {};

    for _, v in workspace:GetPartBoundsInBox(CFrame.new(p11), v12, OverlapParams_new_ret) do
        local v14 = v:FindFirstAncestorOfClass("Model");

        if v14 and (not v13[v14] and v14:FindFirstChildOfClass("Humanoid")) then
            v13[v14] = true;
        end;
    end;

    local v15 = p9:ResolveSkillDamage(p10.ExplosionDamageMult or p10.DamageMultiplier);

    for i in v13 do
        p9:ApplyDamage(i, v15);
    end;
end;

function u1.Activate(u16, u17) -- Line: 127
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v18 = u16.Animations[u1.AnimationName];

    if not v18 then
        warn("[Boss Rose_Cataclysm] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u16.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u16.Is_Using_Skill = true;
    u16.Is_Attacking = true;
    local u19 = false;
    local u20 = false;

    local function disableRoseCharge() -- Line: 147
        -- upvalues: u20 (ref), u16 (copy)
        if not u20 then
            return;
        end;

        u20 = false;
        local v21 = u16.FX and u16.FX.Rose_Charge;

        if v21 then
            v21:SetAttribute("FX_Activate", false);
        end;
    end;

    v18:Play(0, 1, u17.AnimSpeed or 1);
    local v24 = v18:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 161
        -- upvalues: u20 (ref), u16 (copy), SharedUtils (ref)
        u20 = true;
        local v22 = u16.FX and u16.FX.Rose_Charge;

        if v22 then
            v22:SetAttribute("FX_Activate", true);
        end;

        local v23 = u16.Character and u16.Character:FindFirstChild("HumanoidRootPart");

        if v23 then
            SharedUtils.PlaySoundAt(v23, "spark_impact", 1);
        end;
    end);
    local v27 = v18:GetMarkerReachedSignal("End"):Connect(function() -- Line: 176
        -- upvalues: u20 (ref), u16 (copy), SharedUtils (ref)
        if u20 then
            u20 = false;
            local v25 = u16.FX and u16.FX.Rose_Charge;

            if v25 then
                v25:SetAttribute("FX_Activate", false);
            end;
        end;

        local v26 = u16.Character and u16.Character:FindFirstChild("HumanoidRootPart");

        if v26 then
            SharedUtils.PlaySoundAt(v26, "Water_Bass", 1);
        end;
    end);
    local u28 = 0;
    local v33 = v18:GetMarkerReachedSignal("hit"):Connect(function(p29) -- Line: 188
        -- upvalues: u28 (ref), u17 (copy), u16 (copy), u1 (ref), SharedUtils (ref)
        u28 = u28 + 1;

        if u28 == 1 then
            u16:PlayCombatSound(u17.SwingSoundFolder or u16.ClassData.SwingSoundFolder or "Flame_Swing", nil, u16.ClassData.SwingVolume or 1);
            u1._PerformOpenerHit(u16, u17);

            return;
        end;

        if type(p29) ~= "string" or p29 == "" then
            warn("[Boss Rose_Cataclysm] Hit " .. u28 .. " missing Explosion param");

            return;
        end;

        local v30 = u16.FX and u16.FX[p29];

        if not v30 then
            warn("[Boss Rose_Cataclysm] FX part not found:", p29);

            return;
        end;

        v30:SetAttribute("Fire", not v30:GetAttribute("Fire"));
        local v31;

        if v30:IsA("BasePart") then
            v31 = v30.Position;
        elseif v30:IsA("Model") then
            local v32 = v30.PrimaryPart or v30:FindFirstChildWhichIsA("BasePart");

            if v32 then
                v31 = v32.Position;
            else
                v31 = nil;
            end;
        else
            v31 = nil;
        end;

        if not v30:IsA("BasePart") then
            if v30:IsA("Model") then
                v30 = v30.PrimaryPart or v30:FindFirstChildWhichIsA("BasePart");
            else
                v30 = nil;
            end;
        end;

        if v30 then
            SharedUtils.PlaySoundAt(v30, "anime_explode", 1);
        end;

        if v31 then
            u1._PerformExplosionHit(u16, u17, v31);
        end;
    end);
    v18.Stopped:Once(function() -- Line: 228
        -- upvalues: u19 (ref)
        u19 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 232
        -- upvalues: u19 (ref)
        u19 = true;
    end);

    while not u19 do
        task.wait();
    end;

    if v33 then
        v33:Disconnect();
    end;

    if v24 then
        v24:Disconnect();
    end;

    if v27 then
        v27:Disconnect();
    end;

    if u20 then
        u20 = false;
        local v34 = u16.FX and u16.FX.Rose_Charge;

        if v34 then
            v34:SetAttribute("FX_Activate", false);
        end;
    end;

    u16.Is_Using_Skill = false;
    u16.Is_Attacking = false;
end;

return u1;