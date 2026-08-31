--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Killer_Instinct_Heat
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Unrestricted.Killer_Instinct_Heat
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_4_Special",
    MaxDuration = 10,
    TickInterval = 0.1,
    HitboxSize = Vector3.new(55, 55, 55),
    HitboxRange = 0,
    StartSFX = "jojo punch",
    EndSFX = "claw_slam_01"
};

function u1._PerformTick(p2, p3) -- Line: 61
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 76
    -- upvalues: u1 (copy), SharedUtils (copy), RunService (copy)
    local v8 = u6.Animations[u1.AnimationName];

    if not v8 then
        warn("[Boss Killer_Instinct_Heat] Animation not found:", u1.AnimationName);

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
    local u10 = false;
    local u11 = nil;
    local u12 = 0;
    local u13 = u7.TickInterval or u1.TickInterval;

    local function stopBarrage() -- Line: 103
        -- upvalues: u10 (ref), u11 (ref), u6 (copy), SharedUtils (ref), u1 (ref)
        if not u10 then
            return;
        end;

        u10 = false;

        if u11 then
            u11:Disconnect();
            u11 = nil;
        end;

        local v14 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v14 then
            SharedUtils.PlaySoundAt(v14, u1.EndSFX, u6.ClassData.SwingVolume or 1);
        end;
    end;

    local v18 = v8:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 125
        -- upvalues: u10 (ref), u6 (copy), SharedUtils (ref), u1 (ref), u12 (ref), u11 (ref), RunService (ref), u13 (copy), u7 (copy)
        u10 = true;
        local v15 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v15 then
            SharedUtils.PlaySoundAt(v15, u1.StartSFX, u6.ClassData.SwingVolume or 1);
        end;

        u12 = 0;
        u11 = RunService.Heartbeat:Connect(function(p16) -- Line: 140
            -- upvalues: u10 (ref), u6 (ref), u11 (ref), SharedUtils (ref), u1 (ref), u12 (ref), u13 (ref), u7 (ref)
            if not u10 then
                return;
            end;

            if u6.Character and u6.Character.Parent then
                u12 = u12 + p16;

                while u13 <= u12 do
                    u12 = u12 - u13;
                    u1._PerformTick(u6, u7);
                end;

                return;
            end;

            if not u10 then
                return;
            end;

            u10 = false;

            if u11 then
                u11:Disconnect();
                u11 = nil;
            end;

            local v17 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

            if v17 then
                SharedUtils.PlaySoundAt(v17, u1.EndSFX, u6.ClassData.SwingVolume or 1);
            end;
        end);
    end);
    local v20 = v8:GetMarkerReachedSignal("End"):Connect(function() -- Line: 157
        -- upvalues: u10 (ref), u11 (ref), u6 (copy), SharedUtils (ref), u1 (ref)
        if not u10 then
            return;
        end;

        u10 = false;

        if u11 then
            u11:Disconnect();
            u11 = nil;
        end;

        local v19 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v19 then
            SharedUtils.PlaySoundAt(v19, u1.EndSFX, u6.ClassData.SwingVolume or 1);
        end;
    end);
    v8.Stopped:Once(function() -- Line: 162
        -- upvalues: u9 (ref)
        u9 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 167
        -- upvalues: u9 (ref)
        u9 = true;
    end);

    while not u9 do
        task.wait();
    end;

    if u10 then
        u10 = false;

        if u11 then
            u11:Disconnect();
            u11 = nil;
        end;

        local v21 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v21 then
            SharedUtils.PlaySoundAt(v21, u1.EndSFX, u6.ClassData.SwingVolume or 1);
        end;
    end;

    if v18 then
        v18:Disconnect();
    end;

    if v20 then
        v20:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;