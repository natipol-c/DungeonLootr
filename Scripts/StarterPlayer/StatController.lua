--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     StatController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.StatController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "StatController"
});
local u2 = nil;
local u3 = nil;
local u4 = {};
local u5 = {};
local u6 = 0;
local u7 = {};

function v1.OnChanged(p8: table, u9: function) -- Line: 40
    -- upvalues: u7 (copy)
    table.insert(u7, u9);

    return function() -- Line: 42
        -- upvalues: u7 (ref), u9 (copy)
        local table_find_ret = table.find(u7, u9);

        if table_find_ret then
            table.remove(u7, table_find_ret);
        end;
    end;
end;

local function FireChanged() -- Line: 50
    -- upvalues: u7 (copy), u4 (ref), u5 (ref), u6 (ref)
    for _, v in u7 do
        task.spawn(v, u4, u5, u6);
    end;
end;

function v1.GetStats(p10) -- Line: 59
    -- upvalues: u4 (ref)
    return u4;
end;

function v1.GetStat(p11: table, p12: string) -- Line: 64
    -- upvalues: u4 (ref)
    return u4[p12] or 0;
end;

function v1.GetSkillPoints(p13) -- Line: 69
    -- upvalues: u5 (ref), u6 (ref)
    return u5, u6;
end;

function v1.AllocatePoint(p14: table, p15: string) -- Line: 75
    -- upvalues: u2 (ref)
    local v16, v17 = u2:AllocatePoint(p15):await();

    if v16 then
        return v17;
    end;

    return false, "RequestFailed";
end;

function v1.DeallocatePoint(p18: table, p19: string) -- Line: 86
    -- upvalues: u2 (ref)
    local v20, v21 = u2:DeallocatePoint(p19):await();

    if v20 then
        return v21;
    end;

    return false, "RequestFailed";
end;

function v1.AllocatePoints(p22: table, p23: string, p24: number) -- Line: 97
    -- upvalues: u2 (ref)
    local v25, v26 = u2:AllocatePoints(p23, p24):await();

    if v25 and type(v26) == "table" then
        return v26.Success, v26.Reason, v26.Applied or 0;
    end;

    return false, "RequestFailed", 0;
end;

function v1.DeallocatePoints(p27: table, p28: string, p29: number) -- Line: 108
    -- upvalues: u2 (ref)
    local v30, v31 = u2:DeallocatePoints(p28, p29):await();

    if v30 and type(v31) == "table" then
        return v31.Success, v31.Reason, v31.Applied or 0;
    end;

    return false, "RequestFailed", 0;
end;

function v1.AutoAllocate(p32) -- Line: 119
    -- upvalues: u2 (ref)
    local v33, v34 = u2:AutoAllocate():await();

    if v33 and type(v34) == "table" then
        return v34.Success, v34.Reason, v34.Result;
    end;

    return false, "RequestFailed", nil;
end;

function v1.Respec(p35) -- Line: 129
    -- upvalues: u2 (ref)
    local v36, v37 = u2:Respec():await();

    if v36 then
        return v37;
    end;

    return false, "RequestFailed";
end;

function v1.KnitInit(p38) -- Line: 139
end;

function v1.KnitStart(p39) -- Line: 143
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), FireChanged (copy)
    u2 = Knit.GetService("StatService");
    u3 = Knit.Registry:Get("PlayerData");

    if not u3 then
        warn("[StatController] PlayerData not found in Registry");

        return;
    end;

    local Data = u3.Data;
    u4 = Data.ComputedStats or {};
    u5 = Data.SkillPoints or {};
    u6 = Data.UnspentSkillPoints or 0;
    u3:OnChange(function(p40, p41) -- Line: 159
        -- upvalues: u4 (ref), u3 (ref), FireChanged (ref), u5 (ref), u6 (ref)
        local v42 = p41[1];

        if v42 == "ComputedStats" then
            u4 = u3.Data.ComputedStats or {};
            FireChanged();

            return;
        end;

        if v42 ~= "SkillPoints" then
            if v42 == "UnspentSkillPoints" then
                u6 = u3.Data.UnspentSkillPoints or 0;
                FireChanged();
            end;

            return;
        end;

        u5 = u3.Data.SkillPoints or {};
        FireChanged();
    end);
    u2.StatsUpdated:Connect(function(p43) -- Line: 175
        -- upvalues: u4 (ref), FireChanged (ref)
        u4 = p43;
        FireChanged();
    end);
end;

return v1;