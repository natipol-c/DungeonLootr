--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Infinite_Creation
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Broken Reality.Infinite_Creation
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_4",
    MaxDuration = 10,
    TickInterval = 0.1,
    HitboxSize = Vector3.new(50, 50, 50),
    HitboxRange = 0,
    SlashFXInterval = 0.35,
    SlashFXPool = { "Right_Slash", "Left_Slash" }
};

function u1._PerformTick(p2, p3) -- Line: 58
    -- upvalues: u1 (copy)
    local v4 = p2:QueryHitbox(p3.HitboxSize or u1.HitboxSize, p3.HitboxRange or u1.HitboxRange);
    local v5 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for _, v in v4 do
        p2:ApplyDamage(v.Character, v5);
    end;
end;

function u1.Activate(u6, u7) -- Line: 73
    -- upvalues: u1 (copy), SharedUtils (copy), RunService (copy)
    local v8 = u7._animKey or u1.AnimationName;
    local v9 = u6.Animations[v8];

    if not v9 then
        warn("[Boss Infinite_Creation] Animation not found:", v8);

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
    local u10 = false;
    v9:Play(0, 1, u7.AnimSpeed or 1);
    local u11 = false;
    local u12 = nil;
    local u13 = 0;
    local u14 = 0;
    local u15 = u7.TickInterval or u1.TickInterval;
    local u16 = u7.SlashFXInterval or u1.SlashFXInterval;
    local u17 = u6.FX and u6.FX.Bladeworks;

    local function stopBarrage() -- Line: 107
        -- upvalues: u11 (ref), u12 (ref), u17 (copy), u6 (copy), SharedUtils (ref)
        if not u11 then
            return;
        end;

        u11 = false;

        if u12 then
            u12:Disconnect();
            u12 = nil;
        end;

        if u17 and u17.Parent then
            u17:SetAttribute("FX_Activate", false);
        end;

        local v18 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

        if v18 then
            SharedUtils.PlaySoundAt(v18, "anime_explode", 1);
        end;
    end;

    local v24 = v9:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 130
        -- upvalues: u11 (ref), u17 (copy), u13 (ref), u14 (ref), u12 (ref), RunService (ref), u6 (copy), stopBarrage (copy), u15 (copy), SharedUtils (ref), u1 (ref), u7 (copy), u16 (copy)
        u11 = true;

        if u17 then
            u17:SetAttribute("FX_Activate", true);
        end;

        u13 = 0;
        u14 = 0;
        u12 = RunService.Heartbeat:Connect(function(p19) -- Line: 141
            -- upvalues: u11 (ref), u6 (ref), stopBarrage (ref), u13 (ref), u15 (ref), SharedUtils (ref), u1 (ref), u7 (ref), u14 (ref), u16 (ref)
            if not u11 then
                return;
            end;

            if not (u6.Character and u6.Character.Parent) then
                stopBarrage();

                return;
            end;

            u13 = u13 + p19;

            while u15 <= u13 do
                u13 = u13 - u15;
                local v20 = u6.Character and u6.Character:FindFirstChild("HumanoidRootPart");

                if v20 then
                    SharedUtils.PlaySoundAt(v20, "Rolling_Swing", 0.5);
                    SharedUtils.PlaySoundAt(v20, "Clash", 0.4);
                end;

                u1._PerformTick(u6, u7);
            end;

            u14 = u14 + p19;

            while u16 <= u14 do
                u14 = u14 - u16;
                local v21 = u7.SlashFXPool or u1.SlashFXPool;
                local v22 = v21[math.random(1, #v21)];
                local v23 = u6.FX and u6.FX[v22];

                if v23 then
                    v23:SetAttribute("Fire", not v23:GetAttribute("Fire"));
                end;
            end;
        end);
    end);
    local v25 = v9:GetMarkerReachedSignal("End"):Connect(function() -- Line: 180
        -- upvalues: stopBarrage (copy)
        stopBarrage();
    end);
    v9.Stopped:Once(function() -- Line: 185
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 190
        -- upvalues: u10 (ref)
        u10 = true;
    end);

    while not u10 do
        task.wait();
    end;

    stopBarrage();

    if v24 then
        v24:Disconnect();
    end;

    if v25 then
        v25:Disconnect();
    end;

    u6.Is_Using_Skill = false;
    u6.Is_Attacking = false;
end;

return u1;