--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Graph
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.Graph
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local function clamp(p1, p2, p3) -- Line: 1
    if p1 < p2 then
        return p2;
    end;

    if p3 < p1 then
        return p3;
    end;

    return p1;
end;

local function lerp(p4, p5, p6) -- Line: 2
    return p4 + (p5 - p4) * p6;
end;

local u11 = {
    GenerateSeed = function(p7: userdata) -- Line: 6, Name: GenerateSeed
        local Keypoints = p7.Keypoints;
        local math_random_ret = math.random();
        local v8 = math.random() >= 0.5;
        local v9 = {};

        for i = 1, #Keypoints do
            local v10;

            if Keypoints[i].Envelope > 0 then
                if v8 then
                    v9[i] = math_random_ret * Keypoints[i].Envelope;
                    v10 = i;
                else
                    v9[i] = -math_random_ret * Keypoints[i].Envelope;
                    v10 = i;
                end;
            else
                v10 = i;
            end;
        end;

        return v9;
    end
};

function u11.GenerateSeeds(p12: userdata, p13: number) -- Line: 23
    -- upvalues: u11 (copy)
    local v14 = {};

    for i = 1, p13 do
        v14[i] = u11.GenerateSeed(p12);
        local _ = i;
    end;

    return v14;
end;

function u11.QueryPointsWithTime(p15: number, p16: userdata, p17: table) -- Line: 31
    local math_clamp_ret = math.clamp(p15, 0, 1);
    local Keypoints = p16.Keypoints;
    local v18 = #Keypoints;

    if v18 == 1 then
        return Keypoints[1].Value + (p17[1] or 0);
    end;

    local v19 = 1;

    while v19 < v18 - 1 do
        local v20 = (v19 + v18) // 2;

        if Keypoints[v20].Time <= math_clamp_ret then
            v19 = v20;
            v20 = v18;
        end;

        v18 = v20;
    end;

    local v21 = Keypoints[v19];
    local v22 = Keypoints[v19 + 1];
    local v23 = v22.Time - v21.Time;
    local v24 = v21.Value + (p17[v19] or 0);

    return v24 + (v22.Value + (p17[v19 + 1] or 0) - v24) * (v23 > 0 and ((math_clamp_ret - v21.Time) / v23 or 0) or 0);
end;

function u11.QueryColorPointWithTime(p25: number, p26: userdata) -- Line: 55
    local Keypoints = p26.Keypoints;
    local v27 = #Keypoints;

    if v27 == 0 then
        return Color3.new(1, 1, 1);
    end;

    if v27 == 1 then
        return Keypoints[1].Value;
    end;

    if p25 <= Keypoints[1].Time then
        return Keypoints[1].Value;
    end;

    local v28 = 1;

    while v28 < v27 - 1 do
        local v29 = (v28 + v27) // 2;

        if Keypoints[v29].Time <= p25 then
            v28 = v29;
            v29 = v27;
        end;

        v27 = v29;
    end;

    local v30 = Keypoints[v28];
    local v31 = Keypoints[v28 + 1];
    local v32 = v31.Time - v30.Time;

    return v30.Value:Lerp(v31.Value, v32 > 0 and ((p25 - v30.Time) / v32 or 0) or 0);
end;

function u11.IsStatic(p33: userdata) -- Line: 76
    if not p33 then
        return true;
    end;

    local Keypoints = p33.Keypoints;

    if #Keypoints <= 1 then
        return true;
    end;

    local Value = Keypoints[1].Value;

    for i = 2, #Keypoints do
        if Keypoints[i].Value ~= Value or Keypoints[i].Envelope ~= 0 then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

function u11.GetStaticValue(p34: userdata, p35: number) -- Line: 88
    if p34 and #p34.Keypoints ~= 0 then
        return p34.Keypoints[1].Value;
    end;

    return p35;
end;

local function _mergeSequenceTimes(p36, p37) -- Line: 97
    local v38 = {};
    local v39 = {};

    for _, v in ipairs({ p36, p37 }) do
        for _, v2 in ipairs(v.Keypoints) do
            if not v38[v2.Time] then
                v38[v2.Time] = true;
                table.insert(v39, v2.Time);
            end;
        end;
    end;

    table.sort(v39);

    return v39;
end;

