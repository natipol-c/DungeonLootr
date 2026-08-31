--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     spin
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.spin
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
    emit = function(u4: userdata, p5: any) -- Line: 8, Name: emit
        -- upvalues: u3 (copy), u1 (copy), u2 (copy)
        if u3.isSpinModelStatic(u4) then
            return;
        end;

        local v6 = u1.get(u4, "SpinRotation", Vector3.new(0, 0, 0)) * u3.DEG_TO_RAD;
        local u7 = u1.get(u4, "Scale_Start", 1);
        local u8 = u1.get(u4, "Scale_End", 1);
        local v9 = u1.get(u4, "EmitDelay", 0);
        local v10 = u1.get(u4, "ResetDelay", 0);
        local v11 = u1.get(u4, "ResetOnFinish", true);
        local u12 = u1.get(u4, "SyncPosition", false);
        local u13 = u1.get(u4, "SpinDuration", 0.5);
        local v14 = u1.get(u4, "SpinSpeed_Duration", 0.1);
        local u15 = u1.get(u4, "SpinSpeed_Start", 0);
        local u16 = u1.get(u4, "SpinSpeed_End", 1);
        local u17 = u15;
        task.wait(v9);
        local u18;

        if u15 == u16 then
            u18 = nil;
        else
            u18 = u2.fromParams(u1.get(u4, "SpinSpeed_Curve", u3.default_bezier), v14, function(p19, p20) -- Line: 40
                -- upvalues: u17 (ref), u3 (ref), u15 (copy), u16 (copy)
                u17 = u3.lerp(u15, u16, p19);

                return p20;
            end);
            table.insert(p5, u18);
        end;

        local Pivot = u4:GetPivot();
        local Scale = u4:GetScale();

        if u7 == u8 then
            u4:ScaleTo(u7);
        else
            local fromParams = u2.fromParams;
            local v21 = u1.get(u4, "Scale_Curve", u3.default_bezier);
            table.insert(p5, fromParams(v21, u13, function(p22, p23) -- Line: 55
                -- upvalues: u4 (copy), u3 (ref), u7 (copy), u8 (copy)
                u4:ScaleTo(u3.lerp(u7, u8, p22));

                return p23;
            end));
        end;

        local u24 = u4:FindFirstAncestorOfClass("Attachment") or u4:FindFirstAncestorWhichIsA("BasePart");

        if v11 then
            table.insert(p5, function() -- Line: 67
                -- upvalues: u4 (copy), u24 (copy), u3 (ref), Pivot (copy), Scale (copy)
                u4:PivotTo(u24 and u3.getTransformedOriginExtents(u24) or Pivot);
                u4:ScaleTo(Scale);
            end);
        end;

        local u25 = v6 * u13;
        u2.timer(u13 + v10, function(p26, p27) -- Line: 75
            -- upvalues: u13 (copy), u25 (ref), u24 (copy), u12 (copy), u3 (ref), Pivot (copy), u4 (copy), u17 (ref), u18 (ref)
            local v28 = u25 * math.clamp(p27 / u13, 0, 1);
            local v29;

            if u24 and u12 then
                v29 = u3.getTransformedOriginExtents(u24);
            else
                v29 = Pivot;
            end;

            u4:PivotTo(v29 * CFrame.fromOrientation(v28.x, v28.y, v28.z));

            if u17 > 0 or p27 > 0 and u18.Connected then
                return p26 * u17;
            end;

            return nil;
        end, u18, p5, u3.RENDER_PRIORITY + p5.depth);
    end
};