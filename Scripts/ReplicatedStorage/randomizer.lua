--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     randomizer
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.randomizer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../mod/attributes");
local u2 = require("../mod/lerp");
local u3 = require("../mod/tween");
require("../types");
local u4 = require("../mod/utility");
local u5 = require("../obj/Bezier");
local Random_new_ret = Random.new();
local v6 = {};

local function getBezier(u7: string) -- Line: 14
    -- upvalues: u3 (copy), u4 (copy), u5 (copy)
    local v8 = u3.bezier_cache[u7];

    if not v8 then
        local success, result = pcall(function() -- Line: 18
            -- upvalues: u4 (ref), u7 (copy)
            return u4.deserializePath(u7);
        end);

        if not success then
            return nil;
        end;

        v8 = u5.new(result, 0);
        u3.bezier_cache[u7] = v8;
    end;

    return v8;
end;

local function sampleWeighted(p9) -- Line: 33
    -- upvalues: Random_new_ret (copy)
    return 1 - p9:getEase((Random_new_ret:NextNumber())).y;
end;

function v6.emit(p10: userdata, p11: any, u12: boolean) -- Line: 40
    -- upvalues: u4 (copy), u1 (copy), getBezier (copy), u2 (copy), Random_new_ret (copy)
    local Target = u4.getTarget(p10);

    if not Target then
        return;
    end;

    local Name = p10.Name;
    local v13 = u1.get(p10, "_START_VALUE", nil);
    local v14 = u1.get(p10, "_END_VALUE", nil);

    if v13 == nil or v14 == nil then
        return;
    end;

    local v15 = typeof(v13);

    if v15 ~= typeof(v14) then
        return;
    end;

    local v16 = getBezier((u1.get(p10, "Weight_Curve", u4.linear_bezier)));

    if not v16 then
        return;
    end;

    local u17;

    if u12 then
        u17 = u1.get(Target, Name, nil);
    else
        local v18;
        v18, u17 = pcall(function() -- Line: 74
            -- upvalues: Target (copy), Name (copy)
            return Target[Name];
        end);

        if not v18 then
            return;
        end;
    end;

    local v19 = (u2[v15] or u2.Other)(v13, v14, 1 - v16:getEase((Random_new_ret:NextNumber())).y);
    local v20 = u1.get(p10, "ResetOnFinish", true);

    if u12 then
        u1.set(Target, Name, v19);
    else
        Target[Name] = v19;
    end;

    if v20 then
        task.defer(function() -- Line: 100
            -- upvalues: u12 (copy), u1 (ref), Target (copy), Name (copy), u17 (ref)
            if u12 then
                u1.set(Target, Name, u17);

                return;
            end;

            Target[Name] = u17;
        end);
    end;
end;

return v6;