function u11.BlendGraphWithTime(p40: userdata, p41: userdata, p42: userdata, p43: number) -- Line: 112
    -- upvalues: _mergeSequenceTimes (copy), u11 (copy)
    local v44 = p43 or 1;
    local v45 = _mergeSequenceTimes(p40, p41);
    local v46 = u11.QueryPointsWithTime(v44 < 0 and 0 or (v44 > 1 and 1 or v44), p42, {}) or 1;
    local v47 = {};

    for _, v in ipairs(v45) do
        local v48 = u11.QueryPointsWithTime(v, p40, {}) or p40.Keypoints[#p40.Keypoints].Value;
        local v49 = u11.QueryPointsWithTime(v, p41, {}) or p41.Keypoints[#p41.Keypoints].Value;
        table.insert(v47, NumberSequenceKeypoint.new(v, v48 + (v49 - v48) * v46));
    end;

    return NumberSequence.new(v47);
end;

function u11.BlendColorGraphWithTime(p50: userdata, p51: userdata, p52: userdata, p53: number) -- Line: 126
    -- upvalues: _mergeSequenceTimes (copy), u11 (copy)
    local v54 = p53 or 1;
    local v55 = _mergeSequenceTimes(p50, p51);
    local v56 = u11.QueryPointsWithTime(v54 < 0 and 0 or (v54 > 1 and 1 or v54), p52, {}) or 1;
    local v57 = {};

    for _, v in ipairs(v55) do
        local v58 = u11.QueryColorPointWithTime(v, p50);
        local v59 = u11.QueryColorPointWithTime(v, p51);
        table.insert(v57, ColorSequenceKeypoint.new(v, v58:Lerp(v59, v56)));
    end;

    return ColorSequence.new(v57);
end;

function u11.LerpGraph(p60: userdata, p61: userdata, p62: number) -- Line: 142
    -- upvalues: _mergeSequenceTimes (copy), u11 (copy)
    local v63 = p62 or 0;
    local v64 = v63 < 0 and 0 or (v63 > 1 and 1 or v63);
    local v65 = _mergeSequenceTimes(p60, p61);
    local v66 = {};

    for _, v in ipairs(v65) do
        local v67 = u11.QueryPointsWithTime(v, p60, {});
        local v68 = u11.QueryPointsWithTime(v, p61, {});
        table.insert(v66, NumberSequenceKeypoint.new(v, v67 + (v68 - v67) * v64));
    end;

    return NumberSequence.new(v66);
end;

function u11.LerpColorGraph(p69: userdata, p70: userdata, p71: number) -- Line: 155
    -- upvalues: _mergeSequenceTimes (copy), u11 (copy)
    local v72 = p71 or 0;
    local v73 = v72 < 0 and 0 or (v72 > 1 and 1 or v72);
    local v74 = _mergeSequenceTimes(p69, p70);
    local v75 = {};

    for _, v in ipairs(v74) do
        local v76 = u11.QueryColorPointWithTime(v, p69);
        local v77 = u11.QueryColorPointWithTime(v, p70);
        table.insert(v75, ColorSequenceKeypoint.new(v, v76:Lerp(v77, v73)));
    end;

    return ColorSequence.new(v75);
end;

function u11.PrecomputeMergedTimes(p78: userdata, p79: userdata) -- Line: 169
    -- upvalues: _mergeSequenceTimes (copy)
    return _mergeSequenceTimes(p78, p79);
end;

function u11.PrecomputeMergedColorTimes(p80: userdata, p81: userdata) -- Line: 174
    -- upvalues: _mergeSequenceTimes (copy)
    return _mergeSequenceTimes(p80, p81);
end;

function u11.LerpGraphFast(p82: userdata, p83: userdata, p84: number, p85: table) -- Line: 179
    -- upvalues: u11 (copy)
    local v86 = p84 or 0;
    local v87 = v86 < 0 and 0 or (v86 > 1 and 1 or v86);
    local v88 = {};

    for _, v in ipairs(p85) do
        local v89 = u11.QueryPointsWithTime(v, p82, {});
        local v90 = u11.QueryPointsWithTime(v, p83, {});
        table.insert(v88, NumberSequenceKeypoint.new(v, v89 + (v90 - v89) * v87));
    end;

    return NumberSequence.new(v88);
end;

function u11.LerpColorGraphFast(p91: userdata, p92: userdata, p93: number, p94: table) -- Line: 191
    -- upvalues: u11 (copy)
    local v95 = p93 or 0;
    local v96 = v95 < 0 and 0 or (v95 > 1 and 1 or v95);
    local v97 = {};

    for _, v in ipairs(p94) do
        local v98 = u11.QueryColorPointWithTime(v, p91);
        local v99 = u11.QueryColorPointWithTime(v, p92);
        table.insert(v97, ColorSequenceKeypoint.new(v, v98:Lerp(v99, v96)));
    end;

    return ColorSequence.new(v97);
end;

function u11.CollectGraphStates(p100) -- Line: 204
    local v101 = {};
    local v102 = {};

    if not p100 then
        return v101, v102;
    end;

    for _, child in pairs(p100:GetChildren()) do
        if child:IsA("Configuration") then
            local Attribute = child:GetAttribute("Time");

            if Attribute == nil then
                local v103 = tonumber(string.match(child.Name, "%d+"));
                Attribute = v103 and v103 - 1 or 0;
            end;

            local Attribute2 = child:GetAttribute("Transparency");

            if Attribute2 and typeof(Attribute2) == "NumberSequence" then
                table.insert(v101, {
                    Time = Attribute,
                    Graph = Attribute2
                });
            end;

            local Attribute3 = child:GetAttribute("Color");

            if Attribute3 and typeof(Attribute3) == "ColorSequence" then
                table.insert(v102, {
                    Time = Attribute,
                    Graph = Attribute3
                });
            end;
        end;
    end;

    table.sort(v101, function(p104, p105) -- Line: 225
        return p104.Time < p105.Time;
    end);
    table.sort(v102, function(p106, p107) -- Line: 226
        return p106.Time < p107.Time;
    end);

    for _, v in ipairs({ v101, v102 }) do
        if #v > 1 and v[#v].Time > 1 then
            local Time = v[#v].Time;

            if Time > 0 then
                for _, v2 in ipairs(v) do
                    v2.Time = v2.Time / Time;
                end;
            end;
        end;
    end;

    return v101, v102;
end;

function u11.ScaleSequence(p108, p109) -- Line: 240
    if not p108 or typeof(p108) ~= "NumberSequence" then
        return p108;
    end;

    local Keypoints = p108.Keypoints;
    local math_abs_ret = math.abs(p109);
    local v110 = {};

    for _, v in ipairs(Keypoints) do
        table.insert(v110, NumberSequenceKeypoint.new(v.Time, v.Value * p109, v.Envelope * math_abs_ret));
    end;

    return NumberSequence.new(v110);
end;

return u11;