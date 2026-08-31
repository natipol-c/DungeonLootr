--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     M1_ForgeVFX
  Path:     game.ReplicatedStorage.Classes.Unrestricted.Skill_Modules.M1_ForgeVFX
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:51 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).group(script, {
    groupPath = "M1S",
    follow = true,
    modeRoot = {
        attribute = "M1Mode",
        default = "Sword"
    }
});