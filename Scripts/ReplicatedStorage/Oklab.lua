--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Oklab
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.mod.color.Oklab
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../color/sRGB");
local u6 = {
    fromLinear = function(p2) -- Line: 42, Name: fromLinear
        local v3 = (p2.R * 0.4122214708 + p2.G * 0.5363325363 + p2.B * 0.0514459929) ^ 0.3333333333333333;
        local v4 = (p2.R * 0.2119034982 + p2.G * 0.6806995451 + p2.B * 0.1073969566) ^ 0.3333333333333333;
        local v5 = (p2.R * 0.0883024619 + p2.G * 0.2817188376 + p2.B * 0.6299787005) ^ 0.3333333333333333;

        return Vector3.new(v3 * 0.2104542553 + v4 * 0.793617785 - v5 * 0.0040720468, v3 * 1.9779984951 - v4 * 2.428592205 + v5 * 0.4505937099, v3 * 0.0259040371 + v4 * 0.7827717662 - v5 * 0.808675766);
    end
};

function u6.fromSRGB(p7) -- Line: 59
    -- upvalues: u6 (copy), u1 (copy)
    return u6.fromLinear(u1.toLinear(p7));
end;

function u6.toLinear(p8: vector, p9: boolean?) -- Line: 65
    local v10 = (p8.X + p8.Y * 0.3963377774 + p8.Z * 0.2158037573) ^ 3;
    local v11 = (p8.X - p8.Y * 0.1055613458 - p8.Z * 0.0638541728) ^ 3;
    local v12 = (p8.X - p8.Y * 0.0894841775 - p8.Z * 1.291485548) ^ 3;
    local v13 = v10 * 4.0767416621 - v11 * 3.3077115913 + v12 * 0.2309699292;
    local v14 = v10 * -1.2684380046 + v11 * 2.6097574011 - v12 * 0.3413193965;
    local v15 = v10 * -0.0041960863 - v11 * 0.7034186147 + v12 * 1.707614701;

    if not p9 then
        v13 = math.clamp(v13, 0, 1);
        v14 = math.clamp(v14, 0, 1);
        v15 = math.clamp(v15, 0, 1);
    end;

    return Color3.new(v13, v14, v15);
end;

function u6.toSRGB(p16: vector, p17: boolean?) -- Line: 89
    -- upvalues: u1 (copy), u6 (copy)
    return u1.fromLinear(u6.toLinear(p16, p17));
end;

return u6;