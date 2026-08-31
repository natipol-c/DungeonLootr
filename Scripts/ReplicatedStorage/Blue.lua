--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Blue
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Honored One.Blue
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
    AnimationName = "Ability_1",
    EffectModule = "Blue",
    MaxDuration = 3.5,
    TickMultiplier = 0.5,
    TickInterval = 0.4,
    TickHitboxSize = Vector3.new(30, 30, 30),
    TickHitboxRange = 30,
    FinisherMultiplier = 2,
    FinisherHitboxSize = Vector3.new(30, 30, 30),
    FinisherHitboxRange = 30,
    StartSFX = "Blue_Spell_Fast",
    StartVolume = 1,
    EndSFX = "explosion_punch",
    EndVolume = 3
};

function u1._Chip(p2, p3) -- Line: 71
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.TickHitboxSize or u1.TickHitboxSize, p3.TickHitboxRange or u1.TickHitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.TickMultiplier or u1.TickMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1._Collapse(p6, p7) -- Line: 83
    -- upvalues: u1 (copy)
    local v8 = p6:QueryHitbox(p7.FinisherHitboxSize or u1.FinisherHitboxSize, p7.FinisherHitboxRange or u1.FinisherHitboxRange);
    local v9 = p6:ResolveSkillDamage(p7.FinisherMultiplier or u1.FinisherMultiplier);

    for _, v in v8 do
        p6:ApplyDamage(v.Character, v9);
    end;
end;

function u1.Activate(u10, u11) -- Line: 97
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v12 = u11._animKey or u1.AnimationName;
    local v13 = u10.Animations[v12];

    if not v13 then
        warn("[Boss Blue] Animation not found:", v12);

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
    local v18 = v13:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 121
        -- upvalues: u16 (ref), u10 (copy), u1 (ref), SharedUtils (ref), u11 (copy), u15 (ref)
        if u16 then
            return;
        end;

        u16 = true;
        local v17 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if not v17 then
            return;
        end;

        u10:PlayEffectModule(u1.EffectModule, "Start", v17.CFrame);
        SharedUtils.PlaySoundAt(v17, u11.StartSFX or u1.StartSFX, u11.StartVolume or u1.StartVolume);
        u15 = true;
        task.spawn(function() -- Line: 134
            -- upvalues: u15 (ref), u10 (ref), u1 (ref), u11 (ref)
            while u15 and u10.Is_Using_Skill do
                u1._Chip(u10, u11);
                task.wait(u11.TickInterval or u1.TickInterval);
            end;
        end);
    end);
    local v20 = v13:GetMarkerReachedSignal("End"):Connect(function() -- Line: 144
        -- upvalues: u15 (ref), u10 (copy), Character (copy), u1 (ref), u11 (copy), SharedUtils (ref)
        u15 = false;
        local v19 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");
        u10:PlayEffectModule(u1.EffectModule, "Detach", v19 and v19.CFrame or Character.CFrame);
        u1._Collapse(u10, u11);

        if v19 then
            SharedUtils.PlaySoundAt(v19, u11.EndSFX or u1.EndSFX, u11.EndVolume or u1.EndVolume);
        end;
    end);
    v13.Stopped:Once(function() -- Line: 160
        -- upvalues: u14 (ref)
        u14 = true;
    end);
    task.delay(u11.MaxDuration or u1.MaxDuration, function() -- Line: 161
        -- upvalues: u14 (ref)
        u14 = true;
    end);

    while not u14 do
        task.wait();
    end;

    u15 = false;

    if v18 then
        v18:Disconnect();
    end;

    if v20 then
        v20:Disconnect();
    end;

    u10:PlayEffectModule(u1.EffectModule, "DBreset", Character.CFrame);
    u10.Is_Using_Skill = false;
    u10.Is_Attacking = false;
end;

return u1;