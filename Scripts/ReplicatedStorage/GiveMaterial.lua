--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiveMaterial
  Path:     game.ReplicatedStorage.CmdrClient.Commands.GiveMaterial
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "giveMaterial",
    Description = "Give a player crafting materials by name and amount",
    Group = "Admin",
    Aliases = { "gm" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to receive the materials"
        }, {
            Type = "materialId",
            Name = "MaterialId",
            Description = "Material name (autocomplete enabled — dungeon materials + Forge/Reforge stones)"
        }, {
            Type = "integer",
            Name = "Amount",
            Description = "How many to give",
            Default = 1
        } }
};