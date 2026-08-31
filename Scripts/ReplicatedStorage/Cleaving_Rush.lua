--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cleaving_Rush
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Cursed King.Cleaving_Rush
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
    EffectModule = "Cleaving_Rush",
    MaxDuration = 4,
    RangedDamageMultiplier = 1.5,
    RangedHitboxSize = Vector3.new(20, 15, 45),
    RangedHitboxRange = 45,
    FlurryDamageMultiplier = 1,
    FlurryHitboxSize = Vector3.new(18, 12, 22),
    FlurryHitboxRange = 18,
    FlurryTickInterval = 0.3,
    FinaleSFX = "claw_combo",
    FinaleVolume = 1
};

function u1._RangedHit(p2, p3) -- Line: 55
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.RangedHitboxSize or u1.RangedHitboxSize, p3.RangedHitboxRange or u1.RangedHitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.RangedDamageMultiplier or u1.RangedDamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1._FlurryTick(p6, p7) -- Line: 67
    -- upvalues: u1 (copy)
    local v8 = p6:QueryHitbox(p7.FlurryHitboxSize or u1.FlurryHitboxSize, p7.FlurryHitboxRange or u1.FlurryHitboxRange);
    local v9 = p6:ResolveSkillDamage(p7.FlurryDamageMultiplier or u1.FlurryDamageMultiplier);

    for _, v in v8 do
        p6:ApplyDamage(v.Character, v9);
    end;
end;

function u1.Activate(u10, u11) -- Line: 80
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v12 = u11._animKey or u1.AnimationName;
    local v13 = u10.Animations[v12];

    if not v13 then
        warn("[Boss Cleaving_Rush] Animation not found:", v12);

        return;
    end;

    local Character = u10.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u10.Is_Using_Skill = true;
    u10.Is_Attacking = true;
    local u14 = false;
    local u15 = false;
    local u16 = false;
    v13:Play(0, 1, u11.AnimSpeed or 1);
    local v19 = v13:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 103
        -- upvalues: u10 (copy), u1 (ref), u11 (copy)
        local v18 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if not v18 then
            return;
        end;

        u1._RangedHit(u10, u11);
        u10:PlayCombatSound(u10.ClassData.SwingSoundFolder or "Sukuna", nil, u10.ClassData.SwingVolume or 1);

        if p17 and p17 ~= "" then
            u10:PlayEffectModule(u1.EffectModule, "Hit", v18.CFrame, p17);
        end;
    end);
    local v22 = v13:GetMarkerReachedSignal("Start"):Connect(function(p20) -- Line: 122
        -- upvalues: u16 (ref), u10 (copy), u1 (ref), SharedUtils (ref), u11 (copy), u15 (ref)
        if u16 then
            return;
        end;

        u16 = true;
        local v21 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if not v21 then
            return;
        end;

        if p20 and p20 ~= "" then
            u10:PlayEffectModule(u1.EffectModule, "Start", v21.CFrame, p20);
        end;

        SharedUtils.PlaySoundAt(v21, u11.FinaleSFX or u1.FinaleSFX, u11.FinaleVolume or u1.FinaleVolume);
        u15 = true;
        task.spawn(function() -- Line: 135
            -- upvalues: u15 (ref), u10 (ref), u1 (ref), u11 (ref)
            while u15 and u10.Is_Using_Skill do
                u1._FlurryTick(u10, u11);
                task.wait(u11.FlurryTickInterval or u1.FlurryTickInterval);
            end;
        end);
    end);
    local v23 = v13:GetMarkerReachedSignal("End"):Connect(function() -- Line: 145
        -- upvalues: u15 (ref)
        u15 = false;
    end);
    v13.Stopped:Once(function() -- Line: 150
        -- upvalues: u14 (ref)
        u14 = true;
    end);
    task.delay(u11.MaxDuration or u1.MaxDuration, function() -- Line: 151
        -- upvalues: u14 (ref)
        u14 = true;
    end);

    while not u14 do
        task.wait();
    end;

    u15 = false;

    if v19 then
        v19:Disconnect();
    end;

    if v22 then
        v22:Disconnect();
    end;

    if v23 then
        v23:Disconnect();
    end;

    u10:PlayEffectModule(u1.EffectModule, "DBreset", Character.CFrame);
    u10.Is_Using_Skill = false;
    u10.Is_Attacking = false;
end;

return u1;