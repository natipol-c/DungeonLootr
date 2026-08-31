--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     lightning
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.lightning
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
local u4 = require("../mod/common/bezier");
local u5 = require("../obj/Bezier");
local u6 = require("../pkg/Promise");
require("../obj/ObjectCache");
local v7 = {};
local u8 = nil;

function v7.init(p9) -- Line: 16
    -- upvalues: u8 (ref)
    u8 = p9;
end;

function v7.deinit() -- Line: 20
    -- upvalues: u8 (ref)
    u8 = nil;
end;

local function readLightningAttributes(p10: userdata) -- Line: 24
    -- upvalues: u1 (copy), u3 (copy)
    local v11 = {};
    local v12 = u1.get(p10, "Segments", 8);
    v11.segments = math.max(v12, 2);
    v11.jaggedness = u1.getRange(p10, "Jaggedness", NumberRange.new(0.5, 1), NumberRange.new(0, (1 / 0)));
    v11.offsetScale = u1.get(p10, "OffsetScale", 1);
    v11.refreshRate = u1.get(p10, "RefreshRate", 15);
    v11.independentSegments = u1.get(p10, "IndependentSegments", false);
    v11.refreshDuringDissipate = u1.get(p10, "RefreshDuringDissipate", false);
    v11.nestedEffectMode = u1.getEnum(p10, "NestedEffectMode", "None", { "None", "All", "Head", "Tail" });
    v11.colorSequence = u1.get(p10, "Color", ColorSequence.new(Color3.new(1, 1, 1)));
    v11.colorEasingData = u1.get(p10, "Color_Curve", u3.linear_bezier);
    v11.colorDuration = u1.get(p10, "Color_Duration", 1);
    v11.transparencyStart = u1.get(p10, "Transparency_Start", 0);
    v11.transparencyEnd = u1.get(p10, "Transparency_End", 0);
    v11.fillColorSequence = u1.get(p10, "Fill_Color", ColorSequence.new(Color3.new(1, 1, 1)));
    v11.fillColorEasingData = u1.get(p10, "Fill_Color_Curve", u3.linear_bezier);
    v11.fillColorDuration = u1.get(p10, "Fill_Color_Duration", 1);
    v11.fillTransparencyStart = u1.get(p10, "Fill_Transparency_Start", 1);
    v11.fillTransparencyEnd = u1.get(p10, "Fill_Transparency_End", 1);
    v11.fillDepthMode = u1.getEnum(p10, "Fill_DepthMode", "Occluded", { "AlwaysOnTop", "Occluded" });
    v11.fadeInStart = u1.get(p10, "Fade_In_Start", 1);
    v11.fadeInDuration = u1.get(p10, "Fade_In_Duration", 0);
    v11.fadeInCurveData = u1.get(p10, "Fade_In_Curve", u3.default_bezier);
    v11.fadeOutEnd = u1.get(p10, "Fade_Out_End", 1);
    v11.fadeOutDuration = u1.get(p10, "Fade_Out_Duration", 0);
    v11.fadeOutCurveData = u1.get(p10, "Fade_Out_Curve", u3.default_bezier);
    v11.lengthStart = u1.get(p10, "Length_Start", 1);
    v11.lengthEnd = u1.get(p10, "Length_End", 1);
    v11.dissipateMode = u1.getEnum(p10, "Dissipate_Mode", "None", { "None", "Retract", "Scale" });
    v11.dissipateDuration = u1.get(p10, "Dissipate_Duration", 0.5);
    v11.dissipateCurveData = u1.get(p10, "Dissipate_Curve", u3.default_bezier);
    v11.widthStart = u1.get(p10, "Width_Start", 2);
    v11.widthEnd = u1.get(p10, "Width_End", 0.2);

    return v11;
end;

local function createSegmentStates(p13: number) -- Line: 77
    local v14 = {};

    for i = 1, p13 do
        v14[i] = {
            birthTime = nil,
            initialWidth = nil,
            initialTransparency = nil,
            wasVisible = false
        };
        local _ = i;
    end;

    return v14;
end;

local function computeJaggedOffset(p15: userdata, p16, p17: number, p18: number, p19: vector, p20: vector) -- Line: 92
    local v21 = p15:NextNumber(p16.Min, p16.Max);
    local math_min_ret = math.min(v21 * p17 * p18, p18 * 0.8);
    local v22 = p15:NextNumber(0, 6.283185307179586);

    return (p19 * math.cos(v22) + p20 * math.sin(v22)) * math_min_ret;
end;

local function generateLightningPoints(p23: userdata, p24: number, p25: function, p26, p27: number) -- Line: 109
    -- upvalues: u4 (copy)
    local table_create_ret = table.create(p24 + 1);
    local v28 = 1 / p24;
    table_create_ret[1] = p25(0);
    local v29 = table_create_ret[1];

    for i = 1, p24 - 1 do
        local v30 = i * v28;
        local v31 = p25(v30);
        local v32 = p25((math.min(v30 + 0.01, 1))) - v31;
        local PerpendicularVectors, v33 = u4.getPerpendicularVectors(v32.Magnitude <= 0.001 and Vector3.new(0, 1, 0) or v32.Unit);
        local Magnitude = (v31 - v29).Magnitude;
        local v34 = p23:NextNumber(p26.Min, p26.Max);
        local math_min_ret = math.min(v34 * p27 * Magnitude, Magnitude * 0.8);
        local v35 = p23:NextNumber(0, 6.283185307179586);
        v29 = v31 + (PerpendicularVectors * math.cos(v35) + v33 * math.sin(v35)) * math_min_ret;
        table_create_ret[i + 1] = v29;
        local _ = i;
    end;

    table_create_ret[p24 + 1] = p25(1);

    return table_create_ret;
end;

