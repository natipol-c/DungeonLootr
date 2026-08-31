--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     tweener
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.tweener
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
local Random_new_ret = Random.new();

return {
    emit = function(p5: userdata, p6: any, u7: boolean) -- Line: 11, Name: emit
        -- upvalues: u4 (copy), u1 (copy), Random_new_ret (copy), u3 (copy), u2 (copy)
        local Target = u4.getTarget(p5);

        if not Target then
            return;
        end;

        local Name = p5.Name;
        local v8 = u1.get(p5, "EmitDelay", 0);
        local v9 = u1.get(p5, "ResetOnFinish", true);
        local Range = u1.getRange(p5, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)));

        if v8 > 0 then
            task.wait(v8);
        end;

        local u10 = u1.get(p5, "_END_VALUE", nil);
        local v11 = u1.get(p5, "_START_VALUE", nil);
        local v12;

        if u7 then
            v12 = u1.get(Target, Name, nil);
        else
            local v13;
            v13, v12 = pcall(function() -- Line: 37
                -- upvalues: Target (copy), Name (copy)
                return Target[Name];
            end);

            if not v13 then
                return;
            end;
        end;

        local u14 = v11 or v12;
        local v15 = typeof(u14);

        if v15 ~= typeof(u10) then
            return;
        end;

        local v16 = Random_new_ret:NextNumber(Range.Min, Range.Max);
        local u17 = u1.get(p5, "Speed_Start", 1);
        local u18 = u1.get(p5, "Speed_End", 1);
        local u19 = u17;
        local u20;

        if u17 == u18 then
            u20 = nil;
        else
            u20 = u3.fromParams(u1.get(p5, "Speed_Curve", u4.default_bezier), u1.get(p5, "Speed_Duration", 0.1), function(p21, p22) -- Line: 71
                -- upvalues: u19 (ref), u4 (ref), u17 (copy), u18 (copy)
                u19 = u4.lerp(u17, u18, p21);

                return p22;
            end);
            table.insert(p6, u20);
        end;

        local u23 = u2[v15] or u2.Other;
        local v24;

        if u7 then
            v24 = function(p25, p26) -- Line: 83
                -- upvalues: u1 (ref), Target (copy), Name (copy), u23 (copy), u14 (ref), u10 (copy), u19 (ref)
                u1.set(Target, Name, u23(u14, u10, p25));

                return p26 * u19;
            end;
        else
            v24 = function(p27, p28) -- Line: 87
                -- upvalues: Target (copy), Name (copy), u23 (copy), u14 (ref), u10 (copy), u19 (ref)
                Target[Name] = u23(u14, u10, p27);

                return p28 * u19;
            end;
        end;

        local fromParams = u3.fromParams;
        local v29 = u1.get(p5, "Easing_Curve", u4.linear_bezier);
        table.insert(p6, fromParams(v29, v16, v24, u20, nil, nil, u4.RENDER_PRIORITY + p6.depth));

        if v9 then
            table.insert(p6, function() -- Line: 106
                -- upvalues: u7 (copy), u1 (ref), Target (copy), Name (copy), u14 (ref)
                if u7 then
                    u1.set(Target, Name, u14);

                    return;
                end;

                Target[Name] = u14;
            end);
        end;

        u3.timer(v16, function(p30, p31) -- Line: 115
            -- upvalues: u19 (ref), u20 (ref)
            if u19 > 0 or p31 > 0 and (u20 and u20.Connected) then
                return p30 * u19;
            end;

            return nil;
        end, u20, p6);
    end
};