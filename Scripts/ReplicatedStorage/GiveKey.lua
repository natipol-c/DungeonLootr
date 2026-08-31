--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiveKey
  Path:     game.ReplicatedStorage.CmdrClient.Commands.GiveKey
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "GiveKey",
    Description = "Grant dungeon keys to a player. Tier: 1-5 or Master.",
    Group = "Admin",
    Aliases = { "gk" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to receive the key(s)"
        }, {
            Type = "string",
            Name = "Tier",
            Description = "Key tier: 1, 2, 3, 4, 5, or Master"
        }, {
            Type = "number",
            Name = "Amount",
            Description = "How many keys to grant (default 1)"
        } }
};