local function generateProjectilePoints(p36: userdata, p37: number, p38: vector, p39: vector, p40, p41: number, p42: vector) -- Line: 148
    -- upvalues: u4 (copy)
    local table_create_ret = table.create(p37 + 1);
    local v43 = 1 / p37;
    local v44 = p39 - p38;
    local Magnitude = v44.Magnitude;

    if Magnitude > 0.001 then
        p42 = v44 / Magnitude;
    end;

    local PerpendicularVectors, v45 = u4.getPerpendicularVectors(p42);
    local v46 = Magnitude * v43;
    table_create_ret[1] = p38;

    for i = 1, p37 - 1 do
        local v47 = p38:Lerp(p39, i * v43);
        local v48 = p36:NextNumber(p40.Min, p40.Max);
        local math_min_ret = math.min(v48 * p41 * v46, v46 * 0.8);
        local v49 = p36:NextNumber(0, 6.283185307179586);
        local v50 = (PerpendicularVectors * math.cos(v49) + v45 * math.sin(v49)) * math_min_ret;
        table_create_ret[i + 1] = v47 + v50;
        local _ = i;
    end;

    table_create_ret[p37 + 1] = p39;

    return table_create_ret;
end;

local function getBlendedPosition(p51: number, p52: function, p53: vector, p54: vector, p55: table) -- Line: 193
    local math_clamp_ret = math.clamp((p55.distanceTraveled - (1 - p51) * p55.boltLength) / p55.transitionBuffer, 0, 1);
    local v56 = math.min(p55.distanceTraveled / p55.boltLength, 1) * p55.curvedLengthT;

    return p52((math.min(1, p55.curvedTailT + p51 * p55.curvedLengthT + v56))):Lerp(p53:Lerp(p54, p51), math_clamp_ret);
end;

local function generateTransitionPoints(p57: userdata, p58: number, p59: function, p60: vector, p61: vector, p62, p63: number, p64: vector, p65: table) -- Line: 217
    -- upvalues: u4 (copy), getBlendedPosition (copy)
    local table_create_ret = table.create(p58 + 1);
    local table_create_ret2 = table.create(p58 + 1);
    local v66 = 1 / p58;
    local v67 = p61 - p60;
    local Magnitude = v67.Magnitude;

    if Magnitude > 0.001 then
        p64 = v67 / Magnitude;
    end;

    local PerpendicularVectors, v68 = u4.getPerpendicularVectors(p64);
    local v69 = Magnitude * v66;

    for i = 0, p58 do
        local v70 = getBlendedPosition(i * v66, p59, p60, p61, p65);
        local v71;

        if i == 0 or i == p58 then
            table_create_ret[i + 1] = v70;
            table_create_ret2[i + 1] = Vector3.new(0, 0, 0);
            v71 = i;
        else
            local v72 = p57:NextNumber(p62.Min, p62.Max);
            local math_min_ret = math.min(v72 * p63 * v69, v69 * 0.8);
            local v73 = p57:NextNumber(0, 6.283185307179586);
            local v74 = (PerpendicularVectors * math.cos(v73) + v68 * math.sin(v73)) * math_min_ret;
            table_create_ret[i + 1] = v70 + v74;
            table_create_ret2[i + 1] = v74;
            v71 = i;
        end;
    end;

    return table_create_ret, table_create_ret2;
end;

local function updateTransitionPoints(p75: number, p76: function, p77: vector, p78: vector, p79: table) -- Line: 259
    -- upvalues: getBlendedPosition (copy)
    local table_create_ret = table.create(p75 + 1);
    local v80 = 1 / p75;
    local jaggedOffsets = p79.jaggedOffsets;

    for i = 0, p75 do
        local v81 = getBlendedPosition(i * v80, p76, p77, p78, p79);
        table_create_ret[i + 1] = v81 + (not jaggedOffsets and Vector3.new(0, 0, 0) or jaggedOffsets[i + 1]);
        local _ = i;
    end;

    return table_create_ret;
end;

local function isTransitionComplete(p82: table) -- Line: 281
    return p82.distanceTraveled >= p82.boltLength + p82.transitionBuffer;
end;

