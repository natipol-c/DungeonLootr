--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     bezier
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.bezier
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../mod/common/bezier");
local u5 = require("../obj/Bezier");
local u6 = require("../pkg/Promise");
require("../obj/ObjectCache");
local v7 = {};
local u8 = nil;

function v7.init(p9) -- Line: 18
    -- upvalues: u8 (ref)
    u8 = p9;
end;

function v7.deinit() -- Line: 22
    -- upvalues: u8 (ref)
    u8 = nil;
end;

local function readBezierAttributes(p10: userdata) -- Line: 26
    -- upvalues: u1 (copy), u3 (copy)
    return {
        facePath = u1.get(p10, "FacePath", false),
        arcSpace = u1.get(p10, "ArcSpace", false),
        rotSpeedStart = u1.getRange(p10, "RotSpeed_Start", NumberRange.new(0, 0)),
        rotSpeedEnd = u1.getRange(p10, "RotSpeed_End", NumberRange.new(0, 0)),
        minInitRot = u1.get(p10, "MinInitRot", Vector3.new(0, 0, 0)),
        maxInitRot = u1.get(p10, "MaxInitRot", Vector3.new(0, 0, 0)),
        speedCurve = u1.get(p10, "Speed_Curve", u3.default_bezier),
        speedDuration = u1.get(p10, "Speed_Duration", 0.1),
        easingCurve = u1.get(p10, "Easing_Curve", u3.linear_bezier)
    };
end;

