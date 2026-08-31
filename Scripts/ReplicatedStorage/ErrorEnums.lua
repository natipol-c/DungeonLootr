--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ErrorEnums
  Path:     game.ReplicatedStorage.Globals.Modules.ErrorEnums
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local script_ErrorEnumClass = require(script.ErrorEnumClass);
local v1 = setmetatable({}, script_ErrorEnumClass.CustomEnums);
v1.PlayerRelated = setmetatable({}, script_ErrorEnumClass.CustomEnum);
v1.PlayerRelated.MissingCharacter = setmetatable({
    Name = "MissingCharacter",
    Value = 0,
    Class = "PlayerRelated",
    EnumType = v1.PlayerRelated,

    Call = function(p2: userdata) -- Line: 9, Name: Call
        return `Character Not Found For Player: {p2}.`;
    end
}, script_ErrorEnumClass.CustomEnumItem);
v1.Connections = setmetatable({}, script_ErrorEnumClass.CustomEnum);
v1.Connections.NotFound = setmetatable({
    Name = "NotFound",
    Value = 0,
    Class = "Connections",
    EnumType = v1.Connections,

    Call = function(p3: string, p4: string) -- Line: 14, Name: Call
        return `Connection: {p3} Not Found In The ConnectionManager: {p4}.`;
    end
}, script_ErrorEnumClass.CustomEnumItem);
v1.Connections.AlreadyExists = setmetatable({
    Name = "AlreadyExists",
    Value = 1,
    Class = "Connections",
    EnumType = v1.Connections,

    Call = function(p5: string, p6: string) -- Line: 15, Name: Call
        return `Connection: {p5} Already Exists In The ConnectionManager: {p6}.`;
    end
}, script_ErrorEnumClass.CustomEnumItem);
v1.DirectionError = setmetatable({}, script_ErrorEnumClass.CustomEnum);
v1.DirectionError.TypeMismatch = setmetatable({
    Name = "TypeMismatch",
    Value = 0,
    Class = "DirectionError",
    EnumType = v1.DirectionError,

    Call = function(p7: string, p8: string) -- Line: 20, Name: Call
        return `Type Mismatch Occured. Expected: {p8}, Got: {p7}`;
    end
}, script_ErrorEnumClass.CustomEnumItem);

return v1;