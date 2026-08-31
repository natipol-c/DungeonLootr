--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RateLimit
  Path:     game.ReplicatedStorage.Packages._Index.aykut92_replica@0.1.7.replica.Shared.RateLimit
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = {};
local u2 = {};
local u3 = {};
u3.__index = u3;

function u3.New(p4: number, p5: boolean?) -- Line: 41
    -- upvalues: u3 (copy), u2 (copy)
    if p4 <= 0 then
        error("[RateLimit]: Invalid rate");
    end;

    local v6 = {
        sources = {},
        rate_period = 1 / p4,
        is_full_wait = p5 == true
    };
    setmetatable(v6, u3);
    u2[v6] = true;

    return v6;
end;

function u3.CheckRate(p7, p8) -- Line: 58
    -- upvalues: u1 (copy)
    local sources = p7.sources;
    local os_clock_ret = os.clock();
    local v9 = p8 == nil and "nil" or p8;
    local v10 = sources[v9];

    if v10 == nil then
        if typeof(v9) == "Instance" and (v9:IsA("Player") and u1[v9] == nil) then
            return false;
        end;

        sources[v9] = os_clock_ret + p7.rate_period;

        return true;
    end;

    if p7.is_full_wait == true then
        if v10 > os_clock_ret then
            return false;
        end;

        sources[v9] = os_clock_ret + p7.rate_period;

        return true;
    end;

    local math_max_ret = math.max(os_clock_ret, v10 + p7.rate_period);

    if math_max_ret - os_clock_ret >= 1 then
        return false;
    end;

    sources[v9] = math_max_ret;

    return true;
end;

function u3.CleanSource(p11, p12) -- Line: 98
    p11.sources[p12] = nil;
end;

function u3.Cleanup(p13) -- Line: 102
    p13.sources = {};
end;

function u3.Destroy(p14) -- Line: 106
    -- upvalues: u2 (copy)
    u2[p14] = nil;
end;

for _, v in ipairs(Players:GetPlayers()) do
    u1[v] = true;
end;

Players.PlayerAdded:Connect(function(p15) -- Line: 116
    -- upvalues: u1 (copy)
    u1[p15] = true;
end);
Players.PlayerRemoving:Connect(function(p16) -- Line: 120
    -- upvalues: u1 (copy), u2 (copy)
    u1[p16] = nil;

    for i in pairs(u2) do
        i.sources[p16] = nil;
    end;
end);

return u3;