--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DropLoot
  Path:     game.ReplicatedStorage.CmdrClient.Commands.DropLoot
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "dropLoot",
    Description = "Spawn an unidentified equipment drop at a player\'s position",
    Group = "Admin",
    Aliases = { "dl" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to receive the drop"
        }, {
            Type = "dungeonLocationId",
            Name = "Dungeon",
            Description = "Dungeon to pull equipment templates from (autocomplete enabled)",
            Default = "Forest Challenge"
        }, {
            Type = "string",
            Name = "Difficulty",
            Description = "Easy / Normal / Hard / Nightmare / Endless — drives level bracket",
            Default = "Normal"
        }, {
            Type = "string",
            Name = "Rarity",
            Description = "Rarity override (Common/Uncommon/Rare/Epic/Legendary/Mythic) — blank = natural roll",
            Default = ""
        } }
};