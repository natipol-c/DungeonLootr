--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Bezier
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.obj.Bezier
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local function cubicBezier(p1, p2, p3, p4, p5) -- Line: 11
    return (1 - p5) ^ 3 * p1 + 3 * (1 - p5) ^ 2 * p5 * p2 + 3 * (1 - p5) * p5 ^ 2 * p3 + p5 ^ 3 * p4;
end;

local function cubicBezierDerivative(p6, p7, p8, p9, p10) -- Line: 16
    return 3 * (1 - p10) ^ 2 * (p7 - p6) + 6 * (1 - p10) * p10 * (p8 - p7) + 3 * p10 ^ 2 * (p9 - p8);
end;

local u11 = {};
u11.__index = u11;

function u11.new(p12: table, p13: number?) -- Line: 34
    -- upvalues: u11 (copy)
    local v14 = setmetatable({}, u11);
    v14.points = p12;
    v14.accuracy = p13 or 20;
    v14.point_count = 0;
    v14.cumulative_lengths = {};
    v14:_recalculate();

    return v14;
end;

function u11.setPoints(p15: any, p16: table) -- Line: 48
    p15.points = p16;
    p15.ease_lut = nil;
    p15:_recalculate();
end;

function u11.getSegmentPoints(p17: any, p18: number) -- Line: 55
    if p18 < 1 or p17.point_count - 1 < p18 then
        if p18 <= 0 then
            return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0);
        end;

        error("attempt to get a non-existent segment at index " .. p18);
    end;

    local v19 = (p18 - 1) * 4 - math.max(p18 - 2, 0);
    local math_max_ret = math.max(v19, 1);

    return p17.points[math_max_ret], p17.points[math_max_ret + 1], p17.points[math_max_ret + 2], p17.points[math_max_ret + 3];
end;

function u11.forSample(p20: any, p21: number, p22: function) -- Line: 75
    local v23 = p20.length // p21;

    if v23 == 0 then
        return;
    end;

    for i = 0, v23 do
        p22(p20:getPositionArcSpace(i / v23), i);
        local _ = i;
    end;
end;

function u11.getPosition(p24: any, p25: number) -- Line: 88
    local SegmentIndex, v26 = p24:getSegmentIndex(p25);
    local SegmentPoints, v27, v28, v29 = p24:getSegmentPoints(SegmentIndex);

    return (1 - v26) ^ 3 * SegmentPoints + 3 * (1 - v26) ^ 2 * v26 * v27 + 3 * (1 - v26) * v26 ^ 2 * v28 + v26 ^ 3 * v29;
end;

function u11.getSegmentIndex(p30: any, p31: number) -- Line: 95
    local math_clamp_ret = math.clamp(p31, 0, 1);
    local v32 = p30.point_count - 1;
    local v33 = math_clamp_ret * v32;
    local v34 = math.floor(v33) + 1;
    local math_min_ret = math.min(v34, v32);
    local v35 = v33 - math.floor(v33);

    return math_min_ret, math_clamp_ret == 1 and 1 or v35;
end;

function u11.getEasedSegmentIndex(p36: any, p37: number) -- Line: 112
    local v38 = p36.point_count - 1;

    for i = 1, v38 do
        local SegmentPoints, _, _, v39 = p36:getSegmentPoints(i);
        local x = SegmentPoints.x;
        local x2 = v39.x;

        if x <= p37 and p37 < x2 then
            return i, (p37 - x) / (x2 - x);
        end;

        local _ = i;
    end;

    return v38, 1;
end;

function u11._getEaseRaw(p40: any, p41: number) -- Line: 133
    local EasedSegmentIndex, v42 = p40:getEasedSegmentIndex(p41);
    local SegmentPoints, v43, v44, v45 = p40:getSegmentPoints(EasedSegmentIndex);

    for i = 1, 5 do
        local x = v43.x;
        local x2 = v44.x;
        local v46 = 3 * (1 - v42) ^ 2 * (x - SegmentPoints.x) + 6 * (1 - v42) * v42 * (x2 - x) + 3 * v42 ^ 2 * (v45.x - x2);

        if v46 == 0 then
            break;
        end;

        local v47 = ((1 - v42) ^ 3 * SegmentPoints.x + 3 * (1 - v42) ^ 2 * v42 * v43.x + 3 * (1 - v42) * v42 ^ 2 * v44.x + v42 ^ 3 * v45.x - p41) / v46;
        local v48 = v42 - v47;
        v42 = v48 < 0 and 0 or (v48 > 1 and 1 or v48);

        if math.abs(v47) < 0.001 then
            break;
        end;

        local _ = i;
    end;

    return (1 - v42) ^ 3 * SegmentPoints + 3 * (1 - v42) ^ 2 * v42 * v43 + 3 * (1 - v42) * v42 ^ 2 * v44 + v42 ^ 3 * v45;
end;

function u11._buildEaseLUT(p49) -- Line: 162
    local table_create_ret = table.create(65);

    for i = 0, 64 do
        table_create_ret[i] = p49:_getEaseRaw(i / 64);
        local _ = i;
    end;

    p49.ease_lut = table_create_ret;
end;

function u11.getEase(p50: any, p51: number) -- Line: 173
    local ease_lut = p50.ease_lut;

    if not ease_lut then
        p50:_buildEaseLUT();
        ease_lut = p50.ease_lut;
    end;

    local math_clamp_ret = math.clamp(p51, 0, 1);
    local v52 = math_clamp_ret * 64;
    local math_floor_ret = math.floor(v52);
    local math_min_ret = math.min(math_floor_ret + 1, 64);
    local v53 = v52 - math_floor_ret;
    local v54 = ease_lut[math_floor_ret];
    local v55 = ease_lut[math_min_ret];

    if v54 and v55 then
        return v54:Lerp(v55, v53);
    end;

    return p50:_getEaseRaw(math_clamp_ret);
end;

function u11.getPositionArcSpace(p56: any, p57: number) -- Line: 200
    if p56.length <= 0 then
        return p56.points[1] or Vector3.new(0, 0, 0);
    end;

    local v58 = math.clamp(p57, 0, 1) * p56.cumulative_lengths[p56.accuracy + 1];
    local v59 = p56.accuracy + 1;
    local v60 = 1;
    local v61 = nil;

    while v60 < v59 do
        v61 = v60 + (v59 - v60) // 2;

        if p56.cumulative_lengths[v61] < v58 then
            v60 = v61 + 1;
        else
            v59 = v61;
        end;
    end;

    if v58 < p56.cumulative_lengths[v61] and v61 > 1 then
        v61 = v61 - 1;
    end;

    local v62 = p56.cumulative_lengths[v61];

    if v62 == v58 then
        return p56:getPosition((v61 - 1) / p56.accuracy);
    end;

    return p56:getPosition((v61 - 1 + (v58 - v62) / (p56.cumulative_lengths[v61 + 1] - v62)) / p56.accuracy);
end;

function u11._recalculate(p63) -- Line: 236
    table.clear(p63.cumulative_lengths);
    table.insert(p63.cumulative_lengths, 0);
    p63.point_count = math.ceil(#p63.points / 3);
    local v64 = nil;
    local v65 = 0;

    for i = 1, p63.accuracy do
        local Position = p63:getPosition(i / p63.accuracy);
        local v66 = v64 or p63:getPosition(0);
        v65 = v65 + vector.magnitude(Position - v66);
        table.insert(p63.cumulative_lengths, v65);
        v64 = Position;
        local _ = i;
    end;

    p63.length = v65;

    for i, v in p63.cumulative_lengths do
        p63.cumulative_lengths[i] = v / v65;
    end;
end;

return u11;