function v7.emit(u11: userdata, u12: userdata, u13: any, p14: boolean?) -- Line: 45
    -- upvalues: u8 (ref), u4 (copy), readBezierAttributes (copy), u3 (copy), u1 (copy), u2 (copy), u5 (copy), u6 (copy), RunService (copy)
    local Points = u11:FindFirstChild("Points");

    if not (Points and (Points:IsA("Attachment") and u8)) then
        return;
    end;

    local u15 = u4.readCommonAttributes(u11);
    local u16 = readBezierAttributes(u11);
    local u17 = u4.drawFuncMap[u15.shapeType] and u4.drawFuncMap[u15.shapeType][u15.shapeStyle];

    if not u17 then
        return;
    end;

    local v18 = u15.emitDuration > 0;
    task.wait(u15.emitDelay);

    if v18 and not p14 then
        u3.forceEmit(u11, true);
        u1.trigger(u11, "Enabled", true);
        u3.onCancel(u13, function() -- Line: 70
            -- upvalues: u3 (ref), u11 (copy)
            local v19 = u3.stopEmitDuration(u11);

            if v19 then
                u3.cancelToken(v19);
            end;
        end);

        if u15.speedStart ~= u15.speedEnd then
            u1.setState(u11, "SpeedTweening", true);
            table.insert(u13, u2.fromParams(u16.speedCurve, u16.speedDuration, function(p20, p21) -- Line: 86
                -- upvalues: u1 (ref), u11 (copy), u3 (ref), u15 (copy)
                u1.setState(u11, "SpeedOverride", u3.lerp(u15.speedStart, u15.speedEnd, p20));

                return p21;
            end, nil, function() -- Line: 91
                -- upvalues: u1 (ref), u11 (copy)
                u1.setState(u11, "SpeedTweening", nil);
            end));
        end;

        task.wait(u15.emitDuration);
        u3.awaitEmitDuration(u3.stopEmitDuration(u11));

        return;
    end;

    if u15.emitCount <= 0 then
        return;
    end;

    local u22 = u4.validateParent(u11);

    if not u22 then
        return;
    end;

    local TransformedOriginExtents, u23 = u3.getTransformedOriginExtents(u22);

    if not TransformedOriginExtents then
        return;
    end;

    local u24, u25 = u4.findEndAttachments(u11);
    local BezierPoints = u3.getBezierPoints(Points);
    local Random_new_ret = Random.new();
    local u26 = not u24 and u5.new(BezierPoints);
    local u27 = u4.createHitboxParams({
        enabled = u15.hitboxEnabled,
        collisionGroup = u15.hitboxCollisionGroup,
        filterTag = u15.hitboxFilterTag,
        filterType = u15.hitboxFilterType,
        ignoreCanCollide = u15.hitboxIgnoreCanCollide
    }, u22, Points);
    local u28 = {};

    for i = 1, u15.emitCount do
        local u29 = Random_new_ret:NextNumber(u16.rotSpeedStart.Min, u16.rotSpeedStart.Max);
        local u30 = Random_new_ret:NextNumber(u16.rotSpeedEnd.Min, u16.rotSpeedEnd.Max);
        local v31 = Random_new_ret:NextNumber(u16.minInitRot.x, u16.maxInitRot.x);
        local v32 = Random_new_ret:NextNumber(u16.minInitRot.y, u16.maxInitRot.y);
        local vector_create_ret = vector.create(v31, v32, Random_new_ret:NextNumber(u16.minInitRot.z, u16.maxInitRot.z));
        local u33 = Random_new_ret:NextNumber(u15.duration.Min, u15.duration.Max);
        local u34 = u15.projectileEnabled and Random_new_ret:NextNumber(u15.projectileLifetime.Min, u15.projectileLifetime.Max);
        table.insert(u28, u6.new(function(u35) -- Line: 154
            -- upvalues: u4 (ref), TransformedOriginExtents (copy), u23 (copy), u15 (copy), u17 (copy), Random_new_ret (copy), u24 (copy), u22 (copy), u26 (copy), BezierPoints (copy), u25 (copy), u16 (copy), u3 (ref), u8 (ref), u12 (copy), u13 (copy), u28 (copy), vector_create_ret (copy), u29 (copy), RunService (ref), u27 (copy), u1 (ref), u11 (copy), u2 (ref), u33 (copy), u30 (copy), u34 (copy)
            local v36 = u4.calculateEmissionCFrame(TransformedOriginExtents, u23, {
                face = u15.face,
                spreadAngle = u15.spreadAngle,
                mirror = u15.mirror,
                mirrorRot = u15.mirrorRot,
                partial = u15.partial,
                emissionDirection = u15.emissionDirection
            }, u17, Random_new_ret, u24, u22:IsA("Attachment"));
            local v37 = u26 or u4.createBezierWithEndpoint(BezierPoints, v36, u24, u25);
            local u38 = u4.createPosGetter(v37, BezierPoints, v36, u24, u16.arcSpace);
            local RandomId = u3.getRandomId();

            if not u8 then
                u35();

                return;
            end;

            local u39 = u8:get(RandomId);
            u39.CFrame = CFrame.new(u38(0));
            local u40 = u39._getReal();
            u3.copyProperties(u12, u40, u3.COPY_PART_PROPERTIES);
            u3.copyProperties(u12, u40, u3.COPY_EXTENDED_PART_PROPERTIES);
            local v41 = u12:Clone();

            for _, child in v41:GetChildren() do
                child.Parent = u40;
            end;

            v41:Destroy();
            local u42 = u13.effects.prepareEmitOnFinish(u40, u13);
            local Finished = u13.effects.emitNested(u40, u13.depth + 1, u13).Finished;
            table.insert(u28, Finished);
            table.insert(u13, function() -- Line: 199
                -- upvalues: u8 (ref), RandomId (copy)
                if u8 then
                    u8:free(RandomId);
                end;
            end);
            local u43 = Vector3.new(0, 0, 0);
            local u44 = Vector3.new(0, 0, 0);
            local u45 = false;
            local u46 = false;
            local CFrame_identity = CFrame.identity;
            local speedStart = u15.speedStart;
            local CFrame_fromOrientation_ret = CFrame.fromOrientation(vector_create_ret.x, vector_create_ret.y, vector_create_ret.z);
            local u47 = u29;

            local function onFinish() -- Line: 218
                -- upvalues: u46 (ref), u15 (ref), u3 (ref), u22 (ref), u39 (copy), RunService (ref), u13 (ref), u42 (copy), u40 (copy), u35 (copy)
                if u46 then
                    return;
                end;

                if u15.syncPosition then
                    local TransformedOriginExtents2 = u3.getTransformedOriginExtents(u22);
                    local CFrame2 = u39.CFrame;

                    local function updatePos() -- Line: 227
                        -- upvalues: u39 (ref), u3 (ref), u22 (ref), TransformedOriginExtents2 (copy), CFrame2 (copy)
                        u39.CFrame = u3.getTransformedOriginExtents(u22) * TransformedOriginExtents2:ToObjectSpace(CFrame2);
                    end;

                    local RandomId2 = u3.getRandomId();
                    RunService:BindToRenderStep(RandomId2, u3.RENDER_PRIORITY + u13.depth, updatePos);
                    table.insert(u13, function() -- Line: 235
                        -- upvalues: RunService (ref), RandomId2 (copy)
                        RunService:UnbindFromRenderStep(RandomId2);
                    end);
                end;

                u46 = true;
                u13.effects.emitOnFinish(u42, u40, u13.depth + 1, u13).Finished:finally(function() -- Line: 243
                    -- upvalues: u35 (ref)
                    u35();
                end);
            end;

            local function shapecast() -- Line: 248
                -- upvalues: u15 (ref), u40 (copy), u27 (ref)
                if u15.hitboxEnabled then
                    return workspace:GetPartsInPart(u40, u27)[1] ~= nil;
                end;

                return false;
            end;

            local u48;

            if u15.speedStart == u15.speedEnd or u1.getState(u11, "SpeedOverride", nil) then
                u48 = nil;
            else
                u48 = u2.fromParams(u16.speedCurve, u16.speedDuration, function(p49, p50) -- Line: 261
                    -- upvalues: speedStart (ref), u3 (ref), u15 (ref)
                    speedStart = u3.lerp(u15.speedStart, u15.speedEnd, p49);

                    return p50;
                end);
                table.insert(u13, u48);
            end;

            local function getEffectiveSpeed() -- Line: 269
                -- upvalues: u1 (ref), u11 (ref), speedStart (ref)
                return u1.getState(u11, "SpeedOverride", speedStart);
            end;

            local function isSpeedTweening() -- Line: 273
                -- upvalues: u48 (ref), u1 (ref), u11 (ref)
                if u48 then
                    return u48.Connected;
                end;

                return u1.getState(u11, "SpeedTweening", false);
            end;

            u4.createPropertyTween(u13, u11, "RotSpeed", u33, u29, u30, function(p51) -- Line: 278
                -- upvalues: u47 (ref)
                u47 = p51;
            end, function() -- Line: 280
                -- upvalues: getEffectiveSpeed (copy)
                return getEffectiveSpeed();
            end, u48);
            table.insert(u13, u2.fromParams(u16.easingCurve, u33, function(p52, p53, p54) -- Line: 290
                -- upvalues: u38 (copy), u16 (ref), u33 (ref), CFrame_identity (ref), vector_create_ret (ref), u47 (ref), u3 (ref), CFrame_fromOrientation_ret (ref), u15 (ref), u39 (copy), u22 (ref), TransformedOriginExtents (ref), u44 (ref), u43 (ref), u40 (copy), u27 (ref), onFinish (copy), u45 (ref), u1 (ref), u11 (ref), speedStart (ref), u48 (ref), u34 (ref)
                local v55 = u38(p52);
                local CFrame_new_ret = CFrame.new(v55);

                if u16.facePath then
                    local v56 = u38((math.clamp((p54 + 0.016666666666666666) / u33, 0, 1)));

                    if v55 == v56 then
                        CFrame_new_ret = CFrame_new_ret * CFrame_identity.Rotation;
                    else
                        CFrame_new_ret = CFrame.lookAt(v55, v56);
                    end;
                end;

                local v57 = vector_create_ret:Sign() * u47 * u3.DEG_TO_RAD * p53;
                CFrame_fromOrientation_ret = CFrame_fromOrientation_ret * CFrame.fromOrientation(v57.x, v57.y, v57.z);
                CFrame_identity = CFrame_new_ret;
                local v58 = CFrame_new_ret * CFrame_fromOrientation_ret;

                if u15.syncPosition then
                    u39.CFrame = u3.getTransformedOriginExtents(u22) * TransformedOriginExtents:ToObjectSpace(v58);
                else
                    u39.CFrame = v58;
                end;

                u44 = (v55 - u43) / p53;
                u43 = v55;
                local v59;

                if u15.hitboxEnabled then
                    v59 = workspace:GetPartsInPart(u40, u27)[1] ~= nil;
                else
                    v59 = false;
                end;

                if v59 then
                    onFinish();
                    u45 = true;

                    return nil;
                end;

                local State = u1.getState(u11, "SpeedOverride", speedStart);
                speedStart = State;

                if State == 0 then
                    local v60;

                    if u48 then
                        v60 = u48.Connected;
                    else
                        v60 = u1.getState(u11, "SpeedTweening", false);
                    end;

                    if not v60 then
                        return nil;
                    end;
                end;

                if u15.projectileEnabled and p52 * u33 < u34 or not u15.projectileEnabled then
                    return p53 * State;
                end;

                onFinish();

                return nil;
            end, u48, function(p61) -- Line: 341
                -- upvalues: u15 (ref), u45 (ref), onFinish (copy), u24 (ref), u44 (ref), u40 (copy), u3 (ref), u22 (ref), u2 (ref), u34 (ref), u39 (copy), u27 (ref), u1 (ref), u11 (ref), speedStart (ref), u48 (ref), u13 (ref)
                if not u15.projectileEnabled or u45 then
                    if p61 then
                        onFinish();
                    end;

                    return;
                end;

                local v62;

                if u15.projectileMatchEnd and u24 then
                    v62 = u24.WorldCFrame.LookVector;
                else
                    v62 = u44.Unit;
                end;

                u44 = (v62 ~= v62 and Vector3.new(0, 0, 0) or v62) * u15.projectileSpeed;
                local Position = u40.Position;
                local TransformedOriginExtents2 = u3.getTransformedOriginExtents(u22);
                u2.timer(u34, function(p63, p64) -- Line: 363
                    -- upvalues: u15 (ref), u39 (ref), u3 (ref), u22 (ref), TransformedOriginExtents2 (copy), Position (copy), u44 (ref), u40 (ref), u27 (ref), onFinish (ref), u45 (ref), u1 (ref), u11 (ref), speedStart (ref), u48 (ref)
                    if u15.syncPosition then
                        u39.CFrame = u3.getTransformedOriginExtents(u22) * TransformedOriginExtents2:ToObjectSpace(CFrame.new(Position + u44 * p64));
                    else
                        u39.CFrame = CFrame.new(Position + u44 * p64) * u40.CFrame.Rotation;
                    end;

                    local v65;

                    if u15.hitboxEnabled then
                        v65 = workspace:GetPartsInPart(u40, u27)[1] ~= nil;
                    else
                        v65 = false;
                    end;

                    if v65 then
                        onFinish();
                        u45 = true;

                        return nil;
                    end;

                    local State = u1.getState(u11, "SpeedOverride", speedStart);
                    speedStart = State;

                    if State > 0 then
                        return p63 * State;
                    end;

                    if p64 > 0 then
                        local v66;

                        if u48 then
                            v66 = u48.Connected;
                        else
                            v66 = u1.getState(u11, "SpeedTweening", false);
                        end;

                        if v66 then
                            return p63 * State;
                        end;
                    end;

                    return nil;
                end, u48, u13, u3.RENDER_PRIORITY + u13.depth);

                if not u45 then
                    onFinish();
                end;
            end, true, u3.RENDER_PRIORITY + u13.depth));
        end));
        local _ = i;
    end;

    u6.all(u28):await();
    task.wait(u15.destroyDelay);
end;

return v7;