--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     spr
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.spr
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local math_exp = math.exp;
local math_sin = math.sin;
local math_cos = math.cos;
local math_min = math.min;
local math_max = math.max;
local math_sqrt = math.sqrt;
local math_atan2 = math.atan2;
local math_round = math.round;

local function magnitudeSq(p1: table) -- Line: 53
    local v2 = 0;

    for _, v in p1 do
        v2 = v2 + v ^ 2;
    end;

    return v2;
end;

local function distanceSq(p3: table, p4: table) -- Line: 61
    local v5 = 0;

    for i, v in p3 do
        v5 = v5 + (p4[i] - v) ^ 2;
    end;

    return v5;
end;

local u6 = {};
u6.__index = u6;

function u6.new(p7: number, p8: number, p9: any, p10: any, p11: any) -- Line: 100
    -- upvalues: u6 (copy)
    local v12 = p11.toIntermediate(p9);
    local v13 = {
        d = p7,
        f = p8,
        g = v12,
        p = v12,
        v = table.create(#v12, 0),
        typedat = p11,
        rawGoal = p10
    };

    return setmetatable(v13, u6);
end;

function u6.setGoal(p14, p15) -- Line: 113
    p14.rawGoal = p15;
    p14.g = p14.typedat.toIntermediate(p15);
end;

function u6.setDampingRatio(p16: any, p17: number) -- Line: 118
    p16.d = p17;
end;

function u6.setFrequency(p18: any, p19: number) -- Line: 122
    p18.f = p19;
end;

function u6.canSleep(p20) -- Line: 126
    local v21 = 0;

    for _, v in p20.v do
        v21 = v21 + v ^ 2;
    end;

    if v21 > 0.0001 then
        return false;
    end;

    local g = p20.g;
    local v22 = 0;

    for i, v in p20.p do
        v22 = v22 + (g[i] - v) ^ 2;
    end;

    return v22 <= 6.781684027777778e-8;
end;

function u6.step(p23: any, p24: number) -- Line: 138
    -- upvalues: math_exp (copy), math_sqrt (copy), math_cos (copy), math_sin (copy)
    local d = p23.d;
    local v25 = p23.f * 6.283185307179586;
    local g = p23.g;
    local p = p23.p;
    local v = p23.v;

    if d == 1 then
        local v26 = math_exp(-v25 * p24);
        local v27 = p24 * v26;
        local v28 = v26 + v27 * v25;
        local v29 = v26 - v27 * v25;
        local v30 = v27 * v25 * v25;

        for i = 1, #p do
            local v31 = p[i] - g[i];
            p[i] = v31 * v28 + v[i] * v27 + g[i];
            v[i] = v[i] * v29 - v31 * v30;
            local _ = i;
        end;
    elseif d < 1 then
        local v32 = math_exp(-d * v25 * p24);
        local v33 = math_sqrt(1 - d * d);
        local v34 = math_cos(p24 * v25 * v33);
        local v35 = math_sin(p24 * v25 * v33);
        local v36;

        if v33 > 0.00001 then
            v36 = v35 / v33;
        else
            local v37 = p24 * v25;
            v36 = v37 + (v37 * v37 * (v33 * v33) * (v33 * v33) / 20 - v33 * v33) * (v37 * v37 * v37) / 6;
        end;

        local v38;

        if v25 * v33 > 0.00001 then
            v38 = v35 / (v25 * v33);
        else
            local v39 = v25 * v33;
            v38 = p24 + (p24 * p24 * (v39 * v39) * (v39 * v39) / 20 - v39 * v39) * (p24 * p24 * p24) / 6;
        end;

        for i = 1, #p do
            local v40 = p[i] - g[i];
            p[i] = (v40 * (v34 + v36 * d) + v[i] * v38) * v32 + g[i];
            v[i] = (v[i] * (v34 - v36 * d) - v40 * (v36 * v25)) * v32;
            local _ = i;
        end;
    else
        local v41 = math_sqrt(d * d - 1);
        local v42 = -v25 * (d + v41);
        local v43 = -v25 * (d - v41);
        local v44 = math_exp(v42 * p24);
        local v45 = math_exp(v43 * p24);

        for i = 1, #p do
            local v46 = p[i] - g[i];
            local v47 = (v[i] - v46 * v42) / (2 * v25 * v41);
            local v48 = v44 * (v46 - v47);
            p[i] = v48 + v47 * v45 + g[i];
            v[i] = v48 * v42 + v47 * v45 * v43;
            local _ = i;
        end;
    end;

    return p23.typedat.fromIntermediate(p23.p);
end;

local u49 = {};
u49.__index = u49;

function u49.new(p50: number, p51: number, p52, p53) -- Line: 255
    -- upvalues: u49 (copy)
    local v54 = {
        v = Vector3.new(0, 0, 0),
        d = p50,
        f = p51,
        g = p53:Orthonormalize(),
        p = p52:Orthonormalize()
    };

    return setmetatable(v54, u49);
end;

function u49.setGoal(p55: any, p56) -- Line: 265
    p55.g = p56:Orthonormalize();
end;

function u49.setDampingRatio(p57: any, p58: number) -- Line: 269
    p57.d = p58;
end;

function u49.setFrequency(p59: any, p60: number) -- Line: 273
    p59.f = p60;
end;

local function dot(p61: vector, p62: vector) -- Line: 278
    return p61.X * p62.X + p61.Y * p62.Y + p61.Z * p62.Z;
end;

local function areRotationsClose(p63, p64) -- Line: 282
    local XVector = p63.XVector;
    local XVector2 = p64.XVector;
    local YVector = p63.YVector;
    local YVector2 = p64.YVector;
    local ZVector = p63.ZVector;
    local ZVector2 = p64.ZVector;

    return XVector.X * XVector2.X + XVector.Y * XVector2.Y + XVector.Z * XVector2.Z + (YVector.X * YVector2.X + YVector.Y * YVector2.Y + YVector.Z * YVector2.Z) + (ZVector.X * ZVector2.X + ZVector.Y * ZVector2.Y + ZVector.Z * ZVector2.Z) > 2.9999999695382584;
end;

local function angleDiff(p65, p66) -- Line: 290
    -- upvalues: math_max (copy), math_sqrt (copy), math_atan2 (copy)
    local XVector = p65.XVector;
    local XVector2 = p66.XVector;
    local YVector = p65.YVector;
    local YVector2 = p66.YVector;
    local ZVector = p65.ZVector;
    local ZVector2 = p66.ZVector;
    local v67 = XVector.X * XVector2.X + XVector.Y * XVector2.Y + XVector.Z * XVector2.Z + (YVector.X * YVector2.X + YVector.Y * YVector2.Y + YVector.Z * YVector2.Z) + (ZVector.X * ZVector2.X + ZVector.Y * ZVector2.Y + ZVector.Z * ZVector2.Z) - 1;

    return math_atan2(math_sqrt((math_max(0, 1 - v67 * v67 * 0.25))), v67 * 0.5);
end;

local function fromAxisAngle(p68: vector, p69: number) -- Line: 299
    -- upvalues: math_cos (copy), math_sin (copy)
    local v70 = math_cos(p69);
    local v71 = math_sin(p69);
    local X = p68.X;
    local Y = p68.Y;
    local Z = p68.Z;
    local v72 = X * Y * (1 - v70);
    local v73 = Y * Z * (1 - v70);
    local v74 = Z * X * (1 - v70);
    local Vector3_new_ret = Vector3.new(X * X * (1 - v70) + v70, v72 + Z * v71, v74 - Y * v71);
    local Vector3_new_ret2 = Vector3.new(v72 - Z * v71, Y * Y * (1 - v70) + v70, v73 + X * v71);
    local Vector3_new_ret3 = Vector3.new(v74 + Y * v71, v73 - X * v71, Z * Z * (1 - v70) + v70);

    return CFrame.fromMatrix(Vector3.new(0, 0, 0), Vector3_new_ret, Vector3_new_ret2, Vector3_new_ret3):Orthonormalize();
end;

local function rotateAxis(p75: vector, p76) -- Line: 315
    -- upvalues: fromAxisAngle (copy)
    local CFrame_identity = CFrame.identity;
    local Magnitude = p75.Magnitude;

    if Magnitude > 1e-6 then
        CFrame_identity = fromAxisAngle(p75.Unit, Magnitude);
    end;

    return CFrame_identity * p76;
end;

local function axisAngleDiff(p77, p78) -- Line: 325
    -- upvalues: angleDiff (copy)
    local v79 = (p77 * p78:Inverse()):ToAxisAngle();
    local v80 = angleDiff(p77, p78);

    return v79.Unit * v80;
end;

function u49.canSleep(p81) -- Line: 334
    local p = p81.p;
    local g = p81.g;
    local XVector = p.XVector;
    local XVector2 = g.XVector;
    local YVector = p.YVector;
    local YVector2 = g.YVector;
    local ZVector = p.ZVector;
    local ZVector2 = g.ZVector;

    return XVector.X * XVector2.X + XVector.Y * XVector2.Y + XVector.Z * XVector2.Z + (YVector.X * YVector2.X + YVector.Y * YVector2.Y + YVector.Z * YVector2.Z) + (ZVector.X * ZVector2.X + ZVector.Y * ZVector2.Y + ZVector.Z * ZVector2.Z) > 2.9999999695382584 and p81.v.Magnitude < 0.0017453292519943296;
end;

function u49.step(p82: any, p83: number) -- Line: 340
    -- upvalues: angleDiff (copy), math_exp (copy), fromAxisAngle (copy), math_sqrt (copy), math_cos (copy), math_sin (copy)
    local d = p82.d;
    local v84 = p82.f * 6.283185307179586;
    local g = p82.g;
    local p = p82.p;
    local v = p82.v;
    local v85 = (p * g:Inverse()):ToAxisAngle();
    local v86 = angleDiff(p, g);
    local v87 = v85.Unit * v86;
    local v88 = math_exp(-d * v84 * p83);
    local v89, v90;

    if d == 1 then
        local v91 = (v87 * (1 + v84 * p83) + v * p83) * v88;
        local CFrame_identity = CFrame.identity;
        local Magnitude = v91.Magnitude;

        if Magnitude > 1e-6 then
            CFrame_identity = fromAxisAngle(v91.Unit, Magnitude);
        end;

        v89 = CFrame_identity * g;
        v90 = (v * (1 - p83 * v84) - v87 * (p83 * v84 * v84)) * v88;
    elseif d < 1 then
        local v92 = math_sqrt(1 - d * d);
        local v93 = math_cos(p83 * v84 * v92);
        local v94 = math_sin(p83 * v84 * v92);
        local v95 = v94 / v92;
        local v96 = (v87 * (v93 + v95 * d) + v * (v94 / (v84 * v92))) * v88;
        local CFrame_identity = CFrame.identity;
        local Magnitude = v96.Magnitude;

        if Magnitude > 1e-6 then
            CFrame_identity = fromAxisAngle(v96.Unit, Magnitude);
        end;

        v89 = CFrame_identity * g;
        v90 = (v * (v93 - v95 * d) - v87 * (v95 * v84)) * v88;
    else
        local v97 = math_sqrt(d * d - 1);
        local v98 = -v84 * (d + v97);
        local v99 = -v84 * (d - v97);
        local v100 = (v - v87 * v98) / (2 * v84 * v97);
        local v101 = (v87 - v100) * math_exp(v98 * p83);
        local v102 = v100 * math_exp(v99 * p83);
        local v103 = v101 + v102;
        local CFrame_identity = CFrame.identity;
        local Magnitude = v103.Magnitude;

        if Magnitude > 1e-6 then
            CFrame_identity = fromAxisAngle(v103.Unit, Magnitude);
        end;

        v89 = CFrame_identity * g;
        v90 = v101 * v98 + v102 * v99;
    end;

    p82.p = v89;
    p82.v = v90;

    return v89;
end;

local u106 = {
    springType = u6.new,

    toIntermediate = function(p104) -- Line: 394, Name: toIntermediate
        return { p104.X, p104.Y, p104.Z };
    end,

    fromIntermediate = function(p105: table) -- Line: 398, Name: fromIntermediate
        return Vector3.new(p105[1], p105[2], p105[3]);
    end
};
local u107 = {};
u107.__index = u107;

function u107.new(p108: number, p109: number, p110, p111, p112: any) -- Line: 408
    -- upvalues: u6 (copy), u106 (copy), u49 (copy), u107 (copy)
    local v113 = {
        rawGoal = p111,
        _position = u6.new(p108, p109, p110.Position, p111.Position, u106),
        _rotation = u49.new(p108, p109, p110.Rotation, p111.Rotation)
    };

    return setmetatable(v113, u107);
end;

function u107.setGoal(p114: table, p115) -- Line: 422
    p114.rawGoal = p115;
    p114._position:setGoal(p115.Position);
    p114._rotation:setGoal(p115.Rotation);
end;

function u107.setDampingRatio(p116: table, p117: number) -- Line: 428
    p116._position.d = p117;
    p116._rotation.d = p117;
end;

function u107.setFrequency(p118: table, p119: number) -- Line: 433
    p118._position.f = p119;
    p118._rotation.f = p119;
end;

function u107.canSleep(p120) -- Line: 438
    local v121 = p120._position:canSleep() and p120._rotation:canSleep();

    return v121;
end;

function u107.step(p122, p123) -- Line: 442
    local v124 = p122._position:step(p123);

    return p122._rotation:step(p123) + v124;
end;

local function inverseGammaCorrectD65(p125) -- Line: 453
    return p125 < 0.0404482362771076 and p125 / 12.92 or 0.87941546140213 * (p125 + 0.055) ^ 2.4;
end;

local function gammaCorrectD65(p126) -- Line: 457
    return p126 < 0.0031306684425 and 12.92 * p126 or 1.055 * p126 ^ 0.4166666666666667 - 0.055;
end;

local function rgbToLuv(p127) -- Line: 461
    local R = p127.R;
    local G = p127.G;
    local B = p127.B;
    local v128 = R < 0.0404482362771076 and R / 12.92 or 0.87941546140213 * (R + 0.055) ^ 2.4;
    local v129 = G < 0.0404482362771076 and G / 12.92 or 0.87941546140213 * (G + 0.055) ^ 2.4;
    local v130 = B < 0.0404482362771076 and B / 12.92 or 0.87941546140213 * (B + 0.055) ^ 2.4;
    local v131 = 0.9257063972951867 * v128 - 0.8333736323779866 * v129 - 0.09209820666085898 * v130;
    local v132 = 0.2125862307855956 * v128 + 0.7151703037034108 * v129 + 0.0722004986433362 * v130;
    local v133 = 3.6590806972265884 * v128 + 11.442689580057424 * v129 + 4.114991502426484 * v130;
    local v134 = v132 > 0.008856451679035631 and 116 * v132 ^ 0.3333333333333333 - 16 or 903.296296296296 * v132;
    local v135, v136;

    if v133 > 1e-14 then
        v135 = v134 * v131 / v133;
        v136 = v134 * (9 * v132 / v133 - 0.46832);
    else
        v135 = -0.19783 * v134;
        v136 = -0.46832 * v134;
    end;

    return { v134, v135, v136 };
end;

local function luvToRgb(p137: table) -- Line: 490
    -- upvalues: math_min (copy)
    local v138 = p137[1];

    if v138 < 0.0197955 then
        return Color3.new(0, 0, 0);
    end;

    local v139 = p137[2] / v138 + 0.19783;
    local v140 = p137[3] / v138 + 0.46832;
    local v141 = (v138 + 16) / 116;
    local v142 = v141 > 0.20689655172413793 and v141 * v141 * v141 or v141 * 0.12841854934601665 - 0.01771290335807126;
    local v143 = v142 * v139 / v140;
    local v144 = v142 * ((3 - v139 * 0.75) / v140 - 5);
    local v145 = v143 * 7.2914074 - v142 * 1.537208 - v144 * 0.4986286;
    local v146 = v143 * -2.180094 + v142 * 1.8757561 + v144 * 0.0415175;
    local v147 = v143 * 0.1253477 - v142 * 0.2040211 + v144 * 1.0569959;

    if v145 < 0 and (v145 < v146 and v145 < v147) then
        v146 = v146 - v145;
        v147 = v147 - v145;
        v145 = 0;
    elseif v146 < 0 and v146 < v147 then
        v145 = v145 - v146;
        v147 = v147 - v146;
        v146 = 0;
    elseif v147 < 0 then
        v145 = v145 - v147;
        v146 = v146 - v147;
        v147 = 0;
    end;

    return Color3.new(math_min(v145 < 0.0031306684425 and 12.92 * v145 or 1.055 * v145 ^ 0.4166666666666667 - 0.055, 1), math_min(v146 < 0.0031306684425 and 12.92 * v146 or 1.055 * v146 ^ 0.4166666666666667 - 0.055, 1), (math_min(v147 < 0.0031306684425 and 12.92 * v147 or 1.055 * v147 ^ 0.4166666666666667 - 0.055, 1)));
end;

local u164 = {
    boolean = {
        springType = u6.new,

        toIntermediate = function(p148) -- Line: 532, Name: toIntermediate
            return { p148 and 1 or 0 };
        end,

        fromIntermediate = function(p149) -- Line: 536, Name: fromIntermediate
            return p149[1] >= 0.5;
        end
    },
    number = {
        springType = u6.new,

        toIntermediate = function(p150) -- Line: 544, Name: toIntermediate
            return { p150 };
        end,

        fromIntermediate = function(p151) -- Line: 548, Name: fromIntermediate
            return p151[1];
        end
    },
    NumberRange = {
        springType = u6.new,

        toIntermediate = function(p152) -- Line: 556, Name: toIntermediate
            return { p152.Min, p152.Max };
        end,

        fromIntermediate = function(p153) -- Line: 560, Name: fromIntermediate
            return NumberRange.new(p153[1], p153[2]);
        end
    },
    UDim = {
        springType = u6.new,

        toIntermediate = function(p154) -- Line: 568, Name: toIntermediate
            return { p154.Scale, p154.Offset };
        end,

        fromIntermediate = function(p155: table) -- Line: 572, Name: fromIntermediate
            -- upvalues: math_round (copy)
            return UDim.new(p155[1], (math_round(p155[2])));
        end
    },
    UDim2 = {
        springType = u6.new,

        toIntermediate = function(p156) -- Line: 580, Name: toIntermediate
            local X = p156.X;
            local Y = p156.Y;

            return {
                X.Scale,
                X.Offset,
                Y.Scale,
                Y.Offset
            };
        end,

        fromIntermediate = function(p157: table) -- Line: 586, Name: fromIntermediate
            -- upvalues: math_round (copy)
            return UDim2.new(p157[1], math_round(p157[2]), p157[3], (math_round(p157[4])));
        end
    },
    Vector2 = {
        springType = u6.new,

        toIntermediate = function(p158) -- Line: 594, Name: toIntermediate
            return { p158.X, p158.Y };
        end,

        fromIntermediate = function(p159: table) -- Line: 598, Name: fromIntermediate
            return Vector2.new(p159[1], p159[2]);
        end
    },
    Vector3 = u106,
    Color3 = {
        springType = u6.new,
        toIntermediate = rgbToLuv,
        fromIntermediate = luvToRgb
    },
    ColorSequence = {
        springType = u6.new,

        toIntermediate = function(p160) -- Line: 615, Name: toIntermediate
            -- upvalues: rgbToLuv (ref)
            local Keypoints = p160.Keypoints;
            local v161 = rgbToLuv(Keypoints[1].Value);
            local v162 = rgbToLuv(Keypoints[#Keypoints].Value);

            return {
                v161[1],
                v161[2],
                v161[3],
                v162[1],
                v162[2],
                v162[3]
            };
        end,

        fromIntermediate = function(p163: table) -- Line: 631, Name: fromIntermediate
            -- upvalues: luvToRgb (ref)
            return ColorSequence.new(luvToRgb({ p163[1], p163[2], p163[3] }), luvToRgb({ p163[4], p163[5], p163[6] }));
        end
    },
    CFrame = {
        springType = u107.new,
        toIntermediate = error,
        fromIntermediate = error
    }
};
local u171 = {
    Pivot = {
        class = "PVInstance",

        get = function(p165: userdata) -- Line: 657, Name: get
            return p165:GetPivot();
        end,

        set = function(p166: userdata, p167) -- Line: 660, Name: set
            p166:PivotTo(p167);
        end
    },
    Scale = {
        class = "Model",

        get = function(p168: userdata) -- Line: 666, Name: get
            return p168:GetScale();
        end,

        set = function(p169: userdata, p170: number) -- Line: 669, Name: set
            p169:ScaleTo((math.clamp(p170, 1.402e-45, 16777216)));
        end
    }
};

local function getProperty(p172: userdata, p173: string) -- Line: 678
    -- upvalues: u171 (copy)
    local v174 = u171[p173];

    if v174 and p172:IsA(v174.class) then
        return v174.get(p172);
    end;

    return p172[p173];
end;

local function setProperty(p175: userdata, p176: string, p177: any) -- Line: 687
    -- upvalues: u171 (copy)
    local v178 = u171[p176];

    if v178 and p175:IsA(v178.class) then
        v178.set(p175, p177);

        return;
    end;

    p175[p176] = p177;
end;

local u179 = {};
local u180 = {};
local u181 = {};

local function processSprings(p182: any, p183: number) -- Line: 701
    -- upvalues: u171 (copy), u181 (copy)
    for i, v in p182 do
        local v184 = i;
        local v185 = v;

        for i2, v2 in v do
            if v2:canSleep() then
                v185[i2] = nil;
                local rawGoal = v2.rawGoal;
                local v186 = u171[i2];

                if v186 and v184:IsA(v186.class) then
                    v186.set(v184, rawGoal);
                else
                    v184[i2] = rawGoal;
                end;
            else
                local v187 = v2:step(p183);
                local v188 = u171[i2];

                if v188 and v184:IsA(v188.class) then
                    v188.set(v184, v187);
                else
                    v184[i2] = v187;
                end;
            end;
        end;

        if not next(v185) then
            p182[v184] = nil;
            local v189 = u181[v184];

            if v189 then
                u181[v184] = nil;

                for _, v2 in v189 do
                    task.spawn(v2);
                end;
            end;
        end;
    end;
end;

RunService.PreSimulation:Connect(function(p190) -- Line: 730
    -- upvalues: processSprings (copy), u179 (copy)
    processSprings(u179, p190);
end);
RunService.PostSimulation:Connect(function(p191) -- Line: 734
    -- upvalues: processSprings (copy), u180 (copy)
    processSprings(u180, p191);
end);

local function assertType(p192: number, p193: string, p194: string, p195: any) -- Line: 738
    if not p194:find((typeof(p195))) then
        error(`bad argument #{p192} to {p193} ({p194} expected, got {typeof(p195)})`, 3);
    end;
end;

return table.freeze({
    target = function(p196: userdata, p197: number, p198: number, p199: table) -- Line: 747, Name: target
        -- upvalues: u180 (copy), u179 (copy), u171 (copy), u164 (copy)
        if not ("Instance"):find((typeof(p196))) then
            error(`bad argument #{1} to spr.target (Instance expected, got {typeof(p196)})`, 3);
        end;

        if not ("number"):find((typeof(p197))) then
            error(`bad argument #{2} to spr.target (number expected, got {typeof(p197)})`, 3);
        end;

        if not ("number"):find((typeof(p198))) then
            error(`bad argument #{3} to spr.target (number expected, got {typeof(p198)})`, 3);
        end;

        if not ("table"):find((typeof(p199))) then
            error(`bad argument #{4} to spr.target (table expected, got {typeof(p199)})`, 3);
        end;

        if p197 ~= p197 or p197 < 0 then
            error(("expected damping ratio >= 0; got %.2f"):format(p197), 2);
        end;

        if p198 ~= p198 or p198 < 0 then
            error(("expected undamped frequency >= 0; got %.2f"):format(p198), 2);
        end;

        local v200;

        if p196:IsA("Camera") then
            v200 = u180;
        else
            v200 = u179;
        end;

        local v201 = v200[p196];

        if not v201 then
            v201 = {};
            v200[p196] = v201;
        end;

        for i, v in p199 do
            local v202 = u171[i];
            local v203;

            if v202 and p196:IsA(v202.class) then
                v203 = v202.get(p196);
            else
                v203 = p196[i];
            end;

            if typeof(v) ~= typeof(v203) then
                error(`bad property {i} to spr.target ({typeof(v203)} expected, got {typeof(v)})`, 2);
            end;

            if p198 == (1 / 0) then
                local v204 = u171[i];

                if v204 and p196:IsA(v204.class) then
                    v204.set(p196, v);
                else
                    p196[i] = v;
                end;

                v201[i] = nil;
            else
                local v205 = v201[i];

                if not v205 then
                    local v206 = u164[typeof(v)];

                    if not v206 then
                        error("unsupported type: " .. typeof(v), 2);
                    end;

                    v205 = v206.springType(p197, p198, v203, v, v206);
                    v201[i] = v205;
                end;

                v205:setGoal(v);
                v205:setDampingRatio(p197);
                v205:setFrequency(p198);
            end;
        end;

        if not next(v201) then
            v200[p196] = nil;
        end;
    end,

    stop = function(p207: userdata, p208: string?) -- Line: 808, Name: stop
        -- upvalues: u179 (copy), u180 (copy)
        if not ("Instance"):find((typeof(p207))) then
            error(`bad argument #{1} to spr.stop (Instance expected, got {typeof(p207)})`, 3);
        end;

        if not ("string|nil"):find((typeof(p208))) then
            error(`bad argument #{2} to spr.stop (string|nil expected, got {typeof(p208)})`, 3);
        end;

        if p208 then
            local v209 = u179[p207] or u180[p207];

            if v209 then
                v209[p208] = nil;
            end;
        else
            u179[p207] = nil;
            u180[p207] = nil;
        end;
    end,

    completed = function(p210: userdata, p211: function) -- Line: 825, Name: completed
        -- upvalues: u181 (copy)
        if not ("Instance"):find((typeof(p210))) then
            error(`bad argument #{1} to spr.completed (Instance expected, got {typeof(p210)})`, 3);
        end;

        if not ("function"):find((typeof(p211))) then
            error(`bad argument #{2} to spr.completed (function expected, got {typeof(p211)})`, 3);
        end;

        local v212 = u181[p210];

        if v212 then
            table.insert(v212, p211);

            return;
        end;

        u181[p210] = { p211 };
    end
});