function v7.emit(u83: userdata, u84: userdata, u85: any, p86: boolean?) -- Line: 285
    -- upvalues: u8 (ref), u4 (copy), readLightningAttributes (copy), u3 (copy), u1 (copy), u2 (copy), u5 (copy), u6 (copy), createSegmentStates (copy), generateLightningPoints (copy), generateTransitionPoints (copy), generateProjectilePoints (copy), updateTransitionPoints (copy)
    local Points = u83:FindFirstChild("Points");

    if not (Points and (Points:IsA("Attachment") and u8)) then
        return;
    end;

    local u87 = u4.readCommonAttributes(u83);
    local u88 = readLightningAttributes(u83);
    local u89 = u4.drawFuncMap[u87.shapeType] and u4.drawFuncMap[u87.shapeType][u87.shapeStyle];

    if not u89 then
        return;
    end;

    local v90 = u87.emitDuration > 0;
    task.wait(u87.emitDelay);

    if v90 and not p86 then
        u3.forceEmit(u83, true);
        u1.trigger(u83, "Enabled", true);
        u3.onCancel(u85, function() -- Line: 310
            -- upvalues: u3 (ref), u83 (copy)
            local v91 = u3.stopEmitDuration(u83);

            if v91 then
                u3.cancelToken(v91);
            end;
        end);

        if u87.speedStart ~= u87.speedEnd then
            u1.setState(u83, "SpeedTweening", true);
            local fromParams = u2.fromParams;
            local v92 = u1.get(u83, "Speed_Curve", u3.default_bezier);
            local v93 = u1.get(u83, "Speed_Duration", 0.1);
            table.insert(u85, fromParams(v92, v93, function(p94, p95) -- Line: 326
                -- upvalues: u1 (ref), u83 (copy), u3 (ref), u87 (copy)
                u1.setState(u83, "SpeedOverride", u3.lerp(u87.speedStart, u87.speedEnd, p94));

                return p95;
            end, nil, function() -- Line: 331
                -- upvalues: u1 (ref), u83 (copy)
                u1.setState(u83, "SpeedTweening", nil);
            end));
        end;

        task.wait(u87.emitDuration);
        u3.awaitEmitDuration(u3.stopEmitDuration(u83));

        return;
    end;

    if u87.emitCount <= 0 then
        return;
    end;

    local u96 = u4.validateParent(u83);

    if not u96 then
        return;
    end;

    local TransformedOriginExtents, u97 = u3.getTransformedOriginExtents(u96);

    if not TransformedOriginExtents then
        return;
    end;

    local u98, u99 = u4.findEndAttachments(u83);
    local BezierPoints = u3.getBezierPoints(Points);
    local Random_new_ret = Random.new();
    local u100 = not u98 and u5.new(BezierPoints);
    local u101 = u5.new(u3.deserializePath(u88.colorEasingData), 0);
    local u102 = u5.new(u3.deserializePath(u88.fillColorEasingData), 0);
    local u103 = u5.new(u3.deserializePath(u88.fadeInCurveData), 0);
    local u104 = u5.new(u3.deserializePath(u88.fadeOutCurveData), 0);
    local u105 = u4.createHitboxParams({
        enabled = u87.hitboxEnabled,
        collisionGroup = u87.hitboxCollisionGroup,
        filterTag = u87.hitboxFilterTag,
        filterType = u87.hitboxFilterType,
        ignoreCanCollide = u87.hitboxIgnoreCanCollide
    }, u96, Points);
    local u106 = {};

    for i = 1, u87.emitCount do
        local u107 = Random_new_ret:NextNumber(u87.duration.Min, u87.duration.Max);
        local u108 = u87.projectileEnabled and Random_new_ret:NextNumber(u87.projectileLifetime.Min, u87.projectileLifetime.Max);
        table.insert(u106, u6.new(function(u109) -- Line: 390
            -- upvalues: u4 (ref), TransformedOriginExtents (copy), u97 (copy), u87 (copy), u89 (copy), Random_new_ret (copy), u98 (copy), u96 (copy), u100 (copy), BezierPoints (copy), u99 (copy), u88 (copy), createSegmentStates (ref), u8 (ref), u102 (copy), u85 (copy), u84 (copy), u3 (ref), generateLightningPoints (ref), u106 (copy), u1 (ref), u83 (copy), u2 (ref), u105 (copy), generateTransitionPoints (ref), generateProjectilePoints (ref), updateTransitionPoints (ref), u101 (copy), u103 (copy), u104 (copy), u107 (copy), u108 (copy)
            local v110 = u4.calculateEmissionCFrame(TransformedOriginExtents, u97, {
                face = u87.face,
                spreadAngle = u87.spreadAngle,
                mirror = u87.mirror,
                mirrorRot = u87.mirrorRot,
                partial = u87.partial,
                emissionDirection = u87.emissionDirection
            }, u89, Random_new_ret, u98, u96:IsA("Attachment"));
            local v111 = u100 or u4.createBezierWithEndpoint(BezierPoints, v110, u98, u99);
            local u112 = u4.createPosGetter(v111, BezierPoints, v110, u98, true);
            local table_create_ret = table.create(u88.segments);
            local table_create_ret2 = table.create(u88.segments);
            local u113 = createSegmentStates(u88.segments);
            local v114 = 1 / u88.segments;
            local table_create_ret3 = table.create(u88.segments);

            for i2 = 1, u88.segments do
                table_create_ret3[i2] = {
                    start = (i2 - 1) * v114,
                    finish = i2 * v114
                };
                local _ = i2;
            end;

            if not u8 then
                u109();

                return;
            end;

            local v115 = u88.fillTransparencyStart < 1 and true or u88.fillTransparencyEnd < 1;
            local u116, u117;

            if v115 then
                u116 = Instance.new("Model");
                u116.Name = "LightningContainer";
                u116.Parent = workspace.Terrain;
                u117 = Instance.new("Highlight");
                u117.Adornee = u116;
                u117.FillColor = u4.getColorWithEasingOklab(u88.fillColorSequence, 0, u102);
                u117.FillTransparency = u88.fillTransparencyStart;
                u117.OutlineTransparency = 1;
                u117.DepthMode = Enum.HighlightDepthMode[u88.fillDepthMode];
                u117.Parent = u116;
            else
                u117 = nil;
                u116 = nil;
            end;

            local function shouldEmitNested(p118: number) -- Line: 448
                -- upvalues: u88 (ref)
                local nestedEffectMode = u88.nestedEffectMode;

                if nestedEffectMode == "All" then
                    return true;
                end;

                if nestedEffectMode == "Head" then
                    return p118 == u88.segments;
                end;

                if nestedEffectMode == "Tail" then
                    return p118 == 1;
                end;

                return false;
            end;

            local u119;

            if u88.nestedEffectMode == "None" then
                u119 = nil;
            else
                u119 = u85.effects.prepareEmitOnFinish(u84, u85);
            end;

            local u120 = {};
            local v121 = {};

            for i2 = 1, u88.segments do
                local RandomId = u3.getRandomId();
                local v122 = u8:get(RandomId)._getReal();
                u3.copyProperties(u84, v122, u3.COPY_PART_PROPERTIES);
                v122.Size = Vector3.new(u88.widthStart, u88.widthStart, 1);
                v122.Anchored = true;
                v122.CanQuery = false;
                v122.CanTouch = false;
                v122.CanCollide = false;

                if v115 and u116 then
                    v122.Parent = u116;
                end;

                local nestedEffectMode = u88.nestedEffectMode;
                local v123;

                if nestedEffectMode == "All" then
                    v123 = true;
                elseif nestedEffectMode == "Head" then
                    v123 = i2 == u88.segments;
                elseif nestedEffectMode == "Tail" then
                    v123 = i2 == 1;
                else
                    v123 = false;
                end;

                local v124;

                if v123 then
                    local v125 = u84:Clone();
                    v124 = i2;

                    for _, child in v125:GetChildren() do
                        child.Parent = v122;

                        if u88.nestedEffectMode == "Head" then
                            table.insert(u120, child);
                        end;
                    end;

                    v125:Destroy();
                    table.insert(v121, v124);
                else
                    v124 = i2;
                end;

                table_create_ret[v124] = v122;
                table_create_ret2[v124] = RandomId;
            end;

            local u126;

            if u88.nestedEffectMode == "Head" and #u120 > 0 then
                for _, v in u120 do
                    v.Parent = table_create_ret[1];
                end;

                u126 = 1;
            else
                u126 = nil;
            end;

            table.insert(u85, function() -- Line: 521
                -- upvalues: u8 (ref), u88 (ref), table_create_ret2 (copy), u116 (ref)
                if u8 then
                    for i2 = 1, u88.segments do
                        u8:free(table_create_ret2[i2]);
                        local _ = i2;
                    end;

                    if u116 then
                        u116:Destroy();
                    end;
                end;
            end);
            local u127 = u116 or u84;
            local speedStart = u87.speedStart;
            local widthStart = u88.widthStart;
            local lengthStart = u88.lengthStart;
            local transparencyStart = u88.transparencyStart;
            local fillTransparencyStart = u88.fillTransparencyStart;
            local u128 = generateLightningPoints(Random_new_ret, u88.segments, u112, u88.jaggedness, u88.offsetScale);
            local u129 = 0;
            local u130 = 0;
            local u131 = 0;
            local u132 = false;

            for _, v in v121 do
                local Finished = u85.effects.emitNested(table_create_ret[u88.nestedEffectMode == "Head" and 1 or v], u85.depth + 1, u85).Finished;
                table.insert(u106, Finished);
            end;

            local u133 = Vector3.new(0, 0, 0);
            local u134 = Vector3.new(0, 0, 0);
            local u135 = 0;
            local u136 = false;
            local u137 = 0;
            local u138 = 0;
            local u139 = 0;
            local widthStart2 = u88.widthStart;
            local u140 = TransformedOriginExtents;
            local u141 = nil;
            local u142 = nil;
            local u143 = nil;
            local u144 = nil;
            local u145;

            if u87.speedStart == u87.speedEnd or u1.getState(u83, "SpeedOverride", nil) then
                u145 = nil;
            else
                u145 = u2.fromParams(u1.get(u83, "Speed_Curve", u3.default_bezier), u1.get(u83, "Speed_Duration", 0.1), function(p146, p147) -- Line: 586
                    -- upvalues: speedStart (ref), u3 (ref), u87 (ref)
                    speedStart = u3.lerp(u87.speedStart, u87.speedEnd, p146);

                    return p147;
                end);
                table.insert(u85, u145);
            end;

            local function getEffectiveSpeed() -- Line: 595
                -- upvalues: u1 (ref), u83 (ref), speedStart (ref)
                return u1.getState(u83, "SpeedOverride", speedStart);
            end;

            local function isSpeedTweening() -- Line: 599
                -- upvalues: u145 (ref), u1 (ref), u83 (ref)
                if u145 then
                    return u145.Connected;
                end;

                return u1.getState(u83, "SpeedTweening", false);
            end;

            local function getSpeedDelta(p148: number, p149: boolean?) -- Line: 603
                -- upvalues: u1 (ref), u83 (ref), speedStart (ref), u145 (ref)
                local State = u1.getState(u83, "SpeedOverride", speedStart);
                speedStart = State;

                if State > 0 then
                    return p148 * State;
                end;

                if not p149 then
                    local v150;

                    if u145 then
                        v150 = u145.Connected;
                    else
                        v150 = u1.getState(u83, "SpeedTweening", false);
                    end;

                    if not v150 then
                        return nil;
                    end;
                end;

                return p148 * State;
            end;

            local function getHeadSegmentIndex() -- Line: 616
                -- upvalues: u137 (ref), u88 (ref)
                local math_ceil_ret = math.ceil(u137 * u88.segments);

                return math.clamp(math_ceil_ret, 1, u88.segments);
            end;

            local function shapecast() -- Line: 620
                -- upvalues: u87 (ref), table_create_ret (copy), u137 (ref), u88 (ref), u105 (ref)
                if not u87.hitboxEnabled then
                    return false;
                end;

                local math_ceil_ret = math.ceil(u137 * u88.segments);
                local v151 = table_create_ret[math.clamp(math_ceil_ret, 1, u88.segments)];

                return v151 and (v151.Transparency < 1 and workspace:GetPartsInPart(v151, u105)[1]) and true or false;
            end;

            local function refreshPoints() -- Line: 639
                -- upvalues: u142 (ref), u143 (ref), u141 (ref), u144 (ref), u128 (ref), generateTransitionPoints (ref), Random_new_ret (ref), u88 (ref), u112 (copy), generateProjectilePoints (ref), generateLightningPoints (ref)
                if u142 and (u143 and u141) then
                    if u144 then
                        local v152 = u144;

                        if v152.distanceTraveled < v152.boltLength + v152.transitionBuffer then
                            local v153, v154 = generateTransitionPoints(Random_new_ret, u88.segments, u112, u143, u142, u88.jaggedness, u88.offsetScale, u141, u144);
                            u128 = v153;
                            u144.jaggedOffsets = v154;

                            return;
                        end;
                    end;

                    u128 = generateProjectilePoints(Random_new_ret, u88.segments, u143, u142, u88.jaggedness, u88.offsetScale, u141);

                    if u144 then
                        u144.jaggedOffsets = nil;
                    end;
                else
                    u128 = generateLightningPoints(Random_new_ret, u88.segments, u112, u88.jaggedness, u88.offsetScale);
                end;
            end;

            local function updatePointsBetweenRefreshes(p155: number) -- Line: 674
                -- upvalues: u144 (ref), u128 (ref), updateTransitionPoints (ref), u88 (ref), u112 (copy), u143 (ref), u142 (ref), generateTransitionPoints (ref), Random_new_ret (ref), u141 (ref), u87 (ref)
                if u144 then
                    local v156 = u144;

                    if v156.distanceTraveled < v156.boltLength + v156.transitionBuffer then
                        if u144.jaggedOffsets then
                            u128 = updateTransitionPoints(u88.segments, u112, u143, u142, u144);

                            return;
                        end;

                        local v157, v158 = generateTransitionPoints(Random_new_ret, u88.segments, u112, u143, u142, u88.jaggedness, u88.offsetScale, u141, u144);
                        u128 = v157;
                        u144.jaggedOffsets = v158;

                        return;
                    end;
                end;

                local v159 = u141 * u87.projectileSpeed * p155;

                for i2 = 1, #u128 do
                    u128[i2] = u128[i2] + v159;
                    local _ = i2;
                end;
            end;

            local function updateSegments(p160: number, p161: number?, p162: number, p163: boolean?, p164: number?) -- Line: 708
                -- upvalues: u137 (ref), lengthStart (ref), widthStart (ref), u88 (ref), u129 (ref), refreshPoints (copy), u113 (copy), table_create_ret3 (copy), table_create_ret (copy), transparencyStart (ref), u4 (ref), u130 (ref), u101 (ref), u135 (ref), u103 (ref), u3 (ref), u136 (ref), u138 (ref), u104 (ref), u128 (ref), u117 (ref), u131 (ref), u102 (ref), fillTransparencyStart (ref), u126 (ref), u120 (copy), u112 (copy), u133 (ref), u134 (ref)
                local os_clock_ret = os.clock();
                u137 = p160;
                local v165 = p161 or math.max(0, p160 - lengthStart);
                local v166 = p164 or widthStart;

                if p163 ~= false and u88.refreshRate > 0 then
                    u129 = u129 + p162;

                    if 1 / u88.refreshRate <= u129 then
                        refreshPoints();
                        u129 = 0;
                    end;
                end;

                for i2 = 1, u88.segments do
                    local v167 = u113[i2];
                    local v168 = table_create_ret3[i2];
                    local v169 = table_create_ret[i2];
                    local start = v168.start;
                    local finish = v168.finish;
                    local v170;

                    if v165 < finish then
                        v170 = start < p160;
                    else
                        v170 = false;
                    end;

                    local v171;

                    if v170 then
                        if not v167.wasVisible then
                            v167.wasVisible = true;
                            v167.birthTime = os_clock_ret;
                            v167.initialWidth = widthStart;
                            v167.initialTransparency = transparencyStart;
                        end;

                        v169.Color = u4.getColorWithEasingOklab(u88.colorSequence, u130, u101);
                        local v172;

                        if u88.independentSegments and v167.initialTransparency then
                            v172 = v167.initialTransparency;
                        else
                            v172 = transparencyStart;
                        end;

                        local v173 = u88.fadeInDuration <= 0 and 1 or math.clamp(u135 / u88.fadeInDuration, 0, 1);
                        local v174 = 1 - u103:getEase(v173).y;
                        local v175 = u3.lerp(u88.fadeInStart, v172, v174);
                        local v176;

                        if u136 and u88.fadeOutDuration > 0 then
                            local v177 = 1 - u104:getEase((math.clamp(u138 / u88.fadeOutDuration, 0, 1))).y;
                            v176 = u3.lerp(v172, u88.fadeOutEnd, v177);
                        else
                            v176 = v172;
                        end;

                        if v173 < 1 then
                            v172 = v175;
                        elseif u136 then
                            v172 = v176;
                        end;

                        v169.Transparency = v172;
                        local v178;

                        if p164 then
                            local v179;

                            if u88.independentSegments and v167.initialWidth then
                                v179 = v167.initialWidth;
                            else
                                v179 = widthStart;
                            end;

                            v178 = v179 * (widthStart <= 0 and 0 or p164 / widthStart);
                        elseif u88.independentSegments and v167.initialWidth then
                            v178 = v167.initialWidth;
                        else
                            v178 = v166;
                        end;

                        local v180 = u128[i2];
                        local v181 = u128[i2 + 1];

                        if v180 and v181 then
                            local v182;

                            if start < v165 then
                                v182 = v180:Lerp(v181, (v165 - start) / (finish - start));
                            else
                                v182 = v180;
                            end;

                            if p160 < finish then
                                v181 = v180:Lerp(v181, (p160 - start) / (finish - start));
                            end;

                            local v183 = (v182 + v181) / 2;
                            local Magnitude = (v181 - v182).Magnitude;

                            if Magnitude > 0.001 then
                                v169.Size = Vector3.new(v178, v178, Magnitude);
                                v169.CFrame = CFrame.lookAt(v183, v181);
                                v171 = i2;
                            else
                                v171 = i2;
                            end;
                        else
                            v171 = i2;
                        end;
                    else
                        v169.Transparency = 1;

                        if v167.wasVisible then
                            v167.wasVisible = false;
                            v167.birthTime = nil;
                            v167.initialWidth = nil;
                            v167.initialTransparency = nil;
                            v171 = i2;
                        else
                            v171 = i2;
                        end;
                    end;
                end;

                if u117 then
                    u117.FillColor = u4.getColorWithEasingOklab(u88.fillColorSequence, u131, u102);
                    u117.FillTransparency = fillTransparencyStart;
                end;

                if u126 then
                    local math_ceil_ret = math.ceil(u137 * u88.segments);
                    local math_clamp_ret = math.clamp(math_ceil_ret, 1, u88.segments);

                    if math_clamp_ret ~= u126 then
                        local v184 = table_create_ret[math_clamp_ret];

                        for _, v in u120 do
                            v.Parent = v184;
                        end;

                        u126 = math_clamp_ret;
                    end;
                end;

                local v185 = u112((math.min(p160, 1)));

                if p162 > 0 then
                    u133 = (v185 - u134) / p162;
                end;

                u134 = v185;
            end;

            u4.createPropertyTween(u85, u83, "Width", u107, u88.widthStart, u88.widthEnd, function(p186) -- Line: 868
                -- upvalues: widthStart (ref)
                widthStart = p186;
            end, getEffectiveSpeed, u145);
            u4.createPropertyTween(u85, u83, "Transparency", u107, u88.transparencyStart, u88.transparencyEnd, function(p187) -- Line: 879
                -- upvalues: transparencyStart (ref)
                transparencyStart = p187;
            end, getEffectiveSpeed, u145);
            u4.createPropertyTween(u85, u83, "Length", u107, u88.lengthStart, u88.lengthEnd, function(p188) -- Line: 893
                -- upvalues: lengthStart (ref)
                lengthStart = p188;
            end, getEffectiveSpeed, u145);

            if v115 then
                u4.createPropertyTween(u85, u83, "FillTransparency", u88.fillColorDuration, u88.fillTransparencyStart, u88.fillTransparencyEnd, function(p189) -- Line: 908
                    -- upvalues: fillTransparencyStart (ref)
                    fillTransparencyStart = p189;
                end, getEffectiveSpeed, u145);
            end;

            local function handleDissipation(u190: number, p191: number, p192: number, p193: string, p194: number, u195: string, p196: function) -- Line: 917
                -- upvalues: u136 (ref), u139 (ref), widthStart2 (ref), u2 (ref), u138 (ref), u1 (ref), u83 (ref), speedStart (ref), u135 (ref), u88 (ref), u130 (ref), u131 (ref), u3 (ref), updateSegments (copy), u145 (ref), u85 (ref)
                u136 = true;
                u139 = p191;
                widthStart2 = p192;
                u2.fromParams(p193, p194, function(p197, p198, p199) -- Line: 930
                    -- upvalues: u138 (ref), u1 (ref), u83 (ref), speedStart (ref), u135 (ref), u88 (ref), u130 (ref), u131 (ref), u195 (copy), u3 (ref), u139 (ref), u190 (copy), widthStart2 (ref), updateSegments (ref)
                    u138 = p199;
                    local v200 = p198 * u1.getState(u83, "SpeedOverride", speedStart);
                    u135 = u135 + v200;

                    if u88.refreshDuringDissipate then
                        u130 = (u130 + v200 / u88.colorDuration) % 1;
                        u131 = (u131 + v200 / u88.fillColorDuration) % 1;
                    end;

                    local v201;

                    if u195 == "Retract" then
                        v201 = u3.lerp(u139, u190, p197);
                    else
                        v201 = nil;
                    end;

                    local v202;

                    if u195 == "Scale" then
                        v202 = u3.lerp(widthStart2, 0, p197);
                    else
                        v202 = nil;
                    end;

                    updateSegments(u190, v201, v200, u88.refreshDuringDissipate, v202);
                    local State = u1.getState(u83, "SpeedOverride", speedStart);
                    speedStart = State;

                    if State > 0 then
                        return p198 * State;
                    end;

                    return p198 * State;
                end, u145, p196, true, u3.RENDER_PRIORITY + u85.depth);
            end;

            local function startDissipation() -- Line: 950
                -- upvalues: u136 (ref), u132 (ref), u137 (ref), u119 (copy), u85 (ref), u127 (copy), u109 (copy), u88 (ref), lengthStart (ref), widthStart (ref), u139 (ref), widthStart2 (ref), u2 (ref), u138 (ref), u1 (ref), u83 (ref), speedStart (ref), u135 (ref), u130 (ref), u131 (ref), u3 (ref), updateSegments (copy), u145 (ref)
                if u136 or u132 then
                    return;
                end;

                local u203 = u137;
                local u204;

                if u119 then
                    u204 = u85.effects.emitOnFinish(u119, u127, u85.depth + 1, u85);
                else
                    u204 = nil;
                end;

                local function onDissipationComplete() -- Line: 961
                    -- upvalues: u132 (ref), u204 (copy), u109 (ref)
                    if u132 then
                        return;
                    end;

                    u132 = true;

                    if u204 then
                        u204.Finished:finally(function() -- Line: 969
                            -- upvalues: u109 (ref)
                            u109();
                        end);

                        return;
                    end;

                    u109();
                end;

                if u88.dissipateMode ~= "None" then
                    local math_max_ret = math.max(0, u203 - lengthStart);
                    local dissipateMode = u88.dissipateMode;
                    u136 = true;
                    u139 = math_max_ret;
                    widthStart2 = widthStart;
                    u2.fromParams(u88.dissipateCurveData, u88.dissipateDuration, function(p205, p206, p207) -- Line: 930
                        -- upvalues: u138 (ref), u1 (ref), u83 (ref), speedStart (ref), u135 (ref), u88 (ref), u130 (ref), u131 (ref), dissipateMode (copy), u3 (ref), u139 (ref), u203 (copy), widthStart2 (ref), updateSegments (ref)
                        u138 = p207;
                        local v208 = p206 * u1.getState(u83, "SpeedOverride", speedStart);
                        u135 = u135 + v208;

                        if u88.refreshDuringDissipate then
                            u130 = (u130 + v208 / u88.colorDuration) % 1;
                            u131 = (u131 + v208 / u88.fillColorDuration) % 1;
                        end;

                        local v209;

                        if dissipateMode == "Retract" then
                            v209 = u3.lerp(u139, u203, p205);
                        else
                            v209 = nil;
                        end;

                        local v210;

                        if dissipateMode == "Scale" then
                            v210 = u3.lerp(widthStart2, 0, p205);
                        else
                            v210 = nil;
                        end;

                        updateSegments(u203, v209, v208, u88.refreshDuringDissipate, v210);
                        local State = u1.getState(u83, "SpeedOverride", speedStart);
                        speedStart = State;

                        if State > 0 then
                            return p206 * State;
                        end;

                        return p206 * State;
                    end, u145, onDissipationComplete, true, u3.RENDER_PRIORITY + u85.depth);

                    return;
                end;

                if u88.fadeOutDuration <= 0 then
                    if u132 then
                        return;
                    end;

                    u132 = true;

                    if u204 then
                        u204.Finished:finally(function() -- Line: 969
                            -- upvalues: u109 (ref)
                            u109();
                        end);

                        return;
                    end;

                    u109();

                    return;
                end;

                local math_max_ret = math.max(0, u203 - lengthStart);
                u136 = true;
                u139 = math_max_ret;
                widthStart2 = widthStart;
                local u211 = "None";
                u2.fromParams(u88.fadeOutCurveData, u88.fadeOutDuration, function(p212, p213, p214) -- Line: 930
                    -- upvalues: u138 (ref), u1 (ref), u83 (ref), speedStart (ref), u135 (ref), u88 (ref), u130 (ref), u131 (ref), u211 (copy), u3 (ref), u139 (ref), u203 (copy), widthStart2 (ref), updateSegments (ref)
                    u138 = p214;
                    local v215 = p213 * u1.getState(u83, "SpeedOverride", speedStart);
                    u135 = u135 + v215;

                    if u88.refreshDuringDissipate then
                        u130 = (u130 + v215 / u88.colorDuration) % 1;
                        u131 = (u131 + v215 / u88.fillColorDuration) % 1;
                    end;

                    local v216;

                    if u211 == "Retract" then
                        v216 = u3.lerp(u139, u203, p212);
                    else
                        v216 = nil;
                    end;

                    local v217;

                    if u211 == "Scale" then
                        v217 = u3.lerp(widthStart2, 0, p212);
                    else
                        v217 = nil;
                    end;

                    updateSegments(u203, v216, v215, u88.refreshDuringDissipate, v217);
                    local State = u1.getState(u83, "SpeedOverride", speedStart);
                    speedStart = State;

                    if State > 0 then
                        return p213 * State;
                    end;

                    return p213 * State;
                end, u145, onDissipationComplete, true, u3.RENDER_PRIORITY + u85.depth);
            end;

            local fromParams = u2.fromParams;
            local v218 = u1.get(u83, "Easing_Curve", u3.linear_bezier);
            table.insert(u85, fromParams(v218, u107, function(p219, p220, p221) -- Line: 1008
                -- upvalues: u1 (ref), u83 (ref), speedStart (ref), u135 (ref), u130 (ref), u88 (ref), u131 (ref), u87 (ref), u3 (ref), u96 (ref), u140 (ref), u128 (ref), updateSegments (copy), table_create_ret (copy), u137 (ref), u105 (ref), startDissipation (copy), u145 (ref), u107 (ref), u108 (ref)
                local v222 = p220 * u1.getState(u83, "SpeedOverride", speedStart);
                u135 = u135 + v222;
                u130 = (u130 + v222 / u88.colorDuration) % 1;
                u131 = (u131 + v222 / u88.fillColorDuration) % 1;

                if u87.syncPosition then
                    local TransformedOriginExtents2 = u3.getTransformedOriginExtents(u96);
                    local v223 = TransformedOriginExtents2 * u140:Inverse();

                    for i2 = 1, #u128 do
                        u128[i2] = v223:PointToWorldSpace(u140:PointToObjectSpace(u128[i2]));
                        local _ = i2;
                    end;

                    u140 = TransformedOriginExtents2;
                end;

                updateSegments(p219, nil, v222);
                local v224;

                if u87.hitboxEnabled then
                    local math_ceil_ret = math.ceil(u137 * u88.segments);
                    local v225 = table_create_ret[math.clamp(math_ceil_ret, 1, u88.segments)];
                    v224 = v225 and (v225.Transparency < 1 and workspace:GetPartsInPart(v225, u105)[1]) and true or false;
                else
                    v224 = false;
                end;

                if v224 then
                    startDissipation();

                    return nil;
                end;

                local State = u1.getState(u83, "SpeedOverride", speedStart);
                speedStart = State;
                local v226;

                if State > 0 then
                    v226 = p220 * State;
                else
                    local v227;

                    if u145 then
                        v227 = u145.Connected;
                    else
                        v227 = u1.getState(u83, "SpeedTweening", false);
                    end;

                    if v227 then
                        v226 = p220 * State;
                    else
                        v226 = nil;
                    end;
                end;

                if v226 == nil then
                    return nil;
                end;

                if u87.projectileEnabled and p219 * u107 < u108 or not u87.projectileEnabled then
                    return v226;
                end;

                startDissipation();

                return nil;
            end, u145, function() -- Line: 1048
                -- upvalues: u136 (ref), u132 (ref), u87 (ref), u2 (ref), u3 (ref), u1 (ref), u83 (ref), speedStart (ref), u135 (ref), u130 (ref), u88 (ref), u131 (ref), updateSegments (copy), table_create_ret (copy), u137 (ref), u105 (ref), startDissipation (copy), u145 (ref), u85 (ref), u98 (ref), u133 (ref), u112 (copy), lengthStart (ref), u128 (ref), u144 (ref), u108 (ref), u142 (ref), u143 (ref), u141 (ref), u129 (ref), refreshPoints (copy), updatePointsBetweenRefreshes (copy)
                if u136 or u132 then
                    return;
                end;

                if not u87.projectileEnabled then
                    if u87.destroyDelay > 0 then
                        u2.fromParams(u3.linear_bezier, u87.destroyDelay, function(p228, p229) -- Line: 1059
                            -- upvalues: u1 (ref), u83 (ref), speedStart (ref), u135 (ref), u130 (ref), u88 (ref), u131 (ref), updateSegments (ref), u87 (ref), table_create_ret (ref), u137 (ref), u105 (ref), startDissipation (ref)
                            local v230 = p229 * u1.getState(u83, "SpeedOverride", speedStart);
                            u135 = u135 + v230;
                            u130 = (u130 + v230 / u88.colorDuration) % 1;
                            u131 = (u131 + v230 / u88.fillColorDuration) % 1;
                            updateSegments(1, nil, v230, true);
                            local v231;

                            if u87.hitboxEnabled then
                                local math_ceil_ret = math.ceil(u137 * u88.segments);
                                local v232 = table_create_ret[math.clamp(math_ceil_ret, 1, u88.segments)];
                                v231 = v232 and (v232.Transparency < 1 and workspace:GetPartsInPart(v232, u105)[1]) and true or false;
                            else
                                v231 = false;
                            end;

                            if v231 then
                                startDissipation();

                                return nil;
                            end;

                            local State = u1.getState(u83, "SpeedOverride", speedStart);
                            speedStart = State;

                            if State > 0 then
                                return p229 * State;
                            end;

                            return p229 * State;
                        end, u145, function() -- Line: 1076
                            -- upvalues: startDissipation (ref)
                            startDissipation();
                        end, true, u3.RENDER_PRIORITY + u85.depth);

                        return;
                    end;

                    startDissipation();

                    return;
                end;

                local v233;

                if u87.projectileMatchEnd and u98 then
                    v233 = u98.WorldCFrame.LookVector;
                else
                    v233 = u133.Unit;
                end;

                local u234 = (v233 ~= v233 or v233.Magnitude < 0.001) and Vector3.new(0, 0, 1) or v233.Unit;
                local u235 = u112(1);
                local Magnitude = (u235 - u112((math.max(0, 1 - lengthStart)))).Magnitude;
                local math_max_ret = math.max(0, 1 - lengthStart);
                local v236 = 1 - math_max_ret;
                local table_create_ret4 = table.create(u88.segments + 1);

                for i2 = 0, u88.segments do
                    local v237 = u112(math_max_ret + i2 / u88.segments * v236);
                    table_create_ret4[i2 + 1] = u128[i2 + 1] - v237;
                    local _ = i2;
                end;

                local u238 = {
                    distanceTraveled = 0,
                    curvedTailT = math_max_ret,
                    curvedLengthT = v236,
                    boltLength = Magnitude,
                    transitionBuffer = Magnitude * 0.3,
                    jaggedOffsets = table_create_ret4
                };
                u144 = u238;
                u2.timer(u108, function(p239, p240) -- Line: 1132
                    -- upvalues: u1 (ref), u83 (ref), speedStart (ref), u135 (ref), u130 (ref), u88 (ref), u131 (ref), u87 (ref), u238 (copy), u235 (copy), u234 (ref), Magnitude (copy), u142 (ref), u143 (ref), u141 (ref), u129 (ref), refreshPoints (ref), updatePointsBetweenRefreshes (ref), updateSegments (ref), table_create_ret (ref), u137 (ref), u105 (ref), startDissipation (ref), u108 (ref)
                    local v241 = p239 * u1.getState(u83, "SpeedOverride", speedStart);
                    u135 = u135 + v241;
                    u130 = (u130 + v241 / u88.colorDuration) % 1;
                    u131 = (u131 + v241 / u88.fillColorDuration) % 1;
                    local v242 = p240 * u87.projectileSpeed;
                    u238.distanceTraveled = v242;
                    local v243 = u235 + u234 * v242;
                    u142 = v243;
                    u143 = v243 - u234 * Magnitude;
                    u141 = u234;

                    if u88.refreshRate > 0 then
                        u129 = u129 + v241;

                        if u129 >= 1 / u88.refreshRate then
                            refreshPoints();
                            u129 = 0;
                        else
                            updatePointsBetweenRefreshes(p239);
                        end;
                    else
                        updatePointsBetweenRefreshes(p239);
                    end;

                    updateSegments(1, nil, v241, false);
                    local v244;

                    if u87.hitboxEnabled then
                        local math_ceil_ret = math.ceil(u137 * u88.segments);
                        local v245 = table_create_ret[math.clamp(math_ceil_ret, 1, u88.segments)];
                        v244 = v245 and (v245.Transparency < 1 and workspace:GetPartsInPart(v245, u105)[1]) and true or false;
                    else
                        v244 = false;
                    end;

                    if v244 then
                        startDissipation();

                        return nil;
                    end;

                    if u108 <= p240 then
                        return nil;
                    end;

                    local State = u1.getState(u83, "SpeedOverride", speedStart);
                    speedStart = State;

                    if State > 0 then
                        return p239 * State;
                    end;

                    return p239 * State;
                end, u145, u85, u3.RENDER_PRIORITY + u85.depth);
                startDissipation();
            end, true, u3.RENDER_PRIORITY + u85.depth));
        end));
        local _ = i;
    end;

    u6.all(u106):await();
end;

return v7;