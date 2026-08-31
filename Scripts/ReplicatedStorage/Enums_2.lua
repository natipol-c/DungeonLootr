--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Enums
  Path:     game.ReplicatedStorage.Globals.Modules.Enums
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local script_CustomEnumClass = require(script.CustomEnumClass);
local v1 = setmetatable({}, script_CustomEnumClass.CustomEnums);
v1.SignalType = setmetatable({}, script_CustomEnumClass.CustomEnum);
v1.SignalType.Default = script_CustomEnumClass.CustomEnumItem.Extend("Default", 0, v1.SignalType, "SignalType");
v1.SignalType.Property = script_CustomEnumClass.CustomEnumItem.Extend("Property", 1, v1.SignalType, "SignalType");
v1.SignalType.Attribute = script_CustomEnumClass.CustomEnumItem.Extend("Attribute", 2, v1.SignalType, "SignalType");
v1.FilterMode = setmetatable({}, script_CustomEnumClass.CustomEnum);
v1.FilterMode.Entities = script_CustomEnumClass.CustomEnumItem.Extend("AllEntities", 0, v1.FilterMode, "FilterMode");
v1.FilterMode.Players = script_CustomEnumClass.CustomEnumItem.Extend("AllPlayers", 1, v1.FilterMode, "FilterMode");
v1.FilterMode.NPCs = script_CustomEnumClass.CustomEnumItem.Extend("AllNPCs", 2, v1.FilterMode, "FilterMode");
v1.FilterMode.Enemies = script_CustomEnumClass.CustomEnumItem.Extend("AllEnemies", 3, v1.FilterMode, "FilterMode");
v1.MovementStateType = setmetatable({}, script_CustomEnumClass.CustomEnum);
v1.MovementStateType.Walk = script_CustomEnumClass.CustomEnumItem.Extend("Walk", 0, v1.MovementStateType, "MovementStateType");
v1.MovementStateType.Sprint = script_CustomEnumClass.CustomEnumItem.Extend("Sprint", 1, v1.MovementStateType, "MovementStateType");
v1.MovementStateType.Jump = script_CustomEnumClass.CustomEnumItem.Extend("Jump", 2, v1.MovementStateType, "MovementStateType");
v1.MovementStateType.Fall = script_CustomEnumClass.CustomEnumItem.Extend("Fall", 3, v1.MovementStateType, "MovementStateType");
v1.MovementStateType.Land = script_CustomEnumClass.CustomEnumItem.Extend("Land", 4, v1.MovementStateType, "MovementStateType");
v1.MovementStateType.Dodge = script_CustomEnumClass.CustomEnumItem.Extend("Dodge", 5, v1.MovementStateType, "MovementStateType");
v1.MovementStateType.Swim = script_CustomEnumClass.CustomEnumItem.Extend("Swim", 6, v1.MovementStateType, "MovementStateType");
v1.CameraState = setmetatable({}, script_CustomEnumClass.CustomEnum);
v1.CameraState.FreeLook = script_CustomEnumClass.CustomEnumItem.Extend("FreeLook", 0, v1.CameraState, "CameraState");
v1.CameraState.ShiftLock = script_CustomEnumClass.CustomEnumItem.Extend("ShiftLock", 1, v1.CameraState, "CameraState");

return v1;