--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     tween
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.mod.tween
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = require("./logger");
local u2 = require("./utility");
local u3 = require("../obj/Bezier");
local u4 = {
    bezier_cache = {}
};

function u4.fromParams(u5: string, u6: number, u7: function, u8: userdata?, u9: function?, u10: boolean?, p11: number?) -- Line: 12
    -- upvalues: u4 (copy), u2 (copy), u1 (copy), u3 (copy), RunService (copy)
    local u12 = u4.bezier_cache[u5];

    if not u12 then
        local success, result = pcall(function() -- Line: 24
            -- upvalues: u2 (ref), u5 (copy)
            return u2.deserializePath(u5);
        end);

        if not success then
            u1.error((`failed to decode bezier path data with error: {result}`));
        end;

        u12 = u3.new(result, 0);
        u4.bezier_cache[u5] = u12;
    end;

    local u13 = 0;
    local u14 = nil;

    local function step(p15) -- Line: 41
        -- upvalues: u10 (copy), u13 (ref), u6 (copy), u12 (ref), u7 (copy), u8 (copy), u14 (ref), u9 (copy)
        if not u10 and u13 == 0 then
            local math_max_ret = math.max(u6, 0);
            u13 = math.clamp(u13 + p15, 0, math_max_ret);
        end;

        local v16 = u7(1 - u12:getEase((math.clamp(u13 / u6, 0, 1))).y, p15, u13);

        if v16 == nil then
            if not (u8 and u8.Connected) then
                u14();

                if u9 then
                    u9(true);
                end;

                return;
            end;
        else
            local v17;

            if u6 == 0 then
                v17 = u6 < u13;
            else
                v17 = u6 <= u13;
            end;

            if v17 then
                if not (u8 and u8.Connected) then
                    u14();

                    if u9 then
                        u9(true);
                    end;

                    return;
                end;
            end;
        end;

        if v16 then
            local math_max_ret = math.max(u6, 0.001);
            u13 = math.clamp(u13 + v16, 0, math_max_ret);
        end;
    end;

    if not p11 then
        local u18 = RunService.RenderStepped:Connect(step);

        u14 = function() -- Line: 74
            -- upvalues: u18 (ref)
            u18:Disconnect();
        end;

        return u18;
    end;

    local RandomId = u2.getRandomId();
    RunService:BindToRenderStep(RandomId, p11, step);
    local u19 = true;

    u14 = function() -- Line: 86
        -- upvalues: u19 (ref), RunService (ref), RandomId (copy)
        if not u19 then
            return;
        end;

        u19 = false;
        RunService:UnbindFromRenderStep(RandomId);
    end;

    return u14;
end;

function u4.timer(u20: number, u21: function, u22: userdata?, p23: table?, p24: number?) -- Line: 100
    -- upvalues: RunService (copy), u2 (copy)
    local coroutine_running_ret = coroutine.running();
    local u25 = 0;
    local u26 = nil;

    local function v30(p27) -- Line: 113
        -- upvalues: u21 (copy), u25 (ref), u20 (copy), u22 (copy), u26 (ref), coroutine_running_ret (copy)
        local v28 = u21(p27, u25);

        if v28 == nil then
            if not (u22 and u22.Connected) then
                u26();
                task.spawn(coroutine_running_ret);

                return;
            end;
        else
            local v29;

            if u20 == 0 then
                v29 = u20 < u25;
            else
                v29 = u20 <= u25;
            end;

            if v29 then
                if not (u22 and u22.Connected) then
                    u26();
                    task.spawn(coroutine_running_ret);

                    return;
                end;
            end;
        end;

        if v28 then
            local math_max_ret = math.max(u20, 0.001);
            u25 = math.clamp(u25 + v28, 0, math_max_ret);
        end;
    end;

    if p24 then
        local RandomId = u2.getRandomId();
        RunService:BindToRenderStep(RandomId, p24, v30);
        local u31 = true;

        u26 = function() -- Line: 143
            -- upvalues: u31 (ref), RunService (ref), RandomId (copy)
            if not u31 then
                return;
            end;

            u31 = false;
            RunService:UnbindFromRenderStep(RandomId);
        end;
    else
        local u32 = RunService.RenderStepped:Connect(v30);

        u26 = function() -- Line: 133
            -- upvalues: u32 (copy)
            u32:Disconnect();
        end;
    end;

    if p23 then
        table.insert(p23, u26);
    end;

    coroutine.yield();
end;

return u4;