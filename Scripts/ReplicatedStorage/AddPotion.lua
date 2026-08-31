--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AddPotion
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AddPotion
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AddPotion",
    Description = "Add health potions to a player",
    Group = "Admin",
    Aliases = { "ap" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player who\'ll receive the potions"
        }, {
            Type = "string",
            Name = "PotionId",
            Description = "Potion ID (e.g. SmallHealFlat, WarriorsElixir)"
        }, {
            Type = "number",
            Name = "Amount",
            Description = "Amount to give",
            Default = 1
        } }
};