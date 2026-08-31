--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TypeRegistry
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.TypeRegistry
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    CONFIG_NAME = "PartIcleProperties",
    Types = require(script.TypeData).Types
};

function u1.getTypeFor(p2) -- Line: 41
    -- upvalues: u1 (copy)
    for i, v in pairs(u1.Types) do
        if v.classCheck(p2) then
            return v, i;
        end;
    end;

    return nil, nil;
end;

function u1.getTypeName(p3) -- Line: 51
    -- upvalues: u1 (copy)
    local _, v4 = u1.getTypeFor(p3);

    return v4;
end;

function u1.getConfig(p5) -- Line: 57
    -- upvalues: u1 (copy)
    return p5:FindFirstChild(u1.CONFIG_NAME);
end;

function u1.getAttrName(p6, p7) -- Line: 63
    local v8 = p6.properties[p7];

    if v8 and v8.attrName then
        return v8.attrName;
    end;

    return p7;
end;

function u1.read(u9, u10) -- Line: 73
    -- upvalues: u1 (copy)
    local TypeFor = u1.getTypeFor(u9);

    if not TypeFor then
        return nil;
    end;

    local v11 = TypeFor.properties[u10];

    if not v11 then
        return nil;
    end;

    if TypeFor.directAccess then
        if v11.attribute then
            local Attribute = u9:GetAttribute(v11.attrName or u10);

            if Attribute == nil or not Attribute then
                Attribute = v11.default;
            end;

            return Attribute;
        end;

        local success, result = pcall(function() -- Line: 86
            -- upvalues: u9 (copy), u10 (copy)
            return u9[u10];
        end);

        if success and result ~= nil then
            return result;
        end;

        return v11.default;
    end;

    local Config = u1.getConfig(u9);

    if not Config then
        return nil;
    end;

    local Attribute = Config:GetAttribute((u1.getAttrName(TypeFor, u10)));

    if Attribute == nil then
        return v11.default;
    end;

    if v11.type == "enum" and type(Attribute) == "string" then
        return Enum[v11.enumType][Attribute];
    end;

    return Attribute;
end;

function u1.write(u12, u13, u14) -- Line: 108
    -- upvalues: u1 (copy)
    local TypeFor = u1.getTypeFor(u12);

    if not TypeFor then
        return;
    end;

    local v15 = TypeFor.properties[u13];

    if not v15 then
        return;
    end;

    if TypeFor.directAccess then
        if v15.attribute then
            u12:SetAttribute(v15.attrName or u13, u14);

            return;
        end;

        pcall(function() -- Line: 120
            -- upvalues: u12 (copy), u13 (copy), u14 (copy)
            u12[u13] = u14;
        end);

        return;
    end;

    local Config = u1.getConfig(u12);

    if not Config then
        return;
    end;

    local AttrName = u1.getAttrName(TypeFor, u13);

    if v15.type ~= "enum" then
        Config:SetAttribute(AttrName, u14);

        return;
    end;

    if typeof(u14) == "EnumItem" then
        Config:SetAttribute(AttrName, u14.Name);

        return;
    end;

    Config:SetAttribute(AttrName, (tostring(u14)));
end;

function u1.readAll(p16) -- Line: 143
    -- upvalues: u1 (copy)
    local TypeFor = u1.getTypeFor(p16);

    if not TypeFor then
        return nil;
    end;

    local Config = u1.getConfig(p16);

    if not Config then
        return nil;
    end;

    local v17 = {};

    for i, v in pairs(TypeFor.properties) do
        local Attribute = Config:GetAttribute((u1.getAttrName(TypeFor, i)));

        if Attribute == nil then
            v17[i] = v.default;
        elseif v.type == "enum" and type(Attribute) == "string" then
            v17[i] = Enum[v.enumType][Attribute];
        else
            v17[i] = Attribute;
        end;
    end;

    return v17;
end;

function u1.writeDefaults(p18, p19) -- Line: 166
    for i, v in pairs(p19.properties) do
        local v20 = v.attrName or i;
        local default = v.default;

        if v.type == "enum" then
            p18:SetAttribute(v20, default.Name);
        else
            p18:SetAttribute(v20, default);
        end;
    end;
end;

function u1.createConfig(p21, p22) -- Line: 179
    -- upvalues: u1 (copy)
    local Configuration = Instance.new("Configuration");
    Configuration.Name = u1.CONFIG_NAME;
    u1.writeDefaults(Configuration, p22);
    Configuration.Parent = p21;

    return Configuration;
end;

function u1.isGraph(p23) -- Line: 188
    return p23.type == "NumberSequence" and true or p23.type == "ColorSequence";
end;

function u1.isNonNegative(p24) -- Line: 193
    return p24.nonNegative == true;
end;

function u1.getPropDef(p25, p26) -- Line: 198
    -- upvalues: u1 (copy)
    local v27 = u1.Types[p25];

    if v27 then
        return v27.properties[p26];
    end;

    return nil;
end;

function u1.getDefault(p28) -- Line: 206
    -- upvalues: u1 (copy)
    for _, v in pairs(u1.Types) do
        local v29 = v.properties[p28];

        if v29 then
            return v29.default;
        end;
    end;

    return nil;
end;

return u1;