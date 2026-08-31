--[[
  Type:     ModuleScript
  Method:   cached
  Name:     Color3
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Color3
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

local Util = require(script.Parent.Parent.Shared.Util);
local u3 = Util.MakeSequenceType({
    Prefixes = "# hexColor3 ! brickColor3",
    Length = 3,

    ValidateEach = function(p1, p2) -- Line: 5, Name: ValidateEach
        if p1 == nil then
            return false, ("Invalid or missing number at position %d in Color3 type."):format(p2);
        end;

        if p1 < 0 or p1 > 255 then
            return false, ("Number out of acceptable range 0-255 at position %d in Color3 type."):format(p2);
        end;

        if p1 % 1 == 0 then
            return true;
        end;

        return false, ("Number is not an integer at position %d in Color3 type."):format(p2);
    end,

    TransformEach = tonumber,
    Constructor = Color3.fromRGB
});

local function parseHexDigit(p4) -- Line: 21
    if #p4 == 1 then
        p4 = p4 .. p4;
    end;

    return tonumber(p4, 16);
end;

local u13 = {
    Transform = function(p5) -- Line: 30, Name: Transform
        -- upvalues: Util (copy), parseHexDigit (copy)
        local v6, v7, v8 = p5:match("^#?(%x%x?)(%x%x?)(%x%x?)$");

        return Util.Each(parseHexDigit, v6, v7, v8);
    end,

    Validate = function(p9, p10, p11) -- Line: 35, Name: Validate
        local v12;

        if p9 == nil or p10 == nil then
            v12 = false;
        else
            v12 = p11 ~= nil;
        end;

        return v12, "Invalid hex color";
    end,

    Parse = function(...) -- Line: 39, Name: Parse
        return Color3.fromRGB(...);
    end
};

return function(p14) -- Line: 44
    -- upvalues: u3 (copy), Util (copy), u13 (copy)
    p14:RegisterType("color3", u3);
    p14:RegisterType("color3s", Util.MakeListableType(u3, {
        Prefixes = "# hexColor3s ! brickColor3s"
    }));
    p14:RegisterType("hexColor3", u13);
    p14:RegisterType("hexColor3s", Util.MakeListableType(u13));
end;