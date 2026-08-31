--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     particle
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.particle
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");

return {
    emit = function(u4: userdata, u5: userdata, p6: any) -- Line: 8, Name: emit
        -- upvalues: u1 (copy), u2 (copy), u3 (copy)
        if u4.Enabled then
            u4.Enabled = false;
        end;

        local v7 = u1.get(u4, "EmitDelay", 0);
        local v8 = u1.get(u4, "EmitCount", 1);
        local v9 = u1.get(u4, "EmitDuration", 0);
        local u10 = v9 > 0;
        task.wait(v7);

        if u10 then
            u5.Enabled = true;
        end;

        local v11 = u1.get(u4, "TimeScale_Duration", 0.1);
        local u12 = u1.get(u4, "TimeScale_Start", u5.TimeScale, true);
        local u13 = u1.get(u4, "TimeScale_End", u5.TimeScale, true);
        local u14 = nil;

        if u12 == u13 then
            if u12 ~= u5.TimeScale then
                u5.TimeScale = u12;
            end;
        else
            u14 = u2.fromParams(u1.get(u4, "TimeScale_Curve", u3.default_bezier), v11, function(p15, p16) -- Line: 36
                -- upvalues: u3 (ref), u12 (copy), u13 (copy), u5 (copy)
                u5.TimeScale = u3.lerp(u12, u13, (math.clamp(p15, 0, 1)));

                return p16;
            end);
            table.insert(p6, u14);
        end;

        u3.onCancel(p6, function() -- Line: 50
            -- upvalues: u10 (copy), u5 (copy)
            if u10 then
                u5.Enabled = false;
            end;

            u5:Clear();
        end);
        u5:Emit(v8);

        if u10 then
            task.wait(v9);
            u5.Enabled = false;
        end;

        u2.timer(u4.Lifetime.Max, function(p17, p18) -- Line: 65
            -- upvalues: u4 (copy), u14 (ref)
            if u4.TimeScale > 0 or p18 > 0 and (u14 and u14.Connected) then
                return p17 * u4.TimeScale;
            end;

            return nil;
        end, u14, p6);
    end
};