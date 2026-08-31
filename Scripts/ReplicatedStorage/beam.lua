--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     beam
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.beam
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../mod/common/flipbook");
local u5 = require("../pkg/Promise");
local Random_new_ret = Random.new();

local function getLegacyWidths(p6: userdata, p7: number) -- Line: 12
    -- upvalues: u1 (copy)
    return u1.get(p6, "Width0", p6.Width0, true) * p7, u1.get(p6, "Width1", p6.Width1, true) * p7, u1.get(p6, "StartWidth0", p6.Width0, true) * p7, u1.get(p6, "StartWidth1", p6.Width1, true) * p7;
end;

return {
    emit = function(p8: userdata, u9: userdata, p10: any, p11: number) -- Line: 24, Name: emit
        -- upvalues: getLegacyWidths (copy), u1 (copy), Random_new_ret (copy), u2 (copy), u3 (copy), u4 (copy), u5 (copy)
        local v12 = p10.effects.prepareEmitOnFinish(u9, p10);
        local v13, v14, v15, v16 = getLegacyWidths(p8, p11);
        local u17 = u1.get(p8, "Width0_Start", v15);
        local u18 = u1.get(p8, "Width0_End", v13);
        local u19 = u1.get(p8, "Width1_Start", v16);
        local u20 = u1.get(p8, "Width1_End", v14);
        local u21 = u1.get(p8, "CurveSize0_Start", u9.CurveSize0);
        local u22 = u1.get(p8, "CurveSize0_End", u9.CurveSize0);
        local u23 = u1.get(p8, "CurveSize1_Start", u9.CurveSize1);
        local u24 = u1.get(p8, "CurveSize1_End", u9.CurveSize1);
        local v25 = u1.get(p8, "EmitDelay", 0);
        local v26 = u1.get(p8, "Duration", 1, true);
        local v27 = u1.get(p8, "EndTransparencyScale", 1, true);
        local Range = u1.getRange(p8, "EffectDuration", NumberRange.new(v26, v26), NumberRange.new(0, (1 / 0)));
        local v28 = u1.get(p8, "Length_Scale_Start", NumberRange.new(1, 1));
        local v29 = u1.get(p8, "Length_Scale_End", NumberRange.new(1, 1));
        local u30 = u1.get(p8, "Length_Texture_Start", p8.TextureLength);
        local u31 = u1.get(p8, "Length_Texture_End", p8.TextureLength);
        local v32 = Random_new_ret:NextNumber(Range.Min, Range.Max);
        local u33 = Random_new_ret:NextNumber(v29.Min, v29.Max);
        local u34 = Random_new_ret:NextNumber(v28.Min, v28.Max);
        local u35 = u1.get(p8, "Transparency_Scale_Start", 1);
        local u36 = u1.get(p8, "Transparency_Scale_End", v27);
        local u37 = u1.get(p8, "Speed_Texture_Start", p8.TextureSpeed);
        local u38 = u1.get(p8, "Speed_Texture_End", p8.TextureSpeed);
        local u39 = u1.get(p8, "Speed_Start", 1);
        local u40 = u1.get(p8, "Speed_End", 1);
        local TextureSpeed = u9.TextureSpeed;
        task.wait(v25);
        u9.Enabled = true;
        local v41 = {};
        local u42 = 1;
        local u43 = nil;
        local Finished = p10.effects.emitNested(u9, p10.depth + 1, p10).Finished;
        table.insert(v41, Finished);

        if u37 ~= u38 then
            u2.fromParams(u1.get(p8, "Speed_Texture_Curve", u3.default_bezier), v32, function(p44, p45) -- Line: 86
                -- upvalues: TextureSpeed (ref), u3 (ref), u37 (copy), u38 (copy), u9 (copy), u42 (ref)
                TextureSpeed = u3.lerp(u37, u38, p44);
                u9.TextureSpeed = TextureSpeed * u42;

                return p45;
            end);
        end;

        if u39 ~= u40 then
            u43 = u2.fromParams(u1.get(p8, "Speed_Curve", u3.default_bezier), u1.get(u9, "Speed_Duration", 0.1), function(p46, p47) -- Line: 98
                -- upvalues: u42 (ref), u3 (ref), u39 (copy), u40 (copy), u9 (copy), TextureSpeed (ref)
                u42 = u3.lerp(u39, u40, p46);
                u9.TextureSpeed = TextureSpeed * u42;

                return p47;
            end);
            table.insert(p10, u43);
        end;

        local Keypoints = p8.Transparency.Keypoints;
        local v48 = #Keypoints;
        local table_create_ret = table.create(v48);
        local table_create_ret2 = table.create(v48);

        for i, v in Keypoints do
            table_create_ret2[i] = {
                time = v.Time,
                value = v.Value,
                envelope = v.Envelope
            };
        end;

        local u49 = nil;

        local function setTScale(p50: number) -- Line: 127
            -- upvalues: u49 (ref), table_create_ret2 (copy), table_create_ret (copy), u9 (copy)
            if u49 and math.abs(p50 - u49) < 0.001 then
                return;
            end;

            u49 = p50;
            local v51 = p50 > 1 and p50 - 1 or 1 - p50;

            for i, v in table_create_ret2 do
                local value = v.value;
                table_create_ret[i] = NumberSequenceKeypoint.new(v.time, value + (p50 > 1 and 1 - value or -value) * v51, v.envelope);
            end;

            u9.Transparency = NumberSequence.new(table_create_ret);
        end;

        local Attachment0 = u9.Attachment0;
        local Attachment1 = u9.Attachment1;
        local u52;

        if Attachment0 then
            u52 = Attachment0.CFrame;
        else
            u52 = Attachment0;
        end;

        local u53;

        if Attachment1 then
            u53 = Attachment1.CFrame;
        else
            u53 = Attachment1;
        end;

        local function setLengthScale(p54: number) -- Line: 149
            -- upvalues: u52 (copy), u53 (copy), Attachment0 (copy), Attachment1 (copy)
            if not (u52 and u53) then
                return;
            end;

            local v55 = (u53.Position - u52.Position) * 0.5;
            local v56 = u52.Position + v55;
            local v57 = v55 * p54;
            Attachment0.CFrame = CFrame.new(v56 - v57) * (u52 - u52.Position);
            Attachment1.CFrame = CFrame.new(v56 + v57) * (u53 - u53.Position);
        end;

        table.insert(p10, function() -- Line: 168
            -- upvalues: setLengthScale (copy)
            setLengthScale(1);
        end);

        if u35 == u36 then
            if u35 ~= 1 then
                setTScale(u35);
            end;
        else
            local fromParams = u2.fromParams;
            local v58 = u1.get(p8, "Transparency_Scale_Curve", u3.default_bezier);
            table.insert(p10, fromParams(v58, v32, function(p59, p60) -- Line: 178
                -- upvalues: setTScale (copy), u3 (ref), u35 (copy), u36 (copy), u42 (ref)
                setTScale(u3.lerp(u35, u36, p59));

                return p60 * u42;
            end, u43));
        end;

        if u30 ~= u31 then
            local fromParams = u2.fromParams;
            local v61 = u1.get(p8, "Length_Texture_Curve", u3.default_bezier);
            table.insert(p10, fromParams(v61, v32, function(p62, p63) -- Line: 195
                -- upvalues: u9 (copy), u3 (ref), u30 (copy), u31 (copy), u42 (ref)
                u9.TextureLength = u3.lerp(u30, u31, p62);

                return p63 * u42;
            end, u43));
        end;

        if u34 == u33 then
            if u30 ~= 1 then
                setLengthScale(u34);
            end;
        else
            local fromParams = u2.fromParams;
            local v64 = u1.get(p8, "Length_Scale_Curve", u3.default_bezier);
            table.insert(p10, fromParams(v64, v32, function(p65, p66) -- Line: 207
                -- upvalues: u3 (ref), u34 (copy), u33 (copy), setLengthScale (copy), u42 (ref)
                setLengthScale((u3.lerp(u34, u33, p65)));

                return p66 * u42;
            end, u43));
        end;

        if u17 == u18 then
            u9.Width0 = u17;
        else
            local fromParams = u2.fromParams;
            local v67 = u1.get(p8, "Width0_Curve", u3.default_bezier);
            table.insert(p10, fromParams(v67, v32, function(p68, p69) -- Line: 222
                -- upvalues: u9 (copy), u3 (ref), u17 (copy), u18 (copy), u42 (ref)
                u9.Width0 = u3.lerp(u17, u18, p68);

                return p69 * u42;
            end, u43));
        end;

        if u19 == u20 then
            u9.Width1 = u19;
        else
            local fromParams = u2.fromParams;
            local v70 = u1.get(p8, "Width1_Curve", u3.default_bezier);
            table.insert(p10, fromParams(v70, v32, function(p71, p72) -- Line: 234
                -- upvalues: u9 (copy), u3 (ref), u19 (copy), u20 (copy), u42 (ref)
                u9.Width1 = u3.lerp(u19, u20, p71);

                return p72 * u42;
            end, u43));
        end;

        if u21 == u22 then
            u9.Width0 = u17;
        else
            local fromParams = u2.fromParams;
            local v73 = u1.get(p8, "CurveSize0_Curve", u3.default_bezier);
            table.insert(p10, fromParams(v73, v32, function(p74, p75) -- Line: 246
                -- upvalues: u9 (copy), u3 (ref), u21 (copy), u22 (copy), u42 (ref)
                u9.CurveSize0 = u3.lerp(u21, u22, p74);

                return p75 * u42;
            end, u43));
        end;

        if u23 == u24 then
            u9.Width1 = u19;
        else
            local fromParams = u2.fromParams;
            local v76 = u1.get(p8, "CurveSize1_Curve", u3.default_bezier);
            table.insert(p10, fromParams(v76, v32, function(p77, p78) -- Line: 258
                -- upvalues: u9 (copy), u3 (ref), u23 (copy), u24 (copy), u42 (ref)
                u9.CurveSize1 = u3.lerp(u23, u24, p77);

                return p78 * u42;
            end, u43));
        end;

        local FlipbookData = u4.getFlipbookData(p8);
        local v79;

        if FlipbookData then
            local v81 = {
                ref = p8,
                frames = FlipbookData,
                speedTween = u43,
                effectDuration = v32,
                curve = u1.get(p8, "Flipbook_Change_Curve", u3.linear_bezier),
                duration = u1.get(p8, "Flipbook_Change_Duration", v32),

                getSpeed = function() -- Line: 281, Name: getSpeed
                    -- upvalues: u42 (ref)
                    return u42;
                end,

                setTexture = function(p80) -- Line: 285, Name: setTexture
                    -- upvalues: u9 (copy)
                    u9.Texture = p80;
                end
            };
            v79 = u4.getChangeDuration(v81);
            local fromParams = u2.fromParams;
            local curve = v81.curve;
            local v82 = u4.createUpdateCallback(v81);
            table.insert(p10, fromParams(curve, v79, v82, u43));
        else
            v79 = 0;
        end;

        u2.timer(math.max(v32, v79), function(p83, p84) -- Line: 298
            -- upvalues: u42 (ref), u43 (ref)
            if u42 > 0 or p84 > 0 and (u43 and u43.Connected) then
                return p83 * u42;
            end;

            return nil;
        end, u43, p10);

        if v12 then
            local Finished2 = p10.effects.emitOnFinish(v12, u9.Parent or workspace.Terrain, p10.depth + 1, p10).Finished;
            table.insert(v41, Finished2);
        end;

        u5.all(v41):await();
    end
};