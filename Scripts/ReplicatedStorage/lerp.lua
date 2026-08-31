--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     lerp
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.mod.lerp
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("./color/Oklab");
local u17 = {
    number = function(p2: number, p3: number, p4: number) -- Line: 7, Name: number
        return p2 + (p3 - p2) * p4;
    end,

    Vector3 = function(p5: vector, p6: vector, p7: number) -- Line: 11, Name: Vector3
        return p5:Lerp(p6, p7);
    end,

    Vector2 = function(p8, p9, p10: number) -- Line: 15, Name: Vector2
        return p8:Lerp(p9, p10);
    end,

    CFrame = function(p11, p12, p13: number) -- Line: 19, Name: CFrame
        return p11:Lerp(p12, p13);
    end,

    UDim2 = function(p14, p15, p16: number) -- Line: 23, Name: UDim2
        return p14:Lerp(p15, p16);
    end
};

function u17.UDim(p18, p19, p20: number) -- Line: 27
    -- upvalues: u17 (copy)
    return UDim.new(u17.number(p18.Scale, p19.Scale, p20), u17.number(p18.Offset, p19.Offset, p20));
end;

function u17.NumberRange(p21, p22, p23: number) -- Line: 35
    -- upvalues: u17 (copy)
    return NumberRange.new(u17.number(p21.Min, p22.Min, p23), u17.number(p21.Max, p22.Max, p23));
end;

function u17.Color3(p24, p25, p26: number) -- Line: 43
    -- upvalues: u1 (copy)
    return u1.toSRGB(u1.fromSRGB(p24):Lerp(u1.fromSRGB(p25), p26));
end;

function u17.PhysicalProperties(p27: userdata, p28: userdata, p29: number) -- Line: 50
    -- upvalues: u17 (copy)
    return PhysicalProperties.new(u17.number(p27.Density, p28.Density, p29), u17.number(p27.Friction, p28.Friction, p29), u17.number(p27.Elasticity, p28.Elasticity, p29), u17.number(p27.FrictionWeight, p28.FrictionWeight, p29), u17.number(p27.ElasticityWeight, p28.ElasticityWeight, p29));
end;

function u17.Rect(p30, p31, p32: number) -- Line: 60
    return Rect.new(p30.Min:Lerp(p31.Min, p32), p30.Max:Lerp(p31.Max, p32));
end;

function u17.NumberSequence(p33: userdata, p34: userdata, p35: number) -- Line: 65
    local v36 = {};
    local v37 = {};
    local v38 = 0;

    for _, v in p33.Keypoints do
        local v39 = v;
        local v40 = nil;
        local v41 = nil;

        for _, v2 in p34.Keypoints do
            if v2.Time == v39.Time then
                v40 = v2;
                v41 = v40;
                local v42 = v40;
                v40 = v41;
                v42 = v41;
                break;
            end;

            if v2.Time < v39.Time and (v40 == nil or v2.Time > v40.Time) then
                v40 = v2;
            elseif v2.Time > v39.Time and (v41 == nil or v2.Time < v41.Time) then
                v41 = v2;
            end;
        end;

        local v43, v44;

        if v41 == v40 then
            v43 = v41.Value;
            v44 = v41.Envelope;
        else
            local v45 = (v39.Time - v40.Time) / (v41.Time - v40.Time);
            v43 = (v41.Value - v40.Value) * v45 + v40.Value;
            v44 = (v41.Envelope - v40.Envelope) * v45 + v40.Envelope;
        end;

        v38 = v38 + 1;
        v36[v38] = NumberSequenceKeypoint.new(v39.Time, (v43 - v39.Value) * p35 + v39.Value, (v44 - v39.Envelope) * p35 + v39.Envelope);
        v37[v39.Time] = true;
    end;

    for _, v in p34.Keypoints do
        if not v37[v.Time] then
            local v46 = v;
            local v47 = nil;
            local v48 = nil;

            for _, v2 in p33.Keypoints do
                if v2.Time == v46.Time then
                    v47 = v2;
                    v48 = v47;
                    local v49 = v47;
                    v47 = v48;
                    v49 = v48;
                    break;
                end;

                if v2.Time < v46.Time and (v47 == nil or v2.Time > v47.Time) then
                    v47 = v2;
                elseif v2.Time > v46.Time and (v48 == nil or v2.Time < v48.Time) then
                    v48 = v2;
                end;
            end;

            local v50, v51;

            if v48 == v47 then
                v50 = v48.Value;
                v51 = v48.Envelope;
            else
                local v52 = (v46.Time - v47.Time) / (v48.Time - v47.Time);
                v50 = (v48.Value - v47.Value) * v52 + v47.Value;
                v51 = (v48.Envelope - v47.Envelope) * v52 + v47.Envelope;
            end;

            v38 = v38 + 1;
            v36[v38] = NumberSequenceKeypoint.new(v46.Time, (v46.Value - v50) * p35 + v50, (v46.Envelope - v51) * p35 + v51);
        end;
    end;

    table.sort(v36, function(p53, p54) -- Line: 136
        return p53.Time < p54.Time;
    end);
    local v55;

    if #v36 > 20 then
        local v56 = (#v36 - 1) / 19;
        v55 = {};

        for i = 0, 19 do
            local v57 = v36[math.floor(i * v56 + 1)];
            table.insert(v55, v57);
            local _ = i;
        end;

        if v55[#v55].Time < v36[#v36].Time then
            v55[#v55] = v36[#v36];
        end;
    else
        v55 = v36;
    end;

    return NumberSequence.new(v55);
end;

local function getColorAtTime(p58: userdata, p59: number) -- Line: 161
    local Keypoints = p58.Keypoints;

    if p59 <= Keypoints[1].Time then
        return Keypoints[1].Value;
    end;

    if Keypoints[#Keypoints].Time <= p59 then
        return Keypoints[#Keypoints].Value;
    end;

    local v60 = nil;
    local v61 = nil;

    for i = 1, #Keypoints do
        local v62 = Keypoints[i];

        if v62.Time == p59 then
            return v62.Value;
        end;

        local v63;

        if v62.Time < p59 then
            v60 = v62;
            v63 = i;
        else
            if p59 < v62.Time then
                v61 = v62;
                break;
            end;

            v63 = i;
        end;
    end;

    return v60.Value:Lerp(v61.Value, (p59 - v60.Time) / (v61.Time - v60.Time));
end;

function u17.ColorSequence(p64: userdata, p65: userdata, p66: number) -- Line: 192
    -- upvalues: getColorAtTime (copy), u1 (copy)
    local v67 = {};

    for _, v in ipairs(p65.Keypoints) do
        local v68 = getColorAtTime(p64, v.Time);
        local v69 = u1.toSRGB(u1.fromSRGB(v68:Lerp(v.Value, p66)));
        table.insert(v67, ColorSequenceKeypoint.new(v.Time, v69));
    end;

    return ColorSequence.new(v67);
end;

function u17.Other(p70: any, p71: any, p72: number) -- Line: 206
    if p72 < 0.5 then
        p71 = p70 or p71;
    end;

    return p71;
end;

return u17;