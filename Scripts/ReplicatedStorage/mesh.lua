--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     mesh
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.mesh
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../mod/common/flipbook");
local u5 = require("../mod/color/Oklab");
local u6 = require("../pkg/Promise");
local Random_new_ret = Random.new();

return {
    emit = function(u7: userdata, u8: userdata, p9: any, p10: number, p11: boolean?) -- Line: 17, Name: emit
        -- upvalues: u1 (copy), Random_new_ret (copy), u3 (copy), u2 (copy), RunService (copy), u5 (copy), u4 (copy), u6 (copy)
        local Start = u7:FindFirstChild("Start");
        local End = u7:FindFirstChild("End");

        if not Start or (not End or (not Start:IsA("BasePart") or (not End:IsA("BasePart") or u1.get(u7, "Enabled", false) and not p11))) then
            return;
        end;

        local v12 = u1.get(u7, "Duration", 1, true);
        local Range = u1.getRange(u7, "EffectDuration", NumberRange.new(v12, v12), NumberRange.new(0, (1 / 0)));
        local v13 = Random_new_ret:NextNumber(Range.Min, Range.Max);
        local v14 = u1.get(u7, "EmitDelay", 0);
        local v15 = u1.get(u7, "DestroyDelay", 0);
        local v16 = u1.get(u7, "EmitDuration", 0);
        local v17 = u1.get(u7, "Flipbook", false, true);
        local u18 = u1.get(u7, "FlipbookFadeOffset", 0, true);
        local v19 = (v17 or not Start:FindFirstChildOfClass("Decal")) and "Mesh_" or "Decal_";
        local Attribute = u7:GetAttribute("StartTransparency");

        if Attribute ~= nil then
            u7:SetAttribute(v19 .. "StartTransparency", Attribute);
            u7:SetAttribute("StartTransparency", nil);
        end;

        local Attribute2 = u7:GetAttribute("EndTransparency");

        if Attribute2 ~= nil then
            u7:SetAttribute(v19 .. "EndTransparency", Attribute2);
            u7:SetAttribute("EndTransparency", nil);
        end;

        local v20 = u7:HasTag(u3.ENABLED_VFX_TAG) and v16 > 0;
        local u21 = u1.get(u7, "Decal_StartTransparency", 0, true);
        local u22 = u1.get(u7, "Decal_EndTransparency", 1, true);
        local v23;

        if Start then
            v23 = Start:FindFirstChildOfClass("Decal");
        else
            v23 = Start;
        end;

        local v24 = v23 and 1 or 0;
        local v25 = u1.get(u7, "Mesh_StartTransparency", v24, true);
        local v26 = u1.get(u7, "Mesh_EndTransparency", v24, true);
        local u27 = u1.get(u7, "SyncPosition", false);
        local u28 = u1.get(u7, "Speed_Start", 1);
        local u29 = u1.get(u7, "Speed_End", 1);
        local u30 = u1.get(u7, "Part_Transparency_Start", v25);
        local u31 = u1.get(u7, "Part_Transparency_End", v26);
        local v32 = u1.get(u7, "SpreadAngle", Vector3.new(0, 0, 0));
        local Range2 = u1.getRange(u7, "Part_RotSpeed_Start", NumberRange.new(0, 0));
        local Range3 = u1.getRange(u7, "Part_RotSpeed_End", NumberRange.new(0, 0));
        local u33 = u1.get(u7, "RotAroundOrigin", false);
        local v34 = u1.get(u7, "MinInitRot", Vector3.new(0, 0, 0));
        local v35 = u1.get(u7, "MaxInitRot", Vector3.new(0, 0, 0));
        local u36 = Random_new_ret:NextNumber(Range2.Min, Range2.Max);
        local u37 = Random_new_ret:NextNumber(Range3.Min, Range3.Max);
        local v38 = Random_new_ret:NextNumber(v34.x, v35.x);
        local v39 = Random_new_ret:NextNumber(v34.y, v35.y);
        local u40 = vector.create(v38, v39, Random_new_ret:NextNumber(v34.z, v35.z)) * u3.DEG_TO_RAD;
        task.wait(v14);

        if v20 and not p11 then
            u3.forceEmit(u7, true);
            u1.trigger(u7, "Enabled", true);
            u3.onCancel(p9, function() -- Line: 125
                -- upvalues: u3 (ref), u7 (copy)
                local v41 = u3.stopEmitDuration(u7);

                if v41 then
                    u3.cancelToken(v41);
                end;
            end);

            if u28 ~= u29 then
                u1.setState(u7, "SpeedTweening", true);
                local fromParams = u2.fromParams;
                local v42 = u1.get(u7, "Speed_Curve", u3.default_bezier);
                local v43 = u1.get(u7, "Speed_Duration", 0.1);
                table.insert(p9, fromParams(v42, v43, function(p44, p45) -- Line: 141
                    -- upvalues: u1 (ref), u7 (copy), u3 (ref), u28 (copy), u29 (copy)
                    u1.setState(u7, "SpeedOverride", u3.lerp(u28, u29, p44));

                    return p45;
                end, nil, function() -- Line: 146
                    -- upvalues: u1 (ref), u7 (copy)
                    u1.setState(u7, "SpeedTweening", nil);
                end));
            end;

            task.wait(v16);
            u3.awaitEmitDuration(u3.stopEmitDuration(u7));

            return;
        end;

        local u46 = u7:FindFirstAncestorOfClass("Attachment") or Start;
        local u47;

        if typeof(u8) == "table" then
            u47 = u8._getReal() or u8;
        else
            u47 = u8;
        end;

        local TransformedOriginExtents = u3.getTransformedOriginExtents(u46);
        local u48 = Start.CFrame:ToObjectSpace(End.CFrame);
        local u49 = u28;
        local u50 = u36;
        local CFrame_fromOrientation_ret = CFrame.fromOrientation(u40.x, u40.y, u40.z);
        local CFrame_identity = CFrame.identity;
        local CFrame_fromOrientation = CFrame.fromOrientation;
        local v51 = Random_new_ret:NextNumber(-v32.x, v32.x);
        local math_rad_ret = math.rad(v51);
        local v52 = Random_new_ret:NextNumber(-v32.y, v32.y);
        local u53 = CFrame_fromOrientation(math_rad_ret, math.rad(v52), 0);

        local function updatePos(p54: number) -- Line: 178
            -- upvalues: u27 (copy), u3 (ref), u46 (copy), TransformedOriginExtents (copy), u40 (copy), u50 (ref), CFrame_fromOrientation_ret (ref), u33 (copy), u53 (copy), CFrame_identity (ref), u8 (copy)
            local v55 = u27 and u3.getTransformedOriginExtents(u46) or TransformedOriginExtents;
            local v56 = u40:Sign() * u50 * p54;
            CFrame_fromOrientation_ret = CFrame_fromOrientation_ret * CFrame.fromOrientation(v56.x, v56.y, v56.z);
            local v57;

            if u33 then
                v57 = v55 * u53 * CFrame_fromOrientation_ret * CFrame_identity;
            else
                v57 = v55 * u53 * CFrame_identity * CFrame_fromOrientation_ret;
            end;

            u8.CFrame = v57 * CFrame_fromOrientation_ret;
        end;

        updatePos(0);
        local RandomId = u3.getRandomId();
        RunService:BindToRenderStep(RandomId, u3.RENDER_PRIORITY + p9.depth, updatePos);
        table.insert(p9, function() -- Line: 204
            -- upvalues: RunService (ref), RandomId (copy)
            RunService:UnbindFromRenderStep(RandomId);
        end);
        local v58 = {};
        local v59 = p9.effects.prepareEmitOnFinish(u8, p9);
        local Finished = p9.effects.emitNested(u8, p9.depth + 1, p9).Finished;
        table.insert(v58, Finished);
        local u60;

        if u28 == u29 or u1.getState(u7, "SpeedOverride", nil) then
            u60 = nil;
        else
            u60 = u2.fromParams(u1.get(u7, "Speed_Curve", u3.default_bezier), u1.get(u7, "Speed_Duration", 0.1), function(p61, p62) -- Line: 222
                -- upvalues: u49 (ref), u3 (ref), u28 (copy), u29 (copy)
                u49 = u3.lerp(u28, u29, p61);

                return p62;
            end);
            table.insert(p9, u60);
        end;

        if u48 ~= CFrame.identity then
            local fromParams = u2.fromParams;
            local v63 = u1.get(u7, "Part_CFrame_Curve", u3.default_bezier);
            table.insert(p9, fromParams(v63, v13, function(p64, p65) -- Line: 234
                -- upvalues: CFrame_identity (ref), u48 (copy), u1 (ref), u7 (copy), u49 (ref)
                CFrame_identity = CFrame.identity:Lerp(u48, p64);

                return p65 * u1.getState(u7, "SpeedOverride", u49);
            end, u60));
        end;

        if u36 ~= u37 then
            local fromParams = u2.fromParams;
            local v66 = u1.get(u7, "Part_RotSpeed_Curve", u3.default_bezier);
            table.insert(p9, fromParams(v66, v13, function(p67, p68) -- Line: 247
                -- upvalues: u50 (ref), u3 (ref), u36 (copy), u37 (copy), u1 (ref), u7 (copy), u49 (ref)
                u50 = u3.lerp(u36, u37, p67);

                return p68 * u1.getState(u7, "SpeedOverride", u49);
            end, u60));
        end;

        if u30 == u31 then
            u8.Transparency = u30;
        else
            local fromParams = u2.fromParams;
            local v69 = u1.get(u7, "Part_Transparency_Curve", u3.default_bezier);
            table.insert(p9, fromParams(v69, v13, function(p70, p71) -- Line: 262
                -- upvalues: u8 (copy), u3 (ref), u30 (copy), u31 (copy), u1 (ref), u7 (copy), u49 (ref)
                u8.Transparency = u3.lerp(u30, u31, p70);

                return p71 * u1.getState(u7, "SpeedOverride", u49);
            end, u60));
        end;

        local u72 = Start.Size * p10;
        local u73 = End.Size * p10;

        if u72 == u73 then
            u8.Size = u72;
        else
            local u74 = -1;
            local fromParams = u2.fromParams;
            local v75 = u1.get(u7, "Part_Size_Curve", u3.default_bezier);
            table.insert(p9, fromParams(v75, v13, function(p76, p77) -- Line: 280
                -- upvalues: u1 (ref), u7 (copy), u49 (ref), u74 (ref), u8 (copy), u72 (copy), u73 (copy)
                local State = u1.getState(u7, "SpeedOverride", u49);

                if math.abs(p76 - u74) < 0.005 then
                    return p77 * State;
                end;

                u74 = p76;
                u8.Size = u72:Lerp(u73, p76);

                return p77 * State;
            end, u60));
        end;

        local v78 = Start:FindFirstChildOfClass("SpecialMesh");
        local v79 = End:FindFirstChildOfClass("SpecialMesh");
        local u80 = u8:FindFirstChildOfClass("SpecialMesh");

        if u80 then
            if v78 and v79 then
                local u81 = v78.Scale * p10;
                local u82 = v79.Scale * p10;

                if u81 ~= u82 then
                    local fromParams = u2.fromParams;
                    local v83 = u1.get(u7, "Mesh_Scale_Curve", u3.default_bezier);
                    table.insert(p9, fromParams(v83, v13, function(p84, p85) -- Line: 313
                        -- upvalues: u80 (copy), u3 (ref), u81 (copy), u82 (copy), u1 (ref), u7 (copy), u49 (ref)
                        u80.Scale = u3.lerp(u81, u82, p84);

                        return p85 * u1.getState(u7, "SpeedOverride", u49);
                    end, u60));
                end;
            else
                u80.Parent = nil;
                table.insert(p9, function() -- Line: 324
                    -- upvalues: u80 (copy), u47 (copy)
                    u80.Parent = u47;
                end);
            end;
        end;

        local MeshDecals, v86, v87 = u3.getMeshDecals(u7, u8);
        local v88 = 0;

        if v17 then
            table.sort(MeshDecals, function(p89, p90) -- Line: 335
                local v91 = p89.Name:match("%d+") or 0;
                local v92 = p90.Name:match("%d+") or 0;

                return tonumber(v91) < tonumber(v92);
            end);
            local Decal = Instance.new("Decal");
            Decal.Parent = u47;
            table.insert(p9, Decal);

            if u18 > 0 and u21 ~= u22 then
                table.insert(p9, u2.fromParams(u3.default_bezier, v13 + u18, function(p93, p94) -- Line: 351
                    -- upvalues: Decal (copy), u3 (ref), u21 (copy), u22 (copy), u1 (ref), u7 (copy), u49 (ref)
                    Decal.Transparency = u3.lerp(u21, u22, p93);

                    return p94 * u1.getState(u7, "SpeedOverride", u49);
                end, u60));
            end;

            table.insert(p9, u2.fromParams(u3.default_bezier, v13, function(p95, p96) -- Line: 361
                -- upvalues: MeshDecals (copy), Decal (copy), u18 (copy), u3 (ref), u21 (copy), u22 (copy), u1 (ref), u7 (copy), u49 (ref)
                local math_round_ret = math.round(#MeshDecals * p95);
                local v97 = MeshDecals[math.max(math_round_ret, 1)];
                Decal.Texture = v97.Texture;
                Decal.Color3 = v97.Color3;
                Decal.ZIndex = v97.ZIndex;

                if u18 == 0 then
                    Decal.Transparency = u3.lerp(u21, u22, p95);
                    Decal.ZIndex = v97.ZIndex;
                end;

                return p96 * u1.getState(u7, "SpeedOverride", u49);
            end, u60));
        else
            for _, v in MeshDecals do
                local u98 = v87[v];
                local u99 = u1.get(v, "Transparency_Start", u21);
                local u100 = u1.get(v, "Transparency_End", u22);

                if u99 == u100 then
                    v.Transparency = u99;
                else
                    local fromParams = u2.fromParams;
                    local v101 = u1.get(v, "Transparency_Curve", u3.default_bezier);
                    table.insert(p9, fromParams(v101, v13, function(p102, p103) -- Line: 392
                        -- upvalues: v (copy), u3 (ref), u99 (copy), u100 (copy), u1 (ref), u7 (copy), u49 (ref)
                        v.Transparency = u3.lerp(u99, u100, p102);

                        return p103 * u1.getState(u7, "SpeedOverride", u49);
                    end, u60));
                end;

                if v.Color3 ~= u98.Color3 then
                    local fromParams = u2.fromParams;
                    local v104 = u1.get(v, "Color_Curve", u3.default_bezier);
                    table.insert(p9, fromParams(v104, v13, function(p105, p106) -- Line: 406
                        -- upvalues: u5 (ref), v (copy), u98 (copy), v (copy), u1 (ref), u7 (copy), u49 (ref)
                        local v107 = u5.fromSRGB(v.Color3);
                        local v108 = u5.fromSRGB(u98.Color3);
                        v.Color3 = u5.toSRGB(v107:Lerp(v108, p105), true);

                        return p106 * u1.getState(u7, "SpeedOverride", u49);
                    end, u60));
                end;

                local v109 = v86[v];

                if v109 then
                    local v111 = {
                        ref = v,
                        frames = v109,
                        speedTween = u60,
                        effectDuration = v13,
                        curve = u1.get(v, "Flipbook_Change_Curve", u3.linear_bezier),
                        duration = u1.get(v, "Flipbook_Change_Duration", v13),

                        getSpeed = function() -- Line: 429, Name: getSpeed
                            -- upvalues: u1 (ref), u7 (copy), u49 (ref)
                            return u1.getState(u7, "SpeedOverride", u49);
                        end,

                        setTexture = function(p110) -- Line: 433, Name: setTexture
                            -- upvalues: v (copy)
                            v.Texture = p110;
                        end
                    };
                    local ChangeDuration = u4.getChangeDuration(v111);

                    if v88 < ChangeDuration then
                        v88 = ChangeDuration;
                    end;

                    local fromParams = u2.fromParams;
                    local curve = v111.curve;
                    local v112 = u4.createUpdateCallback(v111);
                    table.insert(p9, fromParams(curve, ChangeDuration, v112, u60));
                end;
            end;
        end;

        u2.timer(math.max(v13, v88) + u18 + v15, function(p113, p114) -- Line: 454
            -- upvalues: u1 (ref), u7 (copy), u49 (ref), u60 (ref)
            local State = u1.getState(u7, "SpeedOverride", u49);
            u49 = State;

            if State > 0 then
                return p113 * State;
            end;

            if p114 > 0 then
                local v115;

                if u60 then
                    v115 = u60.Connected;
                else
                    v115 = u1.getState(u7, "SpeedTweening", false);
                end;

                if v115 then
                    return p113 * State;
                end;
            end;

            return nil;
        end, u60, p9);
        u6.all(v58):await();
        p9.effects.emitOnFinish(v59, u47, p9.depth + 1, p9).Finished:await();
    end
};