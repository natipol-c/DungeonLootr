--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     StatusEffectScheduler
  Path:     game.ReplicatedStorage.Modules.StatusEffectScheduler
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local NPC = require(game.ServerScriptService.Management.Classes.NPC);
local u1 = {
    _effects = {},
    _connection = nil,
    _nextId = 0
};

local function IsTargetAlive(p2: userdata) -- Line: 53
    -- upvalues: NPC (copy)
    if not (p2 and p2.Parent) then
        return false;
    end;

    local v3 = NPC._cache[p2];

    if v3 then
        local v4;

        if v3.State == "Dead" then
            v4 = false;
        else
            v4 = (v3.Health or 0) > 0;
        end;

        return v4;
    end;

    local Humanoid = p2:FindFirstChild("Humanoid");
    local v5;

    if Humanoid == nil then
        v5 = false;
    else
        v5 = Humanoid.Health > 0;
    end;

    return v5;
end;

local function ProcessTick(p6) -- Line: 67
    -- upvalues: NPC (copy), Players (copy), SharedUtils (copy)
    local Target = p6.Target;
    local v7;

    if Target and Target.Parent then
        local v8 = NPC._cache[Target];

        if v8 then
            if v8.State == "Dead" then
                v7 = false;
            else
                v7 = (v8.Health or 0) > 0;
            end;
        else
            local Humanoid = Target:FindFirstChild("Humanoid");

            if Humanoid == nil then
                v7 = false;
            else
                v7 = Humanoid.Health > 0;
            end;
        end;
    else
        v7 = false;
    end;

    if not v7 then
        return false;
    end;

    local v9 = Target.PrimaryPart or Target:FindFirstChild("HumanoidRootPart");
    local v10 = NPC._cache[Target];

    if v10 then
        v10:TakeDamage(p6.Damage, p6.Attacker);
    else
        local v11 = Players:GetPlayerFromCharacter(Target) and Target:FindFirstChild("Humanoid");

        if v11 then
            v11:TakeDamage(p6.Damage);
        end;
    end;

    if v9 then
        SharedUtils.ShowStatusDamage(v9, p6.Damage, p6.Color, p6.Prefix);
    end;

    p6.TicksRemaining = p6.TicksRemaining - 1;

    return p6.TicksRemaining > 0;
end;

local function OnHeartbeat(p12: number) -- Line: 93
    -- upvalues: u1 (copy), ProcessTick (copy)
    local _effects = u1._effects;
    local v13 = 1;

    while true do
        local v14;

        while true do
            if v13 > #_effects then
                if #_effects == 0 and u1._connection then
                    u1._connection:Disconnect();
                    u1._connection = nil;
                end;

                return;
            end;

            v14 = _effects[v13];
            v14.Elapsed = v14.Elapsed + p12;

            if v14.Elapsed >= v14.Interval then
                break;
            end;

            v13 = v13 + 1;
        end;

        v14.Elapsed = v14.Elapsed - v14.Interval;

        if ProcessTick(v14) then
            v13 = v13 + 1;
        else
            local v15 = #_effects;
            _effects[v13] = _effects[v15];
            _effects[v15] = nil;

            if v14.OnComplete then
                v14.OnComplete(v14);
            end;
        end;
    end;
end;

local function EnsureRunning() -- Line: 130
    -- upvalues: u1 (copy), RunService (copy), OnHeartbeat (copy)
    if not u1._connection then
        u1._connection = RunService.Heartbeat:Connect(OnHeartbeat);
    end;
end;

function u1.Apply(p16: table, p17: table) -- Line: 153
    -- upvalues: u1 (copy), RunService (copy), OnHeartbeat (copy)
    assert(p17.Target, "[StatusEffectScheduler] Target is required");
    assert(p17.Damage, "[StatusEffectScheduler] Damage is required");
    assert(p17.Ticks, "[StatusEffectScheduler] Ticks is required");
    assert(p17.Interval, "[StatusEffectScheduler] Interval is required");
    assert(p17.Color, "[StatusEffectScheduler] Color is required");
    local v18 = p17.StackPolicy or "independent";
    local EffectId = p17.EffectId;

    if EffectId and v18 ~= "independent" then
        for _, v in p16._effects do
            if v.EffectId == EffectId and v.Target == p17.Target then
                if v18 == "refresh" then
                    v.TicksRemaining = p17.Ticks;
                    v.Elapsed = 0;

                    return v._id;
                end;

                if v18 == "stack" then
                    v.Damage = v.Damage + p17.Damage;
                    v.TicksRemaining = p17.Ticks;
                    v.Elapsed = 0;

                    return v._id;
                end;
            end;
        end;
    end;

    p16._nextId = p16._nextId + 1;
    local v19 = {
        Elapsed = 0,
        _id = p16._nextId,
        Target = p17.Target,
        Attacker = p17.Attacker,
        Damage = p17.Damage,
        TicksRemaining = p17.Ticks,
        Interval = p17.Interval,
        Color = p17.Color,
        Prefix = p17.Prefix or "-",
        EffectId = EffectId,
        OnComplete = p17.OnComplete
    };
    table.insert(p16._effects, v19);

    if not u1._connection then
        u1._connection = RunService.Heartbeat:Connect(OnHeartbeat);
    end;

    return v19._id;
end;

function u1.ClearTarget(p20: table, p21: userdata) -- Line: 206
    local _effects = p20._effects;
    local v22 = 1;

    while v22 <= #_effects do
        if _effects[v22].Target == p21 then
            local v23 = #_effects;
            _effects[v22] = _effects[v23];
            _effects[v23] = nil;
        else
            v22 = v22 + 1;
        end;
    end;
end;

function u1.Cancel(p24: table, p25: number) -- Line: 221
    local _effects = p24._effects;

    for i, v in _effects do
        if v._id == p25 then
            local v26 = #_effects;
            _effects[i] = _effects[v26];
            _effects[v26] = nil;

            return true;
        end;
    end;

    return false;
end;

function u1.ClearEffect(p27: table, p28: userdata, p29: string) -- Line: 235
    local _effects = p27._effects;
    local v30 = 1;

    while v30 <= #_effects do
        if _effects[v30].Target == p28 and _effects[v30].EffectId == p29 then
            local v31 = #_effects;
            _effects[v30] = _effects[v31];
            _effects[v31] = nil;
        else
            v30 = v30 + 1;
        end;
    end;
end;

function u1.GetActiveCount(p32) -- Line: 250
    return #p32._effects;
end;

return u1;