--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     sRGB
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.mod.color.sRGB
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = {};

local function transform(p2: number) -- Line: 42
    if p2 < 0.04045 then
        return p2 / 12.92;
    end;

    return ((p2 + 0.055) / 1.055) ^ 2.4;
end;

local function inverse(p3: number) -- Line: 52
    if p3 < 0.0031308 then
        return p3 * 12.92;
    end;

    return p3 ^ 0.4166666666666667 * 1.055 - 0.055;
end;

function v1.fromLinear(p4) -- Line: 61
    local R = p4.R;
    local v5;

    if R < 0.0031308 then
        v5 = R * 12.92;
    else
        v5 = R ^ 0.4166666666666667 * 1.055 - 0.055;
    end;

    local G = p4.G;
    local v6;

    if G < 0.0031308 then
        v6 = G * 12.92;
    else
        v6 = G ^ 0.4166666666666667 * 1.055 - 0.055;
    end;

    local B = p4.B;
    local v7;

    if B < 0.0031308 then
        v7 = B * 12.92;
    else
        v7 = B ^ 0.4166666666666667 * 1.055 - 0.055;
    end;

    return Color3.new(v5, v6, v7);
end;

function v1.toLinear(p8) -- Line: 67
    local R = p8.R;
    local v9;

    if R < 0.04045 then
        v9 = R / 12.92;
    else
        v9 = ((R + 0.055) / 1.055) ^ 2.4;
    end;

    local G = p8.G;
    local v10;

    if G < 0.04045 then
        v10 = G / 12.92;
    else
        v10 = ((G + 0.055) / 1.055) ^ 2.4;
    end;

    local B = p8.B;
    local v11;

    if B < 0.04045 then
        v11 = B / 12.92;
    else
        v11 = ((B + 0.055) / 1.055) ^ 2.4;
    end;

    return Color3.new(v9, v10, v11);
end;

return v1;