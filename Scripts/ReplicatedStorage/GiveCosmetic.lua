--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiveCosmetic
  Path:     game.ReplicatedStorage.CmdrClient.Commands.GiveCosmetic
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "giveCosmetic",
    Description = "Grant a player a cosmetic set",
    Group = "Admin",
    Aliases = { "gc" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to receive the cosmetic set"
        }, {
            Type = "cosmeticSetId",
            Name = "SetId",
            Description = "Cosmetic set name (autocomplete enabled)"
        } }
};